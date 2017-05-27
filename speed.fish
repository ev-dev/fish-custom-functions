function speed
	if test -z $argv
		set loopTimes 3
	else if test "$argv" -lt 2
		set loopTimes 1
	else
		set loopTimes "$argv"
	end

	set downSum 0
	set upSum 0
	set avgDivisor "$loopTimes"
	for testNum in (seq $loopTimes)
		touch ~/.config/speedtests/speedtest$testNum ~/.config/speedtests/formated$testNum

		spin "speedtest >>~/.config/speedtests/$testNum"

		set arr (cat ~/.config/speedtests/speedtest$testNum | string split -r  " Mbit/s")

		set up (echo $arr[1] | string sub -s 9)
		set down (echo $arr[4] | string sub -s 11)

		set up (echo $up | string split -r ".")[1]
		set down (echo $down | string split -r ".")[1]

		set upSum (math "$upSum" + "$up")
		set downSum (math "$downSum" + "$down")
		
		echo "Download Speed: @$down Mbps"
		echo "Upload Speed: @$up Mbps"
		
		echo "downSum: $downSum"
		echo "upSum: $upSum"
	end

	set upAvg (math "$upSum" / "$avgDivisor")
	set downAvg (math "$downSum" / "$avgDivisor")

	echo "- Results for $avgDivisor Tests -"
	echo "Download Speed Avg: $downAvg Mbps"
	echo "Upload Speed Avg: $upAvg Mbps"

	rm ~/.config/speedtests/*

end

#	set upval "$up"
#	set operation (math "$upval" + "$testval")
#	echo "Double Upload: $operation Mbps"


#	set up ((eval $up) / 2)
#	echo "Avg Upload Speed: $up Mbps"
	
#	echo "   "
#	echo "   "
#	for i in $arr
#		echo "      "
#		echo "--------------------"
#		echo "Individual element: "
#		echo $i
#		echo "--------------------"
#		echo "    "		
#	end
#	touch ~/.config/speedtests/temp
#	echo "$DLspeed" > ~/.config/speedtests/temp
#	cat ~/.config/speedtests/temp
#	cat	~/.config/speedtests/formated

	