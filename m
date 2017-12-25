Received: from imap.thunk.org ([74.207.234.97]:54658 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752321AbdLYQbN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Dec 2017 11:31:13 -0500
Date: Mon, 25 Dec 2017 11:31:02 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: xfstests: generic/342 run failed in f2fs
Message-ID: <20171225163102.GB14399@thunk.org>
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
 <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, philip.li@intel.com
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 24, 2017 at 11:47:20PM -0800, Eric Sandeen wrote:
> Filesystems are free to do /more/ than the minimum required by posix -
> see ext4_sync_parent for example.  Or xfs_finish_rename, for synchronous
> mounts:
> 
>          * If this is a synchronous mount, make sure that the rename transaction
>          * goes to disk before returning to the user.
>          */
>         if (tp->t_mountp->m_flags & (XFS_MOUNT_WSYNC|XFS_MOUNT_DIRSYNC))
>                 xfs_trans_set_sync(tp);
> 
> so behavior can be fs-dependent, or mount option dependent, etc.
> 
> But to be portable, if an app wants directory changes to be persistent
> before proceeding, it must fsync the directory after making changes.
> 
> I don't know about f2fs's design intent, whether it guarantees more
> than posix requires, but to guarantee that this test works on any posix
> fs, I think that directory fsync is needed.

Agreed that this is a test bug, and we should add the fsync to the
parent directory.

It might also be a good idea for f2fs to do more, given that fsync is
a slow enough operation that so long as you can make sure the fsync of
the parent directory happens within the same atomic update as the
child inode, you might as well give the more expansive guarantee.  But
obviously that's up to the f2fs developers to decide whether they want
to do that work.

Cheers,

      	     	       	       	    - Ted

