Return-Path: <SRS0=fsOW=DS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F50C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 06:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63536207FB
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 06:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgJKGL7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Oct 2020 02:11:59 -0400
Received: from out20-62.mail.aliyun.com ([115.124.20.62]:38013 "EHLO
        out20-62.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKGL7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Oct 2020 02:11:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436743|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0527695-0.000110887-0.94712;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.IhhcCIT_1602396713;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IhhcCIT_1602396713)
          by smtp.aliyun-inc.com(10.147.41.199);
          Sun, 11 Oct 2020 14:11:54 +0800
Date:   Sun, 11 Oct 2020 14:11:53 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        anju@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 1/1] ext4/046: Add test to verify unwritten extent
 conversion in buff-io
Message-ID: <20201011061153.GX3853@desktop>
References: <5baabca9c454e09e796a5a97127ca9d73840d8bd.1602243041.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5baabca9c454e09e796a5a97127ca9d73840d8bd.1602243041.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 09, 2020 at 05:12:24PM +0530, Ritesh Harjani wrote:
> There was an issue where with with filesize > 4G, map.m_lblk
> was getting overflow in buff-IO path while converting unwritten to
> written extent with dioread_nolock mount option with bs < ps.
> Adding a testcase for the same.
> This test doesn't force any explicit mount option within the test,
> as it will be set anyway along with test config, although it does
> force for blocksize < pagesize config (as this test is specific to

I don't think we need to force blksize < pagesize either, as testing
different blocksize configs is a common test setup and is part of
tester's resposibility.

> that). Patch at [1] fixes the issue.
> 
> [1]: https://patchwork.ozlabs.org/patch/1378632
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/ext4/046     | 101 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/046.out |   2 +
>  tests/ext4/group   |   1 +
>  3 files changed, 104 insertions(+)
>  create mode 100755 tests/ext4/046
>  create mode 100644 tests/ext4/046.out
> 
> diff --git a/tests/ext4/046 b/tests/ext4/046
> new file mode 100755
> index 000000000000..49de6bbb2c89
> --- /dev/null
> +++ b/tests/ext4/046
> @@ -0,0 +1,101 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test No. generic/046
> +#
> +# Test writes to falloc file with filesize > 4GB and make sure to verify
> +# the file checksum both before and after mount.
> +# This test is to check whether unwritten extents gets properly converted
> +# to written extent on a filesystem with bs < ps.

Mention dioread_nolock mount option as well here?

> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs ext4

I don't see any ext4 specific setups in the test, so it could be a
generic test.

> +_supported_os Linux

"_suppored_os" is removed, just drop this line.

> +_require_scratch
> +_require_xfs_io_command "falloc"
> +
> +# keep 4k as a blksz for 64k pagesz
> +pagesz=$(getconf PAGE_SIZE)
> +if [ $pagesz -eq 65536 ]; then
> +	blksz=4096
> +else
> +	blksz=$(($pagesz/4))
> +fi
> +
> +devsize=`blockdev --getsize64 $SCRATCH_DEV`
> +if [ $devsize -lt 6442450944 ]; then
> +	_notrun "Too small scratch device, need at least 6G"
> +fi

_require_scratch_size is used to do this check.

> +
> +# Test for bs < ps
> +export MKFS_OPTIONS="-F -b $blksz"
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +# check blksz
> +real_blksz=$(_get_file_block_size $SCRATCH_MNT)
> +test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
> +
> +testfile=$SCRATCH_MNT/testfile-$seq
> +
> +# Fallocate testfile with size > 4G
> +fsize=$((5 * 1024 * 1024 * 1024))
> +$XFS_IO_PROG -f -c "falloc 0 $fsize" $testfile >> $seqres.full 2>&1
> +
> +# First write at offset < 4G (at few alternative blks)
> +off=$((3 * 1024 * 1024 * 1024))
> +for i in 1 2 3 4; do
> +	$XFS_IO_PROG -f \
> +		-c "pwrite $off $blksz" \
> +		$testfile >> $seqres.full 2>&1
> +	off=$(($off + (2*$blksz)))
> +done
> +
> +# Then write at offset > 4G (at few alternative blks) to check
> +# any 32bit overflow case in map.m_lblk
> +off=$((4 * 1024 * 1024 * 1024))
> +for i in 1 2 3 4; do
> +	$XFS_IO_PROG -f \
> +		-c "pwrite $off $blksz" \
> +		$testfile >> $seqres.full 2>&1
> +	off=$(($off + (2*$blksz)))
> +done
> +
> +# ==== Pre-Remount ===
> +md5_pre=`md5sum $testfile | cut -d' ' -f1`
> +echo "Pre-Remount md5sum of $testfile = $md5_pre" >> $seqres.full
> +
> +_scratch_cycle_mount
> +
> +# ==== Post-Remount ===
> +md5_post=`md5sum $testfile | cut -d' ' -f1`
> +echo "Post-Remount md5sum of $testfile = $md5_post" >> $seqres.full
> +test $md5_pre != $md5_post && echo "md5sum mismatch"
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/ext4/046.out b/tests/ext4/046.out
> new file mode 100644
> index 000000000000..52c445eb70bb
> --- /dev/null
> +++ b/tests/ext4/046.out
> @@ -0,0 +1,2 @@
> +QA output created by 046
> +Silence is golden
> diff --git a/tests/ext4/group b/tests/ext4/group
> index 40351fd9ca0c..02a499a9d220 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -48,6 +48,7 @@
>  043 auto quick
>  044 auto quick
>  045 auto dir
> +046 auto quick

Also add 'prealloc' group

Thanks,
Eryu

>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.26.2
