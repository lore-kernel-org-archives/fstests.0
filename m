Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1396C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Apr 2022 05:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiDKFdy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Apr 2022 01:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiDKFdx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2022 01:33:53 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 777D129C82
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 22:31:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C2B3153DA3C;
        Mon, 11 Apr 2022 15:31:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ndmeF-00GJem-HT; Mon, 11 Apr 2022 15:31:35 +1000
Date:   Mon, 11 Apr 2022 15:31:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs: test xfsdump when an inode < root inode is
 present
Message-ID: <20220411053135.GH1609613@dread.disaster.area>
References: <20220408170847.1088522-1-zlang@redhat.com>
 <20220409040056.GA14099@magnolia>
 <20220410121103.wk2hgixq57dogzah@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410121103.wk2hgixq57dogzah@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6253bd39
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=GMwFSGjYRNBZMOYGfdsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 10, 2022 at 08:11:03PM +0800, Zorro Lang wrote:
> On Fri, Apr 08, 2022 at 09:00:56PM -0700, Darrick J. Wong wrote:
> > On Sat, Apr 09, 2022 at 01:08:47AM +0800, Zorro Lang wrote:
> > > From: Eric Sandeen <sandeen@redhat.com>
> > > 
> > > This tests a longstanding bug where xfsdumps are not properly
> > > created when an inode is present on the filesytsem which has
> > > a lower number than the root inode.
> > > 
> > > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > > 
> > > Friendly ping for reviewing.
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > >  common/dump       |  1 +
> > >  tests/xfs/543     | 63 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/xfs/543.out | 47 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 111 insertions(+)
> > >  create mode 100755 tests/xfs/543
> > >  create mode 100644 tests/xfs/543.out
> > > 
> > > diff --git a/common/dump b/common/dump
> > > index ea16d442..ab48cd13 100644
> > > --- a/common/dump
> > > +++ b/common/dump
> > > @@ -219,6 +219,7 @@ _require_tape()
> > >  
> > >  _wipe_fs()
> > >  {
> > > +    [[ "$WIPE_FS" = "no" ]] && return
> > 
> > Is WIPE_FS intended as a general means to prevent wipefs -a between
> > tests?  If so, it ought to be in the README.
> 
> Actually I don't know how to if I should say WIPE_FS means to prevent
> wipefs -a between tests. Due to:
> 
> 1) We have a _wipe_fs() in common/dump[1], it's very old, and it only
> try to make a new xfs, although it calls wipe "fs"... And it's only used
> for tests/xfs/* cases to call _create_dumpdir_*() function.
> 
> 2) Then we have _try_wipe_scratch_devs() in common/rc [2], which calls
> _try_wipe_scratch_xfs() in common/xfs [3] (which is newer), it's only
> used in ./check script now.
> 
> So I'm wondering if we'd better to change the _wipe_fs() to:
> _wipe_dump()
> {
> 	[[ "$WIPE_DUMP" = "no" ]] && return
> 	_require_scratch
> 
> 	_try_wipe_scratch_devs >>$seqres.full
> 	_scratch_mount >>$seqres.full
> }
> 
> What do you think?

common/dump::_wipe_fs() is effectively just _scratch_mkfs() followed
by mounting it. It does not need to exist at all.

The test(s) need to have run _require_scratch() in it's setup, it
shouldn't be hidden deep inside random functions that fill the
scratch device.

They should also run scratch_mkfs/mount themselves to prep the
scratch device, and then _wipe_fs() can go away entirely.

And the new test simply calls the function to populate the scratch
device at the place where you want to preserve the previous contents
of the scratch device without first running scratch_mkfs....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
