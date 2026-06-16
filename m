Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1B309EE7
	for <fstests@vger.kernel.org>; Tue, 16 Jun 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618493; cv=none; b=Rn4l90W1MLrcZ4rqcpjNXZCm2XskRrQn5O7v2vPyLQ+LbVVNzvCZk4w9Cb+jlbpkpP09R0+usw0DgWqhMYtDSjnsqb3FV1RHIkVTOEetM+ymt9QgaahPnJFPLXXkQT+VX+qlpiHWJRSalGBfiuDDqCI9E//8PV/d4G9+ApUJYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618493; c=relaxed/simple;
	bh=r/Wck9xABR4kiuxyjf6dxlwncB42bUEUSkh1zPubXOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAP79D5lQsUvA79dDo4fRU3rpSUmfb3asep0ul0cFD1m2Svivasgi17k91gICyvZQpdIPErmx9AIfy9cGtVKSGKyBhdntzHjxoVm3MD9UChG94Ctl/MKCo+g/SdMI5uM55ZwOuxcT3S7Ypjyyo3+/EaELjZZuH7KbskJMrpOnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0UeREWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0UeREWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9ED1F000E9;
	Tue, 16 Jun 2026 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618492;
	bh=j3oxfE3q9MoqMDp6eTZNp1mvXS1FGownvmpW6tScf/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a0UeREWbzesChtoxiPmxgrq/0X1EVpXDZKIosy/kE1FOW1vWi7K0BNuFh+o2yPTgN
	 hYh5xQQ1Omn3utKg2py3kpR7mMhsp0zQQn3H46xqCQmkXiRbgNW84qmU4Q0ryxtTmy
	 xdl+FEff70x8x+JTp+LEsI+yukcqTbn29WkjvvJxnwTjEBMbat9X8193x4Y5lubezf
	 eTZdL2YP2+xVJ1ibf/U/FGEWwAFfv3cWf2QxVTzSg/TGkNFkEy+g2ahRNcYyIEwF/N
	 kk5wm9KTUcv3+EVULD/XRmhu4Zm9kinuqkFRgyl7cUKqaeN72oVVWiK49hq3jDnsOe
	 4EGSawzMpXYmA==
Date: Tue, 16 Jun 2026 22:01:26 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4] f2fs/025: test to do sanity check section type
 correctly in f2fs GC
Message-ID: <ajFW6e_zutXtSKwL@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260616073526.2967012-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616073526.2967012-1-chao@kernel.org>

On Tue, Jun 16, 2026 at 07:35:26AM +0000, Chao Yu wrote:
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
> v4:
> - add missing "_require_fs_sysfs_attr $TEST_DEV gc_urgent"

Thanks for updating, this version is good to me :)

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/f2fs/025     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/025.out |  2 ++
>  2 files changed, 84 insertions(+)
>  create mode 100755 tests/f2fs/025
>  create mode 100644 tests/f2fs/025.out
> 
> diff --git a/tests/f2fs/025 b/tests/f2fs/025
> new file mode 100755
> index 000000000..807f18f23
> --- /dev/null
> +++ b/tests/f2fs/025
> @@ -0,0 +1,82 @@
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
> +_require_scratch
> +_require_scratch_shutdown
> +_require_xfs_io_command "pwrite"
> +_require_xfs_io_command "truncate"
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_fs_sysfs_attr $TEST_DEV gc_urgent
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
> +_scratch_mount -o mode=lfs
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
> +_scratch_shutdown
> +
> +_scratch_unmount
> +
> +_scratch_mount -o mode=lfs
> +
> +# Run urgent_gc mode to trigger garbage collection
> +dev_name=$(_short_dev $SCRATCH_DEV)
> +$F2FS_IO_PROG gc_urgent $dev_name run 5 >> $seqres.full
> +
> +_scratch_unmount
> +
> +# Check whether the dmesg has the warning indicating the bug
> +_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
> +	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
> +
> +echo "Silence is golden"
> +_exit 0
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
