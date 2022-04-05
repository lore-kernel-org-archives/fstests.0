Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B4C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Apr 2022 02:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiDECgS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Apr 2022 22:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiDECgR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Apr 2022 22:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4A34DDF8
        for <fstests@vger.kernel.org>; Mon,  4 Apr 2022 18:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F168961782
        for <fstests@vger.kernel.org>; Tue,  5 Apr 2022 00:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3FEC2BBE4;
        Tue,  5 Apr 2022 00:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649120245;
        bh=nUtX3hsL+g39Cdm56CwhMbxvIfRxPJsC5BsDO4cjYz0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=e7ps3t6Es3hdJlkSijh/WzZzKRlZo8yyX7TozgnSnK8ZVAaFQcgTiMk3MKDK2NayL
         0W2R/Smq0aTgzpn1gVXjXqHxL3UVukzOsIy1tqbupv/5893zrOScvgeQauVaWwBwt+
         ry2xndQwqUr8+lEJzwyuaVpPgyRFPLDhaz2Pj6JPDTmwaZkmeMgZH0Hos7qBTEEP0O
         h1lzaYa0vgOmFjs0oS2mBGzyXIBj1na1U7xkTMhMn9KFMC1qEIIPE9cEE/8gEfoCnq
         UXn0FrLyuGcgXUisVFWAYnhJ+fJtzSndt47fAF2A6QtBAeqaQqUV4oRWJVgTBNmdFa
         lqQA8khJeg58A==
Date:   Mon, 4 Apr 2022 17:57:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>, Eryu Guan <guaneryu@gmail.com>,
        fstests@vger.kernel.org
Subject: Re: maintainership of fstests
Message-ID: <20220405005724.GD27665@magnolia>
References: <Yjdmj0lVqCbbbjW8@desktop>
 <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
 <f73b9664-d3fc-0b95-e458-27860d87287a@sandeen.net>
 <20220404161544.oosbjrnw4muu6y3p@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404161544.oosbjrnw4muu6y3p@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 05, 2022 at 12:15:44AM +0800, Zorro Lang wrote:
> On Mon, Apr 04, 2022 at 10:36:01AM -0500, Eric Sandeen wrote:
> > On 3/21/22 11:19 AM, Zorro Lang wrote:
> > > On Mon, Mar 21, 2022 at 01:38:23AM +0800, Eryu Guan wrote:
> > >> Hi folks,
> > >>
> > >> It's almost 6 years since I've taken the maintainership of fstests, and
> > >> I tried my best to keep the pace of weekly update, or at least bi-weekly
> > >> update due to something like public holidays.
> > >>
> > >> But it's been a month since last fstests update due to my personal
> > >> urgent issues, and some patches got no review for more than one month.
> > >> So I think it's time to re-consider the maintainership of fstests.
> > >>
> > >> I will have less spare time in the foreseeable future, as I have to
> > >> spend more time on my family, so it's hard to keep the weekly update
> > >> pace. And six years is a long time, I think it's time to have a new
> > >> maintainer.
> > > 
> > > Hi Eryu,
> > > 
> > > By thinking about it a while, I get up my courage to apply this job, although I
> > > know I'm not the best one can handle this job. Just this project is really
> > > useful for my team. Nearly from I joined Red Hat, my jobs started to around the
> > > xfstests. It's a great testsuit, which can cover most of our testing. I felt
> > > relieved when you toke this maintainer, and admired your courage at that time,
> > > that really helps us a lot. No matter what you decide, thanks again for all your
> > > help, as previous colleague, as friend.
> > 
> > Hi Zorro - I'm sure that you would do well as a new maintainer, even if it
> > requires some learning. Every new challenge requires learning. :) If you are able
> > to balance it with your other tasks, I would be happy to see you take this on,
> > if it's something you want to do.
> > 
> > (See also Darrick's suggestion that maintainer tasks could be split up a bit,
> > across the different filesystems.)
> 
> Thanks for your trust, Eric. As you said, it'll be a challenge to me, but I'll try
> my best if I can have this opportunity.

Go for it!!!!1!!

--D

> Thanks,
> Zorro
> 
> > 
> > Thanks,
> > -Eric
> > 
> > > Thanks,
> > > Zorro
> > > 
> > >>
> > >> Or we could go to the group-maintain way? As Darrick mentioned before
> > >> (for xfs not fstests, if I recall correctly). Then we need a new primary
> > >> maintainer :)
> > >>
> > >> What do you think?
> > >>
> > >> Thanks,
> > >> Eryu
> > >>
> > >> P.S.
> > >> I'll keep the maintainer role and do the review & update as usual until
> > >> all things settle down.
> > >>
> > > 
> > 
> 
