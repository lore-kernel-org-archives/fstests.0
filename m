Return-Path: <SRS0=q2aQ=AX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032DCC433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Jul 2020 23:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCBA20575
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Jul 2020 23:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGLXy2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:54:28 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:58489 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727932AbgGLXy2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Jul 2020 19:54:28 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 01A6E1A8A08;
        Mon, 13 Jul 2020 09:54:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1julnY-0000y1-QW; Mon, 13 Jul 2020 09:54:20 +1000
Date:   Mon, 13 Jul 2020 09:54:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: add CLI option to repeat tests
Message-ID: <20200712235420.GI5369@dread.disaster.area>
References: <20200708053513.3259990-1-david@fromorbit.com>
 <20200708081518.4oqe4menrpifbags@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708081518.4oqe4menrpifbags@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=qj677rFPGuqeTe_-rXgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 08, 2020 at 10:15:18AM +0200, Lukas Czerner wrote:
> On Wed, Jul 08, 2020 at 03:35:13PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Frequently when trying to reproduce a problem I want to run a set of
> > specific tests in a loop, over and over again. I run fstests from a
> > set of run scripts that have non-trivial overhead (e.g. patterning
> > block devices before the runs start), so if all I want to do is run
> > the same test 100x, using a shell loop over the entire run
> > scripts reduces the iteration rate substantially.
> > 
> > Hence add an option to check to allow fstests to loop a number of
> > times over the configured test set without stopping.
> 
> Hi Dave,
> 
> this is useful as I am often doing the same. However what I am really
> missing is the ability to end the loop when a test fails and the ability
> to run tests in infinite loop (or until the test fails).

To run until a test set fails, I have just been using "-i 10000"
because if it passes 10000 loops, it isn't going to fail.. :)

Hence I didn't see a need to complicate things with a specific
"loop forever" options.

> It should be easy modification to make, what do you think ?

Feel free to add send a patch on top of this one to support that -
all of the failures I've been looking at with this have been "test
does not complete" failures, so it wasn't important to me.

As it is, right now I don't have time to feature creep simple
modifications like this into more complex functionality - I really
only sent this out because Willy mentioned on #xfs that he wished
there was a way to loop a test and I said "I've got a patch on my
local tree for that"....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
