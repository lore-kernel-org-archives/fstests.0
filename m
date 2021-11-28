Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD9C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Nov 2021 16:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbhK1QVA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Nov 2021 11:21:00 -0500
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:33391 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358240AbhK1QTA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Nov 2021 11:19:00 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437368|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0180182-0.000619724-0.981362;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.M-i-AXq_1638116141;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.M-i-AXq_1638116141)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 29 Nov 2021 00:15:41 +0800
Date:   Mon, 29 Nov 2021 00:15:41 +0800
From:   Eryu Guan <guan@eryu.me>
To:     "chenlongcl.chen@huawei.com" <chenlongcl.chen@huawei.com>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: verify ext4 when the starting block of index and
 leaf are inconsistent
Message-ID: <YaOrLVKnPMQbA6lQ@desktop>
References: <20211123013759.170012-1-chenlongcl.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211123013759.170012-1-chenlongcl.chen@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 23, 2021 at 09:37:59AM +0800, chenlongcl.chen@huawei.com wrote:
> From: chenlong <chenlongcl.chen@huawei.com>
> 
> Insert the extent entry in ext4_ext_insert_extent() (to be inserted at
> the beginning of the block). In the stage of updating the starting block
> number of the parent index block, an error happened
> in ext4_ext_correct_indexes()->ext4_ext_get_access(), which caused the
> index update of the parent index node to fail. The ext4_ext_insert_extent()
> function exits directly and does not roll back the extent entry of
> the leaf block. Eventually, the extent starting block numbers in
> the index block and leaf block are inconsistent, triggering bugon
> 
> This is a regression test for three kernel commit:
> 1. 0f2f87d51aebc (ext4: prevent partial update of the extent blocks)
> 2. 9c6e071913792 (ext4: check for inconsistent extents between index
>    and leaf block)
> 3. 8dd27fecede55 (ext4: check for out-of-order index extents in
>    ext4_valid_extent_entries())

Missing Signed-off-by tag.

> ---
>  tests/ext4/054     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/054.out |  2 +
>  2 files changed, 99 insertions(+)
>  create mode 100755 tests/ext4/054
>  create mode 100644 tests/ext4/054.out
> 
> diff --git a/tests/ext4/054 b/tests/ext4/054
> new file mode 100755
> index 00000000..3d63f12f
> --- /dev/null
> +++ b/tests/ext4/054
> @@ -0,0 +1,97 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 054
> +#
> +# Regression test for kernel commit:
> +# 1. 0f2f87d51aebc (ext4: prevent partial update of the extent blocks)
> +# 2. 9c6e071913792 (ext4: check for inconsistent extents between index \
> +#    and leaf block)
> +# 3. 8dd27fecede55 (ext4: check for out-of-order index extents in \
> +#    ext4_valid_extent_entries())
> +
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -f $tmp.*
> +    $UMOUNT_PROG ${IMG_MNT} > /dev/null 2>&1
> +    rm -f ${IMG_FILE} > /dev/null 2>&1
> +}
> +
> +# Import common functions
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_require_test
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "pwrite"
> +_require_xfs_io_command "fsync"
> +_require_xfs_io_command "fpunch"
> +_require_command "$DEBUGFS_PROG" debugfs
> +
> +IMG_FILE=${SCRATCH_MNT}/$seq.fs
> +IMG_MNT=${SCRATCH_MNT}/$seq.mnt

SCRATCH_DEV is not required nor mounted, so IMG_FILE and IMG_MNT are
created on the root filesystem.

And I don't see why we need to loop back mount an fs image here, does
_require_scratch_nocheck then use $SCRATCH_DEV directly work for you?

And if loop device is really needed, _require_loop should be added as
well, and use $TEST_DIR to save the fs image and mnt dir, e.g.

IMG_FILE=$TEST_DIR/$seq.fs
IMG_MNT=$TEST_DIR/$seq.mnt

and use _create_loop_device and _destroy_loop_device helpers.

> +TEST_FILE="${IMG_MNT}/testfile"
> +
> +fallocate -l 10M $IMG_FILE

$XFS_IO_PROG -c "falloc 0 10m" $IMG_FILE

> +mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
> +
> +$MKFS_EXT4_PROG -F $IMG_FILE >> $seqres.full 2>&1 || _fail "mkfs failed"
> +
> +$MOUNT_PROG -t ${FSTYP} ${IMG_FILE} ${IMG_MNT} >/dev/null 2>&1 || \
> +    _fail "mount failed"

If use $SCRATCH_DEV, above will simply be

_scratch_mkfs >> $seqres.full 2>&1
_scratch_mount 

> +touch $TEST_FILE
> +
> +#
> +# The following steps create an abnormal file system image and
> +# create a file(testfile). The starting logic block of his second leaf
                                                          ^^^^ its ?

> +# extent block is inconsistent with the starting logic block of the
> +# second idx extent entry in the inode.
> +# Level Entries       Logical      Physical Length Flags
> +# 0/ 1   2/  2  5632 -  6527  2020            896
> +#               ^^^^ 指向了leaf block
                        ^^^^^ Use English please.

> +# 1/ 1   1/ 15  5376 -  5439  7041 -  7104     64 Uninit
> +# 1/ 1   2/ 15  5632 -  5695  7297 -  7360     64 Uninit
> +#
> +for i in {0..50}
> +do
> +    offset=$((1024 * 128 * i))
> +    $XFS_IO_PROG -c "falloc $offset $((1024 * 64))" $TEST_FILE >> $seqres.full
> +    offset=$((offset + 1024 * 64))
> +    $XFS_IO_PROG -c "pwrite $offset $((1024 * 64))" $TEST_FILE >> $seqres.full
> +    $XFS_IO_PROG -c "fsync" $TEST_FILE >> $seqres.full
> +done
> +
> +$XFS_IO_PROG -c "fpunch $((1024 * 5376)) $((1024 * 256))" $TEST_FILE \
> +        >> $seqres.full
> +$XFS_IO_PROG -c "fsync" $TEST_FILE >> $seqres.full
> +$XFS_IO_PROG -c "falloc $((1024 * 5376)) $((1024 * 64))" $TEST_FILE \
> +        >> $seqres.full
> +$XFS_IO_PROG -c "fsync" $TEST_FILE
> +
> +$UMOUNT_PROG ${IMG_MNT} || _fail "umount failed"
> +
> +$DEBUGFS_PROG -w -R "set_inode_field testfile block[6] 0x1600" $IMG_FILE \
> +        2>>$seqres.full >> $seqres.full
> +
> +# Mount the file system and create a block at a location in the middle
> +# of 5440-5632
> +
> +$MOUNT_PROG -t ${FSTYP} -o nodelalloc ${IMG_FILE} ${IMG_MNT} \

Please add comments to explain why nodelalloc is needed.

Thanks,
Eryu

> +        >/dev/null 2>&1 || _fail "mount failed"
> +$XFS_IO_PROG -c "pwrite $((1024 * 5568)) $((1024 * 64))" $TEST_FILE \
> +        2>>$seqres.full >> $seqres.full
> +
> +# If this BUG is not fixed, when the testcase is executed to this position,
> +# the kernel will be BUG_ON immediately.
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/054.out b/tests/ext4/054.out
> new file mode 100644
> index 00000000..108fe4c9
> --- /dev/null
> +++ b/tests/ext4/054.out
> @@ -0,0 +1,2 @@
> +QA output created by 054
> +Silence is golden
> -- 
> 2.17.1
