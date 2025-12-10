import wave
import struct
import sys
import math

###############################################################
# Parameters identical to original system
###############################################################
highfreq = 2600.0
lowfreq  = highfreq / 2.0
samplingRate = 44100.0

###############################################################
# Parity and SCELBI byte encoding
###############################################################
def even_parity(x):
    return (bin(x).count("1") % 2) == 0

def add_parity(byte7):
    """
    Insert even parity bit as MSB.
    byte7 = 7-bit payload (header bits + nibble)
    """
    P = 0 if even_parity(byte7) else 1
    return (P << 7) | byte7


# -----------------------------
# Address and Data Encoders
# -----------------------------
def encode_high_address(addr):
    hi = (addr >> 4) & 0x0F
    lo = addr & 0x0F

    b1 = add_parity(0b1000000 | hi)   # P100AAAA
    b2 = add_parity(0b0000000 | lo)   # P000AAAA
    return [b1, b2]


def encode_low_address(addr):
    hi = (addr >> 4) & 0x0F
    lo = addr & 0x0F

    b1 = add_parity(0b0100000 | hi)   # P010AAAA
    b2 = add_parity(0b0000000 | lo)   # P000AAAA
    return [b1, b2]


def encode_data_byte(value):
    hi = (value >> 4) & 0x0F
    lo = value & 0x0F

    b1 = add_parity(0b0000000 | hi)   # P000DDDD
    b2 = add_parity(0b0000000 | lo)   # P000DDDD
    return [b1, b2]


def encode_last_data_byte(value):
    hi = (value >> 4) & 0x0F
    lo = value & 0x0F

    b1 = add_parity(0b0010000 | hi)   # P001DDDD   <--- LAST byte indicator
    b2 = add_parity(0b0000000 | lo)   # P000DDDD
    return [b1, b2]


###############################################################
# SCELBI Byte → Bitstream
#   SCELBI expects a START BIT = 1 before each byte.
###############################################################
def byte_to_bitstream(byte):
    bits = [1]  # Start bit
    for n in range(7, -1, -1):
        bits.append((byte >> n) & 1)
    return bits

###############################################################
# Bitstream → Waveform (square-wave FSK)
###############################################################
def bitstream_to_wave(bits):
    samples = []
    amplitude = 0.4

    for b in bits:
        if b == 1:
            freq = highfreq
        else:
            freq = lowfreq

        # Each bit takes one slow cycle
        N = int(samplingRate / (lowfreq))

        for i in range(N):
            val = -amplitude

            if b == 1:
                # two positive lobes per cycle
                if i >= N/8 and i < 3*N/8:
                    val = amplitude
                if i >= 5*N/8 and i < 7*N/8:
                    val = amplitude
            else:
                # one positive lobe per cycle
                if i >= N/4 and i < 3*N/4:
                    val = amplitude

            samples.append(val)

    return samples


###############################################################
# Write WAV file
###############################################################
def write_wav(filename, samples):
    with wave.open(filename, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(int(samplingRate))

        frames = bytearray()
        total = len(samples)

        for i, s in enumerate(samples, start=1):
            s = max(-1.0, min(1.0, s))
            frames.extend(struct.pack("<h", int(s * 32767)))

            if i % 5000 == 0 or i == total:
                percent = 100 * i / total
                print(f"Progress: {i}/{total} ({percent:.1f}%)")

        w.writeframes(frames)


###############################################################
# Intel HEX Reader
###############################################################
def read_ihex(filename):
    mem = {}

    with open(filename, "r") as f:
        for line in f:
            if not line.startswith(":"):
                continue

            count = int(line[1:3], 16)
            addr  = int(line[3:7], 16)
            rtype = int(line[7:9], 16)
            data  = line[9:9+count*2]

            if rtype == 0x00:
                for i in range(count):
                    mem[addr + i] = int(data[i*2:i*2+2], 16)
            elif rtype == 0x01:
                break

    return mem


###############################################################
# MAIN
###############################################################
def main():
    if len(sys.argv) != 3:
        print("Usage: python FSK_Encoder.py input.hex output.wav")
        sys.exit(1)

    hexfile = sys.argv[1]
    wavfile = sys.argv[2]

    print(f"Reading Intel HEX: {hexfile}")
    mem = read_ihex(hexfile)

    if not mem:
        print("No data found!")
        sys.exit(1)

    addrs = sorted(mem.keys())
    final_addr = addrs[-1]

    print(f"Loaded {len(addrs)} bytes from HEX")

    encoded_bytes = []
    last_addr = None

    # Build SCELBI-format byte stream
    for addr in addrs:
        value = mem[addr]

        # New block? Send address
        if last_addr is None or addr != last_addr + 1:
            AH = (addr >> 8) & 0xFF
            AL = addr & 0xFF

            encoded_bytes += encode_high_address(AH)
            encoded_bytes += encode_low_address(AL)

        # Last byte?
        if addr == final_addr:
            encoded_bytes += encode_last_data_byte(value)
        else:
            encoded_bytes += encode_data_byte(value)

        last_addr = addr

    print(f"Total SCELBI packets: {len(encoded_bytes)}")

    # Expand to bitstream using SCELBI start-bit format
    bitstream = []
    
    #Create 3s header
    header_length = int(3 * lowfreq)
    for b in range(header_length):
        bitstream.append(0)
    
    #Add data to bitstream
    for b in encoded_bytes:
        bitstream.extend(byte_to_bitstream(b))
        #Add 1 byte of spacing
        for i in range(8): bitstream.append(0)

    #Create 1s tail
    header_length = int(1 * lowfreq)
    for b in range(header_length):
        bitstream.append(0)

    print(f"Total bits: {len(bitstream)}")

    samples   = bitstream_to_wave(bitstream)

    print(f"Total samples: {len(samples)}")
    write_wav(wavfile, samples)

    print(f"Done. Wrote: {wavfile}")


if __name__ == "__main__":
    main()
