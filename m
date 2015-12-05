Received: from mail-pf0-f178.google.com ([209.85.192.178]:34922 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbLEIR3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 5 Dec 2015 03:17:29 -0500
Received: by pfu207 with SMTP id 207so37939008pfu.2
        for <fstests@vger.kernel.org>; Sat, 05 Dec 2015 00:17:29 -0800 (PST)
Date: Sat, 5 Dec 2015 16:09:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [patch] xfs/259 - inherit $_fs_has_crcs
Message-ID: <20151205080915.GA19209@eguan.usersys.redhat.com>
References: <x494mfy5igz.fsf@segfault.boston.devel.redhat.com>
 <x49zixq43mk.fsf@segfault.boston.devel.redhat.com>
 <20151204204557.GA64533@bfoster.bfoster>
 <x49egf23pbb.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49egf23pbb.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 04, 2015 at 03:56:56PM -0500, Jeff Moyer wrote:
> Brian Foster <bfoster@redhat.com> writes:
> 
> >> > @@ -72,7 +72,7 @@ for del in $sizes_to_check; do
> >> >  	lofile=$(losetup -f)
> >> >  	losetup $lofile "$testfile"
> >> >  	"$MKFS_XFS_PROG" -l size=32m -b size=$blocksize $lofile \
> >> > -					>/dev/null || echo "mkfs failed!"
> >> > +			 -m crc=$_fs_has_crcs>/dev/null || echo "mkfs failed!"
> >> 
> >> It occurs to me that this may break on systems using a mkfs.xfs that
> >> does not support the "-m crc" option.  Is there a standard way to test
> >> for such things?
> >> 
> >
> > I suppose we could add a $crc_options to the mkfs command line that can
> > be set appropriately in the if/else. If the test fs has crc support, set
> > crc_options="-m crc=1". Otherwise, maybe use
> > '_scratch_mkfs_xfs_supported -m crc=0' (from
> > common/rc:_require_xfs_mkfs_crc()) in the else condition to either set
> > crc_options="-m crc=0" or drop the option (crc_options="")?
> 
> How does one determine whether mkfs.xfs supports the crc= option?  That
> was the question I tried to ask.  ;-)

You can test for XFS_MKFS_HAS_NO_META_SUPPORT, if it's set to true then
mkfs.xfs has no crc support. More details you can refer to

commit 90a3bfc5b673cc06ec81b7f7dc9788d3e30c5993

Thanks,
Eryu

> 
> > Another option could be just to unconditionally set crc=[0|1] and add a
> > _require_xfs_crc() to the test, but that would just skip the test on
> > older systems.
> 
> I think we can agree that would be a bad approach.  :)
> 
> -Jeff
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
