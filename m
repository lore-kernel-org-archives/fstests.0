Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25761C05027
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Feb 2023 08:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBQIQF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBQIQE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2023 03:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE85F246
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 00:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676621716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbS7911hScRu2MaDwz0qjzrdGp+96HgI0J1ybBnU28c=;
        b=QHE3yDMhgNCuRdfgL5sRhOvLeZQyymBEwwa94p/gt3NKhFYaqOWeAg0qykmYx1eRkf9etZ
        QQp5IjCPpd4TWwqIQ3qBXYg02uIboYEXksco/1uRn9Pn9DA50zxMGGAOTL8HKfvcSRLZJp
        shN0SJGdz3UPnhgUaZzYJcGVrvd8Kc4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-417-ELmcc1A0MraXjrTSUzyL4Q-1; Fri, 17 Feb 2023 03:15:14 -0500
X-MC-Unique: ELmcc1A0MraXjrTSUzyL4Q-1
Received: by mail-pj1-f69.google.com with SMTP id u21-20020a17090adb5500b0023670a0d9b3so601519pjx.1
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 00:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbS7911hScRu2MaDwz0qjzrdGp+96HgI0J1ybBnU28c=;
        b=KAoFnrKqpUyCIXtmj7ZiwBfOqldDjQ6XpF75oBy2ybWss1bu3XcbnoUnJ9dM7gtzXw
         iZZ4Uq0RpGBo6VQIgrThJU4e9082gGJKDm7yy15C+OvkAHBHUbPnBbwPiZyvf6vq5WlD
         sTVGatnhUp3W8qVQQs99ocMr7gUQr29si7aQ+2u9MMA9Onfiv5gQPDUCR72fcGa9qs0N
         fUSBouOUZ3cnQV25Jlxh+J9pY3SHoNUOfxRHwMCYPE5ZtBiNGRHtyQpRKHStk7cgDhlc
         fiRr4kax+pheUyInIz0/b79eL+4xPpUlsLlnN9FgXh+RBkZHMEh8w5PO50QBV0Axc4Mv
         io5A==
X-Gm-Message-State: AO0yUKUcXvPxuoNmxUWnNZ4HBEQ8WvxpO0O9r2gOVrEqAoxXb3csmYb8
        zZl0oNzYbstHKhvKxM3TrDA5qPsf7KtTYwpT4HlcvRG8c6qIOZVogvSp11MyaXbvbX+hSQPPnz3
        24N0g3UfxHdQC86aQ/M/Lfni440CB
X-Received: by 2002:a17:90a:e7ce:b0:233:bd59:5719 with SMTP id kb14-20020a17090ae7ce00b00233bd595719mr5366140pjb.0.1676621713546;
        Fri, 17 Feb 2023 00:15:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+oiPN2g1rzO+fZ9kUvMHirlL2J4UxJHHsGxGHpTYl+WDpPYp2aAoLOHQdVeTuRcXeyHrronw==
X-Received: by 2002:a17:90a:e7ce:b0:233:bd59:5719 with SMTP id kb14-20020a17090ae7ce00b00233bd595719mr5366127pjb.0.1676621713194;
        Fri, 17 Feb 2023 00:15:13 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gx11-20020a17090b124b00b002309279baf8sm4393423pjb.43.2023.02.17.00.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:15:12 -0800 (PST)
Date:   Fri, 17 Feb 2023 16:15:08 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/604: fix test to actually create dirty inodes
Message-ID: <20230217081508.gpsmhgxbdli4gtwu@zlang-mailbox>
References: <4dd1c7d583289c12d2acf8bfee3b555307399220.1676564465.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd1c7d583289c12d2acf8bfee3b555307399220.1676564465.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 16, 2023 at 04:21:50PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test case generic/604 aims to test a scenario where at unmount time we
> have many dirty inodes, however the test does not actually creates any
> files, because it calls xfs_io without the -f argument, so xfs_io fails
> but any error is ignored because stderr is redirected to /dev/null.
> 
> Fix this by passing -f to xfs_io and also stop redirecting stderr to
> /dev/null, so that in case of any unexpected failure creating files, the
> test fails.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/604 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/604 b/tests/generic/604
> index 3c6b76a4..9c53fd57 100755
> --- a/tests/generic/604
> +++ b/tests/generic/604
> @@ -22,7 +22,7 @@ _require_scratch
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  for i in $(seq 0 500); do
> -	$XFS_IO_PROG -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null 2>&1
> +	$XFS_IO_PROG -f -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null

Thanks for catching and fixing this issue.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  done
>  _scratch_unmount &
>  _scratch_mount
> -- 
> 2.35.1
> 

