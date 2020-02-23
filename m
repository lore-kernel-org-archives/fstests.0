Return-Path: <SRS0=lR6x=4L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E99C35671
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 12:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCAF20675
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 12:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is2Ov72S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgBWMqE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Feb 2020 07:46:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43098 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgBWMqD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Feb 2020 07:46:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so3815888pfh.10
        for <fstests@vger.kernel.org>; Sun, 23 Feb 2020 04:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=82G3IR4oJUzASc7KXOMWASAJ8K2wlTzxM+YrM7Soe8k=;
        b=is2Ov72S7Hk6ZLX59Q/mAcPP613oPw5YCF54lKd61tlz51vG1TtWoLQafKut/vdtMV
         x/vDboeQ8w4g6MBLS+alzsCWrL2miGAtVNfWkz2breK9l0QraJHeMHJje3c6TGUS7qWT
         y+oknVrp9jBM/LlXhz099O0H3HvsHFBnESISHAY/U9IBwvYwP1VtGApZnwYi9CX0r3hh
         C0pdplHfHYnsR9JBZG94BLaUeG3g1DkCbEm3rOPhVsyu1YpB8RDhTbvVnDTcwEaNRDFH
         yTRQ8E5Jr9uxIjnxGsc4VCxDRYGwB9FjD7q9kjIn5fyQYnYa8TBdNoDrpjHOvv6mQVhq
         UNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82G3IR4oJUzASc7KXOMWASAJ8K2wlTzxM+YrM7Soe8k=;
        b=X4EBQenGQAf11afL50G3Bq9SsIKFiIFTulBJ2MkAccEyI3mtUnXlNXuNRps76Q9JCV
         1VOInQyAEseLNGg+mts8Odjj5siqvdmjqjGdpS4KfYV5HGGuvXzlJdFrHvL4OBhYLWJe
         PaaUytOcS81h35GGcR9wUEbILydAsYcirmay8Wp8FqQk3/vvc+GCbdQUl0rEqulbl6bv
         QmAnVbBwKk7EdS0F34AFu/YckOjbypEBRPn4j8qre/5FTVvRthON+73MT4DeZ+7AN/b0
         PiR7pNg8gmvQko3hgb7ne9w0GwVCaaSEx5NzKmyiHs6J4EGsIg4jUw2+hDGJLyqxWvmA
         cdNw==
X-Gm-Message-State: APjAAAVUJxNnnvb83bzroj7WPMzOJlkzpqETE24OpI4Q6uzFM0BrpWx7
        M+NGzdf5WhELe9wpmxKTT2c=
X-Google-Smtp-Source: APXvYqzG4JSSWgISAjGU8j9zAZPVpZfftkUlCdPmCZTWaoPX5GC6nfI+2f9eoXK/Y021RU5Lmc4u1g==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr47720087pfi.105.1582461963212;
        Sun, 23 Feb 2020 04:46:03 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id g19sm9089377pfh.134.2020.02.23.04.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 04:46:02 -0800 (PST)
Date:   Sun, 23 Feb 2020 20:45:48 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/513: fix 4k allocsize fails on 64k pagesize
Message-ID: <20200223124545.GB3840@desktop>
References: <20200218165818.21066-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218165818.21066-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 19, 2020 at 12:58:18AM +0800, Zorro Lang wrote:
> The minimal I/O preallocation size is page size. The allocsize=4k
> always fails on 64k pagesize machine. So change the fs blocksize
> allocsize test to allocsize=64k.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

I think it's better to make the page size auto-detected, and filter out
the actual size to something like "PAGESIZE" in .out file.

> ---
>  tests/xfs/513     | 4 ++--
>  tests/xfs/513.out | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/513 b/tests/xfs/513
> index 70bc2f1c..3c3f5163 100755
> --- a/tests/xfs/513
> +++ b/tests/xfs/513
> @@ -178,13 +178,13 @@ do_test()
>  
>  echo "** start xfs mount testing ..."
>  # Test allocsize=size
> -# Valid values for this option are page size (typically 4KiB) through to 1GiB
> +# Valid values for this option are page size through to 1GiB
>  do_mkfs
>  if [ $dbsize -ge 1024 ];then
>  	blsize="$((dbsize / 1024))k"
>  fi
>  do_test "" pass "allocsize" "false"
> -do_test "-o allocsize=$blsize" pass "allocsize=$blsize" "true"
> +do_test "-o allocsize=64k" pass "allocsize=64k" "true"

do_test "-o allocsize=PAGESIZE" pass "allocsize=PAGESIZE" "true"

And do_test converts the "PAGESIZE" to actual page size.

>  do_test "-o allocsize=1048576k" pass "allocsize=1048576k" "true"
>  do_test "-o allocsize=$((dbsize / 2))" fail
>  do_test "-o allocsize=2g" fail
> diff --git a/tests/xfs/513.out b/tests/xfs/513.out
> index 9be18dd8..2d9f8384 100644
> --- a/tests/xfs/513.out
> +++ b/tests/xfs/513.out
> @@ -5,7 +5,7 @@ QA output created by 513
>  ** start xfs mount testing ...
>  FORMAT: 
>  TEST: "" "pass" "allocsize" "false"
> -TEST: "-o allocsize=4k" "pass" "allocsize=4k" "true"
> +TEST: "-o allocsize=64k" "pass" "allocsize=64k" "true"

So .out prints "... allocsize=PAGESIZE" ...

Thanks,
Eryu

>  TEST: "-o allocsize=1048576k" "pass" "allocsize=1048576k" "true"
>  TEST: "-o allocsize=2048" "fail"
>  TEST: "-o allocsize=2g" "fail"
> -- 
> 2.20.1
> 
