Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC07C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 05:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiDRF7f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 01:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiDRF7f (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 01:59:35 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D317A88
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 22:56:56 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x24so1054426qtq.11
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Aweq15nZzHPJaDPCNiSpQowTBga0FqQnJlOFwIxoYlw=;
        b=WyWzpRObECGSJjvc2NsVV16Z7EqcGaJ9BNybYNNF7v2ch1FnEXUsNBlRIkOojjHtG0
         UGJ4MxTxoUpFvgGCSSz0dKdoXTAcpic5aKHmsnjF8o0aWEsFOvmPjUYAFKy10Ro+EDfI
         x4zhJm7OJOOtd0MSv/sPI3Y8t7HcITQlYaHnu9ExEDI9MjHsZvN3LQYl/NbNWCKHbn4V
         EMdlONWFCk54QM943JE+qxzCNXrWCG1IY0/lal7xzuGggwGZsy2iZJ6taE1MLXUYd2Xd
         zcqel6b5uo2fV46afw/zRuRhKxOmoA1XgssC2sjbL+IoYpTgz0VBLnTR7veLvGAsW8mG
         ax5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Aweq15nZzHPJaDPCNiSpQowTBga0FqQnJlOFwIxoYlw=;
        b=fs6DctUMfx3y4wcAv93PSgXg/rBJkGbzIcIbmYDwLBr1bgLq15eOMa/Q2tw2Osmw4P
         i4OAgLuDzo1tG1VTYP0Im/ndepEKKhd70u9VhvesmpLH3d9Yd+JGQFRAQv4d8CRQO/eZ
         twuil4GwLI57LOwzb7qLUrfJCusyJgog68EZTuKPFtkHwVnW7wuuIjqZZ8gqujV7K6vr
         c6jJcVy5uZFKI8zwBJsODRXde/sZPBvlF099+5fhXY+p/XSSsrcc5gzwsXrEluT6ugum
         0Vty2tdN2Mj+cUJoZ/msLMNxbR7u8cXi1cUtlzOyKSlSP1Zf/UgqT0VaWHt+/3368ZDL
         JD4g==
X-Gm-Message-State: AOAM533jqQn4C8DFXHdme5ux+8c2HIk2roEDEYiQL3/500LAOimIOmMJ
        eMWFvbdNEXegOVCyYaaFcJEDIugKVU9vLPiI0Da91k5hI18=
X-Google-Smtp-Source: ABdhPJysuMkh9/Cnl7lCm5qcu1lqSzyEAXffiErHTSAMsl0vUH3sM+cSsPeI34Ozmhap7vREiEkbjfKb6Z36zG0oSRE=
X-Received: by 2002:ac8:4e46:0:b0:2e1:b933:ec06 with SMTP id
 e6-20020ac84e46000000b002e1b933ec06mr6153988qtw.684.1650261414981; Sun, 17
 Apr 2022 22:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220417174023.3244263-1-amir73il@gmail.com> <20220417174023.3244263-4-amir73il@gmail.com>
 <20220418050520.h4ufi2qwz6ozpczp@zlang-mailbox>
In-Reply-To: <20220418050520.h4ufi2qwz6ozpczp@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Apr 2022 08:56:43 +0300
Message-ID: <CAOQ4uxiRA9pY1LEC8EBizYnOO1k=15dXKLsO6VdVOPwx3JN91w@mail.gmail.com>
Subject: Re: [PATCH 3/3] common: add run option to skip tests for known issues
To:     Amir Goldstein <amir73il@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 18, 2022 at 8:05 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Sun, Apr 17, 2022 at 08:40:23PM +0300, Amir Goldstein wrote:
> > Some tests are written before a fix is merged upstream and some tests
> > are written without a known available fix at all. Such is the case with
> > test overlay/061.
> >
> > Introduce a helper _known_issues_on_fs() which can be used to document
> > this situation and print a hint on failure.
> > The helper supports specifying specifc fs with the known issue for
> > generic tests as well as the notation ^FS1 ^FS2 to indicate a known issue
> > on all filesystems expect for FS1 FS2.
> >
> > Setting the variable SKIP_KNOWN_ISSUES=yes, will cause all tests
> > annotated as known issues for the tested fs to be skipped.
> >
> > A future improvement may provide a run option to skip tests based on
> > _known_issues_before_kernel when running the tests on an older kernel
> > version.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  README            |  2 ++
> >  common/rc         | 16 +++++++++++++++-
> >  tests/overlay/061 |  2 ++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/README b/README
> > index 7da66cb6..8abc3840 100644
> > --- a/README
> > +++ b/README
> > @@ -241,6 +241,8 @@ Misc:
> >     this option is supported for all filesystems currently only -overlay is
> >     expected to run without issues. For other filesystems additional patches
> >     and fixes to the test suite might be needed.
> > + - set SKIP_KNOWN_ISSUES=yes to skip tests for bug without a known fix.
> > +   Those tests are annotated with _known_issue_on_fs helper.
> >
> >  ______________________
> >  USING THE FSQA SUITE
> > diff --git a/common/rc b/common/rc
> > index 2e9dc408..3cf60a7e 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1597,8 +1597,23 @@ _supported_fs()
> >               _notrun "not suitable for this filesystem type: $FSTYP"
> >  }
> >
> > +_known_issue_on_fs()
> > +{
> > +     # Only "supported" fs have the known issue
> > +     _check_supported_fs $* || return
> > +
> > +     if [ "$SKIP_KNOWN_ISSUES" = "yes" ]; then
> > +             _notrun "known issue for this filesystem type: $FSTYP"
> > +     fi
> > +
> > +     echo "HINT: You _MAY_ be hit by a known issue for filesystem type $FSTYP." >> $seqres.hints
> > +     echo >> $seqres.hints
> > +}
> > +
> >  _known_issue_before_kernel()
> >  {
> > +     # TODO: don't run if $SKIP_KNOWN_ISSUES and kernel version < $1
> > +
>
> As I said in last patch review, it's only for one kernel base line, it might cause
> downstream kernel testing can't run a case, even if it had backported the patches.
>

I agree. This may be useful to some but a bit controversial.
Anyway, I shall remove this TODO.


> >       echo "HINT: You _MAY_ be hit by a known issue on kernel version < $1." >> $seqres.hints
> >       echo >> $seqres.hints
> >  }
> > @@ -4929,7 +4944,6 @@ _require_kernel_config()
> >       _has_kernel_config $1 || _notrun "Installed kernel not built with $1"
> >  }
> >
> > -
> >  init_rc
> >
> >  ################################################################################
> > diff --git a/tests/overlay/061 b/tests/overlay/061
> > index b80cf5a0..36be3391 100755
> > --- a/tests/overlay/061
> > +++ b/tests/overlay/061
> > @@ -22,6 +22,8 @@ _begin_fstest posix copyup
> >
> >  # real QA test starts here
> >  _supported_fs overlay
> > +_known_issue_on_fs overlay
>
> If it's a overlay case, it's absolutely cover an overlay known issue at first.
> Even if it hit a mm or underlying fs bug, the _known_issue_on_fs is helpless
> for that.

I disagree.
There is a subtle difference.
Most of the tests in fstests are regression tests meaning that they
cover an issue that is supposed to be fixed in the tested kernel.

In case of overlayfs, I took "test driven development" a bit further and
wrote fstests to cover non-standard behavior that we want to fix and then
wrote a development roadmap [*] that took more that 10 kernel releases
to complete.
Test overlay/061 is the last of those tests, whose issue was never addressed
and there is no prospect as to when it is going to be addressed.

This is the reason that previous patch removed all those lines from comments:
-# This simple test demonstrates a known issue with overlayfs:

[*] https://github.com/amir73il/overlayfs/wiki/Overlayfs-TODO#Compliance

As a tester, how would you know if something is wrong with your kernel
when a test is failing unless you had an annotation that tells you that the
test is expected to fail?

SKIP_KNOWN_ISSUES takes this one step further and says don't bother
me with tests that are expected to fail.

>
> I can understand above 2 patches, but this patch looks weird to me. We can
> give a hint to downstream testing (from upstream commit side). But deal with
> known issues, that's another story. I'd like to let testers from different
> downstream kernels to deal with their known issues checking by themselves,
> don't depend on upstream fstests for all.
>

Not sure I understand your point.

The intention of this helper was to address the debate over two of Darrick's
new tests. I mentioned them in the cover letter but forgot to mention here:

[1] https://lore.kernel.org/fstests/20220412172853.GG16799@magnolia/
[2] https://lore.kernel.org/fstests/20220414155007.GC17014@magnolia/

There is a difference between:
_supported_fs ext4 xfs btrfs

And:

_supported_fs generic
# https://lore.kernel.org/fstests/20220414155007.GC17014@magnolia/
_known_issue_on_fs ^ext4 ^xfs ^btrfs

The main difference is that the test WILL run and fail on all other fs
and both me and Eryu indicated that should happen.

The difference from only using _supported_fs generic
is that giving more information causes less surprises and less confusion
to other fs developers that get a surprise new failure when pulling fstests
upstream updates.

In the end, that what this series is all about - being more considerate
of other testers and making the information known to test author known
to a much wider audience that does not need to dig in test comments
and long mailing list discussions or overlayfs roadmap wikis to find that
information.

Thanks,
Amir.
