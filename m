Received: from mx1.redhat.com ([209.132.183.28]:59970 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231AbbLDU45 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 15:56:57 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 2E797C0A525E
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 20:56:57 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] xfs/259 - inherit $_fs_has_crcs
References: <x494mfy5igz.fsf@segfault.boston.devel.redhat.com>
	<x49zixq43mk.fsf@segfault.boston.devel.redhat.com>
	<20151204204557.GA64533@bfoster.bfoster>
Date: Fri, 04 Dec 2015 15:56:56 -0500
In-Reply-To: <20151204204557.GA64533@bfoster.bfoster> (Brian Foster's message
	of "Fri, 4 Dec 2015 15:45:57 -0500")
Message-ID: <x49egf23pbb.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Brian Foster <bfoster@redhat.com> writes:

>> > @@ -72,7 +72,7 @@ for del in $sizes_to_check; do
>> >  	lofile=$(losetup -f)
>> >  	losetup $lofile "$testfile"
>> >  	"$MKFS_XFS_PROG" -l size=32m -b size=$blocksize $lofile \
>> > -					>/dev/null || echo "mkfs failed!"
>> > +			 -m crc=$_fs_has_crcs>/dev/null || echo "mkfs failed!"
>> 
>> It occurs to me that this may break on systems using a mkfs.xfs that
>> does not support the "-m crc" option.  Is there a standard way to test
>> for such things?
>> 
>
> I suppose we could add a $crc_options to the mkfs command line that can
> be set appropriately in the if/else. If the test fs has crc support, set
> crc_options="-m crc=1". Otherwise, maybe use
> '_scratch_mkfs_xfs_supported -m crc=0' (from
> common/rc:_require_xfs_mkfs_crc()) in the else condition to either set
> crc_options="-m crc=0" or drop the option (crc_options="")?

How does one determine whether mkfs.xfs supports the crc= option?  That
was the question I tried to ask.  ;-)

> Another option could be just to unconditionally set crc=[0|1] and add a
> _require_xfs_crc() to the test, but that would just skip the test on
> older systems.

I think we can agree that would be a bad approach.  :)

-Jeff
