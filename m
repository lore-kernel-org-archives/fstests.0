Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40ADC61DA4
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Feb 2023 05:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBRFr4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Feb 2023 00:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRFrz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Feb 2023 00:47:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BEBC661
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 21:47:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E626CB82C9F
        for <fstests@vger.kernel.org>; Sat, 18 Feb 2023 05:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4824EC433EF;
        Sat, 18 Feb 2023 05:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676699270;
        bh=wOKIX/tXQard0vBGNGBzWP+INiQTguLsxOTUGLIVhbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaOW5q93CYhzQoX3vqWqhC5NNgvLeTPSq0Ud9S72hJwUyKruR2d6NXra3k/ElJsCK
         3XevL6SuAY6l4F/gXedol1+GJvKDlaIDzG0Oob5S5SyC0PCa0cu0VoR/LXq4EU8+TZ
         fpIlVUa6JuaLakjvPrMxlLesklFhYiWfP2Lj4cClJuOpHLAkb4bGWQcZhKWcvfg47p
         zBW/CdaIhfRw09+5J3afju5phYJDhPeiqfIAJcF0zcwu2oRMo8Ci44ilDeFJy6l50J
         HvU64PSQiHM1JdEkR6ye76JTBGMlh4p5nYbrKOCnOT/87n56EbBTqJuqwhp2ibj+tu
         9n06a9HK1LlqA==
Date:   Sat, 18 Feb 2023 13:47:45 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] selftest: add tests for debugging testing setup
Message-ID: <20230218054745.q4fxwrpvyzwwq6pd@zlang-mailbox>
References: <20230214215431.1425107-1-leah.rumancik@gmail.com>
 <20230215044941.xgk3crhvv2jlahx6@zlang-mailbox>
 <CAOQ4uxguCkBjXydVLbDSGX7-aHd_G_tfD4u4fgvH9QCN=edA-g@mail.gmail.com>
 <Y+1/2GwjLpM5cRF+@google.com>
 <20230216054107.e2xed7ns4pcjqrc3@zlang-mailbox>
 <Y+/KU+4yrm47q5Ny@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+/KU+4yrm47q5Ny@google.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Feb 17, 2023 at 10:41:23AM -0800, Leah Rumancik wrote:
> On Thu, Feb 16, 2023 at 01:41:07PM +0800, Zorro Lang wrote:
> > On Wed, Feb 15, 2023 at 04:59:04PM -0800, Leah Rumancik wrote:
> > > On Wed, Feb 15, 2023 at 07:57:55AM +0200, Amir Goldstein wrote:
> > > > On Wed, Feb 15, 2023 at 6:57 AM Zorro Lang <zlang@redhat.com> wrote:
> > > > >
> > > > > On Tue, Feb 14, 2023 at 01:54:31PM -0800, Leah Rumancik wrote:
> > > > > > Many people have developed infrastructure around xfstests. In order to
> > > > > > test a setup, it would be helpful to have dummy tests that have
> > > > > > consistent test outcomes. Add a new test folder with the following
> > > > > > tests:
> > > > > >
> > > > > > selftest/001 pass
> > > > > > selftest/002 fail from output mismatch
> > > > > > selftest/003 fail via _fail
> > > > > > selftest/004 skip
> > > > > > selftest/005 crash
> > > > > > selftest/006 hang
> > > > > >
> > > > > > Also, create two new groups: 'selftest' which includes tests 001-004 and
> > > > > > 'dangerous_selftest' which includes tests 005-006. The selftests will
> > > > > > run when running all tests but they are not part of the auto group.
> > > > > >
> > > > > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > > > > ---
> > > > > > v1 -> v2:
> > > > > >
> > > > > > - change name of folder from 'debug' to 'selftest'
> > > > > > - update tags to 'selftest' and 'dangerous_selftest'
> > > > > > - add selftest folder to SRC_GROUPS
> > > > > > - update copyright tag
> > > > > > - add test which _fails
> > > > >
> > > > > Thanks, this version looks good to me, just each case has a blank line at EOF.
> > > > > I'll help to remove those blank lines when I merge this patch.
> > > > >
> > > > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > > > >
> > > > > Thanks,
> > > > > Zorro
> > > > >
> > > > >
> > > > > >
> > > > > > v1: https://lore.kernel.org/fstests/20230209013143.2586104-1-leah.rumancik@gmail.com/
> > > > > >
> > > > > >  check                   |  2 +-
> > > > > >  doc/group-names.txt     |  2 ++
> > > > > >  tests/selftest/001      | 14 ++++++++++++++
> > > > > >  tests/selftest/001.out  |  2 ++
> > > > > >  tests/selftest/002      | 14 ++++++++++++++
> > > > > >  tests/selftest/002.out  |  2 ++
> > > > > >  tests/selftest/003      | 16 ++++++++++++++++
> > > > > >  tests/selftest/003.out  |  2 ++
> > > > > >  tests/selftest/004      | 16 ++++++++++++++++
> > > > > >  tests/selftest/004.out  |  2 ++
> > > > > >  tests/selftest/005      | 17 +++++++++++++++++
> > > > > >  tests/selftest/005.out  |  2 ++
> > > > > >  tests/selftest/006      | 20 ++++++++++++++++++++
> > > > > >  tests/selftest/006.out  |  2 ++
> > > > > >  tests/selftest/Makefile | 24 ++++++++++++++++++++++++
> > > > > >  15 files changed, 136 insertions(+), 1 deletion(-)
> > > > > >  create mode 100755 tests/selftest/001
> > > > > >  create mode 100644 tests/selftest/001.out
> > > > > >  create mode 100755 tests/selftest/002
> > > > > >  create mode 100644 tests/selftest/002.out
> > > > > >  create mode 100755 tests/selftest/003
> > > > > >  create mode 100644 tests/selftest/003.out
> > > > > >  create mode 100755 tests/selftest/004
> > > > > >  create mode 100644 tests/selftest/004.out
> > > > > >  create mode 100755 tests/selftest/005
> > > > > >  create mode 100644 tests/selftest/005.out
> > > > > >  create mode 100755 tests/selftest/006
> > > > > >  create mode 100644 tests/selftest/006.out
> > > > > >  create mode 100644 tests/selftest/Makefile
> > > > > >
> > > > > > diff --git a/check b/check
> > > > > > index 4827532e..c2065cdc 100755
> > > > > > --- a/check
> > > > > > +++ b/check
> > > > > > @@ -48,7 +48,7 @@ timestamp=${TIMESTAMP:=false}
> > > > > >
> > > > > >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
> > > > > >
> > > > > > -SRC_GROUPS="generic shared"
> > > > > > +SRC_GROUPS="generic shared selftest"
> > > > 
> > > > I know this is a bit of bikeshedding,
> > > > but is it really needed to add selftest/* to SRC_GROUPS and then filter it out
> > > > by group?
> > > > 
> > > > Seems to me that it would be simpler to not add any new groups and use
> > > > ./check -g selftest/quick -g selftest/dangerous
> > > > to run the tests in the selftests subdir.
> > > > 
> > > > Just to be clear, the syntax above already works, nothing new to implement.
> > > > 
> > > > I do not object to adding the selftest groups if others like it better this way.
> > > 
> > > I think it behaves more as expected when it is a part of SRC_GROUPS, but
> > > I will probably run these by specifying specific tests - so I don't
> > > care much about which groups are used / if it is in SRC_GROUPS or not,
> > > and I am happy to change it if others agree.
> > 
> > I agree with the suggestion from Amir. The "selftest" should be an independent
> > test group only be run when a tester intend to run it.
> 
> 
> When you say "selftest" should be an independent test group, do you mean
> we should keep the "selftest" and "dangerous_selftest" groups but just
> remove the "selftest" folder from SRC_GROUPS? I think Amir was suggesting
> to completely remove the test groups "selftest" and
> "dangerous_selftest" as well as removing the folder from SRC_GROUPS.

Oh, sorry for the confusion. I think generally no one run selftest cases with
other cases together (correct me if someone has this requirement ;), so we can
remove the selftest from SRC_GROUPS.

About the new groups (selftest and dangerous_selftest), I'm both OK with or
without them. (So let's keep them if no more objection:).

Besides that, we'd better to update the documentation, to shows we have
selftest in tests/selftest directory, and how to add and run them. (in
README or add a README.selftest).

Thanks,
Zorro

> 
> - Leah
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > > 
> > > > It would also be nice to drop a line in README about running selftests.
> > > 
> > > Sure, I can do this.
> > > 
> > > > 
> > > > Thanks,
> > > > Amir.
> > > 
> > 
> 
