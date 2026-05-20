Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1433BAD91
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280119; cv=none; b=WjIx+wtiP4QvPXPFaLF7vqVMwsTmTOiotraERzpsy1vOLkNSNapB8iHiHRutnEAW9FQda2gZ7emsBT2lRmWdsTOvgVwfAApdEH0SCN6MteJgZ/EqaX+8KSvwqaZD+8bPxJ/ZfhGL5xxJ0G0RrLbxVlrqhvOiYaCheHSh14ewAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280119; c=relaxed/simple;
	bh=V+cC+FLZZyfZe89WU60mpbwyEGSZLJZOqjrmmws1Y2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpkqDuzjEBoD6OH+KdwES/ltNMZBHKl+bh0KknApApSPLciuT23fpnoXTWK7nGnxZKTXKqlljkO/tPzVR2qmOn0RJDWIsJ0dl1zAs12Vj/zD0SwMI4NNsi3l3LZY70wfLVFT+ftyaUM9foZGIF0cc9nIlCv5C/SN/qOPcyTfeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7AzNmR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7AzNmR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694541F000E9;
	Wed, 20 May 2026 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280118;
	bh=/w3xRDdSB1Oue9DDBq9k8Rn4urhWgVsSGxIhJfb9Q7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U7AzNmR4ufuz8RzeqbLm4M+bR3KDu12MqbzJ4QvdnaQyABBdPqIMEM2XGOUvPnyOj
	 uGT8FCdzduuKSjnYv9cu8F2uN3jl0j4uyBHMW6pYUSdeia17qcbFQ6YK+WHkI/OiXk
	 q/4Nn1gEwIdsEVf9vLYPK6d8PtZ/zJqsniXGCztnbUvnS4amcytafs0f0osDD4+0ho
	 XwlAfgQY4t3YsBI/ipQN3ZgDUd+yFfLcd+Nb7BRzldgqH70YjZMginVD+PwG6IaYFm
	 PVsGaGrdvkNeveC8LjttzVjDCjc/+xs/6HeecDUZA4XLrVwBB2ji2EG1oXC0Z4Yni5
	 rgpWNOO8CmgPg==
Date: Wed, 20 May 2026 20:28:29 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, jprusakowski@google.com, 
	joannechien@google.com, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/025: test to do sanity check section type correctly
 in f2fs GC
Message-ID: <ag2Rh-4_Tp082XXx@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, jprusakowski@google.com, joannechien@google.com, 
	linux-f2fs-devel@lists.sourceforge.net
References: <20260518101252.445214-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518101252.445214-1-chao@kernel.org>

On Mon, May 18, 2026 at 06:12:52PM +0800, Chao Yu wrote:
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
>  tests/f2fs/025     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/025.out |  2 ++
>  2 files changed, 90 insertions(+)
>  create mode 100644 tests/f2fs/025
>  create mode 100644 tests/f2fs/025.out
> 
> diff --git a/tests/f2fs/025 b/tests/f2fs/025
> new file mode 100644
> index 00000000..1eba7158
> --- /dev/null
> +++ b/tests/f2fs/025
> @@ -0,0 +1,88 @@
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
> +
> +_require_scratch
> +_require_xfs_io_command "pwrite"
> +_require_xfs_io_command "truncate"
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_check_dmesg
> +
> +# Format with 96MB size and 2 segments per section
> +_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
> +
> +# Mount with mode=lfs
> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
> +
> +# Create files to fill whole filesystem, then segment type will be changed to node type
> +for ((i=0;i<5120;i++)) do
> +	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1

5120 * 4k = 20MB

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

1928k + 16M + 16M + 8M + 32K ~= 40M

> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1

96M - 40M - 20M = 36M

I'm not a f2fs expert, I think you hope to (almost) fill the fs before this 2M
pwrite step. If so, I'm wondering can we ensure that other metadata takes ~36 MB
of space, thereby guaranteeing that this 2 MB write triggers the reuse of that
1928 KB segment (no matter with any MKFS_OPTIONS)?

Thanks,
Zorro

> +
> +# Shutdown the filesystem without checkpoint
> +$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
> +
> +# Run urgent_gc mode to trigger garbage collection
> +dev_name=$(_short_dev $SCRATCH_DEV)
> +if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
> +	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
> +fi
> +
> +# Wait background GC thread to wake up to run and potentially encounter the inconsistency
> +sleep 5
> +
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +# Check whether the dmesg has the warning indicating the bug
> +_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
> +	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
> new file mode 100644
> index 00000000..3d70951e
> --- /dev/null
> +++ b/tests/f2fs/025.out
> @@ -0,0 +1,2 @@
> +QA output created by 025
> +Silence is golden
> -- 
> 2.49.0
> 
