Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F67C4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 14:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447AD6112E
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 14:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbhHSOkw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240264AbhHSOkw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 10:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629384015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kz6q7Kjh1ew1ZitEOf1YBFFbVPswTpV5ukQSHrYU+Jw=;
        b=XjerDSJQvM+XJAetJT3ux2JaCaESQnal/Y1VO/1/Q44iAIHJkJGotZGLqumK0rMp1RWg7L
        /kzAzCN+Xl103kKBWa6J1YeNLDApiRaFDfZJpnrmdWfAcpBe1DEWwxvgVeG5GeN2MsEmjg
        QzgmRct5rWA62bVBibuHhuE0lcUmVls=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-_Q-YQbuzNI6rINkwJYwDVA-1; Thu, 19 Aug 2021 10:40:13 -0400
X-MC-Unique: _Q-YQbuzNI6rINkwJYwDVA-1
Received: by mail-pj1-f71.google.com with SMTP id o23-20020a17090a4217b02901774c248202so1823241pjg.9
        for <fstests@vger.kernel.org>; Thu, 19 Aug 2021 07:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Kz6q7Kjh1ew1ZitEOf1YBFFbVPswTpV5ukQSHrYU+Jw=;
        b=TtukE84une2YNGBddYJNwRwymh7KbNViG+RNiSP+yYAyiorV1pHtU0b7XngelYm5KX
         JW2u82B3wvBkaoyDiVgzFidlJRQp31e4/u8tPTXRYy9i1r3OK3Sfyn9r3Jm5vqJV13dQ
         Ufae+2RY3J+X1TzjKpR9w3kZEM8sSHKJMp+QM1Q/v/oY/Vh0A6M3f23uCmBSXaWwDWd8
         kfU0Jm/yiSbPYcdrO7C2lWEX8TJLVJAJcxPojEhJEBnWIuvu+QO7NMYCwWffsav7xdZX
         IIoGI5baQePkyfiS2x/fFVXhXWw8HptHkwBPeleSeAcJkT5ZZTdg2Z+8sUO4qDjByG42
         f//g==
X-Gm-Message-State: AOAM530fGURO2wAxVSKTe1sB0BohOGXG4YfnhWJMcloQqQQynSePHIIy
        89gBZ5WokY7495acF9cnDkgM7wbVuaYQ5ZEc3CSYWldQrGmPDMaYfZ6K+i580rC4h2pdarPyTox
        3www3VhvaFSsSq1SwyA==
X-Received: by 2002:a65:494e:: with SMTP id q14mr14334532pgs.314.1629384012459;
        Thu, 19 Aug 2021 07:40:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZrkEfmmDlpi8JI4Bu3U0OKmlKQ6QeUW14tgUXbrGgkILgSjzx48Fn3DUfh6qIAnnWV2BM4A==
X-Received: by 2002:a65:494e:: with SMTP id q14mr14334520pgs.314.1629384012203;
        Thu, 19 Aug 2021 07:40:12 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e8sm4603996pgg.31.2021.08.19.07.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 07:40:11 -0700 (PDT)
Date:   Thu, 19 Aug 2021 23:00:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/70: Use scratch device instead of test.
Message-ID: <20210819150050.jweulrtgjeh57wac@fedora>
Mail-Followup-To: Nikolay Borisov <nborisov@suse.com>,
        fstests@vger.kernel.org
References: <20210819131355.304528-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819131355.304528-1-nborisov@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 19, 2021 at 04:13:55PM +0300, Nikolay Borisov wrote:
> At the end of the test the fsstress work dir is deleted, this suggests
> the test really requires a scratch device and not a test device. Change
> it accordingly.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---

Hmm... is there any more specific reasons to explain why have to change this
TEST_DIR to SCRATCH_MNT? For example, this test hit ENOSPC in TEST_DIR, or
it takes too much time to remove $TEST_DIR/fsstress in _cleanup, or use
SCRATCH_DEV can cover more things, and so on. I think more specific reason
can help to push this patch be merged. After all there's not a rule says
if a case don't need to keep its work dir, then must use SCRATCH_DEV. Except
the maintainer is more inclined to accept that :)

Thanks,
Zorro

>  tests/generic/070 | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/070 b/tests/generic/070
> index 678344fa011d..c98f445ae4b8 100755
> --- a/tests/generic/070
> +++ b/tests/generic/070
> @@ -13,7 +13,6 @@ _begin_fstest attr udf auto quick stress
>  _cleanup()
>  {
>      cd /
> -    rm -rf $TEST_DIR/fsstress
>      rm -f $tmp.*
>  }
>  
> @@ -24,11 +23,14 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs generic
>  
> -_require_test
> +_require_scratch
>  _require_attrs
>  
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount
> +
>  FSSTRESS_ARGS=`_scale_fsstress_args \
> -	-d $TEST_DIR/fsstress \
> +	-d $SCRATCH_MNT \
>  	-f allocsp=0 \
>  	-f freesp=0 \
>  	-f bulkstat=0 \
> @@ -40,5 +42,7 @@ FSSTRESS_ARGS=`_scale_fsstress_args \
>          -p 1 -n 10000 -S c`
>  $FSSTRESS_PROG $FSSTRESS_ARGS >$seqres.full 2>&1
>  
> +_scratch_unmount
> +
>  status=$?
>  exit
> -- 
> 2.17.1
> 

