Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337838E
	for <fstests@vger.kernel.org>; Sat, 25 Nov 2023 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPdpau22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05C1C433C7;
	Sat, 25 Nov 2023 00:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700872641;
	bh=Ct/ZOZAM6h/WEHhgWOzQjAUafLdO2XgizvL2JPWqKcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPdpau22pJhZbn+tWzL92xpE6gaC4TqUE9HBkK+WEP8oAmOHrOqZVMKgMIIR7fwRc
	 T3TY1ZbQUljB6cXdtJLPKuyIzhBzoOLYqFpD0PtWakHKEFvcDF+63WkoYvYw9op51V
	 BzE0hd12nBjRR2w9dRVRUoN74xbOcUU8srYTgkXXBcXJPvFPLqJgkCXMXPAWwhmykP
	 +r6z1ESve1zt7v0voAK/dab11exPAFRQ3YIqkXAN95XuivOazHetxPFyxHENUBP0Gq
	 R//O5vm9wSt9nf5WTTIo2RiIJ2VDTwWO9PDwASPfpJyPt4mpA6EAf1NZCeENm/hAb2
	 XvLhJLKnpGAhQ==
Date: Fri, 24 Nov 2023 16:37:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com, guaneryu@gmail.com,
	amir73il@gmail.com, ritesh.list@gmail.com, yangerkun@huawei.com
Subject: Re: [PATCH v5] ext4: Regression test of ext4_lblk_t overflow
Message-ID: <20231125003720.GL36175@frogsfrogsfrogs>
References: <20231124115356.2438805-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124115356.2438805-1-libaokun1@huawei.com>

On Fri, Nov 24, 2023 at 07:53:56PM +0800, Baokun Li wrote:
> Append writes to a file with logical block numbers close to 0xffffffff and
> observe if a kernel crash is caused by ext4_lblk_t overflow triggering
> BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for commit
> bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks fine to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> V1->V2:
> 	Changes to make the use case more generic, not just for testing
> 	ext4.(ext4 and xfs have been tested)
> V2->V3:
> 	Clean up the code and remove hardcoding.
> V3->V4:
> 	Correct the description and modify finsert related code to
> 	make the test case easier to understand.
> V4->V5:
> 	Modify the image size to 80M.
> 	Modify the space reserved in the file to 2M.
> 	Now the test case can trigger the original problem at ext4
> 	1k,4k,64k block size.
> 
>  tests/generic/737     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/737.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/generic/737
>  create mode 100644 tests/generic/737.out
> 
> diff --git a/tests/generic/737 b/tests/generic/737
> new file mode 100755
> index 00000000..b4bf33e4
> --- /dev/null
> +++ b/tests/generic/737
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test No. 737
> +#
> +# Append writes to a file with logical block numbers close to 0xffffffff
> +# and observe if a kernel crash is caused by ext4_lblk_t overflow triggering
> +# BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for commit
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
> +dev_size=$((80 * 1024 * 1024))
> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> +
> +_scratch_mount
> +file_blksz="$(_get_file_block_size ${SCRATCH_MNT})"
> +
> +# Reserve 1M space
> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full
> +
> +# Create a file with logical block numbers close to 0xffffffff
> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full
> +max_pos=$(( 0xffffffff * file_blksz ))
> +finsert_len=$(( max_pos - ((10 + 2) << 20) ))
> +$XFS_IO_PROG -f -c "finsert 1M ${finsert_len}" "${SCRATCH_MNT}/file" >> $seqres.full
> +
> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
> +nr_free=$(stat -f -c '%f' ${SCRATCH_MNT})
> +_fill_fs $((nr_free * file_blksz)) ${SCRATCH_MNT}/fill $file_blksz 0 >> $seqres.full 2>&1
> +sync
> +
> +# Remove reserved space to gain free space for allocation
> +rm -f ${SCRATCH_MNT}/tmp
> +
> +# Trying to allocate two blocks triggers BUG_ON.
> +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 $((2 * file_blksz))" >> $seqres.full
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
