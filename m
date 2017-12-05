Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:14137 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751208AbdLEVMC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Dec 2017 16:12:02 -0500
Date: Wed, 6 Dec 2017 08:09:56 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: False lockdep completion splats with loop device
Message-ID: <20171205210956.GZ5858@dastard>
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
 <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205150741.xsbp4mtilqfrsukl@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Byungchul Park <byungchul.park@lge.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 05, 2017 at 10:07:41AM -0500, Theodore Ts'o wrote:
> On Tue, Dec 05, 2017 at 02:16:45PM +0900, Byungchul Park wrote:
> > 
> > Hello,
> > 
> > I believe that the commit e319e1fbd9d42 "block, locking/lockdep: Assign
> > a lock_class per gendisk used for wait_for_completion()" solved the
> > false positive.
> > 
> > Could you tell me if it doesn't handle it, with the report? Then, I
> > will follow up and try to solve it.
> 
> No, it doesn't handle it.  And there was some discussion in the linked
> thread on the xfs mailing list that seemed to indicate that it was not
> a complete fix.

Well, it uses a static key hidden inside the macro
alloc_disk_node(), so every disk allocated from the same callsite
points to the same static lockdep map. IOWs, every caller of
alloc_disk() (i.e. the vast majority of storage devices) are
configured to point at the same static lockdep map, regardless of
their location in the storage stack.

The loop device uses alloc_disk().

IOWs, it doesn't address the problem of false positives due to
layering in the IO stack at all because we can still have
filesystems both above and below the lockdep map that has been
attached to the devices...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
