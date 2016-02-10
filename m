Received: from imap.thunk.org ([74.207.234.97]:33955 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbcBJXjN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 18:39:13 -0500
Date: Wed, 10 Feb 2016 18:39:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 08/12] xfstests: fix generic/312 on tmpfs, ignore
 /proc/partitions
Message-ID: <20160210233911.GM26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-9-git-send-email-tytso@mit.edu>
 <20160210055455.GS19486@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210055455.GS19486@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 04:54:55PM +1100, Dave Chinner wrote:
> 
> _scratch_mkfs
> _scratch_mount
> _require_fs_space $SCRATCH_MNT $((fssize / 1024))
> _scratch_unmount
> _scratch_mkfs_sized $fssize

This doesn't work because _require_fs_space uses df -klP, and the -l
file systems with names such as "test:/scratch" to be filtered out ---
and xfstests requires us to use NFS-looking names as a hint that the
file system has no block device.

This results in "_require_fs_space" failing on tmpfs file systems with
the error messages:

    df: no file systems processed
    ./common/rc: line 1860: [: -lt: unary operator expected

I'm not sure why the -l option is being used at all in the first
place.  Any objections if I remove it?  Presumably this is also
causing _require_fs_space to blow up on any tests run using NFS....

Alternatively I could just remove if it $FSTYP == tmpfs, but that
assumes there was some reason for using the -l option in the first
place.

			     	     	- Ted
