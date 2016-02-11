#!/usr/bin/env bash

conf_regex="\[application_name\]"
conf_file="000.conf"
app_name="catalog-app"
if [ -f "$conf_file" ] ; then
	echo "YOYOYOYOYOYOYO"
	sed -i.bak "s|${conf_regex}|${app_name}|" $conf_file
fi
cat $conf_file