Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbdL0TLc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Dec 2017 14:11:32 -0500
Date: Wed, 27 Dec 2017 11:11:30 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: xfstests: generic/342 run failed in f2fs
Message-ID: <20171227191130.GB13490@jaegeuk-macbookpro.roam.corp.google.com>
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
 <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
 <20171225163102.GB14399@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171225163102.GB14399@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Sandeen <sandeen@sandeen.net>, Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, philip.li@intel.com
List-ID: <fstests@vger.kernel.org>

On 12/25, Theodore Ts'o wrote:
> On Sun, Dec 24, 2017 at 11:47:20PM -0800, Eric Sandeen wrote:
> > Filesystems are free to do /more/ than the minimum required by posix -
> > see ext4_sync_parent for example.  Or xfs_finish_rename, for synchronous
> > mounts:
> > 
> >          * If this is a synchronous mount, make sure that the rename transaction
> >          * goes to disk before returning to the user.
> >          */
> >         if (tp->t_mountp->m_flags & (XFS_MOUNT_WSYNC|XFS_MOUNT_DIRSYNC))
> >                 xfs_trans_set_sync(tp);
> > 
> > so behavior can be fs-dependent, or mount option dependent, etc.
> > 
> > But to be portable, if an app wants directory changes to be persistent
> > before proceeding, it must fsync the directory after making changes.
> > 
> > I don't know about f2fs's design intent, whether it guarantees more
> > than posix requires, but to guarantee that this test works on any posix
> > fs, I think that directory fsync is needed.
> 
> Agreed that this is a test bug, and we should add the fsync to the
> parent directory.

Agreed too. Or, how about using "-o dirsync"?

> 
> It might also be a good idea for f2fs to do more, given that fsync is
> a slow enough operation that so long as you can make sure the fsync of
> the parent directory happens within the same atomic update as the
> child inode, you might as well give the more expansive guarantee.  But
> obviously that's up to the f2fs developers to decide whether they want
> to do that work.

Indeed. Actually, since one of our goals was to reduce fsync latencies for
Android, we decided to support posix in a minimum way. In order to avoid
complex directory updates recursively, however, we allowed the fsync on
directories to trigger checkpoint requiring many IO operations.

IMHO, as a quick fix, it seems we need to handle MS_DIRSYNC likewse xfs.
#define MS_DIRSYNC      128     /* Directory modifications are synchronous */

Thanks,

> 
> Cheers,
> 
>       	     	       	       	    - Ted
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
