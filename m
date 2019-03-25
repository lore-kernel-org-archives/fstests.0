Received: from userp2130.oracle.com ([156.151.31.86]:52418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbfCYMgi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Mar 2019 08:36:38 -0400
Subject: Re: [PATCH] fstests: Verify that removed device has its superblocks
 deleted
References: <20190325094200.18687-1-nborisov@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <620fe973-9b9a-8915-8b41-bb1baccfee2b@oracle.com>
Date: Mon, 25 Mar 2019 20:36:19 +0800
MIME-Version: 1.0
In-Reply-To: <20190325094200.18687-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: guaneryu@gmail.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 3/25/19 5:42 PM, Nikolay Borisov wrote:
> When a device is removed from a btrfs filesystem its superblock copies
> must be deleted. This test ensures this is indeed the case.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   tests/btrfs/184     | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/184.out |  2 ++
>   tests/btrfs/group   |  1 +
>   3 files changed, 60 insertions(+)
>   create mode 100755 tests/btrfs/184
>   create mode 100644 tests/btrfs/184.out
> 
> diff --git a/tests/btrfs/184 b/tests/btrfs/184
> new file mode 100755
> index 000000000000..3bf7d201a145
> --- /dev/null
> +++ b/tests/btrfs/184
> @@ -0,0 +1,57 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
> +#
> +# FS QA Test 184
> +#
> +# Verify that when a device is removed from a multi-device
> +# filesystem its superblock copies are correctly deleted
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
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_scratch_dev_pool 2
> +_require_btrfs_command inspect-internal dump-super
> +
> +_scratch_pool_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# pick last dev in the list
> +dev_del=`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`

> +$BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs device delete failed"

  Device delete will fail with the raid1 mkfs option in the config fail.

Thanks, Anand


> +for i in {0..2}; do
> +    output=$($BTRFS_UTIL_PROG inspect-internal dump-super -s $i $dev_del 2>&1)
> +    $BTRFS_UTIL_PROG inspect-internal dump-super -s $i $dev_del 2>&1 | grep -q "bad magic"
> +    ret=$?
> +    if [[ "$output" != "" && $ret -eq 1 ]]; then
> +        _fail "Deleted dev superblocks not scratched"
> +    fi
> +done
> +_scratch_unmount
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/184.out b/tests/btrfs/184.out
> new file mode 100644
> index 000000000000..b4ce96cfc047
> --- /dev/null
> +++ b/tests/btrfs/184.out
> @@ -0,0 +1,2 @@
> +QA output created by 184
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index f3227c1708d9..c1d215bf5ff8 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -186,3 +186,4 @@
>   181 auto quick balance
>   182 auto quick balance
>   183 auto quick clone compress punch
> +184 auto quick volume
> 
