Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1C2C05027
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Feb 2023 11:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBFLNb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Feb 2023 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBFLNa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2023 06:13:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8652706
        for <fstests@vger.kernel.org>; Mon,  6 Feb 2023 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675681964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tL8veezodjWjtH5rs2UBkdL3ewpOHvR0JsGYzkWyHsY=;
        b=OejCsrCFbpDI0wd60CDcwuB6yJpWsWZ5Dv3v5p52JCULQNuRZ10VMX4tNbtdWEk48z3GtL
        KV7OvcZi0KOBoPhZy+qJposen5E7es8KV3Bgq2GAg0Z+xUXXC8uADXoW7u7GwkL9ctp573
        ODLGciCocadH4tFe4f03NmCrtZmIuXo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-jy7xDYWiPlGUo27Nwlg3bQ-1; Mon, 06 Feb 2023 06:12:40 -0500
X-MC-Unique: jy7xDYWiPlGUo27Nwlg3bQ-1
Received: by mail-pj1-f69.google.com with SMTP id a20-20020a17090ad81400b0022c3185ebbeso4384825pjv.3
        for <fstests@vger.kernel.org>; Mon, 06 Feb 2023 03:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL8veezodjWjtH5rs2UBkdL3ewpOHvR0JsGYzkWyHsY=;
        b=s+PGTFTHrnxt8YAXctXZ/qD0KSrITw/dfKYA1sK1J1HSNYqszhO1HR1G0c2fyXL9Bf
         ZkQfMQv75QF4PlNxLuu06LcujGCuUWYeyXFEGVTyFJvGn3iXLSaDAZ8IsdFr10wDWgWD
         ykMffH4HTrFcs+zigPt0bUl0Qx8wAEC2YAg348uqS/LKRR1kwQfB+CLSjsjZ8g+5Upqz
         +R1CfH+SsZRwTLlt+leUMrNrPYKylFKVmiihjPXWCPdZgonXLQfMSEGo8a+46wtjRRDU
         0VJade48n7lLEyvOBPKGF/9YuvhoKwiivHf7EoGCOt7DxxnaC7hF5jwsCBC/DWnHChRf
         1SbQ==
X-Gm-Message-State: AO0yUKV/bIx49VoiurQmSKIMjipC8OeNDxtf+4VOYkeT7XxgfapIDy2V
        D8hrdbYvFmRWRgwSHXiQ1ibuwv3yK0yNltKBkAyClKmI7futW9nx9OoGO1eZcBrh2fIEVdPZUHd
        intlK2UtoaphsGL6qPw==
X-Received: by 2002:a17:902:c611:b0:194:5fc9:f55a with SMTP id r17-20020a170902c61100b001945fc9f55amr16273764plr.35.1675681959488;
        Mon, 06 Feb 2023 03:12:39 -0800 (PST)
X-Google-Smtp-Source: AK7set+83GIzpXTBvQfgdGbynT6+oTigLqm2oRK2RnVyOVPs4Znr8gBwtm4FXIBAOJvs6+PF01I+jA==
X-Received: by 2002:a17:902:c611:b0:194:5fc9:f55a with SMTP id r17-20020a170902c61100b001945fc9f55amr16273745plr.35.1675681959012;
        Mon, 06 Feb 2023 03:12:39 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902aa9600b001965f761e6dsm6626021plr.182.2023.02.06.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:12:38 -0800 (PST)
Date:   Mon, 6 Feb 2023 19:12:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 3/3] common: Improve blocksize support for udf
Message-ID: <20230206111235.f2nwx2xmdwjtnv64@zlang-mailbox>
References: <20230131123809.28200-1-jack@suse.cz>
 <20230131124005.14207-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131124005.14207-3-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 31, 2023 at 01:39:59PM +0100, Jan Kara wrote:
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

This patch looks good to me, thanks for doing this for udf filesystem :)

It's been long time, no patches from udf list to fstests list. For exmaple,
The udf/102 missed the _setup_udf_scratchdir() helper (be removed) for long
time, if you're working on udf testing, you might be interested in it.
Anyway, I'll merge this patchset this week.

Reviewed-by: Zorro Lang <zlang@redhat.com>

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

