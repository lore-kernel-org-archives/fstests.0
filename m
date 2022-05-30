Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F58C38A02
	for <linux-fstests@archiver.kernel.org>; Mon, 30 May 2022 13:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbiE3Ngv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 May 2022 09:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiE3NgA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 May 2022 09:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90FED9808C
        for <fstests@vger.kernel.org>; Mon, 30 May 2022 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653917379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UDptAJl+uYFvCcxDFXfRmIlTNa3Yuv5SuAtq+XPxlPQ=;
        b=RD/tLobwiZKWpHlYSMpuwZGytdqDjuNlFionSZkYvgXv6zDgLI1pinCTRCwFeIzLKRMcCN
        GNCrcAMCIkganBwPK1h46w3f4Ie20cNC6yW4fxy+0GeckWzS64v9WZieJyIvn3Y37ZU7aG
        i6CrkmOwKXr4SeL0G03Hqbo8et/GO34=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-ZQvM15ALO22dQCMYHk5ZHQ-1; Mon, 30 May 2022 09:29:37 -0400
X-MC-Unique: ZQvM15ALO22dQCMYHk5ZHQ-1
Received: by mail-oi1-f200.google.com with SMTP id q5-20020acaf205000000b0032c2eeaafafso544863oih.22
        for <fstests@vger.kernel.org>; Mon, 30 May 2022 06:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDptAJl+uYFvCcxDFXfRmIlTNa3Yuv5SuAtq+XPxlPQ=;
        b=SM7SkuO7u+JNIPt7iEEgVHUT3FkxRbHd4hLEtsLcLIcm+4ckx7dOpzEHsYRZzA2KDk
         JstkFMvfCt4W5wdh0WPW+StsALEbNoW1149nfSqgC5kCR3QCds5O6DPRDGrFstEFvXBa
         dOMutfkwExumzAZSp5ESVMIYPKmv+jfRaN6miezL6ulaeL2y7OLPByfIVS+2tDfmm2f5
         0usxwjH/l2Z9Gearfxig/Rz6CL8aWxV6oYyXFc8GmZUyCU7keBxT8t5vPPL2MdOg0Fsk
         T5EZZgo4/4HLD7J9RRyR6kjREzM0otaL2d2bHamm3yjeHDKGxN5c1/b+lMso+2Moaf84
         KPgQ==
X-Gm-Message-State: AOAM533FWU1zMstc2K5CXc0uUoROAtTU65egEj3AgXFX1EATNX4ttufw
        eCmqP17lWQXem9eZafIFfM5AlMSCRhkKV1yn1uX1ttHJFRmjdECWgCFrITR07jPNo4V0GogObky
        L9F70vX8zwef7owIeqQ==
X-Received: by 2002:a05:6870:5702:b0:e2:9f03:dae1 with SMTP id k2-20020a056870570200b000e29f03dae1mr10659473oap.201.1653917377262;
        Mon, 30 May 2022 06:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu/pXp4Z/Fvwc6wmxSd2IqK9Sx9IckVuTGZzO0QIetDq4O92xLhfJDslUVrt1C9DQHDNi3OQ==
X-Received: by 2002:a05:6870:5702:b0:e2:9f03:dae1 with SMTP id k2-20020a056870570200b000e29f03dae1mr10659455oap.201.1653917376984;
        Mon, 30 May 2022 06:29:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id cv18-20020a056870c69200b000e686d13883sm3519997oab.29.2022.05.30.06.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:29:36 -0700 (PDT)
Date:   Mon, 30 May 2022 21:29:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic/623: fix test for runing on overlayfs
Message-ID: <20220530132930.hbvehsbu3nppq6y7@zlang-mailbox>
References: <20220530112905.79602-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530112905.79602-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 30, 2022 at 02:29:05PM +0300, Amir Goldstein wrote:
> For this test to run on overlayfs we open a different file to perform
> shutdown+fsync while keeping the writeback target file open.
> 
> We should probably perform fsync on the writeback target file, but
> the bug is reproduced on xfs and overlayfs+xfs also as is.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Zorro,
> 
> I tested that this test passes for both xfs and overlayfs+xfs on v5.18
> and tested that both configs fail with the same warning on v5.10.109.
> 
> I tried changing fsync to syncfs for the test to be more correct in the
> overlayfs case, but then golden output of xfs and overlayfs+xfs differ
> and that would need some more output filtering (or disregarding output
> completely).
> 
> Since this minimal change does the job and does not change test behavior
> on xfs on any of the tested kernels, I thought it might be good enough.
> 
> Thanks,
> Amir.
> 
>  tests/generic/623 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/623 b/tests/generic/623
> index ea016d91..bb36ad25 100755
> --- a/tests/generic/623
> +++ b/tests/generic/623
> @@ -24,10 +24,13 @@ _scratch_mount
>  # XFS had a regression where it failed to check shutdown status in the fault
>  # path. This produced an iomap warning because writeback failure clears Uptodate
>  # status on the page.
> +# For this test to run on overlayfs we open a different file to perform
> +# shutdown+fsync while keeping the writeback target file open.
>  file=$SCRATCH_MNT/file
>  $XFS_IO_PROG -fc "pwrite 0 4k" -c fsync $file | _filter_xfs_io
>  ulimit -c 0
> -$XFS_IO_PROG -x -c "mmap 0 4k" -c "mwrite 0 4k" -c shutdown -c fsync \
> +$XFS_IO_PROG -x -c "mmap 0 4k" -c "mwrite 0 4k" \
> +	-c "open $(_scratch_shutdown_handle)" -c shutdown -c fsync \

Did you try to reproduce the original bug which this test case covers?

According to the "man xfs_io":

       open [[ -acdfrstRTPL ] path ]
              Closes the current file, and opens the file specified by path instead. Without any arguments, displays statistics about the current file - see the stat command.

Although I doubt if it always real close the current file, but you open to get
a new file descriptor, later operations will base on new fd. I don't know if
it still has original testing coverage.

I'd like to help this case to support overlay, presuppose original fs
testing isn't changed. Or it's not worth.

Welcome more review points from the author of this case and others.

Thanks,
Zorro

>  	-c "mwrite 0 4k" $file | _filter_xfs_io
>  
>  # success, all done
> -- 
> 2.25.1
> 

