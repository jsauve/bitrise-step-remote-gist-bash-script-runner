#!/bin/bash

gist_url_base="gist.github.com"

echo
echo "gist_url: ${gist_url}"

# Required input validation
if [[ "${gist_url}" == "" ]]; then
	echo
	echo "No gist_url provided as environment variable. Terminating..."
	echo
	exit 1
fi

# Required input validation
if [[ "${exit_on_failure}" != "0" ]] && [[ "${exit_on_failure}" != "1" ]]; then
	echo
	echo "exit_on_failure must be set to either 0 or 1. Terminating..."
	echo
	exit 1
fi

# validate Gist URL
if [[ "${gist_url}" != "http://$gist_url_base"* ]] && [[ "${gist_url}" != "https://$gist_url_base"* ]];then
	echo
	echo "gist_url must be a valid Gist URL (containing '$gist_url_base'). Terminating... "
	echo
	exit 1
fi

echo
echo "---------------------------------------------------"
echo "--- Fetching raw Gist URL(s) from: ${gist_url}"
echo
echo "--- Warning messages from tidy command (disregard):"

temp_doc=$(curl -sSL "${gist_url}" | grep -Eoi '<a [^>]+>Raw</a>' | tidy -quiet)

file_count=$(echo $temp_doc | xmllint --html --xpath "count(//a/@href)" -)

echo
echo "--- # of Gist files found: $file_count"
echo "---------------------------------------------------"

declare -a raw_urls

for (( i=1; i <= $file_count; i++ )); do 
    raw_urls[$i]="$(echo $temp_doc | xmllint --html --xpath 'string(//a['$i']/@href)' -)"
done

j=1
for i in "${raw_urls[@]}"
do

	raw_url="https://$gist_url_base$i"
	echo
	echo "---------------------------------------------------"
	echo "--- Executing remote script #$j: $raw_url"
	echo
	bash -c "$(curl -sSL "${raw_url}")"
	res_code=$?
	if [ ${res_code} -ne 0 ] ; then
		echo
		echo "--- [!] Script #$j returned with an error code: ${res_code}"
		echo "---------------------------------------------------"
		if [[ ${exit_on_failure} == "1" ]]; then
			exit 1
		fi
		j=$(($j+1))
	else
		echo
		echo "--- Script #$j returned with a success code - OK"
		echo "---------------------------------------------------"
		echo
		j=$(($j+1))
	fi

done

exit 0