Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2913C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 04:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiFXEGB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 00:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiFXEGA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 00:06:00 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D629563A0
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 21:05:59 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id n203so675896vke.7
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 21:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXgl9Cfe1A1D3yOYrsUWrZ6jXV2Mxp66c2kpSivu54U=;
        b=RBh5DVMv9hABwJbFz/3hCRrLz+Kpd3Hwn7LRhceBQ5biQ5j9h+W8hpVIwvbMSv3eOd
         cCMM/c4EXrTKZIy0SCpi0Kc8rNM1NhH8BDk3fcMRpZVUOAyxj7dje1kdPEY2StXsaYN7
         cwBvow8LovZTYlv3pIZCBTvt4jPCwg2Oq1JIL/YDFYetq/C4gQOYiMt1CkLZ4gAwL1Eg
         3NTTdX/o8PrZvSCXOTr0BgRI/Kmg2Z7+LT6bzKj+Wmrixpg74BDGGW41mM8MvceAjPSZ
         D8yS2EaCkO9wnyyVTMnvppLRs6+29pjfDaE5JzqmGk0645686dz16bBq1XEhv0OVo21u
         QtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXgl9Cfe1A1D3yOYrsUWrZ6jXV2Mxp66c2kpSivu54U=;
        b=DnPgwgXH4HXDKyVXZitMGMJ0Yz9z9NLUjBvlyX4s544Js8GUDyx9n9QcQU1pnCaF4Y
         5LWxjKCbNyD1qjR2eFCYeh6dI/Tjf4VOXkVIBak1OaSncdBbqkLNwfxVk6v4RhwT+CD6
         8bWNRKDZKuBIsdoQk+pH7Z4rAvLrpqIOhgojamas3aGIE5kdsYP9KvXU/fuaWC7UyXYT
         6jPqfgfj3Nd7YQEMp69le+PAX7nRVw2PIQaL6A2gGY+gEjdBnSizxlN0lExTHWaUPdXw
         TuAqGRDBUJzhpcnaHGbOEYzVIamKj22mJJoXp5ypi7YmQlRVia0qCb7YqJ4BjdYRFSi7
         kCsw==
X-Gm-Message-State: AJIora+xpOzttq1ieDqY6FJmPlPodGOhU8dZroEBJcjl/skeWN3kC03u
        8nDajDnP1FwmiBB6fDy76SnFYEQ6dXW6xKc2ivs=
X-Google-Smtp-Source: AGRyM1ucc25bu51p01gUq8MOLuQRNR0AG0TqCvohNH/jKBd9eUDacr+qoaUanwquCnPA2shzm4L0kLfBwKasPXCeTsI=
X-Received: by 2002:a1f:eec2:0:b0:36c:1c9b:465f with SMTP id
 m185-20020a1feec2000000b0036c1c9b465fmr12368807vkh.3.1656043558564; Thu, 23
 Jun 2022 21:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-2-amir73il@gmail.com>
 <YrSqMByKUgHQllwN@magnolia>
In-Reply-To: <YrSqMByKUgHQllwN@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Jun 2022 07:05:46 +0300
Message-ID: <CAOQ4uxim+bk6QGfWarp06mLg0Eikv2cvQR4-TEPLxSR2hgtprQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fstests: add missing _require_freeze() to tests
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 23, 2022 at 9:00 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Sun, Jun 19, 2022 at 04:46:54PM +0300, Amir Goldstein wrote:
> > And add a few tests that use freeze to the freeze group
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  tests/xfs/119 | 1 +
> >  tests/xfs/318 | 3 ++-
> >  tests/xfs/325 | 3 ++-
> >  tests/xfs/422 | 3 ++-
> >  tests/xfs/438 | 2 +-
> >  tests/xfs/517 | 1 +
> >  6 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/xfs/119 b/tests/xfs/119
> > index a1180371..b6f96601 100755
> > --- a/tests/xfs/119
> > +++ b/tests/xfs/119
> > @@ -20,6 +20,7 @@ _begin_fstest log v2log auto freeze
> >  _supported_fs xfs
> >
> >  _require_scratch
> > +_require_freeze
> >
> >  # this may hang
> >  sync
> > diff --git a/tests/xfs/318 b/tests/xfs/318
> > index 38c7aa60..be93f9ab 100755
> > --- a/tests/xfs/318
> > +++ b/tests/xfs/318
> > @@ -7,7 +7,7 @@
> >  # Simulate free extent errors with a file write and a file remove.
> >  #
> >  . ./common/preamble
> > -_begin_fstest auto quick rw
> > +_begin_fstest auto quick rw freeze
>
> Not sure why these tests (318, 325, 422, 438) are being added to the
> freeze group -- they use freeze to force xfs to do background tasks
> (inodegc, initializing quota, etc), but they are not themselves
> functionality testing for filesystem freezing.

True. I was hesitant about that part myself.
But think about it this way -

One of the reasons is that when developers change
some code in the vicinity of freeze they want to run a fast
smoke test with tests the exercise freeze.
In this perspective, it seems useful that the freeze smoke test
will also exercise freeze when used as a trigger for internal
xfs tasks.

That was my thinking, but I have no strong feelings
either way, so if others don't like it, I can drop this part.

>
> The _require_freeze additions look fine though.
>

Thanks,
Amir.
