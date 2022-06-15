Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E04C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jun 2022 04:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiFOEPx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jun 2022 00:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFOEPw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jun 2022 00:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB8DC49F8A
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655266551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3B/ASmeKkxmcQzUypNUNv4mROclqhfa3VD/BeWE9hc=;
        b=QqbEapHlLD0LhXNRdm31vZ5EIGNj9XJEH5Vwfjzd1mZRCXQqAlvWiB1oAT7XEYZ8EZQn+L
        /yBlsEh9n7HJUi1kaROJJphavZksndKp+iQtz4enoNQTRYtsUxs0XYjOVzusJhIxAGlv+r
        RbHnCIXbKRqIS5uzl2A72RjFoIIcKKA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-3g260D7tNkS_CJyG26CgMA-1; Wed, 15 Jun 2022 00:15:46 -0400
X-MC-Unique: 3g260D7tNkS_CJyG26CgMA-1
Received: by mail-qk1-f198.google.com with SMTP id s8-20020a05620a0bc800b006a6d42a1a0eso9096285qki.3
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 21:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3B/ASmeKkxmcQzUypNUNv4mROclqhfa3VD/BeWE9hc=;
        b=eFL5uDsNtiDChVHgLZHs7BTN/1GvVK8THO/ZFoNPhbz82G0xch03qMF0fGqTlA2LCX
         2szIFRpp9kuidkM91mORgjA8qCWzUXh1V9tRrevgUpPUhvE2yn8RSNIaKBPB+g8h8YNE
         F9D7n430ZYS2SgP2/Es/ffQIZejMSdWW69yLd59gRVCVvQSLezwSGAxUuh9lBOahLo6f
         H+n/kpuBq9JUbcqwm/dJzKlMKcgY4ZrlT8ObEuCcTTU0qjM0DbW6NFykGUoLbMFv7B9c
         gdPUT9LUDbVKZSAx7S7R7M3813XvBp63tGrLaMuFeiHMwDIrOMa/YaLs0fHUt41sudeA
         V1Bw==
X-Gm-Message-State: AOAM530miu4tkWi4kGMG1TuIOTvno67hqxxpUEdB9fVFLGIKEqWQQik5
        7qTblscrindKI8Da2CSUuk4tQDXDg0v/eRKmgtoHFkBIzjPQI5yi14YtRxE0h1zEMnEiC2uoChp
        yJj008bOfIAyEbGHV3Q==
X-Received: by 2002:a05:622a:1a83:b0:304:e859:24fc with SMTP id s3-20020a05622a1a8300b00304e85924fcmr7106548qtc.641.1655266546192;
        Tue, 14 Jun 2022 21:15:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZEx/WLt2PHAHFN3XnqXaIB+jCiqCnEddB5YwpRW8PXrX6AWx4Y8cRNtlN9vxA1EA+FYEp2w==
X-Received: by 2002:a05:622a:1a83:b0:304:e859:24fc with SMTP id s3-20020a05622a1a8300b00304e85924fcmr7106543qtc.641.1655266545928;
        Tue, 14 Jun 2022 21:15:45 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bj36-20020a05620a192400b006a716fed4d6sm10283024qkb.50.2022.06.14.21.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 21:15:45 -0700 (PDT)
Date:   Wed, 15 Jun 2022 12:15:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] common/rc: fix input value to _scratch_mkfs_sized
Message-ID: <20220615041540.k3lzznbeklbwh6ui@zlang-mailbox>
References: <20220614050843.11802-1-lan@suse.com>
 <20220614050843.11802-2-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614050843.11802-2-lan@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 14, 2022 at 01:08:43PM +0800, An Long wrote:
> _scratch_mkfs_sized only receive integer number of bytes as a valid
> input. But if the MKFS_OPTIONS variable exists, it will use the value of
> block size in MKFS_OPTIONS to override input. In case of
> MKFS_OPTIONS="-b 4k", would result in blocksize=4 but not 4096. This

Hi An,

Good catch. Can you provide an example that a case fails on this issue, and
then it tests passed after having this patch? I'm wondering why no one notice
that before.

> will give errors to ext2/3/4 etc, and brings potential bugs to xfs or
> btrfs.
> 
> In addition, since we can receive various strings, so remove integer
> number check.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  common/rc | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 22050bc2..026007d3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1077,7 +1077,7 @@ _parse_size_from_string()
>  }
>  
>  # Create fs of certain size on scratch device
> -# _scratch_mkfs_sized <size in bytes> [optional blocksize]
> +# _scratch_mkfs_sized <size> [optional blocksize]
>  _scratch_mkfs_sized()
>  {
>  	local fssize=$1
> @@ -1086,13 +1086,13 @@ _scratch_mkfs_sized()
>  
>  	case $FSTYP in
>  	xfs)
> -		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
> +		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?size= ?+([0-9]+[a-zA-Z]?).*/\1/p'`
>  		;;
>  	btrfs)
> -		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
> +		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+[a-zA-Z]?).*/\1/p'`
>  		;;
>  	ext2|ext3|ext4|ext4dev|udf|reiser4|ocfs2|reiserfs)
> -		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
> +		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+[a-zA-Z]?).*/\1/p'`
>  		;;
>  	jfs)
>  		def_blksz=4096
> @@ -1101,14 +1101,8 @@ _scratch_mkfs_sized()
>  
>  	[ -n "$def_blksz" ] && blocksize=$def_blksz
>  	[ -z "$blocksize" ] && blocksize=4096
> -
> -	local re='^[0-9]+$'
> -	if ! [[ $fssize =~ $re ]] ; then
> -		_notrun "error: _scratch_mkfs_sized: fs size \"$fssize\" not an integer."
> -	fi
> -	if ! [[ $blocksize =~ $re ]] ; then
> -		_notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
> -	fi
> +	blocksize=$(_parse_size_from_string $blocksize)
> +	fssize=$(_parse_size_from_string $fssize)

For now, the _parse_size_from_string is only used for this patch, I think these
two patches can be merged into one patch, as it trys to fix one single problem.

Thanks,
Zorro

>  
>  	local blocks=`expr $fssize / $blocksize`
>  
> -- 
> 2.35.3
> 

