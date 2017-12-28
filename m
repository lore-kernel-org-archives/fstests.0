Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:5991 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751086AbdL1JJH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Dec 2017 04:09:07 -0500
Date: Thu, 28 Dec 2017 20:09:03 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests: generic/342 run failed in f2fs
Message-ID: <20171228090903.GQ5858@dastard>
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
 <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
 <20171225163102.GB14399@thunk.org>
 <20171227191130.GB13490@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171227191130.GB13490@jaegeuk-macbookpro.roam.corp.google.com>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Eric Sandeen <sandeen@sandeen.net>, Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, philip.li@intel.com
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 27, 2017 at 11:11:30AM -0800, Jaegeuk Kim wrote:
> On 12/25, Theodore Ts'o wrote:
> > On Sun, Dec 24, 2017 at 11:47:20PM -0800, Eric Sandeen wrote:
> > > Filesystems are free to do /more/ than the minimum required by posix -
> > > see ext4_sync_parent for example.  Or xfs_finish_rename, for synchronous
> > > mounts:
> > > 
> > >          * If this is a synchronous mount, make sure that the rename transaction
> > >          * goes to disk before returning to the user.
> > >          */
> > >         if (tp->t_mountp->m_flags & (XFS_MOUNT_WSYNC|XFS_MOUNT_DIRSYNC))
> > >                 xfs_trans_set_sync(tp);
> > > 
> > > so behavior can be fs-dependent, or mount option dependent, etc.
> > > 
> > > But to be portable, if an app wants directory changes to be persistent
> > > before proceeding, it must fsync the directory after making changes.
> > > 
> > > I don't know about f2fs's design intent, whether it guarantees more
> > > than posix requires, but to guarantee that this test works on any posix
> > > fs, I think that directory fsync is needed.
> > 
> > Agreed that this is a test bug, and we should add the fsync to the
> > parent directory.
> 
> Agreed too. Or, how about using "-o dirsync"?
> 
> > 
> > It might also be a good idea for f2fs to do more, given that fsync is
> > a slow enough operation that so long as you can make sure the fsync of
> > the parent directory happens within the same atomic update as the
> > child inode, you might as well give the more expansive guarantee.  But
> > obviously that's up to the f2fs developers to decide whether they want
> > to do that work.
> 
> Indeed. Actually, since one of our goals was to reduce fsync latencies for
> Android, we decided to support posix in a minimum way. In order to avoid
> complex directory updates recursively, however, we allowed the fsync on
> directories to trigger checkpoint requiring many IO operations.

So what you are really saying is that f2fs is not strictly ordered
w.r.t metadata crash consistency after fsync()? Wasn't that
considered a bug in btrfs that had to be fixed (and did get fixed)?

Oh, yeah, it's right there in the test commit history:

commit f02fe949113f35ae221ec1ab5c9959912f594bf4
Author: Filipe Manana <fdmanana@suse.com>
Date:   Tue Apr 5 11:47:55 2016 +1000

    generic: add test for fsync after renaming file
    
    Test that if we rename a file, create a new file that has the old name
    of the other file and is a child of the same parent directory, fsync the
    new inode, power fail and mount the filesystem, we do not lose the first
    file and that file has the name it was renamed to.
    
    This test is motivated by an issue found in btrfs which is fixed by the
    following patch for the linux kernel:
    
      "Btrfs: fix file loss caused by fsync after rename and new inode"
    
    Signed-off-by: Filipe Manana <fdmanana@suse.com>
    Reviewed-by: Eryu Guan <eguan@redhat.com>
    Signed-off-by: Dave Chinner <david@fromorbit.com>

There's a whole lot more detail in the kernel commit 2be63d5ce929
("Btrfs: fix file loss on log replay after renaming a file and
fsync") but my point is that we considered this a btrfs filesystem
bug and so changing the test defeats it's purpose as a regression
test for the btrfs bug.

So IMO the test should not be changed. And I think we should be
consistent and consider this f2fs failure as a f2fs bug that needs
fixing to bring it's behaviour in line with xfs, ext4, and btrfs.

Remember this when quoting POSIX about fsync behaviour: Posix is a
terrible standard when it comes to data integrity. We go way, way
beyond what POSIX specifies as a valid fsync implementation (i.e.
posix allows "do nothing and return success" as a conformant
implementation). Ext4, XFS and btrfs all have strictly ordered
metadata crash recovery semantics and all of the crash recovery
tests expect this behaviour from the filesytem being tested. The
underlying intention is that by encoding it into these tests, all
widely used and future linux filesystems meet or exceed this crash
integrity requirement.

IOWs, changing the test is the wrong thing to do on many levels....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
