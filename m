Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211FECAAD1
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Aug 2022 02:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiH1CtL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 27 Aug 2022 22:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiH1CtK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 27 Aug 2022 22:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857AA2ED51
        for <fstests@vger.kernel.org>; Sat, 27 Aug 2022 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661654948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68X0zg3NEM88zYos+dzftqhh6Zlx3yOU3jN3Id6tzdQ=;
        b=H52ZNWr1bSZ+SRBWTExjc/HbXRP8BBZRMjzFOULXiVTd9NUL7W7oSyPkbCZECYOU6JUwpz
        O/i6Roo2cKeN0UBfOvTI/gqnoCp0MZhpZ4OXE7om+mchFDuipKpmOruk/ymY2StqRO5lwT
        aXtujMYIqZA4hyYptJSMiqr7PhrkMxs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-321-1ROgS0YpP-6MHsCTfB3-cA-1; Sat, 27 Aug 2022 22:49:07 -0400
X-MC-Unique: 1ROgS0YpP-6MHsCTfB3-cA-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso4153392qkp.21
        for <fstests@vger.kernel.org>; Sat, 27 Aug 2022 19:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=68X0zg3NEM88zYos+dzftqhh6Zlx3yOU3jN3Id6tzdQ=;
        b=Sw7HPPlr9LTuzRJUYdcIgUR+qLb+P1lAv38VraEwOzysD59Z2nPgf1ajpzCoFGcYJX
         XwzYkm/Xt+NM62HA2zHf7RBIGXnLEtJDSCy26APsIqYpyubfoFPKk2a7AwQXlBIZEFaz
         0maAA1isahIIjrKxkICizjXa2hIRHTK1k8yqRzSSkLB6SHEuu5eBM8m0fCRr3+L6eRgB
         nzOKQ2GxZkp+hAI+Mj8p5eE8TjMu8+wAeX0zltZPrnctyJKJ3UCGmrtmUsfYbZ0T6FuS
         pR+vuuEtoH8aVrR3bllFmZZZgYd1Cn33xNmV/E1JWrJwYM6mwrZAUfhAsk8UwQ4+h/KG
         6L5A==
X-Gm-Message-State: ACgBeo0HObAoxM87DLhHChz63lJmBEdZFw7RDfXX3tc2cT2Q2qOYP8nK
        HjMvFawKcAEuqFAqPWOJ3lhiIsSJneEwYcHUXFpCEtKH/LaYEbc1FcZ3Tu38PSmqV7VJ1S0j5k/
        fe4rfvUoYfmWx7BHCNg==
X-Received: by 2002:a05:6214:c44:b0:497:1321:b7a7 with SMTP id r4-20020a0562140c4400b004971321b7a7mr5659505qvj.16.1661654946626;
        Sat, 27 Aug 2022 19:49:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4l0x25JtgDBZhxzAsWMWgLDcUeKwiIG/3i5Z4Fb7nKFdXAJPKH9MCTErDsDpJP+sXfPb96Zw==
X-Received: by 2002:a05:6214:c44:b0:497:1321:b7a7 with SMTP id r4-20020a0562140c4400b004971321b7a7mr5659496qvj.16.1661654946364;
        Sat, 27 Aug 2022 19:49:06 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z20-20020ac87f94000000b003051ea4e7f6sm2816172qtj.48.2022.08.27.19.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 19:49:05 -0700 (PDT)
Date:   Sun, 28 Aug 2022 10:48:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, jack@suse.cz, oliver.sang@intel.com,
        lkp@intel.com, linux-ext4@vger.kernel.org, tytso@mit.edu,
        lczerner@redhat.com
Subject: Re: [PATCH] ext4/053: Remove nouser_xattr test
Message-ID: <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
References: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 17, 2022 at 11:10:23AM +0800, Yang Xu wrote:
> Plan to remove noacl and nouser_xattr mount option in kernel because they
> are deprecated[1]. So remove nouser_xattr test in here.

What's the [1]?

We'd better to be careful when we want to remove a testing coverage. I'm not
sure if they've decided to removed this mount option, the ext4/053 is an
important test case for ext4, so I'd like to hear their opinion.

Thanks,
Zorro

> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/ext4/053 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 555e474e..5d2c478a 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -439,7 +439,6 @@ for fstype in ext2 ext3 ext4; do
>  	mnt oldalloc removed
>  	mnt orlov removed
>  	mnt -t user_xattr
> -	mnt nouser_xattr
>  
>  	if _has_kernel_config CONFIG_EXT4_FS_POSIX_ACL; then
>  		mnt -t acl
> -- 
> 2.27.0
> 

