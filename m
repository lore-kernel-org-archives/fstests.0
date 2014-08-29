Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:2137 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751470AbaH2CwY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Aug 2014 22:52:24 -0400
Date: Fri, 29 Aug 2014 12:52:18 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH xfstests] xfs: add tests for XFS_IOC_FSSETXATTR behaviour
Message-ID: <20140829025218.GG26465@dastard>
References: <20140718191314.GB27801@teal.hq.k1024.org>
 <1409199840-16907-1-git-send-email-iusty@k1024.org>
 <20140828101628.GS20518@dastard>
 <20140828222854.GB29940@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140828222854.GB29940@google.com>
Sender: fstests-owner@vger.kernel.org
To: Iustin Pop <iustin@google.com>
Cc: Iustin Pop <iusty@k1024.org>, xfs@oss.sgi.com, hch@infradead.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 28, 2014 at 03:28:54PM -0700, Iustin Pop wrote:
> On Don, Aug 28, 2014 at 08:16:28 +1000, Dave Chinner wrote:
> > [cc fstests@vger.kernel.org]
> > 
> > On Wed, Aug 27, 2014 at 09:24:00PM -0700, Iustin Pop wrote:
> > > Add two tests that check for correct behaviour of XFS_IOC_FSSETXATTR:
> > > 
> > > - 307: check that extent size can always be set on a directory
> > > - 308: check that setting a non-zero extent size directly via the ioctl
> > >   sets the expected flags (EXTSIZE and EXTSZINHERIT)
> > > 
> > > Signed-off-by: Iustin Pop <iusty@k1024.org>
> > 
> > Minor stuff first:
> > 
> > - xfstests patches should be sent to fstests@vger.kernel.org now.
> 
> OK, will do. There was nothing written in the git repository's README,
> hence I chose what I thought best.

Documentation always needs updating, and stuff is in the process of
being moved around.

> > > +# Copyright (c) 2014 Google Inc.  All Rights Reserved.
> > 
> > Is that correct? It doesn't match the email address you sent this
> > from and I've never seen you post from a @google.com address.  I
> > always like to check that the copyright assignment is correct in
> > situations like this...
> 
> It is correct indeed (and thanks for double-checking). I prefer to send
> my interactions/contributions done not as part of my job using my
> personal address (hence I always wrote to xfs@ from the same address),
> but even in that case, the copyright remains with my employer.
> 
> Just as a confirmation, sending this email from my @google.com address.

Thanks, I'll know in future ;)

> > > +# now create a 'big' (with extents) directory
> > > +mkdir $big
> > > +idx=1
> > > +while xfs_bmap $big | grep -q "no extents"; do
> > > +	touch $big/$idx
> > > +	idx=$((idx+1))
> > > +	if [ "$idx" -gt 1048576 ]; then
> > > +		# still no extents? giving up
> > > +		echo "Can't make a directory to have extents even after 1M files" 1>&2
> > > +		exit
> > > +	fi
> > > +done
> > 
> > urk. largest inode size is 2kb, which means at most it can fit less
> > than 100 dirents in the inode before spilling to extent form. So
> > just do a loop that creates 1000 files - there's no need to
> > overengineer the test code.
> 
> Will do.  It's fine to still check that the directory does have extents,
> I hope?

$XFS_IO_PROG -c 'bmap -vp' $big | _filter_bmap

> > > +int main(int argc, char **argv) {
> > > +	struct fsxattr fa;
> > > +	int fd = open(argv[1], O_RDONLY);
> > > +	if (fd < 0) {
> > > +		perror("open");
> > > +		return 1;
> > > +	}
> > > +	fa.fsx_xflags = 0;
> > > +	fa.fsx_extsize = 1048576 * 8;
> > > +	int r = xfsctl(argv[1], fd, XFS_IOC_FSSETXATTR, &fa);
> > 
> > .... that code is quite broken. Yes, it would work to set the
> > appropriate extent size flags with the kernel
> > changes you made, but that's not how this ioctl works.
> > 
> > i.e. it will cause any flag bits that are set on the inode to be
> > cleared
> 
> Good point…
> 
> > and it's likely to fail on old kernels beacuse they have
> > very different behaviour to what your patch does.
> 
> OK, that I didn't know. (Would you mind quickly explaining?)

The extsize hint on the inode is not used by the kernel code unless
the XFS_XFLAG_EXTSIZE is also set. So existing kernels may set the
inode extszhint field, but the code will ignore it because the flags
didn't get set on the inode. See xfs_get_extsz_hint().

With your kernel changes, the above *invalid* code will result in
the flags being set on the inode, and so there's a change of
behaviour from "old kernel, does not trigger extsz behaviour" to
"new kernel, extsz behaviour is invoked".

> > We have xfs_io precisely so that we don't have to maintain random
> > test code like this throughout xfstests - do it once, do it right,
> > use it everywhere.
> 
> I totally agree that xfs_io is what people should use, but I disagree on
> the use of xfs_io in this particular test, let me explain why.
> 
> With 3.16-rc1 at least, it is possible to set fsx_extsize to a non-zero
> value, without setting the flags (if you call the ioctl directly). Such
> an inode  will be (unless I'm mistaken) flagged with a warning by
> xfs_repair, which means that it's an invalid inode state.

Yes, since this commit bd5683f ("xfs_repair: validate inode di_flags
field") in 2011 repair will flag that the hint is non-zero but the
correct flags are not set. Likewise it will warn if the wrong flags
are set. You can get wrong flags set on the inode in many ways, but
historically the kernel and repair utilities haven't cared.

> So in my view, there's a kernel bug, in that it allows a user land
> application to put an inode into a "wrong" state. This particular test
> is designed to reproduce this kernel bug, so that the kernel fix can be
> verified that is indeed a fix.

Yes this is not what xfstests is for. If we fix an API bug, there's
little value to testing forever that the API is fixed. What we are
trying to cover is that when the parameters are set correctly that
the behaviour is correct.

If you want to do "is the API validating user input correctly"
testing then that's what trinity is for. Dave Jones has long wanted
to get better ioctl coverage for filesystem specific operations, so
I'd suggest that this is the avenue for testing whether an API
behaves correctly and catches all invalid input.

Then we get to fix all the problems that trinity causes, just like
the mm folk have been doing for the past couple of years...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
