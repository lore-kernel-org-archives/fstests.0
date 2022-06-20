Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF0C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 15:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbiFTPSM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbiFTPRy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 11:17:54 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998BF1BE8E
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 08:08:59 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id o21so4001860uat.6
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dlznnp2QGDWIzOb5/jWxkKEm4XtkUsYP36isVGUd2A=;
        b=hMux7j1JejaiZwM2pS6CjuMMK04MjgNoipcJOLPosFr5s3mieSDGHYIW+X04E8VVPI
         WL2Fx+OukeDHXJQGzZDhI71YNVGW6IDQQiQ9lIHGIl/nN7MZqJbBhdXwXdJ1xZLF0l6H
         0VsJFlpbO/lGk4LsKmgF1g+BdGm/WkvqaISvUS8dg6UJJdVvL3BomkFBKDx2cn5NhDJC
         y+YXnYEOSWDHiFRhP/7WHsKBZrJfbOIdarOptlB+NJh4YMHwFGo3nXB51kkp8s9f90si
         qxrqCbeYWruhgCOswK6tTweW55qMRxSrY12zIMxidXTprA3XBKSDxlsBD8GpXvtHHQjf
         8Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dlznnp2QGDWIzOb5/jWxkKEm4XtkUsYP36isVGUd2A=;
        b=LlPHDViG3y7I+PMkf4d/KF6wTTTxK0IIDhVw9C5epmQfmr9CcbSuuZXKetU6bLNnF5
         uVbFiMXoSDwTxaSVqI/F3FIL2+WdynGxr5IlTA/YfoPkXkIXz22wuwSbWiL4Oc4D064m
         GVNxxwHwl0V3/1bjnUqpAHwBCWFCvkbhQNP3ESIaKshFj7WBYa9EplA+xru3sJ1rZJJl
         1Fk0OPF1qHok0n2UkNMbT1ixScKJGAcUnLlnHQsX6KsaISa9jgQ+q2Tmomy4hCWkWhV0
         woZpHfA6k4uTmxygTIJlYlFXIf8G+b+Z2ZCJTLcJJoznLF06228W3A12h2B6KfPL0nR+
         FPJg==
X-Gm-Message-State: AJIora8x1Og5jPeLDmrCxdnkYLLpZEdbi51vw25dSkswGyN5T3Zr25sK
        /ur50sC0Uu2o1ZQn7a7b8Qn/6+YLcCwGWDAsiHY=
X-Google-Smtp-Source: AGRyM1uckqJgw2VKWKVSNnCNJ/9JUOVH1m5E/rfNApSjsnKiRZjs/RteX/cKikWxk3gxaNCvNdHsUE5hX5MM3p49IkY=
X-Received: by 2002:ab0:4973:0:b0:37f:27c2:59fb with SMTP id
 a48-20020ab04973000000b0037f27c259fbmr454538uad.80.1655737738730; Mon, 20 Jun
 2022 08:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-3-amir73il@gmail.com>
 <20220620111705.zmujyr3v2f5uw326@zlang-mailbox> <CAOQ4uxjcMiT_-0mRWz3+v2pRx+sXdG0a51E=Tt1etgOrZJXrRA@mail.gmail.com>
 <20220620142139.zukdj3nk4lntwtpx@zlang-mailbox>
In-Reply-To: <20220620142139.zukdj3nk4lntwtpx@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 Jun 2022 18:08:47 +0300
Message-ID: <CAOQ4uxj39eZ_jp1vYbmwHU7hbsdxjO_Q7MP5dpw8UAmvLsKYEA@mail.gmail.com>
Subject: Re: [PATCH 2/4] fstests: make sure to unfreeze test and scratch mounts
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 5:21 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Jun 20, 2022 at 03:13:33PM +0300, Amir Goldstein wrote:
> > On Mon, Jun 20, 2022 at 2:17 PM Zorro Lang <zlang@redhat.com> wrote:
> > >
> > > On Sun, Jun 19, 2022 at 04:46:55PM +0300, Amir Goldstein wrote:
> > > > Almost all of the tests that _require_freeze() fail to unfreeze
> > > > scratch mount in case the test is interrupted while fs is frozen.
> > > >
> > > > Move the handling of unfreeze to generic check code.
> > > > For now, tests only freeze scratch fs, but to be more robust, unfreeze
> > > > both test and scratch fs following a call to _require_freeze().
> > > >
> > > > Tests could still hang if thier private _cleanup() routine tries
> > > > to modify the frozen fs or wait for a blocked process. Fix the
> > > > _cleanup() routine of xfs/011 to avoid that.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  check             | 14 ++++++++------
> > > >  common/rc         |  5 +++--
> > > >  tests/generic/390 |  2 --
> > > >  tests/xfs/011     |  2 --
> > > >  tests/xfs/517     |  1 -
> > > >  5 files changed, 11 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/check b/check
> > > > index de11b37e..d6ee71aa 100755
> > > > --- a/check
> > > > +++ b/check
> > > > @@ -527,17 +527,21 @@ _check_filesystems()
> > > >  {
> > > >       local ret=0
> > > >
> > > > +     # Make sure both test and scratch are unfrozen post _require_freeze()
> > > > +     if [ -f ${RESULT_DIR}/require_freeze ]; then
> > > > +             xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
> > > > +             xfs_freeze -u "$SCRATCH_MNT" >/dev/null 2>&1
> > > > +     fi
> > >
> > > Hi Amir,
> > >
> > > I'm wondering why not let each freeze related test cases take care of "unfreeze"
> > > by itself? If a case freeze a filesystem which isn't on TEST_DEV or SCRATCH_DEV
> > > (e.g. a loop device base on a file in $TEST_DIR), or other situations, then the
> > > case still can call _require_freeze, but "unfreeze TEST_DIR or SCRATCH_MNT" can't
> > > help.
> >
> > That's also an option, but:
> > 1. It is less robust, leaving room for human mistakes. Why is that better?
> > 2. Leftover frozen fs is quite harmful to subsequent test runs, so it
> > is important
> >     to avoid it
> > 3. Tests that freeze loop/dm (generic/459, xfs/428, [*]) can and should cleanup
> >     themselves. I will add that too, but in any case...
> > 4. unfreeze of tests and scratch fs is harmless even when it is not needed -
> >     we may even want to do that at the start of tests run(?)
>
> I think Dave doesn't like to add common steps to thousands of cases, if without
> a critical reason. So I hope to get more review points for this kind of changes.
>
> >
> > [*] I noticed that generic/085 which _require_freeze() does not even
> >     use xfs_freeze (intentionally) - it uses dmsetup suspend/resume,
> >     so I guess _require_freeze() should be removed from that test.
>
> Agree, I think dm suspend through different userspace and kernel interface with
> fsfreeze, so that require doesn't make sense.
>
> >
> > Anyway, if you and others insist against this auto-unfreeze approach,
> > I will post the patch to unfreeze fs in individual tests, but I won't be
> > happy about it.
>
> From the functional side, I think this change makes sense. But if think about
> the performance, let's get more opinions at first. If there's not objection,
> we can have it.
>

Maybe the change was not clear.

Only the tests that declare _require_freeze() in the beginning of the test
(14 tests) are going to be affected by this change.
The rest of the tests have no impact at all.

Thanks,
Amir.
