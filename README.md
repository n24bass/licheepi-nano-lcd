# LicheePi-Nano with LCD
Linux capable single board computer using the Allwinner F1C100s SoC
with 32MB of embedded RAM. 

This repo contains a Buildroot configuration to build a small, bootable
SD-Card image for the LicheePi Nano.

## Supported Features:
- LCD Panels (480x272) from the 40-pin FFC connector
- Resistive Touchscreen (Nsiway NS2009)
- Backlight control
	- sysfs export at: ```/sys/class/blacklight/blacklight```
	- ```echo [0-7] > brightness```
- USB Host Support (HID: mice, keyboards)
- Audio via on-chip codec and hardware pins (HPL, HPR, etc.)
	- See [LicheePi Nano schematic](docs/licheepi_nano_sch.pdf)


mclewell さんのものをベースに Licheepi Nano 用に config と dts に手をいれています。

* spi1 for Microchip enc28j60 ethernet   
  ```$ udhcpc```
* i2c0  
  example: ```ssd1306```
* codec - HeadPhone 
* lradc - 4 key input

## build

Clone this repo:
```
git clone https://github.com/mclewell/licheepi-nano-lcd
git submodule update --init
```
Change to the Buildroot directory:
```
cd licheepi-nano-lcd/software/buildroot
```
We will be doing an out-of-tree build. Make an directory for the output:
```
mkdir output-sd
cd output-sd
```
Set-up the build:
```
make -C ../ O=$(pwd) BR2_EXTERNAL=$PWD/../../ licheepi_nano_lcd_sd_defconfig
```
Start the build:
```
make
```

## Microchip ENC28J60

This is a standalone 10 MBit ethernet controller with SPI interface.

pin assign: 

| Lichee pi nano | enc28j60 |
| ---- | --- |
| J5-3 (PA3/SPI1_MISO) | SDO |
| J5-5 (PA2/SPI1_CLK) | CLK | 
| J5-7 (PA1/SPI1_MOSI) | SDI | 
| J5-9 (PA0/SPI1_CS) | CS |
| J5-11 (3V3) | 3.3V |
| J5-13 (GND) | GND |
| J2-21 (PE3) | INT | 


