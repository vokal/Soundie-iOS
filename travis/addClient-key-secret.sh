#!/bin/bash

#Create SNDObfuscation.swift
echo "let SoundCloudClientID: String = \"$SOUNDCLOUD_CLIENT_ID\"" > Soundie/Soundie/Resources/SNDObfuscation.swift
echo "let SoundCloudClientSecret: String = \"$SoundCloudClientSecret\"" >> Soundie/Soundie/Resources/SNDObfuscation.swift
echo "let SoundCloudRedirectUri: String = \"$SoundCloudRedirectUri\"" >> Soundie/Soundie/Resources/SNDObfuscation.swift
