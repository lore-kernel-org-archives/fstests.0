Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D891C4361B
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Mar 2021 00:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B40764F2B
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Mar 2021 00:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhCCABV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Mar 2021 19:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576201AbhCBE0C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Mar 2021 23:26:02 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F292C061756
        for <fstests@vger.kernel.org>; Mon,  1 Mar 2021 20:25:20 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z65so7596207vsz.12
        for <fstests@vger.kernel.org>; Mon, 01 Mar 2021 20:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dp0eBqjEJuPKMLoSTgyUXOudQS9ZGSctDwCm4Wz1HQg=;
        b=eyz1FsCpC3gu5znxvHRiuRALw5ulEeD/6q68F+KVYJft0qudBACiu5g4YqxZWjNCnR
         hHfuDUI6v8NHrtTc2SjNwikCKIHETDpMaCyagwEToCobAFXVYLpU0OnGJc71tP38AmGJ
         A7RF8/KrYCwLHMfKVCds9AGIpFM8S7Ms9NybVzcyDoTfUFR29hRJReynbma9Xa0Uh3yX
         ECJyXYHcZMTJeUD/+kSG9zLcdl51Wqi9506mFGXxAkl0VtvO2ZCNXRQShKsT2M+2LWyy
         e1CvVDLGgVCZI6i19MPJSOGVw2DfI3dNPrWv7XO2qWFCxVsw+hLiKepKlbCihgO9rn3F
         TEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dp0eBqjEJuPKMLoSTgyUXOudQS9ZGSctDwCm4Wz1HQg=;
        b=JUxtAMn0DeVlx1loT1MO+teS09t+c4lZgqZbx5uVxB+BNIHn3mCdrtd5LwetEucuo0
         hLTmaXD/n7QbkLpib7MPUYwN4hti1nQKNos8i9qznjAR4LlddqiXr7lGsSSWfSR8t0LW
         OnRD875A6rJkPm4bIm2eC4dIJtPVSbFGVCXy1eKZiJpdDRZ74zFuilnysCx0qi31vQgo
         V5tbI0xEgd/aHkLp6ePXiXWtGTHVzWTxSWedHT/9G3pDm1mqvM6mqSZiznS1BVj6jZoP
         sKb3KumbeRB620NFYqUtM7WLNLUaJdYPHc8lLAtimmp0D8nH6nRkjcAsE9FHGHKrs4Ko
         fPFg==
X-Gm-Message-State: AOAM532snqPx+c0SjbYQxrE8r+zTHY9fFrFnRByf5eDn7j9esy3bWY50
        B5K9DLJbzQWxRIQwYQOesGFAnRmpo01elotyJG0=
X-Google-Smtp-Source: ABdhPJz3/yxRjEQDB9+CZQGKu4WdGmtQEVP6dGYIBffufuNaanW7ykNHglVbcH50sek//1aREoIwOvQiLrxJ0QJwJfw=
X-Received: by 2002:a67:a20c:: with SMTP id l12mr1130651vse.57.1614659119039;
 Mon, 01 Mar 2021 20:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20210210205818.1494305-1-tytso@mit.edu> <20210301171440.GD7269@magnolia>
 <YD0ssnT0BCnwPXXk@mit.edu> <CABnRu57hdKav3Mi8vQYeowZrQtFToMSzK23h4H2DuqGL0Dea2A@mail.gmail.com>
 <20210302033329.GG7269@magnolia>
In-Reply-To: <20210302033329.GG7269@magnolia>
From:   Su Yue <damenly.su@gmail.com>
Date:   Tue, 2 Mar 2021 12:25:31 +0800
Message-ID: <CABnRu54M+pP_eYWXYHHkz22RvzwvrUZah-TtbY_9+sQUyKVWAA@mail.gmail.com>
Subject: Re: [PATCH] generic: test which tries to exercise AIO/DIO into
 unwritten space
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 2, 2021 at 11:33 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Mar 02, 2021 at 11:20:06AM +0800, Su Yue wrote:
> > On Tue, Mar 2, 2021 at 2:10 AM Theodore Ts'o <tytso@mit.edu> wrote:
> > >
> > > On Mon, Mar 01, 2021 at 09:14:40AM -0800, Darrick J. Wong wrote:
> > > > On Wed, Feb 10, 2021 at 03:58:18PM -0500, Theodore Ts'o wrote:
> > > > > This test verifies that the an unwritten extent is properly marked as
> > > > > written after writing into it.
> > > > >
> > > > > There was a hard-to-hit bug which would occasionally trigger with ext4
> > > > > for which this test was a reproducer.  This has been fixed after
> > > > > moving ext4 to use iomap for Direct I/O's, although as of this
> > > > > writing, there are still some occasional failures on ext4 when block
> > > > > size < page size.
> > > >
> > > > Are there still failures?
> > >
> > > Yes.  It's on Ritesh's todo list, but I don't believe it's bubbled up
> > > to the top of his list.
> > >
> > > The failure rate is substantially less than what I had been seeing
> > > with 4k block sizes before the move to iomap, and in practice it was
> > > hard to hit in production.  We noticed on Google data center workloads
> > > (but even then it was impossible to reliably repro before I found this
> > > fio recipe); as far as I know no one else had reported seeing this
> > > problem.
> > >
> > > So in summary, as of this writing, on 1k and 2k block sizes, this test
> > > is still occasionally failing for ext4 (but not xfs, where it reliably
> > > passes).  On 4k block sizes on x86 with ext4, this test is still
> > > failing in on 5.4 and earler kernels, unless someone has managed to
> > > backport DIO iomap support for ext4 into an enterprise linux kernel.
> > >
> > But both xfs and ext4 100% fail in v5.12-rc1 with 4k block size and 4k page
> > size on x86_64. The test itself should be okay because btrfs passes.
> > xfstests-dev version is 8cbc48b460b6 applied this patch. logs are attached.
>
> Is this generic/623?  That test is new, and I've noticed it'll fail if
> you have coredumps enabled because the test tries to induce a SIGBUS.
>
Hmm.. I think the "generic/623" you mean is introduced by 011bfb01f7f9
("generic: test
mapped write after shutdown and failed writeback"). The generic/623 which
I mean is the commit 8cbc48b460b6(011bfb01f7f9~1) applied Theodore's
patch "generic: test which tries to exercise AIO/DIO into unwritten space".

--
Su
> --D
>
> >
> > # fio --version
> > fio-3.25
> >
> > #cat local.config
> > export TEST_DEV=/dev/mapper/test-1
> > export TEST_DIR=/mnt/test
> > export SCRATCH_DEV_POOL="/dev/mapper/test-[2-6]"
> > export SCRATCH_MNT=/mnt/scratch
> > export LOGWRITES_DEV="/dev/mapper/test-7"
> > export KEEP_DMESG=yes
> >
> > >                                         - Ted
>
>
>
>
