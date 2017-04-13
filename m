Received: from sandeen.net ([63.231.237.45]:55866 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbdDMWli (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 13 Apr 2017 18:41:38 -0400
Subject: Re: [PATCH] xfs/288: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
 <20170413223427.GB5083@birch.djwong.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <b634101c-d259-c783-70ec-491da4046490@sandeen.net>
Date: Thu, 13 Apr 2017 17:41:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170413223427.GB5083@birch.djwong.org>
Content-Type: text/plain; charset=windows-1252
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 4/13/17 5:34 PM, Darrick J. Wong wrote:
> On Thu, Apr 13, 2017 at 03:28:02PM -0500, Eric Sandeen wrote:
>> Test for the patch I just sent to the xfs list,
>> xfs: handle array index overrun in xfs_dir2_leaf_readbuf()
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> the .out file is very big; We could probably live without
>> it, since the test is just looking for a hang or a KASAN
>> splat.
>>
>> diff --git a/tests/xfs/288 b/tests/xfs/288
>> new file mode 100755
>> index 0000000..537b45b
>> --- /dev/null
>> +++ b/tests/xfs/288
>> @@ -0,0 +1,119 @@
>> +#! /bin/bash
>> +# FS QA Test 288
>> +#
>> +# Test readdir on fragmented multi-fsb dir blocks
>> +#
>> +# If the readahead map ends with a partial multi-fsb dir
>> +# block, the loop at the end of xfs_dir2_leaf_readbuf() may
>> +# walk off the end of the mapping array, read garbage,
>> +# corrupt the loop control counter, and never return.
>> +#
>> +# Failure is a hang; KASAN should also catch this.
>> +#
>> +#--------------------------------------------------------------------=
---
>> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
>> +# Author: Eric Sandeen <sandeen@redhat.com>
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation=
,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#--------------------------------------------------------------------=
---
>> +#
>> +
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs xfs
>> +_supported_os Linux
>> +_require_scratch
>> +_require_test_program "punch-alternating"
>> +
>> +# We want to override mkfs with a very specific geometry
>> +$MKFS_XFS_PROG -f -d size=3D512m -n size=3D8192 -i size=3D1024 $SCRAT=
CH_DEV  \
>> +	> $seqres.full 2>&1 || _fail "mkfs failed"
>> +
>> +_scratch_mount
>> +
>> +# Make a ton of mostly-empty inode clusters so we can always
>> +# make more inodes
>> +mkdir $SCRATCH_MNT/tmp
>> +for I in `seq 1 10000`; do touch $SCRATCH_MNT/tmp/$I; done
>> +
>> +# These mostly-empty clusters will live here:
>> +mkdir $SCRATCH_MNT/clusters
>> +for I in `seq 1 32 10000`; do
>> +	mv $SCRATCH_MNT/tmp/$I $SCRATCH_MNT/clusters;
>> +done
>> +rm -rf $SCRATCH_MNT/tmp
>> +
>> +# Make our test dir with a couple blocks, should be contiguous
>> +mkdir $SCRATCH_MNT/testdir
>> +# roughly 20 chars per file
>> +for I in `seq 1 100`; do
>> +	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
>> +done
>> +
>> +# Now completely fragment freespace.
>> +# Consume most of it:
>> +xfs_io -f -c "falloc 0 400m" $SCRATCH_MNT/fillfile ||
>> +	_fail "Could not allocate space"
>> +
>> +# File to fragment:
>> +xfs_io -f -c "falloc 0 70m" $SCRATCH_MNT/fragfile ||
>> +	_fail "Could not allocate space"
>> +
>> +df -h $SCRATCH_MNT > $seqres.full 2>&1
>=20
> Truncates $seqres.full...

oops too much of a hurry, that was debug :/

>> +
>> +# Fill remaining space; let this run to failure
>> +dd if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile1 oflag=3Ddirect > $seqr=
es.full 2>&1
>=20
> Truncates $seqres.full...
>=20
>> +# Fragment our all-consuming file
>> +./src/punch-alternating $SCRATCH_MNT/fragfile > $seqres.full 2>&1
>=20
> Trunca...oh never mind. :)

I suck.

>> +
>> +# Punching might have freed up large-ish swaths of metadata
>> +# Consume hopefully any remaining contiguous freespace
>> +# (and then some for good measure)
>> +dd if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile2 bs=3D1M count=3D64 > $=
seqres.full 2>&1
>> +xfs_io -c fsync $SCRATCH_MNT/spacefile2 > $seqres.full 2>&1
>=20
> dd conv=3Dfsync?

of course :)

>> +
>> +# Now populate the directory so that it must allocate these
>> +# fragmented blocks
>> +for I in `seq 1 1400`;
>> +	do touch $SCRATCH_MNT/testdir/12345678901234567890$I;
>> +done
>> +
>> +# Now traverse that ugly thing!
>> +find $SCRATCH_MNT/testdir
>=20
> Spews ~1400 unfiltered scratch_mnt paths into the golden output...
> ...if you're looking for a hang or dmesg splat, there are ways to detec=
t
> those.

Right, like I mentioned, probably not needed; it's not what the test
is after, but also nice to know that we get the right stuff back from
this insanely formatted dir.  I'm happy enough to remove it.

>> +
>> +status=3D0
>> +exit
>> diff --git a/tests/xfs/288.out b/tests/xfs/288.out
>> new file mode 100644


>> +/mnt/scratch/testdir/12345678901234567890248
>> +/mnt/scratch/testdir/12345678901234567890249
>=20
> MY EYES!!

But wait, there's more!

>> +/mnt/scratch/testdir/12345678901234567890250
>> +/mnt/scratch/testdir/12345678901234567890251
>> +/mnt/scratch/testdir/12345678901234567890252
>> +/mnt/scratch/testdir/12345678901234567890253
>> +/mnt/scratch/testdir/12345678901234567890254
...
>> +/mnt/scratch/testdir/12345678901234567890358
> A M=F8=F8se once bit my sister... No realli!
>> +/mnt/scratch/testdir/12345678901234567890359
...
>> +/mnt/scratch/testdir/12345678901234567890458
>> +/mnt/scratch/testdir/12345678901234567890459
> She was Karving her initials on the m=F8=F8se with the sharpened end of=
 an
> interspace t=F8=F8thbrush given her by Svenge...
>> +/mnt/scratch/testdir/12345678901234567890460
>> +/mnt/scratch/testdir/12345678901234567890461
...
>> +/mnt/scratch/testdir/12345678901234567890663
>> +/mnt/scratch/testdir/12345678901234567890664
> We apologise for the fault in the subtitles. Those responsible have bee=
n sacked.
>> +/mnt/scratch/testdir/12345678901234567890665
>> +/mnt/scratch/testdir/12345678901234567890666
...
>> +/mnt/scratch/testdir/12345678901234567890801
>> +/mnt/scratch/testdir/12345678901234567890802
> Mynd you, m=F8=F8se bites Kan be pretti nasti...
>> +/mnt/scratch/testdir/12345678901234567890803
>> +/mnt/scratch/testdir/12345678901234567890804
>> +/mnt/scratch/testdir/12345678901234567890805
...
>> +/mnt/scratch/testdir/12345678901234567890944
>> +/mnt/scratch/testdir/12345678901234567890945
>> +/mnt/scratch/testdir/12345678901234567890946
> We apologise again for the fault in the subtitles. Those responsible fo=
r
> sacking the people who have just been sacked have been sacked.
>> +/mnt/scratch/testdir/12345678901234567890947
>> +/mnt/scratch/testdir/12345678901234567890948
...
>> +/mnt/scratch/testdir/123456789012345678901122
>> +/mnt/scratch/testdir/123456789012345678901123
> M=F8=F8se trained by YUTTE HERMSGERV=D8RDENBR=D8TB=D8RDA
> Special M=F8=F8se Effects OLAF PROT
>> +/mnt/scratch/testdir/123456789012345678901124
>> +/mnt/scratch/testdir/123456789012345678901125
...
>> +/mnt/scratch/testdir/123456789012345678901184
>> +/mnt/scratch/testdir/123456789012345678901185
> The directors of the firm hired to continue the credits after the other
> people had been sacked, wish it to be known that they have just been
> sacked. The credits have been completed in an entirely different style
> at great expense and at the last minute.=20
>> +/mnt/scratch/testdir/123456789012345678901186
>> +/mnt/scratch/testdir/123456789012345678901187
...
>> +/mnt/scratch/testdir/123456789012345678901312
>> +/mnt/scratch/testdir/123456789012345678901313
>> +/mnt/scratch/testdir/123456789012345678901314
> Directed By 40 SPECIALLY TRAINED ECUADORIAN MOUNTAIN LLAMAS 6 VENEZUELA=
N
> RED LLAMAS 142 MEXICAN WHOOPING LLAMAS 14 NORTH CHILEAN GUANACOS...
>> +/mnt/scratch/testdir/123456789012345678901315
>> +/mnt/scratch/testdir/123456789012345678901316
...

Thank you.  No, really.  :)

>> +/mnt/scratch/testdir/123456789012345678901399
>> +/mnt/scratch/testdir/123456789012345678901400
>> diff --git a/tests/xfs/group b/tests/xfs/group
>> index 75769f9..127cc36 100644
>> --- a/tests/xfs/group
>> +++ b/tests/xfs/group
>> @@ -285,6 +285,7 @@
>>  285 dangerous_fuzzers dangerous_scrub
>>  286 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>>  287 auto dump quota quick
>> +288 auto dir metadata dangerous
>>  290 auto rw prealloc quick ioctl zero
>>  291 auto repair
>>  292 auto mkfs quick
>> @@ -342,7 +343,7 @@
>>  345 auto quick clone
>>  346 auto quick clone
>>  347 auto quick clone
>> -348 auto quick fuzzers repair
>> +348 auto quick fuzzers repair dangerous
>=20
> Huh?

Sigh.

-Eric
