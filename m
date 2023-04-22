Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F89C6FD18
	for <linux-fstests@archiver.kernel.org>; Sat, 22 Apr 2023 08:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDVIZx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 22 Apr 2023 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDVIZw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 22 Apr 2023 04:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D0819B
        for <fstests@vger.kernel.org>; Sat, 22 Apr 2023 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682151904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fo98sPRado6i9ZjZ5+U7hRnm9axVVu76O4ZpTTgL5mU=;
        b=gMi5sUWtKvdou+2PNLJZdr+70NbKFf6a7KopDK5uw0pgG9RVunLU7TVxyyDl8VYjQKH03C
        OOzDHfW9HNw2ras0M+td4/cMyRxmuGZrtGS9SkNCD6GFrOICOy26E+R/HZ7PLexSvwK3jA
        HQaNBzhDakrpvawUfzwoWhN8nA8g5oo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-RByn0cUAMjarJz0tz7X6Vg-1; Sat, 22 Apr 2023 04:25:02 -0400
X-MC-Unique: RByn0cUAMjarJz0tz7X6Vg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24763adb145so2740760a91.2
        for <fstests@vger.kernel.org>; Sat, 22 Apr 2023 01:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682151901; x=1684743901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo98sPRado6i9ZjZ5+U7hRnm9axVVu76O4ZpTTgL5mU=;
        b=PXyEY5we3hGAKDI1J26Y6tKDo+qVZEV8qb7zPatAKIv/zLEerBCAyBd+TjuuVXfiHL
         gKNCe5zOX2eSoRljkwAJAh0dFC25geIXMRq0OMKMhclaaewu46g11mbIwFS/SwvQgEXC
         beXT+jJrd+GcGMo7EhR6Kt4nTK4OcpKOBCurBH6OYAQHDmcHfG5+nwEEy1xjLA75qDEA
         YsQUW0CXLZsipy5Z3nMhnm+CB1p4nnmHKWG+3wdMwXkeIy7nR+a7IqPpjE573gIRl5Lp
         UkBjL/7XJuIGwUtagtL4vyMm64Gp8sBGnUwUgZOJbVqckLcyc8EScQvFBTgi6grYZ6sK
         NRxA==
X-Gm-Message-State: AAQBX9f9g7eKAZtqLlmnXlaRReUJ1IVGNmitoqCab3UGiOYh0gZ+JDL2
        nIJLaGKZnx6FnoNAm7yMxRpNFnXofZP45X35F8TapJItPIyKxQAhfW4ELkvIiQYTLfsy0S6sfo8
        naRH5mu1tY+pguazG6g==
X-Received: by 2002:a17:90a:4f0b:b0:247:1e13:90ef with SMTP id p11-20020a17090a4f0b00b002471e1390efmr7685760pjh.20.1682151901632;
        Sat, 22 Apr 2023 01:25:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y/1WYyWDvY7Vd5JNgv35XimIX39iYRM4fzaXqMnxD1AhlmfF7bJ8hnu2D3wO1yivhdczhOvA==
X-Received: by 2002:a17:90a:4f0b:b0:247:1e13:90ef with SMTP id p11-20020a17090a4f0b00b002471e1390efmr7685746pjh.20.1682151901275;
        Sat, 22 Apr 2023 01:25:01 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jl16-20020a170903135000b001a216d44440sm3656173plb.200.2023.04.22.01.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 01:25:00 -0700 (PDT)
Date:   Sat, 22 Apr 2023 16:24:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 1/3] generic/476: reclassify this test as a long running
 soak stress test
Message-ID: <20230422082456.6nsk5ve756j37jas@zlang-mailbox>
References: <168123682679.4086541.13812285218510940665.stgit@frogsfrogsfrogs>
 <168123683265.4086541.1415706130542808348.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168123683265.4086541.1415706130542808348.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 11, 2023 at 11:13:52AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test is a long(ish) running stress test, so add it to those groups.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/476 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/generic/476 b/tests/generic/476
> index 212373d17c..edb0be7b50 100755
> --- a/tests/generic/476
> +++ b/tests/generic/476
> @@ -8,7 +8,7 @@
>  # bugs in the write path.
>  #
>  . ./common/preamble
> -_begin_fstest auto rw
> +_begin_fstest auto rw soak long_rw stress

Sorry for late reviewing. I thought a bit more about this change. I think
the "soak", "long_rw" and "stress" tags are a bit overlap. If the "stress"
group means "fsstress", then I think the fsstress test can be in soak
group too, and currently the test cases in "soak" group are same with the
"long_rw" group [1].

So I think we can give the "soak" tag to more test cases with random I/Os
(fsstress or fsx or others). And rename "long_rw" to "long_soak" for those
soak group cases which need long soaking time. Then we have two group tags
for random loading/stress test cases, the testers can (decide to) run these
random load test cases seperately with more time or loop count.

Anyway, above things can be done in another patchset, I just speak out to
get more talking:) For this patch:

Reviewed-by: Zorro Lang <zlang@redhat.com>



Thanks,
Zorro

[1]
# ./check -n -g soak
SECTION       -- simpledev
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64
MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch

generic/521
generic/522
generic/642

# ./check -n -g long_rw
SECTION       -- simpledev
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64
MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch

generic/521
generic/522
generic/642


>  
>  # Override the default cleanup function.
>  _cleanup()
> 

