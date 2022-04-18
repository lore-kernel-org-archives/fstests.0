Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C8C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 09:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiDRJJA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiDRJI7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 05:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DCE19FC8
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 02:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650272779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nhbws3dgiR9Up/uPeyd6sJvTB42ShFX5JOm1KLhT5DY=;
        b=FWoWblhsod54PPVKQOK6Kov2+dS34hmZM+W/AmGAwCYtqdiZ2XlN8f8rSi4OmpuJ0k1cZf
        WSEgQBXz/uxK1jDnC3d2C5y/D10oeU8DWAbAHQsf+nyzy8Hn7ihnrYQBcGju9V+9Nk8BHL
        wp5rr+6QrHjOYLrNAdXxazuv1i8SYcQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-WcWDDhuVMaavPtzkLJ0Lxw-1; Mon, 18 Apr 2022 05:06:18 -0400
X-MC-Unique: WcWDDhuVMaavPtzkLJ0Lxw-1
Received: by mail-qk1-f197.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso9925891qkl.7
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 02:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Nhbws3dgiR9Up/uPeyd6sJvTB42ShFX5JOm1KLhT5DY=;
        b=Kt95xD8dUotKW4ah7/58eep7BUi6TUGEWPzDX2+QKCGS4bE5XVAXFMeWUaVb/oUMj8
         vcPUjv2zL5WNpx9xYwfzUeoBmwmDEc9YyeXpyaD1sF0rqNCuY8lvktYKeqCYfBiMMcxC
         nd7SN42aBrLeuNqigzaIug++RUz1rSPTrHOrSOvgPypP3nhDZb+gyPvy+Pa5uNjuvkLJ
         KQfrOeOda5ax4J8Nv/wW2+ctev3/foTq+r+aFxBhO6HJur8oxaVDePZFkwqhDrCSjwxF
         Uu3JPfk5j45oC4e0sMyN2nabkqXgoPwde58WPakMZOG1jKsbBdZhlsDXXaAFhGcZN8ef
         ESZg==
X-Gm-Message-State: AOAM532yq0kmEVygwHQGZumGuXGSOS2KGPc8DiijrtSy93eawBQTHVEs
        3wLxxtY+pmUInIvMAZYDzOVezxTlB579yIx5DfS2DVv+91dWSgOx5eleYF7suEsim9apTC3923W
        tsVGfCgg1fWgQ7woL6g==
X-Received: by 2002:a05:622a:6083:b0:2f1:d380:1fad with SMTP id hf3-20020a05622a608300b002f1d3801fadmr6506136qtb.4.1650272777143;
        Mon, 18 Apr 2022 02:06:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/SymwnMrpf8T66Jm5X+lCKRdz8Khxh3I43YThaij4Ls1VzGobD7m3HprfqDdMrRER7n6e/A==
X-Received: by 2002:a05:622a:6083:b0:2f1:d380:1fad with SMTP id hf3-20020a05622a608300b002f1d3801fadmr6506123qtb.4.1650272776803;
        Mon, 18 Apr 2022 02:06:16 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t12-20020a05622a01cc00b002f204a559a4sm625064qtw.53.2022.04.18.02.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 02:06:16 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:06:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/3] common: add run option to skip tests for known issues
Message-ID: <20220418090609.34ynpe2fbi4ptxgp@zlang-mailbox>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20220417174023.3244263-1-amir73il@gmail.com>
 <20220417174023.3244263-4-amir73il@gmail.com>
 <20220418050520.h4ufi2qwz6ozpczp@zlang-mailbox>
 <CAOQ4uxiRA9pY1LEC8EBizYnOO1k=15dXKLsO6VdVOPwx3JN91w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiRA9pY1LEC8EBizYnOO1k=15dXKLsO6VdVOPwx3JN91w@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 18, 2022 at 08:56:43AM +0300, Amir Goldstein wrote:
> On Mon, Apr 18, 2022 at 8:05 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Sun, Apr 17, 2022 at 08:40:23PM +0300, Amir Goldstein wrote:
> > > Some tests are written before a fix is merged upstream and some tests
> > > are written without a known available fix at all. Such is the case with
> > > test overlay/061.
> > >
> > > Introduce a helper _known_issues_on_fs() which can be used to document
> > > this situation and print a hint on failure.
> > > The helper supports specifying specifc fs with the known issue for
> > > generic tests as well as the notation ^FS1 ^FS2 to indicate a known issue
> > > on all filesystems expect for FS1 FS2.
> > >
> > > Setting the variable SKIP_KNOWN_ISSUES=yes, will cause all tests
> > > annotated as known issues for the tested fs to be skipped.
> > >
> > > A future improvement may provide a run option to skip tests based on
> > > _known_issues_before_kernel when running the tests on an older kernel
> > > version.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  README            |  2 ++
> > >  common/rc         | 16 +++++++++++++++-
> > >  tests/overlay/061 |  2 ++
> > >  3 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/README b/README
> > > index 7da66cb6..8abc3840 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -241,6 +241,8 @@ Misc:
> > >     this option is supported for all filesystems currently only -overlay is
> > >     expected to run without issues. For other filesystems additional patches
> > >     and fixes to the test suite might be needed.
> > > + - set SKIP_KNOWN_ISSUES=yes to skip tests for bug without a known fix.
> > > +   Those tests are annotated with _known_issue_on_fs helper.
> > >
> > >  ______________________
> > >  USING THE FSQA SUITE
> > > diff --git a/common/rc b/common/rc
> > > index 2e9dc408..3cf60a7e 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -1597,8 +1597,23 @@ _supported_fs()
> > >               _notrun "not suitable for this filesystem type: $FSTYP"
> > >  }
> > >
> > > +_known_issue_on_fs()
> > > +{
> > > +     # Only "supported" fs have the known issue
> > > +     _check_supported_fs $* || return
> > > +
> > > +     if [ "$SKIP_KNOWN_ISSUES" = "yes" ]; then
> > > +             _notrun "known issue for this filesystem type: $FSTYP"
> > > +     fi
> > > +
> > > +     echo "HINT: You _MAY_ be hit by a known issue for filesystem type $FSTYP." >> $seqres.hints
> > > +     echo >> $seqres.hints
> > > +}
> > > +
> > >  _known_issue_before_kernel()
> > >  {
> > > +     # TODO: don't run if $SKIP_KNOWN_ISSUES and kernel version < $1
> > > +
> >
> > As I said in last patch review, it's only for one kernel base line, it might cause
> > downstream kernel testing can't run a case, even if it had backported the patches.
> >
> 
> I agree. This may be useful to some but a bit controversial.
> Anyway, I shall remove this TODO.
> 
> 
> > >       echo "HINT: You _MAY_ be hit by a known issue on kernel version < $1." >> $seqres.hints
> > >       echo >> $seqres.hints
> > >  }
> > > @@ -4929,7 +4944,6 @@ _require_kernel_config()
> > >       _has_kernel_config $1 || _notrun "Installed kernel not built with $1"
> > >  }
> > >
> > > -
> > >  init_rc
> > >
> > >  ################################################################################
> > > diff --git a/tests/overlay/061 b/tests/overlay/061
> > > index b80cf5a0..36be3391 100755
> > > --- a/tests/overlay/061
> > > +++ b/tests/overlay/061
> > > @@ -22,6 +22,8 @@ _begin_fstest posix copyup
> > >
> > >  # real QA test starts here
> > >  _supported_fs overlay
> > > +_known_issue_on_fs overlay
> >
> > If it's a overlay case, it's absolutely cover an overlay known issue at first.
> > Even if it hit a mm or underlying fs bug, the _known_issue_on_fs is helpless
> > for that.
> 
> I disagree.
> There is a subtle difference.
> Most of the tests in fstests are regression tests meaning that they
> cover an issue that is supposed to be fixed in the tested kernel.
> 
> In case of overlayfs, I took "test driven development" a bit further and
> wrote fstests to cover non-standard behavior that we want to fix and then
> wrote a development roadmap [*] that took more that 10 kernel releases
> to complete.
> Test overlay/061 is the last of those tests, whose issue was never addressed
> and there is no prospect as to when it is going to be addressed.
> 
> This is the reason that previous patch removed all those lines from comments:
> -# This simple test demonstrates a known issue with overlayfs:
> 
> [*] https://github.com/amir73il/overlayfs/wiki/Overlayfs-TODO#Compliance
> 
> As a tester, how would you know if something is wrong with your kernel
> when a test is failing unless you had an annotation that tells you that the
> test is expected to fail?
> 
> SKIP_KNOWN_ISSUES takes this one step further and says don't bother
> me with tests that are expected to fail.
> 
> >
> > I can understand above 2 patches, but this patch looks weird to me. We can
> > give a hint to downstream testing (from upstream commit side). But deal with
> > known issues, that's another story. I'd like to let testers from different
> > downstream kernels to deal with their known issues checking by themselves,
> > don't depend on upstream fstests for all.
> >
> 
> Not sure I understand your point.

Oh, sorry I didn't explain that clearly. I mean patch [1/3] and [2/3] can be improved
by more talking, but [3/3] is not reasonable for me.

Let's see what's the purpose of _known_issue_on_fs():

1) If it trys to work for upstream mainline:
As a hint, it can be replaced by known commit output [2/3]. As a forcibly "_notrun" to a fs,
it can be replaced by _supported_fs ^$someonefs with a proper comment [1/3]. As a test driven
tool... no, I don't like to make xfstests to be place which developers used to record/update/
remind their "planning to do/fix", they can record them in other place :)

2) If it trys to help downstream testing:
It's really helpless for downstream testing, except downstream testers maintain their
own xfstests, and change `_known_issue_on_fs xxx` for themselves. But as a downstream
tester, I'd like to maintain our known issues (known failures and skip list) by
ourselves in another place, not in xfstests inside.

Anyway, let's see reviewpoint from others too :)

Thanks,
Zorro

> 
> The intention of this helper was to address the debate over two of Darrick's
> new tests. I mentioned them in the cover letter but forgot to mention here:
> 
> [1] https://lore.kernel.org/fstests/20220412172853.GG16799@magnolia/
> [2] https://lore.kernel.org/fstests/20220414155007.GC17014@magnolia/
> 
> There is a difference between:
> _supported_fs ext4 xfs btrfs
> 
> And:
> 
> _supported_fs generic
> # https://lore.kernel.org/fstests/20220414155007.GC17014@magnolia/
> _known_issue_on_fs ^ext4 ^xfs ^btrfs
> 
> The main difference is that the test WILL run and fail on all other fs
> and both me and Eryu indicated that should happen.
> 
> The difference from only using _supported_fs generic
> is that giving more information causes less surprises and less confusion
> to other fs developers that get a surprise new failure when pulling fstests
> upstream updates.
> 
> In the end, that what this series is all about - being more considerate
> of other testers and making the information known to test author known
> to a much wider audience that does not need to dig in test comments
> and long mailing list discussions or overlayfs roadmap wikis to find that
> information.
> 
> Thanks,
> Amir.
> 

