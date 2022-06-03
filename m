Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE4C43334
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jun 2022 05:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiFCF3d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Jun 2022 01:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiFCF3c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Jun 2022 01:29:32 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C3EB38DB4
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 22:29:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 884015EC4B7;
        Fri,  3 Jun 2022 15:29:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwzsH-0024h9-7c; Fri, 03 Jun 2022 15:29:29 +1000
Date:   Fri, 3 Jun 2022 15:29:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/8 v2] fstests: Add Log Attribute Replay test
Message-ID: <20220603052929.GQ227878@dread.disaster.area>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-2-david@fromorbit.com>
 <20220603014112.GO227878@dread.disaster.area>
 <Ypl1SaRtV9O3HNqC@magnolia>
 <20220603045504.ws4unxiojst3qppb@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603045504.ws4unxiojst3qppb@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62999c3a
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=heNjibvkODbNPbefddsA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 03, 2022 at 12:55:04PM +0800, Zorro Lang wrote:
> On Thu, Jun 02, 2022 at 07:43:21PM -0700, Darrick J. Wong wrote:
> > On Fri, Jun 03, 2022 at 11:41:12AM +1000, Dave Chinner wrote:
> > > From: Allison Henderson <allison.henderson@oracle.com>
> > > 
> > > This patch adds tests to exercise the log attribute error
> > > inject and log replay. These tests aim to cover cases where attributes
> > > are added, removed, and overwritten in each format (shortform, leaf,
> > > node). Error inject is used to replay these operations from the log.
> > > 
> > > dchinner: sanitise md5sum input to just attr values.
> > > dchinner: correct md5sums.
> > > dchinner: ensure replace tests use different values so recovery can
> > >           determine the replace was replayed correctly.
> > > dchinner: don't remove corpse in _cleanup - scratch devices don't
> > > 	  require cleanup, and if the test fails we want to leave
> > > 	  the broken state for post-mortem analysis.
> > > dchinner: only run on v5 filesystems.
> > > 
> > > Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> > > Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > > V2:
> > > - redirected attr get failure messages to /dev/null rather than
> > >   have to filter them. The md5sum tells us that the attr didn't
> > >   exist.
> > > 
> > >  tests/xfs/600     | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/xfs/600.out | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 347 insertions(+)
> > > 
> > > diff --git a/tests/xfs/600 b/tests/xfs/600
> > > new file mode 100755
> > > index 00000000..bc9415ec
> > > --- /dev/null
> > > +++ b/tests/xfs/600
> > > @@ -0,0 +1,179 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2022, Oracle and/or its affiliates.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 600
> > > +#
> > > +# Log attribute replay test
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick attr
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/filter
> > > +. ./common/attr
> > > +. ./common/inject
> > > +
> > > +_cleanup()
> > > +{
> > > +	rm -rf $tmp.*
> > > +	test -w /sys/fs/xfs/debug/larp && \
> > > +		echo 0 > /sys/fs/xfs/debug/larp
> > 
> > Probably ought to restore the old value, but otherwise the logic in here
> > looks solid enough.
> 
> I can help that when I merge it this week.
> 
> BTW, I saw the "[PATCH 00/15] xfs: Log Attribute Replay" patchset has been
> merged by mainline linux. So I suspose it's time to merge this patch. Please
> tell me if it's still not the time. As I know there's not only one patchset
> is related with this.

I wanted it merged two weeks ago because we merged LARP into the XFS
for-next tree a month ago. We need tests merged when the changes go
into the for-next tree, not when the for-next tree gets merged into
Linus's tree weeks later....

> And I'll really appreciate that, if any of you would like to list all related
> patchset titles (from kernel and userspace) to help this case test pass :)

I'm not going to attempt to find the 6 or 7 patchset and list them.
They are all merged into 5.19, so use that kernel. For userspace,
use the libxfs-5.19-sync branch I pushed out earlier in the week:

https://lore.kernel.org/linux-xfs/20220601010636.GC227878@dread.disaster.area/T/#u

That contains all the 5.19 kernel changes and the userspace support
for large extent counters and LARP, including all the error
injection stuff that the various tests use.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
