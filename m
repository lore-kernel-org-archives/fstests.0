Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C587AC4332F
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Dec 2022 14:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLIOAa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIOA3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Dec 2022 09:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B2777212
        for <fstests@vger.kernel.org>; Fri,  9 Dec 2022 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670594367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DtOqqrMaw2JPnbMZlrl9s4VFPCKR2oUUhKcTc9NPbrU=;
        b=aZ71mdFNpZprmLHeu3GbWwW9APQ8kOS/Xvd/u65skmtf2NpcQsG0nKNFYkt+5LO+Ojx4d4
        4xk8R0hLrCWxrE31f7KJ38KWCNd7Yp+xE2n7uZrrIeqMBwmuf2QZhh7t51/NqmiAA8LOSL
        jWzjqm9uugn9CbX3n9+wNqGI0LiiW0w=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-ys0lnPJ1PF2VisEbycTL6Q-1; Fri, 09 Dec 2022 08:59:25 -0500
X-MC-Unique: ys0lnPJ1PF2VisEbycTL6Q-1
Received: by mail-pg1-f199.google.com with SMTP id f132-20020a636a8a000000b00473d0b600ebso3132589pgc.14
        for <fstests@vger.kernel.org>; Fri, 09 Dec 2022 05:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtOqqrMaw2JPnbMZlrl9s4VFPCKR2oUUhKcTc9NPbrU=;
        b=z3rU9fhe7U6bQxjZ9J89+gQoKHwYoP7VG4HFU+3j1sQizWXwJ2qnCQQ5MFTok3WkIr
         7q4vSYAyvf5/m6TMbm9kkeHoOLb5Vxy/40uwrro4D8T2su5UEymcq52STVHuzjGcV/ol
         rp+i8UisVdn+EN8e0lKiCepUNpfhwo/jXG7Go6KIQI6V+PxlGhe/0YT2ZV+nILuWoLsO
         Y/C9x7N/Syf4F3T7UCqXLz4We8bYlU+lCzlKbw9M7XFzMURHJWAfETniL726/IyXZUpA
         xOl/Wh5QVBvnHqPqUf9ZisWY8PEtF+wI8AK+mz8v5JcOGoLMJd8tPmhG+bhhRU21zAtc
         4Ijg==
X-Gm-Message-State: ANoB5pkF73XZOTpA8oWYIHSgDUo1Xc0whoiW5PMBAv4K/Jl0XgLGqzMi
        WKdrxYMfkaCn3ZC/ytIAMDc6WlE5loS/clNNg+3Oss+B7XV1Ydjl8BRYHmVgr+oe+QOwkGX4NXu
        qTINmcunjjh1oFEvzNw==
X-Received: by 2002:a17:902:aa87:b0:187:480d:f37a with SMTP id d7-20020a170902aa8700b00187480df37amr6067093plr.24.1670594364706;
        Fri, 09 Dec 2022 05:59:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7XeU7zx3Z/4j8KHFao/DE5TzvGEu2Zr+tz+EX1nih+YTt6iXrxho6S5MZ/+sEbb8q8PfcikA==
X-Received: by 2002:a17:902:aa87:b0:187:480d:f37a with SMTP id d7-20020a170902aa8700b00187480df37amr6067078plr.24.1670594364392;
        Fri, 09 Dec 2022 05:59:24 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b00188fdae6e0esm1397877plg.44.2022.12.09.05.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:59:23 -0800 (PST)
Date:   Fri, 9 Dec 2022 21:59:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] ignore src/fake-dump-rootino and tests/xfs/216.out
Message-ID: <20221209135919.txajl7kmt6pvmdcf@zlang-mailbox>
References: <1670578130-13-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670578130-13-1-git-send-email-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 09, 2022 at 09:28:49AM +0000, Shiyang Ruan wrote:
> 1. The executable binary in src/ should be in ignore file.
> 2. tests/xfs/216.out is a symlink generated at runtime, also should
>    be ignored.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---

I think we can combine these two patches into one patch. Due to they all try to
avoid dirty git tree after building/testing.

After that, you can add:
Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index ad9f45437..a1107003a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -80,6 +80,7 @@ tags
>  /src/e4compact
>  /src/ext4_resize
>  /src/fault
> +/src/fake-dump-rootino
>  /src/feature
>  /src/fiemap-tester
>  /src/fill
> @@ -205,6 +206,7 @@ tags
>  /tests/xfs/033.out
>  /tests/xfs/071.out
>  /tests/xfs/096.out
> +/tests/xfs/216.out
>  
>  # cscope files
>  cscope.*
> -- 
> 2.38.1
> 

