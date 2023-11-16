#Debug Colors
RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[1:34m'
YELLOW='\033[1;33m'
CLEAR='\033[0;0m'
#Summary variables
passed_drives=0
failed_drives=0

#Refresh drive list 
echo -e "${YELLOW} Refreshing drive list...${CLEAR}"
sudo rescan-scsi-bus

#Obtain drive count
drive_count=$(lsblk -o NAME | grep -E '^sd' | awk 'END {print NR}')
echo -e "${YELLOW}Drive count: $drive_count ${CLEAR}"
if [ "$drive_count" -lt 2 ]; then
    echo -e "${RED}No new drives detected! Check connections and try again. ${CLEAR}"
    exit
else
    echo -e "${GREEN}New drives found.${CLEAR}"
fi
#revise boot drive later
boot_drive="sda"
new_drives=$(lsblk -o NAME | grep -E '^sd' | grep -v "$boot_drive")
echo -e "${YELLOW}Found drives:\n${BLUE}$new_drives ${CLEAR}"

for drive in $new_drives; do
    echo -e "${YELLOW}Attempting to remove password from drive ${BLUE}$drive${YELLOW}...${CLEAR}"
    # Attempt to remove the password
    remove_pass=$(sudo hdparm --user-master u --security-set-pass pass /dev/$drive 2>&1)

    # Check the exit status of the hdparm command
    if echo "$remove_pass" | grep -q "bad"; then
        echo -e "${RED}Drive ${BLUE}$drive${RED} FAILED to unlock. Please reboot with Space Monkey.${CLEAR}"
        ((failed_drives++))
    else
        echo -e "${GREEN}Drive ${BLUE}$drive${GREEN} UNLOCKED.${CLEAR}"
        # Disable security
        sudo hdparm --security-disable pass /dev/$drive
        ((passed_drives++))
    fi
done

echo -e "${GREEN}Drives PASSED: ${BLUE}$passed_drives${CLEAR}, ${RED}Drives FAILED: ${BLUE}$failed_drives${CLEAR}"
echo -e "${GREEN}------------DONE------------${CLEAR}"
