Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B96EC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Apr 2022 18:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiDJSPv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Apr 2022 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiDJSPv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Apr 2022 14:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC560DB7
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 11:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C194A611B5
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 18:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D299C385A1;
        Sun, 10 Apr 2022 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649614419;
        bh=B2/guWRvKqPQzrIkNotqR7yK0rx65Cc2jnmQn3FpWbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXk02RuqNakQ5YfgbGJBBotgJMrS4Ztfr+sM659D0s7vvvZQ/uM3SkXue1FqjJPiX
         onjucSnggHUQGVDO2rySgT4X0rWnFDRfOHAorLu0l1KPHjMVq63cpPHUk0L51IRN5Z
         7jhgo8B7ku3InsXrV3n8bFyaxqOH/UX0kOKycvtRc7c6rPGs7IFTwDkNzUxfI78awS
         RlecS5y9wPSrFo9iJkiiS83P9HXQLFpJ4P36Aysj+YP66291pwYCnIZ8NhjgfTk/w5
         wR+lbdeisW9iNiOBgTuhmdzJG1AuCP5fPOwdVNMrVxAbEQLTICGgrHg4t5kA8Aj7WC
         vj2MtilqQizvQ==
Date:   Sun, 10 Apr 2022 11:13:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eryu Guan <guan@eryu.me>
Cc:     zlang@redhat.com, fstests@vger.kernel.org
Subject: Re: maintainership of fstests
Message-ID: <20220410181338.GA55404@magnolia>
References: <Yjdmj0lVqCbbbjW8@desktop>
 <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
 <YlMErDRHygqXFKGU@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlMErDRHygqXFKGU@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 11, 2022 at 12:24:12AM +0800, Eryu Guan wrote:
> On Tue, Mar 22, 2022 at 12:19:35AM +0800, Zorro Lang wrote:
> > On Mon, Mar 21, 2022 at 01:38:23AM +0800, Eryu Guan wrote:
> > > Hi folks,
> > > 
> > > It's almost 6 years since I've taken the maintainership of fstests, and
> > > I tried my best to keep the pace of weekly update, or at least bi-weekly
> > > update due to something like public holidays.
> > > 
> > > But it's been a month since last fstests update due to my personal
> > > urgent issues, and some patches got no review for more than one month.
> > > So I think it's time to re-consider the maintainership of fstests.
> > > 
> > > I will have less spare time in the foreseeable future, as I have to
> > > spend more time on my family, so it's hard to keep the weekly update
> > > pace. And six years is a long time, I think it's time to have a new
> > > maintainer.
> > 
> > Hi Eryu,
> > 
> > By thinking about it a while, I get up my courage to apply this job, although I
> 
> Glad to hear that! I'm sure you can do it well!
> 
> I'll talk to you to see how to make the transfor of maintainer go smoothly.

Yeah... if you already have a kernel.org account, then you can ignore
the rest of this email. :P

First you'll need a *stable* email service of some kind -- this
MicXXXXXX crap that increasing numbers of us are being forced to use by
corporate IT is not going to cut it.  Contributing to the gmXXX-vger
mail delay swamp isn't great either. :/

Then you'll need to create a PGP key and get enough of us who already
have kernel.org accounts (Eryu, dchinner, me, sandeen, hch, etc.) to
sign it to convince the kernel.org admins that you're legit; and so that
you can push signed tags to the git tree.  I didn't get any hits in
pgp.mit.edu or the kernel keysigning map, so I'm presuming you don't
already have one...

In the old days a signing party was easy enough when we could do that in
person at LSFMM/LinuxCon/etc, but now ... I don't know what the
verification process is.

Next you'll want a kernel.org account so that you can push branches to
git.kernel.org.  You'll also have to ask them to add you to the group
that has write access to the fstests repo:
https://korg.docs.kernel.org/accounts.html

In the meantime, if you need help pushing branches, I think at least
Eric, Dave, and I all should still have write access.

Anyways, welcome Zorro!

--D

> Thanks,
> Eryu
> 
> > know I'm not the best one can handle this job. Just this project is really
> > useful for my team. Nearly from I joined Red Hat, my jobs started to around the
> > xfstests. It's a great testsuit, which can cover most of our testing. I felt
> > relieved when you toke this maintainer, and admired your courage at that time,
> > that really helps us a lot. No matter what you decide, thanks again for all your
> > help, as previous colleague, as friend.
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Or we could go to the group-maintain way? As Darrick mentioned before
> > > (for xfs not fstests, if I recall correctly). Then we need a new primary
> > > maintainer :)
> > > 
> > > What do you think?
> > > 
> > > Thanks,
> > > Eryu
> > > 
> > > P.S.
> > > I'll keep the maintainer role and do the review & update as usual until
> > > all things settle down.
> > > 
> > 
