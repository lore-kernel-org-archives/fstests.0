Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334C7C4743C
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Jun 2021 22:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF79C613AC
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Jun 2021 22:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFDWqP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Jun 2021 18:46:15 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:37773 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229746AbhFDWqP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Jun 2021 18:46:15 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 7348580B1BE;
        Sat,  5 Jun 2021 08:44:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lpIYC-00923N-Nh; Sat, 05 Jun 2021 08:44:24 +1000
Date:   Sat, 5 Jun 2021 08:44:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: add basic ftrace support
Message-ID: <20210604224424.GB2068689@dread.disaster.area>
References: <20210603062113.133326-1-wqu@suse.com>
 <20210604023547.GA2068689@dread.disaster.area>
 <af48b9a5-9f94-5b57-7115-e802faf50886@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af48b9a5-9f94-5b57-7115-e802faf50886@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=7-415B0cAAAA:8
        a=-usMa4jnQt85CIs3mAIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 04, 2021 at 10:45:52AM +0800, Qu Wenruo wrote:
> > So how does one enable all 500+ xfs tracepoints for this? Or just
> > some subset? i.e. how do we pass it a list of events like we do
> > trace-cmd?  IOWs, for this to be actually useful as a replacement
> > for trace-cmd, it has to be able to replace invocations like this:
> > 
> > # trace-cmd record -e xfs_i*lock* -e xfs_buf* -e printk -e iomap* ....
> 
> That's not a big problem, you can do the same thing just using tracefs
> interface, without invovling trace-cmd at all.
> 
> For your above case, you can do the same thing without trace_cmd at all:
> 
> # cat ${tracefs}/available_events | grep xfs_i*lock >> \
>   ${tracefs}/set_event
> # cat ${tracefs}/available_events | grep xfs_buf* >> \
>   ${tracefs}/set_event
> # cat ${tracefs}/available_events | grep iomap* >> \
>   ${tracefs}/set_event
> # cat ${tracefs}/available_events | grep printk >> \
>   ${tracefs}/set_event

....

You forgot that now I have to turn all the events off again
manually. And if the script crashes and doesn't clean up, then I've
got to do that manually.

Talk about going back to the dark ages....

> I mean, if you can use trace-cmd, I see now reason you can't pack your trace
> events into a small script to enable it before running the tests.

The whole point of using tools like perf and trace-cmd is so we
don't need to know how the underlying mechanisms work, and we don't
have to relearn this crap every time the developers decide they are
going to change how it works.

> Or is trace-cmd really making us forget how to manually setup ftrace
> evetnts?

You have got to be joking, right?

The whole point of trace-cmd and perf existing is so that nobody
except the developers of those tools need to know how the complex,
obscure, whacky low level kernel interfaces work. Nor do people have
to keep up with how they change from kernel to kernel, because the
tools abstract all this bullshit away from the user.

I forgot about that interface when trace-cmd was first written
(2009, IIRC). IOWs, I haven't used the low level tracing interfaces
at all for over a decade because it's an utter PITA to use.

Can you imaging saying to another developer "we don't need a mkfs
command because I can write the structures direct to the block
device myself!". It doesn't make much sense, does it? Yet that's
pretty much exactly what you are saying here....

So, no, I don't think poking at low level tracing interfaces inside
fstests is a good idea, especially as it also requires wrapping
fstests in more scripts to control it. Just use trace-cmd to control
trace recording like everyone else already does.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
