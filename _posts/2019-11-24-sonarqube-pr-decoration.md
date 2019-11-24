---
layout: post
title:  "SonarQube Pull Request Decoration"
date:   2019-11-24 11:00:18 +0530
categories: jekyll update
---

#### Pull request decoration did not happen

If you got this warning I recommend that you first enable debug logs on your SonarQube server. Then perform a pull request analysis again while inspecting the [ce.log](https://docs.sonarqube.org/latest/instance-administration/system-info/#header-2).

	tail --follow sonar-dir/logs/ce.log

If you see these warnings, most probably the system clock of your server is to blame.

>GET response did not have expected HTTP code (was 401): {“message”:"‘Issued at’ claim (‘iat’) must be an Integer representing the time that the assertion was issued",“documentation_url”:“https://developer.github.com/enterprise/2.18/v3”}

>Pull request decoration did not happen. Please install SonarQube Github application on the repository’s organization or user.


To synchronize a system clock to real time, the most recommended solution is to install is chrony.

	sudo apt install chrony
	sudo systemctl restart chrony.service

If using a RHEL based distro, run:

	yum install chrony
	systemctl start chronyd

To check whether there is an actual time drift, issue the following command

	$ chronyc tracking
	Reference ID    : A9FEA97B (169.254.169.123)
	Stratum         : 4
	Ref time (UTC)  : Sun Nov 24 15:45:37 2019
	System time     : 46.211318970 seconds fast of NTP time
	Last offset     : -0.000026256 seconds
	RMS offset      : 0.002788091 seconds
	Frequency       : 41.560 ppm fast
	Residual freq   : -0.005 ppm
	Skew            : 5.294 ppm
	Root delay      : 0.000519169 seconds
	Root dispersion : 0.000747741 seconds
	Update interval : 71.3 seconds
	Leap status     : Normal


As you could see from the output, my System time was drifted by about 46 seconds. If there is a time drift, chrony will automatically adjust the clock gradually. You can verify that by issuing `$ chronyc tracking` command and observing the `System time` line of the output. Once the 'System time' property is driven closer to zero, you could try re-running a PR analysis and PR decoration should work fine.
