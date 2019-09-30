Received: from userp2120.oracle.com ([156.151.31.85]:52706 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfI3KQd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Sep 2019 06:16:33 -0400
Subject: Re: [PATCH] fstests: btrfs: Add regression test to check if btrfs can
 handle high devid
References: <20190930083735.21284-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <40bf9e23-3928-a7fc-d3b5-6f73753e314f@oracle.com>
Date: Mon, 30 Sep 2019 18:16:32 +0800
MIME-Version: 1.0
In-Reply-To: <20190930083735.21284-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 9/30/19 4:37 PM, Qu Wenruo wrote:
> Add a regression test to check if btrfs can handle high devid.
> 
> The test will add and remove devices to a btrfs fs, so that the devid
> will increase to uncommon but still valid values.
> 
> The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:
> tree-checker: Verify dev item").
> The fix is titled "btrfs: tree-checker: Fix wrong check on max devid".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Suggested-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>

one nit below.

> ---
>   tests/btrfs/194     | 73 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/194.out |  2 ++
>   tests/btrfs/group   |  1 +
>   3 files changed, 76 insertions(+)
>   create mode 100755 tests/btrfs/194
>   create mode 100644 tests/btrfs/194.out
> 
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 00000000..7a52ed86
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test if btrfs can handle large device ids.
> +#
> +# The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:
> +# tree-checker: Verify dev item").
> +# The fix is titlted: "btrfs: tree-checker: Fix wrong check on max devid"
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
> +_scratch_dev_pool_get 2
> +
> +# The wrong check limit is based on node size, to reduce runtime, we only
> +# support 4K page size system for now
> +if [ $(get_page_size) != 4096 ]; then
> +	_notrun "This test need 4k page size"
> +fi
> +
> +device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +
> +echo device_1=$device_1 device_2=$device_2 >> $seqres.full
> +
> +# Use 4K nodesize to reduce runtime
> +_scratch_mkfs -n 4k >> $seqres.full

  This init part should be _scratch_mkfs on only one device right?

Thanks, Anand

> +_scratch_mount
> +
> +# Add and remove device in a loop, one loop will increase devid by 2.
> +# for 4k nodesize, the wrong check will be triggered at devid 123.
> +# here 64 is enough to trigger such regression



> +for (( i = 0; i < 64; i++ )); do
> +	$BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG device del $device_1 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG device del $device_2 $SCRATCH_MNT
> +done


> +_scratch_dev_pool_put
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> new file mode 100644
> index 00000000..7bfd50ff
> --- /dev/null
> +++ b/tests/btrfs/194.out
> @@ -0,0 +1,2 @@
> +QA output created by 194
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b92cb12c..ef1f0e1b 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>   191 auto quick send dedupe
>   192 auto replay snapshot stress
>   193 auto quick qgroup enospc limit
> +194 auto
> 
