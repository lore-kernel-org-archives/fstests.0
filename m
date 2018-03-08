Received: from mail-pf0-f196.google.com ([209.85.192.196]:42105 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965207AbeCHGLI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Mar 2018 01:11:08 -0500
Date: Thu, 8 Mar 2018 14:10:59 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/146: make sure hit all stripes in the
 case of compression
Message-ID: <20180308061059.GI30836@localhost.localdomain>
References: <20180308055645.22917-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308055645.22917-1-lufq.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 08, 2018 at 01:56:45PM +0800, Lu Fengqi wrote:
> In the case of compression, each 128K input data chunk will be compressed
> to 4K (because of the characters written are duplicate). Therefore we have
> to write (128K * 16) to make sure every stripe can be hit.
> 
> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
> ---
> 
> V2: Modify the regular expression to ensure that it matches various
> compress mount options.
> 
>  tests/btrfs/146 | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/146 b/tests/btrfs/146
> index 7071c128ca0a..a51eda68eaf3 100755
> --- a/tests/btrfs/146
> +++ b/tests/btrfs/146
> @@ -74,9 +74,16 @@ _scratch_pool_mkfs "-d raid0 -m raid1" > $seqres.full 2>&1
>  _scratch_mount
>  
>  # How much do we need to write? We need to hit all of the stripes. btrfs uses
> -# a fixed 64k stripesize, so write enough to hit each one
> +# a fixed 64k stripesize, so write enough to hit each one. In the case of
> +# compression, each 128K input data chunk will be compressed to 4K (because of
> +# the characters written are duplicate). Therefore we have to write (128K * 16)
> +# to make sure every stripe can be hit.
>  number_of_devices=`echo $SCRATCH_DEV_POOL | wc -w`
> -write_kb=$(($number_of_devices * 64))
> +if ! echo $MOUNT_OPTIONS | grep -qoP 'compress(-force)?(=(?!no)|,|$)'; then

I'm wondering if we could just write ($number_of_devices * 2048)K data
unconditionally, so we could get rid of this case switch and the fancy
perl style regexp?

Thanks,
Eryu

> +	write_kb=$(($number_of_devices * 64))
> +else
> +	write_kb=$(($number_of_devices * 2048))
> +fi
>  _require_fs_space $SCRATCH_MNT $write_kb
>  
>  testfile=$SCRATCH_MNT/fsync-err-test
> -- 
> 2.16.2
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
