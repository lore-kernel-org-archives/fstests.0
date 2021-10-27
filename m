Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AF8C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Oct 2021 03:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B64C60F39
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Oct 2021 03:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhJ0DUO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Oct 2021 23:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237933AbhJ0DUO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Oct 2021 23:20:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 477E361040;
        Wed, 27 Oct 2021 03:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635304669;
        bh=aVWXoPCHr+c9LvOMamxUwk/fuXl1q9oaLKbl6Br/epg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STyEjjZlGZ+ax6ZiMTsmhEqOk60cW43CGmFFdvk9IXU92oCyox9ceUTxu9tiWCuRW
         HAiahFK9APpEAgNGwUJfxUM6BtpaWk9lt3vitUL7GqP6V168pFeaEq3I5EEICs2hd1
         gd8k03JbsTuKbzxbqE3U4Vw/wDQv8tlFrmN2EKdhivlIwWLbC8CuzT3jyAaLqA00ab
         fv+M8NX5fQ7fdW8w+hAcsXkewnFHnraHzZxnFKXM+iKoDUB5WstGqTI1S7fMCTsrKk
         JEhPNciXJbnT1PYWE+BrUcLl0k6dKbhVCVK2Cra1NUrLOwpKFwNcbOAzfwyNmIWGws
         Ef5aPkXhdailQ==
Date:   Tue, 26 Oct 2021 20:17:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH V2] fstests: _require_dm_target should not always skip
 DAX capable devices
Message-ID: <20211027031748.GO24282@magnolia>
References: <20211026023622.914273-1-david@fromorbit.com>
 <20211026154240.GN24282@magnolia>
 <20211026235058.GB4821@dread.disaster.area>
 <20211027002650.GF24333@magnolia>
 <20211027013842.GC4821@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027013842.GC4821@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 27, 2021 at 12:38:42PM +1100, Dave Chinner wrote:
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

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> Version 2:
> -use -w for grep command to do exact word matching for options.
> 
>  common/rc | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f693d39..75197453 100644
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
> +	echo $ops | egrep -qw "dax(=always| |$)" && return 0
> +	echo $ops | grep -qw "dax=never" && return 1
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
