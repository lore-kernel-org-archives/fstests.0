Received: from mx1.redhat.com ([209.132.183.28]:48840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbcHZHOY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 Aug 2016 03:14:24 -0400
Date: Fri, 26 Aug 2016 15:13:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [GIT PULL] fstests: updates on 2016-08-20
Message-ID: <20160826071340.GZ27776@eguan.usersys.redhat.com>
References: <201608201444.u7KEi22g015351@int-mx14.intmail.prod.int.phx2.redhat.com>
 <20160826045115.GP22388@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826045115.GP22388@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 26, 2016 at 02:51:15PM +1000, Dave Chinner wrote:
> On Sat, Aug 20, 2016 at 10:44:01PM +0800, Eryu Guan wrote:
> > Eric Sandeen (2):
> >       xfs: test xfs_quota "state" command
> 
> This test hard codes inode numbers in the golden output. Fails the
> moment you change the mkfs parameters away from the default. e.g.
> enable rmapbt=1:
> 
> xfs/263  - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_1k/xfs/263.out.bad)
>     --- tests/xfs/263.out       2016-08-23 16:55:38.026707187 +1000
>     +++ /home/dave/src/xfstests-dev/results//xfs_1k/xfs/263.out.bad     2016-08-26 11:13:06.533209472 +1000
>     @@ -5,15 +5,15 @@
>      User quota state on SCRATCH_MNT (SCRATCH_DEV)
>        Accounting: ON
>        Enforcement: ON
>     -  Inode: #131 (1 blocks, 1 extents)
>     +  Inode: #195 (1 blocks, 1 extents)
>      Group quota state on SCRATCH_MNT (SCRATCH_DEV)
>        Accounting: OFF
>     ...
>     (Run 'diff -u tests/xfs/263.out /home/dave/src/xfstests-dev/results//xfs_1k/xfs/263.out.bad'  to see the entire diff)

I noticed the hard-coded inode numbers too at review time, but I saw
that the mkfs options were hard-coded as well, so I think the inode
numbers wouldn't change too.

As stated in the commit log, xfs/263 requires patches to the upstream
kernel ("quota: fill in Q_XGETQSTAT inode information for inactive
quotas") and to xfsprogs ("xfs_quota: wire up XFS_GETQSTATV") to pass.

I just tested xfs/263 with rmapbt enabled, with latest xfsprogs you just
updated (which contains commit bb92709 "xfs_quota: wire up
XFS_GETQSTATV") and 4.8-rc3 kernel + kernel patch "quota: fill in
Q_XGETQSTAT inode information for inactive quotas" from Eric, and test
passed without problems. Perhaps you need that kernel patch to make it
pass?

But I agree that it'd better to filter the inode numbers to avoid future
changes to golden image. Should I drop it for now or we can fix it later
with a follow-up patch?

Thanks,
Eryu
