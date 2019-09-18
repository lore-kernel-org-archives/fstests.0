Received: from aserp2120.oracle.com ([141.146.126.78]:54794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfIRHy7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Sep 2019 03:54:59 -0400
Subject: Re: [PATCH 2/2] fstests: btrfs/011: Handle finished scrub/replace
 operation gracefully
References: <20190918065626.34902-1-wqu@suse.com>
 <20190918065626.34902-2-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <2b6c6153-d4e0-f776-2c7c-4aa4c6331b39@oracle.com>
Date: Wed, 18 Sep 2019 15:54:49 +0800
MIME-Version: 1.0
In-Reply-To: <20190918065626.34902-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 18/9/19 2:56 PM, Qu Wenruo wrote:
> [BUG]
> When btrfs/011 is executed on a fast enough system (fully memory backed
> VM, with test device has unsafe cache mode), the test can fail like
> this:
> 
>    btrfs/011 43s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests-dev/results//btrfs/011.out.bad)
>      --- tests/btrfs/011.out     2019-07-22 14:13:44.643333326 +0800
>      +++ /home/adam/xfstests-dev/results//btrfs/011.out.bad      2019-09-18 14:49:28.308798022 +0800
>      @@ -1,3 +1,4 @@
>       QA output created by 011
>       *** test btrfs replace
>      -*** done
>      +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>      +(see /home/adam/xfstests-dev/results//btrfs/011.full for details)
>      ...
> 
> [CAUSE]
> Looking into the full output, it shows:
>    ...
>    Replace from /dev/mapper/test-scratch1 to /dev/mapper/test-scratch2
> 
>    # /usr/bin/btrfs replace start -f /dev/mapper/test-scratch1 /dev/mapper/test-scratch2 /mnt/scratch
>    # /usr/bin/btrfs replace cancel /mnt/scratch
>    INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not started
>    failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
> 
> So this means the replace is already finished before we cancel it.
> For fast system, it's very common.
> 
> [FIX]
> Instead of using _run_btrfs_util_prog which requires 0 as return value,
> we just call "$BTRFS_UTIL_PROG replace cancel" and ignore all its
> stderr/stdout, and completely rely on "$BTRFS_UTIL_PROG replace status"
> output to verify the work.
> 
> Furthermore if we finished replac before cancelling it, we should
> replace again to switch the device back, or after the test case, btrfs
> check will fail as there is no valid btrfs on that replaced device.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/011 | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 89bb4d11..858b00e8 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -148,13 +148,25 @@ btrfs_replace_test()
>   		# background the replace operation (no '-B' option given)
>   		_run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
>   		sleep 1
> -		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
> +		# 1s is enough for fast system to finish replace, so here we
> +		# ignore all the output, completely rely on later status
> +		# output to determine
> +		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT &> /dev/null
>   
>   		# 'replace status' waits for the replace operation to finish
>   		# before the status is printed
>   		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>   		cat $tmp.tmp >> $seqres.full
> -		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) failed"
> +		grep -q -e canceled -e finished $tmp.tmp ||\
> +			_fail "btrfs replace status (canceled) failed"
> +
> +		# If replace finished before cancel, replace them back or
> +		# the final fsck after test case will fail as there is no btrfs
> +		# on the $source_dev anymore
> +		if grep -q -e finished $tmp.tmp ; then
> +			$BTRFS_UTIL_PROG replace start -Bf $replace_options \
> +				$target_dev $source_dev $SCRATCH_MNT
> +		fi
>   	else
>   		if [ "${quick}Q" = "thoroughQ" ]; then
>   			# On current hardware, the thorough test runs
> 

Faced the same problem before. But I don't have a good solution
to fix. Because the idea of the test case appears to test the replace
cancel. This change makes it not to error if replace is not running
in the first place.

Thanks, Anand
