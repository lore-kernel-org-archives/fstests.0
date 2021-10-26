Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E1C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Oct 2021 15:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3904B60FC2
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Oct 2021 15:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhJZPpG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235153AbhJZPpF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Oct 2021 11:45:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67FA560F92;
        Tue, 26 Oct 2021 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635262961;
        bh=6XUR6n6USkJGfLXDiv+fhLg4sqGsGepBrQ3g2rpZ2kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4YxcAOS/RpS/m5RNjmx1AtbkseMvv3KY5UuWuEM2r72txrdaYCF5CLlcWvRjiDKP
         TEy0Xfy4QA+jDHtkdwWAydbt6wegmJ2U4lEErpgtFNZJRt0vXH8FBTMNZwIKRkCbDt
         HbbTjfL2DsIfQjKLUseodfopgDDTu3rDp8kgTEDWxUKDcaRtPdzf0qUpaQqp00cDNv
         k2FXF9kKGFRfGjpcHqjDNJJmfxo5ySbQ+TCygy9nUVzt/uST+o1rVjdmMwVxyQwYqx
         JSou7AHO0bKv1hxmYUQ4m506kPG6c6YGmrXC3kVNuONV4uUvlM9TZyoUYGBgHFkOeE
         EdugMqZVLVQ1A==
Date:   Tue, 26 Oct 2021 08:42:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: _require_dm_target should not always skip DAX
 capable devices
Message-ID: <20211026154240.GN24282@magnolia>
References: <20211026023622.914273-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026023622.914273-1-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 26, 2021 at 01:36:22PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Recent changes have turned off all dm-error, dm-thin and dm-flakey
> tests on pmem devices even when we are not explicitly testing DAX.
> This is a regression resulting in a large number of log recovery
> tests no longer running on my pmem-based test VMs. I added the "-o
> dax=never" mount options to these test configs, only to find it
> still would not run the dm tests even though the filesystem will
> never use DAX.
> 
> Fix this so that the dm target DAX test explicitly ignores the
> the block device DAX capability when the filesystem is mounted with
> dax=never and hence we can use all the dm targets when the tests are
> being run with FSDAX disabled.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/rc | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f693d39..0cbe8a7d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1965,12 +1965,19 @@ _require_sane_bdev_flush()
>  }
>  
>  # Decide if the scratch filesystem is likely to be mounted in fsdax mode.
> -# If there's a dax clause in the mount options we assume the test runner
> -# wants us to test DAX; or if the scratch device itself advertises dax mode
> -# in sysfs.
> -__detect_scratch_fsdax()
> +# It goes 3 ways based on mount options::
> +#	1. "dax" or "dax=always" means always test using DAX
> +#	2. "dax=never" means we'll never use DAX
> +#	3. "dax=inode" or nothing means "use scratch dev capability" to
> +#	    determine whether DAX is going to be used.
> +#
> +# Returns 0 if DAX will be used, 1 if DAX is not going to be used.
> +__scratch_uses_fsdax()
>  {
> -	_normalize_mount_options | egrep -q "dax(=always| |$)" && return 0
> +	local ops=$(_normalize_mount_options)
> +
> +	echo $ops | egrep -q "dax(=always| |$)" && return 0
> +	echo $ops | grep -q "dax=never" && return 1

Question: Do you want grep -w here so that grep won't match on anything
that isn't a whole "word"?

e.g. MOUNT_OPTIONS="-o ihatedax=alwaysp*****gmeoff" shouldn't be a
match, right?

--D


>  
>  	local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
>  	test -e "${sysfs}/dax" && return 0
> @@ -1982,6 +1989,8 @@ __detect_scratch_fsdax()
>  _require_dm_target()
>  {
>  	local target=$1
> +	local fsdax
> +	local bdevdax
>  
>  	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
>  	# behaviour
> @@ -1989,7 +1998,7 @@ _require_dm_target()
>  	_require_sane_bdev_flush $SCRATCH_DEV
>  	_require_command "$DMSETUP_PROG" dmsetup
>  
> -	if __detect_scratch_fsdax; then
> +	if __scratch_uses_fsdax; then
>  		case $target in
>  		stripe|linear|log-writes)
>  			;;
> -- 
> 2.33.0
> 
