Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:15350 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752855AbbAZJ3R (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 26 Jan 2015 04:29:17 -0500
Message-ID: <54C60804.9050509@cn.fujitsu.com>
Date: Mon, 26 Jan 2015 17:25:24 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] generic: add test for truncate/collapse range race
References: <1419060301-26830-1-git-send-email-gux.fnst@cn.fujitsu.com> <1419496264-4793-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1419496264-4793-1-git-send-email-gux.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, guaneryu@gmail.com, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

Hi,

    Could you help to review this patch?
    Thanks!

regards,
Xing Gu

On 12/25/2014 04:31 PM, Xing Gu wrote:
> This case tests truncate/collapse range race. If
> the race occurs, it will trigger BUG_ON.
> 
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>   v1->v2: Optimize the run loop iterations and xfs_io operation.
>           Remove the check for a bug message.
>           Echo "Silence is golden" to indicate that an empty output
>           file is expected.
> ---
>   tests/generic/039     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/039.out |  2 ++
>   tests/generic/group   |  1 +
>   3 files changed, 80 insertions(+)
>   create mode 100755 tests/generic/039
>   create mode 100644 tests/generic/039.out
> 
> diff --git a/tests/generic/039 b/tests/generic/039
> new file mode 100755
> index 0000000..ed74f83
> --- /dev/null
> +++ b/tests/generic/039
> @@ -0,0 +1,77 @@
> +#! /bin/bash
> +# FS QA Test No. 039
> +#
> +# Test truncate/collapse range race. If the race occurs, it
> +# will trigger BUG_ON.
> +#
> +# This bug was fixed by the following linux kernel commit:
> +#     fs: move falloc collapse range check into the filesystem methods
> +#     23fffa925ea2c9a2bcb1a4453e2c542635aa3545
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2014 Fujitsu.  All Rights Reserved.
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
> +
> +_cleanup()
> +{
> +    rm -f $tmp.*
> +}
> +
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_os Linux
> +_supported_fs generic
> +_require_scratch
> +_require_xfs_io_command "fcollapse"
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +testfile=$SCRATCH_MNT/file.$seq
> +NCPUS=`$here/src/feature -o`
> +OUTER_LOOPS=$((10 * $NCPUS * $LOAD_FACTOR))
> +INNER_LOOPS=$((50 * $NCPUS * $LOAD_FACTOR))
> +# fcollapse/truncate continuously and simultaneously a same file
> +for ((i=1; i <= OUTER_LOOPS; i++)); do
> +	for ((i=1; i <= INNER_LOOPS; i++)); do
> +		$XFS_IO_PROG -f -c 'truncate 100k' \
> +			-c 'fcollapse 0 16k' $testfile > /dev/null 2>&1
> +	done &
> +	for ((i=1; i <= INNER_LOOPS; i++)); do
> +		$XFS_IO_PROG -f -c 'truncate 0' $testfile > /dev/null 2>&1
> +	done &
> +done
> +wait
> +
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/039.out b/tests/generic/039.out
> new file mode 100644
> index 0000000..d4e7ef6
> --- /dev/null
> +++ b/tests/generic/039.out
> @@ -0,0 +1,2 @@
> +QA output created by 039
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 1e89848..4cdf167 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -41,6 +41,7 @@
>   036 auto aio rw stress
>   037 metadata auto quick
>   038 auto stress
> +039 auto metadata stress
>   053 acl repair auto quick
>   062 attr udf auto quick
>   068 other auto freeze dangerous stress
> 
