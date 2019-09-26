Received: from mail-pg1-f194.google.com ([209.85.215.194]:43131 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfIZIMk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 04:12:40 -0400
Date: Thu, 26 Sep 2019 16:12:32 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] btrfs: Add regression test for SINGLE profile conversion
Message-ID: <20190926081230.GX2622@desktop>
References: <20190926072635.9310-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926072635.9310-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, wqu@suse.com
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 26, 2019 at 10:26:35AM +0300, Nikolay Borisov wrote:
> This is a regression test for the bug fixed by
> 'btrfs: Fix a regression which we can't convert to SINGLE profile'
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tests/btrfs/194     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
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
> +# Test that block groups profile can be converted to SINGLE. This is a regression
> +# test for 'btrfs: Fix a regression which we can't convert to SINGLE profile'
> +#
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
> +$BTRFS_UTIL_PROG balance start -dconvert=single $SCRATCH_MNT > $seqres.full 2>&1
> +[ $? -eq 0 ] || _fail "Convert failed"

This indicates we're missing profile conversion tests in fstests. I
think it's better to add a test framework/helpers and a full set of
profile conversion tests instead of this raid1->single special case.

e.g.

Define a test case array, which describes what's the src/dst of this
conversion and how many devices this case requires, e.g.

test_cases=(
        # $nr_dev_min:$metadata:$data:$metadata_convert:$data_convert
        "2:single:single:raid0:raid0"
        "2:single:single:raid1:raid1"
        "2:single:single:raid1:raid0"
        "3:single:single:raid5:raid5"
        "4:single:single:raid6:raid6"
        "4:single:single:raid10:raid10"
        "2:raid0:raid0:raid1:raid0"
        "2:raid0:raid0:raid1:raid1"
        "3:raid0:raid0:raid5:raid5"
        "4:raid0:raid0:raid6:raid6"
        "4:raid0:raid0:raid10:raid10"
        "2:raid1:raid0:raid1:raid1"
        "3:raid1:raid0:raid5:raid5"
        "4:raid1:raid0:raid6:raid6"
        "4:raid1:raid1:raid10:raid10"
        "4:raid5:raid5:raid1:raid1"
        "4:raid5:raid5:raid6:raid6"
        "4:raid5:raid5:raid10:raid10"
        "4:raid6:raid6:raid1:raid1"
        "4:raid6:raid6:raid5:raid5"
        "4:raid6:raid6:raid10:raid10"
        "4:raid10:raid10:raid5:raid5"
        "4:raid10:raid10:raid6:raid6"
	<adding more cases>
)

Then, create btrfs in source profile and populate fs with different
kinds of files, compute sha1 digests of these files(fssum?), start
conversion, after conversion compare sha1 digests.

And perhaps we could split the test cases into group and add them to
different tests, in case putting all cases in a single test makes the
test time too long.

Thanks,
Eryu

> +
> +_scratch_umount
> +_scratch_dev_pool_put
> +
> +echo "Silence is golden"
> +status=0
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
> -- 
> 2.7.4
> 
