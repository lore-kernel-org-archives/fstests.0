Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CAEC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Mar 2022 06:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiCIGX1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Mar 2022 01:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiCIGX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Mar 2022 01:23:26 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B55BDD2
        for <fstests@vger.kernel.org>; Tue,  8 Mar 2022 22:22:27 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7451410E2642;
        Wed,  9 Mar 2022 17:22:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nRpiJ-003Hra-EV; Wed, 09 Mar 2022 17:22:23 +1100
Date:   Wed, 9 Mar 2022 17:22:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chao Yu <chao.yu@oppo.com>
Cc:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org, guan@eryu.me,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] generic/066: attr1 is still there after log
 replay on f2fs
Message-ID: <20220309062223.GY3927073@dread.disaster.area>
References: <20220228035719.4102745-1-sunke32@huawei.com>
 <cd2a245e-b9d2-c09c-0f8c-a7ca9157ca9f@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2a245e-b9d2-c09c-0f8c-a7ca9157ca9f@oppo.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=622847a1
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=i0EeH86SAAAA:8 a=7-415B0cAAAA:8
        a=9GbEHPOvS_M6fQiB5JEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 09, 2022 at 12:31:17PM +0800, Chao Yu wrote:
> On 2022/2/28 11:57, Sun Ke via Linux-f2fs-devel wrote:
> > The test fail on f2fs:
> >       xattr names and values after second fsync log replay:
> >       # file: SCRATCH_MNT/foobar
> >      +user.attr1="val1"
> >       user.attr3="val3"
> > 
> > attr1 is still there after log replay.
> > I guess it is f2fs's special feature to improve the performance.
> > 
> > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > ---
> > 
> > Is it a BUG on f2fs?
> 
> I don't think so, it fails due to f2fs doesn't follow recovery rule which
> btrfs/ext4/xfs does, but it doesn't mean f2fs has break posix semantics of
> fsync().

I disagree.  A failure in this test is indicative of non-conformance
with the Linux definition of fsync() behaviour.

You are right in that it does not break POSIX fsync semantics, but
POSIX allows "do nothing" as a valid implementation. However,
because of this loophole, the POSIX definition is complete garbage
and we do not use it.

That behaviour that Linux filesytsems are supposed to implement is
defined in the Linux fsync() man page, and it goes way beyond what
POSIX requires:

$ man fsync
....
DESCRIPTION
    fsync() transfers ("flushes") all modified in-core data of
    (i.e., modified buffer cache pages for) the file referred to by
    the file descriptor fd to the disk device (or other permanent
    storage device) so that all changed information can be retrieved
    even if the  system  crashes  or  is rebooted.  This includes
    writing through or flushing a disk cache if present.  The call
    blocks until the device reports that the transfer has
    completed.

    As well as flushing the file data, fsync() also flushes the
    metadata information associated with the file (see inode(7)).
....

IOWs, fsync() on Linux is supposed to persist all data and
metadata associated with the inode to stable storage such that it
can be retreived after a crash or reboot. "metadata information"
includes xattrs attached to the inode that is being fsync()d.

*fdatasync()* does not require xattrs to be persisted unless
they are needed to retreive data, but that's not what g/066 is
exercising.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
