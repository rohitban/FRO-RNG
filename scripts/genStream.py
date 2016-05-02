import sys
import random

threshold = 0.5

def printStream(len):
	for i in xrange(len):
		num = random.random()
		if(num>threshold):
			print("1");
		else:
			print("0");

def main():	
	argList = sys.argv

	if(len(argList)<2):
		print("Usage ./genStream.py <size>")
		return

	length = int(argList[1])

	printStream(length)


if __name__ == "__main__":
	main()
