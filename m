Received: from mx1.redhat.com ([209.132.183.28]:51966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbdGJPGS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Jul 2017 11:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD7D361B83
        for <fstests@vger.kernel.org>; Mon, 10 Jul 2017 15:06:17 +0000 (UTC)
Date: Mon, 10 Jul 2017 17:06:12 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [WIP PATCH V2] Buffer resubmittion test
Message-ID: <20170710150612.ofjodvipik7wvpnu@eorzea.usersys.redhat.com>
References: <20170710133418.7083-1-cmaiolino@redhat.com>
 <20170710145522.GA17652@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710145522.GA17652@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

> 
> Thinking more about this, we could keep the sleep and also add the wait
> right before the unfreeze, right?

Well, depends, we still need to sleep there, an lvextend right after the freeze
won't give xfsaild enough time to run, so the problem won't be triggered, and
adding a wait right before unfreeze, seems pointless to me.
> 
> > Let me know your thoughts.
> > 
> > cheers.
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> 
> Mostly looks good to me. A few minor notes...
> 
> >  tests/xfs/999     | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/999.out |   2 +
> >  tests/xfs/group   |   1 +
> 
> The test is still under xfs (rather than generic).
> 

yup, didn't move it to generic yet. I have a question about it. How do we
specify which filesystem to run the test on without needing to mkfs the device
for the filesystem in question?


> >  3 files changed, 122 insertions(+)
> >  create mode 100755 tests/xfs/999
> >  create mode 100644 tests/xfs/999.out
> > 
> > diff --git a/tests/xfs/999 b/tests/xfs/999
> > new file mode 100755
> > index 0000000..b46f1cc
> > --- /dev/null
> > +++ b/tests/xfs/999
> > @@ -0,0 +1,119 @@
> > +#! /bin/bash
> > +# FS QA Test 999
> > +#
> > +# Test buffer resubmission after a failed writeback with to a full overcommited
> > +# dm-thin device.
> > +#
> > +# When a dm-thin device reaches its full capacity, but the virtual device still
> > +# shows available space, XFS loops indefinitely in xfsaild due items still in
> > +# AIL. The buffers containing such items couldn't be resubmitted because the
> > +# items were flush locked. Test the kernel fix and ensure the buffers are
> > +# properly resubmitted.
> > +#
> > +# This test will hang the filesystem when ran on an unpatched kernel
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Red Hat, Inc. All Rights Reserved.
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
> > +	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
> > +	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
> > +	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> 
> Is filter used anywhere?

Nope, the first thing I was doing was filtering dmesg for the IO errors before
extending the dm-thin device, and I forgot to remove the filter from here, I'll
remove it.

> 
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_scratch_nocheck
> > +_require_dm_target thin-pool
> > +_require_command $LVM_PROG lvm
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +vgname=vg_$seq
> > +lvname=lv_$seq
> > +poolname=pool_$seq
> > +snapname=snap_$seq
> > +origpsize=100
> > +virtsize=200
> > +newpsize=200
> > +
> > +# Ensure we have enough disk space
> > +_scratch_mkfs_sized $((250 * 1024 * 1024)) >>$seqres.full 2>&1
> > +
> > +# Create a 100MB dm-thin POOL
> > +$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
> > +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> > +
> > +$LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y \
> > +		    --zero n -L $origpsize \
> > +		    --poolmetadatasize 4M $vgname >>$seqres.full 2>&1
> > +
> > +# Create a overprovisioned 200MB dm-thin virt. device
> > +$LVM_PROG lvcreate  --virtualsize $virtsize \
> > +		    -T $vgname/$poolname \
> > +		    -n $lvname >>$seqres.full 2>&1
> > +
> > +_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> > +
> > +
> > +$LVM_PROG lvcreate  -k n -s $vgname/$lvname \
> > +		    -n $snapname >>$seqres.full 2>&1
> 
> What's the reason for using a snapshot? Is the original thin vol not
> sufficient?

No, it's not, honestly I don't remember now, exactly why not, I've been using
the snapshot in my internal test case since I started to work on this problem,
but without the snapshot I can't trigger the bug, at least not at a 100% rate.

> 
> > +
> > +_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT
> > +
> > +# Consume all space available in the volume and freeze to ensure everything
> > +# required to make the fs consistent is flushed to disk.
> > +xfs_io -f -d -c 'pwrite -b 1m 0 120m' $SCRATCH_MNT/f1 >>$seqres.full 2>&1
> 
> $XFS_IO_PROG

True, will change it

> 
> > +
> > +# This freeze will never complete until the dm-thin POOL device is extended.
> > +# This is expected, it is only used so xfsaild is triggered to flush AIL items.
> > +fsfreeze -f $SCRATCH_MNT &
> > +
> > +# Wait enough so xfsaild can run
> > +sleep 10
> > +
> > +# Make some extra space available so the freeze above can proceed
> > +lvextend -L $newpsize $vgname/$poolname >>$seqres.full 2>&1
> 
> $LVM_PROG lvmextend ?
> 
Indeed, missed it, will fix.

> Brian
> 
> > +
> > +# Try to thaw the filesystem, and complete test if if succeed.
> > +# NOTE: This will hang on affected XFS filesystems.
> > +fsfreeze -u $SCRATCH_MNT
> > +echo "Test OK"
> > +
> > +status=0
> > +exit
> > diff --git a/tests/xfs/999.out b/tests/xfs/999.out
> > new file mode 100644
> > index 0000000..8c3c938
> > --- /dev/null
> > +++ b/tests/xfs/999.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 999
> > +Test OK
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index 792161a..2bde916 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -416,3 +416,4 @@
> >  416 dangerous_fuzzers dangerous_scrub dangerous_repair
> >  417 dangerous_fuzzers dangerous_scrub dangerous_online_repair
> >  418 dangerous_fuzzers dangerous_scrub dangerous_repair
> > +999 dangerous
> > -- 
> > 2.9.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Carlos
