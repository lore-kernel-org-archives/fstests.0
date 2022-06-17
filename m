Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D10C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jun 2022 22:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346517AbiFQWYJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbiFQWYJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jun 2022 18:24:09 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B0556160C
        for <fstests@vger.kernel.org>; Fri, 17 Jun 2022 15:24:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 83D8B5EE588;
        Sat, 18 Jun 2022 08:24:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o2KNp-007tLE-Vi; Sat, 18 Jun 2022 08:24:06 +1000
Date:   Sat, 18 Jun 2022 08:24:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix input value to _scratch_mkfs_sized
Message-ID: <20220617222405.GA1098723@dread.disaster.area>
References: <20220616043845.14320-1-lan@suse.com>
 <20220617035836.GZ1098723@dread.disaster.area>
 <20220617175212.f5pikh6zdgud2qjl@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617175212.f5pikh6zdgud2qjl@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62acff07
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=7-415B0cAAAA:8
        a=xz4hthnDoRxUTMzA-d4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jun 18, 2022 at 01:52:12AM +0800, Zorro Lang wrote:
> On Fri, Jun 17, 2022 at 01:58:36PM +1000, Dave Chinner wrote:
> > On Thu, Jun 16, 2022 at 12:38:43PM +0800, An Long wrote:
> > > Function _scratch_mkfs_sized cannot recognize the size descriptor.
> > > 
> > > For example, we set MKFS_OPTIONS="-b 4k" and then run generic/416 on
> > > ext4, will fail with "mkfs.ext4: invalid block size - 4".
> > 
> > So isn't the correct fix for this to use the correct format in
> > MKFS_OPTIONS? ie. "-b 4096"?
> > 
> > i.e. why do we need ito add code to fix something that the user must
> > specify themselves and could easily just use an integer to begin
> > with?
> 
> The fstests doesn't notice users that they *must* use pure number in
> MKFS_OPTIONS, especially the block size.

So why not just document the requirement? I mean,
_mkfs_scratch_sized is documented to take the size in bytes primarly
because some mkfs binaries only suport bytes and not shortform human
numbers. We did that because it was seen that consistency in all the
tests of using byte counts was much preferable to having a random
smattering of different units. It's much easier to programatically
calculate the size if it is in bytes, and that results in simpler
and easier to understand code.

The main issue I have here is that we need to reduce the overhead of
setting up every test - adding more complex parameter parsing to
_scratch_mkfs_sized means every test that calls it now takes just a
little bit longer to run. That's about a 100 tests that now take
just a little longer to run, meaning fstests takes a few seconds
more to run.

Every "lets make this pretty parsing" or "lets do complex parsing"
change that replaces a simple, straight forward integer or construct
adds bloat, overhead and runtime. It's a death-by-a-thousand-cuts
scenario - each individual change can be justified, but suddenly
we've adding another 15 minutes of runtime to fstests even for
people who require/use none of that functionality.

Bloat, overhead and runtime are the three main things we
need to remove from fstests, so I feel that the right thing to do is
document that sizes for filesystems, block sizes, etc must always be
in integer units rather than adding code to "be flexible".

> As this issue, we have to accept the size unit(k/m/g ...) or have to
> tell the users that they must use pure integer, any of "k/m/g" is
> unacceptable. I prefer the former, so I'd like to have this change,
> except anyone has a better idea :)

I'd much prefer we document the existing behaviour rather than add
more complexity and overhead....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
