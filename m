Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0384CC636CC
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Feb 2023 00:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBPA7J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Feb 2023 19:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBPA7I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Feb 2023 19:59:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03222BEE9
        for <fstests@vger.kernel.org>; Wed, 15 Feb 2023 16:59:07 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id h4so455892pll.9
        for <fstests@vger.kernel.org>; Wed, 15 Feb 2023 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CJGXyM0Oj+hhoOID8ZKywU88gr39cPAOBiyosSfazTg=;
        b=dA8eeOgYvjchNUwXCp/ptDyuohelp4Mn8LtC4u57DoyLCK/mFy8zLfxFTHWHiFsSBq
         9vvyUfZ8sQ1KH3bTZ8sC0kl04D2uJe5lGG59sPqX94v38AW6tBGNY8ULAaOVAMfUpzhj
         upwsk4BmOWZ8rNCh818va+l29UEhVvOJrZb2Y+YE2pGTU3u92wOnTxd1g2mRs8v25n4V
         RuUWF8xWhl91FIhXxnNsyyny/1CPYg5ZTmZSypcC1iALDZev9QTKY1sGVvvFVt6SEIXI
         mjgh5tVY8tftGn+rpQ4yNsTBv1ld4ILGnk7eimZCXvUxk5V8Ma0/y6O5+qBI/DCfn3Rr
         iEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJGXyM0Oj+hhoOID8ZKywU88gr39cPAOBiyosSfazTg=;
        b=dH8DpEQJ5PTfnE3hrEWdUxeDVNpoEXZ4WiZQ1Q/KOzpFe+0Lll2qPwJb3+3xRUfO6E
         qQXDph8enVWS3L8uUZ7UAhSblPq7XaqBvKzGmQm/eKIOrM4vdc87pYQXOuf7MEK3jRuM
         RUQjDtGJ4TGRDq/fbGDSE1CmQ7583EIIT0wx2a0o7tdiBHwpqlb/2ynrtRHV5RPIS/F9
         br7nyiQON+5ZaqgEaNNm7uUAVzuGik1pPiB/UyNCIZS/hzFnM4Rg13VPR03FNURGLw1o
         a6afIZRnfg1zjAyGDRJvKQudBLCMLSEdjuyF9tvDzdpCJJBxp9+8J+1w3PuMw1I+XKQw
         XHgg==
X-Gm-Message-State: AO0yUKW6chZfh8CCk0/UuRRCfE2RrRvit18BkoosfUtLsdij8oPh2kDj
        mSWCwnJm+bQjWhiex2Xw++Q=
X-Google-Smtp-Source: AK7set8s2q2TqsvrTN2cQ1lotMhM64+xPCXChQNe1KTVuHpX0K54GJu6mFaTBK66jnInwmBiR+9JUg==
X-Received: by 2002:a05:6a20:7fa2:b0:c7:166d:686 with SMTP id d34-20020a056a207fa200b000c7166d0686mr820667pzj.26.1676509146949;
        Wed, 15 Feb 2023 16:59:06 -0800 (PST)
Received: from google.com ([2601:647:4701:18d0:959b:8a40:b914:6ab9])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78d05000000b0058a3d8eab6asm12328406pfe.134.2023.02.15.16.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 16:59:06 -0800 (PST)
Date:   Wed, 15 Feb 2023 16:59:04 -0800
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] selftest: add tests for debugging testing setup
Message-ID: <Y+1/2GwjLpM5cRF+@google.com>
References: <20230214215431.1425107-1-leah.rumancik@gmail.com>
 <20230215044941.xgk3crhvv2jlahx6@zlang-mailbox>
 <CAOQ4uxguCkBjXydVLbDSGX7-aHd_G_tfD4u4fgvH9QCN=edA-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxguCkBjXydVLbDSGX7-aHd_G_tfD4u4fgvH9QCN=edA-g@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 15, 2023 at 07:57:55AM +0200, Amir Goldstein wrote:
> On Wed, Feb 15, 2023 at 6:57 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Tue, Feb 14, 2023 at 01:54:31PM -0800, Leah Rumancik wrote:
> > > Many people have developed infrastructure around xfstests. In order to
> > > test a setup, it would be helpful to have dummy tests that have
> > > consistent test outcomes. Add a new test folder with the following
> > > tests:
> > >
> > > selftest/001 pass
> > > selftest/002 fail from output mismatch
> > > selftest/003 fail via _fail
> > > selftest/004 skip
> > > selftest/005 crash
> > > selftest/006 hang
> > >
> > > Also, create two new groups: 'selftest' which includes tests 001-004 and
> > > 'dangerous_selftest' which includes tests 005-006. The selftests will
> > > run when running all tests but they are not part of the auto group.
> > >
> > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > ---
> > > v1 -> v2:
> > >
> > > - change name of folder from 'debug' to 'selftest'
> > > - update tags to 'selftest' and 'dangerous_selftest'
> > > - add selftest folder to SRC_GROUPS
> > > - update copyright tag
> > > - add test which _fails
> >
> > Thanks, this version looks good to me, just each case has a blank line at EOF.
> > I'll help to remove those blank lines when I merge this patch.
> >
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> >
> > Thanks,
> > Zorro
> >
> >
> > >
> > > v1: https://lore.kernel.org/fstests/20230209013143.2586104-1-leah.rumancik@gmail.com/
> > >
> > >  check                   |  2 +-
> > >  doc/group-names.txt     |  2 ++
> > >  tests/selftest/001      | 14 ++++++++++++++
> > >  tests/selftest/001.out  |  2 ++
> > >  tests/selftest/002      | 14 ++++++++++++++
> > >  tests/selftest/002.out  |  2 ++
> > >  tests/selftest/003      | 16 ++++++++++++++++
> > >  tests/selftest/003.out  |  2 ++
> > >  tests/selftest/004      | 16 ++++++++++++++++
> > >  tests/selftest/004.out  |  2 ++
> > >  tests/selftest/005      | 17 +++++++++++++++++
> > >  tests/selftest/005.out  |  2 ++
> > >  tests/selftest/006      | 20 ++++++++++++++++++++
> > >  tests/selftest/006.out  |  2 ++
> > >  tests/selftest/Makefile | 24 ++++++++++++++++++++++++
> > >  15 files changed, 136 insertions(+), 1 deletion(-)
> > >  create mode 100755 tests/selftest/001
> > >  create mode 100644 tests/selftest/001.out
> > >  create mode 100755 tests/selftest/002
> > >  create mode 100644 tests/selftest/002.out
> > >  create mode 100755 tests/selftest/003
> > >  create mode 100644 tests/selftest/003.out
> > >  create mode 100755 tests/selftest/004
> > >  create mode 100644 tests/selftest/004.out
> > >  create mode 100755 tests/selftest/005
> > >  create mode 100644 tests/selftest/005.out
> > >  create mode 100755 tests/selftest/006
> > >  create mode 100644 tests/selftest/006.out
> > >  create mode 100644 tests/selftest/Makefile
> > >
> > > diff --git a/check b/check
> > > index 4827532e..c2065cdc 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -48,7 +48,7 @@ timestamp=${TIMESTAMP:=false}
> > >
> > >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
> > >
> > > -SRC_GROUPS="generic shared"
> > > +SRC_GROUPS="generic shared selftest"
> 
> I know this is a bit of bikeshedding,
> but is it really needed to add selftest/* to SRC_GROUPS and then filter it out
> by group?
> 
> Seems to me that it would be simpler to not add any new groups and use
> ./check -g selftest/quick -g selftest/dangerous
> to run the tests in the selftests subdir.
> 
> Just to be clear, the syntax above already works, nothing new to implement.
> 
> I do not object to adding the selftest groups if others like it better this way.

I think it behaves more as expected when it is a part of SRC_GROUPS, but
I will probably run these by specifying specific tests - so I don't
care much about which groups are used / if it is in SRC_GROUPS or not,
and I am happy to change it if others agree.

> 
> It would also be nice to drop a line in README about running selftests.

Sure, I can do this.

> 
> Thanks,
> Amir.
