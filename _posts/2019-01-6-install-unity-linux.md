---
layout: post
title:  "Install Unity3D on Linux"
date:   2019-01-6 22:32:23 +0530
categories: linux unity
---
I've been running Unity on my Debian machine, and I'm pretty amazed by how well everything works, 
though it is not listed as an officially supported distro. 
It should also work for any other distro, Ubuntu, Fedora and the like.

The preferred way of installing Unity on Linux is by first installing Unity Hub.

#### Install & Run Unity Hub on Linux

You can find the Unity Hub setup file in here:

https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage

You can also refer to [Unity Hub sub-forum](https://forum.unity.com/forums/unity-hub.142/) in forum.unity.com to make sure that you're downloading the latest available version.

Once downloaded, you may need to give execute permission to the UnityHubSetup.AppImage

~~~ bash
cd /path/to/download/dir
sudo chmod +x UnityHubSetup.AppImage
~~~

Then run the setup file. Either run it from the terminal or just open the file from a file manager.

#### Install Unity from Unity Hub

<a href="/assets/unity/running-unity-hub.gif" target="_blank">
<img src="/assets/unity/running-unity-hub.gif" alt="Running Unity Hub" width="100%"/>
</a>

In the Installs section of Unity Hub application, you can choose a preferred version of Unity that you want to
install. Unity Hub will automatically download and install it for you. Unity Hub also helps us to easily switch between different versions of Unity.

#### Unity Crash

If your Unity crashes, most probably your graphics driver is to blame.

If you have an Intel graphic card that is 2007 or newer, try uninstalling `xserver-xorg-video-intel`.
Your system will then default to use the builtin modesetting driver instead. 

~~~ bash
dpkg -l xserver-xorg-video-intel
sudo apt-get purge xserver-xorg-video-intel
~~~

If that still not fix your issue, try asking in the forums.

If it's not a known issue, you could also send a bug report, which will open an issue in [Issue Tracker](https://issuetracker.unity3d.com/) and Unity team will get back to you.
