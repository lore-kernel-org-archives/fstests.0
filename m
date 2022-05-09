Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C7DC3527B
	for <linux-fstests@archiver.kernel.org>; Mon,  9 May 2022 03:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiEIDxV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 May 2022 23:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiEIDnK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 May 2022 23:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBBDAAC939
        for <fstests@vger.kernel.org>; Sun,  8 May 2022 20:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652067548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=384Wr8HpP/E+deBQjPRBhidqUv4na3aygGhwegGh2ZU=;
        b=Rfcn17Yk6NI15PRWyLOjYEsSWXd1Lbh9+mjTCllqmomXlUkoTOo6+Lg3gW6KoMuNniD1Qy
        K/qjfLE2B7WqWpR9FjhACbdOvUyG22joB6aHqTh02/JZCbmU/gBSu/6PqTZYL8puDok6nk
        g1nC0Ln5Hc59eKgwEeK6qmxlKR7OD3I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-TnqD8etdNP-vzP3_DYgigQ-1; Sun, 08 May 2022 23:39:07 -0400
X-MC-Unique: TnqD8etdNP-vzP3_DYgigQ-1
Received: by mail-qk1-f199.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so7962205qkb.23
        for <fstests@vger.kernel.org>; Sun, 08 May 2022 20:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=384Wr8HpP/E+deBQjPRBhidqUv4na3aygGhwegGh2ZU=;
        b=KsWxhhJufkRrcfn740a/5Mtt2pSvZGgCiR5Rw8gPLhFOh6e8FLyvaZ13TBEqimhyp9
         cTpB/8KlcSsWqOyilKSewQbPhbyTE+GAjejAxQ3ERzGveNu2q82G+4GSqAjZx3bEJnCd
         4qCadj9puUnCCyuMJm6ZgcMPuLqixs2Sb34/tV5dxK1l+XeqpIKeY8x5XLuMmFH7wnhO
         X/46GPCbNO5qdvSPQnmhhZ67ETTNNQgRt5MdyCRuXTo3h95Pn7sd6BAKah8v451+WJrH
         MgrUqbFtVzNVolNJsPc7baFa/pwoykn6OGFC7a3zhuugPXEB80Ng8cnZnVvQ208I0RCD
         RUGg==
X-Gm-Message-State: AOAM53089R5D0A+5kYr4Bi80yIP/VOAI2a94pvgS6S7rCAG9WByDfFyJ
        BXncIQq9CRF/ErkK39HiluTWjoAvyNyxUvWANUJwupLyg50aTbbFO2PED1Opq33mv5bgg2RUgsi
        le4QMcNnbXiwHS7/O3w==
X-Received: by 2002:a05:6214:4103:b0:440:e4d1:a2a0 with SMTP id kc3-20020a056214410300b00440e4d1a2a0mr12030298qvb.42.1652067546598;
        Sun, 08 May 2022 20:39:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7vVXbgrXjgXzlgfNoHbGSK0tKI7G7S3ieCQQCJzV1wQoT1RN6bQ9kDl9PtRc4KylVYW1QJg==
X-Received: by 2002:a05:6214:4103:b0:440:e4d1:a2a0 with SMTP id kc3-20020a056214410300b00440e4d1a2a0mr12030290qvb.42.1652067546392;
        Sun, 08 May 2022 20:39:06 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 18-20020a05620a06d200b0069fc13ce213sm6212806qky.68.2022.05.08.20.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 20:39:05 -0700 (PDT)
Date:   Mon, 9 May 2022 11:39:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to 87cf32ad3fa2
Message-ID: <20220509033900.3gqaxzvhjezlqbqc@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org
References: <20220508160128.DA475C385A4@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508160128.DA475C385A4@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 09, 2022 at 12:01:25AM +0800, Zorro Lang wrote:
> Hi all,
> 
> The for-next branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> has just been updated and tagged as v2022.05.08 release.
> 
> In this release, Amir's patches provide "black list" support in _supported_fs,
> and two helpers _fixed_in_version() and _fixed_by_kernel_commit() to print hints
> for reasons of test failures. Feel free to use these helpers on new cases, or
> improve old cases.
> 
> *A Kindly Reminder*
> Next week(2022.05.09 ~ 05.15) we plan to merge a big idmapped-mounts related
> code refactoring, details refer to:
> 
> https://lore.kernel.org/fstests/20220507122649.dp7iopuu7rllli7k@zlang-mailbox/
> https://lore.kernel.org/fstests/20220507154346.oxfwcq547p325ti3@wittgenstein/T/#mf1bdf41d4a99bb4d1b90dfee2d30ac872c6074f2
> 
> so if you're going to write patches to change src/idmapped-mounts, better to
> wait one more week, to avoid terrible rebasing later.

Hi Christian,

I've sent this notification, hope to get your patchset soon :) Before offical
release, I can provide a topic branch (maybe idmapped-mounts-refactoring) for
your changes temporarily, as others might want to give it a test or write
patches base on your changes but don't want to wait so long time.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> The new head of the for-next branch is commit:
> 
> 87cf32ad3fa2 idmapped-mounts: Add open with O_TMPFILE operation in setgid test
> 
> New commits:
> 
> Amir Goldstein (2):
> [U]      [6ee5ffa079b9] common: support black listing fs in _supported_fs()
> [U]      [28c52b15c6e2] common: print hints for reasons of test failures
> 
> Chandan Babu R (1):
> [D]      [9ae10c882550] xfs/533: Delete test since directory's extent count can never overflow
> 
> Dave Chinner (1):
> [U]      [441606d28681] fstests: faster group file creation
> 
> Yang Xu (3):
> [U]      [6ac390bb605b] idmapped-mounts: Reset errno to zero before run_test
> [U]      [5328ab947ff4] idmapped-mounts: Add mknodat operation in setgid test
> [U]      [87cf32ad3fa2] idmapped-mounts: Add open with O_TMPFILE operation in setgid test
> 
> 
> Code Diffstat:
> 
>  check                                 |  10 +-
>  common/preamble                       |  30 +--
>  common/rc                             |  57 +++++-
>  src/idmapped-mounts/idmapped-mounts.c | 369 +++++++++++++++++++++++++++++++++-
>  tests/generic/500                     |   3 +-
>  tests/generic/631                     |   3 +-
>  tests/generic/679                     |   3 +-
>  tests/overlay/009                     |   3 +
>  tests/overlay/010                     |   3 +
>  tests/overlay/014                     |   2 +
>  tests/overlay/016                     |   4 +-
>  tests/overlay/017                     |   4 +-
>  tests/overlay/018                     |   4 +-
>  tests/overlay/020                     |   3 +
>  tests/overlay/022                     |   2 +
>  tests/overlay/029                     |   2 +
>  tests/overlay/038                     |   2 +
>  tests/overlay/041                     |   2 +
>  tests/overlay/042                     |   3 +
>  tests/overlay/043                     |   4 +-
>  tests/overlay/044                     |   4 +-
>  tests/overlay/054                     |   3 +
>  tests/overlay/055                     |   3 +
>  tests/overlay/063                     |   3 +
>  tests/overlay/065                     |   4 +
>  tests/overlay/067                     |   3 +
>  tests/overlay/070                     |   4 +-
>  tests/overlay/071                     |   4 +-
>  tests/overlay/072                     |   2 +
>  tests/overlay/074                     |   5 +
>  tests/overlay/077                     |   5 +
>  tests/overlay/078                     |   1 +
>  tests/xfs/533                         | 170 ----------------
>  tests/xfs/533.out                     |  17 --
>  tools/mkgroupfile                     |  66 ++++--
>  35 files changed, 541 insertions(+), 266 deletions(-)
> --
> Zorro Lang
> zlang@kernel.org


