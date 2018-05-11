Received: from mail-pl0-f51.google.com ([209.85.160.51]:41515 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeEKDEp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 May 2018 23:04:45 -0400
Received: by mail-pl0-f51.google.com with SMTP id az12-v6so2439201plb.8
        for <fstests@vger.kernel.org>; Thu, 10 May 2018 20:04:45 -0700 (PDT)
Date: Fri, 11 May 2018 11:04:41 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH V2] xfs: test inobt/on disk free state mismatches
Message-ID: <20180511030441.GM8373@desktop>
References: <20180506225352.4415-1-david@fromorbit.com>
 <20180507230551.GJ10363@dastard>
 <20180508005515.GH8373@desktop>
 <20180510230449.GT10363@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510230449.GT10363@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 11, 2018 at 09:04:49AM +1000, Dave Chinner wrote:
> On Tue, May 08, 2018 at 08:55:15AM +0800, Eryu Guan wrote:
> > On Tue, May 08, 2018 at 09:05:51AM +1000, Dave Chinner wrote:
> > > 
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Fuzzing has recently uncovered a couple of conditions where we don't
> > > detect corruptions that reallocate already allocated inodes. This
> > > test exercises those cases, and checks that we shut down the
> > > filesystem appropriately when such a corruption occurs.
> > > 
> > > Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> > > ---
> > > V2:
> > > - fix method of calling xfs_db to use correct helpers.
> > > 
> > >  tests/{shared/003 => xfs/450} | 41 ++++++++++++++++++++++-------------------
> > >  tests/xfs/450.out             | 26 ++++++++++++++++++++++++++
> > >  tests/xfs/group               |  1 +
> > 
> > Messed up with shared/003?
> 
> No. That's just git being smart with it's diffs:
> 
> > >  3 files changed, 49 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/tests/shared/003 b/tests/xfs/450
> > > similarity index 59%
> > > copy from tests/shared/003
> > > copy to tests/xfs/450
> 
> It's copying and then patching, rather than just creating a whole
> new file.

Ah, right.

> 
> 
> > > index 9a9956cf44de..267089738574 100755
> > > --- a/tests/shared/003
> > > +++ b/tests/xfs/450
> > > @@ -1,15 +1,10 @@
> > >  #! /bin/bash
> > > -# FS QA Test 003
> > > +# FS QA Test 450
> > >  #
> > > -# Test mount a needs_recovery partition with noload option.
> > > -# ext4 used to Oops until part of this commit:
> > > -#
> > > -# 744692d ext4: use ext4_get_block_write in buffer write
> > > -#
> > > -# Also test on ext2/3.
> > > +# Catch inobt/on disk inode free state mismatches on V4 filesystems
> > >  #
> > >  #-----------------------------------------------------------------------
> > > -# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
> > > +# Copyright (c) 2018 Red Hat, Inc.  All Rights Reserved.
> > >  #
> > >  # This program is free software; you can redistribute it and/or
> > >  # modify it under the terms of the GNU General Public License as
> > > @@ -45,25 +40,33 @@ _cleanup()
> > >  . ./common/rc
> > >  . ./common/filter
> > >  
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > >  # real QA test starts here
> > > -_supported_fs ext2 ext3 ext4
> > > +
> > > +_supported_fs xfs
> > >  _supported_os Linux
> > >  
> > > -# nofsck as we modify sb via debugfs
> > > +# we intentionally corrupt the filesystem, so don't check it after the test
> > >  _require_scratch_nocheck
> > >  
> > > -# remove previous $seqres.full before test
> > > -rm -f $seqres.full
> > > -echo "Silence is golden"
> > > +# on success, we'll get a shutdown filesystem with a really noisy log message
> > > +# due to transaction cancellation.  Hence we don't want to check dmesg here.
> > > +_disable_dmesg_check
> > > +
> > > +_require_xfs_mkfs_crc
> > > +_scratch_mkfs -m crc=0 > $seqres.full 2>&1
> > 
> > Looks like we can drop _require_xfs_mkfs_crc anyway, as
> > _scratch_mkfs_xfs will remove any metadata options if the mkfs.xfs
> > binary doesn't support it (done by _scratch_mkfs_xfs_opts).
> 
> /me wonders how _scratch_mkfs_xfs_opts() gets user mkfs parameters
> passed to it to filter as _scratch_mkfs_xfs() doesn't pass any user
> parameters to it....

I turns out that I broke it in commit 596a068bf130 ("fstests: teach
_scratch_mkfs to handle mkfs option conflicts"), I forgot to pass extra
mkfs parameters to _scratch_mkfs_xfs_opts(). I'll send a fix soon.

Thanks,
Eryu

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
