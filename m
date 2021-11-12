Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF4C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Nov 2021 23:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A3360EB8
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Nov 2021 23:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhKLXsa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 12 Nov 2021 18:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhKLXs3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Nov 2021 18:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636760737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPAm1mrFAZB6fSD8mo4Nr6ksxNHSwNt9gRv7xK5uBog=;
        b=Ej4QbdUy4Xrxl5Q1p/olZRT3kwOBl4wShufzOPhugTVhRIwxGlKdgE9kp3nksoa6ulK+uL
        /0o9/JINNJd7ydD0eaIuQmcPcbVlJaojFjd17Ae4buBYzHB/a8Zvf5dN/LVffQwKPzl+zh
        0+Sfqwzir7Lm3GvNY2ljxFEr7lp57Ns=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-GhntrV51Muqj7VrMMZAsnw-1; Fri, 12 Nov 2021 18:45:36 -0500
X-MC-Unique: GhntrV51Muqj7VrMMZAsnw-1
Received: by mail-pf1-f197.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so6430880pfx.21
        for <fstests@vger.kernel.org>; Fri, 12 Nov 2021 15:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPAm1mrFAZB6fSD8mo4Nr6ksxNHSwNt9gRv7xK5uBog=;
        b=GQjnRCdze7TeGn7kZdVw3JAS5aaLTiovnXAusWy3lXU49cOUXPyOHttWPgYpKawlS6
         w4mdslait6iFUbdKjc+KImeJGKwlIqowUHrVRfR6XF610IhOehXvPj9Gr3U+caUoW1cB
         F3A9zDFWpZZu7clz4d018+G8biThIB8ROjq7v6BAG25D7YOH3Cc24huk9DxggMN1uhdi
         w9EuuupRp3iCIZWDsOe8YTxSjTHhv/JqUVlXjVviDLecT/LT8Drbhb/PhjfFihgbNFDO
         W57FH3UhjF9WRvcdwMazTwKnhCtvAZbKnLaV2TYdnaderxGqP/gCmM+vhGP5lF1nz5bT
         wtTg==
X-Gm-Message-State: AOAM5306RP5ULM+Hdjy2KPe4aEND/u94+HEMvaFoqONFUUCalBvLj+6i
        Kqiloz+9BqTb6jRMOxJNwibnLqgAuARRaei5ppInWpclJgUDjdcxRshscsjcGmMPTwp3VLV0H8k
        MVm8ZPGy+5EeNYMK3wbf9YkrqVrhiH/gk5w==
X-Received: by 2002:a17:902:cec4:b0:141:cfa1:f7e with SMTP id d4-20020a170902cec400b00141cfa10f7emr12173474plg.13.1636760735162;
        Fri, 12 Nov 2021 15:45:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWs+tfJ95dUoHGVPbmkYAXLLMMeJgRLVKNsdl/9zbwBb+Ie/jkmkXnVzcSg0YvLznCER0XehILVqaVWSPEHfE=
X-Received: by 2002:a17:902:cec4:b0:141:cfa1:f7e with SMTP id
 d4-20020a170902cec400b00141cfa10f7emr12173459plg.13.1636760734963; Fri, 12
 Nov 2021 15:45:34 -0800 (PST)
MIME-Version: 1.0
References: <1636514473-2107-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1636514473-2107-1-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Boyang Xue <bxue@redhat.com>
Date:   Sat, 13 Nov 2021 07:45:24 +0800
Message-ID: <CAHLe9YbMcG7JWCyo-3qAooSOZ0cbBP9maHrpfQiKNFRRGAa+tA@mail.gmail.com>
Subject: Re: [PATCH] ext4/051: correct kernel commit
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello Yang Xu,

I'm the author of the test ext4/051. Yes the original commit ID and
message is wrong, and I think you're correcting with the right commit.
Thanks for fixing it!

I was not aware of it but the original patch had been edited before
finally merged in mainline:
https://lore.kernel.org/all/20210812124737.21981-1-jack@suse.cz/

Thanks,
Boyang

On Wed, Nov 10, 2021 at 11:21 AM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:
>
> ext4/051 fails on my test machine, but I can't find commit in e2fsprogs
> according to commit log that said it is a e2fsprog regression test.
> Actually, it is a kernel regression test.
> So remind user it is a kernel regression test and use correct fix kernel
> commit[1].
>
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2bbb92f
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/ext4/051 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/ext4/051 b/tests/ext4/051
> index b4f56b08..d0e01465 100755
> --- a/tests/ext4/051
> +++ b/tests/ext4/051
> @@ -5,8 +5,8 @@
>  # FS QA Test No. 051
>  #
>  # Test that tune2fs doesn't fail after ext4 shutdown
> -# Regression test for commit:
> -# e905fbe3fd0f ext4: Fix tune2fs checksum failure for mounted filesystem
> +# Regression test for kernel commit:
> +# b2bbb92f7042 ext4: fix e2fsprogs checksum failure for mounted filesystem
>  #
>  . ./common/preamble
>  _begin_fstest auto rw quick
> --
> 2.23.0
>

