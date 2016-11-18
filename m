Received: from mail.kernel.org ([198.145.29.136]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbcKRFLR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Nov 2016 00:11:17 -0500
Date: Thu, 17 Nov 2016 21:11:13 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] xfstests-bld: add f2fs support
Message-ID: <20161118051113.GA24878@jaegeuk>
References: <1479412353-35154-1-git-send-email-ebiggers@google.com>
 <20161118043835.GA22707@jaegeuk>
 <20161118045157.nclslkbhumszrggz@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161118045157.nclslkbhumszrggz@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 17, 2016 at 11:51:57PM -0500, Theodore Ts'o wrote:
> On Thu, Nov 17, 2016 at 08:38:35PM -0800, Jaegeuk Kim wrote:
> > > +    /sbin/fsck.f2fs -f "$dev"
> > 
> > Could you change to call fsck.f2fs instead of /sbin/xx?
> > I'm almost finished to import f2fs-tools in xfstests-bld for kvm-xfstests.
> > Given f2fs-tools from git, it seems /sbin/xx doesn't work.
> 
> So why won't /sbin/fsck.f2fs not work?  The /sbin/fsck driver does
> assume that /sbin/fsck.<type> will work, and other file systems do
> have hard links or put their actual file system checker there:
> 
> % ls /sbin/fsck.*
> 36 /sbin/fsck.cramfs*  0 /sbin/fsck.ext3@     60 /sbin/fsck.fat*     4 /sbin/fsck.nfs*
> 0 /sbin/fsck.exfat@    0 /sbin/fsck.ext4@     76 /sbin/fsck.minix*   0 /sbin/fsck.vfat@
> 0 /sbin/fsck.ext2@     0 /sbin/fsck.ext4dev@   0 /sbin/fsck.msdos@   4 /sbin/fsck.xfs*
> 

IIUC, I guess it'd be okay if VM installed that as a package. I tried to add
f2fs-tools repo likewise fio, I could't find /sbin/mkfs.f2fs, even if it was
installed into bld/sbin/. Instead, bld/sbin/* were copied into xfstests/bin/
in VM, which enables to execute mkfs.f2fs globally through $PATH.

I set up an almost default kvm-xfstests, and I could see:

# ls /sbin/mkfs*
/sbin/mkfs	/sbin/mkfs.cramfs  /sbin/mkfs.ext3  /sbin/mkfs.ext4dev
/sbin/mkfs.bfs	/sbin/mkfs.ext2    /sbin/mkfs.ext4  /sbin/mkfs.minix

# ls /root/xfstests/bin/mkfs.*
/root/xfstests/bin/mkfs.f2fs  /root/xfstests/bin/mkfs.xfs

Let me know, if I'm missing something.

Thanks,

> 
> > > +    /sbin/mkfs.f2fs -q $opts "$dev"
> > 
> > Ditto, mkfs.f2fs.
> 
> Ditto:
> 
> % ls /sbin/mkfs.*
>  28 /sbin/mkfs.bfs*	  0 /sbin/mkfs.ext3@	  76 /sbin/mkfs.minix*	352 /sbin/mkfs.xfs*
>  36 /sbin/mkfs.cramfs*	  0 /sbin/mkfs.ext4@	   0 /sbin/mkfs.msdos@
>   0 /sbin/mkfs.exfat@	  0 /sbin/mkfs.ext4dev@    0 /sbin/mkfs.ntfs@
>   0 /sbin/mkfs.ext2@	 36 /sbin/mkfs.fat*	   0 /sbin/mkfs.vfat@
> 
> 							- Ted
