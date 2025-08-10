EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L SamacSys_Parts:MAX202CPE+ Z1
U 1 1 606F5208
P 5700 1900
F 0 "Z1" H 6300 2165 50  0000 C CNN
F 1 "MAX202CPE+" H 6300 2074 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 6750 2000 50  0001 L CNN
F 3 "http://datasheets.maximintegrated.com/en/ds/MAX200-MAX213.pdf" H 6750 1900 50  0001 L CNN
F 4 "MAX202CPE+, Line Transceiver, EIA/TIA-232-E, RS-232, V.28 2-TX 2-RX 2-TRX, 5 V, 16-Pin PDIP" H 6750 1800 50  0001 L CNN "Description"
F 5 "4.572" H 6750 1700 50  0001 L CNN "Height"
F 6 "700-MAX202CPE" H 6750 1600 50  0001 L CNN "Mouser Part Number"
F 7 "https://www.mouser.co.uk/ProductDetail/Maxim-Integrated/MAX202CPE%2b/?qs=1THa7WoU59H03WmQ%2FB%2FQ6w%3D%3D" H 6750 1500 50  0001 L CNN "Mouser Price/Stock"
F 8 "Maxim Integrated" H 6750 1400 50  0001 L CNN "Manufacturer_Name"
F 9 "MAX202CPE+" H 6750 1300 50  0001 L CNN "Manufacturer_Part_Number"
	1    5700 1900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0101
U 1 1 606FBF47
P 4500 1400
F 0 "#PWR0101" H 4500 1250 50  0001 C CNN
F 1 "+5V" H 4515 1573 50  0000 C CNN
F 2 "" H 4500 1400 50  0001 C CNN
F 3 "" H 4500 1400 50  0001 C CNN
	1    4500 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 606FCD69
P 8050 4500
F 0 "#PWR0102" H 8050 4250 50  0001 C CNN
F 1 "GND" H 8055 4327 50  0000 C CNN
F 2 "" H 8050 4500 50  0001 C CNN
F 3 "" H 8050 4500 50  0001 C CNN
	1    8050 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 1000 8050 1100
Wire Wire Line
	6900 1900 7250 1900
Connection ~ 8000 1900
Wire Wire Line
	8000 1900 8000 2050
Wire Wire Line
	6900 3150 8000 3150
Connection ~ 8000 3150
Wire Wire Line
	8000 3150 8000 4500
Wire Wire Line
	6900 2000 7100 2000
Connection ~ 8050 2000
Wire Wire Line
	5700 3750 5700 3900
Wire Wire Line
	5700 3900 8050 3900
Connection ~ 8050 3900
Wire Wire Line
	8050 3900 8050 4500
Wire Wire Line
	6900 2500 7000 2500
$Comp
L Device:R_US R1
U 1 1 60707EE0
P 7700 2200
F 0 "R1" H 7768 2246 50  0000 L CNN
F 1 "10K" H 7768 2155 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 7740 2190 50  0001 C CNN
F 3 "~" H 7700 2200 50  0001 C CNN
	1    7700 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 2050 8000 2050
Connection ~ 8000 2050
$Comp
L Device:C C2
U 1 1 6070B74A
P 7250 2200
F 0 "C2" H 7365 2246 50  0000 L CNN
F 1 "0.1u" H 7365 2155 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D7.5mm_W4.4mm_P6.00mm" H 7288 2050 50  0001 C CNN
F 3 "~" H 7250 2200 50  0001 C CNN
	1    7250 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7250 2050 7250 1900
Connection ~ 7250 1900
Wire Wire Line
	7250 1900 8000 1900
Wire Wire Line
	7250 2350 7100 2350
Wire Wire Line
	7100 2350 7100 2000
Connection ~ 7100 2000
Wire Wire Line
	7100 2000 8050 2000
$Comp
L Device:C C3
U 1 1 6070EE64
P 4900 2000
F 0 "C3" H 5015 2046 50  0000 L CNN
F 1 "0.1u" H 5015 1955 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D7.5mm_W4.4mm_P6.00mm" H 4938 1850 50  0001 C CNN
F 3 "~" H 4900 2000 50  0001 C CNN
	1    4900 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 2050 8000 3150
$Comp
L Device:C C4
U 1 1 6071A0C3
P 5300 2000
F 0 "C4" H 5415 2046 50  0000 L CNN
F 1 "0.1u" H 5415 1955 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D7.5mm_W4.4mm_P6.00mm" H 5338 1850 50  0001 C CNN
F 3 "~" H 5300 2000 50  0001 C CNN
	1    5300 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 2150 4900 2250
Wire Wire Line
	4900 2250 5650 2250
Wire Wire Line
	5650 2250 5650 2000
Wire Wire Line
	5650 2000 5700 2000
Wire Wire Line
	5300 1850 5700 1850
Wire Wire Line
	5700 1850 5700 1900
Wire Wire Line
	5300 2150 5700 2150
Wire Wire Line
	5700 2150 5700 2100
$Comp
L Device:C C6
U 1 1 6071E825
P 5300 2450
F 0 "C6" H 5415 2496 50  0000 L CNN
F 1 "0.1u" H 5415 2405 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D7.5mm_W4.4mm_P6.00mm" H 5338 2300 50  0001 C CNN
F 3 "~" H 5300 2450 50  0001 C CNN
	1    5300 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 2300 5300 2200
Wire Wire Line
	5300 2200 5700 2200
$Comp
L Device:C C5
U 1 1 60722040
P 4900 2450
F 0 "C5" H 5015 2496 50  0000 L CNN
F 1 "0.1u" H 5015 2405 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D7.5mm_W4.4mm_P6.00mm" H 4938 2300 50  0001 C CNN
F 3 "~" H 4900 2450 50  0001 C CNN
	1    4900 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 2600 4900 3900
Wire Wire Line
	4900 3900 5700 3900
Connection ~ 5700 3900
Wire Wire Line
	4900 2300 5200 2300
Wire Wire Line
	5200 2300 5200 2650
Wire Wire Line
	5200 2650 5600 2650
Wire Wire Line
	5600 2650 5600 2400
Wire Wire Line
	5600 2400 5700 2400
Wire Wire Line
	5550 2600 5550 2300
Wire Wire Line
	5550 2300 5700 2300
Wire Wire Line
	5300 2600 5550 2600
Wire Wire Line
	3950 1750 3900 1750
Wire Wire Line
	3900 1750 3900 1500
Wire Wire Line
	3900 1500 4500 1500
Wire Wire Line
	4450 1750 4500 1750
Wire Wire Line
	4500 1750 4500 1500
Connection ~ 4500 1500
Wire Wire Line
	3950 1950 3900 1950
Wire Wire Line
	3900 1950 3900 3900
Wire Wire Line
	3900 3900 4500 3900
Connection ~ 4900 3900
Connection ~ 4500 3900
Wire Wire Line
	4500 3900 4900 3900
Wire Wire Line
	3850 3950 3850 3650
Wire Wire Line
	3850 3650 3950 3650
Wire Wire Line
	6900 2300 6950 2300
Wire Wire Line
	6950 2300 6950 1450
Wire Wire Line
	6950 1450 3850 1450
Wire Wire Line
	3850 1450 3850 3050
Wire Wire Line
	3850 3050 3950 3050
Wire Wire Line
	6900 2100 7050 2100
Wire Wire Line
	7050 2750 5000 2750
Wire Wire Line
	5000 4000 3800 4000
Wire Wire Line
	3800 4000 3800 2850
Wire Wire Line
	3800 2850 3950 2850
Wire Wire Line
	5700 2500 5650 2500
Wire Wire Line
	5650 2500 5650 4050
Wire Wire Line
	5650 4050 3750 4050
Wire Wire Line
	3750 4050 3750 2750
Wire Wire Line
	3750 2750 3950 2750
Wire Wire Line
	6900 2200 7000 2200
Wire Wire Line
	7000 2200 7000 2400
Wire Wire Line
	7100 2400 7100 4100
Wire Wire Line
	3700 4100 3700 2950
Wire Wire Line
	3700 2950 3950 2950
Wire Wire Line
	3700 4100 7100 4100
Wire Wire Line
	7050 2100 7050 2750
Wire Wire Line
	5000 2750 5000 4000
$Comp
L Device:Fuse F1
U 1 1 6075718D
P 7350 1350
F 0 "F1" H 7410 1396 50  0000 L CNN
F 1 "Fuse" H 7410 1305 50  0000 L CNN
F 2 "Fuse:Fuseholder_AG8" V 7280 1350 50  0001 C CNN
F 3 "~" H 7350 1350 50  0001 C CNN
	1    7350 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 1000 8000 1200
Connection ~ 8000 1200
Wire Wire Line
	8000 1200 8000 1250
$Comp
L Device:D_Zener VR1
U 1 1 6075E285
P 7700 1100
F 0 "VR1" H 7700 1317 50  0000 C CNN
F 1 "6.3V" H 7700 1226 50  0000 C CNN
F 2 "Diode_THT:D_T-1_P12.70mm_Horizontal" H 7700 1100 50  0001 C CNN
F 3 "~" H 7700 1100 50  0001 C CNN
	1    7700 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 1100 8050 1100
Connection ~ 8050 1100
Wire Wire Line
	8050 1100 8050 1550
Wire Wire Line
	7350 1100 7350 1200
$Comp
L Device:C C1
U 1 1 60768AFA
P 7700 1400
F 0 "C1" H 7815 1446 50  0000 L CNN
F 1 "10M" H 7815 1355 50  0000 L CNN
F 2 "Capacitor_THT:C_Axial_L12.0mm_D8.5mm_P20.00mm_Horizontal" H 7738 1250 50  0001 C CNN
F 3 "~" H 7700 1400 50  0001 C CNN
	1    7700 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7350 1100 7550 1100
Wire Wire Line
	7350 1200 8000 1200
Connection ~ 7350 1200
Wire Wire Line
	7700 1250 8000 1250
Connection ~ 8000 1250
Wire Wire Line
	8000 1250 8000 1600
Wire Wire Line
	7700 1550 8050 1550
Connection ~ 8050 1550
Wire Wire Line
	8050 1550 8050 2000
Wire Wire Line
	4500 1500 7350 1500
Wire Wire Line
	4900 1850 4900 1600
Wire Wire Line
	4900 1600 8000 1600
Connection ~ 8000 1600
Wire Wire Line
	8000 1600 8000 1900
Wire Wire Line
	4500 1500 4500 1400
Wire Wire Line
	4450 1850 4500 1850
$Comp
L EdgeConnector:Edge44 J1
U 1 1 606DA8AD
P 4200 1600
F 0 "J1" H 4200 1675 50  0000 C CNN
F 1 "Edge44" H 4200 1584 50  0000 C CNN
F 2 "Connector_PCBEdge:Edge44" H 4200 1600 50  0001 C CNN
F 3 "" H 4200 1600 50  0001 C CNN
	1    4200 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 1850 4500 3900
Wire Wire Line
	6900 3250 7700 3250
Wire Wire Line
	7700 3550 6900 3550
Connection ~ 7700 3250
Wire Wire Line
	7700 3250 7700 3550
Wire Wire Line
	7700 2350 7700 3250
Wire Wire Line
	7000 3650 6900 3650
Wire Wire Line
	7050 3950 3850 3950
Wire Wire Line
	5700 2600 5700 2800
Wire Wire Line
	5700 2800 5050 2800
Wire Wire Line
	5050 2800 5050 4150
Wire Wire Line
	5050 4150 3650 4150
Wire Wire Line
	3650 4150 3650 2550
Wire Wire Line
	3650 2550 3950 2550
Wire Wire Line
	8050 2000 8050 2450
Wire Wire Line
	7000 2400 7100 2400
Wire Wire Line
	6900 2400 6900 2450
Wire Wire Line
	6900 2450 8050 2450
Connection ~ 8050 2450
Wire Wire Line
	8050 2450 8050 3900
Wire Wire Line
	7150 4200 3600 4200
Wire Wire Line
	3600 4200 3600 3750
Wire Wire Line
	3600 3750 3950 3750
Text Label 7800 1200 0    50   ~ 0
VCC
Text Label 5400 1850 0    50   ~ 0
C1+
Text Label 5400 2150 0    50   ~ 0
C1-
Text Label 5300 2350 0    50   ~ 0
C2+
Text Label 5350 2600 0    50   ~ 0
C2-
Text Label 5000 2250 0    50   ~ 0
V+
Text Label 5250 2650 0    50   ~ 0
V-
Text Label 5650 2600 0    50   ~ 0
TxD
Text Label 5700 2700 0    50   ~ 0
CTS
Text Label 7000 2900 0    50   ~ 0
TxIn
Text Label 6950 2300 0    50   ~ 0
Rx
Text Label 7000 2200 0    50   ~ 0
DTR
Text Label 7000 2100 0    50   ~ 0
RxD
Text Label 7300 3250 0    50   ~ 0
PullUp
Text Label 6950 3350 0    50   ~ 0
Tx
Text Label 6950 3450 0    50   ~ 0
STRB
Wire Wire Line
	7000 2500 7000 3650
$Comp
L SamacSys_Parts:SN74LS74AN Z2
U 1 1 606F241D
P 5700 3150
F 0 "Z2" H 6300 3415 50  0000 C CNN
F 1 "SN74LS74AN" H 6300 3324 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 6750 3250 50  0001 L CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls74a" H 6750 3150 50  0001 L CNN
F 4 "Dual D-type pos.-edge-triggered flip-flops with preset and clear" H 6750 3050 50  0001 L CNN "Description"
F 5 "5.08" H 6750 2950 50  0001 L CNN "Height"
F 6 "Texas Instruments" H 6750 2850 50  0001 L CNN "Manufacturer_Name"
F 7 "SN74LS74AN" H 6750 2750 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "595-SN74LS74AN" H 6750 2650 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.co.uk/ProductDetail/Texas-Instruments/SN74LS74AN/?qs=b0gIXGU74fP41yYZQO4%252BKQ%3D%3D" H 6750 2550 50  0001 L CNN "Mouser Price/Stock"
F 10 "SN74LS74AN" H 6750 2450 50  0001 L CNN "Arrow Part Number"
F 11 "https://www.arrow.com/en/products/sn74ls74an/texas-instruments" H 6750 2350 50  0001 L CNN "Arrow Price/Stock"
	1    5700 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 3350 6900 3350
Wire Wire Line
	7050 3350 7050 3950
Wire Wire Line
	6900 3450 7150 3450
Wire Wire Line
	7150 3450 7150 4200
$EndSCHEMATC
