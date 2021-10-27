Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1957BC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Oct 2021 11:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB046103C
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Oct 2021 11:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbhJ0LtF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235172AbhJ0LtF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Oct 2021 07:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635335199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbkKebWtpH9Vgh0e6I4BpTM0SPTS91XRORqJUDpgT18=;
        b=I1cS7qkhxoLUue+3OywA0cgZxxh3wLKJKFilJhHGspE80D6bZzl8zWcL+hNHQ9TuYCx5of
        SKfLpxfojDq+bv7LQY4rsHEvtPnylShleoXdkWv/ntZUL6w/SVso8pGkrXvMdoQRw6PUsW
        zKFtUqM83SyaDhN8sIFTIequFgDT7c8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-lDfM01GsNJSp9pwjZ-t9Cw-1; Wed, 27 Oct 2021 07:46:37 -0400
X-MC-Unique: lDfM01GsNJSp9pwjZ-t9Cw-1
Received: by mail-pl1-f198.google.com with SMTP id o6-20020a170902778600b0013c8ce59005so1131736pll.2
        for <fstests@vger.kernel.org>; Wed, 27 Oct 2021 04:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=qbkKebWtpH9Vgh0e6I4BpTM0SPTS91XRORqJUDpgT18=;
        b=wfuM02Pd99ZZsVbK89+n86dJ/kX7x9Wy+9wVBA1ZzBfAo3gKpIYnG1buKKF1RV05Pp
         XFhRG4zMFbG9G8triEBurAPbZoDUWYfvAbVqnU+dipK9rqNZBRcBY46FIrUwI9YrLks7
         XZxB+uFzYvj6M6znON8pme3sZUe4UHswMN0u4m47BsQjpnLPJQKuSS3IPNuNg51cvuo5
         4b7YGoIwLQeuPOmMAVVjGQv8hdnEpZsLCjgPxZW0QNeaGfGsx+YkPYnV6cHBRp5Wy1ez
         ymPAwaXmMaQdjA25ATD57mKBzCxTRzmS5RWBpJTwk1ZOwxnffXpR6sOVmNa3umfxh7Ld
         0otQ==
X-Gm-Message-State: AOAM533BVW+M3WbijWjlkKWhS3rGJkMS5DooNLQstRNdcEKI8JJ4jW6a
        1QGGQsfkbmvbZpfoQBH4Sxsuip+Loo4+pmbjTjCzxXnmjJx+sQVf9wBCoK+irmSeiPBhzI1HMzf
        +7nKwegx3MSaGvgTIN67avcYhLw5QEKI5LkwIdT/SFthiN5oBnaDYK4w0lC2jcORpsA==
X-Received: by 2002:a05:6a00:16c6:b029:32d:e190:9dd0 with SMTP id l6-20020a056a0016c6b029032de1909dd0mr32245255pfc.70.1635335195970;
        Wed, 27 Oct 2021 04:46:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1Evc92mYg9wtYZejFLoAzgv2hIAbX5Rbth4Uwtsr93jTY4/kPXm9pwq/r7dPjtn/I42O8Ew==
X-Received: by 2002:a05:6a00:16c6:b029:32d:e190:9dd0 with SMTP id l6-20020a056a0016c6b029032de1909dd0mr32245214pfc.70.1635335195340;
        Wed, 27 Oct 2021 04:46:35 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r8sm22505770pgp.30.2021.10.27.04.46.34
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 04:46:34 -0700 (PDT)
Date:   Wed, 27 Oct 2021 20:04:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH V2] fstests: _require_dm_target should not always skip
 DAX capable devices
Message-ID: <20211027120446.ytl7gl3emfpy5x34@fedora>
Mail-Followup-To: fstests@vger.kernel.org
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
> ---

Make sense.

Reviewed-by: Zorro Lang <zlang@redhat.com>

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
> 

