Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:29454 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751708AbbCXJJU (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Mar 2015 05:09:20 -0400
Message-ID: <55112829.1060702@cn.fujitsu.com>
Date: Tue, 24 Mar 2015 17:02:33 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH,RESEND v2] fstests: add test for truncate/collapse range
 race
References: <1427187163-12307-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1427187163-12307-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com
Cc: lczerner@redhat.com, gux.fnst@cn.fujitsu.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

Sorry for bothering, but this patch still is not merged.
Xing Gu has written a new version according to Dave's suggestions, but
there is no response recently, so I re-send this patch and will follow
up it. Any comments would be appreciated, thanks!

Regards,
Xiaoguang Wang

On 03/24/2015 04:52 PM, Xiaoguang Wang wrote:
> This case tests truncate/collapse range race. If the race occurs, it
> will trigger a BUG_ON(). And this kernel patch has fixed this race:
> 
>     commit 23fffa925ea2c9a2bcb1a4453e2c542635aa3545
>     Author: Lukas Czerner <lczerner@redhat.com>
>     Date:   Sat Apr 12 09:56:41 2014 -0400
>         fs: move falloc collapse range check into the filesystem methods
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  tests/generic/067     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/067.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/generic/067
>  create mode 100644 tests/generic/067.out
> 
> diff --git a/tests/generic/067 b/tests/generic/067
> new file mode 100755
> index 0000000..75d4354
> --- /dev/null
> +++ b/tests/generic/067
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# FS QA Test No. 067
> +#
> +# Test truncate/collapse range race.
> +# And this test is also a regression test for kernel commit 23fffa9,
> +#    fs: move falloc collapse range check into the filesystem methods
> +# If the race occurs, it will trigger a BUG_ON().
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2015 Fujitsu.  All Rights Reserved.
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
> diff --git a/tests/generic/067.out b/tests/generic/067.out
> new file mode 100644
> index 0000000..daa1545
> --- /dev/null
> +++ b/tests/generic/067.out
> @@ -0,0 +1,2 @@
> +QA output created by 067
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index d56d3ce..b2f0680 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -69,6 +69,7 @@
>  064 auto quick prealloc
>  065 metadata auto quick
>  066 metadata auto quick
> +067 auto metadata stress
>  068 other auto freeze dangerous stress
>  069 rw udf auto quick
>  070 attr udf auto quick stress
> 

