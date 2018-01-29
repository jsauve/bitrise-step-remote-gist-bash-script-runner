#!/bin/bash

echo
echo "gist_url: ${gist_url}"

# Required input validation
if [[ "${gist_url}" == "" ]]; then
	echo
	echo "No script_url provided as environment variable. Terminating..."
	echo
	exit 1
fi


echo
echo "---------------------------------------------------"
echo "--- Executing script: ${script_url}"
echo

curl -sSL "${gist_url}" | xml select -t -v /html/body | xmllint --xpath "string(//a[text()='Raw']/@href)" - | bash
res_code=$?
if [ ${res_code} -ne 0 ] ; then
	echo "--- [!] The script returned with an error code: ${res_code}"
	echo "---------------------------------------------------"
	exit 1
fi

echo
echo "--- Script returned with a success code - OK"
echo "---------------------------------------------------"
exit 0