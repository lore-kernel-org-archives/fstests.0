Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED63AB272
	for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553906; cv=none; b=DvBtZo4MvTAqFfj4oOy0Ne/DCb+XKPU4J5SsVP4l3f+hSaV+XQzpzEpUFfcrwntPm/rw2m7JlIr9VeapmvlhPzWFLlARhpr/f4gEQCbLR8Bgg1k8q9oMM6f+S3jhymsGODPjsHhdOB/j15dUoTkkA+L/ZZYeV6KduuHNvIEznGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553906; c=relaxed/simple;
	bh=FJTJSW4RBgRHhiJLHEne1ZXbIe5LeBKjjyu1pySs4nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ4oOp8OXL+5LMxywZM1WfnASP3AUcx4LwkEjMIaeAAOsT7oqMjvVnH+A9WooaWMkNefhd0fj5RiNmQW4BLMLC+aMbvmyDhtELYn6WuwPRh0V6NzJsPsyynpvSrD9SkVW+0005RsMc6mHULNkJ6iTQqluN1Od5oCzK+QUAgdzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNaQbMSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNaQbMSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3071F000E9;
	Mon, 15 Jun 2026 20:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553905;
	bh=flt5OZVzqvECwhJj1n8rD2o3bmiyuee+0PRxFjcuIa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hNaQbMSISh5yqrwMO0XQR6hWxcdnO0pAiWgYO5Pkw7r4azv/BTKKomMAEEh0U/a4F
	 mNVDg0LtngBfQjBHYLZtowcY7GNeJMuZI00E08ihKKNvJ6LyYr9ZZTyqT8iRZb4riA
	 SnkW9OGLcnajVZdJ9A2YrOlMCAf5p1JD12BkDJ633efwvc7E8/oveQXmDEee4sbegD
	 PF4tsG74+8Rwbsrrzjz/ET8qqe4aGB6g5x5vSKaY+zr+5my0bFQDqC78qzi+A65SUV
	 vQcQLNFut+TyQp4Ns/nbec6cjYmM3iVhQ9RAv5whvzAZpZWG+Odav2yv6069/RobR0
	 rZpuSSK0YenTg==
Date: Tue, 16 Jun 2026 04:05:00 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/025: test to do sanity check section type correctly
 in f2fs GC
Message-ID: <ajBZEtrLmRZt0AA1@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260612005802.3017709-1-chao@kernel.org>
 <ai7YFkAK8sBL4jXm@zlang-mailbox>
 <b32998c0-17e3-4b81-a474-4a408aa7fa32@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b32998c0-17e3-4b81-a474-4a408aa7fa32@kernel.org>

On Mon, Jun 15, 2026 at 04:22:34PM +0800, Chao Yu wrote:
> On 6/15/26 01:16, Zorro Lang wrote:
> > On Fri, Jun 12, 2026 at 12:58:02AM +0000, Chao Yu wrote:
> >> Without commit 520760b9f915 ("f2fs: optimize representative type determination
> >> in GC"), f2fs GC will report inconsistent segment type in large section issue,
> >> and then it will force to shutdown filesystem.
> >>
> >> [  768.190903] F2FS-fs (loop51): Inconsistent segment (3) type [1, 0] in SIT and SSA
> >>
> >> The reason is f2fs kernel will assume all segment type inside large section is
> >> the same, during GC it loads type from one segment and compare it to other
> >> segments' type, however due to recovery flow, the chosen segment may has zero
> >> valid blocks w/ different segment type, since the segment is invalid(free) one,
> >> it will never be migrated, so that we should not treat such state as abnormal
> >> condition.
> >>
> >> This testcase is created to simulate above condition to see whether f2fs kernel
> >> module can handle it correctly
> >>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >> v2:
> >> - clear MKFS_OPTIONS and MOUNT_OPTIONS to guarantee block allocation is as expected.
> > 
> > Hi Chao,
> > 
> > Sorry, I just noticed your reply to my review on the previous patch version.
> > Due to some unexpected shake-ups recently, I’ve been bogged down with setting
> > up and modifying various new system environments, and I accidentally marked
> > some unread emails as read.
> 
> No worries. :)
> 
> > 
> > The patch looks good to me, with just a few picky review points below:
> 
> Thanks Zorro for taking a look.
> 
> > 
> >>  tests/f2fs/025     | 92 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/f2fs/025.out |  2 +
> >>  2 files changed, 94 insertions(+)
> >>  create mode 100644 tests/f2fs/025
> >>  create mode 100644 tests/f2fs/025.out
> >>
> >> diff --git a/tests/f2fs/025 b/tests/f2fs/025
> >> new file mode 100644
> >> index 000000000..397e5439a
> >> --- /dev/null
> >> +++ b/tests/f2fs/025
> >> @@ -0,0 +1,92 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2026 Chao Yu <chao@kernel.org>
> >> +#
> >> +# FS QA Test No. f2fs/025
> >> +#
> >> +# Check whether f2fs will encounter cp_error (Inconsistent segment type)
> >> +# when doing sanity check on type of segments inside large section during
> >> +# garbage collection.
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick
> >> +
> >> +_fixed_by_kernel_commit 520760b9f915 \
> >> +	"f2fs: optimize representative type determination in GC"
> >> +
> >> +. ./common/filter
> >> +
> >> +_cleanup()
> >> +{
> >> +	cd /
> >> +	rm -r -f $tmp.*
> >> +}
> > 
> > This _cleanup() function is same as default. It can be removed.
> 
> Will remove.
> 
> > 
> >> +
> >> +_require_scratch
> >> +_require_xfs_io_command "pwrite"
> >> +_require_xfs_io_command "truncate"
> >> +_require_command "$F2FS_IO_PROG" f2fs_io
> >> +_require_check_dmesg
> >> +
> >> +# Clear options to avoid interference from external configurations
> >> +export MKFS_OPTIONS=""
> >> +export MOUNT_OPTIONS=""
> >> +
> >> +# Format with 96MB size and 2 segments per section
> >> +_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
> >> +
> >> +# Mount with mode=lfs
> >> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
> >                               ^^^^^^^^^^^^^^^^^^^^
> > It's helpless, due to if _scratch_mount fails, it exit() directly.
> 
> Right, will fix.
> 
> > 
> >> +
> >> +# Create files to fill whole filesystem, then segment type will be changed to node type
> >> +for ((i=0;i<5120;i++)) do
> >> +	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1
> >> +done
> >> +sync
> >> +
> >> +# Remove all files to create free(empty) node segments
> >> +rm -f $SCRATCH_MNT/*
> >> +sync
> >> +
> >> +# Allocate free space so that we have chance to reuse free(empty) node segments
> >> +$XFS_IO_PROG -f -c "pwrite -b 4k 0 1928k" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +sync
> >> +
> >> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +sync
> >> +
> >> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 8M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 32K" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >> +
> >> +# Shutdown the filesystem without checkpoint
> >> +$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1
> > 
> > I'm wondering if we can have f2fs supporting in common _scratch_shutdown
> > helper :)
> 
> I think we can change f2fs testcase to use _scratch_shutdown because the definition of
> nologflush shutdown interface is the same as xfs':
> 
> /*
>  * should be same as XFS_IOC_GOINGDOWN.
>  * Flags for going down operation used by FS_IOC_GOINGDOWN
>  */
> #define F2FS_IOC_SHUTDOWN	_IOR('X', 125, __u32)	/* Shutdown */
> #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
> 
> #define XFS_IOC_GOINGDOWN	     _IOR ('X', 125, uint32_t)
> #define XFS_FSOP_GOING_FLAGS_NOLOGFLUSH		0x2	/* don't flush log nor data */
> 
> > 
> >> +
> >> +_scratch_unmount >> $seqres.full 2>&1
> >                     ^^^^^^^^^^^^^^^^^^^^
> > 
> > If unmount fails, how about let it output the errors, to break the golden image?
> 
> Yes, it's better.
> 
> > 
> >> +
> >> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
> >                               ^^^^^^^^^^^^^^^^^^^^
> >                               helpless
> 
> Will fix.
> 
> > 
> >> +
> >> +# Run urgent_gc mode to trigger garbage collection
> >> +dev_name=$(_short_dev $SCRATCH_DEV)
> >> +if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
> >> +	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
> >> +fi
> > 
> > Hmm... what if there's not /sys/fs/f2fs/$dev_name/gc_urgent? Does it
> > affect the test result?
> > 
> > If it does, this's a necessary requirement for this test, we shouldn't
> > ignore it and keep running. Does $F2FS_IO_PROG provide a command to
> > make a force GC? Or we need to check this file and _notrun if it's
> > not existed.
> 
> Ah, right, that's good point!
> 
> We can use "$F2FS_IO_PROG gc_urgent <dev_name> run 5" instead, it will do below commands:

Great, I just hope the *gc_urgent* isn't a new feature which needs something likes:
`_require_f2fs_io gc_urgent` (there's not _require_f2fs_io:)

> 1. echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
> 2. sleep 5 seconds
> 3. echo 0 > /sys/fs/f2fs/$dev_name/gc_urgent

It also depends on the /sys/fs/f2fs/$dev_name/gc_urgent too. So we have to face
the same question:
  If this file doesn't exist, should this test case _notrun?

Thanks,
Zorro

> 
> > 
> >> +
> >> +# Wait background GC thread to wake up to run and potentially encounter the inconsistency
> >> +sleep 5
> > 
> > Does this sleep try to wait above "echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent"?
> > If so, it makes more sense to move it into the "if-then" logic.
> > 
> >> +
> >> +_scratch_unmount >> $seqres.full 2>&1
> >                     ^^^^^^^^^^^^^^^^^^^^
> > Same as above.
> 
> Will fix.
> 
> > 
> >> +
> >> +# Check whether the dmesg has the warning indicating the bug
> >> +_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
> >> +	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
> >> +
> >> +echo "Silence is golden"
> >> +status=0
> >> +exit
> > 
> > We've replaced "status=0;exit;" with "_exit 0".
> 
> Will fix.
> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
> >> diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
> >> new file mode 100644
> >> index 000000000..3d70951ef
> >> --- /dev/null
> >> +++ b/tests/f2fs/025.out
> >> @@ -0,0 +1,2 @@
> >> +QA output created by 025
> >> +Silence is golden
> >> -- 
> >> 2.49.0
> >>
> 
> 
