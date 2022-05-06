Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0874FC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  6 May 2022 07:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbiEFHsM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 May 2022 03:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiEFHsK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 May 2022 03:48:10 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7830562113
        for <fstests@vger.kernel.org>; Fri,  6 May 2022 00:44:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 19ADF5346AC
        for <fstests@vger.kernel.org>; Fri,  6 May 2022 17:44:26 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nmsdU-008dHE-2H
        for fstests@vger.kernel.org; Fri, 06 May 2022 17:44:24 +1000
Date:   Fri, 6 May 2022 17:44:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: faster group file creation
Message-ID: <20220506074424.GG1949718@dread.disaster.area>
References: <20220506031232.483883-1-david@fromorbit.com>
 <20220506051017.GF1949718@dread.disaster.area>
 <20220506071311.uhdgdzl26zajdclm@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506071311.uhdgdzl26zajdclm@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6274d1da
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=Xljmwckq9NioZQPpmWkA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 06, 2022 at 03:13:11PM +0800, Zorro Lang wrote:
> On Fri, May 06, 2022 at 03:10:17PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > We don't need to execute every test just to check it's groups are
> > valid. Just grab all the groups with grep, pull out the unique ones,
> > then check them.
> > 
> > This also avoids the problem of editor swap files being present in
> > the test directory and breaking the build because they are not
> > executable.
> > 
> > Building on a clean, already built tree so it only builds the
> > group lists:
> > 
> > $ time make
> > ....
> > Building udf
> >  [GROUP] /home/dave/src/xfstests-dev/tests/udf/group.list
> > Building xfs
> >  [GROUP] /home/dave/src/xfstests-dev/tests/xfs/group.list
> > 
> > real    0m36.917s
> > user    0m15.032s
> > sys     0m26.219s
> > $
> > 
> > Patched:
> > 
> > $ time make
> > ....
> > Building udf
> >  [GROUP] /home/dave/src/xfstests-dev/tests/udf/group.list
> > Building xfs
> >  [GROUP] /home/dave/src/xfstests-dev/tests/xfs/group.list
> > groups "frobnozzle" not mentioned in documentation.
> > gmake[3]: *** [../../include/buildgrouplist:8: group.list] Error 1
> > gmake[2]: *** [../include/buildrules:31: xfs] Error 2
> > gmake[1]: *** [include/buildrules:31: tests] Error 2
> > make: *** [Makefile:51: default] Error 2
> > 
> > real    0m1.751s
> > user    0m0.863s
> > sys     0m1.067s
> > 
> > $
> > 
> > Just a little bit faster, and as you can see that it still detects
> > groups that are not documented. There was also an open .001.swp file
> > in the XFS directory and that doesn't throw a failure anymore,
> > either.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> 
> Looks good to me. It's much faster than before, especially when rebuild for
> small changes.

Yup, my run scripts always run make before starting a run, so when
I'm iterating single tests for failure analysis, this knocks 20-30s
out of the cycle time. check starting up is now the thing that is
really slow - it's still taking around 10s to get to the first
test these days....

> Reviewed-by: Zorro Lang <zlang@kernel.org>

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
