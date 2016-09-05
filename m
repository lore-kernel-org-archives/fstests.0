Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:28340 "EHLO
        ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754262AbcIEA1L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Sep 2016 20:27:11 -0400
Date: Mon, 5 Sep 2016 10:26:51 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] seek_sanity_test: use fs block size not preferred IO size
Message-ID: <20160905002651.GB22388@dastard>
References: <1e34c608-b013-edc4-aec0-a50f6bf32a4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e34c608-b013-edc4-aec0-a50f6bf32a4e@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 02, 2016 at 07:04:01PM -0500, Eric Sandeen wrote:
> seek_sanity_test uses a 16x multiple of st_blksize for the basis
> of its io sizes; for filesystems that use generic_fillattr,
> that's the same as fs block size.  But on xfs, we take
> "blocksize for file system I/O" a bit more generously, and
> use xfs_preferred_iosize, which may be page size, stripe width,
> or otherwise.

We take what the stat(2) man page says literally:

	The st_blksize field gives the "preferred" blocksize for
	efficient filesystem I/O.  (Writing to a file in smaller
	chunks may cause an inefficient read-modify-rewrite.)

i.e. I/O sizes smaller than PAGE_SIZE can require RMW cycles in the
page cache, so you need to do page sized IO as a minimum for
efficient IO.

> If we get a value of any more than 4k, the 16x multiplier puts
> us past 64k, which is the threshold for xfs speculative
> preallocation kicking in, and this starts messing with the
> file layout that the test expects.
> 
> So: Switch the test to use statvfs, and get the true fs
> block size.  This will still break for block sizes > 4k,
> but for now at least it makes the test work on xfs with
> page sizes > 4k using the default mkfs or smaller.

So we're going to have to fix it again when someone runs 64k block
size on aarch64 or ppc64?

> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> Another option would be to mount xfs with options to
> defeat speculative prealloc, or to decrease the 16x
> multiplier, but the intent of the test seems to be a 16x
> multiple of fs block size, so let's at least start there.

The easiest way to handle this is to ftruncate() the file out to
it's final size before starting to write to the file. Then
speculative prealloc will never occur.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
