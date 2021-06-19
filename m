Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51751C48BDF
	for <linux-fstests@archiver.kernel.org>; Sat, 19 Jun 2021 01:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F89161279
	for <linux-fstests@archiver.kernel.org>; Sat, 19 Jun 2021 01:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhFSBNQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Jun 2021 21:13:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231819AbhFSBNQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Jun 2021 21:13:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15J15L5l021304
        for <fstests@vger.kernel.org>; Fri, 18 Jun 2021 21:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=byLCX4j/Jr1fNdX4siHmBT7Yix9RRtacOHAZwb/P78E=;
 b=nywuFJHOKMy0xpOcVHZptssJNU5bSgIs/0sIK8/RL/kCPfIabvk0XPNbb6p+SbKOc2b+
 wKOmvsAMWIItOI5NA4YDnUFMYPRIA9DOoY7qqahOpCJTEkoPvekQWSJW+N2p95UtcdDn
 b7UiiBiVeJTcNu6hrS8zWSLzkGGf9lDd7s2q0Ur4KJ8Z7yWhLLxudZwoLTADroCVcqEZ
 JzNkYqjCPEJTYzx7RywPGqIDLrCHASey2YTNOTWTqlSU4TPGEdPDl1cs2Q5sL/9XEOIA
 fiahub1kTTPFPvhgqbdzMPvPqZLQ3dkQ9axEEf4Y2Mgmg1M5jrijDQTAzMI8HlwSOsKJ 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3995xcgt6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Fri, 18 Jun 2021 21:11:06 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15J15LgU021334
        for <fstests@vger.kernel.org>; Fri, 18 Jun 2021 21:11:05 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3995xcgt5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 21:11:05 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15J18ZKk029313;
        Sat, 19 Jun 2021 01:11:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 394mj91y0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Jun 2021 01:11:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15J19mLS34668892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Jun 2021 01:09:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0676AE056;
        Sat, 19 Jun 2021 01:11:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E27AAE055;
        Sat, 19 Jun 2021 01:11:00 +0000 (GMT)
Received: from localhost (unknown [9.199.33.55])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 19 Jun 2021 01:11:00 +0000 (GMT)
Date:   Sat, 19 Jun 2021 06:40:59 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210619011059.5elo3qtmvlp225oo@riteshh-domain>
References: <20210617050525.902967-1-zlang@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617050525.902967-1-zlang@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -g-HxErNAg7FRPENdwrmUSp4w8tnFJmt
X-Proofpoint-GUID: _5Nuo6c7QrQk82GrlzIC14UB-GoGl7-8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_13:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106190003
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 21/06/17 01:05PM, Zorro Lang wrote:
> If a swapfile doesn't contain even a single page-aligned contiguous
> range of blocks, it's an invalid swapfile, and might cause kernel
> issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> assignment to unsigned sis->pages in iomap_swapfile_activate").

Hi Zorro,

Sorry for getting late on this. So can you reproduce the issue described in the
patch on latest upstream kernel too w/o the above kernel fix with this fstest?

So how I remember it, this fix on older kernel prevented a kernel panic.
But on latest kernel it prevented from adding a fake hugesize swapfile.
In your test, I don't see a test for checking whether the swapfile which was
getting added is of the appropriate size or not. Note that this was only
happening with a tiny swapfile of 1 blocksize(totalsize) only.

If you take a look at [1], we are also checking for
+	# error case
+	if [ $swapsize -gt $filesize ]; then
+		status=1
+		echo "Allocated swap size($swapsize) cannot be greater than swapfile size($filesize)"
+	fi

[1]: https://patchwork.kernel.org/project/fstests/patch/e1f9798462ef60648db24b6291e1b149b114f2f2.1622105066.git.riteshh@linux.ibm.com/

-ritesh


>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>
> Thanks the review from Darrick, V3 did below changes:
> 1) Add _require_xfs_io_command fcollapse
> 2) Change the notrun output if block size isn't 1024.
>
> Thanks,
> Zorro
>
>  tests/generic/639     | 83 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/639.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 86 insertions(+)
>  create mode 100755 tests/generic/639
>  create mode 100644 tests/generic/639.out
>
> diff --git a/tests/generic/639 b/tests/generic/639
> new file mode 100755
> index 00000000..c8d0c6c5
> --- /dev/null
> +++ b/tests/generic/639
> @@ -0,0 +1,83 @@
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
> +$here/src/swapon $swapfile
> +swapoff $swapfile
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/639.out b/tests/generic/639.out
> new file mode 100644
> index 00000000..62c66537
> --- /dev/null
> +++ b/tests/generic/639.out
> @@ -0,0 +1,2 @@
> +QA output created by 639
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
