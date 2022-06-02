Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16CEC43334
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 02:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiFBCDd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 22:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiFBCD3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 22:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E8AE48
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 19:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2CE661651
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 02:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D8BC385A5;
        Thu,  2 Jun 2022 02:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654135407;
        bh=Y9fcFfWqjrFSsAeMtH4041oQsqOAgqSaRK113lftenE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/EHWR4IF9sKiGoBDKujWPZZXW5EKPB9RnxswjvRAIgxCcpkbbxThyX0wbPcSsCFw
         gA4cP3UsyRwesvHJPWFiKHyOyBihdSekw4NpX8pP07YBGnEowe0puOzc2IxlhnrS6L
         i1JxmEjPiIyMVZ70JcU7jo8UwjTAlHuKME8C+FWCOKy0pB6IpqfUFZP3/1hRtC4mGw
         pw4zif/ieKP+0m504xPIJRiLx+KImGi3bdv9QQ0fh35MpdbXLSwh8PX675D99hGMUX
         ptr8vKc00K7y/08E+Fnuj7KHusX2vwCl8crljYfhUYHV1m8/Wvb0UPSatKM1oY7Cn1
         m2SyP5/jcB8yA==
Date:   Wed, 1 Jun 2022 19:03:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/8] generic/081: don't run on DAX capable devices
Message-ID: <YpgabpNTG0hC1zmF@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-4-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:31:21AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> LVM/DM has conniptions when you try to use snapshots on a device
> that has DAX capability. It first sets up the underlying device as a
> DAX capable mapping (type 3 or DM_TYPE_DAX_BIO_BASED) but because
> snapshots require COW and shared mappings, it isn't supported on DAX
> capable devices. Hence creating the snapshot device fails because it
> requires a type 1 (DM_TYPE_BIO_BASED) device and DM can't change
> types on a loaded mapping.
> 
> Hence we get this obscure error message in the log:
> 
> device-mapper: ioctl: can't change device type (old=3 vs new=1) after initial table load.
> 
> and these obscure, unhelpful error messages from the LVM command
> outputs:
> 
>   device-mapper: reload ioctl on  (251:0) failed: Invalid argument
>   Failed to suspend logical volume vg_081/base_081.
>   Device vg_081-base_081-real (251:1) is used by another device.
>   Failed to revert logical volume vg_081/base_081.
>   Aborting. Manual intervention required.
> Failed to create snapshot
> 
> How to turn off DAX capability is not documented in dmsetup or LVM
> man pages, nor is dax mentioned anywhere in
> Documentation/admin/device-mapper/ so I have no idea how to tell
> LVM/DM "don't try to enable DAX support!".
> 
> As such, if the uderlying block device is dax capable, skip this
> test.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Seems reasonable to me, who also sees weird problems on the dax vms...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 2f31ca46..c334cfbf 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2116,21 +2116,33 @@ _require_sane_bdev_flush()
>  # Decide if the scratch filesystem is likely to be mounted in fsdax mode.
>  # It goes 3 ways based on mount options::
>  #	1. "dax" or "dax=always" means always test using DAX
> -#	2. "dax=never" means we'll never use DAX
> +#	2. "dax=never" means we'll never use DAX.
>  #	3. "dax=inode" or nothing means "use scratch dev capability" to
>  #	    determine whether DAX is going to be used.
>  #
> -# Returns 0 if DAX will be used, 1 if DAX is not going to be used.
> +# Case 2 and 3 basically mean the same thing for the purpose of
> +# _require_dm_target(). If the fs is not forcing the use of DAX, then DAX
> +# can only be enabled if the underlying block device supports it.
> +#
> +# Returns 0 if the filesytem will use DAX, 1 if it won't.
>  __scratch_uses_fsdax()
>  {
>  	local ops=$(_normalize_mount_options "$MOUNT_OPTIONS")
>  
>  	echo $ops | egrep -qw "dax(=always| |$)" && return 0
> -	echo $ops | grep -qw "dax=never" && return 1
> +	return 1
> +}
>  
> +# Determine if the scratch device is DAX capable. Even if the fs is not
> +# using DAX, we still can't use certain device mapper targets if the block
> +# device is DAX capable. Hence the check needs to be separat from the FS
> +# capability.
> +__scratch_dev_has_dax()
> +{
>  	local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
>  	test -e "${sysfs}/dax" && return 0
>  	test "$(cat "${sysfs}/queue/dax" 2>/dev/null)" = "1" && return 0
> +
>  	return 1
>  }
>  
> @@ -2147,15 +2159,18 @@ _require_dm_target()
>  	_require_sane_bdev_flush $SCRATCH_DEV
>  	_require_command "$DMSETUP_PROG" dmsetup
>  
> -	if __scratch_uses_fsdax; then
> -		case $target in
> -		stripe|linear|log-writes)
> -			;;
> -		*)
> -			_notrun "Cannot run tests with DAX on $target devices."
> -			;;
> -		esac
> -	fi
> +	case $target in
> +	stripe|linear|log-writes)
> +		;;
> +	*)
> +		if __scratch_uses_fsdax; then
> +			_notrun "Cannot run tests with fsdax on $target devices."
> +		fi
> +		if __scratch_dev_has_dax; then
> +			_notrun "Cannot use $target devices on DAX capable block devices."
> +		fi
> +		;;
> +	esac
>  
>  	modprobe dm-$target >/dev/null 2>&1
>  
> -- 
> 2.35.1
> 
