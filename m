Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:45177 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169AbcBKCxF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 21:53:05 -0500
Date: Thu, 11 Feb 2016 13:53:02 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 08/12] xfstests: fix generic/312 on tmpfs, ignore
 /proc/partitions
Message-ID: <20160211025302.GD19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-9-git-send-email-tytso@mit.edu>
 <20160210055455.GS19486@dastard>
 <20160210233911.GM26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210233911.GM26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 06:39:11PM -0500, Theodore Ts'o wrote:
> On Wed, Feb 10, 2016 at 04:54:55PM +1100, Dave Chinner wrote:
> > 
> > _scratch_mkfs
> > _scratch_mount
> > _require_fs_space $SCRATCH_MNT $((fssize / 1024))
> > _scratch_unmount
> > _scratch_mkfs_sized $fssize
> 
> This doesn't work because _require_fs_space uses df -klP, and the -l
> file systems with names such as "test:/scratch" to be filtered out ---
> and xfstests requires us to use NFS-looking names as a hint that the
> file system has no block device.
> 
> This results in "_require_fs_space" failing on tmpfs file systems with
> the error messages:
> 
>     df: no file systems processed
>     ./common/rc: line 1860: [: -lt: unary operator expected
> 
> I'm not sure why the -l option is being used at all in the first
> place.  Any objections if I remove it?  Presumably this is also
> causing _require_fs_space to blow up on any tests run using NFS....

No idea on why -l is used. If there is a reason to be found, it
will be in the commit history.

> Alternatively I could just remove if it $FSTYP == tmpfs, but that
> assumes there was some reason for using the -l option in the first
> place.

Remove it, see what breaks/who complains.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
