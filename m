Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E4EC3DA7D
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Jan 2023 00:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjADAMM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Jan 2023 19:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjADAMM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Jan 2023 19:12:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B413EB0
        for <fstests@vger.kernel.org>; Tue,  3 Jan 2023 16:12:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 366A861531
        for <fstests@vger.kernel.org>; Wed,  4 Jan 2023 00:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA67C433D2;
        Wed,  4 Jan 2023 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672791129;
        bh=/whrhX2xNUMUPROK9ryjTo9BeXP72e3uVAviJX+BfJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTDpo745XcPG3TLRGiQOy4ddU+rm9SGC0WsvLnO/HqNlErbwJf0vS9EsRYNo0Cs2t
         QQbb0Zxx/VvEx2e7SuBbqqv76OUCRBkDj17PQyGUZD1GIAdJMZoMqwmXFS1gxN/u4H
         PwJyw8r0kOdIM01GmceXLnj1vck7BSRh1Tjf0saaBvsb9r9BkOXeAx4wGGMBUgXcJr
         f8jPtrRJCl08HCRUxAkpm9ZHzBSxfVhOR4DzKB4hK8cXkH2/XmEsTZJ3yfrBmfMStc
         D9zHBAff1uUiqcbVWXOTxnb/LhoKAgTY/um8uTdw+PLqcJiy3OiLBTI5DiuAI9d1e2
         OnR5SmOam3MMA==
Date:   Tue, 3 Jan 2023 16:12:09 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] generic: update setgid tests
Message-ID: <Y7TEWaqOyTR1rJoA@magnolia>
References: <20230103-fstests-setgid-v6-2-v1-1-b8972c303ebe@kernel.org>
 <Y7RqOZK+liyY+RNY@magnolia>
 <20230103213120.ucutrjaoykl3dpht@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103213120.ucutrjaoykl3dpht@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 03, 2023 at 10:31:20PM +0100, Christian Brauner wrote:
> On Tue, Jan 03, 2023 at 09:47:37AM -0800, Darrick J. Wong wrote:
> > On Tue, Jan 03, 2023 at 04:28:20PM +0100, Christian Brauner wrote:
> > > Over mutiple kernel releases we have reworked setgid inheritance
> > > significantly due to long-standing security issues, security issues that
> > > were reintroduced after they were fixed, and the subtle and difficult
> > > inheritance rules that plagued individual filesystems. We have lifted
> > > setgid inheritance into the VFS proper in earlier patches. Starting with
> > > kernel v6.2 we have made setgid inheritance consistent between the write
> > > and setattr (ch{mod,own}) paths.
> > > 
> > > The gist of the requirement is that in order to inherit the setgid bit
> > > the user needs to be in the group of the file or have CAP_FSETID in
> > > their user namespace. Otherwise the setgid bit will be dropped
> > > irregardless of the file's executability. Change the tests accordingly
> > > and annotate them with the commits that changed the behavior.
> > > 
> > > Note, that only with v6.2 setgid inheritance works correctly for
> > > overlayfs in the write path. Before this the setgid bit was always
> > > retained.
> > > 
> > > Link: https://lore.kernel.org/linux-ext4/CAOQ4uxhmCgyorYVtD6=n=khqwUc=MPbZs+y=sqt09XbGoNm_tA@mail.gmail.com
> > > Link: https://lore.kernel.org/linux-fsdevel/20221212112053.99208-1-brauner@kernel.org
> > > Link: https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Zorro Lang <zlang@redhat.com>
> > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > ---
> > >  tests/generic/673     | 12 +++++++++---
> > >  tests/generic/673.out |  8 ++++----
> > >  tests/generic/683     | 11 ++++++++---
> > >  tests/generic/683.out |  8 ++++----
> > >  tests/generic/684     | 11 ++++++++---
> > >  tests/generic/684.out |  8 ++++----
> > >  tests/generic/685     | 11 ++++++++---
> > >  tests/generic/685.out |  8 ++++----
> > >  8 files changed, 49 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/tests/generic/673 b/tests/generic/673
> > > index 6d1f49ea..1d8e4184 100755
> > > --- a/tests/generic/673
> > > +++ b/tests/generic/673
> > > @@ -23,6 +23,12 @@ _require_scratch_reflink
> > >  _scratch_mkfs >> $seqres.full
> > >  _scratch_mount
> > >  _require_congruent_file_oplen $SCRATCH_MNT 1048576
> > > +
> > > +# Due to multiple security issues and potential for subtle bugs around setgid
> > > +# inheritance the rules in the write and chmod/chown paths have been made
> > > +# consistent and are enforced by the VFS since kernel 6.2.
> > > +_fixed_in_kernel_version "v6.2"
> > 
> > Uh... will this new behavior get ported to the LTS kernels too, or are
> 
> I plan on backporting this but I would like to wait for a little while
> longer into the v6.2 cycle before doing this as everyone is just coming
> out of the holiday season trying to catch up.
> 
> > we simply changing the kernel behavior here?
> 
> Yes, this is a behavioral change. I made sure to mention the risks and
> reasons involved on the list along the patches and in the pull requests
> that were merged.

<nod> Ok.  I'm cool with this so long as everyone else seems to be. :)

> > Also, this patch does correct the new test failures that I saw as soon
> > as I pulled 6.2-rc1, but it doesn't fix the finsert and fcollapse tests:
> 
> Indeed I have missed them because they were skipped:
> 
> generic/686       [not run] xfs_io finsert  failed (old kernel/wrong fs?)
> generic/687       [not run] xfs_io fcollapse  failed (old kernel/wrong fs?)
> 
> I'll update the series accordingly. Thanks for pointing that out.

Ok, thank you!  And really thank you for digging through the hairy
setgid inheritance mess. :)

--D

> Christian
