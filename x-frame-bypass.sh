#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage: ./x-frame-bypass.sh [TARGET_URL]"
    echo "(do not include URI path in TARGET_URL, just [protocol]://[domain]"
    exit 92
fi

if [[ -z "${TMUX}" ]]; then
    echo "Must be run in tmux"
    exit 92
fi


CYAN='\033[1;36m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

TARGET_URL=$1
SCRIPT=x-frame-bypass.js

cp ${SCRIPT}.tpl ${SCRIPT}

tmux split-window -h "gitar webhook --proxy ${TARGET_URL} -H \"X-Frame-Options:\" -H \"Access-Control-Allow-Origin:*\""
tmux split-window -h "ngrok http 9292"
sleep 6
NGROK_TUNNEL=$(curl --silent --show-error http://127.0.0.1:4040/api/tunnels | jq -r ".tunnels[0].public_url")
sed -i -e "s|GITAR_REVERSE_PROXY|${NGROK_TUNNEL}|g" ${SCRIPT} #see https://unix.stackexchange.com/questions/335640/how-to-replace-variables-strings-with-special-characters-in-sed
surge .
clear
echo -e "👉 Include:\n${GREEN}<script type=\"module\" src=\"https://x-frame-bypass.surge.sh/x-frame-bypass.js\"></script>\n<iframe is=\"x-frame-bypass\" src=\"${TARGET_URL}\"></iframe>${NC}"

echo -e "\n\n🚪To terminate the process: Close ngrok + gitar and launch surge teardown x-frame-bypass.surge.sh"
