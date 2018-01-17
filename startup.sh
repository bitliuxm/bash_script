#! /bin/bash

# this script is excuted in crontab -e

# fix zsh history corrupt
mv ~/.zsh_history ~/.zsh_history_bad
strings ~/.zsh_history_bad > ~/.zsh_history
fc -R ~/.zsh_history

echo `date` >> ~/testcronlog
