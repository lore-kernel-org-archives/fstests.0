Received: from mx1.redhat.com ([209.132.183.28]:51666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeCWTJ7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Mar 2018 15:09:59 -0400
Date: Fri, 23 Mar 2018 15:09:57 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] xfs/444: test log replay after XFS_IOC_SWAPEXT
Message-ID: <20180323190956.GE22357@bfoster.bfoster>
References: <9227d8db-faf6-5c19-239b-074c7f5cfc00@sandeen.net>
 <20180226130212.GA51394@bfoster.bfoster>
 <d7759432-3fea-438b-ab0e-023caf414a35@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7759432-3fea-438b-ab0e-023caf414a35@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 23, 2018 at 01:47:29PM -0500, Eric Sandeen wrote:
> On 2/26/18 7:02 AM, Brian Foster wrote:
> > On Fri, Feb 23, 2018 at 12:33:41PM -0600, Eric Sandeen wrote:
> >> This is a mashup of xfs/042 and some of the log replay tests;
> >> it checks whether the log can be replayed if we crash immediately
> >> after an xfs_fsr / XFS_IOC_SWAPEXT.
> >>
> >> Hint: it can't.  It fails because the temporary donor inode has
> >> been deleted and has invalid mode 0 when we try to replay its
> >> swapext operation.  Kernel patches to fix it will follow soon.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> ---
> >>
> >> diff --git a/tests/xfs/444 b/tests/xfs/444
> >> new file mode 100755
> >> index 0000000..e88438a
> >> --- /dev/null
> >> +++ b/tests/xfs/444
> >> @@ -0,0 +1,144 @@
> > ...
> >> +# Test performs several operations to produce a badly fragmented file, then
> >> +# create enough contiguous free space for xfs_fsr to defragment the fragmented
> >> +# file:
> >> +#
> >> +# - create fs with 3 minimum sized (16Mb) allocation groups
> >> +# - create 16x1MB contiguous files which will become large free space extents
> >> +#   when deleted
> >> +# - put a small "space" between each of the 16 contiuguous files to ensure we
> >> +#   have separated free space extents
> >> +# - fill the remaining free space with a "fill file"
> >> +# - mount/unmount/fill remaining free space with a pad file
> >> +# - punch alternate single block holes in the the "fill file" to create
> >> +#   fragmented free space.
> >> +# - use fill2 to generate a very large fragmented file
> >> +# - delete the 16 large contiguous files created initially
> >> +# - run xfs_fsr on the filesystem
> >> +# - check checksums for remaining files
> >> +
> > Without having dug into the core issue, I wonder whether this sequence
> > could be simplified a bit by using 'xfs_io -c swapext' followed by a
> > shutdown?
> 
> It probably would - given that it's a longstanding problem, I wonder if requiring
> bleeding-edge xfsprogs to test/demonstrate it is wise, though.
> 

That doesn't seem like a big deal to me. We've had numerous cases of
tests that have required new functionality in xfsprogs and/or the kernel
to instrument/reproduce a problem.

> Tell you what, I'll try to rewrite the test so it uses swapext if available, else
> falls back to the heavy-weight fsr run?
> 

Sounds reasonable, but it might not be worth bothering with swapext in
that case. The purpose of the suggestion was to simplify the test by
avoiding all the magic setup stuff noted above to make xfs_fsr do what
the test expects.

Brian

> -Eric
>  
> > Brian
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
