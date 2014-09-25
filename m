Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:65326 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbaIYDzs (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 24 Sep 2014 23:55:48 -0400
Received: by mail-pd0-f179.google.com with SMTP id ft15so9864635pdb.38
        for <fstests@vger.kernel.org>; Wed, 24 Sep 2014 20:55:47 -0700 (PDT)
Date: Thu, 25 Sep 2014 11:55:44 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] xfstests: add test for truncate/collapse range race
Message-ID: <20140925035544.GD13950@dhcp-13-216.nay.redhat.com>
References: <1403157004-25112-1-git-send-email-gux.fnst@cn.fujitsu.com>
 <1410948180-32610-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410948180-32610-1-git-send-email-gux.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 17, 2014 at 06:03:00PM +0800, Xing Gu wrote:
> This case tests truncate/collapse range race. If
> the race occurs, it will trigger BUG_ON.
> 
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  tests/generic/326     | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/326.out |  1 +
>  tests/generic/group   |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/generic/326
>  create mode 100644 tests/generic/326.out
> 
> diff --git a/tests/generic/326 b/tests/generic/326
> new file mode 100755
> index 0000000..8a66180
> --- /dev/null
> +++ b/tests/generic/326
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# FS QA Test No. 326
> +#
> +# Test truncate/collapse range race.
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

Missing "_supported_fs generic" here.

Thanks,
Eryu
> +_require_scratch
> +_require_xfs_io_command "fcollapse"
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +old_bug=`dmesg | grep -c "kernel BUG"`
> +
> +testfile=$SCRATCH_MNT/file.$seq
> +# fcollapse/truncate continuously and simultaneously
> +# a same file
> +for ((i=1; i <= 100; i++))
> +do
> +	for ((i=1; i <= 1000; i++))
> +	do
> +		$XFS_IO_PROG -f -c 'truncate 100k' $testfile 2>> $seqres.full
> +		$XFS_IO_PROG -f -c 'fcollapse 0 16k' $testfile 2>> $seqres.full
> +	done &
> +	for ((i=1; i <= 1000; i++))
> +	do
> +		$XFS_IO_PROG -f -c 'truncate 0' $testfile 2>> $seqres.full
> +	done &
> +done
> +
> +wait
> +
> +new_bug=`dmesg | grep -c "kernel BUG"`
> +if [ $new_bug -ne $old_bug ]; then
> +	echo "kernel bug detected, check dmesg for more infomation."
> +fi
> +
> +status=0 ; exit
> diff --git a/tests/generic/326.out b/tests/generic/326.out
> new file mode 100644
> index 0000000..90a76cc
> --- /dev/null
> +++ b/tests/generic/326.out
> @@ -0,0 +1 @@
> +QA output created by 326
> diff --git a/tests/generic/group b/tests/generic/group
> index bdcfd9d..b690f5c 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -145,3 +145,4 @@
>  323 auto aio stress
>  324 auto fsr quick
>  325 auto quick data log
> +326 auto
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
