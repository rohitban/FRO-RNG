import sys

first_len = 24
next_len = 25

def convertFormat(oldFilename, newFilename):
	with open(oldFilename,'r') as old:
		count = 0
		enterStr = ""
		with open(newFilename,'w') as new:
			for line in old:
				#Append to write string
				enterStr += line.rstrip("\n")
				
				count += 1
				#First line is 24 chars subsequent are 25 chars long
				if(count < first_len):
					limit = first_len
				else:
					limit = next_len 
    			
				if((len(enterStr)%limit)==0):
					#Write line then clear
					new.write(enterStr+"\n")
					enterStr = ""
			#Now write the leftovers to file
			new.write(enterStr+"\n")	

def main():
	argList = sys.argv

	if(len(argList)<2):
		print("Usage ./getASCII.py <size>")

	oldFilename = argList[1]

	newFilename = oldFilename[:len(oldFilename)-4]+"_ascii.txt"

	convertFormat(oldFilename,newFilename)

	print("Finished conversion, output file is "+newFilename)



if __name__ == "__main__":
	main()