Received: from imap.thunk.org ([74.207.234.97]:57143 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbcBJP6k (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 10:58:40 -0500
Date: Wed, 10 Feb 2016 10:58:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 02/12] common: _scratch_mkfs_sized() for tmpfs
Message-ID: <20160210155837.GD26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-3-git-send-email-tytso@mit.edu>
 <20160210060058.GU19486@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210060058.GU19486@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 05:00:58PM +1100, Dave Chinner wrote:
> > +    tmpfs)
> > +	export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
> 
> So what happens when the test asks for 10GB of device space, and you
> only have 4GB of RAM?

The largest amount of storage space requested by shared/generic tests
via _scratch_mkfs_sized is 2G, and that's from generic/27[345].

We currently could run into problems today if the storage device only
had 3G of space, and some test, such as f2fs/001, called
_scratch_mkfs_sized requesting 4G of space.  We currently aren't
checking error returns from the mkfs command; we just assume that it
will succeed.

Because of the someone interesting behavior of tmpfs assuming inode
space is free, we already have problems where even with 8G of memory,
generic/269 and generic/273 will result in the test getting OOM
killed, and if you use less than 4G, there are a more tests that end
up getting OOM killed as a result.

So I think it would be fair to simply document that if you are testing
tmpfs, you need a VM or or a memory container with at least 8G of
memory.  If we start limiting the number of inodes in a tmpfs mount,
we could probably bring that requirement down to 4G, which is
certainly fair.  We do document minimum requirements for the size of
the TEST_DEV and SCRATCH_DEV, don't we?   (Minimum requirements
certainly do exist in practice, in any case.)

Cheers,

					- Ted
