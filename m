Received: from mx1.redhat.com ([209.132.183.28]:57826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756497AbdGLL6O (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Jul 2017 07:58:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78068303142
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2017 11:58:13 +0000 (UTC)
Date: Wed, 12 Jul 2017 13:58:10 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] xfstests: Test filesystem lockup on full overprovisioned
 dm-thin
Message-ID: <20170712115810.ifjxf6e4qrlow5vx@eorzea.usersys.redhat.com>
References: <20170712080527.826-1-cmaiolino@redhat.com>
 <20170712091438.GA7015@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712091438.GA7015@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 12, 2017 at 05:14:38PM +0800, Eryu Guan wrote:
> On Wed, Jul 12, 2017 at 10:05:27AM +0200, Carlos Maiolino wrote:
> > With thin devices, it's possible to have a virtual device larger than
> > the physical device itself, and such situation can cause problems to
> > filesystems, once the filesystem 'believe' to have more space than it
> > actually has.
> > 
> > This can lead the filesystem to several weird behaviors. The one tested
> > here is filesystem lockup.
> > 
> > In case of XFS, it locks up when trying to writeback AIL metadata back
> > to the filesystem, but, once there is no physical space available, XFS
> > locks up and do not gracefuly handle this case.
> > 
> > Other filesystems usually are remounted as read-only, so they already
> > have this situation covered.
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> >  tests/generic/447     | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/447.out |   2 +
> >  tests/generic/group   |   1 +
> >  3 files changed, 149 insertions(+)
> >  create mode 100755 tests/generic/447
> >  create mode 100644 tests/generic/447.out
> > 
> > diff --git a/tests/generic/447 b/tests/generic/447
> > new file mode 100755
> > index 0000000..f1bb07d
> > --- /dev/null
> > +++ b/tests/generic/447
> > @@ -0,0 +1,146 @@
> > +#! /bin/bash
> > +# FS QA Test 424
> > +#
> > +# Test buffer filesystem error recovery during a full overcommited dm-thin device.
> > +#
> > +# When a dm-thin device reaches its full capacity, but the virtual device still
> > +# shows available space, the filesystem should be able to handle such cases
> > +# failing its operation without locking up.
> > +#
> > +# This test has been created first to cover a XFS problem where it loops
> > +# indefinitely in xfsaild due items still in AIL. The buffers containing such
> > +# items couldn't be resubmitted because the items were flush locked.
> > +# But, once this doesn't require any special filesystem feature to be executed,
> > +# this has been integrated as a generic test.
> > +#
> > +# This test might hang the filesystem when ran on an unpatched kernel
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
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch_nocheck
> 
> Better to have comments on why don't check fs consistency after test.
> 
I'd expect the test description at the beginning would be enough to understand
this is a test for checking lockups not consistency. But *shrug*, I can add it
here if it makes things more clear

> > +_require_dm_target thin-pool
> > +_require_command $LVM_PROG lvm
> 
> May need a "_require_freeze" rule here.

Sure, will add it to the next version.

> 
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
> 
> Sorry, I should've asked earlier in your RFC patch.. can all these setup
> work be done with helpers in common/dmthin? e.g. _dmthin_init,
> _dmthin_grow, the backing dev size, virtual size etc. are handled
> properly in dmthin helpers. You could take generic/347 as an example.
> 
> > +
> > +
> > +$LVM_PROG lvcreate  -k n -s $vgname/$lvname \
> > +		    -n $snapname >>$seqres.full 2>&1
> > +
> > +_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT
> > +
> > +# Consume all space available in the volume and freeze to ensure everything
> > +# required to make the fs consistent is flushed to disk.
> > +$XFS_IO_PROG -f -d -c 'pwrite -b 1m 0 120m' $SCRATCH_MNT/f1 >>$seqres.full 2>&1
> > +
> > +# In XFS, this freeze will never complete until the dm-thin POOL device is
> > +# extended. It is expected, and is only used so xfsaild is triggered to
> > +# flush AIL items, other filesystems usually get remounted as read-only during
> > +# the above write process.
> > +fsfreeze -f $SCRATCH_MNT >>$seqres.full 2>&1 &
> > +freezeid=$!
> > +
> > +# Wait enough so xfsaild can run
> > +sleep 10
> > +
> > +# Make some extra space available so the freeze above can proceed
> > +$LVM_PROG lvextend -L $newpsize $vgname/$poolname >>$seqres.full 2>&1
> > +
> > +wait -n $freezeid
> 
> Just "wait $freezeid", no '-n' is needed.
> 
> > +ret=$?
> > +
> > +
> > +# Different filesystems will handle the lack of real space in different ways,
> > +# some will remount the filesystem in read-only mode, some will not. These tests
> > +# will check if:
> > +#	- The filesystem turns into Read-Only and reject further writes
> > +#	- The filesystem stays in Read-Write mode, but can be frozen/thawed
> > +#	  without getting stuck.
> > +ISRO=$(_fs_options /dev/mapper/$vgname-$snapname | grep -w "ro")
> > +
> > +if [ $ret -ne 0 ]; then
> > +	if [ -n "$ISRO" ]; then
> > +		echo "Test OK"
> > +	else
> > +		echo "Freeze failed and FS isn't Read-Only. Test Failed"
> > +		status=1
> > +		exit
> > +	fi
> > +else
> > +	# Try to thaw the filesystem, and complete test if if succeed.
> > +	# NOTE: This will hang on affected XFS filesystems.
> > +	fsfreeze -u $SCRATCH_MNT >>$seqres.full 2>&1
> > +	echo "Test OK"
> > +fi
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/447.out b/tests/generic/447.out
> > new file mode 100644
> > index 0000000..3531fb9
> > --- /dev/null
> > +++ b/tests/generic/447.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 447
> > +Test OK
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 8c1e21a..6a360fa 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -449,3 +449,4 @@
> >  444 auto quick acl
> >  445 auto quick rw
> >  446 auto quick rw dangerous
> > +447 auto dangerous
> 
> Then I'll merge it only when the fix is upstream :)
> 
> Thanks,
> Eryu
> 
> > -- 
> > 2.9.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Carlos
