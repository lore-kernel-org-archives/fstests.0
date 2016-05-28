Received: from mx1.redhat.com ([209.132.183.28]:44873 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbcE1Q42 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 28 May 2016 12:56:28 -0400
Date: Sun, 29 May 2016 00:56:26 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH 2/2] xfs/006: new case to test xfs fail_at_unmount error
 handling
Message-ID: <20160528165626.GC5507@dhcp12-143.nay.redhat.com>
References: <1464362482-7704-1-git-send-email-zlang@redhat.com>
 <1464362482-7704-2-git-send-email-zlang@redhat.com>
 <c2b9bb3e-6d2c-078e-fbe1-e7c38d40316c@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b9bb3e-6d2c-078e-fbe1-e7c38d40316c@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 27, 2016 at 01:26:35PM -0500, Eric Sandeen wrote:
> On 5/27/16 10:21 AM, Zorro Lang wrote:
> > XFS bring in a new configuration under /sys/fs/xfs/error, named
> > fail_at_unmount. It's used to stop unmount retrying forever when
> > it hit IO error.
> > 
> > This case try to unmount an faulty dm device, and to sure unmount
> > won't retry forever if fail_at_unmount=1.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > Thanks Carlos told this easy way(use dm error) to test this feature, or
> > I will try to use dm thinp to reproduce unmount hit an ENOSPC error. That's
> > more difficult to do.
> 
> right, different errors from dm_thinp.
> 
> But I think my simple dm_thinp test and the infrastructure it uses
> should make this easy?  It was merged recently.

Yeah, those dmthin functions looks fine for me, I haven't use them(maybe
use them soon).

I said use dmthin is "more difficult", not means use your functions is difficult,
I mean use dmthin to test this "retry forever" issue is difficult. Because
if use dmthinp, I should make sure when I do unmount, there're some journal have
been recorded, but the data haven't be writeback. So when unmount try to flush
these data, it will hit ENOSPC. right?

I think it's too difficult to create this situation.

But if use dmerror, it's easy to make unmount hit EIO error.

Thanks,
Zorro

> 
> > I haven't gotten some good ideas to test those /sys/fs/xfs/dm-X/error/
> > metadata/... configurations. If someone have good ideas, please let me
> > know:)
> > 
> > Thanks,
> > Zorro
> > 
> >  tests/xfs/006     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/006.out |  2 ++
> >  tests/xfs/group   |  1 +
> >  3 files changed, 83 insertions(+)
> >  create mode 100755 tests/xfs/006
> >  create mode 100644 tests/xfs/006.out
> > 
> > diff --git a/tests/xfs/006 b/tests/xfs/006
> > new file mode 100755
> > index 0000000..dafab50
> > --- /dev/null
> > +++ b/tests/xfs/006
> > @@ -0,0 +1,80 @@
> > +#! /bin/bash
> > +# FS QA Test 006
> > +#
> > +# Test xfs' "fail at unmount" error handling configuration. Stop
> > +# XFS retrying to writeback forever when unmount.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2016 YOUR NAME HERE.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/dmerror
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_dm_target error
> > +_require_scratch
> > +_require_scratch_sys_fs error/fail_at_unmount
> > +
> > +# Format and mount
> > +# The device is still a linear device at here
> > +_scratch_mkfs > $seqres.full 2>&1
> 
> I guess my earlier suggestion was to not mkfs inside the
> _require function for sysfs, so maybe move the test here:
> 
> _require_fs_sys_fs $SCRATCH_DEV error/fail_at_unmount

hmm... I think generally we do _require_* test before do real test.

But do _require_* test after mkfs is still better than after mount:)

> 
> > +_dmerror_init
> > +_dmerror_mount
> > +
> > +# Enable fail_at_unmount
> > +_enable_xfs_fail_at_unmount $DMERROR_DEV
> 
> _set_fs_sys_fs_param $DMERROR_DEV error/fail_at_unmount 1

Sure

Thanks again for your review,
Zorro

> 
> > +
> > +# make some IO at here. If these data still not writeback from
> > +# journal to data, it will hit writeback error after load error
> > +# tabel in next step.
> > +_pwrite_byte 0x61 0 100M $SCRATCH_MNT/file >/dev/null
> > +_dmerror_load_error_table
> > +
> > +# Even above data already all writeback, umount will cause XFS
> > +# try to writeback something to root inode. It still can trigger
> > +# umount fail.
> > +_dmerror_unmount
> > +
> > +echo "Silence is golden"
> > +_dmerror_cleanup
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/006.out b/tests/xfs/006.out
> > new file mode 100644
> > index 0000000..675c1b7
> > --- /dev/null
> > +++ b/tests/xfs/006.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 006
> > +Silence is golden
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index f4c6816..39169ea 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -4,6 +4,7 @@
> >  004 db auto quick
> >  005 auto quick
> >  007 auto quota quick
> > +006 auto quick unmount
> >  008 rw ioctl auto quick
> >  009 rw ioctl auto prealloc quick
> >  010 auto quick repair
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
