Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3964EC4332F
	for <linux-fstests@archiver.kernel.org>; Sat, 10 Dec 2022 15:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLJP0m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 10 Dec 2022 10:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLJP0l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 10 Dec 2022 10:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D8D16491
        for <fstests@vger.kernel.org>; Sat, 10 Dec 2022 07:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670685946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=enn01FuTOQX3sWbl6nwLLluRb6rLiXQO0WSTdDWLOl0=;
        b=KchjF3hV/5qAsK8mDLazU4ELeW/5K+InnZzzemo9Y+/lw76J7q9v24rAZi/rHx5sA/zccF
        904A6lEwPgk8SS8ZwxZR/pI1aZv06UYIYGU/FZ1tN10SNA82Mc2J/JlnSzLIRnwXFYlL9G
        Ha7ZLiPyGB13sutP5qPSnrUvhX02yYU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-JWK7CKZmOTe0sqZ5KSfPrQ-1; Sat, 10 Dec 2022 10:25:44 -0500
X-MC-Unique: JWK7CKZmOTe0sqZ5KSfPrQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-39afd53dcdbso82485227b3.8
        for <fstests@vger.kernel.org>; Sat, 10 Dec 2022 07:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enn01FuTOQX3sWbl6nwLLluRb6rLiXQO0WSTdDWLOl0=;
        b=kmHmIJtlCBtO1cpt9sWY1Wj9GvbnMkoa/5Uns80sdJdmY6WZ6AILhk0LIuZ57enad4
         GjI3R6ZcHAiA/DQ8pvSjZAcCZ8A6x9InLqFfY9QhABAolTWRy89+oudM3XNRb4sPUogo
         +qYsjrXC6JBUl/ZW7zL0NknXHAEdFlGFvwH6Ea88wxeykHMOgxDEFUJ2FLaR6fs2YAxO
         qF+HO0c6n9NTT0qTeBNGF9fGMUiNd3xEIdan+FG2/T72oor3/QOtBIKmm8HVZ2IurkbD
         5BHxGXJK0x60C1sxY0sUCkCC9y9TkudQ4fps5YpWQZOaT0FpCsUolPDcekbURvvvvDjs
         Z8aA==
X-Gm-Message-State: ANoB5pkkQjfXWPJ7bz9ZCPVlUDQrRxepQlielfMYfLiseNajwfi/AYOc
        U354abIaMEcmjDcTtb7VLAZ5MlptV0BrvRnyfy022Xkt6B010EW8qCLdovr+LlGXaSAiqpDeEYP
        rLzpWgKLODWelOgCxMA==
X-Received: by 2002:a25:ef42:0:b0:6ef:d793:820c with SMTP id w2-20020a25ef42000000b006efd793820cmr8339255ybm.10.1670685944086;
        Sat, 10 Dec 2022 07:25:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6aFoHnL/hnTIubrRHkr/IJ3H0daVnJ+2SokIi4tBIQCUSjD21CSL4KQKbzTSTxgGV4IztFEA==
X-Received: by 2002:aa7:97a3:0:b0:578:2e3b:472e with SMTP id d3-20020aa797a3000000b005782e3b472emr1556717pfq.29.1670681486117;
        Sat, 10 Dec 2022 06:11:26 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p16-20020aa79e90000000b0057691fb0d37sm2785789pfq.193.2022.12.10.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 06:11:25 -0800 (PST)
Date:   Sat, 10 Dec 2022 22:11:21 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] add files to ignore & chmod 755 tests/generic/692
Message-ID: <20221210141121.ehlec7dnpwchynbe@zlang-mailbox>
References: <1670639465-53-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670639465-53-1-git-send-email-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Dec 10, 2022 at 02:31:05AM +0000, Shiyang Ruan wrote:
> 1. The executable binary in src/ should be in ignore file.
> 2. tests/xfs/216.out is a symlink generated at runtime, also should be
>    ignored.
> 3. tests/generic/692 was created with 644.  It should be 755 otherwise
>    its mode will be changed and dirty the git tree after test.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> ---

Looks good to me, if no objection or better idea, I'd like change the subject
as below when I merge it:
  fstests: batch update of file mode and untracked files

Thanks,
Zorro

>  .gitignore        | 2 ++
>  tests/generic/692 | 0
>  2 files changed, 2 insertions(+)
>  mode change 100644 => 100755 tests/generic/692
> 
> diff --git a/.gitignore b/.gitignore
> index ad9f45437..a6f433f1d 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -79,6 +79,7 @@ tags
>  /src/dirstress
>  /src/e4compact
>  /src/ext4_resize
> +/src/fake-dump-rootino
>  /src/fault
>  /src/feature
>  /src/fiemap-tester
> @@ -205,6 +206,7 @@ tags
>  /tests/xfs/033.out
>  /tests/xfs/071.out
>  /tests/xfs/096.out
> +/tests/xfs/216.out
>  
>  # cscope files
>  cscope.*
> diff --git a/tests/generic/692 b/tests/generic/692
> old mode 100644
> new mode 100755
> -- 
> 2.38.1
> 

