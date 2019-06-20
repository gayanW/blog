---
layout: post
title:  "Install Windows after Ubuntu/Linux"
date:   2017-10-11 11:00:18 +0530
categories: jekyll update
---
As you know, the most common, and probably the most recommended way of dual booting Ubuntu and Windows is to install Windows first and then Ubuntu. But what if you want to install Windows second on a computer with Ubuntu/Linux already installed?

This guide assumes that you have Ubuntu already installed on your system, and will guide you through installing Windows 7/8/8.1/10 when you have a working Ubuntu/Linux partition.

The problem here is that the Windows installer tends to overwrite Grub bootloader or whatever making only the Windows installation bootable. But the good news is that your Linux partition is untouched, including the original bootloader and the other Grub configurations. So restoring or recovering Grub is just a matter of running a few commands on the terminal.

#### Install Windows on a Separate Partition

If your Ubuntu installation occupies the entire hard drive, to be able to create free space for the Windows installation, you may have to shrink an existing partition using a disk utility like GParted. GParted comes preinstalled on Ubuntu LiveCD.

#### Boot into a Windows installation media and complete the installation

Once installed, because of Microsoft’s false assumption that there are no non-Microsoft operating systems you’ll be taken straight into Windows.

#### Restore / Reinstall Grub 2 with a Ubuntu Live Media

1. Now boot into a Ubuntu Live/USB or CD.
2. Open a terminal. (Ctrl + Alt + t)
3. Use a command like lsblk, blkid or GParted to identify your Linux root, and boot partitions. You may or may not have a separate boot partition.
4. Find Linux Partitions

	~~~
	$ lsblk -f
	NAME                  FSTYPE     MOUNTPOINT
	sda                                                                            
	├─sda1                ext4       /boot
	├─sda2                ext4       /
	├─sda3                ntfs       
	~~~

	In my case,

	  `/dev/sda1` is the Linux boot partition

	  `/dev/sda2` is the Linux root partition

	  `/dev/sda3` is the Windows partition


5. Setup a Chroot Environment

	Now we’ll be repairing our old grub bootloader in a chroot environment.

	Mount your root filesystem under `/mnt`

	    sudo mount /dev/sda2 /mnt/

	> If you’re using BTRFS (New Linux B-Tree File System) instead of EXT4, the above command should change to 
	> sudo mount -t btrfs -o subvol=@ /dev/sda2 /mnt/

	Run `ls /mnt` to verify that the correct partition is mounted. It should list the content of your root.

	~~~
	$ ls /mnt
	bin   dev  home        lib64       media  opt   root  sbin  sys  usr  vmlinuz
	boot  etc  initrd.img  lost+found  mnt    proc  run   srv   tmp  var  vmlinuz.old
	~~~


	Mount the boot partition. (SKIP if you don’t have a separate boot partition)

	    sudo mount /dev/sda1 /mnt/boot

	If you have an EFI partition you should mount that also. It is basically a small FAT32 partition around 100mb. Please refer to the section on how to [reinstall Grub in an EFI system](#reinstalling-grub-in-an-efi-based-system).

	Bind these directories, so grub can detect other operating systems, like so. 

	~~~ bash
	sudo mount --bind /dev /mnt/dev
	sudo mount --bind /dev/pts /mnt/dev/pts
	sudo mount --bind /proc /mnt/proc
	sudo mount --bind /sys /mnt/sys
	~~~

	Let's chroot into our existing Ubuntu/Linux system on the hard disk.

	    sudo chroot /mnt

6. Reinstall Grub.

	~~~ bash
	grub-install /dev/sda (specify the disk `/dev/sdX`, not `/dev/sdaX`)
	grub-install --recheck /dev/sda
	exit
	~~~

	Once you've successfully reinstalled Grub, restart the computer. On next reboot Grub will be the default bootloader and you’ll be presented with a list of operating systems to choose from (Ubuntu and Windows, of course).

#### Reinstalling Grub in an EFI Based System

Reinstalling Grub bootloader in a UEFI based computer is no different from installing Grub on a legacy BIOS system. Here we also mount the EFI partition before chrooting, as we’d do with the boot partition.

##### Case #2

~~~
$ lsblk -f
NAME                  FSTYPE     MOUNTPOINT
sda                                                                            
├─sda1                ext4       /boot/efi
├─sda2                ext4       /
├─sda3                ntfs       
~~~

Here `/dev/sda1` is the EFI partition and `/dev/sda2` is the root.

    sudo mount /dev/sda2 /mnt/

Mount EFI partition under ‘/mnt/boot/efi’

    sudo mount /dev/sda1 /mnt/boot/efi

> Forgetting to do so will result in errors being thrown while trying to execute grub-install: “/boot/efi does not appear to be the EFI partition”

As shown previously, bind the `/dev`, `/dev/pts`, `/proc`, and `/sys` directories.

Finally,

~~~ bash
sudo chroot /mnt
grub-install
exit
~~~

In some rare occasions, Grub might not detect Windows. In that case just login to Ubuntu (installed one on the disk, not the bootable Live USB/CD) and execute,

~~~ bash
sudo os-prober
sudo update-grub
sudo reboot
~~~

Happy Dual-Booting!
