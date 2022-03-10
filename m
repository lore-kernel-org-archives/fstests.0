Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D6FC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Mar 2022 01:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiCJBmn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiCJBmm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Mar 2022 20:42:42 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D93071275D1
        for <fstests@vger.kernel.org>; Wed,  9 Mar 2022 17:41:42 -0800 (PST)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4906010E2BEC;
        Thu, 10 Mar 2022 12:41:40 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nS7oB-003bhG-DU; Thu, 10 Mar 2022 12:41:39 +1100
Date:   Thu, 10 Mar 2022 12:41:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, Sun Ke <sunke32@huawei.com>, guan@eryu.me,
        fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] generic/066: attr1 is still there after log
 replay on f2fs
Message-ID: <20220310014139.GZ3927073@dread.disaster.area>
References: <20220228035719.4102745-1-sunke32@huawei.com>
 <cd2a245e-b9d2-c09c-0f8c-a7ca9157ca9f@oppo.com>
 <20220309062223.GY3927073@dread.disaster.area>
 <0a5c5efd-597e-7d13-9008-195cf6cf83f1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5c5efd-597e-7d13-9008-195cf6cf83f1@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62295756
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=i0EeH86SAAAA:8 a=7-415B0cAAAA:8
        a=NuAcnk6cltMIAt2ZYeMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 09, 2022 at 03:34:27PM +0800, Chao Yu wrote:
> On 2022/3/9 14:22, Dave Chinner wrote:
> > On Wed, Mar 09, 2022 at 12:31:17PM +0800, Chao Yu wrote:
> > > On 2022/2/28 11:57, Sun Ke via Linux-f2fs-devel wrote:
> > > > The test fail on f2fs:
> > > >        xattr names and values after second fsync log replay:
> > > >        # file: SCRATCH_MNT/foobar
> > > >       +user.attr1="val1"
> > > >        user.attr3="val3"
> > > > 
> > > > attr1 is still there after log replay.
> > > > I guess it is f2fs's special feature to improve the performance.
> > > > 
> > > > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > > > ---
> > > > 
> > > > Is it a BUG on f2fs?
> > > 
> > > I don't think so, it fails due to f2fs doesn't follow recovery rule which
> > > btrfs/ext4/xfs does, but it doesn't mean f2fs has break posix semantics of
> > > fsync().
> > 
> > I disagree.  A failure in this test is indicative of non-conformance
> > with the Linux definition of fsync() behaviour.
> > 
> > You are right in that it does not break POSIX fsync semantics, but
> > POSIX allows "do nothing" as a valid implementation. However,
> > because of this loophole, the POSIX definition is complete garbage
> > and we do not use it.
> > 
> > That behaviour that Linux filesytsems are supposed to implement is
> > defined in the Linux fsync() man page, and it goes way beyond what
> > POSIX requires:
> > 
> > $ man fsync
> > ....
> > DESCRIPTION
> >      fsync() transfers ("flushes") all modified in-core data of
> >      (i.e., modified buffer cache pages for) the file referred to by
> >      the file descriptor fd to the disk device (or other permanent
> >      storage device) so that all changed information can be retrieved
> >      even if the  system  crashes  or  is rebooted.  This includes
> >      writing through or flushing a disk cache if present.  The call
> >      blocks until the device reports that the transfer has
> >      completed.
> > 
> >      As well as flushing the file data, fsync() also flushes the
> >      metadata information associated with the file (see inode(7)).
> > ....
> > 
> > IOWs, fsync() on Linux is supposed to persist all data and
> > metadata associated with the inode to stable storage such that it
> > can be retreived after a crash or reboot. "metadata information"
> > includes xattrs attached to the inode that is being fsync()d.
> 
> Quoted from g/066:
> 
> echo "hello world!" >> $SCRATCH_MNT/foobar
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
> $SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar
> ln $SCRATCH_MNT/foobar $SCRATCH_MNT/foobar_link
> touch $SCRATCH_MNT/qwerty
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/qwerty
> 
> IIUC, to match what Linux fsync() manual restricts, if we want to persist the
> xattr removal, we should call fsync() on $SCRATCH_MNT/foobar after
> "$SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar"? rather than calling fsync()
> on unrelated $SCRATCH_MNT/qwerty.

It might look that way, but it's not that straight forward: there's
a carefully constructed object dependency chain in this test that
defines what the correct behaviour should be here.

What's the link count of $SCRATCH_MNT/foobar when
$SCRATCH_MNT/qwerty is present after recovery? Is it 1 or 2?  Does
$SCRATCH_MNT/foobar_link exist?  And if $SCRATCH_MNT/foobar_link
exists, and the link count is 2. The test doesn't even look at these
things, but if user.attr1 is not present, it means that foobar_link
and qwerty are present, $SCRATCH_MNT has a link count of 5 and
foobar has a link count of 2 because that's the dependency chain
that leads to the user.attr1 removal being recovered correctly.

So what does SCRATCH_MNT actually contain when f2fs fails this test?

These depedencies exist because we can't just randomly re-order
recovery of modifications to individual inodes and certain
operations create atomic change dependencies between inodes. It's
those atomic change dependencies that this test is actually
exercising.  i.e. the link count changes tie directory modifications
to inode modifications and this creates cross-object ordering
dependencies down the line that fsync then exposes. That's what the
second part of this test is actually exercising....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
