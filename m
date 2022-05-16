Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D676C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 21:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349298AbiEPVPY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349337AbiEPVPQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 17:15:16 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38B1F17047
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 14:09:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4299C5346D9;
        Tue, 17 May 2022 07:09:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqhyP-00Co1Z-CQ; Tue, 17 May 2022 07:09:49 +1000
Date:   Tue, 17 May 2022 07:09:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] fstests: filter quota warnings
Message-ID: <20220516210949.GK2306852@dread.disaster.area>
References: <20220516060807.1295102-1-david@fromorbit.com>
 <20220516060807.1295102-2-david@fromorbit.com>
 <YoJtGrvDeeOmvFw0@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJtGrvDeeOmvFw0@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6282bd9f
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=O98FjWTPf4uj2PdoTswA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 08:26:18AM -0700, Darrick J. Wong wrote:
> On Mon, May 16, 2022 at 04:08:05PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Quota warning code has been removed from the upstream kernel and now
> > returns -EINVAL errors. Seeing as we can't set warnings anymore and
> > they have always been non-functional in the kernel, just remove the
> > calls to set warnings filter those errors out so those tests pass
> > again.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/xfs/050 | 9 ---------
> >  tests/xfs/153 | 9 ---------
> >  tests/xfs/299 | 9 ---------
> >  3 files changed, 27 deletions(-)
> > 
> > diff --git a/tests/xfs/050 b/tests/xfs/050
> > index 1847611b..2220e470 100755
> > --- a/tests/xfs/050
> > +++ b/tests/xfs/050
> > @@ -84,9 +84,6 @@ _exercise()
> >  	_qsetup $1
> >  
> >  	echo "Using type=$type id=$id" >>$seqres.full
> > -
> > -	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
> > -
> >  	echo
> >  	echo "*** report no quota settings" | tee -a $seqres.full
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > @@ -113,7 +110,6 @@ _exercise()
> >  	_file_as_id $SCRATCH_MNT/softie3 $id $type 1024 0
> >  	_file_as_id $SCRATCH_MNT/softie4 $id $type 1024 0
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
> 
> I don't think we can revert this line from commit e5bbd47e
> ("xfs/{050,299}: clear quota warnings in between checks") because any
> kernel released in the past two years will increment the warning
> counter, and not resetting it to zero between tests means the golden
> output will break.

That's a feature, not a bug. i.e. it tells the people running the
tests that there are fixes they need to backport to the kernel they
are testing. Otherwise the moment a user sets warning limits they
will end up with a broken system.

If we want to make sure distros and LTS kernels backport fixes for
this issue, this is the way to make sure their QE/test environments
notice that these is something that needs fixing...

> We could, however, use more sed magic to force the warning counts in the
> repquota output to be zero, which (I think) enables these changes to
> move forward.

I think that's less good that the situation as it doesn't tell
anyone they are running a kernel with broken quota functionality
that needs fixing....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
