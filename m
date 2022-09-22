Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAC8C54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 15:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIVPRG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 11:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIVPRF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 11:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED9EBBC7
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663859823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwTUEeVgarSgjYIyipiN+WWvxqFf5Mn4Wa2qOCHYKXY=;
        b=GFcCwvEa+wgvBZEstXhO572+5d9btHiO9C5fgOvealmaX+Sj4gj0cN0Rq/8BXpd4+yAYlV
        +Mn1k3NEe/hy/2jvElOC95rpZe3ZmsV2LbraBxn1P6DAM37CPbJ210pVsEqGtz8/aC2sHs
        5V9bjZEq9iW49JwlWMrwVD1DV4HFaw8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-LcAOmVKIOkWURqvIQpU6zA-1; Thu, 22 Sep 2022 11:17:00 -0400
X-MC-Unique: LcAOmVKIOkWURqvIQpU6zA-1
Received: by mail-qt1-f198.google.com with SMTP id fe14-20020a05622a4d4e00b0035cc376b1d5so6590232qtb.4
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 08:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XwTUEeVgarSgjYIyipiN+WWvxqFf5Mn4Wa2qOCHYKXY=;
        b=YFqgtC0GA+I2vHk3YkHpNi4OfGlGnucJPUrs4/DdVfPoeICVAMKCzPB8rXhyuMe0S7
         6yVmRTNhvNQwN0W26fQ+cM2oAhurtKGtt0Zo9cPqSL2RbgcCUJ2NkNf69hId2YzRZJ8v
         s+j29gfQYU7MUez0hD5694FbnEwmsO0eMMR5aC5ZODzPwo2/OJzvI/o+Pe4jWb1zSFkC
         6Wv/EcVLQcNWPtfGB9u0C8CAsXxhy8UJAlYzLZMPVMVMwJPLBY/G/5mwMy5lAAygqcIN
         e3pPKjr5b+xv9lVwfAb4x/WwlJTAK4LVL3N9zFkcmIIh7Xfjs9z8CvpfFkJ/Dv3qeooy
         LHoQ==
X-Gm-Message-State: ACrzQf1C0583UsXRvfrzxwDl4NYyZrwVKM6WXL7Qv9QYHREOiw/WH9//
        oasj0MfOq3ALZBYbcQXuqIEAnsMTp/Po8ORt2/Q/0Tmdd0tzodAnyDYjtS0tj2xugSuBsKEjR4p
        wM2dZ9H8leGqdvbL7fw==
X-Received: by 2002:a05:622a:1046:b0:35c:dde0:6735 with SMTP id f6-20020a05622a104600b0035cdde06735mr3169190qte.689.1663859820051;
        Thu, 22 Sep 2022 08:17:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7rBl9yq/Ktfsu6VfwCU4ZtoRMHQJO2O6CBUQBTpY+PfHXmdR6DN6JvmkOXvjkrMcIlKnhGVA==
X-Received: by 2002:a05:622a:1046:b0:35c:dde0:6735 with SMTP id f6-20020a05622a104600b0035cdde06735mr3169170qte.689.1663859819821;
        Thu, 22 Sep 2022 08:16:59 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a138700b006b9c6d590fasm3812917qki.61.2022.09.22.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:16:59 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:16:55 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] g/299: speed up the test
Message-ID: <20220922151655.3eudeubqbh6s32io@zlang-mailbox>
References: <20220922134822.1020119-1-preichl@redhat.com>
 <20220922134822.1020119-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922134822.1020119-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 03:48:20PM +0200, Pavel Reichl wrote:
> Move the _require_xfs_io_command "falloc" above the
> potencially 'expensive' function _get_max_file_size
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

It's not for speeding up this test, I think you're trying to notrun this case
on a fs which doesn't support fallocate and sparse file but support truncate
syscall. Anyway I don't have objection on this patch.

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

