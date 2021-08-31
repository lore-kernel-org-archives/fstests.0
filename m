Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917AEC432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DE9600CC
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhHaXrF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Aug 2021 19:47:05 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:45402 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231511AbhHaXrF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Aug 2021 19:47:05 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 31075114557F
        for <fstests@vger.kernel.org>; Wed,  1 Sep 2021 09:46:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mLDS5-007FhQ-HY
        for fstests@vger.kernel.org; Wed, 01 Sep 2021 09:46:01 +1000
Date:   Wed, 1 Sep 2021 09:46:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: which has been deprecated by Debian
Message-ID: <20210831234601.GI2566745@dread.disaster.area>
References: <20210830011401.697295-1-david@fromorbit.com>
 <20210830132927.7glbrcsgwep6xq4v@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830132927.7glbrcsgwep6xq4v@fedora>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=0r-O_0yx9S-6RauDYA4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 30, 2021 at 09:29:27PM +0800, Zorro Lang wrote:
> On Mon, Aug 30, 2021 at 11:14:01AM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > This patch is brought to you by the Department That Hates Users.
> > 
> > The latest debian unstable release is now causing a bunch of new
> > test failures because they have deprecated the which command.
> > 
> > Rather than make everyone jump through hoops chasing problems with
> > 'which' while debian decides to how to package at least three
> > variants of 'which' - each which will different semantics, behaviour
> > and support - as alternatives users then have to opt into, let's
> > just remove the remaining uses of the shell independent 'which'
> > command and replace them with bash builtin 'type -P' operations.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> 
> 
> 
> 
> >  common/rc         | 2 +-
> >  src/fill2fs       | 2 +-
> >  tests/ext4/006    | 2 +-
> >  tests/generic/128 | 2 +-
> >  tests/generic/452 | 2 +-
> >  tests/xfs/293     | 2 +-
> >  tests/xfs/505     | 2 +-
> >  tests/xfs/514     | 2 +-
> >  tests/xfs/515     | 2 +-
> >  9 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index a7f9ed86..db400c4d 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4,7 +4,7 @@
> >  
> >  . common/config
> >  
> > -BC=$(which bc 2> /dev/null) || BC=
> > +BC="$(type -P bc)" || BC=
> >  
> >  _require_math()
> >  {
> > diff --git a/src/fill2fs b/src/fill2fs
> > index 1c3383a8..d5e5436b 100755
> > --- a/src/fill2fs
> > +++ b/src/fill2fs
> > @@ -111,7 +111,7 @@ sub normal {
> >  #
> >  
> >  chomp($cwd = `pwd`);
> > -chomp($_ = `which fill2 2>&1 | head -1`);
> > +chomp($_ = `type -P fill2 | head -1`);
> >  if (-x $_) {
> >    # look in the path
> >    $fill2 = fill2;
> > diff --git a/tests/ext4/006 b/tests/ext4/006
> > index 17e77f86..48ed6bee 100755
> > --- a/tests/ext4/006
> > +++ b/tests/ext4/006
> > @@ -24,7 +24,7 @@ _cleanup()
> >  . ./common/populate
> >  . ./common/fuzzy
> >  
> > -if [ ! -x "$(which e2fuzz)" ]; then
> > +if [ ! -x "$(type -P e2fuzz)" ]; then
> >  	_notrun "Couldn't find e2fuzz"
> >  fi
> >  
> > diff --git a/tests/generic/128 b/tests/generic/128
> > index dfc67fd5..dc1d43f4 100755
> > --- a/tests/generic/128
> > +++ b/tests/generic/128
> > @@ -23,7 +23,7 @@ _scratch_mkfs >/dev/null 2>&1
> >  _scratch_mount "-o nosuid"
> >  
> >  mkdir $SCRATCH_MNT/nosuid
> > -cp `which ls` $SCRATCH_MNT
> > +cp "$(type -P ls)" $SCRATCH_MNT
> >  chmod 700 $SCRATCH_MNT/nosuid
> >  chmod 4755 $SCRATCH_MNT/ls
> >  
> > diff --git a/tests/generic/452 b/tests/generic/452
> > index ee4dfe9e..7cbd2dfa 100755
> > --- a/tests/generic/452
> > +++ b/tests/generic/452
> > @@ -26,7 +26,7 @@ _exclude_scratch_mount_option "noexec"
> >  _scratch_mkfs > $seqres.full 2>&1
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> > -LS=$(which ls --skip-alias --skip-functions)
> > +LS="$(type -P ls) --skip-alias --skip-functions)"
> 
> I think the "--skip-alias" and "--skip-functions" options are belong to
> the "which" command, so this change might cause fail.

Yay for command line parsing - invalid options are silently ignored
by which on debian, so this actual command does the same thing as
'which ls'....

Really, though, I think I'm just going to allow the path to find ls
in most cases - the only reason for using `which ls` was for tests
that use it as a file copy source. If 'ls' is not in the default
execution path, lots of stuff will not work...

> >  SCRATCH_LS=$SCRATCH_MNT/ls_on_scratch
> >  cp $LS $SCRATCH_LS

Oh, look, copying the ls binary is exactly what this test is
doing, so this would result in a cp failure...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
