Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB63FC4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Aug 2021 22:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4761268
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Aug 2021 22:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhHUW7Y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 Aug 2021 18:59:24 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:52386 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhHUW7Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Aug 2021 18:59:24 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 142A080BC43;
        Sun, 22 Aug 2021 08:58:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mHZwm-003RQm-AJ; Sun, 22 Aug 2021 08:58:40 +1000
Date:   Sun, 22 Aug 2021 08:58:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/70: Use scratch device instead of test.
Message-ID: <20210821225840.GE2566745@dread.disaster.area>
References: <20210819131355.304528-1-nborisov@suse.com>
 <20210819150050.jweulrtgjeh57wac@fedora>
 <0b70908b-9b9f-d606-1d49-45bee40df1ea@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b70908b-9b9f-d606-1d49-45bee40df1ea@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8
        a=Ytqn3B1En7xDMI5LrH8A:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 19, 2021 at 05:56:31PM +0300, Nikolay Borisov wrote:
> 
> 
> On 19.08.21 г. 18:00, Zorro Lang wrote:
> > On Thu, Aug 19, 2021 at 04:13:55PM +0300, Nikolay Borisov wrote:
> >> At the end of the test the fsstress work dir is deleted, this suggests
> >> the test really requires a scratch device and not a test device. Change
> >> it accordingly.
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> ---
> > 
> > Hmm... is there any more specific reasons to explain why have to change this
> > TEST_DIR to SCRATCH_MNT? For example, this test hit ENOSPC in TEST_DIR, or
> > it takes too much time to remove $TEST_DIR/fsstress in _cleanup, or use
> > SCRATCH_DEV can cover more things, and so on. I think more specific reason
> > can help to push this patch be merged. After all there's not a rule says
> > if a case don't need to keep its work dir, then must use SCRATCH_DEV. Except
> > the maintainer is more inclined to accept that :)
> 
> None of the reasons above, I just thought that stuff in $TEST_DEV lives
> there so that it can simulate an 'aging' system. In this case this
> doesn't seem to be the reason for it as we delete everything.

That's most certainly aging the filesystem. Just because the test
deletes everything it wrote doesn't mean that the filesystem is
unchanged after the test runs. e.g. log structured or COW filesytems
can have very different structures at the end of the test, even
though the current view of the filesystem appears unchanged...

IOWs, tests that don't require a specific filesystem configuration
should be run on the test device, not the scratch device...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
