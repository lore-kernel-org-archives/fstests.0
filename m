Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1948C32771
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Sep 2022 02:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiI2CE5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Sep 2022 22:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiI2CE4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Sep 2022 22:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440E55F23D
        for <fstests@vger.kernel.org>; Wed, 28 Sep 2022 19:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664417094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cGp7QqXW9weflUVgLKAdhgoKS+S2AP8mGnyyq5DNi8=;
        b=AZaViGXQkd7ELOamGKLtvERuisPY66oRSa6g6HbmQhsXdhRBQ00Lxegxwi2ir+wFADMrXV
        KhaYd/fZ3qL7yXHxXPLVHOrUNDLvRRoy2UF/fRlaV0FZC9L5yLTlMcZbVBKVYhZDHQwHXA
        DVKB+voAKXqIm2StA2Jw4YDvYxGrJ1M=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-205-9dSqrOkbO_aQ_ze6IJJhiw-1; Wed, 28 Sep 2022 22:04:52 -0400
X-MC-Unique: 9dSqrOkbO_aQ_ze6IJJhiw-1
Received: by mail-pj1-f70.google.com with SMTP id rw5-20020a17090b2c4500b00203182a71baso24546pjb.1
        for <fstests@vger.kernel.org>; Wed, 28 Sep 2022 19:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3cGp7QqXW9weflUVgLKAdhgoKS+S2AP8mGnyyq5DNi8=;
        b=kSlSjuMRgDm25SgacMIEW8fWUOCASQAeGldc8q2YKx50mQwDKqksaXHO1LsZwHMqvK
         EoctgvTaBZGZ9rezpM2s7//SGp2hIArzfsPr6+bJqtKFInNIaBqTzr1GKlt34+oA1JcN
         w7dx01C3MKOgsLe4xXbCpp7x4vkR/ozVf6YqANYZwyQvgJFW63QkNpVzI41DRYFqUk0m
         H0u7DpHF86S/BwIIsNP4FpKeaPcuDNL4Zm3NXPKjsa7wzRnbc4PC2834wz+ayt8aYvbp
         S2vUOB/UEWxJ3HQcIG/Ih2rpQN6lsc/yCZqWhMw+dKnb42w3EqZUDP6BdxHvhrSfTD3n
         9p7Q==
X-Gm-Message-State: ACrzQf3Vgc496RZ73pUdyZykgViBmtroGTSKhc4kB3qZRRILOc3aWler
        IdXPmCsMumViUpwYL3GpHCRNW3dsp/IppXB9Gs9w87gk7pXOV13+tLVc3dnoyh0Gda5jWWaHHUh
        JFClbwNBkJ5J93pmYWQ==
X-Received: by 2002:a17:90b:3850:b0:200:b1fd:891f with SMTP id nl16-20020a17090b385000b00200b1fd891fmr1087802pjb.144.1664417091697;
        Wed, 28 Sep 2022 19:04:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5M0UgDhGZHOEpYOuHoRUA2uMNpLgYCjhCuFuTJWEkZ+GHk1PXT/aPmqUqnHbqlWxAZEwpEYw==
X-Received: by 2002:a17:90b:3850:b0:200:b1fd:891f with SMTP id nl16-20020a17090b385000b00200b1fd891fmr1087776pjb.144.1664417091330;
        Wed, 28 Sep 2022 19:04:51 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a6b4d00b001fe2ab750bbsm2245547pjl.29.2022.09.28.19.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 19:04:50 -0700 (PDT)
Date:   Thu, 29 Sep 2022 10:04:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/2] g/299: skip test early if falloc is not supported
Message-ID: <20220929020447.c6hspjc2ju3ax3a7@zlang-mailbox>
References: <20220922185502.1046115-1-preichl@redhat.com>
 <20220922185502.1046115-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922185502.1046115-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 08:55:02PM +0200, Pavel Reichl wrote:
> Move the _require_xfs_io_command "falloc" above the
> potencially 'expensive' function _get_max_file_size
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

Hmm... looks like the `_require_xfs_io_command "falloc"` helps to save a helper
"_require_falloc" which detects if fs (kernel part) supports fallocate, although
it trys to make sure xfs_io supports falloc command.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  tests/generic/299 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/299 b/tests/generic/299
> index 8e1a112c..1bb371a3 100755
> --- a/tests/generic/299
> +++ b/tests/generic/299
> @@ -24,6 +24,7 @@ _require_scratch
>  _require_odirect
>  _require_aio
>  _require_block_device $SCRATCH_DEV
> +_require_xfs_io_command "falloc"
>  
>  NUM_JOBS=$((4*LOAD_FACTOR))
>  BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> @@ -96,7 +97,6 @@ filename=buffered-aio-verifier
>  EOF
>  
>  _require_fio $fio_config
> -_require_xfs_io_command "falloc"
>  
>  _scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount
> -- 
> 2.37.3
> 

