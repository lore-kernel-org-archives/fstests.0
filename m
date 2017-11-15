Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:35478
        "EHLO ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753282AbdKOA47 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Nov 2017 19:56:59 -0500
Date: Wed, 15 Nov 2017 11:56:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: rework _require_ext4_mkfs_feature
Message-ID: <20171115005655.GE4094@dastard>
References: <20171112133621.2474-1-tytso@mit.edu>
 <20171114114315.GH17339@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114114315.GH17339@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 14, 2017 at 07:43:15PM +0800, Eryu Guan wrote:
> On Sun, Nov 12, 2017 at 08:36:21AM -0500, Theodore Ts'o wrote:
> > In all of the places where we need check to see if mkfs.ext4 can
> > support a set of file system features, we also should be checking to
> > see if the kernel can support those file system features.  So rename
> > _require_ext4_mkfs_feature to _require_ext4_feature, and actually
> > format the file system in $SCRATCH.  To avoid running mkfs twice in
> > most tests, we will teach the tests to assume that
> > _require_ext4_feature actually leaves $SCRATCH formatted with a file
> > system with those features.
> 
> Hmm, I don't think this the correct usage of _require rules. We use
> _require rule to check if the requirements have been met, but don't
> count on it to do any actual work. And we could always create a small
> filesystem (say 512m) if we want to reduce the mkfs time in the _require
> rule.

Implement, like in mkfs.xfs, the "-N" flag (a.k.a "--dry-run").
It does option parsing and geometry calculations, outputs the config
that would be made, then exits before doing any actual IO. Hence we
can check mkfs feature support on XFS, and only take the time to
make a filesystem if we need to check that kernel support exists.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
