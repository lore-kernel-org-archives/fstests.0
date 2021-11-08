Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D7C433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 04:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F3D613A6
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 04:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhKHENi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Nov 2021 23:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233833AbhKHENi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Nov 2021 23:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636344654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRzch33PrnyA1gC9i1e3x4DuKM/dHDpsFAEddB6YftA=;
        b=WfYTikJbqeBm+dyCYg852kczPKlXbarjO3cjwXPzBnZ40hMAckB91gPzfNUMJ1yYjpwd95
        w9JZfs8AKkiVvUUxjPMMOsZPkW5ouye8Lp3FkyuFijkbJF7qnQw0xZ7Pd3hJFbqCmXowmz
        GjZr5cBAlduoZ0DUKiZoSfoqaz+jEWw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-6hPAuT-6MTuZEimBgLD3dw-1; Sun, 07 Nov 2021 23:10:52 -0500
X-MC-Unique: 6hPAuT-6MTuZEimBgLD3dw-1
Received: by mail-pl1-f198.google.com with SMTP id o8-20020a170902d4c800b001424abc88f3so1846964plg.2
        for <fstests@vger.kernel.org>; Sun, 07 Nov 2021 20:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lRzch33PrnyA1gC9i1e3x4DuKM/dHDpsFAEddB6YftA=;
        b=v9oNCHaWcn/UOpbGNkbb9ivszbERiD/qFEsUUz5QbG9QypoL2GMI2vuXe2qxwwALdY
         PgiGndm2x2bfVEezLzaJzaXRS9lEByCeri1N6EZbaFDAxmpAc+1xFxySgjdDDHZ1/N6C
         WkPMIX4h6ZQlnWfMDvdEwWjLlMWKhEq//A+URMlR6QCibk8iobT32l1RQQ4j7l3ogsRo
         sUPiOKMfwRInojkLWHaHwepSmH5onb/4jGorFSbQHoZDxPTUAfPpN2pi+7+xvKbxrY+G
         k8Pe/m1aqHhCCFTjmDPa08hnbR3bsb3Pp/nzLAxGVsZKTAWtw39+FrK7s6ITLwdbochS
         4gMw==
X-Gm-Message-State: AOAM5323Q/6iHwMMllUssZ6k6eORbaadwvVEVX39wY1wFCodlUMEBRvf
        7qghz9P4ZBGRqRXnrK/TZrJnnMszp3/KN/tLf8VaKm/o/lT3NDjbc/lTKrlah6uwHPytYWCzQhC
        9ts7YzJf+KIyn8Av66g==
X-Received: by 2002:a63:6a49:: with SMTP id f70mr49576182pgc.358.1636344651614;
        Sun, 07 Nov 2021 20:10:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF0o+yVgRmbB37d0J1UdFwmjjc+7o9ALyaFyVk/xHXN8F/xeV2QH+HXVa5i8riJorQI734Xg==
X-Received: by 2002:a63:6a49:: with SMTP id f70mr49576163pgc.358.1636344651246;
        Sun, 07 Nov 2021 20:10:51 -0800 (PST)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c1sm14826587pfv.54.2021.11.07.20.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 20:10:50 -0800 (PST)
Date:   Mon, 8 Nov 2021 12:26:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: Enable _format_swapfile to return the
 swap size
Message-ID: <20211108042618.2lezcpdhwfs6tlav@fedora>
Mail-Followup-To: Carlos Maiolino <cmaiolino@redhat.com>,
        fstests@vger.kernel.org
References: <20211102152828.26895-1-cmaiolino@redhat.com>
 <20211102152828.26895-2-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102152828.26895-2-cmaiolino@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 02, 2021 at 04:28:27PM +0100, Carlos Maiolino wrote:
> Once the kernel is free to not map the full swap file during a swapon call,
> it can be useful to know the exact size of the swap area created during
> _format_swapfile().
> 
> To achieve this, it is required to change _require_scratch_swapfile(), to drop
> the _format_swapfile() return value, otherwise, it will also have a return value
> that will end up in tests outputs causing tests to fail.
> 
> Tests using _format_swapfile() that do not require the swap file size do not
> need to be modified, as the return value will be simply ignored.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  common/rc | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f693d39..fb1f32e0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2587,6 +2587,7 @@ _require_odirect()
>  _format_swapfile() {
>  	local fname="$1"
>  	local sz="$2"
> +	local swap_log=""
>  
>  	rm -f "$fname"
>  	touch "$fname"
> @@ -2595,8 +2596,11 @@ _format_swapfile() {
>  	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
>  	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
>  	# Ignore permission complaints on filesystems that don't support perms
> -	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | \
> -		grep -v "insecure permission"
> +	swap_log=$($MKSWAP_PROG "$fname" 2>&1 | grep -v "insecure permission")
> +	echo $swap_log >> $seqres.full
> +
> +	# return created swap size
> +	echo $swap_log | grep -oP '(?<=size = )\w+'

I saw you've changed generic/643 to suit this change, but there're many cases
call _format_swapfile() [1], now it print something to stdout by default, did
you make sure it won't break other cases' golden image?

Thanks,
Zorro

[1]
$ grep -rsn _format_swapfile tests/
tests/btrfs/173:22:# We can't use _format_swapfile because we don't want chattr +C, and we can't
tests/btrfs/173:34:_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
tests/btrfs/177:66:_format_swapfile "$swapfile" $((32 * 1024 * 1024))
tests/btrfs/174:23:_format_swapfile "$swapfile" $(($(get_page_size) * 10))
tests/btrfs/175:21:     _format_swapfile "$SCRATCH_MNT/swap" "$sz"
tests/btrfs/175:50:_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
tests/btrfs/176:32:_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
tests/btrfs/176:50:_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
tests/generic/643:39:_format_swapfile $swapfile 1m >> $seqres.full
tests/generic/357:42:_format_swapfile "$testdir/file1" $((blocks * blksz))
tests/generic/493:30:_format_swapfile "$testdir/file1" $((blocks * blksz))
tests/generic/494:29:_format_swapfile "$testdir/file1" $((blocks * blksz))
tests/generic/356:42:_format_swapfile "$testdir/file1" $((blocks * blksz))
tests/generic/569:34:_format_swapfile $testfile 20m
tests/generic/495:24:# We can't use _format_swapfile because we're using our custom mkswap and
tests/generic/554:33:_format_swapfile $SCRATCH_MNT/swapfile 16m

>  }
>  
>  _swapon_file() {
> @@ -2628,7 +2632,7 @@ _require_scratch_swapfile()
>  	_scratch_mount
>  
>  	# Minimum size for mkswap is 10 pages
> -	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> +	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
>  
>  	# ext* has supported all variants of swap files since their
>  	# introduction, so swapon should not fail.
> -- 
> 2.31.1
> 

