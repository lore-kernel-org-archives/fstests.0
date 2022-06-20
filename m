Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F69C43334
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 12:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiFTMN6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbiFTMNq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 08:13:46 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900D18E1A
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 05:13:45 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id l28so2342179vsb.1
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObI/cUo9R3QgE4SOYEjrZkYlr+Hn1N4cNM6WCJkbBLw=;
        b=d4orPRUyCxoRPwQpkTP9iKrnc+7rezNfm/tFo8X/TP4yEsIw/wNyFmvlhXdtptZyrO
         cVsBGzGwDdMmKjSNDUvngoaLaNLtDV7quLIiIqfbDPqEhUrpN2kV1yjeW7d1V4Xl/NJB
         1oqE6Vjq0Ftd+nqffHKgh8pzEYGCNHRhM34a3HAcslIi8oMIvWHgJIw0dtAl3UgDZfaA
         6fasUYi84aWS2Ljoz68pv1JELZkuZJCS0uD2a4sShDy9hWqHPBBlUvq++98ZhNVE740l
         RkRK/xQVNhYdeHvA/fKWNs6rFErYC4ZMfd1k67cuzVrZ+jHL38uAffF3YgaeLlzv9tnt
         czvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObI/cUo9R3QgE4SOYEjrZkYlr+Hn1N4cNM6WCJkbBLw=;
        b=h3yMx+ATFGo4On3euFbvapay0KbLU/t4r2dUWe7GRKCesvUoNuv0LO7HliE67vhtKt
         SnYvDiCw9K0/G+z58QcqbuU1EL8uWmSVYLuR213RKYAd++midWh2aufEZ8LLZ6CT2Ej1
         OlLpiJZprBdZ1PUajoNmF1MnLgYeO7oFje1mqzmhCSIiVzBXcMoreUXSKoBisfKUJ42p
         olwwAAzm1iBuAWpIsQJnz2Nu5hxs77xOo/91o6mm6IuxqXb5YVk3qqhgFBKcbh3F+/zu
         KhXRA1wOw21oGTE/43jOw3hQJxrF6ECKyjcxqmJLFXS5d2CZNEcM86aMHYJTWC3TOSon
         n0AQ==
X-Gm-Message-State: AJIora+XmM52Vttq21PEFZVy7hXqs1zhEV8FdlyASJNHs75t92uEuvIo
        /Lfbrq0kuCvtEV6Fqj+nJMGjwbIWuKETuLJNMjc=
X-Google-Smtp-Source: AGRyM1td6rl0w/MU82Ql+pzy3CcfvDCBNBcBEsjfTvG0Twj8uJoRpuI3F1FkVxZxxd2miSvzzjUt5iT85VaBBRfvdyM=
X-Received: by 2002:a05:6102:c50:b0:34c:2063:ae5e with SMTP id
 y16-20020a0561020c5000b0034c2063ae5emr9010566vss.71.1655727224603; Mon, 20
 Jun 2022 05:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-3-amir73il@gmail.com>
 <20220620111705.zmujyr3v2f5uw326@zlang-mailbox>
In-Reply-To: <20220620111705.zmujyr3v2f5uw326@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 Jun 2022 15:13:33 +0300
Message-ID: <CAOQ4uxjcMiT_-0mRWz3+v2pRx+sXdG0a51E=Tt1etgOrZJXrRA@mail.gmail.com>
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

On Mon, Jun 20, 2022 at 2:17 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Sun, Jun 19, 2022 at 04:46:55PM +0300, Amir Goldstein wrote:
> > Almost all of the tests that _require_freeze() fail to unfreeze
> > scratch mount in case the test is interrupted while fs is frozen.
> >
> > Move the handling of unfreeze to generic check code.
> > For now, tests only freeze scratch fs, but to be more robust, unfreeze
> > both test and scratch fs following a call to _require_freeze().
> >
> > Tests could still hang if thier private _cleanup() routine tries
> > to modify the frozen fs or wait for a blocked process. Fix the
> > _cleanup() routine of xfs/011 to avoid that.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  check             | 14 ++++++++------
> >  common/rc         |  5 +++--
> >  tests/generic/390 |  2 --
> >  tests/xfs/011     |  2 --
> >  tests/xfs/517     |  1 -
> >  5 files changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/check b/check
> > index de11b37e..d6ee71aa 100755
> > --- a/check
> > +++ b/check
> > @@ -527,17 +527,21 @@ _check_filesystems()
> >  {
> >       local ret=0
> >
> > +     # Make sure both test and scratch are unfrozen post _require_freeze()
> > +     if [ -f ${RESULT_DIR}/require_freeze ]; then
> > +             xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
> > +             xfs_freeze -u "$SCRATCH_MNT" >/dev/null 2>&1
> > +     fi
>
> Hi Amir,
>
> I'm wondering why not let each freeze related test cases take care of "unfreeze"
> by itself? If a case freeze a filesystem which isn't on TEST_DEV or SCRATCH_DEV
> (e.g. a loop device base on a file in $TEST_DIR), or other situations, then the
> case still can call _require_freeze, but "unfreeze TEST_DIR or SCRATCH_MNT" can't
> help.

That's also an option, but:
1. It is less robust, leaving room for human mistakes. Why is that better?
2. Leftover frozen fs is quite harmful to subsequent test runs, so it
is important
    to avoid it
3. Tests that freeze loop/dm (generic/459, xfs/428, [*]) can and should cleanup
    themselves. I will add that too, but in any case...
4. unfreeze of tests and scratch fs is harmless even when it is not needed -
    we may even want to do that at the start of tests run(?)

[*] I noticed that generic/085 which _require_freeze() does not even
    use xfs_freeze (intentionally) - it uses dmsetup suspend/resume,
    so I guess _require_freeze() should be removed from that test.

Anyway, if you and others insist against this auto-unfreeze approach,
I will post the patch to unfreeze fs in individual tests, but I won't be
happy about it.

Thanks,
Amir.
