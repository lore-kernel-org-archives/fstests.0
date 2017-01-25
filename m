Received: from mx1.redhat.com ([209.132.183.28]:44318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbdAYJUZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 25 Jan 2017 04:20:25 -0500
Date: Wed, 25 Jan 2017 17:20:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] btrfs: add regression test for setxattr on subvolume
 directory
Message-ID: <20170125092024.GH1859@eguan.usersys.redhat.com>
References: <28ac6254ad926413836489a46cbf14497f4802ed.1485327013.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ac6254ad926413836489a46cbf14497f4802ed.1485327013.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 24, 2017 at 10:50:29PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is a regression test for "Btrfs: disable xattr operations on
> subvolume directories". On v4.9, it will result in an aborted
> transaction.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Looks good to me overall, tested with 4.10-rc5 kernel with and without
the proposed kernel fix, results are all as expected. Some minor issues
inline.

> ---
>  tests/btrfs/047     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/047.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 72 insertions(+)
>  create mode 100644 tests/btrfs/047

Better to add new test with mode 755, otherwise git diff shows mode
changes after tests being run.

>  create mode 100644 tests/btrfs/047.out
> 
> diff --git a/tests/btrfs/047 b/tests/btrfs/047
> new file mode 100644
> index 00000000..c3222f8b
> --- /dev/null
> +++ b/tests/btrfs/047
> @@ -0,0 +1,69 @@
> +#! /bin/bash
> +# FS QA Test 047
> +#
> +# Test that we can't set xattrs on read-only subvolume placeholder directories.
> +# Regression test for Btrfs: disable xattr operations on subvolume directories.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Facebook.  All Rights Reserved.
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
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_attrs
> +_require_scratch
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount
> +
> +_run_btrfs_util_prog subvolume create "$SCRATCH_MNT/parent"
> +_run_btrfs_util_prog subvolume create "$SCRATCH_MNT/parent/child"
> +_run_btrfs_util_prog subvolume snapshot "$SCRATCH_MNT/parent" "$SCRATCH_MNT/snapshot"

Please avoid using "run_check" (called by _run_btrfs_util_prog) if
possible. We can use $BTRFS_UTIL_PROG directly and throw away stdout or
append it to $seqres.full, and stderr from these commands will break the
golden image.

Thanks,
Eryu

> +
> +$SETFATTR_PROG -n user.test -v foo "$SCRATCH_MNT/snapshot/child" |& _filter_scratch
> +
> +# The original bug resulted in bogus delayed inodes being inserted, so run the
> +# delayed inodes by doing a commit.
> +_run_btrfs_util_prog filesystem sync "$SCRATCH_MNT"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/047.out b/tests/btrfs/047.out
> new file mode 100644
> index 00000000..48555e90
> --- /dev/null
> +++ b/tests/btrfs/047.out
> @@ -0,0 +1,2 @@
> +QA output created by 047
> +setfattr: SCRATCH_MNT/snapshot/child: Operation not supported
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 88fb8db4..69451c6b 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -49,6 +49,7 @@
>  044 auto quick send
>  045 auto quick send
>  046 auto quick send
> +047 auto quick snapshot attr
>  048 auto quick
>  049 auto quick
>  050 auto quick send
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
