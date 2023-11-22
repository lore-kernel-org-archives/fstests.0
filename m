Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAEB4EB32
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiHflfs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC94CC433C7;
	Wed, 22 Nov 2023 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700670723;
	bh=YcgHrXsIdoLDp9lJF+jdop2D0D3Gwwz0A4AZo5trQfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiHflfs3fqlXJSc8Mot9cPdF7AeBxTsQY1QNixIUdBvgi31OOS2sfV6lvtZZqsXu2
	 uXmkckIMQepvHyHsM5ydFyBjBlXnfUWa4iQtTawyBiw7QzRZ5AwA9mGk84kYOEMp5P
	 16b2c4Erh4kSeV2GnWEACnK19BoWbPG8bDkA9CFd2STo2Tk/COwq6ZYSWyJGt+DdM+
	 Q2nIXhwD8sS3OagB+UU8b0ExhcwQaQivqdn21SB9vjyuOCkN9EmEoKMqPNAkrb0IVs
	 aULDCFZy3BxaEOniw5Bxew+i9avwYFpCwzyNOjHVYP1KnN2f5/e+JBd4zlNPbBkanE
	 CoBDY5Ymx37gg==
Date: Wed, 22 Nov 2023 08:32:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com, guaneryu@gmail.com,
	amir73il@gmail.com, ritesh.list@gmail.com, yangerkun@huawei.com
Subject: Re: [PATCH v3] ext4: Regression test of ext4_lblk_t overflow
Message-ID: <20231122163203.GJ36175@frogsfrogsfrogs>
References: <20231122115314.875252-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122115314.875252-1-libaokun1@huawei.com>

On Wed, Nov 22, 2023 at 07:53:14PM +0800, Baokun Li wrote:
> Append writes to a file approaching 16T and observe if a kernel crash is
> caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
> This is a regression test for commit bc056e7163ac ("ext4: fix BUG in
> ext4_mb_new_inode_pa() due to overflow")
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Changes to make the use case more generic, not just for testing
> 	ext4.(ext4 and xfs have been tested)
> V2->V3:
> 	Clean up the code and remove hardcoding.
> 
>  tests/generic/737     | 53 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/737.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/generic/737
>  create mode 100644 tests/generic/737.out
> 
> diff --git a/tests/generic/737 b/tests/generic/737
> new file mode 100755
> index 00000000..29d428ad
> --- /dev/null
> +++ b/tests/generic/737
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test No. 737
> +#
> +# Append writes to a file approaching 16T and observe if a kernel crash is
> +# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
> +# This is a regression test for commit
> +# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> +#
> +. ./common/preamble
> +. ./common/populate
> +_begin_fstest auto quick insert prealloc
> +
> +# real QA test starts here
> +[[ "$FSTYP" =~ ext* ]] && _fixed_by_kernel_commit bc056e7163ac \
> +	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> +
> +_require_odirect
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "finsert"
> +
> +dev_size=$((100 * 1024 * 1024))
> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> +
> +_scratch_mount
> +blksz="$(_get_block_size ${SCRATCH_MNT})"

_get_file_block_size, not _get_block_size.  The first one retrieves the
file allocation unit (e.g. ext4 bigalloc cluster size / xfs rt extent
size) whereas the second merely returns the base fs block size.

That is an important distinction when you're messing with fallocate. :)

> +# Reserve 1M space
> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full
> +
> +# Create a file (~16T) with logical block numbers close to overflow
> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full
> +insert_size=$((blksz * 4096 - 10 - 3))

What if blksz == 64k ?  This won't compute a file position slightly
below 16T.  I think the comment is wrong since you're trying to overflow
the u32 ext4_lblk_t, correct?

I think what you really want is something more like...

# Shift the last 9M of the file preallocations to a position just short
# of overflowing ext4_lblk_t.
max_pos=$(( 0xffffffff * file_blksz ))
finsert_len=$(( max_pos - ((10 + 3) << 20) ))
$XFS_IO_PROG -f -c "finsert 1M ${finsert_len}" "${SCRATCH_MNT}/file" >> $seqres.full

Not sure why you shift 9M of data to 13M below what I think is the
upper range of ext4_lblk_t; I would have thought that would be
(max_pos - 9MB) but I'm assuming you know the reproduction circumstances
better than me...

--D

> +$XFS_IO_PROG -f -c "finsert 1M ${insert_size}M" "${SCRATCH_MNT}/file" >> $seqres.full
> +
> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
> +nr_free=$(stat -f -c '%f' ${SCRATCH_MNT})
> +_fill_fs $((nr_free * blksz)) ${SCRATCH_MNT}/fill $blksz 0 >> $seqres.full 2>&1
> +sync
> +
> +# Remove reserved space to gain free space for allocation
> +rm -f ${SCRATCH_MNT}/tmp
> +
> +# Trying to allocate two blocks triggers BUG_ON.
> +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 $((2 * blksz))" >> $seqres.full
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/737.out b/tests/generic/737.out
> new file mode 100644
> index 00000000..67b83d78
> --- /dev/null
> +++ b/tests/generic/737.out
> @@ -0,0 +1,2 @@
> +QA output created by 737
> +Silence is golden
> -- 
> 2.31.1
> 
> 
