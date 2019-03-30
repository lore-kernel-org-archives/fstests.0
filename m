Received: from mail-pg1-f194.google.com ([209.85.215.194]:36785 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfC3Jet (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 30 Mar 2019 05:34:49 -0400
Date: Sat, 30 Mar 2019 17:34:41 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] btrfs: Enable btrfs/003
Message-ID: <20190330093441.GZ2824@desktop>
References: <20190319105851.9280-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319105851.9280-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 19, 2019 at 12:58:51PM +0200, Nikolay Borisov wrote:
> For a long time this test has been failing on all kinds of VM configuration,
> which are using virtio_blk devices. This is due to the fact that scsi
> devices are deletable and virtio_blk are not. However, this only prevents
> device replace case to run and has no negative effect on the other
> useful test cases.
> 
> Re-enable btrfs/003 to run by making _require_deletable_scratch_dev_pool
> private to the test case and modifying it to return success (0) or
> failure (1) if devices are not deletable. Further modify the replace
> test case to check the return value of this function and skip it if
> devices are not deletable.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  common/rc       | 12 ------------
>  tests/btrfs/003 | 19 ++++++++++++++++++-
>  2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 1c42515ff0ea..5693ba3cad18 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2961,18 +2961,6 @@ _require_scratch_dev_pool_equal_size()
>  	done
>  }
>  
> -# We will check if the device is deletable
> -_require_deletable_scratch_dev_pool()
> -{
> -	local i
> -	local x
> -	for i in $SCRATCH_DEV_POOL; do
> -		x=`echo $i | cut -d"/" -f 3`
> -		if [ ! -f /sys/class/block/${x}/device/delete ]; then
> -			_notrun "$i is a device which is not deletable"
> -		fi
> -	done
> -}
>  
>  # Check that fio is present, and it is able to execute given jobfile
>  _require_fio()
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index 938030ef4c65..2aeb9fe6325a 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -17,6 +17,21 @@ dev_removed=0
>  removed_dev_htl=""
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> +# Check if all scratch dev pools are deletable
> +_require_deletable_scratch_dev_pool()

Then it's not a _require rule anymore, maybe we could just rename it to
something like "deletable_scratch_dev_pool"? Also remove the leading "_"
if it becomes a private function.

Thanks,
Eryu

> +{
> +	local i
> +	local x
> +	for i in $SCRATCH_DEV_POOL; do
> +		x=`echo $i | cut -d"/" -f 3`
> +		if [ ! -f /sys/class/block/${x}/device/delete ]; then
> +			return 1
> +		fi
> +	done
> +
> +	return 0
> +}
> +
>  _cleanup()
>  {
>      cd /
> @@ -35,7 +50,6 @@ _supported_fs btrfs
>  _supported_os Linux
>  _require_scratch
>  _require_scratch_dev_pool 4
> -_require_deletable_scratch_dev_pool
>  _require_command "$WIPEFS_PROG" wipefs
>  
>  rm -f $seqres.full
> @@ -111,6 +125,9 @@ _test_replace()
>  	local ds
>  	local d
>  
> +	# If scratch devs are not deletable skip this test
> +	if ! _require_deletable_scratch_dev_pool; then return 0; fi
> +
>  	# exclude the first and the last disk in the disk pool
>  	n=$(($n-1))
>  	ds=${devs[@]:1:$(($n-1))}
> -- 
> 2.7.4
> 
