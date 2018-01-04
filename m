Received: from userp2120.oracle.com ([156.151.31.85]:54200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbeADRfF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Jan 2018 12:35:05 -0500
Date: Thu, 4 Jan 2018 09:29:37 -0800
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH] fstests: btrfs/158: reproduce a scrub bug on raid6
 corruption
Message-ID: <20180104172937.GA5829@lim.localdomain>
Reply-To: bo.li.liu@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 04, 2018 at 05:05:34PM +0800, Eryu Guan wrote:
> On Tue, Jan 02, 2018 at 01:35:00PM -0700, Liu Bo wrote:
> > This is to reproduce a bug of scrub, with which scrub is unable to
> > repair raid6 corruption as expected.
> > 
> > The kernel side fixes are
> >   Btrfs: make raid6 rebuild retry more
> >   Btrfs: fix scrub to repair raid6 corruption
> > 
> > Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> 
> Looks fine overall, I tested it with 4.15-rc6 kernel and test failed as
> expected, re-tested successfully after applying the patches mentioned in
> commit log.
> 

Thanks for testing it.

> Just some really minor issues below, and I can fix them on commit if
> what I suggest looks sane to you.
>

They all look good to me, thanks a lot for the comments.

> > ---
> >  tests/btrfs/158     | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/158.out |  10 +++++
> >  tests/btrfs/group   |   1 +
> >  3 files changed, 125 insertions(+)
> >  create mode 100755 tests/btrfs/158
> >  create mode 100644 tests/btrfs/158.out
> > 
> > diff --git a/tests/btrfs/158 b/tests/btrfs/158
> > new file mode 100755
> > index 0000000..43afc2d
> > --- /dev/null
> > +++ b/tests/btrfs/158
> > @@ -0,0 +1,114 @@
> > +#! /bin/bash
> > +# FS QA Test 158
> > +#
> > +# The test case is check if scrub is able fix raid6 data corruption,
> > +# ie. if there is data corruption on two disks in the same horizontal
> > +# stripe, e.g.  due to bitrot.
> > +#
> > +# The kernel fixes are
> > +#	Btrfs: make raid6 rebuild retry more
> > +#	Btrfs: fix scrub to repair raid6 corruption
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Oracle.  All Rights Reserved.
>                    ^^^^ 2018?

oops, it was 2017 when I made the test.

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
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_scratch_dev_pool 4
> > +_require_btrfs_command inspect-internal dump-tree
> > +
> > +get_physical_stripe0()
> > +{
> > +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> > +	grep " DATA\|RAID6" -A 10 | \
> > +	$AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /0/) { print $6 }'
> > +}
> > +
> > +get_physical_stripe1()
> > +{
> > +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> > +	grep " DATA\|RAID6" -A 10 | \
> > +	$AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /1/) { print $6 }'
> > +}
> > +
> > +_scratch_dev_pool_get 4
> > +# step 1: create a raid6 btrfs and create a 4K file
> > +echo "step 1......mkfs.btrfs" >>$seqres.full
> > +
> > +mkfs_opts="-d raid6 -b 1G"
> > +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> > +
> > +# -o nospace_cache makes sure data is written to the start position of the data
> > +# chunk
> > +_scratch_mount -o nospace_cache
> > +
> > +# [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
> > +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> > +	"$SCRATCH_MNT/foobar" | _filter_xfs_io
> > +
> > +_scratch_unmount
> > +
> > +stripe_0=`get_physical_stripe0`
> > +stripe_1=`get_physical_stripe1`
> > +dev4=`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
> > +dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
> > +
> > +# step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
> > +echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
> > +
> > +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs_io
> > +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs_io
> > +
> > +# step 3: read foobar to repair the bitrot
> 
> Comment meant to be "scrub to repair the bitrot"?
> 
> > +echo "step 3......repair the bitrot" >> $seqres.full
> > +_scratch_mount -o nospace_cache
> > +
> > +btrfs scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
> 
> $BTRFS_UTIL_PROG ...
>

Ah, sorry, this was mostly copied from btrfs/157, and you're 100%
right on both of the above.

> > +
> > +od -x $SCRATCH_MNT/foobar
> > +
> > +_scratch_dev_pool_put
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
> > new file mode 100644
> > index 0000000..1f5ad3f
> > --- /dev/null
> > +++ b/tests/btrfs/158.out
> > @@ -0,0 +1,10 @@
> > +QA output created by 158
> > +wrote 131072/131072 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 65536/65536 bytes at offset 9437184
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 65536/65536 bytes at offset 9437184
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
> > +*
> > +0400000
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index f68abf4..0b3cf12 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -160,3 +160,4 @@
> >  155 auto quick send
> >  156 auto quick trim
> >  157 auto quick raid
> > +158 auto quick raid
> 
> Should be in 'scrub' group too.
>

OK, good to know there is a group for scrub.

thanks,
-liubo
