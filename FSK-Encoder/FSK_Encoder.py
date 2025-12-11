import wave
import struct
import sys
import math

###############################################################
# Parameters identical to original system
###############################################################
highfreq = 2585.0
lowfreq  = highfreq / 2.0
samplingRate = 44100.0

# -----------------------------
# SCELBI nibble helper
# -----------------------------
def nibble_to_tapebyte(nibble):
    """
    Convert a 4-bit nibble into the SCELBI tape byte form:
      dddd 0001
    where dddd is the nibble (upper 4 bits) and lower 4 bits are 0001.
    """
    return ((nibble & 0x0F) << 4) | 0x08


def nibbles_to_tapebyte(nibble1,nibble2):
    """
    Convert a 4-bit nibble into the SCELBI tape byte form:
      dddd 0001
    where dddd is the nibble (upper 4 bits) and lower 4 bits are 0001.
    """
    return ((nibble1 & 0x0F) << 4) | nibble2

def rearrange_bits(byte):
    """
    Rearrange an 8-bit byte so that the output bits are:
    4 5 6 7 0 1 2 3  (from the original bit positions)
    """
    byte &= 0xFF  # ensure it's 8-bit

    # Extract and shift bits into new positions:
    return (
        ((byte >> 4) & 1) << 7 |  # input bit 4 -> output bit 7
        ((byte >> 5) & 1) << 6 |  # input bit 5 -> output bit 6
        ((byte >> 6) & 1) << 5 |  # input bit 6 -> output bit 5
        ((byte >> 7) & 1) << 4 |  # input bit 7 -> output bit 4
        ((byte >> 0) & 1) << 3 |  # input bit 0 -> output bit 3
        ((byte >> 1) & 1) << 2 |  # input bit 1 -> output bit 2
        ((byte >> 2) & 1) << 1 |  # input bit 2 -> output bit 1
        ((byte >> 3) & 1) << 0    # input bit 3 -> output bit 0
    )

def scelbi_checksum(byte_array):
    """
    Compute the SCELBI-style checksum:
    - Sum all bytes (0–255)
    - Take the low 8 bits of the sum
    - Return the two's complement of that value (also 0–255)
    """
    filtered_bytes = []
    counter = 0
    #filter out delays
    for byte in byte_array:
        if counter % 2 == 0:
            new_byte = rearrange_bits(byte)
            print("Including byte: " +  "{:08b}".format(new_byte))
            filtered_bytes += [new_byte]
        counter = counter + 1
        
    total = sum(filtered_bytes) & 0xFF         # keep to 8 bits
    checksum = (-total) & 0xFF             # two's complement
    print(f"Checksum: {checksum} - " + "{:08b}".format(checksum))
    return checksum

# -----------------------------
# Address and Data Encoders (documented SCELBI nibble format)
# -----------------------------
def encode_high_address(addr):
    """
    Emit: [CMD(8), HIGH_NIBBLE_of_AH, LOW_NIBBLE_of_AH]
    CMD = 8 (high-address command)
    AH = high byte of 16-bit address (addr >> 8)
    Each nibble is converted to tape byte (dddd0001).
    """
    AH = (addr >> 8) & 0xFF
    hi = (AH >> 4) & 0x0F
    lo = AH & 0x0F

    #cmd = nibble_to_tapebyte(0x8)   # 8 = high-address command
    #b1 = nibble_to_tapebyte(hi)
    #b2 = nibble_to_tapebyte(lo)
    cmd = nibbles_to_tapebyte(0x1,0x1)
    loc = nibbles_to_tapebyte(hi,lo)
    #return [cmd, b1, b2]
    return [cmd,4,loc,0]


def encode_low_address(addr):
    """
    Emit: [CMD(4), HIGH_NIBBLE_of_AL, LOW_NIBBLE_of_AL]
    CMD = 4 (low-address command)
    AL = low byte of 16-bit address (addr & 0xFF)
    """
    AL = addr & 0xFF
    hi = (AL >> 4) & 0x0F
    lo = AL & 0x0F

    #cmd = nibble_to_tapebyte(0x4)   # 4 = low-address command
    #b1 = nibble_to_tapebyte(hi)
    #b2 = nibble_to_tapebyte(lo)
    cmd = nibbles_to_tapebyte(0x2,0x2)
    loc = nibbles_to_tapebyte(hi,lo)
    #return [cmd, b1, b2]
    return [cmd,5,loc,0]


def encode_data_byte(value):
    """
    Emit: [HI_NIBBLE, LO_NIBBLE, F, 0]
    where F = 0xF (increment dummy) and 0 = 0x0 (increment actual).
    All converted to tape bytes (dddd0001).
    """
    hi = (value >> 4) & 0x0F
    lo = value & 0x0F

    b1 = nibble_to_tapebyte(hi)
    b2 = nibble_to_tapebyte(lo)
    inc_f = nibble_to_tapebyte(0xF)
    inc_0 = nibble_to_tapebyte(0x0)
    #return [b1, b2, inc_f, inc_0]
    return [b1,7,b2,8]


# (We keep encode_last_data_byte removed — documented format doesn't require a special last marker.)

###############################################################
# SCELBI Byte → Bitstream
#   NOTE: you asked to keep the existing start-bit framing and parity behavior,
#   so this function remains unchanged (it will add a leading '1' start bit
#   before each produced 8-bit byte).
###############################################################
def byte_to_bitstream(byte):
    bits = [1]  # Start bit
    for n in range(7, -1, -1):
        bits.append((byte >> n) & 1)
    bits = [bits[0], bits[4], bits[3], bits[2], bits[1], bits[8], bits[7], bits[6], bits[5]]
    print(bits)
    return bits

###############################################################
# Bitstream → Waveform (square-wave FSK)
#   (left intact; you asked to only change the data format)
###############################################################
def bitstream_to_wave(bits):
    samples = []
    amplitude = 0.3

    for b in bits:
        if b == 1:
            freq = highfreq
        else:
            freq = lowfreq

        # Each bit takes one slow cycle
        N = 2 * int(samplingRate / (lowfreq))

        for i in range(N):
            val = -amplitude

            if b == 1:
                # two positive lobes per cycle
                if i >= 1*N/16 and i < 3*N/16:
                    val = amplitude
                if i >= 5*N/16 and i < 7*N/16:
                    val = amplitude
                if i >= 9*N/16 and i < 11*N/16:
                    val = amplitude
                if i >= 13*N/16 and i < 15*N/16:
                    val = amplitude
            else:
                # one positive lobe per cycle
                if i >= 1*N/8 and i < 3*N/8:
                    val = amplitude
                if i >= 5*N/8 and i < 7*N/8:
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
        print("Usage: python FSK_Encoder_v2.py input.hex output.wav")
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

    # Start command
    encoded_bytes += [nibbles_to_tapebyte(0x0,0x8),2]
    
    # Build SCELBI-format byte stream
    for addr in addrs:
        value = mem[addr]

        # New block? Send address (high then low)
        if last_addr is None or addr != last_addr + 1:
            AH = (addr >> 8) & 0xFFFF
            AL = addr & 0xFFFF

            encoded_bytes += encode_high_address(addr)
            encoded_bytes += [nibbles_to_tapebyte(0x0,0x8),1]
            encoded_bytes += encode_low_address(addr)

        # Data byte (use documented form; include F0 increment pair)
        encoded_bytes += encode_data_byte(value)

        last_addr = addr

    

    encoded_bytes += [nibbles_to_tapebyte(0x5,0x8),0]
    checksum = scelbi_checksum(encoded_bytes)
    encoded_bytes += [nibbles_to_tapebyte(0x4,0xC),1]
    checksum = scelbi_checksum(encoded_bytes)
    encoded_bytes += [nibbles_to_tapebyte(0x0,0x1),0]
    checksum = scelbi_checksum(encoded_bytes)
    print(f"Total SCELBI bytes (nibbles & control bytes): {len(encoded_bytes)}")

    # Expand to bitstream using the existing byte-to-bitstream (start-bit = 1)
    bitstream = []

    # Create 3s header (keeps your previous header behavior)
    header_length = int(1.5 * lowfreq)
    for b in range(header_length):
        bitstream.append(0)

    # Add data to bitstream
    counter = 0
    for b in encoded_bytes:
        if counter%2 == 0:
            #Add byte
            bitstream.extend(byte_to_bitstream(b))
        else:
            # Add prescribed delay
            for i in range(b):
                bitstream.append(0)
        counter = counter + 1

    # Create 1s tail
    tail_length = int(0.5 * lowfreq)
    for b in range(tail_length):
        bitstream.append(0)

    print(f"Total bits: {len(bitstream)}")

    samples = bitstream_to_wave(bitstream)

    print(f"Total samples: {len(samples)}")
    write_wav(wavfile, samples)

    print(f"Done. Wrote: {wavfile}")


if __name__ == "__main__":
    main()
