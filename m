Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:9632 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751315AbcFVAJb (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2016 20:09:31 -0400
Date: Wed, 22 Jun 2016 10:00:40 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v4 2/2] xfs/006: new case to test xfs fail_at_unmount
 error handling
Message-ID: <20160622000040.GF27480@dastard>
References: <1466429073-10124-1-git-send-email-zlang@redhat.com>
 <1466429073-10124-2-git-send-email-zlang@redhat.com>
 <20160621070818.GT5140@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160621070818.GT5140@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, sandeen@redhat.com, cem@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 21, 2016 at 03:08:18PM +0800, Eryu Guan wrote:
> On Mon, Jun 20, 2016 at 09:24:33PM +0800, Zorro Lang wrote:
> > +# real QA test starts here
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_dm_target error
> > +_require_scratch
> > +
> > +_scratch_mkfs > $seqres.full 2>&1
> > +_require_fs_sysfs $SCRATCH_DEV error/fail_at_unmount
> 
> Usually we call _require_xxx before mkfs and do the real test, a comment
> to explain why we need to mkfs first would be good.

Ok, so why do we need to test the scratch device for this
sysfs file check? We've already got the test device mounted, and
filesystems tend to present identical sysfs control files for all
mounted filesystems.

i.e. this _require_fs_sysfs() function could just drop the device
and check the test device for whether the sysfs entry exists. If it
doesn't, then the scratch device isn't going to have it, either.

> > +# umount will cause XFS try to writeback something to root inode.
> > +# So after load error table, it can trigger umount fail.
> > +_dmerror_load_error_table
> > +_dmerror_unmount
> 
> Unmount still doesn't hang for me when I set fail_at_unmount to 0. Maybe
> it's hard to hit the correct timing everytime.

I wouldn't expect unmount to hang if you just "mount/pull
device/unmount" like this test appears to be doing. The filesystem
has to have dirty metadata for it to reliably hang. run a short
fsstress load, pull the device while it is running, then unmount.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
