# HDDPassRemover
Removes password from flash-boot locked drives.

This script will bulk remove passwords from password locked drives. 
It will work with drives that initialize through an external flash PCB.
You will need to initialize them with said PCB before the drive can interface properly.
During that process, the drive must remain powered on when you move the SATA data cable to your Linux machine.

If your hardware does not support hot plugging, you will need to run the shell with the "scan" argument
(bash password.sh scan)
This will refresh your SCSI bus to find newly plugged in drives and prepare for password removal.

DISCLAIMER: This script only ignores the boot drive, any other connected drive is assumed to be a target.
NOTE: NVMe drives are not targeted (/dev/sdX addresses only)
