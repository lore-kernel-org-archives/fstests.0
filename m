Received: from mail-pl1-f194.google.com ([209.85.214.194]:35407 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1Ogw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Nov 2018 09:36:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so6384735plo.2
        for <fstests@vger.kernel.org>; Tue, 27 Nov 2018 19:36:48 -0800 (PST)
Date: Wed, 28 Nov 2018 11:36:40 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 2/3] ext4: 032: fail nicely if the test partition is not
 big enough for the test
Message-ID: <20181128033640.GR3889@desktop>
References: <20181127214308.137410-1-gwendal@chromium.org>
 <20181127214308.137410-3-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127214308.137410-3-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 27, 2018 at 01:43:07PM -0800, Gwendal Grignou wrote:
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  tests/ext4/032 | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 8534ddd6..7d8c6da7 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -35,12 +35,21 @@ ext4_online_resize()
>  	local original_size=$1
>  	local final_size=$2
>  	local check_if_supported=${3:-0}
> +	local avail=`df -P $SCRATCH_DIR | awk 'END {print $4}'`
> +	local requested=$(($final_size * $BLK_SIZ))
> +
> +	if [ $avail -lt $requested ]; then
> +		echo "+++ not enough space on $SCRATCH_DIR: " \
> +		     "requested $requested only $avail left" | \
> +			tee -a $seqres.full
> +		_notrun "incomplete test due to storage space constraint"
> +	fi

This doesn't look right to me. We can safely truncate to a very large
file size even if the size is bigger than the free space, it's just a
typical sparse file.

I guess the problem is that your SCRATCH_DEV is too small to hold the
post-resize fs image.

Thanks,
Eryu

>  
>  	## Start with a clean image file.
>  	echo "" > ${IMG_FILE}
>  	echo "+++ truncate image file to $final_size" | \
>  		tee -a $seqres.full
> -	$XFS_IO_PROG -f -c "truncate $(($final_size * $BLK_SIZ))" ${IMG_FILE}
> +	$XFS_IO_PROG -f -c "truncate $requested" ${IMG_FILE}
>  	LOOP_DEVICE=`_create_loop_device $IMG_FILE`
>  
>  	echo "+++ create fs on image file $original_size" | \
> -- 
> 2.18.1
> 
