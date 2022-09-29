Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C6C04A95
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Sep 2022 05:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiI2FPT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Sep 2022 01:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiI2FPS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Sep 2022 01:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F75E50705
        for <fstests@vger.kernel.org>; Wed, 28 Sep 2022 22:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664428514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GTuWhbffLEeU8hqaqNOROd9qdekK/JDI25YrwgIquQ=;
        b=EBA468mbN9ZwLhFGtd5pQLdIiGS72kQgG+KY85puLsUjnqHVQn0hz0807+NtxAKxHY9FjB
        3PKBzSbsgMKG9Ao0C8odlWE4T7+SHPvvG0lwydnxPkIVLzmfZab1ND3F1cfVSEZwSjfouW
        gTJHBQ2WdZbuiPp9aMuZjchOBICZe+E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-y3825FwjMzW6UodqHJ7z5Q-1; Thu, 29 Sep 2022 01:15:13 -0400
X-MC-Unique: y3825FwjMzW6UodqHJ7z5Q-1
Received: by mail-pj1-f70.google.com with SMTP id q99-20020a17090a17ec00b00205fb739e79so243349pja.0
        for <fstests@vger.kernel.org>; Wed, 28 Sep 2022 22:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7GTuWhbffLEeU8hqaqNOROd9qdekK/JDI25YrwgIquQ=;
        b=hixueSbHInfuUAB6EqbWnFYR4jXjb8YQv85yW+YLF0dSfj9K0umNbfoFsX698m/vpR
         YPvk0y519QqGCnyd+QRHLXwbZrWZnKLYlsz5yOqIVT/ZMSLzyzal1GRE7hd5q6CcJJHr
         XssFuMDJYgoYzASVF+8dZoMNuuPX+agna3uQRLX+zOHouXYazw2mr8ktoPYWtP2Rqc/J
         qeWlnnSW5hzSLWFR2mjRbqVX137Df6wqBbC9553lSJzYBSNkcr9O+sbhJrZdLtluObKA
         u8cCof44GFEVBheBJwfjVxvgVSzEouckmGVkoePTIsD/C2T6lt+ob5W8fvSskDPA2LiJ
         p0Tg==
X-Gm-Message-State: ACrzQf1w5wFHVmj+fLY5qvUZ4i/65U1FLWjtlaNm+r3H2Rwl7qw1JRcL
        cvzNeKvpMyc2GFzB5A7NJI3zh/Z80jZaVJW+CG/C8XmrgOYQ/6ZY2+ZARe/XKCifYOlMjceNddt
        BNWD/uYzYNVw0w2Z/Qw==
X-Received: by 2002:a17:90a:1617:b0:200:9da5:d0ed with SMTP id n23-20020a17090a161700b002009da5d0edmr1726918pja.90.1664428511890;
        Wed, 28 Sep 2022 22:15:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5WymMJm3RJ490QTBz0OGuToqqM9rKqU7ZRaOk4r7ofg6uhYEgWsXRz4PMJwbsSgxbu1fD9OQ==
X-Received: by 2002:a17:90a:1617:b0:200:9da5:d0ed with SMTP id n23-20020a17090a161700b002009da5d0edmr1726883pja.90.1664428511523;
        Wed, 28 Sep 2022 22:15:11 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z67-20020a626546000000b00546d875a944sm5002769pfb.214.2022.09.28.22.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 22:15:11 -0700 (PDT)
Date:   Thu, 29 Sep 2022 13:15:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] common: introduce zone_capacity() to return a
 zone capacity
Message-ID: <20220929051507.aonami57xnhnixan@zlang-mailbox>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <b148b071bb11828f4a4c6600331cc8464a1895f1.1664419525.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b148b071bb11828f4a4c6600331cc8464a1895f1.1664419525.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 29, 2022 at 01:19:24PM +0900, Naohiro Aota wrote:
> Introduce _zone_capacity() to return a zone capacity of the given address
> in the given device (optional). Move _filter_blkzone_report() for it, and
> rewrite btrfs/237 with it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/filter   | 13 -------------
>  common/zoned    | 28 ++++++++++++++++++++++++++++
>  tests/btrfs/237 |  8 ++------
>  3 files changed, 30 insertions(+), 19 deletions(-)
>  create mode 100644 common/zoned
> 
> diff --git a/common/filter b/common/filter
> index 28dea64662dc..ac5c93422567 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -651,18 +651,5 @@ _filter_bash()
>  	sed -e "s/^bash: line 1: /bash: /"
>  }
>  
> -#
> -# blkzone report added zone capacity to be printed from v2.37.
> -# This filter will add an extra column 'cap' with the same value of
> -# 'len'(zone size) for blkzone version < 2.37
> -#
> -# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> -# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
> -_filter_blkzone_report()
> -{
> -	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' |\
> -	sed -e 's/len/cap/2'
> -}
> -
>  # make sure this script returns success
>  /bin/true
> diff --git a/common/zoned b/common/zoned
> new file mode 100644
> index 000000000000..d1bc60f784a1
> --- /dev/null
> +++ b/common/zoned
> @@ -0,0 +1,28 @@
> +#
> +# Common zoned block device specific functions
> +#
> +
> +#
> +# blkzone report added zone capacity to be printed from v2.37.
> +# This filter will add an extra column 'cap' with the same value of
> +# 'len'(zone size) for blkzone version < 2.37
> +#
> +# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> +# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
> +_filter_blkzone_report()
> +{
> +	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' |\
> +	sed -e 's/len/cap/2'
> +}
> +
> +_zone_capacity() {
> +    local phy=$1
> +    local dev=$2
> +
> +    [ -z "$dev" ] && dev=$SCRATCH_DEV
> +
> +    size=$($BLKZONE_PROG report -o $phy -l 1 $dev |\
> +	       _filter_blkzone_report |\
> +	       grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> +    echo $((size << 9))
> +}
> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index bc6522e2200a..101094b5ce70 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -13,7 +13,7 @@
>  _begin_fstest auto quick zone balance
>  
>  # Import common functions.
> -. ./common/filter
> +. ./common/zbd

I'm a little surprised this line doesn't report error :) Anyway, it should be
common/zoned as above. Others look good to me. With this fix, you can add:

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  # real QA test starts here
>  
> @@ -56,11 +56,7 @@ fi
>  
>  start_data_bg_phy=$(get_data_bg_physical)
>  start_data_bg_phy=$((start_data_bg_phy >> 9))
> -
> -size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
> -	_filter_blkzone_report |\
> -	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> -size=$((size << 9))
> +size=$(_zone_capacity $start_data_bg_phy)
>  
>  reclaim_threshold=75
>  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
> -- 
> 2.37.3
> 

