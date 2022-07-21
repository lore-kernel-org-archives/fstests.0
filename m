Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6F3C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 15:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiGUP3T (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGUP3S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 11:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A2067FE67
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658417357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGmvQD4jZESscpLk7KvGpoZsYp0VHnYIXvMFCB64A1w=;
        b=Xg3R5vFlrNHX6sz//2KJcn314G4wyzIVb8A/5JpbPv/itdzMDqNGNmofDojRA1IWqgUbM0
        zB1uaB4KE3QiIbWF0+rIa6VSbA6KcT+0PiYm9ocepAqQPRLOg6aifm2iIZzZPNvbAxUn8Q
        j4t48zx8740/AwZM8DoWEtBq4ohedc4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-Cx14bFs8P5yoRpCdhjrZeA-1; Thu, 21 Jul 2022 11:29:15 -0400
X-MC-Unique: Cx14bFs8P5yoRpCdhjrZeA-1
Received: by mail-qv1-f71.google.com with SMTP id k7-20020a056214102700b004740a13b3bcso1261263qvr.4
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 08:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGmvQD4jZESscpLk7KvGpoZsYp0VHnYIXvMFCB64A1w=;
        b=DIuxLRazoi7TQPsbz1/bZAVwPG9tNwRsrUM++qDjwnjWCzNqHNNryr2fe3vEVj7oVs
         OF32Hvm40SrVaUqIZ82fbfIQ4Ihr9sAgXSGHi+5AilaUyjrd6Ri7zhxzdyS0kLs8BkTe
         GTMdrgz/ek1I4RGsgIfsQwAOWbbRwpLOtRfYP2/0KLCzRmXvmFAP9zCsEiboocHu6DuB
         yoADdJYmq88YMlOHt6i6Ir2HyY8vEkuW66ulv9B6fupbBAAtFo+nOc2NDqZmznM1c+nq
         Vf0dk0B0FhTWd+mgG8IlId637wB9E6trdWSM3JkUPknnRiRLLJOiRMY6AYy5RNLA+Fy/
         +yrw==
X-Gm-Message-State: AJIora8+mYAafnSUywGfQARU+qPOpvKbEKdOLy4jOHDRnKrvJLkVHXNc
        lf+O9n/xU2FdmFD50Mk/mc1qzb4F5U3wAW+fB5Aji7+IefzHnE/oa+sViJK1CZ9mszPUwlSsx/7
        NnMLr/EpsGCuHxtjLrA==
X-Received: by 2002:a05:620a:4546:b0:6b5:f144:68bb with SMTP id u6-20020a05620a454600b006b5f14468bbmr12636760qkp.253.1658417354664;
        Thu, 21 Jul 2022 08:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vC8+9it8KkM+/OUS2c5Vr4K3l/X0q1B5dLT+SdLoPo16QGgUVbDBgadu5f1YkaGL5DHq01eg==
X-Received: by 2002:a05:620a:4546:b0:6b5:f144:68bb with SMTP id u6-20020a05620a454600b006b5f14468bbmr12636745qkp.253.1658417354382;
        Thu, 21 Jul 2022 08:29:14 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l9-20020a37f909000000b006b59eacba61sm1590634qkj.75.2022.07.21.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:29:14 -0700 (PDT)
Date:   Thu, 21 Jul 2022 23:29:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Message-ID: <20220721152909.otn3spgou5inzhoo@zlang-mailbox>
References: <20220721022959.4189726-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721022959.4189726-1-bxue@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 10:29:59AM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> The test requires larger scratch dev size when running on top of NFS other
> than ext4 and xfs. It requires at least 27GB in my test. Without this
> requirement, the test run never finishes on NFS, leaving 100% scratch disk
> space use.
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
> Hi,
> 
> I find generic/476 easily goes into an infinite run on top of NFS. When it
> happens, the common pattern is 100% disk space use of SCRATCH_MNT, and
> `nfsiostat` shows 50% write error on SCRATCH_MNT. When I run it with a large
> enough SCRATCH_MNT, the problem disappears. So I post this patch to add the size
> requirement.
> 
> Please help review this patch. Thanks!
> 
> -Boyang
> 
>  tests/generic/476 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/476 b/tests/generic/476
> index 212373d1..dcc7c3da 100755
> --- a/tests/generic/476
> +++ b/tests/generic/476
> @@ -24,6 +24,7 @@ _cleanup()
>  _supported_fs generic
>  
>  _require_scratch
> +_require_scratch_size $((27 * 1024 * 1024)) # 27GB

At first, most of other filesystems don't need this requirement, that will
reduce test coverage of other fs suddently. Second, there's not a clear
reason to prove NFS (or others) need a 27+GB device to run this test. Due to
the generic/476 does nothing special, except random I/Os, even running with
ENOSPC...

So one difference of running with small device or large enough device is the
chance to run with ENOSPC. I think the device size isn't the root cause of
nfs hang you hit, I doubt if it's a NFS bug with ENOSPC, or something else
bug which is triggered by someone random I/O operation.

We'd better not to skip a known generic test (from upstream fstests directly)
if without a clear reason. That might cause we miss bugs or test coverage,
better to make sure if it's a real bug at first. Then think about if we need
to improve the case or fix a bug.

Thanks,
Zorro

>  _require_command "$KILLALL_PROG" "killall"
>  
>  echo "Silence is golden."
> -- 
> 2.27.0
> 

