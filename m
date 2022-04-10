Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D888C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Apr 2022 16:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbiDJQ0d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Apr 2022 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbiDJQ0b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Apr 2022 12:26:31 -0400
Received: from out20-37.mail.aliyun.com (out20-37.mail.aliyun.com [115.124.20.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63822D5F
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 09:24:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1128573|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.178855-0.026402-0.794743;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.NNrV.Iw_1649607852;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.NNrV.Iw_1649607852)
          by smtp.aliyun-inc.com(33.37.67.126);
          Mon, 11 Apr 2022 00:24:12 +0800
Date:   Mon, 11 Apr 2022 00:24:12 +0800
From:   Eryu Guan <guan@eryu.me>
To:     zlang@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: maintainership of fstests
Message-ID: <YlMErDRHygqXFKGU@desktop>
References: <Yjdmj0lVqCbbbjW8@desktop>
 <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 22, 2022 at 12:19:35AM +0800, Zorro Lang wrote:
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
> Hi Eryu,
> 
> By thinking about it a while, I get up my courage to apply this job, although I

Glad to hear that! I'm sure you can do it well!

I'll talk to you to see how to make the transfor of maintainer go smoothly.

Thanks,
Eryu

> know I'm not the best one can handle this job. Just this project is really
> useful for my team. Nearly from I joined Red Hat, my jobs started to around the
> xfstests. It's a great testsuit, which can cover most of our testing. I felt
> relieved when you toke this maintainer, and admired your courage at that time,
> that really helps us a lot. No matter what you decide, thanks again for all your
> help, as previous colleague, as friend.
> 
> Thanks,
> Zorro
> 
> > 
> > Or we could go to the group-maintain way? As Darrick mentioned before
> > (for xfs not fstests, if I recall correctly). Then we need a new primary
> > maintainer :)
> > 
> > What do you think?
> > 
> > Thanks,
> > Eryu
> > 
> > P.S.
> > I'll keep the maintainer role and do the review & update as usual until
> > all things settle down.
> > 
> 
