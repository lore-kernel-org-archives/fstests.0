Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6ADC43334
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 02:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbiFUCx5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 22:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbiFUCx4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 22:53:56 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568E19001
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:53:55 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id k5so2921685vkd.8
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5ELlethHLb0dG7zTemmLkKtN2SGohMNclygZsC24y4=;
        b=GheBz/0HcgKEBPQ6sHHOvulouhXXhcgrY9i59ezEiuM2AZP4S4BMl0fLbc5uT4/cNw
         aS3UTHG4g4CcF3H4gG22fKruKbFgkRQLO52NtigtmwucNZhgEQMXE9wcwRVjwouZ59Ik
         HBDttTpjYHQvjef8PVSrOWFsOLhA0mnTxZFB4yru9eyCmdXUCcMUWN9/7Lu3+KrT9zw/
         1hXainQ5GvCFnANfM3ozAQQfBmne5rGbbKLEsNcqId9SVMhBJgF7Hasi0DC5gNv1nvaB
         g4nY2kcBOfav+F7pZnsCZETxMl/ZliQSAmX9ZoUaJg0cAV+eCrE74uuOWcWaQ27R6XlG
         xMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5ELlethHLb0dG7zTemmLkKtN2SGohMNclygZsC24y4=;
        b=tBooNW35QhQWhD5aJOM7ACmYkV4pyQF21wtIJfDqFfJUnEr+H7qUC5SBTwBGbP+90l
         Dm5Ym3Z5E12H7gd08FYBktIzXaUXoTXDvzBh9ezv6QGL3eGRA9UPmTfbPnVIQJEU0hvC
         CoNGBKdI3f3nhxqLe9YcNuupCVI+3VykSOYcIy2tu9Dg7YCM/R7ce/6d5wxvBqfuOSBV
         IrdV0oNdl2BbyhsipSdAwWEU+q+Cbl/5ZV71tMimYNIaUCs2eof8OxUh2L91T9bpwLvg
         Ces/fLdyFmuE5KIN/laBJPY8LBJHWc8K+ZaEQzaD1ioWijPjQeFBidVwgYC4cTGeus8K
         LiJg==
X-Gm-Message-State: AJIora+ot1HPX70vvrWAZ72068Ubz2xNdMkYMGV5DXRKfvYJgUOjR7/g
        ifXzJwzxa2pcdU3eVsei/liTFLV5THruO6obDG8=
X-Google-Smtp-Source: AGRyM1s5COzYPv6QBZ5JBXCOwLfveA9wlXeC0tWOjaBjhsZoiQ6J+s+9kjBUw4u7d5S9AOKOLrvAovI366zWHrowFl8=
X-Received: by 2002:a1f:eec2:0:b0:36c:1c9b:465f with SMTP id
 m185-20020a1feec2000000b0036c1c9b465fmr2620378vkh.3.1655780034697; Mon, 20
 Jun 2022 19:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-3-amir73il@gmail.com>
 <20220620111705.zmujyr3v2f5uw326@zlang-mailbox> <CAOQ4uxjcMiT_-0mRWz3+v2pRx+sXdG0a51E=Tt1etgOrZJXrRA@mail.gmail.com>
 <20220620142139.zukdj3nk4lntwtpx@zlang-mailbox> <20220620223421.GC1098723@dread.disaster.area>
In-Reply-To: <20220620223421.GC1098723@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jun 2022 05:53:49 +0300
Message-ID: <CAOQ4uxjNx42RY3JfR6-NrggL5LnH_Xtt-iWP3nDpnzYF7oZBLw@mail.gmail.com>
Subject: Re: [PATCH 2/4] fstests: make sure to unfreeze test and scratch mounts
To:     Dave Chinner <david@fromorbit.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 21, 2022 at 1:34 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jun 20, 2022 at 10:21:39PM +0800, Zorro Lang wrote:
> > On Mon, Jun 20, 2022 at 03:13:33PM +0300, Amir Goldstein wrote:
> > > On Mon, Jun 20, 2022 at 2:17 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Sun, Jun 19, 2022 at 04:46:55PM +0300, Amir Goldstein wrote:
> > > > > Almost all of the tests that _require_freeze() fail to unfreeze
> > > > > scratch mount in case the test is interrupted while fs is frozen.
> > > > >
> > > > > Move the handling of unfreeze to generic check code.
> > > > > For now, tests only freeze scratch fs, but to be more robust, unfreeze
> > > > > both test and scratch fs following a call to _require_freeze().
> > > > >
> > > > > Tests could still hang if thier private _cleanup() routine tries
> > > > > to modify the frozen fs or wait for a blocked process. Fix the
> > > > > _cleanup() routine of xfs/011 to avoid that.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >  check             | 14 ++++++++------
> > > > >  common/rc         |  5 +++--
> > > > >  tests/generic/390 |  2 --
> > > > >  tests/xfs/011     |  2 --
> > > > >  tests/xfs/517     |  1 -
> > > > >  5 files changed, 11 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/check b/check
> > > > > index de11b37e..d6ee71aa 100755
> > > > > --- a/check
> > > > > +++ b/check
> > > > > @@ -527,17 +527,21 @@ _check_filesystems()
> > > > >  {
> > > > >       local ret=0
> > > > >
> > > > > +     # Make sure both test and scratch are unfrozen post _require_freeze()
> > > > > +     if [ -f ${RESULT_DIR}/require_freeze ]; then
> > > > > +             xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
> > > > > +             xfs_freeze -u "$SCRATCH_MNT" >/dev/null 2>&1
> > > > > +     fi
> > > >
> > > > Hi Amir,
> > > >
> > > > I'm wondering why not let each freeze related test cases take care of "unfreeze"
> > > > by itself? If a case freeze a filesystem which isn't on TEST_DEV or SCRATCH_DEV
> > > > (e.g. a loop device base on a file in $TEST_DIR), or other situations, then the
> > > > case still can call _require_freeze, but "unfreeze TEST_DIR or SCRATCH_MNT" can't
> > > > help.
> > >
> > > That's also an option, but:
> > > 1. It is less robust, leaving room for human mistakes. Why is that better?
>
> It's not, but I'm addressing exactly this problem with the common
> _cleanup() infrastructure that I'm working on. Several of the issues
> that you are trying to address here are already dealt with in that
> series, and it doesn't add extra overhead to the test
> infrastructure for tests that don't use freeze/thaw.
>
> > > 2. Leftover frozen fs is quite harmful to subsequent test runs, so it
> > > is important
> > >     to avoid it
>
> Well, yes. It is a test bug, and the test shouldn't have bugs.
>
> > > 3. Tests that freeze loop/dm (generic/459, xfs/428, [*]) can and should cleanup
> > >     themselves. I will add that too, but in any case...
>
> Except now we have two methods of thawing the filesystem depending
> on where it is mounted and what device is in use. That's not an
> improvement.
>
> > > 4. unfreeze of tests and scratch fs is harmless even when it is not needed -
> > >     we may even want to do that at the start of tests run(?)
> >
> > I think Dave doesn't like to add common steps to thousands of cases, if without
> > a critical reason. So I hope to get more review points for this kind of changes.
>
> Doing work that in every test execution that is only actually
> necessary if a test is interrupted to work around a potential bug in
> 1 or 2 tests is really poor design and implementation. Just fix the
> test bugs, don't burden everything else with the additional overhead
> of checking whether the test might have a bug in it or not...
>
> > > [*] I noticed that generic/085 which _require_freeze() does not even
> > >     use xfs_freeze (intentionally) - it uses dmsetup suspend/resume,
> > >     so I guess _require_freeze() should be removed from that test.
> >
> > Agree, I think dm suspend through different userspace and kernel interface with
> > fsfreeze, so that require doesn't make sense.
>
> dmsuspend uses the internal kernel freeze API to freeze the
> filesytsems. Failures in those tests can leave filesytsems frozen,
> too, but these days we cannot thaw them with fs level freeze....
>
> > > Anyway, if you and others insist against this auto-unfreeze approach,
> > > I will post the patch to unfreeze fs in individual tests, but I won't be
> > > happy about it.
> >
> > From the functional side, I think this change makes sense. But if think about
> > the performance, let's get more opinions at first. If there's not objection,
> > we can have it.
>
> I think it's wrong from a functional side, too. The test harness is
> not responsible for individual test state cleanup - the tests
> themselves are responsible for that. The whole point of the
> _cleanup() consolidation I've started doing is that it will
> centralise all this common cleanup functionality and allow us to end
> up connecting it to _requires rules that indicate what functionality
> the test uses.  i.e. the end goal is that most tests do not need any
> cleanup - everything that needs cleaning up is defined by the
> _requires rules the test runs first and nothing else is needed.
>
> Only when tests do custom stuff will test specific cleanup functions
> be needed, just like they are required to do now to clean up after
> themselves. And that means, right now, that tests that freeze the
> filesystem still need to do the right thing in the _cleanup()
> functions up until the consolidation of cleanup means they don't
> need it anymore....
>
> AFAIC, you can go move all this stuff to check if you really
> want, but I'm just going to rip it all back out in short order
> because it just doesn't fit the cleanup model I'm trying to move the
> infrastructure towards.
>

As long as your cleanup is going to consolidate all this I will
just go ahead and fix the buggy tests now.

Thanks!
Amir.
