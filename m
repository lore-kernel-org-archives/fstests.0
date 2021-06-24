Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D6DC48BDF
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Jun 2021 08:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34DF613E3
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Jun 2021 08:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFXItS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Jun 2021 04:49:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229465AbhFXItS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Jun 2021 04:49:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15O8Y3wR183718
        for <fstests@vger.kernel.org>; Thu, 24 Jun 2021 04:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=IOeq5tGiWuUNoDbkXy0rh6AtzYo4XYXonEJsuYCk7bg=;
 b=iartt/0CJCJpxm9s49ZYvmYn2SsU1S4RRCRtB/E6o5uPiBjRaoJVYwVspYC5gKDA8LDC
 ma7opNxOshbQyDk9/WWi+DpQZhAF8YC/sa7pYmV3W23OvScC2yGcoQikzFewAMQa3fSR
 /wFzHGYB/K30uHawQSufIfl3Fg2YFWj4tbZL9S36rve2ePRA7lAf4nwvDMgO1k527qqH
 nngYYj03HrnNyeI+TchaMG+3xBdizG15byWRnNdv33cQnE0inPSrfqktSkqVLF2eRpM8
 lvFix7EV4d9yDBBuBXcbuR0Kd8NLSNgr71+oqGoesFjzbggFXfVj8O0L88cnnkADtcVN Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39cg7ckbx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 24 Jun 2021 04:46:58 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15O8YAQo184612
        for <fstests@vger.kernel.org>; Thu, 24 Jun 2021 04:46:58 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39cg7ckbwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 04:46:58 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15O8jO77027238;
        Thu, 24 Jun 2021 08:46:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 399878ae63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 08:46:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15O8ksSn29163824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 08:46:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16343AE056;
        Thu, 24 Jun 2021 08:46:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B16E6AE055;
        Thu, 24 Jun 2021 08:46:53 +0000 (GMT)
Received: from localhost (unknown [9.199.33.234])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Jun 2021 08:46:53 +0000 (GMT)
Date:   Thu, 24 Jun 2021 14:16:52 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210624084652.3pspy7s3ostfnlve@riteshh-domain>
References: <20210624042759.3304586-1-zlang@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624042759.3304586-1-zlang@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7GXQItEzr-Dat-Bdzq_yqppcNgGCJ-LP
X-Proofpoint-GUID: sJcbjoYvm-tReEMMW3DOORM5rMwPUl3j
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_06:2021-06-23,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240046
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 21/06/24 12:27PM, Zorro Lang wrote:
> If a swapfile doesn't contain even a single page-aligned contiguous
> range of blocks, it's an invalid swapfile, and might cause kernel
> issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> assignment to unsigned sis->pages in iomap_swapfile_activate").
>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>
> Hi,
>
> V4 did below changes:
> 1) Expect swapon return EINVAL
> 2) Compare swap size and swapfile size if swapon passed

Thanks for the changes. Looks good to me.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


>
> It's passed on fixed kernel, panic on old kernel, failed on upstream unfixed
> kernel. Thanks review points from djwong and riteshh!
>
> PS: This case might trigger another KASAN bug[1], I hit it several times.
> But looks like it's getting fixed:
>   https://lore.kernel.org/linux-block/fb0804e5-bfae-62ac-c3e6-d46a9a33ca53@huawei.com/
>
> Thanks,
> Zorro
>
> [  328.725559] BUG: KASAN: use-after-free in bt_iter+0x2a2/0x320
> [  328.731994] Read of size 8 at addr ffff88828fea1200 by task kworker/23:1H/575
>
> [  328.741634] CPU: 23 PID: 575 Comm: kworker/23:1H Tainted: G S                5.13.0-rc4-xfs #8
> [  328.751255] Hardware name: IBM System x3650 M4 -[7915ON3]-/00J6520, BIOS -[VVE124AUS-1.30]- 11/21/2012
> [  328.761651] Workqueue: kblockd blk_mq_timeout_work
> [  328.767017] Call Trace:
> [  328.769752]  dump_stack+0x9c/0xcf
> [  328.773465]  print_address_description.constprop.0+0x18/0x130
> [  328.779891]  ? bt_iter+0x2a2/0x320
> [  328.783694]  ? bt_iter+0x2a2/0x320
> [  328.787495]  kasan_report.cold+0x7f/0x111
> [  328.791978]  ? bt_iter+0x2a2/0x320
> [  328.795780]  bt_iter+0x2a2/0x320
> [  328.799387]  blk_mq_queue_tag_busy_iter+0x42e/0x7e0
> [  328.804839]  ? blk_mq_tag_to_rq+0xb0/0xb0
> [  328.809321]  ? psi_group_change+0x842/0xd10
> [  328.813998]  ? blk_mq_all_tag_iter+0x710/0x710
> [  328.818964]  ? load_balance+0x22f0/0x22f0
> [  328.823445]  ? blk_mq_tag_to_rq+0xb0/0xb0
> [  328.827928]  ? psi_task_switch+0x1b5/0x630
> [  328.832507]  blk_mq_timeout_work+0xa9/0x3a0
> [  328.837185]  ? __blk_mq_end_request+0x440/0x440
> [  328.842243]  process_one_work+0x671/0xfd0
> [  328.846729]  ? _raw_write_lock_irq+0xb0/0xb0
> [  328.851504]  worker_thread+0x562/0xf50
> [  328.855698]  ? process_one_work+0xfd0/0xfd0
> [  328.860365]  kthread+0x31c/0x3e0
> [  328.863974]  ? __kthread_bind_mask+0x90/0x90
> [  328.868747]  ret_from_fork+0x22/0x30
>
> [  328.874415] Allocated by task 3056:
> [  328.878311]  kasan_save_stack+0x1b/0x40
> [  328.882604]  __kasan_slab_alloc+0x61/0x80
> [  328.887084]  kmem_cache_alloc+0xec/0x250
> [  328.891468]  xfs_buf_item_init+0x137/0x800 [xfs]
> [  328.896997]  _xfs_trans_bjoin+0x75/0x2b0 [xfs]
> [  328.902278]  xfs_trans_read_buf_map+0x4fa/0xb20 [xfs]
> [  328.908246]  xfs_read_agf+0x173/0x3a0 [xfs]
> [  328.913196]  xfs_alloc_read_agf+0x5a/0xcf0 [xfs]
> [  328.918626]  xchk_ag_read_headers+0x119/0x2c0 [xfs]
> [  328.924408]  xchk_ag_init+0x15/0x30 [xfs]
> [  328.929217]  xchk_inode_xref+0x1ca/0x5a0 [xfs]
> [  328.934515]  xchk_inode+0x1eb/0x680 [xfs]
> [  328.939328]  xfs_scrub_metadata+0x59c/0xc00 [xfs]
> [  328.944917]  xfs_ioc_scrub_metadata+0x80/0xe0 [xfs]
> [  328.950675]  xfs_file_ioctl+0xe91/0x1380 [xfs]
> [  328.955945]  __x64_sys_ioctl+0x127/0x190
> [  328.960331]  do_syscall_64+0x40/0x80
> [  328.964331]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> [  328.971639] Freed by task 3056:
> [  328.975147]  kasan_save_stack+0x1b/0x40
> [  328.979436]  kasan_set_track+0x1c/0x30
> [  328.983624]  kasan_set_free_info+0x20/0x30
> [  328.988200]  __kasan_slab_free+0xeb/0x120
> [  328.992680]  slab_free_freelist_hook+0x61/0x120
> [  328.997743]  kmem_cache_free+0xf3/0x440
> [  329.002032]  xfs_buf_item_put+0xeb/0x160 [xfs]
> [  329.007316]  xfs_trans_brelse+0x284/0x3d0 [xfs]
> [  329.012702]  xchk_ag_free+0xde/0x2a0 [xfs]
> [  329.017611]  xchk_inode_xref+0x394/0x5a0 [xfs]
> [  329.022908]  xchk_inode+0x1eb/0x680 [xfs]
> [  329.027720]  xfs_scrub_metadata+0x59c/0xc00 [xfs]
> [  329.033307]  xfs_ioc_scrub_metadata+0x80/0xe0 [xfs]
> [  329.039063]  xfs_file_ioctl+0xe91/0x1380 [xfs]
> [  329.044333]  __x64_sys_ioctl+0x127/0x190
> [  329.048717]  do_syscall_64+0x40/0x80
> [  329.052715]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> [  329.060015] The buggy address belongs to the object at ffff88828fea1110
>                 which belongs to the cache xfs_buf_item of size 272
> [  329.074095] The buggy address is located 240 bytes inside of
>                 272-byte region [ffff88828fea1110, ffff88828fea1220)
> [  329.087206] The buggy address belongs to the page:
> [  329.092550] page:00000000bdd5714b refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28fea0
> [  329.103049] head:00000000bdd5714b order:1 compound_mapcount:0
> [  329.109469] flags: 0x57ffffc0010200(slab|head|node=1|zone=2|lastcpupid=0x1fffff)
> [  329.117743] raw: 0057ffffc0010200 dead000000000100 dead000000000122 ffff88810b407540
> [  329.126392] raw: 0000000000000000 0000000000180018 00000001ffffffff 0000000000000000
> [  329.135038] page dumped because: kasan: bad access detected
>
> [  329.142924] Memory state around the buggy address:
> [  329.148266]  ffff88828fea1100: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  329.156333]  ffff88828fea1180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  329.164397] >ffff88828fea1200: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
> [  329.172462]                    ^
> [  329.176068]  ffff88828fea1280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  329.184134]  ffff88828fea1300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
> [  329.192197] ==================================================================
>
> Thanks,
> Zorro
>
>  tests/generic/639     | 94 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/639.out |  3 ++
>  tests/generic/group   |  1 +
>  3 files changed, 98 insertions(+)
>  create mode 100755 tests/generic/639
>  create mode 100644 tests/generic/639.out
>
> diff --git a/tests/generic/639 b/tests/generic/639
> new file mode 100755
> index 00000000..b280ba62
> --- /dev/null
> +++ b/tests/generic/639
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 639
> +#
> +# Test small swapfile which doesn't contain even a single page-aligned contiguous
> +# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
> +# assignment to unsigned sis->pages in iomap_swapfile_activate").
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
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_scratch_swapfile
> +_require_test_program mkswap
> +_require_test_program swapon
> +_require_xfs_io_command fcollapse
> +
> +make_unaligned_swapfile()
> +{
> +	local fname=$1
> +	local n=$((psize / bsize - 1))
> +
> +	# Make sure the swapfile doesn't contain even a single page-aligned
> +	# contiguous range of blocks. This's necessary to cover the bug
> +	$XFS_IO_PROG -f -t -c "pwrite 0 $(((psize + bsize) * n))" $fname >> $seqres.full 2>&1
> +	for((i=1; i<=n; i++));do
> +		$XFS_IO_PROG -c "fcollapse $(((psize - bsize) * i)) $bsize" $fname
> +	done
> +	chmod 0600 $fname
> +	$CHATTR_PROG +C $fname > /dev/null 2>&1
> +	$here/src/mkswap $fname
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +psize=`get_page_size`
> +bsize=`_get_file_block_size $SCRATCH_MNT`
> +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> +# If not, try to make a smaller enough block size
> +if [ $bsize -ge $psize ];then
> +	_scratch_unmount
> +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
> +	if [ $? -ne 0 ];then
> +		_notrun "Can't make filesystem block size < page size."
> +	fi
> +	_scratch_mount
> +	bsize=`_get_file_block_size $SCRATCH_MNT`
> +	if [ $bsize -ne 1024 ];then
> +		_notrun "Can't force 1024-byte file block size."
> +	fi
> +fi
> +swapfile=$SCRATCH_MNT/$seq.swapfile
> +make_unaligned_swapfile $swapfile
> +# Expect EINVAL from swapon. If not, might miss 5808fecc5723 ("iomap: Fix
> +# negative assignment to unsigned sis->pages in iomap_swapfile_activate")
> +$here/src/swapon $swapfile
> +# Further testing, check if swap size <= swapfile size, if swapon passed
> +if [ $? -eq 0 ];then
> +	swapsize=$(awk -v fname="$swapfile" '{if ($1~fname) print $3}' /proc/swaps)
> +	swapsize=$((swapsize * 1024))
> +	filesize=$(_get_filesize $swapfile)
> +	if [ $swapsize -gt $filesize ]; then
> +		echo "Allocated swap size($swapsize) shouldn't be greater than swapfile size($filesize)"
> +	fi
> +fi
> +swapoff $swapfile 2>/dev/null
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/639.out b/tests/generic/639.out
> new file mode 100644
> index 00000000..181822e5
> --- /dev/null
> +++ b/tests/generic/639.out
> @@ -0,0 +1,3 @@
> +QA output created by 639
> +swapon: Invalid argument
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 9a636b23..48ffa3c7 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -641,3 +641,4 @@
>  636 auto quick swap
>  637 auto quick dir
>  638 auto quick rw
> +639 auto quick swap
> --
> 2.31.1
>
