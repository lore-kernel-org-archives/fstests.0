Received: from mx1.redhat.com ([209.132.183.28]:41824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166973AbdDXInw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Apr 2017 04:43:52 -0400
Date: Mon, 24 Apr 2017 16:43:39 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] ext4: check mount's handling for very large
 s_first_meta_bg
Message-ID: <20170424084339.GL26397@eguan.usersys.redhat.com>
References: <1492769440-12413-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170424044717.GK26397@eguan.usersys.redhat.com>
 <58FD929A.4040008@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58FD929A.4040008@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 24, 2017 at 01:52:26PM +0800, Xiao Yang wrote:

> > > +_require_command "$DEBUGFS_PROG" debugfs
> > > +_require_ext4_mkfs_feature "bigalloc,meta_bg,^resize_inode"
> > > +
> > > +echo "Create ext4 fs and modify first_meta_bg's value"
> > > +$MKFS_EXT4_PROG -F -b 4096 -O bigalloc,meta_bg,^resize_inode $SCRATCH_DEV 16m>>  $seqres.full 2>&1 \
> > > +	|| _notrun "Could not create ext4 filesystem"
> > _scratch_mkfs "-O bigalloc,meta_bg,^resize_inode">>  $seqres.full 2>&1
> > 
> > should be fine, if there're conflicts between MKFS_OPTIONS and these
> > extra mkfs options _scratch_mkfs will mkfs again only with test-provided
> > mkfs options.
> > 
> I will use _scratch_mkfs as you said.  However, i still specify 4096 as
> block size, because debugfs can't set first_meta_bg
> to 842150400 on RHEL7 when default block size is 1024.   Please see the
> following e2fsprogs bug:
> 
> commit d36b957b345ee6e4b529be99b8fdc8d3e70ccdc1
> Author: Darrick J. Wong <darrick.wong@oracle.com>
> Date:   Sat Jan 11 13:58:15 2014 -0500
> 
>     libext2fs: don't always read backup group descriptors on a 1k-block
> meta_bg fs

I noticed this too, debugfs failed to open ext4 fs when block size is 1k
when testing on my rhel7 host. But I think what should be done is fixing
e2fsprogs on RHEL7 not workarounding the bug in the test code. The test
is doing nothing wrong, and it 'finds' a bug (test not run).

This leads me to wonder if we should skip this test if debugfs hanppened
to fail to set first_meta_bg? So that test would fail explicitly (mount
succeeds unexpectedly) instead of _notrun and being ignored.

Thanks,
Eryu
