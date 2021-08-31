Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85C5C432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 23:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9397160E98
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 23:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhHaXuC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Aug 2021 19:50:02 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:39810 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234555AbhHaXuB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Aug 2021 19:50:01 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 1A1BB1B922F;
        Wed,  1 Sep 2021 09:49:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mLDUx-007Fj7-9L; Wed, 01 Sep 2021 09:48:59 +1000
Date:   Wed, 1 Sep 2021 09:48:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: which has been deprecated by Debian
Message-ID: <20210831234859.GJ2566745@dread.disaster.area>
References: <20210830011401.697295-1-david@fromorbit.com>
 <20210830171952.GA9911@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830171952.GA9911@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=M6AA-ViiZXM12Ji9B2sA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 30, 2021 at 10:19:52AM -0700, Darrick J. Wong wrote:
> > Subject: [PATCH] fstests: which has been deprecated by Debian
> 
> fstests has been deprecated by Debian?  daaaang. ;)
> 
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
> 
> Given that FHS 3.0 section 3.4.2 requires ls to be in /bin, can we
> hardcode this into these tests?

For the binary copying, I'll just leave it like this. For all
others, I'll just leave the path to find the ls binary.

> > diff --git a/tests/xfs/293 b/tests/xfs/293
> > index fbd26b63..20f8c486 100755
> > --- a/tests/xfs/293
> > +++ b/tests/xfs/293
> > @@ -30,7 +30,7 @@ case "$MANPAGE" in
> >  *)		CAT=cat;;
> >  esac
> >  
> > -_require_command `which $CAT` $CAT
> > +_require_command "$(type -P $CAT)" $CAT
> 
> Same thing with cat.

Except $CAT might be something other than "cat" here. i.e.:

case "$MANPAGE" in
*.gz|*.z\|*.Z)  CAT=zcat;;
*.bz2)          CAT=bzcat;;
*.xz)           CAT=xzcat;;
*)              CAT=cat;;
esac

_require_command "$(type -P $CAT)" $CAT

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
