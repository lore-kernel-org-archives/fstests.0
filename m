Received: from userp1040.oracle.com ([156.151.31.81]:25737 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdAYJwq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Jan 2017 04:52:46 -0500
Subject: Re: [PATCH] btrfs: add regression test for setxattr on subvolume
 directory
References: <28ac6254ad926413836489a46cbf14497f4802ed.1485327013.git.osandov@fb.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <0fe483e9-59b3-2c1a-e664-6c7a7d1f723a@oracle.com>
Date: Wed, 25 Jan 2017 17:56:52 +0800
MIME-Version: 1.0
In-Reply-To: <28ac6254ad926413836489a46cbf14497f4802ed.1485327013.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>



one below.

On 01/25/17 14:50, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> This is a regression test for "Btrfs: disable xattr operations on
> subvolume directories". On v4.9, it will result in an aborted
> transaction.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  tests/btrfs/047     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/047.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 72 insertions(+)
>  create mode 100644 tests/btrfs/047
>  create mode 100644 tests/btrfs/047.out
>
> diff --git a/tests/btrfs/047 b/tests/btrfs/047
> new file mode 100644

  There is no run permission. Rest is good.


   Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


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
>
