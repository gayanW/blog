---
layout: post
title:  "Recovering corrupted NTFS partitions in a Linux machine"
date:   2018-08-14 10:42:18 +0530
categories: linux 
---

#### What if my partition is not showing up or gone missing?

In that case, TestDisk could help. It is a disk utility designed to help people recover their lost partitions.

To install it, here in my case on Debian, I’ll do

    $ sudo apt-get install testdisk
    $ testdisk

TestDisk has a QUICK SEARCH option which can search and list all your missing partitions if there’s any. Most probably your missing partitions should have appeared by now. If not, try running a DEEPER SEARCH. Once it found any, use the WRITE option of TestDisk which will re-write the partition table for you.

Restart your computer and your missing partitions should now show up.

I won’t go into detail. For a more thorough guide, follow the [Step By Step guide][testdisk-step-by-step] from the official Wiki.

#### How to fix when my NTFS goes RAW?

It’s better to use Windows utilities when it comes to dealing with NTFS.

1. Boot into a Windows Recovery Disk.
2. Then go into 'System Recovery Options' menu.
3. Open the command prompt window.
4. Use one or more of the following commands to find out the label of your corrupted partition.

	~~~
	diskpart list disk
	diskpart select disk
	diskpart list volumes
	~~~

5. Once done exit from diskpart and run

	~~~
	chkdsk /f /r D:
	where D: is the drive letter of the corrupted partition. 
	~~~

If you have got better solutions, let us know in the comment section.

[testdisk-step-by-step]: https://www.cgsecurity.org/wiki/TestDisk_Step_By_Step
