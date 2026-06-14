Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADD257844
	for <fstests@vger.kernel.org>; Sun, 14 Jun 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457396; cv=none; b=V74BvbDNsqyic3nqO4IV2B16SEU+Ihj8ZKEEppK9XH0+JLd6wkde73HNn86qJsAZaM/03fk7prhKzSYxv7rMAUVsQ2Xub1S48kbuyXCPbh8PmuS2VoZVGUPT8qUYmJggWD4+p/az1JeUiYYyv/2KVkHVGbwFBx+4AjlOaA/Qq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457396; c=relaxed/simple;
	bh=IfBkngfVB5n8MUCaE4D/Rc73YDsw9f+qdv/Q0QGsdQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdQG2ecDRhGmBDATyW4+lrBUFycteGih2T5elmLajfd5GAynP9ynT3gijMTYl19gCCBWV//IUIZFDQrgeY3EAfplT2/a4Q4owS6I1sxBOVfaLGE82Hq+T1UooS+wYlYlFT2WnVC+7zBAOXhireu3HmEEX7mDlr3M0uDqm+RaZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4XAkkZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4XAkkZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F11F000E9;
	Sun, 14 Jun 2026 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781457394;
	bh=RZAnhAitdy9O9O9fVyXz8ikfzogvQdFrgRNB/T3l5pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z4XAkkZ4brnHI0Tn2DfbUoXO/PBddllmCBj+B1kXGdLgiPbG8PbeXcPIAoduX8uVW
	 nLQb0fGcFxPV5MpwB4vrS905MEnJu1PapuNs68xvHknPF04RBnOwh/lTjjTTxharSI
	 hfdpTSc7UUomhdbursv1go3P9xrt6LHVJbBgi3QgP7IScfCMiMdpOgxxQMYIrXRe15
	 QNKEG6MfBtEcSTaYX31wkrXAAXFJInwMTgYBm8HN+Rs64gpTzk1tEIx+fRv3y5lkaq
	 g+t0b8U9d44nJPtZyKI0RDFWk+bYZKHPG8i1oSh/UMmuJxsVhvtE9I7ttHyG7iWT9h
	 ibEdf6crVRSXg==
Date: Mon, 15 Jun 2026 01:16:28 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/025: test to do sanity check section type correctly
 in f2fs GC
Message-ID: <ai7YFkAK8sBL4jXm@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260612005802.3017709-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612005802.3017709-1-chao@kernel.org>

On Fri, Jun 12, 2026 at 12:58:02AM +0000, Chao Yu wrote:
> Without commit 520760b9f915 ("f2fs: optimize representative type determination
> in GC"), f2fs GC will report inconsistent segment type in large section issue,
> and then it will force to shutdown filesystem.
> 
> [  768.190903] F2FS-fs (loop51): Inconsistent segment (3) type [1, 0] in SIT and SSA
> 
> The reason is f2fs kernel will assume all segment type inside large section is
> the same, during GC it loads type from one segment and compare it to other
> segments' type, however due to recovery flow, the chosen segment may has zero
> valid blocks w/ different segment type, since the segment is invalid(free) one,
> it will never be migrated, so that we should not treat such state as abnormal
> condition.
> 
> This testcase is created to simulate above condition to see whether f2fs kernel
> module can handle it correctly
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - clear MKFS_OPTIONS and MOUNT_OPTIONS to guarantee block allocation is as expected.

Hi Chao,

Sorry, I just noticed your reply to my review on the previous patch version.
Due to some unexpected shake-ups recently, I’ve been bogged down with setting
up and modifying various new system environments, and I accidentally marked
some unread emails as read.

The patch looks good to me, with just a few picky review points below:

>  tests/f2fs/025     | 92 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/025.out |  2 +
>  2 files changed, 94 insertions(+)
>  create mode 100644 tests/f2fs/025
>  create mode 100644 tests/f2fs/025.out
> 
> diff --git a/tests/f2fs/025 b/tests/f2fs/025
> new file mode 100644
> index 000000000..397e5439a
> --- /dev/null
> +++ b/tests/f2fs/025
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Chao Yu <chao@kernel.org>
> +#
> +# FS QA Test No. f2fs/025
> +#
> +# Check whether f2fs will encounter cp_error (Inconsistent segment type)
> +# when doing sanity check on type of segments inside large section during
> +# garbage collection.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_fixed_by_kernel_commit 520760b9f915 \
> +	"f2fs: optimize representative type determination in GC"
> +
> +. ./common/filter
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +}

This _cleanup() function is same as default. It can be removed.

> +
> +_require_scratch
> +_require_xfs_io_command "pwrite"
> +_require_xfs_io_command "truncate"
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_check_dmesg
> +
> +# Clear options to avoid interference from external configurations
> +export MKFS_OPTIONS=""
> +export MOUNT_OPTIONS=""
> +
> +# Format with 96MB size and 2 segments per section
> +_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
> +
> +# Mount with mode=lfs
> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
                              ^^^^^^^^^^^^^^^^^^^^
It's helpless, due to if _scratch_mount fails, it exit() directly.

> +
> +# Create files to fill whole filesystem, then segment type will be changed to node type
> +for ((i=0;i<5120;i++)) do
> +	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1
> +done
> +sync
> +
> +# Remove all files to create free(empty) node segments
> +rm -f $SCRATCH_MNT/*
> +sync
> +
> +# Allocate free space so that we have chance to reuse free(empty) node segments
> +$XFS_IO_PROG -f -c "pwrite -b 4k 0 1928k" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +sync
> +
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +sync
> +
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 8M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 32K" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +
> +# Shutdown the filesystem without checkpoint
> +$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1

I'm wondering if we can have f2fs supporting in common _scratch_shutdown
helper :)

> +
> +_scratch_unmount >> $seqres.full 2>&1
                    ^^^^^^^^^^^^^^^^^^^^

If unmount fails, how about let it output the errors, to break the golden image?

> +
> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
                              ^^^^^^^^^^^^^^^^^^^^
                              helpless

> +
> +# Run urgent_gc mode to trigger garbage collection
> +dev_name=$(_short_dev $SCRATCH_DEV)
> +if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
> +	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
> +fi

Hmm... what if there's not /sys/fs/f2fs/$dev_name/gc_urgent? Does it
affect the test result?

If it does, this's a necessary requirement for this test, we shouldn't
ignore it and keep running. Does $F2FS_IO_PROG provide a command to
make a force GC? Or we need to check this file and _notrun if it's
not existed.

> +
> +# Wait background GC thread to wake up to run and potentially encounter the inconsistency
> +sleep 5

Does this sleep try to wait above "echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent"?
If so, it makes more sense to move it into the "if-then" logic.

> +
> +_scratch_unmount >> $seqres.full 2>&1
                    ^^^^^^^^^^^^^^^^^^^^
Same as above.

> +
> +# Check whether the dmesg has the warning indicating the bug
> +_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
> +	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
> +
> +echo "Silence is golden"
> +status=0
> +exit

We've replaced "status=0;exit;" with "_exit 0".

Thanks,
Zorro

> diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
> new file mode 100644
> index 000000000..3d70951ef
> --- /dev/null
> +++ b/tests/f2fs/025.out
> @@ -0,0 +1,2 @@
> +QA output created by 025
> +Silence is golden
> -- 
> 2.49.0
> 
