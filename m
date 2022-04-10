Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449B2C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Apr 2022 16:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiDJQRv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Apr 2022 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiDJQRv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Apr 2022 12:17:51 -0400
Received: from out20-61.mail.aliyun.com (out20-61.mail.aliyun.com [115.124.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C0A60CF4
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 09:15:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2192227|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.248951-0.00491397-0.746135;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=guan@eryu.me;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.NNrO4LK_1649607336;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.NNrO4LK_1649607336)
          by smtp.aliyun-inc.com(33.37.75.176);
          Mon, 11 Apr 2022 00:15:36 +0800
Date:   Mon, 11 Apr 2022 00:15:36 +0800
From:   Eryu Guan <guan@eryu.me>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Amir Goldstein <amir73il@gmail.com>, zlang@redhat.com
Subject: Re: maintainership of fstests
Message-ID: <YlMCqJj3Mllobfj4@desktop>
References: <Yjdmj0lVqCbbbjW8@desktop>
 <20220321221336.GM8241@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321221336.GM8241@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 21, 2022 at 03:13:36PM -0700, Darrick J. Wong wrote:
> On Mon, Mar 21, 2022 at 01:38:23AM +0800, Eryu Guan wrote:
> > Hi folks,
> > 
> > It's almost 6 years since I've taken the maintainership of fstests, and
> > I tried my best to keep the pace of weekly update, or at least bi-weekly
> > update due to something like public holidays.
> > 
> > But it's been a month since last fstests update due to my personal
> > urgent issues, and some patches got no review for more than one month.
> > So I think it's time to re-consider the maintainership of fstests.
> > 
> > I will have less spare time in the foreseeable future, as I have to
> > spend more time on my family, so it's hard to keep the weekly update
> > pace. And six years is a long time, I think it's time to have a new
> > maintainer.
> 
> Thank you for your service for all that time! :)
> 
> > Or we could go to the group-maintain way? As Darrick mentioned before
> > (for xfs not fstests, if I recall correctly). Then we need a new primary
> > maintainer :)
> > 
> > What do you think?
> 
> Splitting responsibility for maintenance doesn't seem like a huge step
> to me -- for fs-specific tests, we need the developers for that fs to
> review test changes.  Review for tests/generic/ can be done by the
> fs{devel,*} community at large, much as it is done now.

Agreed.

> 
> The /difficult/ part, I think, is handling things like treewide
> reorganizations, and integration testing the test suite.  That, I think,
> is what really requires a primary maintainer who has broader visibility
> into what's going on.

Agreed.

> 
> That primary maintainer also has to have time to run a build-and-test
> farm of all the major fstests clients (ext*, xfs, btrfs, overlay, nfs,
> what else?) to make sure that new code doesn't break existing
> filesystems' ability to test themselves.

Yes, that's what I did when I was at RH, I ran regression tests on all
major filesystems and on all major arches (x86_64 ppc64(le) aarch64)
before pushing new patches to git repo to make sure the new release is
in good shape.

And that's the problem for me now, as I don't have such machine resource
anymore.. And that's what Zorro has now :)

> 
> Granted, (speaking only for XFS, probably btrfs, and maybe even ext*),
> we seem to notice regressions pretty fast when we download the weekly
> release, so I think the primary maintainer's focus probably ought to be
> more towards the non-mainstream Linux filesystems.
> 
> Also: over the past 6 years, I have /really/ enjoyed the fact that
> fstests has small releases every 1-2 weeks as opposed to larger
> infrequent drops.  It's a relief not to have to chase a merge window
> like I do for the kernel.  Thank you a bunch for keeping that going!

Thanks for all the help and reviews all these years!

Thanks,
Eryu

> 
> --D
> 
> FYI: It's Spring Break here in the US, so you might not get much of a
> response for a week or two.
> 
> > 
> > Thanks,
> > Eryu
> > 
> > P.S.
> > I'll keep the maintainer role and do the review & update as usual until
> > all things settle down.
