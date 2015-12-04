Received: from mx1.redhat.com ([209.132.183.28]:59699 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754938AbbLDUp7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 15:45:59 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 2C3A98EFE6
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 20:45:59 +0000 (UTC)
Date: Fri, 4 Dec 2015 15:45:57 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [patch] xfs/259 - inherit $_fs_has_crcs
Message-ID: <20151204204557.GA64533@bfoster.bfoster>
References: <x494mfy5igz.fsf@segfault.boston.devel.redhat.com>
 <x49zixq43mk.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49zixq43mk.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 04, 2015 at 10:47:47AM -0500, Jeff Moyer wrote:
> Jeff Moyer <jmoyer@redhat.com> writes:
> 
> > Hi,
> >
> > When running xfs/259 against a file system that has crcs disabled, the
> > test will fail.  The problem is that mkfs.xfs now defaults to enabling
> > crcs.  So, when the test checks the underlying file system and finds
> > crcs are disabled, it tries to create a file system with a block size
> > that is too small to support them.  The solution is to explicitly
> > specify the crc feature.
> >
> > Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> >
> > diff --git a/tests/xfs/259 b/tests/xfs/259
> > index 16c1935..e0022ce 100755
> > --- a/tests/xfs/259
> > +++ b/tests/xfs/259
> > @@ -72,7 +72,7 @@ for del in $sizes_to_check; do
> >  	lofile=$(losetup -f)
> >  	losetup $lofile "$testfile"
> >  	"$MKFS_XFS_PROG" -l size=32m -b size=$blocksize $lofile \
> > -					>/dev/null || echo "mkfs failed!"
> > +			 -m crc=$_fs_has_crcs>/dev/null || echo "mkfs failed!"
> 
> It occurs to me that this may break on systems using a mkfs.xfs that
> does not support the "-m crc" option.  Is there a standard way to test
> for such things?
> 

I suppose we could add a $crc_options to the mkfs command line that can
be set appropriately in the if/else. If the test fs has crc support, set
crc_options="-m crc=1". Otherwise, maybe use
'_scratch_mkfs_xfs_supported -m crc=0' (from
common/rc:_require_xfs_mkfs_crc()) in the else condition to either set
crc_options="-m crc=0" or drop the option (crc_options="")?

Another option could be just to unconditionally set crc=[0|1] and add a
_require_xfs_crc() to the test, but that would just skip the test on
older systems.

Brian

> -Jeff
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
