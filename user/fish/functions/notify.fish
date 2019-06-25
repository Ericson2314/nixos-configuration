function notify
	eval "$argv"
	set -l stat $status
	curl -s -F token=(cat ~/.config/pushover/token) -F user=(cat ~/.config/pushover/user) -F title=Terminal -F "message=($stat) $argv" https://api.pushover.net/1/messages.json > /dev/null 2>&1
end
