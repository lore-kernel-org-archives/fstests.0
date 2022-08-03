Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A8C19F2D
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 22:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiHCWmo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiHCWmn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 18:42:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A417A9E
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 15:42:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x25so25070ljm.5
        for <fstests@vger.kernel.org>; Wed, 03 Aug 2022 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZTC8pqnrrWrVXkLaGQrW0Mi6fvjHzMsYZgeoNR5c7Xk=;
        b=ghCsBaGRN7NASruqI7lhfwUTZQUCbOzpvP8io/1rI0/bMsZmbloWcYtD7n7/IfiYPB
         BUbObP8qhUbzu49ghHR0xHoq3F9nd7GUDpzyqDashy2AIrpo2tYEiDITExdqgn5RyAKD
         NGcGKnicjt5zWuZs0tC3Ym5fAa28sR2pKCIYCKrPzRGF1hJxe82I0sxhO3wcXDLxsvMk
         gDRzpxXz99Kh+U2XQW4kEEAEnO1jWe1osi/USnt08aGB0tVlXpEM8EwEs4FKAfdPMN3O
         F4u0x9Q816EVOoMyC3vSU6fnPQkAjHSvKPBSeqzp+DbMZRxvy1Dtk0ezi8tuVnJbI2ly
         Qy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZTC8pqnrrWrVXkLaGQrW0Mi6fvjHzMsYZgeoNR5c7Xk=;
        b=gU29d5FE55+unuXrLaLSyEcWYrlYXZ0LlUarwVvKbNobwSFgCT9axs87RlLd9/BVuK
         RMvpuVXaYvzxLso5+zubVenoG61u+DSki0S1ar2U+loV4fnkNubxC0vjGTLJbWAKiwYW
         /tR6t1Kq+UNSE6XLHtLu/y37i/FKOTm8p7SQRrnDdY3jkQwSNU3vD7jL9rtGpAdNF9cI
         r2nDgZMqhk6k3+sWGnb7RYF9keECb0O8xiuFCtZawjxvJm7woWhfrvVJqTf1HsLJaPQG
         2Y8hFza2Ubhsfc/VAfKfQhhhg/lBZVb8mct2zwsB74qzvC1fdYk54JXgTfn+HMmgHGpL
         uNZg==
X-Gm-Message-State: AJIora96obG4YhfpiKkvfRXYrgH3A7F+nXpECy+WL+XX55Fhn8v7mIsE
        F2o7rG0AhXU6NG0hWokvSP3d1cFLH4a1q/+BA2g8AFp75DU=
X-Google-Smtp-Source: AGRyM1sS3D+36i3ULxDy7oZWSbBf1r5kMqPnKHsEckihriqkGQmKe5vFAmu6KuyMr4ohPwCQKTi2L0a6MEK3kCTGrxg=
X-Received: by 2002:a2e:9444:0:b0:25d:91c1:caa3 with SMTP id
 o4-20020a2e9444000000b0025d91c1caa3mr9029485ljh.190.1659566560588; Wed, 03
 Aug 2022 15:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220803224121.420705-1-nhuck@google.com>
In-Reply-To: <20220803224121.420705-1-nhuck@google.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 3 Aug 2022 15:42:29 -0700
Message-ID: <CAJkfWY7kJDqBzqnGD_X4vVKZc3tfnDShC=AbFOjyra+8o1shvw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] generic: test HCTR2 filename encryption
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 3, 2022 at 3:41 PM Nathan Huckleberry <nhuck@google.com> wrote:
>
> This patchset is not intended to be accepted yet.  It is reliant on HCTR2
> support in the kernel which has not yet been accepted.  See the HCTR2 patchset
> here: https://lore.kernel.org/all/20220520181501.2159644-1-nhuck@google.com/

Oops, I need to remove this.

>
> HCTR2 is a new wide-block encryption mode that can used for filename encryption
> in fscrypt.  This patchset adds a reference implementation of HCTR2 to the
> fscrypt testing utility and adds tests for filename encryption with HCTR2.
>
> More information on HCTR2 can be found here: "Length-preserving encryption with
> HCTR2": https://ia.cr/2021/1441
>
> Changes in v5:
> * Added links to relevant references for POLYVAL and HCTR2
> * Removed POLYVAL partial block handling
> * Referenced HCTR2 commit in test
>
> Changes in v4:
> * Add helper functions for HCTR2 hashing
> * Fix accumulator alignment bug
> * Small style fixes
>
> Changes in v3:
> * Consolidate tests into one file
>
> Changes in v2:
> * Use POLYVAL multiplication directly instead of using GHASH trick
> * Split reference implementation and tests into two patches
> * Remove v1 policy tests
> * Various small style fixes
>
> Nathan Huckleberry (2):
>   fscrypt-crypt-util: add HCTR2 implementation
>   generic: add tests for fscrypt policies with HCTR2
>
>  common/encrypt           |   2 +
>  src/fscrypt-crypt-util.c | 358 ++++++++++++++++++++++++++++++++-------
>  tests/generic/900        |  31 ++++
>  tests/generic/900.out    |  16 ++
>  4 files changed, 350 insertions(+), 57 deletions(-)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
>
> --
> 2.37.1.455.g008518b4e5-goog
>
