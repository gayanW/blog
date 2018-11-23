---
layout: post
title:  "Fixing JHBuild Errors"
date:   2018-08-14 10:42:18 +0530
categories: linux 
---
**Fixing no native package found errors**

JHBuild uses apt-file to locate packages in which a given file belongs to.

When apt-file cannot locate the relevant packages for you, JHBuild would give you with informational warnings such as:

    I: Installing dependencies on system: libsystemd-journal libtiff
    I: Using apt-file to search for providers; this may be slow. Please wait.
    I: No native package found for libsystemd-journal (/libsystemd-journal.pc)
    I: No native package found for libtiff (/usr/include/tiff.h)

In such cases, first make sure that your apt-file database is up-to-date.

    sudo apt-file update

Then re-run the process. JHBuild might still fails to complete the process. This could be due to several reasons. So for instance if apt-file finds several packages which includes the same file, JHBuild would fail to decide on which package to install. In that case we'd have to find the most appropriate pacakge and install it manaully. Also the actual package name can be sligtly different from the name stated in the warning.

To find the relevant package which includes the given file, you could run:

    apt-file search path/to/missing.file

You could also use Ubuntu's package archive search on web, instead of apt-file. But apt-file usually is more convenient.

1. Go to packages.ubuntu.com
2. Search the contents of packages which include the missing file.
3. Find the relevant package for your distribution and install it.

For example here the missing libsystemd.pc belongs to the package named 'libsystemd-dev'

Therefore running `apt-get install libsystemd-dev` should fix it.

**Fixing No matching system package installed**

This type of errors can be quite tricky as your distribution might not have a package that is newer than the required version.

Example cases:

    libsystemd-journal (libsystemd-journal.pc, required=201)

Ubuntu’s Launchpad provides compatibility package for libsystemd-journal-dev (>201) which includes the required .pc file. Downloading and installing latest binary .deb file for your distribution should fix it.

**Fixing configure errors: Package requirements (package-name) were not met**

In that case do,

    apt-cache search package-name

This will list down all the packages for the given keyword: package-name

Find the required development package from the list and install it.
On a Debian based system the package name would probably contain a *-dev suffix. For Fedora, look for ‘-devel’

For example to fix *"configure: error: Package requirements (libselinux >= 2.0) were not met"*

Run the following in a terminal

    apt-cache search libselinux

On my system the output is,

    libselinux1 - SELinux runtime shared libraries
    libselinux1-dev - SELinux development headers
    libsemanage1 - SELinux policy management library

So installing ‘libselinux1-dev’ should fix the configure error.

    apt-get install libselinux1-dev
