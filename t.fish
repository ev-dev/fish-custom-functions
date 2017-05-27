function t --argument-names 'limit' 'dirChoice'
	if test -z $limit
		and test -z $dirChoice
		tree --filelimit 30 -L 3
	# if the input for $limit gets replaced, must be number
	else if test (string replace -r '[\d]' "$limit" 'isnumber') = 'isnumber'
		tree -L 3 --filelimit $limit $dirChoice
	# else the input $limit actually implys directory
	else
		tree -L 3 --filelimit $limit
	end
end
