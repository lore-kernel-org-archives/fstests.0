Received: from sandeen.net ([63.231.237.45]:39886 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S977226AbdDXTzC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Apr 2017 15:55:02 -0400
Subject: Re: [PATCH] xfs/288: test xfs_growfs to ensure rejection if target
 isn't mounted
References: <20170424150935.28707-1-billodo@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <c4494af9-5444-1b5d-6fcc-eddb48dc8fea@sandeen.net>
Date: Mon, 24 Apr 2017 14:54:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170424150935.28707-1-billodo@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Bill O'Donnell <billodo@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 4/24/17 10:09 AM, Bill O'Donnell wrote:
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
> +
> +echo "=== truncate ==="
> +truncate --size=128m $tmpfile
> +
> +echo "=== xfs_growfs - unmounted, command should be rejected ==="
> +xfs_growfs $tmpdir
> +
> +echo "=== xfs_growfs - check relative path, unmounted ==="
> +cd $TEST_DIR
> +xfs_growfs ./tmpdir
> +
> +echo "=== xfs_growfs - no path, unmounted ==="
> +cd $TEST_DIR

Is there a reason to keep cd'ing to the same dir?  Here and below
as well.

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

Testing a plain file as a target might be good too.  The implementation
shouldn't care, but one mistake I've seen is to do "xfs_info imagefile.img"
and they get an answer about the host fs, not the image file.  It'd
be good to ensure that an argument of a regular file is also rejected.

You could just point xfs_growfs at the image file you create, before
doing any of the other mount tests.

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
> +data     =                       bsize=4096   blocks=16384, imaxpct=25
> +         =                       sunit=0      swidth=0 blks
> +naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> +log      =internal log           bsize=4096   blocks=855, version=2
> +         =                       sectsz=512   sunit=0 blks, lazy-count=1
> +realtime =none                   extsz=4096   blocks=0, rtextents=0
> +=== truncate ===
> +=== xfs_growfs - unmounted, command should be rejected ===
> +xfs_growfs: /mnt/test/tmpdir is not a mounted XFS filesystem
> +=== xfs_growfs - check relative path, unmounted ===
> +xfs_growfs: ./tmpdir is not a mounted XFS filesystem
> +=== xfs_growfs - no path, unmounted ===
> +xfs_growfs: tmpdir is not a mounted XFS filesystem
> +=== mount ===
> +=== xfs_growfs - mounted ===
> +meta-data=/dev/loop0             isize=512    agcount=4, agsize=4096 blks

Hm, when I ran this I had a loop0 already set up, so got loop1, and this
failed to match.  That may be another argument against actually checking
the output too carefully.  

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

yeah, so as Darrick mentioned I'd make sure that it either grows each
time, or that you don't care if it grows at all, just for consistency.

A little odd to have only the first one grow, but have all the subsequent
ones still "succeed."

You'll need to filter all this output somehow - if anyone runs with different
options in MKFS_OPTS, much of this output may fail to match - but things like
fs features, block size, inode size, etc are not relevant to the test.

I think that _filter_mkfs might actually filter growfs just fine, not sure.

Thanks,
-Eric

