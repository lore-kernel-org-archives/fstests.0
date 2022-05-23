Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279B6C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 23 May 2022 08:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiEWIaf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 May 2022 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiEWIae (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 May 2022 04:30:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFC6378
        for <fstests@vger.kernel.org>; Mon, 23 May 2022 01:30:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u3so12058368qta.8
        for <fstests@vger.kernel.org>; Mon, 23 May 2022 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfqXbgBPQZOYY9xVEbQyJ4GLjiHP4e/eTASAXq10efE=;
        b=aw0niF39P5Q3V17IJv/bk4CIaV+/Q8s15d098ZNjh4FdpuLXnfwExzmasv2N3sWF+X
         17TmiJ/4kBq/ewM0iYrOOuIP4RtQSoueeeCpvMC+5gdLsdi3nfSjux9DU8skG4xlHVen
         oby4VQRMciwe8EV329WI29bk+7BEuA+abJ3qX+9RrzlV6PO918VLdwp0sN7ADO4EbXmM
         +Sqk/DHEAzDgj9YaRLQB//XOdBLrTzpMyromj+reY7R1I+61O9mIRj7UbJcRXHXbk5AB
         QcPfde74OPD5cOq/x3lkavqXGRBcporY0Jt5MJ37U+zN5gPVyjiUcE51/b66A5EKpL7z
         5eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfqXbgBPQZOYY9xVEbQyJ4GLjiHP4e/eTASAXq10efE=;
        b=zyQ/aF0xZc7NnuanJS0V7fggJBBI/xdmpWq5Pcf8FZ4JTmszIKaMCFMD2JR9FkRm4p
         MVkUm7mynBQqwOa7IS9Nj331/kYQ0Fo3WuoX/X7bjjOqTq40AqQXD/71qsZKS/hcbp8H
         2pJQaQli8E5qHl9KVpngbWLePbRWPghM8lpOCxtYWOvvgWC7PB45z9UEQDy+CDP30/98
         Ytt2S8RndRLPLFwuWeEIgenl+whrbeVkXstTuOJCCtoBsiI9XH5HvVwodfXIj4QTK2w7
         Np+rr1YTtBlZX9+qRIFk4w7Lbn3sq4KTp4te+7gpDDnJ7ZtaKtLDAMNmOdmtOT6DbBWr
         /EaA==
X-Gm-Message-State: AOAM531wfDTJWkUYPuXSvr3ohG/gpydYv3bPtg6OnZCew4xzhpicVrVi
        dJG9BUMxLAAMzb8rct0ngzgExdIQpArbWMUrLDY=
X-Google-Smtp-Source: ABdhPJxqYhEs9ZhEwshPQbdt6r4bj5g/zaVGnBWaHb7qEKmfK03uyBUNWBuMmFjlpKF8rI5mUOKuGlIwjKbebwObQaM=
X-Received: by 2002:ac8:5f0a:0:b0:2f9:3b64:b5ba with SMTP id
 x10-20020ac85f0a000000b002f93b64b5bamr532790qta.2.1653294632189; Mon, 23 May
 2022 01:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220520143249.2103631-1-amir73il@gmail.com> <20220522141023.diwajhcswq53wgt5@zlang-mailbox>
In-Reply-To: <20220522141023.diwajhcswq53wgt5@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 23 May 2022 11:30:20 +0300
Message-ID: <CAOQ4uxgg--fHonEH7=cFoacfMjd5BdOYAedxoWbm1VfL6H-+Qw@mail.gmail.com>
Subject: Re: [PATCH] xfs: annotate fix commits for upcoming 5.10.y backports
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 22, 2022 at 5:10 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Fri, May 20, 2022 at 05:32:49PM +0300, Amir Goldstein wrote:
> > In preparation for backporting xfs fixes to stable kernel 5.10.y,
> > annotate some of the tests that pass after applying the backports.
> >
> > Most of the annotated tests have the fix commit documented either
> > in comment or in commit message already.
> >
> > All tests have been verified to pass with fix commits apply, but
> > for a few tests, a failure was observed when running on kernel without
> > the documented fix commit. That is probably because failure happens
> > only on a specific setup.
> >
> > Generic tests have also been annotated with xfs fix commits.
> > That may produce wrong hints if the test fails on another fs, but
> > that is what hints are for - to give tester a hint, so if tester is
> > not testing xfs, it's easy to figure out that the hint is irrelevant.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Hi Zorro,
> >
> > Here are a bunch of fixed_by annotations for xfs bug fixes,
> > which I am in the process of testing for stable kernel v5.10.y [1].
>
> I just confirmed that these commit IDs are right, and these cases are
> specific reproducer for them. So I'd like to ack this patch.
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>
> >
> > There are a lot more tests with fix commits documented in comments
> > and/or commit message, but I did not annotate any test that I did not
> > verify myself to pass with the fix commit.
>
> Thanks for you did that such carefully. You remind me that I just release
> a new fstests version v2022.05.22, which has several known failures too.
> https://lore.kernel.org/fstests/20220522094622.25751C385AA@smtp.kernel.org/T/#u
>
> I'm thinking about another question, if a case covers more and more known
> issue, the known list will be very long, even might take 1/3 of the code
> lines. That will look not graceful ...
>
> We'd better to not make an existed case grow biger and biger. And don't
> record known issues in a case which just can reproduce it with small chance

No of course not, that would not be productive.
fixed_by_commit should be reserved to "proper" regression tests
failing before fix, passing after fix

There could still be several fixed_by commits for different fs
and for different regressions that were detected on different
kernel versions.

> randomly. Likes you record e4826691cc7e ("xfs: restore shutdown check in mapped
> write fault path") into g/623, actually we found it by g/019 at first, then
> write g/623 to cover that. So g/019 isn't the recommended case to record this
> issue.
>

Exactly. Good example.

Thanks,
Amir.
