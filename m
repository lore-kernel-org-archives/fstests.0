Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:23595 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757430AbcBDXPX (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 4 Feb 2016 18:15:23 -0500
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/2 v2] xfs_quota: allow operation on ext4 for project quotas
Date: Fri,  5 Feb 2016 10:15:16 +1100
Message-Id: <1454627718-19583-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

This is a followup to the patch I posted here:

http://oss.sgi.com/archives/xfs/2016-01/msg00450.html

The first patch is changed to address Eric's comments about how the
report command should not change - I introduced a "-f" command line
flag to ensure that foreign filesystems are only available whenteh
-f flag is present.

The second patch is to address the build issue that occurs from the
newly promoted definitions defining the struct fsxattr and having
xfs_fs.h define it a second time. We have to still support builds on
systems that don't have the new VFS ioctl definitions, so it
triggers the definitions of the structure and flags based on whether
the VFS definition has been included or not already.

-Dave.

