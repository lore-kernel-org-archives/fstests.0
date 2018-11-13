Received: from userp2130.oracle.com ([156.151.31.86]:44406 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbeKMUZY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Nov 2018 15:25:24 -0500
Subject: Re: [PATCH] btrfs: fix computation of max fs size for multiple device
 fs tests
References: <20181106153437.26870-1-fdmanana@kernel.org>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <4daaaa0e-b25f-4412-3b2f-0ccd578972a9@oracle.com>
Date: Tue, 13 Nov 2018 18:27:56 +0800
MIME-Version: 1.0
In-Reply-To: <20181106153437.26870-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>



On 11/06/2018 11:34 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We were sorting numerical values with the 'sort' tool without telling it
> that we are sorting numbers, giving us unexpected ordering. So just pass
> the '-n' option to the 'sort' tool.
> 
> Example:
> 
> $ echo -e "11\n9\n20" | sort
> 11
> 20
> 9
> 
> $ echo -e "11\n9\n20" | sort -n
> 9
> 11
> 20
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for the fix.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



> ---
>   tests/btrfs/124 | 2 +-
>   tests/btrfs/125 | 2 +-
>   tests/btrfs/154 | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/124 b/tests/btrfs/124
> index ce3ad6aa..a52c65f6 100755
> --- a/tests/btrfs/124
> +++ b/tests/btrfs/124
> @@ -61,7 +61,7 @@ dev2=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
>   dev1_sz=`blockdev --getsize64 $dev1`
>   dev2_sz=`blockdev --getsize64 $dev2`
>   # get min of both
> -max_fs_sz=`echo -e "$dev1_sz\n$dev2_sz" | sort | head -1`
> +max_fs_sz=`echo -e "$dev1_sz\n$dev2_sz" | sort -n | head -1`
>   # Need disks with more than 2G.
>   if [ $max_fs_sz -lt 2000000000 ]; then
>   	_scratch_dev_pool_put
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index e38de264..5ac68b67 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -68,7 +68,7 @@ dev2_sz=`blockdev --getsize64 $dev2`
>   dev3_sz=`blockdev --getsize64 $dev3`
>   
>   # get min of both.
> -max_fs_sz=`echo -e "$dev1_sz\n$dev2_sz\n$dev3_sz" | sort | head -1`
> +max_fs_sz=`echo -e "$dev1_sz\n$dev2_sz\n$dev3_sz" | sort -n | head -1`
>   # Need disks with more than 2G
>   if [ $max_fs_sz -lt 2000000000 ]; then
>   	_scratch_dev_pool_put
> diff --git a/tests/btrfs/154 b/tests/btrfs/154
> index 99ea232a..cd6c688f 100755
> --- a/tests/btrfs/154
> +++ b/tests/btrfs/154
> @@ -51,7 +51,7 @@ DEV1_SZ=`blockdev --getsize64 $DEV1`
>   DEV2_SZ=`blockdev --getsize64 $DEV2`
>   
>   # get min
> -MAX_FS_SZ=`echo -e "$DEV1_SZ\n$DEV2_SZ" | sort | head -1`
> +MAX_FS_SZ=`echo -e "$DEV1_SZ\n$DEV2_SZ" | sort -n | head -1`
>   # Need disks with more than 2G
>   if [ $MAX_FS_SZ -lt 2000000000 ]; then
>   	_scratch_dev_pool_put
> 
