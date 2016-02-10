Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:37259 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbcBJWhc (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 17:37:32 -0500
Date: Thu, 11 Feb 2016 09:37:29 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 02/12] common: _scratch_mkfs_sized() for tmpfs
Message-ID: <20160210223729.GY19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-3-git-send-email-tytso@mit.edu>
 <20160210060058.GU19486@dastard>
 <20160210155837.GD26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210155837.GD26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 10:58:37AM -0500, Theodore Ts'o wrote:
> On Wed, Feb 10, 2016 at 05:00:58PM +1100, Dave Chinner wrote:
> > > +    tmpfs)
> > > +	export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
> > 
> > So what happens when the test asks for 10GB of device space, and you
> > only have 4GB of RAM?
> 
> The largest amount of storage space requested by shared/generic tests
> via _scratch_mkfs_sized is 2G, and that's from generic/27[345].

Sure, but that doesn't doesn't invalidate my question.

I run xfstests on machines with 1GB RAM, so those tests you list
above are going to have problems with tmpfs, yes?

> We currently could run into problems today if the storage device only
> had 3G of space, and some test, such as f2fs/001, called
> _scratch_mkfs_sized requesting 4G of space.  We currently aren't
> checking error returns from the mkfs command; we just assume that it
> will succeed.

That would be a test bug.  We have a general rule of thumb that
test/scratch devices are typically a couple of GB in size, so if the
test needs less space than that it doesn't need to check. If the
test needs more than 1-2GB of space, then it needs to call
_require_fs_space to abort the test if the device is too small.
Hence we end up with tests being not run with:

generic/312      [not run] this test requires $SCRATCH_DEV has 5368709120B space

This needs to work for tmpfs, too, so that we don't run tests that
will overcommit RAM on machines with limited memory.

> Because of the someone interesting behavior of tmpfs assuming inode
> space is free, we already have problems where even with 8G of memory,
> generic/269 and generic/273 will result in the test getting OOM
> killed, and if you use less than 4G, there are a more tests that end
> up getting OOM killed as a result.

As I said, this is a tmpfs bug that needs fixing, not working around
in xfstests. If tmpfs is limited to 512MB or 1GB of space, then
having it be able to consume multiple times it's requested size in
memory is simply wrong.

> So I think it would be fair to simply document that if you are
> testing tmpfs, you need a VM or or a memory container with at
> least 8G of memory. If we start limiting the number of inodes in a
> tmpfs mount, we could probably bring that requirement down to 4G,
> which is certainly fair.  We do document minimum requirements for
> the size of the TEST_DEV and SCRATCH_DEV, don't we? 

No, not that I know of.

> (Minimum
> requirements certainly do exist in practice, in any case.)

See above.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
