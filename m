Received: from aserp1040.oracle.com ([141.146.126.69]:22507 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbdKBSiJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Nov 2017 14:38:09 -0400
Date: Thu, 2 Nov 2017 11:38:02 -0700
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH] fstests: btrfs: add test case for raid6 reconstruction
 bug
Message-ID: <20171102183802.GA30812@dhcp-10-11-181-183.us.oracle.com>
Reply-To: bo.li.liu@oracle.com
References: <20171102000123.25595-1-bo.li.liu@oracle.com>
 <20171102154952.GB17339@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102154952.GB17339@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 02, 2017 at 11:49:52PM +0800, Eryu Guan wrote:
> On Wed, Nov 01, 2017 at 06:01:23PM -0600, Liu Bo wrote:
> > This is to reproduce a raid6 reconstruction bug after two drives
> > getting offline and online via hotplug.
> > 
> > Signed-off-by: James Alandt <James.Alandt@wdc.com>
> > Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> 
> I don't have 5 deletable pool devices to actually test this patch, but
> just comment issues I can see from the code.
>

In fact only two devices will be deleted.

> > ---
> >  tests/btrfs/152   | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/group |   1 +
> >  2 files changed, 122 insertions(+)
> >  create mode 100755 tests/btrfs/152
> > 
> > diff --git a/tests/btrfs/152 b/tests/btrfs/152
> > new file mode 100755
> > index 0000000..2b3d98c
> > --- /dev/null
> > +++ b/tests/btrfs/152
> > @@ -0,0 +1,121 @@
> > +#! /bin/bash
> > +# FS QA Test 152
> > +#
> > +# This test is to reproduce a bug of btrfs raid6 reconstruction.
> 
> Better to provide more information about the bug and how would you like
> to test it, it helps others to understand the bug and test, also it will
> be helpful to debug test failure if it fails, say 5 years later.
> 
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Oracle.  All Rights Reserved.
> > +# Author: Liu Bo <bo.li.liu@oracle.com>
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
> > +	if [ $removed == 1 ]; then
> 	     $removed -eq 1 looks better
> 
> > +		_scratch_umount
> > +		_devmgt_add ${disk1_remove}
> > +		_devmgt_add ${disk2_remove}
> > +	fi
> 
> Better to initialize all the variables used here before _cleanup.
> 
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_scratch
> > +_require_scratch_nocheck
> 
> Above two _requires are not needed.
> 
> > +_require_scratch_dev_pool 5
> 
> Because you have this one.

OK, good to know it.

> 
> > +_require_deletable_scratch_dev_pool
> > +
> > +# umount test so that we can unload btrfs module
> > +_test_unmount
> > +_require_btrfs_loadable
> 
> Perhaps you can take use of the new helpers introduced by Darrick's
> pending patch "fstests: add module reloading helpers" (you can find the
> patch in list), and with new helpers you don't have to umount test dev
> before "_require_loadable_fs_module btrfs", which will be the
> replacement of _require_btrfs_loadable.
>

That'd be a perfect fit here.

> > +
> > +_scratch_dev_pool_get 5
> > +
> > +devs=( $SCRATCH_DEV_POOL )
> > +n=${#devs[@]}
> > +
> > +mkfs_opts="-draid6 -mraid6 -n64K -b 1G"
> > +_scratch_pool_mkfs $mkfs_opts >> $seqres.full 2>&1
> > +
> > +_scratch_mount -o nospace_cache
> 
> Please comment any non-obvious & non-default mkfs/mount options like
> -n64k, -o nospace_cache :)
>

OK.

> > +
> > +# 1st 4k write
> > +$XFS_IO_PROG -f -c "pwrite -W 0 4K" $SCRATCH_MNT/f1 | _filter_xfs_io
> > +sync
> 
> No need to sync with "-W" pwrite.
>

OK, I need to keep sync to commit a transaction, so I'll remove '-W'
instead.

> > +
> > +# hotplug disk1
> > +disk1=${devs[$((n-1))]}
> > +disk1_short=`_short_dev ${disk1}`
> > +disk1_remove=`readlink -f /sys/block/${disk1_short} | rev | cut -d "/" -f 3 | rev`
> 
> Factor this into a common function? I see similar code in btrfs/003 to
> do the same task.
>

OK.

> > +_devmgt_remove ${disk1_remove} $disk1_short
> > +removed=1
> > +
> > +# 2nd 4K write
> > +$XFS_IO_PROG -f -c "pwrite -W 0 4K" $SCRATCH_MNT/f2 | _filter_xfs_io
> > +sync
> 
> Same here (and other places below), sync not needed.
> 
> > +
> > +# hotplug disk2
> > +disk2=${devs[$((n-2))]}
> > +disk2_short=`_short_dev ${disk2}`
> > +disk2_remove=`readlink -f /sys/block/${disk2_short} | rev | cut -d "/" -f 3 | rev`
> > +_devmgt_remove ${disk2_remove} $disk2_short
> > +removed=1
> > +
> > +# 3rd 4K write
> > +$XFS_IO_PROG -f -c "pwrite -W 0 4K" $SCRATCH_MNT/f3 | _filter_xfs_io
> > +sync
> > +
> > +_scratch_unmount
> > +
> > +# bring disk1 & disk2 online
> > +_devmgt_add ${disk1_remove}
> > +_devmgt_add ${disk2_remove}
> > +removed=0
> > +
> > +# reload the module to simulate 'reboot'
> > +_reload_btrfs_ko
> 
> With the new helper, this should be "_reload_fs_module btrfs"
> 
> > +
> > +# have every disk available for btrfs
> > +btrfs dev scan
> 
> $BTRFS_UTIL_PROG device scan
> 
> Use full btrfs command name, e.g. dev->device, subvol->subvolume.
>

OK.

> > +
> > +_scratch_mount -onospace_cache,degraded || _fail "mount -onospace_cache,degraded failed"
> 
> If we _fail here then we skip _scratch_dev_pool_put. So just print out a
> message to break the golden output.
>

Make sense, thanks a lot for all the comments.

Thanks,

-liubo

> Thanks,
> Eryu
> 
> > +
> > +_scratch_dev_pool_put
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index a7ff7b0..1dbb66f 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -154,3 +154,4 @@
> >  149 auto quick send compress
> >  150 auto quick dangerous
> >  151 auto quick
> > +152 auto quick
> > -- 
> > 2.5.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
`
