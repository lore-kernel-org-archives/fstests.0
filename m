Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7826 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbaEWDRy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 May 2014 23:17:54 -0400
Date: Fri, 23 May 2014 11:17:48 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/005: filter _scratch_mount output and fix golden
 output to match it
Message-ID: <20140523031748.GU18962@dhcp-13-216.nay.redhat.com>
References: <1400775429-30015-1-git-send-email-eguan@redhat.com>
 <20140522233449.GN18954@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140522233449.GN18954@dastard>
Sender: xfstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, May 23, 2014 at 09:34:49AM +1000, Dave Chinner wrote:
> On Fri, May 23, 2014 at 12:17:09AM +0800, Eryu Guan wrote:
> > Failure message of _scratch_mount is something like:
> > 
> > mount: mount /dev/sda5 on /mnt/scratch failed: Structure needs cleaning
> > 
> > not
> > 
> > mount: Structure needs cleaning
> 
> Evidence to the contrary:
> 
> # MKFS_OPTIONS="-b size=1024 -m crc=1"  ./check xfs/005
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 test1 3.15.0-rc5-dgc+
> MKFS_OPTIONS  -- -f -b size=1024 -m crc=1 /dev/vdb
> MOUNT_OPTIONS -- /dev/vdb /mnt/scratch
> 
> xfs/005 0s ... 0s
> Ran: xfs/005
> Passed all 1 tests
> 
> # mount /dev/vdb /mnt/scratch
> mount: Structure needs cleaning
> # mount -V
> mount from util-linux 2.20.1 (with libblkid and selinux support)
> #
> 
> So xfs/005 is correct for a relatively recent mount binary.
> What version of mount are you using?

I'm using util-linux 2.23
# mount -V
mount from util-linux 2.23.2 (libmount 2.23.0: selinux, debug, assert)

I looked into the util-linux git history, the new output has been
added to mount since v2.21-rc1~41, via commit ce433404.

So probably the output should be filtered to remove the device and
mount point info. I'll send a v2.

Thanks for the review!

Eryu
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> _______________________________________________
> xfs mailing list
> xfs@oss.sgi.com
> http://oss.sgi.com/mailman/listinfo/xfs
