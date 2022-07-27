Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A81DC04A68
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Jul 2022 12:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiG0MVw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Jul 2022 08:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiG0MVv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jul 2022 08:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1E082C648
        for <fstests@vger.kernel.org>; Wed, 27 Jul 2022 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658924509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OnEraViqlPc7pBrLeCU4ypHt6OIMM9xxzQMmVQ4Aw90=;
        b=KjsQpZto2el55QYTFdBx5FDOhuJl6LoMwSqxRtOtACljjweF8FU2XWwYr/P6EsY+2e/CLZ
        R8PB3QCYTBrXQRSF158y1thbs2y1LmKTy44kkIWV1ypHeVKb4CpV1HqiOHeU4St06GxgbB
        dMAtRrmldFCRdtjNNnmhbzhfQdgQxXU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-_5yayQlwN4aaG3gZXziHdg-1; Wed, 27 Jul 2022 08:21:48 -0400
X-MC-Unique: _5yayQlwN4aaG3gZXziHdg-1
Received: by mail-oo1-f69.google.com with SMTP id b4-20020a4a3404000000b00435e23d0402so1008257ooa.11
        for <fstests@vger.kernel.org>; Wed, 27 Jul 2022 05:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnEraViqlPc7pBrLeCU4ypHt6OIMM9xxzQMmVQ4Aw90=;
        b=zrLpj4/L3nc1VJWmcJfN0uTjvo3UtCXslxOr6rn3I8W0vrCI8MhI48nET710yH5rPx
         I/WLB2zV+gGJDn7Fja81gzkgT0DES6tOmZaJIXnNBafHB38MsWynaKd0bAQqTQmkdebh
         KLzuo1Owi9scDHtMwkhARpeQ2OTG4TWeN5zn3lJfA5nvkdDqOCIwzKw+tJ6KBF3eJizS
         4fAyyoi6sl1JEa7dUV65uaZg2Qj0+IIBjRYWze1sX6SZhiT+TKyupvFL630CeozX2FTT
         81cjnv3z/2F1hcYloYaUVGY0iMR+llSVngI8wKdh/UwfLOC325dRGo+rW761vSdPfVHi
         ccWQ==
X-Gm-Message-State: AJIora9IGH3lR2gYEUz2J+Y3Ch+EyeDIC+53ZLuw+0qxByf9+7nBs0Xn
        PVfn3il21NJz2i1AQ+uFgY3QkU4dvPsifNfwXJ6V5Kr/2t7a8JztypICOsB+uOiUnS8J8/4RSek
        s+v94q8943Zjf+X2vOA==
X-Received: by 2002:a05:6808:3ca:b0:33a:6eb4:5f76 with SMTP id o10-20020a05680803ca00b0033a6eb45f76mr1619903oie.249.1658924507909;
        Wed, 27 Jul 2022 05:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/NlF1CCVRhqJ2/9CV/j/OK/1ArDVpHfCrh5U3kWfmPWVd3/oiHxYZ7amu+z6LHOChsNSnEg==
X-Received: by 2002:a05:6808:3ca:b0:33a:6eb4:5f76 with SMTP id o10-20020a05680803ca00b0033a6eb45f76mr1619897oie.249.1658924507658;
        Wed, 27 Jul 2022 05:21:47 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s25-20020a4ac819000000b0042300765d39sm7066068ooq.46.2022.07.27.05.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:21:47 -0700 (PDT)
Date:   Wed, 27 Jul 2022 20:21:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/432: fix this test when external devices are in use
Message-ID: <20220727122142.ktp5loclqazchncw@zlang-mailbox>
References: <YuBFw4dheeSRHVQd@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuBFw4dheeSRHVQd@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 26, 2022 at 12:51:31PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This program exercises metadump and mdrestore being run against the
> scratch device.  Therefore, the test must pass external log / rt device
> arguments to xfs_repair -n to check the "restored" filesystem.  Fix the
> incorrect usage, and report repair failures, since this test has been
> silently failing for a while now.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/432 |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/432 b/tests/xfs/432
> index 86012f0b..5c6744ce 100755
> --- a/tests/xfs/432
> +++ b/tests/xfs/432
> @@ -89,7 +89,16 @@ _scratch_xfs_metadump $metadump_file -w
>  xfs_mdrestore $metadump_file $metadump_img
>  
>  echo "Check restored metadump image"
> -$XFS_REPAIR_PROG -n $metadump_img >> $seqres.full 2>&1
> +repair_args=('-n')
> +[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> +	repair_args+=('-l' "$SCRATCH_LOGDEV")
> +
> +[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
> +	repair_args+=('-r' "$SCRATCH_RTDEV")
> +
> +$XFS_REPAIR_PROG "${repair_args[@]}" $metadump_img >> $seqres.full 2>&1
> +res=$?
> +test $res -ne 0 && echo "xfs_repair on restored fs returned $res?"

Make sense to me, I don't have better idea. One question, is xfs_metadump
and xfs_mdrestore support rtdev? Due to I didn't find xfs_metadump have
a "-r" option, although it has "-l logdev" :)

About the "$res", I don't know why we need this extra variable, as it's
not used in other place.

Thanks,
Zorro

>  
>  # success, all done
>  status=0
> 

