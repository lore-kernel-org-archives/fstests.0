Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:5313 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750752AbcBJWUP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 17:20:15 -0500
Date: Thu, 11 Feb 2016 09:19:59 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 01/12] check: avoid error messages of tests/$FS does not
 exist
Message-ID: <20160210221959.GX19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-2-git-send-email-tytso@mit.edu>
 <20160210054531.GR19486@dastard>
 <20160210153455.GB26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210153455.GB26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 10:34:55AM -0500, Theodore Ts'o wrote:
> On Wed, Feb 10, 2016 at 04:45:31PM +1100, Dave Chinner wrote:
> > On Tue, Feb 09, 2016 at 08:49:50PM -0500, Theodore Ts'o wrote:
> > > There are no tmpfs specific tests, so tests/tmpfs does not exist.
> > > Avoid print an error message caused by trying to read the file
> > > tests/tmpfs/group (for example).
> > > 
> > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > 
> > Where does this error message get emitted? I would have expected
> > lots of people to notice this (e.g. NFS, CIFS, ext2, ext3, gfs2)
> > if this was causing some kind of problem long before this...
> 
> It doesn't really cause a problem; it's more of a cosmetic issue, in
> that it prints a harmless/annoying error message during the test
> startup.  It shows up if you specify a group, e.g. "check -g quick":
> 
> BEGIN TEST tmpfs: tmpfs Wed Feb 10 10:31:09 EST 2016
> DEVICE: test:/tmp
> MK2FS OPTIONS:
> MOUNT OPTIONS: -o block_validity
> ./check: line 96: tests/tmpfs/group: No such file or directory
> FSTYP         -- tmpfs
> PLATFORM      -- Linux/i686 kvm-xfstests 4.5.0-rc2ext4-00002-g6df2762
> MKFS_OPTIONS  -- test:/scratch
> MOUNT_OPTIONS -- -o size=1G test:/scratch /test/scratch
> 
> generic/001   	 [10:31:10][    5.811742] run fstests generic/001

Can you please rewrite the commit message to include this?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
