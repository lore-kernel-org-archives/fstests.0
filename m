Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ADFC433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Mar 2022 22:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiCUXA0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiCUW6A (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2022 18:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D99474EDB
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 15:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE0056157D
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 22:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEE3C340E8;
        Mon, 21 Mar 2022 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647900817;
        bh=ZsN2oDQzRl6MOGBdqpR5d0rngeEVJlKk7l+6evdZdcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+V9IlcEaEEALFoHoUmCtiu/xWXHwVsJRmq+c7Uy2fJHIXNwGhs94aWcyd5QDOf7A
         xnwpGrNGy+dmVYN4c1RD62mY6s6XT+mUx8u6oJidBsCj44jA/U3Y2KKRmg5WHRI3wn
         D61rS62sk5MtDB9tg1pGx6Thq5DGUwd8ua3HyvdzaXZ0ohs6NgIRzxPkuXZ2R63kh5
         Tz80gczccmF1fsQs9aBJmLY8CZLLkcWgLfZpU5nUaOMKzTqiYS9qkY6Lz9BwUfGZCn
         67xm06kArUsgOsPXhLA9Q2dIpWis0mE8ShnuDX3GowdHP4S0ceOMe7uedwqsRnbizG
         t2krPgxBNXLOw==
Date:   Mon, 21 Mar 2022 15:13:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: maintainership of fstests
Message-ID: <20220321221336.GM8241@magnolia>
References: <Yjdmj0lVqCbbbjW8@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjdmj0lVqCbbbjW8@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 21, 2022 at 01:38:23AM +0800, Eryu Guan wrote:
> Hi folks,
> 
> It's almost 6 years since I've taken the maintainership of fstests, and
> I tried my best to keep the pace of weekly update, or at least bi-weekly
> update due to something like public holidays.
> 
> But it's been a month since last fstests update due to my personal
> urgent issues, and some patches got no review for more than one month.
> So I think it's time to re-consider the maintainership of fstests.
> 
> I will have less spare time in the foreseeable future, as I have to
> spend more time on my family, so it's hard to keep the weekly update
> pace. And six years is a long time, I think it's time to have a new
> maintainer.

Thank you for your service for all that time! :)

> Or we could go to the group-maintain way? As Darrick mentioned before
> (for xfs not fstests, if I recall correctly). Then we need a new primary
> maintainer :)
> 
> What do you think?

Splitting responsibility for maintenance doesn't seem like a huge step
to me -- for fs-specific tests, we need the developers for that fs to
review test changes.  Review for tests/generic/ can be done by the
fs{devel,*} community at large, much as it is done now.

The /difficult/ part, I think, is handling things like treewide
reorganizations, and integration testing the test suite.  That, I think,
is what really requires a primary maintainer who has broader visibility
into what's going on.

That primary maintainer also has to have time to run a build-and-test
farm of all the major fstests clients (ext*, xfs, btrfs, overlay, nfs,
what else?) to make sure that new code doesn't break existing
filesystems' ability to test themselves.

Granted, (speaking only for XFS, probably btrfs, and maybe even ext*),
we seem to notice regressions pretty fast when we download the weekly
release, so I think the primary maintainer's focus probably ought to be
more towards the non-mainstream Linux filesystems.

Also: over the past 6 years, I have /really/ enjoyed the fact that
fstests has small releases every 1-2 weeks as opposed to larger
infrequent drops.  It's a relief not to have to chase a merge window
like I do for the kernel.  Thank you a bunch for keeping that going!

--D

FYI: It's Spring Break here in the US, so you might not get much of a
response for a week or two.

> 
> Thanks,
> Eryu
> 
> P.S.
> I'll keep the maintainer role and do the review & update as usual until
> all things settle down.
