# HDDPassRemover
Removes password from flash-boot locked drives.

This script will bulk remove passwords from password locked drives. 
It will work with drives that initialize through an external flash PCB.
You will need to initialize them with said PCB before the drive can interface properly.
During that process, the drive must remain powered on when you move the SATA data cable to your Linux machine.
This is the reason for the drive rescan at the beginning of the code.
