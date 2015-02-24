Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:64690 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281AbbBXHUn (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Feb 2015 02:20:43 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YQ9nM-00033r-Pu
	for fstests@vger.kernel.org; Tue, 24 Feb 2015 18:20:40 +1100
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YQ9nM-0000rF-OX
	for fstests@vger.kernel.org; Tue, 24 Feb 2015 18:20:40 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/4] fstests: sector size fixes and whiteouts...
Date: Tue, 24 Feb 2015 18:20:31 +1100
Message-Id: <1424762435-3237-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

The first 2 patches are fallout from a kernel change in 4.0-rc1
which changes the physical block size of a ram disk (/dev/ram0) from
512 bytes to 4kB. This bit several tests because it means mkfs.xfs
generates different geometry and so has different output.

The third patch addresses another new issue - it appears that loop
device tardown is much faster than it's ever been and so it
triggering races with unmount trying to tear down it down. unmount
is being a sore loser and so tests are failing randomly.

The final patch is a test for RENAME_WHITEOUT. I have no idea if it
encodes correct behaviour because the behaviour is completely
undocumented. So I've simply made a test that exercises ext4's
behaviour and I'm using that to verify the new XFS code matches the
same userspace visible behaviour as ext4.

-Dave.
