Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A0C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 18 May 2022 14:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiEROTW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 May 2022 10:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiEROTV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 May 2022 10:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED9034C7A1
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652883560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfckOg9nc/G1Pfdg8hFEzkjneT+SXrT9/xnBgJMJNjw=;
        b=BtK6uANpbrKHRfqnQCeAwB4qcpxGo4hFuTl1cepGigKRq59CeLFnbgvF1O74nzEKTP0cJE
        kEz05Iu01cewQKLbElBBApsP5KrgP6ua6s8T2La9y8HIJwFVqDf8+1XrlfGblb5O1WMqQ0
        cXlj+Np8DAKdyK/TlSKB9nDIGo7FzNQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-g8Q2D060N86JrPeQbhYMIw-1; Wed, 18 May 2022 10:19:18 -0400
X-MC-Unique: g8Q2D060N86JrPeQbhYMIw-1
Received: by mail-qk1-f199.google.com with SMTP id d67-20020a379b46000000b006a00045c8c9so1628619qke.22
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 07:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=VfckOg9nc/G1Pfdg8hFEzkjneT+SXrT9/xnBgJMJNjw=;
        b=BV/c3UefuJkJ2ejoOwlJnF0LGRYYhe1p14oGjAKuUHsAfi/4aDpbek6gwu+FKmPqtX
         sU08bgKOPUIdJ75b9YmPJQ/npCY+6nuZW7/+f4s7t4INpGflCcjcAn5jb1mNjKA6X3aj
         urm6AiZVP/leGHhsWwNw6LB+1hygfrqm6qfNg4j7knELqucPWayGH/uEzk7xhO+/Io54
         rRZ4eEz0OLsdzIEA/o8BXuJSZkNwVM2eWSWpA2iVtFl9kzqvtlPDdduuukdNd1kd5GWr
         UX42h7vkJsbxfKFQof48nzRUNjRz8lpY7Ufpkrm4fsg88tptQqblkO/SpCRHleSFwExr
         r1dQ==
X-Gm-Message-State: AOAM5323w6Opcv+kcO1IK/ZETEuG3EHXTZnODsmXZ8AyDLLqA8cB2c/x
        2fMbvqL4wD3LC8RQgHNAjq/lNzTZ7KSE0+2mPPUkURjTGdtgm/1SElMqWrdjjd0Q2ee3+WSjvDK
        H5AjuDiG06D986Yls9g==
X-Received: by 2002:a05:620a:400f:b0:6a0:5a16:69f3 with SMTP id h15-20020a05620a400f00b006a05a1669f3mr20337008qko.103.1652883557916;
        Wed, 18 May 2022 07:19:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylKGmaR4h+fKRUx8ZDF0bpMUiS7wkjGXnxRlpZU9EGGNOWc9WDXcuIvIad24ACm2E8HEwu0A==
X-Received: by 2002:a05:620a:400f:b0:6a0:5a16:69f3 with SMTP id h15-20020a05620a400f00b006a05a1669f3mr20336985qko.103.1652883557661;
        Wed, 18 May 2022 07:19:17 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s62-20020a372c41000000b0069fc13ce1e9sm1560424qkh.26.2022.05.18.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 07:19:17 -0700 (PDT)
Date:   Wed, 18 May 2022 22:19:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH 0/2] update test_dummy_encryption testing in
 ext4/053
Message-ID: <20220518141911.zg73znk2o2krxxwk@zlang-mailbox>
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>,
        fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20220501051928.540278-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501051928.540278-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 30, 2022 at 10:19:26PM -0700, Eric Biggers wrote:
> This series updates the testing of the test_dummy_encryption mount
> option in ext4/053.
> 
> The first patch will be needed for the test to pass if the kernel patch
> "ext4: only allow test_dummy_encryption when supported"
> (https://lore.kernel.org/r/20220501050857.538984-2-ebiggers@kernel.org)
> is applied.
> 
> The second patch starts testing a case that previously wasn't tested.
> It reproduces a bug that was introduced in the v5.17 kernel and will
> be fixed by the kernel patch
> "ext4: fix up test_dummy_encryption handling for new mount API"
> (https://lore.kernel.org/r/20220501050857.538984-6-ebiggers@kernel.org).
> 
> This applies on top of my recent patch
> "ext4/053: fix the rejected mount option testing"
> (https://lore.kernel.org/r/20220430192130.131842-1-ebiggers@kernel.org).

Hi Eric,

Your "ext4/053: fix the rejected mount option testing" has been merged. As the
two kernel patches haven't been merged by upstream linux, I'd like to merge
this patchset after the kernel patches be merged. (feel free to ping me, if
I forget this:)

And I saw some discussion under this patchset, and no any RVB, so I'm wondering
if you are still working/changing on it?

Thanks,
Zorro

> 
> Eric Biggers (2):
>   ext4/053: update the test_dummy_encryption tests
>   ext4/053: test changing test_dummy_encryption on remount
> 
>  tests/ext4/053 | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> -- 
> 2.36.0
> 

