Received: from mout.gmx.net ([212.227.17.21]:48965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbfIZHuf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Sep 2019 03:50:35 -0400
Subject: Re: [PATCH] btrfs: Add regression test for SINGLE profile conversion
References: <20190926072635.9310-1-nborisov@suse.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6a8d0118-86a6-b187-1183-4e47a260b0a6@gmx.com>
Date: Thu, 26 Sep 2019 15:50:22 +0800
MIME-Version: 1.0
In-Reply-To: <20190926072635.9310-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>



On 2019/9/26 =E4=B8=8B=E5=8D=883:26, Nikolay Borisov wrote:
> This is a regression test for the bug fixed by
> 'btrfs: Fix a regression which we can't convert to SINGLE profile'
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  tests/btrfs/194     | 52 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/btrfs/194.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 55 insertions(+)
>  create mode 100755 tests/btrfs/194
>  create mode 100644 tests/btrfs/194.out
>
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 000000000000..8935defd3f5e
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test that block groups profile can be converted to SINGLE. This is a =
regression
> +# test for 'btrfs: Fix a regression which we can't convert to SINGLE pr=
ofile'
> +#
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
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +_scratch_pool_mkfs -draid1
> +
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG balance start -dconvert=3Dsingle $SCRATCH_MNT > $seqre=
s.full 2>&1
> +[ $? -eq 0 ] || _fail "Convert failed"
> +
> +_scratch_umount
> +_scratch_dev_pool_put
> +
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> new file mode 100644
> index 000000000000..7bfd50ffb5a4
> --- /dev/null
> +++ b/tests/btrfs/194.out
> @@ -0,0 +1,2 @@
> +QA output created by 194
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b92cb12ca66f..6a11eb1b8230 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>  191 auto quick send dedupe
>  192 auto replay snapshot stress
>  193 auto quick qgroup enospc limit
> +194 auto quick volume balance
>
