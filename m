Received: from aserp1040.oracle.com ([141.146.126.69]:33384 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S974754AbdDXQe5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2017 12:34:57 -0400
Date: Mon, 24 Apr 2017 09:34:50 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/288: test xfs_growfs to ensure rejection if target
 isn't mounted
Message-ID: <20170424163450.GC5190@birch.djwong.org>
References: <20170424150935.28707-1-billodo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424150935.28707-1-billodo@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Bill O'Donnell <billodo@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 24, 2017 at 10:09:35AM -0500, Bill O'Donnell wrote:
> The manpage for xfs_growfs specifies that the file/dir to be
> grown must be mounted. This is a test to ensure that if the
> target isn't mounted, the command is rejected. The test covers
> absolute paths and relative paths, including symbolic links
> and bind mounts.
> 
> Signed-off-by: Bill O'Donnell <billodo@redhat.com>
> ---
>  tests/xfs/288     | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/288.out | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/group   |   1 +
>  3 files changed, 241 insertions(+)
>  create mode 100755 tests/xfs/288
>  create mode 100644 tests/xfs/288.out
> 
> diff --git a/tests/xfs/288 b/tests/xfs/288
> new file mode 100755
> index 0000000..628f753
> --- /dev/null
> +++ b/tests/xfs/288
> @@ -0,0 +1,121 @@
> +#! /bin/bash
> +# FS QA Test 288
> +#
> +# Test to ensure xfs_growfs command rejects non-existent mount points
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    umount $tmpdir
> +    umount $tmpbind
> +    rmdir $tmpdir
> +    rm -f $tmpsymlink
> +    rmdir $tmpbind
> +    rm -f $tmp
> +    rm -f $tmpfile
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
> +_require_test
> +_require_loop
> +
> +tmpfile=$TEST_DIR/fsfile
> +tmpdir=$TEST_DIR/tmpdir
> +tmpsymlink=$TEST_DIR/tmpsymlink.$$
> +tmpbind=$TEST_DIR/tmpbind.$$
> +
> +mkdir -p $tmpdir || _fail "!!! failed to create temp mount dir"
> +
> +echo "=== mkfs.xfs ==="
> +mkfs.xfs -d file,name=$tmpfile,size=64m -f

$MKFS_XFS_PROG -d file...

> +
> +echo "=== truncate ==="
> +truncate --size=128m $tmpfile
> +
> +echo "=== xfs_growfs - unmounted, command should be rejected ==="
> +xfs_growfs $tmpdir

$XFS_GROWFS_PROG $tmpdir

> +
> +echo "=== xfs_growfs - check relative path, unmounted ==="
> +cd $TEST_DIR
> +xfs_growfs ./tmpdir
> +
> +echo "=== xfs_growfs - no path, unmounted ==="
> +cd $TEST_DIR
> +xfs_growfs tmpdir
> +
> +echo "=== mount ==="
> +mount -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
> +
> +echo "=== xfs_growfs - mounted ==="
> +xfs_growfs $tmpdir
> +
> +echo "=== xfs_growfs - check relative path ==="
> +cd $TEST_DIR
> +xfs_growfs ./tmpdir

So this growfs invocation should succeed, correct?  I see agcount
doubling but $tmpfile doesn't get expanded... such that all the
following growfses have no space to grow the fs, but they also don't
spit out error messages.

(Just talking myself through this test...)

Also wondering if this test ought to keep expanding $testfile one AG at
a time prior to every growfs test so that test success is keyed off of
seeing a "data blocks changed from XXX to YYY" message, just in case the
layout ever shifts...

> +
> +echo "=== xfs_growfs - no path ==="
> +cd $TEST_DIR
> +xfs_growfs tmpdir
> +
> +echo "=== test symbolic link ==="
> +ln -s $tmpdir $tmpsymlink
> +xfs_growfs $tmpsymlink
> +
> +echo "=== test symbolic link using relative path ==="
> +xfs_growfs ./tmpsymlink.$$
> +
> +echo "=== test symbolic link using no path ==="
> +xfs_growfs tmpsymlink.$$
> +
> +echo "=== test bind mount ==="
> +mkdir $tmpbind
> +mount -o bind $tmpdir $tmpbind
> +xfs_growfs $tmpbind
> +
> +echo "=== test bind mount - relative path ==="
> +
> +xfs_growfs ./tmpbind.$$
> +
> +echo "=== test bind mount - no path ==="
> +xfs_growfs tmpbind.$$
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/288.out b/tests/xfs/288.out
> new file mode 100644
> index 0000000..a526048
> --- /dev/null
> +++ b/tests/xfs/288.out
> @@ -0,0 +1,119 @@
> +QA output created by 288
> +=== mkfs.xfs ===
> +meta-data=/mnt/test/fsfile       isize=512    agcount=4, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1, sparse=0, rmapbt=0, reflink=0

Don't let mkfs/growfs output leak into the golden output, because as
soon as anything changes the mkfs output (we turn on sparse inodes by
default (or rmap, or reflink...) or someone runs this on a 4k sector
disk, or...) the golden output will differ from the observed output and
./check will flag this test as failed even if the growfs behavior is
exactly what you were looking for.

I think you're testing whether or not the growfs succeeded by comparing
agcount, right?  You might consider recording the growfs output to a
file and importing that into the running shell, like some of the tests
seem to do.

> +data     =                       bsize=4096   blocks=16384, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal log           bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== truncate ===
> +=== xfs_growfs - unmounted, command should be rejected ===
> +xfs_growfs: /mnt/test/tmpdir is not a mounted XFS filesystem

Please run the error messages through _filter_test_dir so that we don't
hardcode TEST_DIR/SCRATCH_MNT pathnames in test output.

> +=== xfs_growfs - check relative path, unmounted ===
> +xfs_growfs: ./tmpdir is not a mounted XFS filesystem
> +=== xfs_growfs - no path, unmounted ===
> +xfs_growfs: tmpdir is not a mounted XFS filesystem
> +=== mount ===
> +=== xfs_growfs - mounted ===
> +meta-data=/dev/loop0             isize=512    agcount=4, agsize=4096 blks

FWIW mount -o loop doesn't guarantee you /dev/loop0.  Imagine if an
xfstest user set up TEST_DEV=/dev/loop0.

> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=16384, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +data blocks changed from 16384 to 32768
> +=== xfs_growfs - check relative path ===
> +meta-data=/dev/loop0             isize=512    agcount=8, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=32768, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== xfs_growfs - no path ===
> +meta-data=/dev/loop0             isize=512    agcount=8, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=32768, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== test symbolic link ===
> +meta-data=/dev/loop0             isize=512    agcount=8, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=32768, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== test symbolic link using relative path ===
> +meta-data=/dev/loop0             isize=512    agcount=8, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=32768, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== test symbolic link using no path ===
> +meta-data=/dev/loop0             isize=512    agcount=8, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=32768, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== test bind mount ===
> +meta-data=/dev/loop0             isize=512    agcount=8, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=32768, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== test bind mount - relative path ===
> +meta-data=/dev/loop0             isize=512    agcount=8, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=32768, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== test bind mount - no path ===
> +meta-data=/dev/loop0             isize=512    agcount=8, agsize=4096 blks
> +         =                       sectsz=512   attr=2, projid32bit=1
> +         =                       crc=1        finobt=1 spinodes=0 rmapbt=0
> +         =                       reflink=0
> +data     =                       bsize=4096   blocks=32768, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal               bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 75769f9..0dcb8e0 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -285,6 +285,7 @@
>  285 dangerous_fuzzers dangerous_scrub
>  286 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>  287 auto dump quota quick
> +288 growfs auto quick
>  290 auto rw prealloc quick ioctl zero
>  291 auto repair
>  292 auto mkfs quick
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
