Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B02C54EAA
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 16:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjA3QzR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 11:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjA3QzQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 11:55:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CDA3D931
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 08:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675097670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+gNtsCfOW/4nZogkNifctL/uC+p/h1xy6+ZEqixrUE=;
        b=gRm45/fRomtUlBj7h6HjTf0RljUyfaNq0h+4T7iQV6PDsKaLgTkCYGKCQjb5u4bmtXNXnZ
        VZZdg8Gz8WFSok3uidXoF969Z46IVzC/Ha30Gpb1rcmPbmWsY638qrKv1xHj5bqlgK192l
        3R+Oz8VQlvDfyukVqXEV0e9NzAdRQR8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-aHSDp1U4PDG7Ycc92j1vgQ-1; Mon, 30 Jan 2023 11:54:29 -0500
X-MC-Unique: aHSDp1U4PDG7Ycc92j1vgQ-1
Received: by mail-pg1-f198.google.com with SMTP id k16-20020a635a50000000b0042986056df6so5381810pgm.2
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 08:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+gNtsCfOW/4nZogkNifctL/uC+p/h1xy6+ZEqixrUE=;
        b=q9u78X+UGwTQVPmGdvC7n/ygkG7GussOrNeRs6WRkunFnC1Yk0KEKJqPkgZQovIvur
         bgb3hzJDB0wfxPaYnWCxwtBubaxrS5xo+8vGR4JzJb2VxvsBvOIxlKo1WazlKeIoNI/g
         pC0/J16OKYoVVujxxa6YHpQL7b4xEsU6WZlQogs0FD9CUisNsvMATJxoI9sVNn9b3Ud0
         KPvHegZr9+HDZP0gGWjJTiw74RcQ0S+Y/xC7wmvftEOf/Ibz005yoHtd5q02OXgjRnAI
         nXG3OrKkM6Q7eEC2fbVTjEhnflbdOAWnEwgDO5DVgNObhdzSrlaToWw7+YMPoKo+/mBY
         k1Kw==
X-Gm-Message-State: AO0yUKW8jI2RPibakBAccBgKOYpSsF4ez/0rxZ+4SbV4OYx4OkEaoM/O
        XpVc5vTDaXBok7yxE2Nurjen973mGRgNclXMkG2lYMacQsrHjdZRiyQnKav4GzGsVq+5tMCOMBW
        SMBL0nG26W+bAg0NqUQ==
X-Received: by 2002:a17:903:4093:b0:194:7f1f:7dfc with SMTP id z19-20020a170903409300b001947f1f7dfcmr6663449plc.42.1675097668131;
        Mon, 30 Jan 2023 08:54:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/k4w3gI59j4eCjU3/YLNbugPpxZgEPi3d7LZIBXroFjIg1nx6pvDKOum6ojBvtpUiWWsXekg==
X-Received: by 2002:a17:903:4093:b0:194:7f1f:7dfc with SMTP id z19-20020a170903409300b001947f1f7dfcmr6663437plc.42.1675097667788;
        Mon, 30 Jan 2023 08:54:27 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b00192d9b86318sm8057367plb.137.2023.01.30.08.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:54:27 -0800 (PST)
Date:   Tue, 31 Jan 2023 00:54:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common: Improve blocksize support for udf
Message-ID: <20230130165423.r2okhrub4mkdhbwx@zlang-mailbox>
References: <20230123093800.3394-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123093800.3394-1-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 23, 2023 at 10:38:00AM +0100, Jan Kara wrote:
> Add better support for blocksize selection in _scratch_mkfs_sized
> (accept another variant of mkfs options, select correct default block
> size if not specified). Also add blocksize selection support to
> _scratch_mkfs_blocksized.
> 
> For _check_udf_filesystem to keep working when blocksize is not
> specified in MKFS_OPTIONS, add detection of blocksize from a mounted
> filesystem.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Is this patch a replacement of below patch ?
  [PATCH 1/2] common: Provide blocksize and ecclength to udf fsck

Due to you've sent a patchset, and that 2nd patch has been reviewed but
not merged:
  [PATCH 2/2] common: Unmount udf filesystem prior checking

I'm not sure if you write this one singly to replace the 1st patch, or be a
supplement. Can you send these 2 or 3 patches in one patchset :)

Thanks,
Zorro

>  common/rc | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f80afe7aeec..e49918c9deab 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -922,9 +922,15 @@ _scratch_mkfs_sized()
>  	btrfs)
>  		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
>  		;;
> -	ext2|ext3|ext4|ext4dev|udf|reiser4|ocfs2|reiserfs)
> +	ext2|ext3|ext4|ext4dev|reiser4|ocfs2|reiserfs)
>  		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
>  		;;
> +	udf)
> +		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
> +		if [ -z "$def_blksz" ]; then
> +			def_blksz=512
> +		fi
> +		;;
>  	jfs)
>  		def_blksz=4096
>  		;;
> @@ -1116,6 +1122,9 @@ _scratch_mkfs_blocksized()
>  		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS --block_size=$blocksize \
>  								$SCRATCH_DEV
>  		;;
> +	udf)
> +		_scratch_mkfs -b $blocksize
> +		;;
>  	*)
>  		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
>  		;;
> @@ -3074,17 +3083,18 @@ _check_udf_filesystem()
>  	return
>      fi
>  
> +    local device=$1
> +    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
> +    if [ -z "$blksz" ]; then
> +	blksz=512
> +    fi
>      # Is the filesystem mounted?
>      local type=`_fs_type $device`
>      if [ "$type" = "$FSTYP" ]; then
> +	blksz=`blockdev --getbsz $device`
>  	local mountpoint=`_umount_or_remount_ro $device`
>      fi
>  
> -    local device=$1
> -    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
> -    if [ -z "$blksz" ]; then
> -	blksz=512
> -    fi
>      local opt_arg="-ecclength 1 -blocksize $blksz"
>      if [ $# -eq 2 ]; then
>  	opt_arg+=" -lastvalidblock $(( $2 - 1 ))"
> -- 
> 2.35.3
> 

