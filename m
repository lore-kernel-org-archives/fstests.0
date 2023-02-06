Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A34C05027
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Feb 2023 11:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBFLA4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Feb 2023 06:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBFLAy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2023 06:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE816AC2
        for <fstests@vger.kernel.org>; Mon,  6 Feb 2023 03:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675681207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PO8AgcK2K8tFlEPtsRXC2XUVM8JrE8mr43RtvB0Dgq0=;
        b=dAwa6NHYEUnlIcbNHXIga29T0sVeI4XW/J5RfIoZVg4fvF+q451pgeANxlZGKEGXtTjQ2E
        8IpEVKUYu6azqjtg3fd3BrkWP+j+sR5CJeQaMRn4UQJhkaSg8k6xr03jLAcTZa44s+Gm8d
        GpK9eKx5BFT6PX23aSn/zUNgsC7WdnU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-vHnhbs1UMz28vk8Q_0FAhQ-1; Mon, 06 Feb 2023 06:00:06 -0500
X-MC-Unique: vHnhbs1UMz28vk8Q_0FAhQ-1
Received: by mail-pf1-f200.google.com with SMTP id z7-20020aa79587000000b00593f19705d5so6311342pfj.10
        for <fstests@vger.kernel.org>; Mon, 06 Feb 2023 03:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO8AgcK2K8tFlEPtsRXC2XUVM8JrE8mr43RtvB0Dgq0=;
        b=NbLE+X++M/mXaOQf6n1/PFTRmN9AA1hS4ApYPKJXu+HtyTaWTKigEo1Hc0BR+USsL0
         Jt0fxYjYnE3qr7el9mTY3oqEy5qUS34Qo8vz8PBpgCNvvQTjn5iHccIEIBZITr6vZBgV
         IakJDXR46gob678+3WdUR2bUwzd2pyem6wWsvi5qn0SYXGFMAFT5k7eUW1Hb+z9hbaLF
         3TY2xVOBEISPSRxuJZQNjc6HYbz2ETUvpyLZQ152Tj14zi3jgbkFcZXoZizvbWqKst2R
         W/fkbxpEIo1sScfgnHlY0xqNvnGN1uI/fpxMyP2mXoOl7rNk0GQX1nYg+VZpGroX6oy+
         2n1A==
X-Gm-Message-State: AO0yUKWESOn/yw8AindBiIUO8xwgK9cqSpgUx+mlMPrToNENPEpiM6mB
        Say49D4WMWGy6SBVjoo0O6Uns1KstaEJn9azYNBtnxHWw8RgZ4EP4GQAMYv78C3hMcdM386Zxru
        X/wZT1qrK5RbXokySCA==
X-Received: by 2002:a17:903:1210:b0:192:90e7:41d5 with SMTP id l16-20020a170903121000b0019290e741d5mr23787803plh.52.1675681204881;
        Mon, 06 Feb 2023 03:00:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/Ho9tAi13aHDkJum20Wm/PMjUvereF6BnLXQVTzkPSuQqXTiN5FkJqdQt4fMDbtGzazEroxQ==
X-Received: by 2002:a17:903:1210:b0:192:90e7:41d5 with SMTP id l16-20020a170903121000b0019290e741d5mr23787774plh.52.1675681204477;
        Mon, 06 Feb 2023 03:00:04 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b00192f4fbdeb5sm5115648plb.102.2023.02.06.03.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:00:03 -0800 (PST)
Date:   Mon, 6 Feb 2023 19:00:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 2/3] common: Unmount udf filesystem prior checking
Message-ID: <20230206110000.zs4v6bnfge5isshs@zlang-mailbox>
References: <20230131123809.28200-1-jack@suse.cz>
 <20230131124005.14207-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131124005.14207-2-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 31, 2023 at 01:39:58PM +0100, Jan Kara wrote:
> _check_udf_filesystem forgot to unmount the filesystem prior to checking
> it. That was leading to check failures.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index bf3effa4c1ed..7f80afe7aeec 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3074,6 +3074,12 @@ _check_udf_filesystem()
>  	return
>      fi
>  
> +    # Is the filesystem mounted?
> +    local type=`_fs_type $device`
> +    if [ "$type" = "$FSTYP" ]; then
> +	local mountpoint=`_umount_or_remount_ro $device`
> +    fi
> +
>      local device=$1
>      local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
>      if [ -z "$blksz" ]; then
> @@ -3090,6 +3096,10 @@ _check_udf_filesystem()
>  	_udf_test_known_error_filter | \
>  	grep -E -iv "Error count:.*[0-9]+.*total occurrences:.*[0-9]+|Warning count:.*[0-9]+.*total occurrences:.*[0-9]+" && \
>          echo "Warning UDF Verifier reported errors see $seqres.checkfs." && return 1
> +    # Remount the filesystem
> +    if [ "$type" = "$FSTYP" ]; then
> +	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
> +    fi
>      return 0
>  }
>  
> -- 
> 2.35.3
> 

