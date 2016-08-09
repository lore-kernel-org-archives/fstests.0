Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:18395 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751774AbcHIG3s (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 9 Aug 2016 02:29:48 -0400
Date: Tue, 9 Aug 2016 16:29:43 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 13/17] xfs: test swapext with reflink
Message-ID: <20160809062943.GF19025@dastard>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914485888.11762.1688573359701830686.stgit@birch.djwong.org>
 <20160808081359.GB27776@eguan.usersys.redhat.com>
 <20160808174132.GC11291@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160808174132.GC11291@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <eguan@redhat.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 08, 2016 at 10:41:32AM -0700, Darrick J. Wong wrote:
> On Mon, Aug 08, 2016 at 04:13:59PM +0800, Eryu Guan wrote:
> > On Thu, Jul 21, 2016 at 04:47:38PM -0700, Darrick J. Wong wrote:
> > > Add a few tests to stress the new swapext code for reflink and rmap.
> > > +_reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > > +
> > > +echo "Defrag the big file"
> > > +old_nextents=$(xfs_io -c 'stat -v' $testdir/file1 | grep 'nextents' | cut -d ' ' -f 3)
> > 
> > There's a "_count_extents" helper, does that work for this case?
> 
> It can, though stat -v reports GETFSXATTR results, which should be faster than
> _count_extents because the latter FIEMAPs the entire file and counts lines.
> Seeing as XFS records the extent count in the inode, we might as well use it.

perhaps put a special xfs case in _count_extents() that does this
rather than FIEMAP?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
