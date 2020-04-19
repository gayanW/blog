---
layout: post
title:  "Install Unity3D on Linux"
date:   2019-01-6 22:32:23 +0530
categories: linux unity
---
I've been running Unity on my Debian / Ubuntu machines for so long and never have any issues whatsoever. As of now Ubuntu 18.04, and CentOS 7 are listed as the officially supported distros. I'm currently developing a sci-fi brain teaser which is currently on closed beta on Google Play, is solely build on Unity Linux. Again, it's no different from running it on a Windows machine.

The preferred way of installing Unity on Linux is by first installing Unity Hub.

#### Install & Run Unity Hub on Linux

You can find the Unity Hub setup file in here:

https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage

You can also refer to [Unity Hub sub-forum](https://forum.unity.com/forums/unity-hub.142/) in forum.unity.com for additional information and to make sure that you're downloading the latest available version.

Once downloaded, you may need to give execute permission to the UnityHubSetup.AppImage

~~~ bash
cd /path/to/download/dir
sudo chmod +x UnityHub.AppImage
~~~

Then run the setup file. Either run it from the terminal or just open the file from a file manager.

#### Install Unity from Unity Hub

<a href="/assets/unity/running-unity-hub.gif" target="_blank">
<img src="/assets/unity/running-unity-hub.gif" alt="Running Unity Hub" width="100%"/>
</a>

In the Installs section of Unity Hub application, you can choose a preferred version of Unity that you want to
install. Unity Hub will automatically download and install it for you. One can have several Unity versions installed. Unity Hub allows you to easily switch between those different versions of Unity.

Unity recommends that we use Unity Hub for creating, opening, and managing all the projects. So always use Unity Hub instead of directly running a specific Editor version which usually gets installed under ~/Unity/Hub/Editor/[Version]. You may create a shortcut to your UnityHub.AppImage file for convenience.

#### Unity Crash

If your Unity crashes, most probably your graphics driver is to blame.

If you have an Intel graphic card that is 2007 or newer, try uninstalling `xserver-xorg-video-intel`.
Your system will then default to use the builtin modesetting driver instead. 

~~~ bash
dpkg -l xserver-xorg-video-intel
sudo apt-get purge xserver-xorg-video-intel
~~~

If that still not fix your issue, try asking in the forums.

If it's not a known issue, you could always send a bug report by opening an issue in [Issue Tracker](https://issuetracker.unity3d.com/) and Unity team probably will get back to you.
