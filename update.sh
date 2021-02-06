#!/bin/bash
# Script to help updateing configureation files for OpenWebRX
# Tests bands.json and bookmarks.json for proper json format
# This tests for proper json format, it does not verify that
# the file has correct and resonably parmeters for the OpenWebRX app
# If all the files are good format and one or more is newer that is
# currently running it copies them over to /etc/openwebrx/ and
# then restarts the OpenWebRX app.
#
# Dan Karg K0TI
#
# Last Revsion Feb 05 2021
#

# Test for running as user 0 (root)
if [ $UID != "0" ]
then
    echo "Must be run as root (sudo)"
    exit 1
fi

# Variablues used to keep track of state of files
bands=0
bookmarks=0
restart=1


# test the bands.json file to be sure it's a good json format
if python -m json.tool bands.json >/dev/null 2>&1 ; then
    echo "bands.json -------- passes json test"
    if [[ bands.json -nt /etc/openwebrx/bands.json ]] ; then
      cp -u bands.json /etc/openwebrx/bands.json
      newfile=1
      echo "bands.json -------- newer and copied"
    else
      echo "bands.json -------- not newer, no copy performed"
    fi
else
    echo "bands.json -------- file bad , test failed"
    restart=0
fi

# test the bookmarks file to be sure it's a good json format
if python -m json.tool bookmarks.json >/dev/null 2>&1 ; then
    echo "bookmarks.json ---- passes json test"
    if [[ bookmarks.json -nt /etc/openwebrx/bookmarks.json ]] ; then
      cp -u bookmarks.json /etc/openwebrx/bookmarks.json
      newfile=1
      echo "bookmarks.json ---- newer and copied"
    else
      echo "bookmarks.json ---- not newer, no copy performed"
    fi    
else
    echo "bookmarks.json ---- file bad , test failed"
    restart=0
fi

# if both files are good then we might restart
if [[ $restart -eq 1 ]] ; then
  # test to see if we have a newer config_webrx.py to copy over
  if [[ config_webrx.py -nt /etc/openwebrx/config_webrx.py ]] ; then
    cp -u config_webrx.py /etc/openwebrx/config_webrx.py
    newfile=1
    echo "config_webrx.py --- newer and copied"
  else
    echo "config_webrx.py --- not newer, no copy performed"
  fi
  # if everything checks out and we have something newer restart OpenWebRX
  if [[ $newfile -eq 1 ]] ; then
    # 1 or more of the 3 files were updated need to restart
    # restart openweb rx
    systemctl restart openwebrx.service
    echo "OpenWebRX reloaded"
  fi
fi
