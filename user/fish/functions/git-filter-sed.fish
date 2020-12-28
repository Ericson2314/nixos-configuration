function git-filter-sed
	git grep -l -E $argv[1] $$argv[3] | xargs sed -i -E -e "s#$argv[1]#$argv[2]#g"
end
