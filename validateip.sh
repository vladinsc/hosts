output=$(cat /etc/hosts)
echo "$output" | awk '/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ [A-Za-z0-9.-]+/ {print $1, $2}'
while read -r ip domain; 
do
real_ip=$(nslookup "$domain" 8.8.8.8 | grep 'Address' | tail -n 1 | awk '{print $2}')
if [ $ip != $real_ip] 
then 
	echo "Bogus ip for $domain found in /etc/hosts. IP local: $ip , IP real: $real_ip"
else
	echo "Good ip for $domain for in /etc/hosts. IP: $ip"
fi
done
