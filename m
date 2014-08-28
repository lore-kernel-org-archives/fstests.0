Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:54946 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaH1W25 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Aug 2014 18:28:57 -0400
Received: by mail-ig0-f179.google.com with SMTP id r2so1705121igi.0
        for <fstests@vger.kernel.org>; Thu, 28 Aug 2014 15:28:57 -0700 (PDT)
Date: Thu, 28 Aug 2014 15:28:54 -0700
From: Iustin Pop <iustin@google.com>
Subject: Re: [PATCH xfstests] xfs: add tests for XFS_IOC_FSSETXATTR behaviour
Message-ID: <20140828222854.GB29940@google.com>
References: <20140718191314.GB27801@teal.hq.k1024.org>
 <1409199840-16907-1-git-send-email-iusty@k1024.org>
 <20140828101628.GS20518@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140828101628.GS20518@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Iustin Pop <iusty@k1024.org>, xfs@oss.sgi.com, hch@infradead.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Don, Aug 28, 2014 at 08:16:28 +1000, Dave Chinner wrote:
> [cc fstests@vger.kernel.org]
> 
> On Wed, Aug 27, 2014 at 09:24:00PM -0700, Iustin Pop wrote:
> > Add two tests that check for correct behaviour of XFS_IOC_FSSETXATTR:
> > 
> > - 307: check that extent size can always be set on a directory
> > - 308: check that setting a non-zero extent size directly via the ioctl
> >   sets the expected flags (EXTSIZE and EXTSZINHERIT)
> > 
> > Signed-off-by: Iustin Pop <iusty@k1024.org>
> 
> Minor stuff first:
> 
> - xfstests patches should be sent to fstests@vger.kernel.org now.

OK, will do. There was nothing written in the git repository's README,
hence I chose what I thought best.

> - can you pick the first unused numbers in the sequence for new
>   tests (xfs/032, xfs/051) so I don't have to renumber them before
>   applying them?

Will do - this is what the 'new' script did (or tried to do, as it
doesn't seem to work reliably).

> - a patch per new test - it makes it easier to review and apply as i
>   don't have to split patches into multiple commits...

Will do so when resending.

> > diff --git a/tests/xfs/307 b/tests/xfs/307
> > new file mode 100755
> > index 0000000..e8f3576
> > --- /dev/null
> > +++ b/tests/xfs/307
> > @@ -0,0 +1,87 @@
> > +#! /bin/bash
> > +# FS QA Test No. 307
> > +#
> > +# Test that setting extent size on directories work even for large
> > +# directories.
> 
> What is a "large directory"? Wouldn't it be better to describe the
> test as "Determine whether the extent size hint can be set on
> directories with allocated extents correctly"?

Indeed that's better, I'll update.

> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2014 Google Inc.  All Rights Reserved.
> 
> Is that correct? It doesn't match the email address you sent this
> from and I've never seen you post from a @google.com address.  I
> always like to check that the copyright assignment is correct in
> situations like this...

It is correct indeed (and thanks for double-checking). I prefer to send
my interactions/contributions done not as part of my job using my
personal address (hence I always wrote to xfs@ from the same address),
but even in that case, the copyright remains with my employer.

Just as a confirmation, sending this email from my @google.com address.

> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_test
> 
> Not needed, doesn't use the test device.

Ack.

> > +_require_scratch
> > +
> > +_scratch_mkfs_xfs >/dev/null 2>&1
> > +_scratch_mount
> > +
> > +small=$SCRATCH_MNT/small
> > +big=$SCRATCH_MNT/big
> > +
> > +# sanity check on a small directory
> > +mkdir $small
> > +# expect that an empty directory has no extents
> > +xfs_bmap $small | grep -q "no extents"
> 
> Better to use xfs_io directly and filter out $SCRATCH_MNT into the
> golden output file like so:
> 
> $XFS_IO_PROG -c "bmap" $small | _filter_scratch
> 
> which will give:
> 
> SCRATCH_MNT/small: no extents

Oh, nice, thanks!

> > +# and that we can set an extent size on it
> > +xfs_io -c 'extsize 8m' $small
> 
> $XFS_IO_PROG

Ack.

> > +# and finally check that the extent size update has taken place
> > +(cd $SCRATCH_MNT; xfs_io -c 'extsize' small)
> 
> $XFS_IO_PROG -c 'extsize' $small | _filter_scratch

Ack.

> > +# now create a 'big' (with extents) directory
> > +mkdir $big
> > +idx=1
> > +while xfs_bmap $big | grep -q "no extents"; do
> > +	touch $big/$idx
> > +	idx=$((idx+1))
> > +	if [ "$idx" -gt 1048576 ]; then
> > +		# still no extents? giving up
> > +		echo "Can't make a directory to have extents even after 1M files" 1>&2
> > +		exit
> > +	fi
> > +done
> 
> urk. largest inode size is 2kb, which means at most it can fit less
> than 100 dirents in the inode before spilling to extent form. So
> just do a loop that creates 1000 files - there's no need to
> overengineer the test code.

Will do.  It's fine to still check that the directory does have extents,
I hope?

> > +# expect that we can set the extent size on $big as well
> > +xfs_io -c 'extsize 8m' $big
> 
> $XFS_IO_PROG

Ack.

> > +# and that it took effect
> > +(cd $SCRATCH_MNT; xfs_io -c 'extsize' big)
> 
> $XFS_IO_PROG -c 'extsize' $big | _filter_scratch

Ack.

> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/307.out b/tests/xfs/307.out
> > new file mode 100644
> > index 0000000..f825525
> > --- /dev/null
> > +++ b/tests/xfs/307.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 307
> > +[8388608] small
> > +[8388608] big
> > diff --git a/tests/xfs/308 b/tests/xfs/308
> > new file mode 100755
> > index 0000000..7b43836
> > --- /dev/null
> > +++ b/tests/xfs/308
> > @@ -0,0 +1,98 @@
> > +#! /bin/bash
> > +# FS QA Test No. 308
> > +#
> > +# Test that setting extent size on files and directories (directly via
> > +# ioctl and not via xfs_io) sets the correct flags.
> 
> xfs_io uses the ioctl directly - there's no need to write a special
> c program to do this, especially as....
> 
> > +touch $file
> > +mkdir $dir
> > +
> > +cat > $cprog << EOF
> > +#include <stdio.h>
> > +#include <xfs/xfs.h>
> > +
> > +int main(int argc, char **argv) {
> > +	struct fsxattr fa;
> > +	int fd = open(argv[1], O_RDONLY);
> > +	if (fd < 0) {
> > +		perror("open");
> > +		return 1;
> > +	}
> > +	fa.fsx_xflags = 0;
> > +	fa.fsx_extsize = 1048576 * 8;
> > +	int r = xfsctl(argv[1], fd, XFS_IOC_FSSETXATTR, &fa);
> 
> .... that code is quite broken. Yes, it would work to set the
> appropriate extent size flags with the kernel
> changes you made, but that's not how this ioctl works.
> 
> i.e. it will cause any flag bits that are set on the inode to be
> cleared

Good point…

> and it's likely to fail on old kernels beacuse they have
> very different behaviour to what your patch does.

OK, that I didn't know. (Would you mind quickly explaining?)

> IOWs, setting fsx_extsize without setting either XFS_XFLAG_EXTSIZE
> or XFS_XFLAG_EXTSZINHERIT is bad practice. The kernel is left to
> guess what you actually wanted to be done - the flags are supposed
> to tell the kernel that the fsx_extsize value is meaningful, not the
> other way around.

See below.

> FWIW, the xfs_io code is *exactly* what applications should be
> doing to set the extent size or any other inode flag. i.e:
> 
> 1. stat the fd to determine the type.
> 2. populate the fsxattr structure with the existing inode flags
> 3. change the flags/fields of the fsxattr structure appropriately
> 4. set the new values to the inode.
> 
> i.e, from io/open.c:
> 
> static int
> set_extsize(const char *path, int fd, long extsz)
> {
>         struct fsxattr  fsx;
>         struct stat64   stat;
> 
>         if (fstat64(fd, &stat) < 0) {
>                 perror("fstat64");
>                 return 0;
>         }
>         if ((xfsctl(path, fd, XFS_IOC_FSGETXATTR, &fsx)) < 0) {
>                 printf("%s: XFS_IOC_FSGETXATTR %s: %s\n",
>                         progname, path, strerror(errno));
>                 return 0;
>         }
> 
>         if (S_ISREG(stat.st_mode)) {
>                 fsx.fsx_xflags |= XFS_XFLAG_EXTSIZE;
>         } else if (S_ISDIR(stat.st_mode)) {
>                 fsx.fsx_xflags |= XFS_XFLAG_EXTSZINHERIT;
>         } else {
>                 printf(_("invalid target file type - file %s\n"), path);
>                 return 0;
>         }
>         fsx.fsx_extsize = extsz;
> 
>         if ((xfsctl(path, fd, XFS_IOC_FSSETXATTR, &fsx)) < 0) {
>                 printf("%s: XFS_IOC_FSSETXATTR %s: %s\n",
>                         progname, path, strerror(errno));
>                 return 0;
>         }
> 
>         return 0;
> }
> 
> We have xfs_io precisely so that we don't have to maintain random
> test code like this throughout xfstests - do it once, do it right,
> use it everywhere.

I totally agree that xfs_io is what people should use, but I disagree on
the use of xfs_io in this particular test, let me explain why.

With 3.16-rc1 at least, it is possible to set fsx_extsize to a non-zero
value, without setting the flags (if you call the ioctl directly). Such
an inode  will be (unless I'm mistaken) flagged with a warning by
xfs_repair, which means that it's an invalid inode state.

So in my view, there's a kernel bug, in that it allows a user land
application to put an inode into a "wrong" state. This particular test
is designed to reproduce this kernel bug, so that the kernel fix can be
verified that is indeed a fix.

I can't use xfs_io here, because it will do the "right" thing - set the
EXTSIZE/EXTSZINHERIT flags correctly; but this is a test that the kernel
protects the inode invariants, not that xfs_io does so.

Alternatively, you could say that it's perfectly fine to have a non-zero
fsx_extsize, and that only when the flag is set it should be taken into
account; but I don't think that is what the rest of the code expects
today.

So, I'm fine either way, but I would to fix this so that all the code
agrees what the correct states for an inode are, and that the kernel
prevents user space from violating this assumption via a (documented)
ioctl. Just let me know which are the correct states.

Thanks for the feedback, and for such a quick reply.

iustin
