Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:55234 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489AbcBJXNV (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 18:13:21 -0500
Date: Thu, 11 Feb 2016 10:13:18 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 10/12] generic: disable generic/027 for tmpfs
Message-ID: <20160210231318.GB19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-11-git-send-email-tytso@mit.edu>
 <20160210055838.GT19486@dastard>
 <20160210154810.GC26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210154810.GC26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 10:48:10AM -0500, Theodore Ts'o wrote:
> On Wed, Feb 10, 2016 at 04:58:39PM +1100, Dave Chinner wrote:
> > > With tmpfs, we can limit the size of the file system, which limits the
> > > block allocation, but there is no limit to the number of inodes that
> > > can be created until kmalloc() fails --- or the OOM killer kills the
> > > test.  So this causes this test to run for a long, long time, and in
> > > some cases the test or the test runner will get OOM killed instead.
> > > We have other ENOSPC tests, so given that tmpfs is just so different
> > > from all other file systems, it's simpler just to disable this test
> > > for tmpfs than to try to make it work.
> > 
> > This sounds like a bug in tmpfs and a potential user level DOS
> > vector, too. Hence I dont think not running the test is the right
> > thing to do here - tmpfs should be handling this gracefully by
> > applying sane resource limits.
> 
> Well, it's not really that interesting of a DOS vector since if the
> goal is to use up all available memory, there are other ways to do it
> that are much more efficient.

Of course, but that doesn't mean the behaviour is valid. If we are
relying on the OOM killer to kill the right thing or require memcgs
to prevent trivial OOM killer invocations, then we've got a problem
that needs fixing.

....

> OTOH, the fact that tmpfs doesn't have a inode limits is a bit weird.
> What about having tmpfs enforce a per-mount "maxinodes" restriction
> which by default is "maxsize / 1k", and which can be overriden using a
> maxinodes mount option?  Does that sound sane to you?
> 
> Or we could charge a minimum 512 bytes per inode against the size,
> since between the kernel data structures and the file name, it's not
> like a zero-length tmpfs file is free.

I'd suggest simply charging sizeof(struct shmem_inode_info) against
the space usage when inode allocation is requested.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
