Received: from mx1.redhat.com ([209.132.183.28]:47574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdFZQtY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Jun 2017 12:49:24 -0400
Date: Mon, 26 Jun 2017 11:49:21 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH v3] xfs/288: test xfs_growfs to ensure rejection if
 target path isn't an active xfs mountpoint
Message-ID: <20170626164921.GA25281@redhat.com>
References: <20170424150935.28707-1-billodo@redhat.com>
 <20170427183110.25023-1-billodo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427183110.25023-1-billodo@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, Eric Sandeen <esandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

I noticed this dropped from the radar, and I'm wondering if I
should resubmit it with a new test number, or is it a total NAK?

Thanks-
Bill

On Thu, Apr 27, 2017 at 01:31:10PM -0500, Bill O'Donnell wrote:
> xfs_growfs manpage clearly states that the target path must be an
> active xfs mountpoint. This is a test to ensure that if the target
> path isn't an active xfs mountpoint, the command is rejected. The
> purpose is to check the command response, but not necessarily the
> functionality of xfs_growfs. Test cases include absolute paths,
> relative paths, symbolic links, and bind mounts.
> 
> Signed-off-by: Bill O'Donnell <billodo@redhat.com>
> ---
> 
> v3: improve commit message and subject line. Use _filter_test_dir
>     for absolute pathnames. Use env variable substitutions for
>     common fs commands. Send xfs_growfs stdout to /dev/null.
>     Remove the use of $tmp.*.
>     
> v2: acually grow the fs as test proceeds; add filter, preventing
>     superfluous stdio verbiage; add test for (unmounted) file; add
>     description to commit message to clarify that this isn't a test
>     for xfs_growfs functionality, but rather a test of command
>     argument accepts and rejections.
> 
>  tests/xfs/288     | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/288.out |  23 ++++++++++
>  tests/xfs/group   |   1 +
>  3 files changed, 147 insertions(+)
>  create mode 100755 tests/xfs/288
>  create mode 100644 tests/xfs/288.out
> 
> diff --git a/tests/xfs/288 b/tests/xfs/288
> new file mode 100755
> index 0000000..da4c639
> --- /dev/null
> +++ b/tests/xfs/288
> @@ -0,0 +1,123 @@
> +#! /bin/bash
> +# FS QA Test 288
> +#
> +# Test to ensure xfs_growfs command rejects non-existent mount points
> +# and accepts mounted targets.
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
> +    $UMOUNT_PROG $tmpdir
> +    $UMOUNT_PROG $tmpbind
> +    rmdir $tmpdir
> +    rm -f $tmpsymlink
> +    rmdir $tmpbind
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
> +$MKFS_XFS_PROG -d file,name=$tmpfile,size=16m -f >/dev/null 2>&1
> +
> +echo "=== truncate ==="
> +$XFS_IO_PROG -fc "truncate 256m" $tmpfile
> +
> +echo "=== xfs_growfs - unmounted, command should be rejected ==="
> +$XFS_GROWFS_PROG $tmpdir 2>&1 |  _filter_test_dir
> +
> +echo "=== xfs_growfs - check relative path, unmounted ==="
> +cd $TEST_DIR
> +$XFS_GROWFS_PROG ./tmpdir 2>&1 | _filter_test_dir
> +
> +echo "=== xfs_growfs - no path, unmounted ==="
> +$XFS_GROWFS_PROG tmpdir 2>&1 | _filter_test_dir
> +
> +echo "=== xfs_growfs - plain file - should be rejected ==="
> +$XFS_GROWFS_PROG $tmpfile 2>&1 | _filter_test_dir
> +
> +echo "=== mount ==="
> +$MOUNT_PROG -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
> +
> +echo "=== xfs_growfs - mounted - check absolute path ==="
> +$XFS_GROWFS_PROG -D 8192 $tmpdir | _filter_test_dir > /dev/null
> +
> +echo "=== xfs_growfs - check relative path ==="
> +$XFS_GROWFS_PROG -D 12288 ./tmpdir > /dev/null
> +
> +echo "=== xfs_growfs - no path ==="
> +$XFS_GROWFS_PROG -D 16384 tmpdir > /dev/null
> +
> +echo "=== xfs_growfs - symbolic link ==="
> +ln -s $tmpdir $tmpsymlink
> +$XFS_GROWFS_PROG -D 20480 $tmpsymlink | _filter_test_dir > /dev/null
> +
> +echo "=== xfs_growfs - symbolic link using relative path ==="
> +$XFS_GROWFS_PROG -D 24576 ./tmpsymlink.$$ > /dev/null
> +
> +echo "=== xfs_growfs - symbolic link using no path ==="
> +$XFS_GROWFS_PROG -D 28672 tmpsymlink.$$ > /dev/null
> +
> +echo "=== xfs_growfs - bind mount ==="
> +mkdir $tmpbind
> +$MOUNT_PROG -o bind $tmpdir $tmpbind
> +$XFS_GROWFS_PROG -D 32768 $tmpbind | _filter_test_dir > /dev/null
> +
> +echo "=== xfs_growfs - bind mount - relative path ==="
> +$XFS_GROWFS_PROG -D 36864 ./tmpbind.$$ > /dev/null
> +
> +echo "=== xfs_growfs - bind mount - no path ==="
> +$XFS_GROWFS_PROG -D 40960 tmpbind.$$ > /dev/null
> +
> +echo "=== xfs_growfs - plain file - should be rejected ==="
> +$XFS_GROWFS_PROG $tmpfile 2>&1 | _filter_test_dir
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/288.out b/tests/xfs/288.out
> new file mode 100644
> index 0000000..f7c2362
> --- /dev/null
> +++ b/tests/xfs/288.out
> @@ -0,0 +1,23 @@
> +QA output created by 288
> +=== mkfs.xfs ===
> +=== truncate ===
> +=== xfs_growfs - unmounted, command should be rejected ===
> +xfs_growfs: TEST_DIR/tmpdir is not a mounted XFS filesystem
> +=== xfs_growfs - check relative path, unmounted ===
> +xfs_growfs: ./tmpdir is not a mounted XFS filesystem
> +=== xfs_growfs - no path, unmounted ===
> +xfs_growfs: tmpdir is not a mounted XFS filesystem
> +=== xfs_growfs - plain file - should be rejected ===
> +xfs_growfs: TEST_DIR/fsfile is not a mounted XFS filesystem
> +=== mount ===
> +=== xfs_growfs - mounted - check absolute path ===
> +=== xfs_growfs - check relative path ===
> +=== xfs_growfs - no path ===
> +=== xfs_growfs - symbolic link ===
> +=== xfs_growfs - symbolic link using relative path ===
> +=== xfs_growfs - symbolic link using no path ===
> +=== xfs_growfs - bind mount ===
> +=== xfs_growfs - bind mount - relative path ===
> +=== xfs_growfs - bind mount - no path ===
> +=== xfs_growfs - plain file - should be rejected ===
> +xfs_growfs: TEST_DIR/fsfile is not a mounted XFS filesystem
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
