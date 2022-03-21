import sys
import serial
import argparse

parser = argparse.ArgumentParser()

parser.add_argument("--port", required=True, help="port (ex. /dev/ttyUSB0)")
parser.add_argument("--image", default="initmem.bin", help="image file")
parser.add_argument("--rate", default="8000000", help="baud rate")

args = parser.parse_args()

port = args.port
num = int(args.rate)
num = num if num > 0 else 1000000
name = args.image

with serial.Serial(port, num) as ser:
    print("serial baud rate : "+str(num))
    print("send file : "+name);
    with open(name, mode="rb") as fin:
        content = fin.read()
        ser.write(content)
    print("finished!");
