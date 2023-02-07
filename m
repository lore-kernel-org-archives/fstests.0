Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F7C636CC
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Feb 2023 18:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjBGSrc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjBGSrS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Feb 2023 13:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D08241E0
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675795592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2XeUDSc5+zJsuSlSiabULeVAKK0BXLAlNRHeyKAxH8=;
        b=Cm//flo3IK/b4ZsJOjqsOA32lY63ZjYdUv8Ba22M1ff3C/CVer1cL9wwz1sNQNIS9xk7jX
        fgGXcNXw0j32rUSoKhQmnz5u0Aipriu1YcpEycFV5iQxv+nKcVrMaf6A+v8OeWCur6azP0
        Et1wc4MtBfKx02u4SeGS6qWkLE+gfoM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-QyOHB_sdPMe7qiO3xlpgPw-1; Tue, 07 Feb 2023 13:46:31 -0500
X-MC-Unique: QyOHB_sdPMe7qiO3xlpgPw-1
Received: by mail-pj1-f70.google.com with SMTP id a10-20020a17090a740a00b002307faf7db2so4493382pjg.1
        for <fstests@vger.kernel.org>; Tue, 07 Feb 2023 10:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2XeUDSc5+zJsuSlSiabULeVAKK0BXLAlNRHeyKAxH8=;
        b=PAF7ifwGk5O4XG1XhPR6AgeO4ZfCz11KIGQu0flkbPYoI1yfIURhnKfv4L8usHb3+j
         /aQRO2e/QjhAOlLgKuv+ejM4pgNaoSRFjGp48L45SJym9HYWs9IHonB+RZu/GGi3YlZA
         5thFtqIedczejGc97iw+wYJvyIO6241eIgWyTk2/ou2BnWnR0v/5r+imihYR1gJpTc9w
         /8Z5LUguuH3uS6NruGHxE9+RIOe8WY8aIhbUGW0mjZG3KnvmGOyhISz3d3DX5LLAcqGv
         aZOP/5/eI9a2qiXWPB105wniVUGis3s/MRXHtaA6WkS3xO7OfeyCMt/8nfLAuPJUH9YX
         tUFA==
X-Gm-Message-State: AO0yUKXl8hVvdqJ2sbJp64XpLJusZgTINIS5cb4dEcPzWLix1t38rbSi
        1tA1QX3i9oyYPoNf+xn1l4qxpmlQyYj1xhqRNL7on1aQtCAvTvADQV6+w4FKHcXVqjvoyHsV4iM
        CjYmHp24EphUO/LBkkA==
X-Received: by 2002:a17:902:d0d2:b0:199:1f12:87d2 with SMTP id n18-20020a170902d0d200b001991f1287d2mr2941094pln.42.1675795590206;
        Tue, 07 Feb 2023 10:46:30 -0800 (PST)
X-Google-Smtp-Source: AK7set+WJf8Ptm9Z1RBJ1TToICrC/Bb9Zdg7FXi1NJbuRI68h3z8+AJL/WMWiShAN/GvdweTGCTl4A==
X-Received: by 2002:a17:902:d0d2:b0:199:1f12:87d2 with SMTP id n18-20020a170902d0d200b001991f1287d2mr2941083pln.42.1675795589890;
        Tue, 07 Feb 2023 10:46:29 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ja18-20020a170902efd200b001990a94a487sm5275802plb.293.2023.02.07.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:46:29 -0800 (PST)
Date:   Wed, 8 Feb 2023 02:46:25 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] xfs/357: switch fuzzing to agi 1
Message-ID: <20230207184625.rtdl42fzwfjksdva@zlang-mailbox>
References: <167243874614.722028.11987534226186856347.stgit@magnolia>
 <167243874627.722028.4085306307237352574.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167243874627.722028.4085306307237352574.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 30, 2022 at 02:19:06PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Since we now require a working AGI 0 to mount the system, fuzz AGI 1
> instead.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/357 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/357 b/tests/xfs/357
> index 8a2c920ef4..25af8624db 100755
> --- a/tests/xfs/357
> +++ b/tests/xfs/357
> @@ -25,7 +25,7 @@ echo "Format and populate"
>  _scratch_populate_cached nofill > $seqres.full 2>&1
>  
>  echo "Fuzz AGI"
> -_scratch_xfs_fuzz_metadata '' 'online' 'agi 0' >> $seqres.full
> +_scratch_xfs_fuzz_metadata '' 'online' 'agi 1' >> $seqres.full
>  echo "Done fuzzing AGI"
>  
>  # success, all done
> 

