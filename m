Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CB385D7A
	for <fstests@vger.kernel.org>; Sun, 20 Sep 2026 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905765; cv=none; b=FdZKU8hw0XFsg5f4EelGbrCm1/agFyCUrsy6U2sYaXUGdfH0dY/cOtOPpS62JArmqbmkJ8s7/oPcGcJtRxta7UfvM0ZKEDHNOrXdY+CQyPnJtS3/Cqfpx9G37fQbwC/UyJTcUwjKlfT+5/HTxaGP/Z3TWWf5aqj+KEH9DPjIcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905765; c=relaxed/simple;
	bh=hgtCxGxHyTefrAmZCRre0qes8TnlLSITVIRan76v+e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffi8TTB68uYQ7+nhl7QWYjS94Ogu7dn7NR+VJ9RfhosMgtwQ7dAQGEc/o0w+BYG9FfhCuhx/KT8Bp3N9hEr0lf8Nd/hgXfe0mB4XfLsTXp7EaVCl1xXxNFHVLzQ+pN2fYCoBa4CYtXDccnBZIU1N85mSnvQ67mYpC4N6nW0pDQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfcLj2bc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfcLj2bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333F71F000FF;
	Sun, 20 Sep 2026 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789905763;
	bh=otc92/TjtqOpZJNknonzPRJr4Gv5fyM3H1EvmHQYim0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hfcLj2bcFyh3fUlLmxQwdLHa/+vbJEpbd5r0X7BmCUdEKqwexL4AqkqB0EGgzkpkP
	 jwr4ffUHmzTj56Wj4rxO9/E1cyeu0ntp2AH5IF78O1brieAISzt0mFgBolweUmY93z
	 vq/MJXlMbuv56tex/xxGvtJX+q0Kv1kTbDxxE1P0ce87BGtV/nC7nqlSjRZZAfUk65
	 hDz1TyHTnMauFYO3zk5fFTlLG/ogUtma0awZhfKs3irt+49XS50OXLGSEHn11p2i4m
	 CbZf0DVBE1YonO9puX4N1tpAsYx5VrCRL9/aYQURe5Df6BXRWNKNrKlBcK8or4C5ou
	 vL6fNw7EzIoBQ==
Date: Sun, 20 Sep 2026 20:02:37 +0800
From: Zorro Lang <zlang@kernel.org>
To: Moritz Tanner <moritz.tanner@linbit.com>
Cc: fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] generic: test bdev freeze count leak on nested thaw
Message-ID: <aq_LAV1YmwpPgwGm@zlang-mailbox>
Mail-Followup-To: Moritz Tanner <moritz.tanner@linbit.com>, 
	fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Christoph Hellwig <hch@lst.de>
References: <20260917065938.51819-1-moritz.tanner@linbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917065938.51819-1-moritz.tanner@linbit.com>

On Thu, Sep 17, 2026 at 08:59:38AM +0200, Moritz Tanner wrote:
> Since kernel v6.8, a nested thaw that drops its freeze reference
> while other freezers remain returns -EINVAL although it succeeded.
> bdev_thaw() then keeps bd_fsfreeze_count elevated, and since
> device-mapper's unlock_fs() ignores the error, a dm suspend/resume
> cycle on a filesystem frozen with FIFREEZE leaks the count. After
> unfreezing and unmounting, the block device can never be mounted
> again:
> 
>     dm-1: Can't mount, blockdev is frozen
> 
> Add a regression test that freezes a filesystem on a dm-linear
> device, runs a dm suspend/resume cycle inside the freeze, unfreezes
> and remounts. On buggy kernels the final mount fails with EBUSY.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Lore: https://lore.kernel.org/linux-fsdevel/20260821085451.65206-1-moritz.tanner@linbit.com/
> Signed-off-by: Moritz Tanner <moritz.tanner@linbit.com>
> ---

Looks good to me,

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/802     | 69 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/802.out |  2 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/802
>  create mode 100644 tests/generic/802.out
> 
> diff --git a/tests/generic/802 b/tests/generic/802
> new file mode 100755
> index 00000000..d3b84200
> --- /dev/null
> +++ b/tests/generic/802
> @@ -0,0 +1,69 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 LINBIT HA-Solutions GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 802
> +#
> +# Test that a device-mapper suspend/resume cycle on a filesystem that is
> +# already frozen by userspace does not leak a block device freeze reference.
> +#
> +# On buggy kernels thaw_super() returns -EINVAL for a nested thaw although
> +# it dropped its freeze reference, so bdev_thaw() leaves bd_fsfreeze_count
> +# elevated. Once the filesystem is unmounted, the block device can never
> +# be mounted again:
> +#
> +#     dm-1: Can't mount, blockdev is frozen
> +#
> +. ./common/preamble
> +_begin_fstest auto quick freeze mount
> +
> +_fixed_by_kernel_commit fe967191e585 \
> +	"fs: don't return -EINVAL for successful nested thaw"
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> +	$DMSETUP_PROG resume $lvdev >> $seqres.full 2>&1
> +	_unmount -q $SCRATCH_MNT
> +	_dmsetup_remove $node
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +_require_scratch
> +_require_dm_target linear
> +_require_freeze
> +
> +echo "Silence is golden"
> +
> +size=$((256 * 1024 * 1024))
> +size_in_sector=$((size / 512))
> +_scratch_mkfs_sized $size >> $seqres.full 2>&1
> +
> +node=$seq-test
> +lvdev=/dev/mapper/$node
> +table="0 $size_in_sector linear $SCRATCH_DEV 0"
> +_dmsetup_create $node --table "$table" || \
> +	_fail "failed to create dm device"
> +
> +_mount $lvdev $SCRATCH_MNT || _fail "failed to mount dm device"
> +
> +# Freeze the filesystem from userspace first, then nest a block device
> +# initiated freeze/thaw cycle inside it via dm suspend/resume.
> +xfs_freeze -f $SCRATCH_MNT || _fail "failed to freeze filesystem"
> +$DMSETUP_PROG suspend $lvdev >> $seqres.full 2>&1 || \
> +	_fail "failed to suspend dm device"
> +$DMSETUP_PROG resume $lvdev >> $seqres.full 2>&1 || \
> +	_fail "failed to resume dm device"
> +xfs_freeze -u $SCRATCH_MNT || _fail "failed to unfreeze filesystem"
> +
> +# On buggy kernels the resume leaked a block device freeze reference,
> +# and the device cannot be mounted again once unmounted.
> +_unmount $SCRATCH_MNT
> +_mount $lvdev $SCRATCH_MNT || \
> +	_fail "failed to mount dm device after nested freeze/thaw"
> +_unmount $SCRATCH_MNT
> +
> +status=0
> +exit
> diff --git a/tests/generic/802.out b/tests/generic/802.out
> new file mode 100644
> index 00000000..a69c0539
> --- /dev/null
> +++ b/tests/generic/802.out
> @@ -0,0 +1,2 @@
> +QA output created by 802
> +Silence is golden
> -- 
> 2.55.0
> 
