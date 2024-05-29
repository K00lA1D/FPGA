

from serial import Serial
import time

# Establish connection to the FPGA board
ser = Serial('COM8', 115200, timeout=1)

def send_instruction(instruction):

    """Send a 32-bit instruction to the FPGA via UART and block until it is processed."""
    
    ser.write(instruction.encode() + b'\n')  # Send the instruction followed by a newline
   
    print("Instruction sent. Waiting for the FPGA to process...")
    while True:
        if ser.in_waiting:
            response = ser.read().decode()  # Read response from FPGA
            if response == b'R':  # Ensure the response is byte type
                print("FPGA is ready for the next instruction.")
                break;
            else:
                print("Unexpected response received:", response)


def get_instruction():
    """Prompt the user for a 32-bit binary instruction and validate it."""
    
    while True:

        instruction = input("Please type in the instruction (32 bits): ")
        
        if len(instruction) == 32 and all(c in '01' for c in instruction):
            return instruction
        else:
            print("Invalid input. Please ensure the instruction is exactly 32 bits long and contains only 0s and 1s.")


if __name__ == "__main__":

    try:
        while True:
            instr = get_instruction()
            send_instruction(instr)

    except KeyboardInterrupt:
        print("Program terminated by user.")
    finally:
        ser.close()  # Ensure the serial connection is closed on exit





# Function to send instruction and wait for ready signal
def send_instruction(instruction):
    ser.write(instruction.encode())  # Send the instruction
    while True:
        if ser.in_waiting:
            response = ser.read().decode()  # Read response from FPGA
            if response == 'R':  # Assuming 'R' signifies ready
                break
    print("FPGA is ready for next instruction.")

# Example usage
send_instruction("00010011001010100001000010010011")
