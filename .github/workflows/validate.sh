#!/bin/bash

for file in mods/**/*.xml; do
  xmllint --noout "$file"
done

for file in mods/**/*.xml; do
  # Check Mod.LatestVersion.Link
  latest_version_link=$(xmllint --xpath 'string(//LatestVersion/Link)' "$file" | sed 's|iroj://Url/https\$|https://|' | sed 's|iroj://Url/http\$|http://|')
  test=$(xmllint --xpath 'string(//LatestVersion/Link)' "$file" )
  echo "$test | sed 's|iroj://Url/https\$|https://|' | sed 's|iroj://Url/http\$|http://|'"
  echo "$latest_version_link"
  if ! curl --output /dev/null --silent --head --fail "$latest_version_link"; then
    echo "Invalid LatestVersion.Link: $latest_version_link"
    exit 1
  fi

  # Check Mod.LatestVersion.PreviewImage
  preview_image=$(xmllint --xpath 'string(//LatestVersion/PreviewImage)' "$file")
  if ! curl --output /dev/null --silent --head --fail "$preview_image"; then
    echo "Invalid PreviewImage link: $preview_image"
    exit 1
  fi
  if ! curl --output /dev/null --silent --head --fail -H "Accept: image/*" "$preview_image"; then
    echo "PreviewImage is not an image: $preview_image"
    exit 1
  fi

  # Check Mod.Link
  mod_link=$(xmllint --xpath 'string(//Link)' "$file")
  if ! curl --output /dev/null --silent --head --fail "$mod_link"; then
    echo "Invalid Mod.Link: $mod_link"
    exit 1
  fi

  # Check Mod.DonationLink
  donation_link=$(xmllint --xpath 'string(//DonationLink)' "$file")
  if ! curl --output /dev/null --silent --head --fail "$donation_link"; then
    echo "Invalid DonationLink: $donation_link"
    exit 1
  fi
done