Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8AC3DA7D
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Jan 2023 21:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjACVbc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Jan 2023 16:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjACVbb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Jan 2023 16:31:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E615270
        for <fstests@vger.kernel.org>; Tue,  3 Jan 2023 13:31:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2955DB8111C
        for <fstests@vger.kernel.org>; Tue,  3 Jan 2023 21:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA4DC433F0;
        Tue,  3 Jan 2023 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672781487;
        bh=ztuM6h/3rF95QUH2M0sy07FbNouAKjz6aT/w0Wg6PoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SoFOHqK0Qo55+EU3//Op2fkHEJoZ3AkkuDtLISAtyOhAa7LXiJghWmDLpycyJZakA
         VCGaDtDjq36dEUZM6U8ZTw8bP7NwvnMTa+X4F7FWd35vc9/wdCjUld/AALLKR7HtYd
         Y/29X3L3zPv0f9pBs2Ou0B061xydWyEhv0KWFN2V5zjMC3DH5zXZfXPMrVKXpi4L7O
         86R+DRlMrm3hWXWXlhdyfUwrLhXzAenXLyzKi+1LcM675k/L5g7fG24Ab58jQVEO1E
         hu2BRQbm4ByrLLtqMgAJJ6lddS3SCiqkOCvqKFrOSG0MvkxTcDFWEvZkGq8aklp6KN
         NWFYurAlDi2pQ==
Date:   Tue, 3 Jan 2023 22:31:20 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] generic: update setgid tests
Message-ID: <20230103213120.ucutrjaoykl3dpht@wittgenstein>
References: <20230103-fstests-setgid-v6-2-v1-1-b8972c303ebe@kernel.org>
 <Y7RqOZK+liyY+RNY@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7RqOZK+liyY+RNY@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 03, 2023 at 09:47:37AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 03, 2023 at 04:28:20PM +0100, Christian Brauner wrote:
> > Over mutiple kernel releases we have reworked setgid inheritance
> > significantly due to long-standing security issues, security issues that
> > were reintroduced after they were fixed, and the subtle and difficult
> > inheritance rules that plagued individual filesystems. We have lifted
> > setgid inheritance into the VFS proper in earlier patches. Starting with
> > kernel v6.2 we have made setgid inheritance consistent between the write
> > and setattr (ch{mod,own}) paths.
> > 
> > The gist of the requirement is that in order to inherit the setgid bit
> > the user needs to be in the group of the file or have CAP_FSETID in
> > their user namespace. Otherwise the setgid bit will be dropped
> > irregardless of the file's executability. Change the tests accordingly
> > and annotate them with the commits that changed the behavior.
> > 
> > Note, that only with v6.2 setgid inheritance works correctly for
> > overlayfs in the write path. Before this the setgid bit was always
> > retained.
> > 
> > Link: https://lore.kernel.org/linux-ext4/CAOQ4uxhmCgyorYVtD6=n=khqwUc=MPbZs+y=sqt09XbGoNm_tA@mail.gmail.com
> > Link: https://lore.kernel.org/linux-fsdevel/20221212112053.99208-1-brauner@kernel.org
> > Link: https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Zorro Lang <zlang@redhat.com>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >  tests/generic/673     | 12 +++++++++---
> >  tests/generic/673.out |  8 ++++----
> >  tests/generic/683     | 11 ++++++++---
> >  tests/generic/683.out |  8 ++++----
> >  tests/generic/684     | 11 ++++++++---
> >  tests/generic/684.out |  8 ++++----
> >  tests/generic/685     | 11 ++++++++---
> >  tests/generic/685.out |  8 ++++----
> >  8 files changed, 49 insertions(+), 28 deletions(-)
> > 
> > diff --git a/tests/generic/673 b/tests/generic/673
> > index 6d1f49ea..1d8e4184 100755
> > --- a/tests/generic/673
> > +++ b/tests/generic/673
> > @@ -23,6 +23,12 @@ _require_scratch_reflink
> >  _scratch_mkfs >> $seqres.full
> >  _scratch_mount
> >  _require_congruent_file_oplen $SCRATCH_MNT 1048576
> > +
> > +# Due to multiple security issues and potential for subtle bugs around setgid
> > +# inheritance the rules in the write and chmod/chown paths have been made
> > +# consistent and are enforced by the VFS since kernel 6.2.
> > +_fixed_in_kernel_version "v6.2"
> 
> Uh... will this new behavior get ported to the LTS kernels too, or are

I plan on backporting this but I would like to wait for a little while
longer into the v6.2 cycle before doing this as everyone is just coming
out of the holiday season trying to catch up.

> we simply changing the kernel behavior here?

Yes, this is a behavioral change. I made sure to mention the risks and
reasons involved on the list along the patches and in the pull requests
that were merged.

> 
> Also, this patch does correct the new test failures that I saw as soon
> as I pulled 6.2-rc1, but it doesn't fix the finsert and fcollapse tests:

Indeed I have missed them because they were skipped:

generic/686       [not run] xfs_io finsert  failed (old kernel/wrong fs?)
generic/687       [not run] xfs_io fcollapse  failed (old kernel/wrong fs?)

I'll update the series accordingly. Thanks for pointing that out.

Christian
