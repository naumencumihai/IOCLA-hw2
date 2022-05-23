otp.asm

iterate through plaintext and key character by character and apply xor between 
two characters
put the result at the address from base edx with the same offset


caesar.asm

push edx in stack to be ready to be used in solving this task
calculate the remainder of the key divided to the number of letters from 
english alphabet
take character by character in a loop to check if it is letter and apply 
the rotation on it else the algorithm doesn't modify the character
check if it is space skip it
check if it is letter
add the key and then check if it is exceed the chracter ascii code and apply 
the rotation
pop from stack edx so we can store at the address with edx offset the new 
character

