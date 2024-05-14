#!/bin/bash
# Example Bar Action Script for Linux.
# Requires: acpi, iostat.
# Tested on: Debian 10, Fedora 31.
#

print_mem() {
	MEM=`/usr/bin/free -m | grep ^Mem: | sed -E 's/ +/ /g' | cut -d ' ' -f4`
	echo -n "|Free mem ${MEM}M"
}

print_cpu() {
	IOSTAT_DATA=($(iostat -c | grep '[0-9]$'|sed -E 's/  / /g'))
	echo -n "|CPU Usr "${IOSTAT_DATA[0]}" Sys "${IOSTAT_DATA[2]} " Idle "${IOSTAT_DATA[5]}
}

print_cpuspeed() {
	oldIFS=$IFS
	IFS=$'\n'
	CPU_SPEED=( $(/usr/bin/lscpu -p=MHZ|grep -v '^#'|sed -E 's/,.*//g' ) ) 
	IFS=$oldIFS
	SUM=0
	for (( i=0; i<${#CPU_SPEED[@]}; i++ ));
	do
		SUM=$((${CPU_SPEED[$i]} + SUM));
	done
	SUM=$(($SUM/$i))
	echo -n "|Speed "$SUM
}

print_bat() {

	oldIFS=$IFS
	IFS=$'\n '
	ACPI_DATA=( $(acpi -ab 2>/dev/null; /usr/bin/acpi -b 2>/dev/null|sed -E 's/Not c/Not_c/' ))
	IFS=$oldIFS
	echo -n "|"${ACPI_DATA[6]}
	echo -n " "${ACPI_DATA[2]}
	echo -n " "${ACPI_DATA[3]}

}

print_wifi()
{
	RETE=( $(nmcli connection show --active |grep -v '^lo'| grep -v '^NAME'))
	echo -n "|"${RETE[2]}" "${RETE[3]}" "${RETE[0]}
}

print_volume()
{
	VOL=( $(pamixer --get-volume-human ))
	echo -n "|Vol:" ${VOL} " "
	SINK=( $(pamixer --get-default-sink  | grep ^[0-9] ))
	case "${SINK[0]}" in
		0)
			AUDIO=" Analog out"
			;;
		1)	
			AUDIO=" HDMI out"
			;;
		2)
			AUDIO=" Ext adapter 1"
			;;
		*)
			AUDIO=" Other adapter"
			;;
		esac
	echo -n $AUDIO
}

#  MAIN loop
while :; do
	print_mem
	print_cpu 
	print_cpuspeed
	# print_cpu_governor
	print_bat 
	print_wifi
	print_volume
	# print_light
	echo ""
	sleep 10
done
