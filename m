Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04C10EC
	for <fstests@vger.kernel.org>; Fri, 24 Nov 2023 03:41:58 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ScCk22DqmzvRBn;
	Fri, 24 Nov 2023 19:41:30 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 19:41:56 +0800
Message-ID: <3b47e15e-71ba-1dcd-1e41-14f5297fbf90@huawei.com>
Date: Fri, 24 Nov 2023 19:41:55 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4] ext4: Regression test of ext4_lblk_t overflow
Content-Language: en-US
To: <fstests@vger.kernel.org>
CC: <zlang@redhat.com>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
	<ritesh.list@gmail.com>, <djwong@kernel.org>, <yangerkun@huawei.com>
References: <20231123142720.4107258-1-libaokun1@huawei.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231123142720.4107258-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

Please ignore this version, there's already v5.
Sorry for the noise!


On 2023/11/23 22:27, Baokun Li wrote:
> Append writes to a file with logical block numbers close to 0xffffffff and
> observe if a kernel crash is caused by ext4_lblk_t overflow triggering
> BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for commit
> bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Changes to make the use case more generic, not just for testing
> 	ext4.(ext4 and xfs have been tested)
> V2->V3:
> 	Clean up the code and remove hardcoding.
> V3->V4:
> 	Correct the description and modify finsert related code to
> 	make the test case easier to understand.
>
>   tests/generic/737     | 54 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/737.out |  2 ++
>   2 files changed, 56 insertions(+)
>   create mode 100755 tests/generic/737
>   create mode 100644 tests/generic/737.out
>
> diff --git a/tests/generic/737 b/tests/generic/737
> new file mode 100755
> index 00000000..59bd2217
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
> +dev_size=$((100 * 1024 * 1024))
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
> +finsert_len=$(( max_pos - ((10 + 3) << 20) ))
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


