#!/bin/sh
COOKIE=$(wget -qO- https://wireless.wifirst.net:8099/index.txt)
EMAIL="exemple@email.com"
BODYDATA="{\"fragment_id\":2683,\"box_token\":\"$COOKIE\",\"guest_user\":{\"email\":\"$EMAIL\",\"cgu\":true}}"
UA="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.134 Safari/537.36"


CREDS=$(wget -qO- \
  --method POST \
  --load-cookies /tmp/cookies.txt \
  --save-cookies /tmp/cookies.txt \
  --keep-session-cookies \
  --header 'Content-Type: application/json' \
  --header "User-Agent: $UA" \
  --body-data $BODYDATA \
   'https://portal-front.wifirst.net/api/guest_users')

USERNAME=$(echo $CREDS | awk 'BEGIN{RS=":"}{print $1}' | cut -d '"' -f2 | tail -3 | head -1)
PASSWORD=$(echo $CREDS | awk 'BEGIN{RS=":"}{print $1}' | cut -d '"' -f2 | tail -2 | head -1)
BODYDATA2="username=$USERNAME&password=$PASSWORD&success_url=https%3A%2F%2Fwww.myresidhome.com&error_url=https%3A%2F%2Fportal-front.wifirst.net%2Fconnect-error&update_session=1"

wget -q0- >> /dev/null \
  --method POST \
  --load-cookies /tmp/cookies.txt \
  --save-cookies /tmp/cookies.txt \
  --keep-session-cookies \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --header "User-Agent: $UA" \
  --body-data $BODYDATA2 \
  'https://wireless.wifirst.net:8090/goform/HtmlLoginRequest'
