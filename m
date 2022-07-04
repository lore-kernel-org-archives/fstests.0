Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5560BC43334
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Jul 2022 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiGDPmy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiGDPmx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jul 2022 11:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F15511466
        for <fstests@vger.kernel.org>; Mon,  4 Jul 2022 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656949370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wabevSTXqs5O/isY78iY8xQdBrJccIPajq0APoMuCCk=;
        b=QIJ/pvOiwQfs+KL4yQ5y0qYsuzZS6eamb/ribf8yD1SincRcjDTJ3XbK80665eRcHHUuDP
        Sxo18MXXJGv8StadlO4cNV7ZcPJ5q38jPiOj1zmr0ry5JnRpbo0UsKh+qAwcb0CQCU2dRO
        a6ix+c8ZgnOekkWJKzIx1uUzCqQkwv8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-qPfOt3znMxGVnCd2OpXPgA-1; Mon, 04 Jul 2022 11:42:49 -0400
X-MC-Unique: qPfOt3znMxGVnCd2OpXPgA-1
Received: by mail-qt1-f199.google.com with SMTP id x16-20020ac85f10000000b0031d3262f264so7201805qta.22
        for <fstests@vger.kernel.org>; Mon, 04 Jul 2022 08:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wabevSTXqs5O/isY78iY8xQdBrJccIPajq0APoMuCCk=;
        b=hK8NDs2I1kMQ9WG5SAOrzvs+a6vjP9quwpPsiqh/HlmXgKi4YFh9TddEbkFmq4RMbd
         BDgOE+4uUdxsd2/wli1iKUQsrnANBHkoOxsDRENg7z5fc/BNL9nuycJvrNYHCevrtGCV
         voJJ02ObLvRLLr3aXzOjCb1YK9VaFELYfRBJkcF9phb3kVbSmvjZXkN5c63yeQdIzBkb
         P073vo4csb/7utXMldCX4zsYCt27d0kEXY65jWikkHgQ1TX0LZV7e5t6+z52U36jUodz
         LR5n4ZEjOahoTEVWwtB1L3bJO7YMm4SGRXe1B+XYAA8FtWyt7g4/NyGizl+YncZ0Blqo
         VTDg==
X-Gm-Message-State: AJIora+bt3b1QAPJxRa4gM4OTyeT+3dyTDOi1rpSG2bV4RcAWna8kKtV
        cdx8T7jPAPEKf0KE/Bg6QxOMBv4g0FH6i9TY4MNENBNC/p1R10oNJ/wCFbyRG5V5VWmlF33ObkN
        8lwUNpDbCy5MsWiIwJg==
X-Received: by 2002:ad4:5f48:0:b0:470:9f25:ec7e with SMTP id p8-20020ad45f48000000b004709f25ec7emr27257075qvg.14.1656949368146;
        Mon, 04 Jul 2022 08:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sMNudbvaPQ5fQdcUiCl+E8MFMIxS3GrwMKPLdY6tYx6ZJAfk50Ve8u6TEXbhc4lESjhOKhNA==
X-Received: by 2002:ad4:5f48:0:b0:470:9f25:ec7e with SMTP id p8-20020ad45f48000000b004709f25ec7emr27257060qvg.14.1656949367810;
        Mon, 04 Jul 2022 08:42:47 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n20-20020a05620a223400b006a6b564e9b8sm23354400qkh.4.2022.07.04.08.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:42:47 -0700 (PDT)
Date:   Mon, 4 Jul 2022 23:42:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs/270: only check new_ro_compat value when
 mkfs.xfs supports nrext64 feature
Message-ID: <20220704154242.sfq7ekeprovowcr2@zlang-mailbox>
References: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 27, 2022 at 10:30:02PM +0800, Yang Xu wrote:
> Currently, this case fails on old xfsprogs as below:
> +/var/lib/xfstests/tests/xfs/270: line 51: [: !=: unary operator expected
> 
> Getting ro_compat value will report the following error after setting new ro_compat
> value:
> +cache_purge: shake on cache 0x56033fde4920 left 1 nodes!?
> +cache_purge: shake on cache 0x56033fde4920 left 1 nodes!?
> +cache_zero_check: refcount is 1, not zero (node=0x56033fdf9110
> 
> Old xfsprogs miss a bugfix
> f4afdcb0ad ("xfs_db: clean up the salvage read callsites in set_cur()").
> 
> Here we skip the get step of new ro_comap value when nrext64 feature is supported.
> Also will add a new test to cover this xfsprog bug.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/270 | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/xfs/270 b/tests/xfs/270
> index b740c379..5ff83ead 100755
> --- a/tests/xfs/270
> +++ b/tests/xfs/270
> @@ -22,6 +22,10 @@ _require_scratch_nocheck
>  # Only V5 XFS disallow rw mount/remount with unknown ro-compat features
>  _require_scratch_xfs_crc
>  
> +nrext64_supported=0
> +_scratch_mkfs_xfs_supported -m crc=1 -i nrext64 > /dev/null 2>&1 && \
> +	nrext64_supported=1
> +
>  _scratch_mkfs_xfs >>$seqres.full 2>&1
>  
>  # set the highest bit of features_ro_compat, use it as an unknown
> @@ -43,13 +47,18 @@ ro_compat=$(echo $ro_compat | \
>  _scratch_xfs_set_metadata_field "features_ro_compat" "$ro_compat" "sb 0" \
>  				> $seqres.full 2>&1
>  
> -# read the newly set ro compat filed for verification
> -new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0" \
> -						2>/dev/null)
> -
> -# verify the new ro_compat field is correct.
> -if [ $new_ro_compat != $ro_compat ]; then

My personal opinion is -- change above line as:
   if [ "$new_ro_compat" != "$ro_compat" ]
to avoid the bash syntax error. Then the failure (on old xfsprogs) correspond
to a known xfsprogs bug. That's good enough.

Thanks,
Zorro

> -	echo "Unable to set new features_ro_compat. Wanted $ro_compat, got $new_ro_compat"
> +# Indeed, xfsprogs has a bug here and fixed by commit f4afdcb
> +# ("xfs_db: clean up the salvage read callsites in set_cur()")
> +# Here, we use nrext64 feature as a proxy.
> +if [ $nrext64_supported -eq 1 ]; then
> +	# read the newly set ro compat filed for verification
> +	new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" \
> +					"sb 0" 2>/dev/null)
> +	# verify the new ro_compat field is correct.
> +	if [ $new_ro_compat != $ro_compat ]; then
> +		echo "Unable to set new features_ro_compat. Wanted $ro_compat, \
> +			got $new_ro_compat"
> +	fi
>  fi
>  
>  # rw mount with unknown ro-compat feature should fail
> -- 
> 2.27.0
> 

