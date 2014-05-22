Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:14724 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288AbaEVXew (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 22 May 2014 19:34:52 -0400
Date: Fri, 23 May 2014 09:34:49 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/005: filter _scratch_mount output and fix golden
 output to match it
Message-ID: <20140522233449.GN18954@dastard>
References: <1400775429-30015-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400775429-30015-1-git-send-email-eguan@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, May 23, 2014 at 12:17:09AM +0800, Eryu Guan wrote:
> Failure message of _scratch_mount is something like:
> 
> mount: mount /dev/sda5 on /mnt/scratch failed: Structure needs cleaning
> 
> not
> 
> mount: Structure needs cleaning

Evidence to the contrary:

# MKFS_OPTIONS="-b size=1024 -m crc=1"  ./check xfs/005
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test1 3.15.0-rc5-dgc+
MKFS_OPTIONS  -- -f -b size=1024 -m crc=1 /dev/vdb
MOUNT_OPTIONS -- /dev/vdb /mnt/scratch

xfs/005 0s ... 0s
Ran: xfs/005
Passed all 1 tests

# mount /dev/vdb /mnt/scratch
mount: Structure needs cleaning
# mount -V
mount from util-linux 2.20.1 (with libblkid and selinux support)
#

So xfs/005 is correct for a relatively recent mount binary.
What version of mount are you using?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
