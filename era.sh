#!/bin/sh -e
# ESET Security Management Center
# Copyright (c) 1992-2018 ESET, spol. s r.o. All Rights Reserved

files2del="$(mktemp -q /tmp/XXXXXXXX.files)"
dirs2del="$(mktemp -q /tmp/XXXXXXXX.dirs)"
echo "$dirs2del" >> "$files2del"
dirs2umount="$(mktemp -q /tmp/XXXXXXXX.mounts)"
echo "$dirs2umount" >> "$files2del"

finalize()
{
  set +e

  echo "Cleaning up:"

  if test -f "$dirs2umount"
  then
    while read f
    do
      sudo -S hdiutil detach "$f"
    done < "$dirs2umount"
  fi

  if test -f "$dirs2del"
  then
    while read f
    do
      test -d "$f" && rmdir "$f"
    done < "$dirs2del"
  fi

  if test -f "$files2del"
  then
    while read f
    do
      unlink "$f"
    done < "$files2del"
    unlink "$files2del"
  fi
}

trap 'finalize' HUP INT QUIT TERM EXIT

eraa_server_hostname="WIN-PPUOIERQDM2.eu-central-1.compute.internal"
eraa_server_port="2222"
eraa_peer_cert_b64="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"
eraa_peer_cert_pwd=""
eraa_ca_cert_b64="MIIDeTCCAmGgAwIBAgIQcOFUV38L3IxLGExWi5zn/DANBgkqhkiG9w0BAQUFADBVMScwJQYDVQQDEx5TZXJ2ZXIgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxEDAOBgNVBAsTB05ldGd1cnUxCzAJBgNVBAgTAlVTMQswCQYDVQQGEwJVUzAeFw0xODEyMDcwMDAwMDBaFw0yODEyMDgwMDAwMDBaMFUxJzAlBgNVBAMTHlNlcnZlciBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEQMA4GA1UECxMHTmV0Z3VydTELMAkGA1UECBMCVVMxCzAJBgNVBAYTAlVTMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxOLF7sjxCHlSlGMGM6yqZD1obPXeRQ16l3RLW4nmns17ltlzz5TmqsUeo2wfN5f3JUfTEo6cnxCaCSxZ/u5wJ7J/OcwQ4rpPxLUvd4EGe/EUni/VXWJRFD0ED9Bp+G3jupQAdBR8d/HL5nont644o5IMf+/jBVIyirKP1U2IPqso/2YY8PiM5mI+ed/INKXJTsIntYIKehqIMyh4lSfW8x8r+gfAdfwRh3XnOy1INqugucYoUQUhCmZEX/LzqY3+zANbBsqDdnLS7liw2OiLYKXHcQN2FU9DEKxRFFonp6nuqnoSTXr5B3TBuP6PN1tzPhIDzWd6MRVdn1E+TJ8EhQIDAQABo0UwQzAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUN9+qpAMVqTlkb5CGQH62OKtLhgEwDQYJKoZIhvcNAQEFBQADggEBAJTPsm0ycNhPEUfBgZOcQuvl/9Ty+bq8HdNQ05clm3xEDKV5Yf5bR/3W71TIYs/iJA8PSIFLi7eYE9c1OnOV8AOhkE5KD3pCz3hrpeQ6yjMX+8Rkrq7QDGnOsCcrx2R3z0uUHf+pf+G81Mm9b9PmpZv8qsVFjPsIrfooEiuwlrL+PmWYzPUEN6kqfITYZyM1qye/VjiYqlKEzD+0cU1wwxpP2CfFkdmN1O62X7cJYIkGNiWXKufaFEYV/X9WAEsJz6FwHSBSQUd+AkJRkJQn3qgXopd8V1vvlxNjvRqH3T/U0sB1/IUxDmKuArjwZ7r7yjMFZv+146bX0b/DBgQdyLw="
eraa_product_uuid=""

eraa_installer_url="http://repository.eset.com/v1/com/eset/apps/business/era/agent/v7/7.0.432.0/agent_macosx_x86_64.dmg"
eraa_installer_checksum="1faf5421bfb7df400963d4480e8a0c42a6b2b438"
eraa_initial_sg_token=""
eraa_enable_telemetry="1"

arch=$(uname -m)
if $(echo "$arch" | grep -E "^(x86_64|amd64)$" 2>&1 > /dev/null)
then
    eraa_installer_url="http://repository.eset.com/v1/com/eset/apps/business/era/agent/v7/7.0.432.0/agent_macosx_x86_64.dmg"
    eraa_installer_checksum="1faf5421bfb7df400963d4480e8a0c42a6b2b438"
fi

if test -z $eraa_installer_url
then
  echo "No installer available for '$arch' arhitecture. Sorry :/"
  exit 1
fi

local_params_file="/tmp/postflight.plist"
echo "$local_params_file" >> "$files2del"

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" >> "$local_params_file"
echo "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" >> "$local_params_file"
echo "<plist version=\"1.0\">" >> "$local_params_file"
echo "<dict>" >> "$local_params_file"

echo "  <key>Hostname</key><string>$eraa_server_hostname</string>" >> "$local_params_file"
echo "  <key>SendTelemetry</key><string>$eraa_enable_telemetry</string>" >> "$local_params_file"

echo "  <key>Port</key><string>$eraa_server_port</string>" >> "$local_params_file"

if test -n "$eraa_peer_cert_pwd"
then
  echo "  <key>PeerCertPassword</key><string>$eraa_peer_cert_pwd</string>" >> "$local_params_file"
  echo "  <key>PeerCertPasswordIsBase64</key><string>yes</string>" >> "$local_params_file"
fi

echo "  <key>PeerCertContent</key><string>$eraa_peer_cert_b64</string>" >> "$local_params_file"


if test -n "$eraa_ca_cert_b64"
then
  echo "  <key>CertAuthContent</key><string>$eraa_ca_cert_b64</string>" >> "$local_params_file"
fi
if test -n "$eraa_product_uuid"
then
  echo "  <key>ProductGuid</key><string>$eraa_product_uuid</string>" >> "$local_params_file"
fi
if test -n "$eraa_initial_sg_token"
then
  echo "  <key>InitialStaticGroup</key><string>$eraa_initial_sg_token</string>" >> "$local_params_file"
fi

echo "</dict>" >> "$local_params_file"
echo "</plist>" >> "$local_params_file"

# optional list of G1 migration parameters (MAC, UUID, LSID)
local_migration_list="$(mktemp -q /tmp/XXXXXXXX.migration)"
tee "$local_migration_list" 2>&1 > /dev/null << __LOCAL_MIGRATION_LIST__

__LOCAL_MIGRATION_LIST__
test $? = 0 && echo "$local_migration_list" >> "$files2del"

# get all local MAC addresses (normalized)
for mac in $(ifconfig -a | grep ether | sed -e "s/^[[:space:]]ether[[:space:]]//g")
do
    macs="$macs $(echo $mac | sed 's/\://g' | awk '{print toupper($0)}')"
done

while read line
do
  if test -n "$macs" -a -n "$line"
  then
    mac=$(echo $line | awk '{print $1}')
    uuid=$(echo $line | awk '{print $2}')
    lsid=$(echo $line | awk '{print $3}')
    if $(echo "$macs" | grep "$mac" > /dev/null)
    then
      if test -n "$mac" -a -n "$uuid" -a -n "$lsid"
      then
        /usr/libexec/PlistBuddy -c "Add :ProductGuid string $uuid" "$local_params_file"
        /usr/libexec/PlistBuddy -c "Add :LogSequenceID integer $lsid" "$local_params_file"
         break
      fi
    fi
  fi
done < "$local_migration_list"

local_dmg="$(mktemp -q -u /tmp/EraAgentOnlineInstaller.dmg.XXXXXXXX)"
echo "Downloading installer image '$eraa_installer_url':"

eraa_http_proxy_value="http://172.31.38.126:3128"
if test -n "$eraa_http_proxy_value"
then
  export use_proxy=yes
  export http_proxy="$eraa_http_proxy_value"
  (curl --connect-timeout 300 --insecure -o "$local_dmg" "$eraa_installer_url" || curl --connect-timeout 300 --noproxy "*" --insecure -o "$local_dmg" "$eraa_installer_url") && echo "$local_dmg" >> "$files2del"
else
  curl --connect-timeout 300 --insecure -o "$local_dmg" "$eraa_installer_url" && echo "$local_dmg" >> "$files2del"
fi

os_version=$(system_profiler SPSoftwareDataType | grep "System Version" | awk '{print $6}' | sed "s:.[[:digit:]]*.$::g")
if test "10.7" = "$os_version"
then
  local_sha1="$(mktemp -q -u /tmp/EraAgentOnlineInstaller.sha1.XXXXXXXX)"
  echo "$eraa_installer_checksum  $local_dmg" > "$local_sha1" && echo "$local_sha1" >> "$files2del"
  /bin/echo -n "Checking integrity of of downloaded package " && shasum -c "$local_sha1"
else
  /bin/echo -n "Checking integrity of of downloaded package " && echo "$eraa_installer_checksum  $local_dmg" | shasum -c
fi

local_mount="$(mktemp -q -d /tmp/EraAgentOnlineInstaller.mount.XXXXXXXX)" && echo "$local_mount" | tee "$dirs2del" >> "$dirs2umount"
echo "Mounting image '$local_dmg':" && sudo -S hdiutil attach "$local_dmg" -mountpoint "$local_mount" -nobrowse

local_pkg="$(ls "$local_mount" | grep "\.pkg$" | head -n 1)"

echo "Installing package '$local_mount/$local_pkg':" && sudo -S installer -pkg "$local_mount/$local_pkg" -target /
