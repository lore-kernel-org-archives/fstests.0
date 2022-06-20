Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4FFC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 23:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbiFTXOq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348221AbiFTXOR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 19:14:17 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8064A26550
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 16:12:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1EF005ECB75;
        Tue, 21 Jun 2022 09:12:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o3QZJ-0095XD-Dt; Tue, 21 Jun 2022 09:12:29 +1000
Date:   Tue, 21 Jun 2022 09:12:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix input value to _scratch_mkfs_sized
Message-ID: <20220620231229.GD1098723@dread.disaster.area>
References: <20220616043845.14320-1-lan@suse.com>
 <20220617035836.GZ1098723@dread.disaster.area>
 <20220617175212.f5pikh6zdgud2qjl@zlang-mailbox>
 <20220617222405.GA1098723@dread.disaster.area>
 <20220618031413.j6pgaucpinl5csc5@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618031413.j6pgaucpinl5csc5@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62b0fedf
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=7-415B0cAAAA:8
        a=GOA6u4ec4UHg7Z0lS2EA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jun 18, 2022 at 11:14:13AM +0800, Zorro Lang wrote:
> On Sat, Jun 18, 2022 at 08:24:05AM +1000, Dave Chinner wrote:
> > On Sat, Jun 18, 2022 at 01:52:12AM +0800, Zorro Lang wrote:
> > > On Fri, Jun 17, 2022 at 01:58:36PM +1000, Dave Chinner wrote:
> > > > On Thu, Jun 16, 2022 at 12:38:43PM +0800, An Long wrote:
> > > > > Function _scratch_mkfs_sized cannot recognize the size descriptor.
> > > > > 
> > > > > For example, we set MKFS_OPTIONS="-b 4k" and then run generic/416 on
> > > > > ext4, will fail with "mkfs.ext4: invalid block size - 4".
> > > > 
> > > > So isn't the correct fix for this to use the correct format in
> > > > MKFS_OPTIONS? ie. "-b 4096"?
> > > > 
> > > > i.e. why do we need ito add code to fix something that the user must
> > > > specify themselves and could easily just use an integer to begin
> > > > with?
> > > 
> > > The fstests doesn't notice users that they *must* use pure number in
> > > MKFS_OPTIONS, especially the block size.
> > 
> > So why not just document the requirement? I mean,
> > _mkfs_scratch_sized is documented to take the size in bytes primarly
> > because some mkfs binaries only suport bytes and not shortform human
> > numbers. We did that because it was seen that consistency in all the
> > tests of using byte counts was much preferable to having a random
> > smattering of different units. It's much easier to programatically
> > calculate the size if it is in bytes, and that results in simpler
> > and easier to understand code.
> > 
> > The main issue I have here is that we need to reduce the overhead of
> > setting up every test - adding more complex parameter parsing to
> > _scratch_mkfs_sized means every test that calls it now takes just a
> > little bit longer to run. That's about a 100 tests that now take
> > just a little longer to run, meaning fstests takes a few seconds
> > more to run.
> 
> Oh, so that's what's your really worry about. Understand. But will this
> change takes that long time? If the user still use pure integer as usual,
> it'll through:
> 
>     elif [[ $str =~ ^[0-9]+$ ]] ; then
>             size=$str
> 
> then return directly, won't through those complex calculation.

It's still additional unnecessary overhead to be adding to
_mkfs_scratch_sized as user supplied MKFS_OPTIONS do not change from
test to test.  So why do we even want to do this verification every
time _mkfs_scratch_sized is run?  Look at the *big picture*, not the
individual test context . Validate the user supplied MKFS_OPTIONS
once at startup, not every time _mkfs_scratch_sized is run!

And looking at the big picture, we have a bunch of scratch_mkfs
operations that take byte counts.  _scratch_mkfs_geom that takes
stripe aligment parameters in bytes, _scratch_mkfs_blocksized that
takes block size in bytes, _mkfs_scratch_sized that takes the fs
size (and block size) in bytes, etc.

Bytes as an integer count  is the common unit across all tests,
filesystems and APIs. We can do math directly on them, we don't need
to care if different filesystems support some form of human readable
or not (e.g. some filesystems will recognise "k" but not "K" for
kilobytes), etc.

So if you've going to actually support human readable units for byte
values, think through the consequences of doing that. Think about
the difficultly that then poses for tests that are written as

_mkfs_scratch_sized 1G

and now someone else comes along, needs to modify the test and do
calculations based on the size of the filesystem. Do we expect the
test to now have string parsing in it to convert the filesystem size
to an integer for this new functionality? Or do we then have to
convert every part of the test to use byte units instead of human
units before making the modification? Either way, it adds more work
to future changes than the amount of tiem and work it might save
now.

Hence to me, the big picture implications of allowing human readable
units in fstests code and configs just does not add up to be a net
positive.

> So if we don't merge this patchset. I'd like to make something wrong to
> remind that "must use pure integer in MKFS_OPTIONS". What do you think?

IMO, a single validation check after section config loading in check
is all that is necessary....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
