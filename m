Received: from cn.fujitsu.com ([59.151.112.132]:31947 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752301AbdESCn6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 May 2017 22:43:58 -0400
Message-ID: <591E5BEB.5070008@cn.fujitsu.com>
Date: Fri, 19 May 2017 10:43:55 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH V2] xfs/289: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net> <fbad53d8-9807-1912-c3e4-e932020c19d3@sandeen.net>
In-Reply-To: <fbad53d8-9807-1912-c3e4-e932020c19d3@sandeen.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>, Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi Eric and Eryu

I tested it on RHE7.3GA and RHEL7.4Alpha=EF=BC=8C i got ENOSPC error inst=
ead of=20
hang.  Is it expected behavior?

Please see the following detailed message:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
[root@RHEL7U4Alpha_Intel64 xfstests]# ./check xfs/294
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 RHEL7U4Alpha_Intel64 3.10.0-657.el7.x86_64
MKFS_OPTIONS  -- -f -bsize=3D4096 /dev/sda11
MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sda11=20
/mnt/xfstests/scratch

xfs/294 10s ... - output mismatch (see=20
/var/lib/xfstests/results//xfs/294.out.bad)
     --- tests/xfs/294.out    2017-05-19 10:39:31.798010275 +0800
     +++ /var/lib/xfstests/results//xfs/294.out.bad    2017-05-19=20
10:40:02.112008755 +0800
     @@ -1,2 +1,1234 @@
      QA output created by 294
     -23accd029fad51ec02e4ec1f24799878  -
     +touch: cannot touch=20
'/mnt/xfstests/scratch/testdir/12345678901234567890169': No space left=20
on device
     +touch: cannot touch=20
'/mnt/xfstests/scratch/testdir/12345678901234567890170': No space left=20
on device
     +touch: cannot touch=20
'/mnt/xfstests/scratch/testdir/12345678901234567890171': No space left=20
on device
     +touch: cannot touch=20
'/mnt/xfstests/scratch/testdir/12345678901234567890172': No space left=20
on device
     +touch: cannot touch=20
'/mnt/xfstests/scratch/testdir/12345678901234567890173': No space left=20
on device
     ...
     (Run 'diff -u tests/xfs/294.out=20
/var/lib/xfstests/results//xfs/294.out.bad'  to see the entire diff)
Ran: xfs/294
Failures: xfs/294
Failed 1 of 1 tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Thanks,
Xiao Yang
On 2017/05/04 8:21, Eric Sandeen wrote:
> Regression test for kernel commit:
> 023cc840 xfs: handle array index overrun in xfs_dir2_leaf_readbuf()
>
> See commit for detailed problem description.
>
> tl;dr: readahead on weirdly fragmented multi-block directories
> was broken.
>
> Signed-off-by: Eric Sandeen<sandeen@redhat.com>
> ---
>
> V2: address most review comments, esp. nuking ginormous .out
> file, but kept touch vs. echo, because echo allocates
> 1 byte ->  1 block and throws off all
> the space calibration.  Still runs in 28s here.
>
> 288->289.
>
> Thanks,
> -Eric
>
> diff --git a/tests/xfs/289 b/tests/xfs/289
> new file mode 100755
> index 0000000..86e3dd6
> --- /dev/null
> +++ b/tests/xfs/289
> @@ -0,0 +1,118 @@
> +#! /bin/bash
> +# FS QA Test 289
> +#
> +# Test readdir on fragmented multi-fsb dir blocks
> +#
> +# If the readahead map ends with a partial multi-fsb dir
> +# block, the loop at the end of xfs_dir2_leaf_readbuf() may
> +# walk off the end of the mapping array, read garbage,
> +# corrupt the loop control counter, and never return.
> +#
> +# Failure is a hang; KASAN should also catch this.
> +#
> +#---------------------------------------------------------------------=
--
> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
> +# Author: Eric Sandeen<sandeen@redhat.com>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#---------------------------------------------------------------------=
--
> +#
> +
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs xfs
> +_supported_os Linux
> +_require_scratch
> +_require_test_program "punch-alternating"
> +
> +# We want to mkfs with a very specific geometry
> +MKFS_OPTIONS=3D""
> +_scratch_mkfs "-d size=3D512m -n size=3D8192 -i size=3D1024">>  $seqre=
s.full 2>&1 \
> +	|| _fail "mkfs failed"
> +_scratch_mount
> +
> +# Make a ton of mostly-empty inode clusters so we can always
> +# make more inodes
> +mkdir $SCRATCH_MNT/tmp
> +for I in `seq 1 10000`; do touch $SCRATCH_MNT/tmp/$I; done
> +
> +# These mostly-empty clusters will live here:
> +mkdir $SCRATCH_MNT/clusters
> +for I in `seq 1 32 10000`; do
> +	mv $SCRATCH_MNT/tmp/$I $SCRATCH_MNT/clusters;
> +done
> +rm -rf $SCRATCH_MNT/tmp
> +
> +# Make our test dir with a couple blocks, should be contiguous
> +mkdir $SCRATCH_MNT/testdir
> +# roughly 20 chars per file
> +for I in `seq 1 100`; do
> +	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
> +done
> +
> +# Now completely fragment freespace.
> +# Consume most of it:
> +$XFS_IO_PROG -f -c "falloc 0 400m" $SCRATCH_MNT/fillfile ||
> +	_fail "Could not allocate space"
> +
> +# File to fragment:
> +$XFS_IO_PROG -f -c "falloc 0 70m" $SCRATCH_MNT/fragfile ||
> +	_fail "Could not allocate space"
> +
> +df -h $SCRATCH_MNT>>  $seqres.full 2>&1
> +
> +# Fill remaining space; let this run to failure
> +dd if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile1 oflag=3Ddirect>>  $seqr=
es.full 2>&1
> +# Fragment our all-consuming file
> +./src/punch-alternating $SCRATCH_MNT/fragfile>>  $seqres.full 2>&1
> +
> +# Punching might have freed up large-ish swaths of metadata
> +# Consume hopefully any remaining contiguous freespace
> +# (and then some for good measure)
> +dd conv=3Dfsync if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile2 bs=3D1M co=
unt=3D64>>  $seqres.full 2>&1
> +
> +# Now populate the directory so that it must allocate these
> +# fragmented blocks
> +for I in `seq 1 1400`; do
> +	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
> +done
> +
> +# Now traverse that ugly thing!
> +find $SCRATCH_MNT/testdir | sort | _filter_scratch | md5sum
> +
> +status=3D0
> +exit
> diff --git a/tests/xfs/289.out b/tests/xfs/289.out
> new file mode 100644
> index 0000000..35f8c5e
> --- /dev/null
> +++ b/tests/xfs/289.out
> @@ -0,0 +1,2 @@
> +QA output created by 289
> +23accd029fad51ec02e4ec1f24799878  -
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 75769f9..1b7046b 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -285,6 +285,7 @@
>   285 dangerous_fuzzers dangerous_scrub
>   286 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>   287 auto dump quota quick
> +289 auto dir metadata dangerous
>   290 auto rw prealloc quick ioctl zero
>   291 auto repair
>   292 auto mkfs quick
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> .
>



