Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:43467
        "EHLO ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754283AbeDMNmO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Apr 2018 09:42:14 -0400
Date: Fri, 13 Apr 2018 23:42:10 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/444: add check for xfs_db write bno array
Message-ID: <20180413134210.GD5572@dastard>
References: <1523527230-6394-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <20180412120952.GM729@dastard>
 <20180412130038.GE2932@desktop>
 <20180412230035.GB5572@dastard>
 <20180413043612.GF2932@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413043612.GF2932@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: yang xu <xuyang.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 13, 2018 at 12:36:12PM +0800, Eryu Guan wrote:
> > > But this issue looks like a bug in xfsprogs to me, not a missing feature
> > > in xfsprogs on RHEL7, so I tend to fail the test instead of adding a new
> > > _require rule & _notrun the test. And in this case, IMHO, I don't think
> > > it's necessary to do any update to the test, just leave the test as it
> > > is and file a new bug in Red Hat bugzilla.
> > 
> > ... this isn't a RHEL specific issue - it's an xfsprogs version
> > issue.  i.e.  any older distro that has a binary with a broken
> > "write array" command will fail this test. None of them are going to
> > get updated xfsprogs packages, so like having an old mkfs.xfs
> > binary, this test should run conditionally on having a version of
> > xfs_db that actually works correctly....
> 
> But I still think it's a pure bug in xfsprogs, not xfsprogs version
> issue nor a behavior change in xfsprogs, as we did support "write via
> array indexing", just that it was broken in a certain case, and commit
> 4222d000ed3b fixed that bug. We should expose bugs by letting the test
> fail, not paper over it by _notrun the test. 

Yes, it's a bug in xfsprogs. But it's a bug in a diagnostic
utility that is only used by test infrastructure and XFS
developers.

Yes, it's ialso fixed in recent version of xfsprogs, but you know
very well that we test distros that have ancient xfsprogs and will
never have this issue fixed in them. We use detectiona nd notrun to
avoid tests they should not run all the time, and I don't see how
this is any different.

I really don't understand why you are pushing back on this - why
should this specific infrastructure deficiency cause test failures,
when all the existing infrastructure support checks cause tests to
notrun rather than fail?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
