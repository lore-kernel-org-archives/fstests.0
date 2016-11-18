Received: from imap.thunk.org ([74.207.234.97]:41944 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbcKREwE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 17 Nov 2016 23:52:04 -0500
Date: Thu, 17 Nov 2016 23:51:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: add f2fs support
Message-ID: <20161118045157.nclslkbhumszrggz@thunk.org>
References: <1479412353-35154-1-git-send-email-ebiggers@google.com>
 <20161118043835.GA22707@jaegeuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161118043835.GA22707@jaegeuk>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 17, 2016 at 08:38:35PM -0800, Jaegeuk Kim wrote:
> > +    /sbin/fsck.f2fs -f "$dev"
> 
> Could you change to call fsck.f2fs instead of /sbin/xx?
> I'm almost finished to import f2fs-tools in xfstests-bld for kvm-xfstests.
> Given f2fs-tools from git, it seems /sbin/xx doesn't work.

So why won't /sbin/fsck.f2fs not work?  The /sbin/fsck driver does
assume that /sbin/fsck.<type> will work, and other file systems do
have hard links or put their actual file system checker there:

% ls /sbin/fsck.*
36 /sbin/fsck.cramfs*  0 /sbin/fsck.ext3@     60 /sbin/fsck.fat*     4 /sbin/fsck.nfs*
0 /sbin/fsck.exfat@    0 /sbin/fsck.ext4@     76 /sbin/fsck.minix*   0 /sbin/fsck.vfat@
0 /sbin/fsck.ext2@     0 /sbin/fsck.ext4dev@   0 /sbin/fsck.msdos@   4 /sbin/fsck.xfs*


> > +    /sbin/mkfs.f2fs -q $opts "$dev"
> 
> Ditto, mkfs.f2fs.

Ditto:

% ls /sbin/mkfs.*
 28 /sbin/mkfs.bfs*	  0 /sbin/mkfs.ext3@	  76 /sbin/mkfs.minix*	352 /sbin/mkfs.xfs*
 36 /sbin/mkfs.cramfs*	  0 /sbin/mkfs.ext4@	   0 /sbin/mkfs.msdos@
  0 /sbin/mkfs.exfat@	  0 /sbin/mkfs.ext4dev@    0 /sbin/mkfs.ntfs@
  0 /sbin/mkfs.ext2@	 36 /sbin/mkfs.fat*	   0 /sbin/mkfs.vfat@

							- Ted
