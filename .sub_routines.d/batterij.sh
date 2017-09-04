#!/bin/sh

# force ADC enable for battery voltage and current
sudo i2cset -y -f 0 0x34 0x82 0xC3

################################
#read Power status register @00h
POWER_STATUS=$(sudo i2cget -y -f 0 0x34 0x00)
#echo $POWER_STATUS

BAT_STATUS=$(($(($POWER_STATUS&0x02))/2))  # divide by 2 is like shifting rigth 1 times
#echo $(($POWER_STATUS&0x02))
echo "BAT_STATUS="$BAT_STATUS
# echo $BAT_STATUS

################################
#read Power OPERATING MODE register @01h
POWER_OP_MODE=$(sudo i2cget -y -f 0 0x34 0x01)
#echo $POWER_OP_MODE

CHARG_IND=$(($(($POWER_OP_MODE&0x40))/64))  # divide by 64 is like shifting rigth 6 times
#echo $(($POWER_OP_MODE&0x40))
echo "CHARG_IND="$CHARG_IND
# echo $CHARG_IND

BAT_EXIST=$(($(($POWER_OP_MODE&0x20))/32))  # divide by 32 is like shifting rigth 5 times
#echo $(($POWER_OP_MODE&0x20))
echo "BAT_EXIST="$BAT_EXIST
# echo $BAT_EXIST

################################
#read Charge control register @33h
CHARGE_CTL=$(sudo i2cget -y -f 0 0x34 0x33)
echo "CHARGE_CTL="$CHARGE_CTL
# echo $CHARGE_CTL


################################
#read Charge control register @34h
CHARGE_CTL2=$(sudo i2cget -y -f 0 0x34 0x34)
echo "CHARGE_CTL2="$CHARGE_CTL2
# echo $CHARGE_CTL2


################################
#read battery voltage   79h, 78h        0 mV -> 000h,   1.1 mV/bit      FFFh -> 4.5045 V
BAT_VOLT_MSB=$(sudo i2cget -y -f 0 0x34 0x78)
BAT_VOLT_LSB=$(sudo i2cget -y -f 0 0x34 0x79)

#echo $BAT_VOLT_MSB $BAT_VOLT_LSB
# bash math -- converts hex to decimal so `bc` won't complain later...
# MSB is 8 bits, LSB is lower 4 bits
BAT_BIN=$(( $(($BAT_VOLT_MSB << 4)) | $(($(($BAT_VOLT_LSB & 0x0F)) )) ))

BAT_VOLT=$(echo "($BAT_BIN*1.1)"|bc)
echo "Batterij spanning = "$BAT_VOLT"mV"

###################
#read Battery Discharge Current 7Ch, 7Dh        0 mV -> 000h,   0.5 mA/bit      1FFFh -> 1800 mA
#AXP209 datasheet is wrong, discharge current is in registers 7Ch 7Dh
#13 bits
BAT_IDISCHG_MSB=$(sudo i2cget -y -f 0 0x34 0x7C)
BAT_IDISCHG_LSB=$(sudo i2cget -y -f 0 0x34 0x7D)

#echo $BAT_IDISCHG_MSB $BAT_IDISCHG_LSB

BAT_IDISCHG_BIN=$(( $(($BAT_IDISCHG_MSB << 5)) | $(($(($BAT_IDISCHG_LSB & 0x1F)) )) ))

BAT_IDISCHG=$(echo "($BAT_IDISCHG_BIN*0.5)"|bc)
echo "Ontlaadstroom batterij = "$BAT_IDISCHG"mA"

###################
#read Battery Charge Current    7Ah, 7Bh        0 mV -> 000h,   0.5 mA/bit      FFFh -> 1800 mA
#AXP209 datasheet is wrong, charge current is in registers 7Ah 7Bh
#(12 bits)
BAT_ICHG_MSB=$(sudo i2cget -y -f 0 0x34 0x7A)
BAT_ICHG_LSB=$(sudo i2cget -y -f 0 0x34 0x7B)

#echo $BAT_ICHG_MSB $BAT_ICHG_LSB

BAT_ICHG_BIN=$(( $(($BAT_ICHG_MSB << 4)) | $(($(($BAT_ICHG_LSB & 0x0F)) )) ))

BAT_ICHG=$(echo "($BAT_ICHG_BIN*0.5)"|bc)
echo "Laadstroom batterij = "$BAT_ICHG"mA"

###################
#read internal temperature      5eh, 5fh        -144.7c -> 000h,        0.1c/bit        FFFh -> 264.8c
TEMP_MSB=$(sudo i2cget -y -f 0 0x34 0x5e)
TEMP_LSB=$(sudo i2cget -y -f 0 0x34 0x5f)

# bash math -- converts hex to decimal so `bc` won't complain later...
# MSB is 8 bits, LSB is lower 4 bits
TEMP_BIN=$(( $(($TEMP_MSB << 4)) | $(($(($TEMP_LSB & 0x0F)) )) ))

TEMP_C=$(echo "($TEMP_BIN*0.1-144.7)"|bc)
echo "CPU temperatuur = "$TEMP_C"c"

# Aanvulling status.json tav batterij status

cat >>/home/elseco/data.d/status.json <<EOL
   "Batterij spanning": '"$BAT_VOLT mV",
   "Ontlaadstroom batterij": '"$BAT_IDISCHG mA",
   "Laadstroom batterij": '"$BAT_ICHG mA",
   "CPU temperatuur": '"$TEMP_C c",
EOL
