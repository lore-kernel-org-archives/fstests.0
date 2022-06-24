Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E86C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 06:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiFXG21 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 02:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiFXG2S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 02:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63D9B25ED
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 23:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656052088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+3EZR5DwDQyZa0CyaG2meMOvLYdP72gToXa1FiIx3A=;
        b=LG/+9qE89MTV4d2rLWXx4Y4C6SSr5oRrhsHo0DY2lvzbcef/NCcwShYmJDOpkD8pKweZtj
        0Ct81RcSrNPkKlUCn12iKVV/GOe+hx7ID/4hD3+REcwaIRxrlnjzPNlIiBEtGjRv3mUUQK
        98sQr1FwmZ89GTi37aTXGWWmhFGNYo8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-q7q2sipaPTOna2-FGFA4IQ-1; Fri, 24 Jun 2022 02:28:04 -0400
X-MC-Unique: q7q2sipaPTOna2-FGFA4IQ-1
Received: by mail-qv1-f71.google.com with SMTP id m12-20020a0cac4c000000b00470450cd18dso1709963qvb.8
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 23:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+3EZR5DwDQyZa0CyaG2meMOvLYdP72gToXa1FiIx3A=;
        b=dAil/HDHA8mbPYyBt5ywaV/wqKwsmlQqTfZJjgAkpeQbLaNUha1y3HPg0CfK4YKgXw
         9D9CsI7p6Jx6pf36STJ3CZgb3SzL/LJNBwzySnEbq+7504+qs5U+y6dM632pPe6Rj60D
         TCz/gXHyoz/a/2O+pu1gzV1e2eMAgPl0dGvBAN87CP/5VzKU4d2Yz3VJd35MOkGgNZh0
         hPuJEebgLv9Km3Ah+w1VOE1Mu7AZ0PnMjrOzZY27HpIKPb5cAJ64S8gf0AfgOYb9EFP+
         8N+XtlHR+UQGP17RbJ/UdhcHHkM6vt5bqA4lL+KVlvgDRihFXFASaWqJoYSxillxjVtZ
         m6IQ==
X-Gm-Message-State: AJIora9Fjf1P9yHEC4+A1+/hMlMakq+h5MlonvTl35x60WD6OUD9flws
        w0D/onnuLvoi1kqoJNcqoYJhCIG9iwWHVXXEt0dmrQpFHVUSkLA1US6ZknsJqDHmuOqkodke4dW
        bal4m2KqgWOuqJhYS+A==
X-Received: by 2002:a05:6214:29ec:b0:470:5aec:e15e with SMTP id jv12-20020a05621429ec00b004705aece15emr13088563qvb.102.1656052084111;
        Thu, 23 Jun 2022 23:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sH7qB2YXkIzp/4sla0ZNBNi5h6rvbCgWNTXcSVMVf0XzG8MCxUrsFWrzB5NaGlGrUJgyFOBA==
X-Received: by 2002:a05:6214:29ec:b0:470:5aec:e15e with SMTP id jv12-20020a05621429ec00b004705aece15emr13088557qvb.102.1656052083874;
        Thu, 23 Jun 2022 23:28:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br27-20020a05622a1e1b00b00316fe2eb231sm799806qtb.58.2022.06.23.23.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:28:03 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:27:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 1/4] fstests: add missing _require_freeze() to tests
Message-ID: <20220624062757.sqqixpgdyblbunqm@zlang-mailbox>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-2-amir73il@gmail.com>
 <YrSqMByKUgHQllwN@magnolia>
 <CAOQ4uxim+bk6QGfWarp06mLg0Eikv2cvQR4-TEPLxSR2hgtprQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxim+bk6QGfWarp06mLg0Eikv2cvQR4-TEPLxSR2hgtprQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 07:05:46AM +0300, Amir Goldstein wrote:
> On Thu, Jun 23, 2022 at 9:00 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Sun, Jun 19, 2022 at 04:46:54PM +0300, Amir Goldstein wrote:
> > > And add a few tests that use freeze to the freeze group
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  tests/xfs/119 | 1 +
> > >  tests/xfs/318 | 3 ++-
> > >  tests/xfs/325 | 3 ++-
> > >  tests/xfs/422 | 3 ++-
> > >  tests/xfs/438 | 2 +-
> > >  tests/xfs/517 | 1 +
> > >  6 files changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tests/xfs/119 b/tests/xfs/119
> > > index a1180371..b6f96601 100755
> > > --- a/tests/xfs/119
> > > +++ b/tests/xfs/119
> > > @@ -20,6 +20,7 @@ _begin_fstest log v2log auto freeze
> > >  _supported_fs xfs
> > >
> > >  _require_scratch
> > > +_require_freeze
> > >
> > >  # this may hang
> > >  sync
> > > diff --git a/tests/xfs/318 b/tests/xfs/318
> > > index 38c7aa60..be93f9ab 100755
> > > --- a/tests/xfs/318
> > > +++ b/tests/xfs/318
> > > @@ -7,7 +7,7 @@
> > >  # Simulate free extent errors with a file write and a file remove.
> > >  #
> > >  . ./common/preamble
> > > -_begin_fstest auto quick rw
> > > +_begin_fstest auto quick rw freeze
> >
> > Not sure why these tests (318, 325, 422, 438) are being added to the
> > freeze group -- they use freeze to force xfs to do background tasks
> > (inodegc, initializing quota, etc), but they are not themselves
> > functionality testing for filesystem freezing.
> 
> True. I was hesitant about that part myself.
> But think about it this way -
> 
> One of the reasons is that when developers change
> some code in the vicinity of freeze they want to run a fast
> smoke test with tests the exercise freeze.
> In this perspective, it seems useful that the freeze smoke test
> will also exercise freeze when used as a trigger for internal
> xfs tasks.
> 
> That was my thinking, but I have no strong feelings
> either way, so if others don't like it, I can drop this part.

I'm good to with/without (318, 325, 422, 438) in freeze group. If this change
doesn't bring in troubles to Darrick and others, I think you can keep current
version.

Thanks,
Zorro

> 
> >
> > The _require_freeze additions look fine though.
> >
> 
> Thanks,
> Amir.
> 

