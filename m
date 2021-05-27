Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2899C4707F
	for <linux-fstests@archiver.kernel.org>; Thu, 27 May 2021 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA81B613D3
	for <linux-fstests@archiver.kernel.org>; Thu, 27 May 2021 09:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhE0JUg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 May 2021 05:20:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235608AbhE0JUe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 May 2021 05:20:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R93dWv173031;
        Thu, 27 May 2021 05:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=HqPuibWaReCGl3AxYX6r0cIfBvVO3SvEK1DMRftn6GE=;
 b=VskV7lAEnEAvk6yI2/CzyqedYM3jRbSWmamLTAc03Q2UrogNjh264pO1n8rK/4UZcXsv
 /qizozv41MLHxQRkh2bJia+/LrIwZOEh5kXyZfNgMn1sHsZcxEeN6moqeJJbmkWw8GGw
 OGJa5rtb3FXlnGw9q0aJ0c+Z470Yc1vs+H6KDXSCzdt5537YuNF6p+vaRNK88muIHoR9
 uV3iltQ/FxtQ1jc2CIIMuH28o+4gvx0xG8WCQOAF1RqM0wziJLyAvdHOKVcM1yvaGpsH
 JuU6DTtF24ogABMrPZZwqwi+E2Ee7ToISgNBvgFYHZNbZFP6IRcJ9jDE8qP8LVYfmwkp 3A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38t7bdjtwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 05:19:00 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14R9IXXb026356;
        Thu, 27 May 2021 09:18:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 38s1r493d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 09:18:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14R9IuFQ28115386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 09:18:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56E51A405C;
        Thu, 27 May 2021 09:18:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07A45A405B;
        Thu, 27 May 2021 09:18:56 +0000 (GMT)
Received: from localhost (unknown [9.85.91.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 May 2021 09:18:55 +0000 (GMT)
Date:   Thu, 27 May 2021 14:48:55 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic: test small swapfile without page-aligned
 contiguous blocks
Message-ID: <20210527091855.3tvpubionfxzphu6@riteshh-domain>
References: <20210525044642.552682-1-zlang@redhat.com>
 <20210525044642.552682-2-zlang@redhat.com>
 <20210525160907.GB202095@locust>
 <20210526041351.GE2978781@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526041351.GE2978781@localhost.localdomain>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rqr07yCNtCBmFLkMx8itf5vojRPhWKZn
X-Proofpoint-ORIG-GUID: rqr07yCNtCBmFLkMx8itf5vojRPhWKZn
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_04:2021-05-26,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105270060
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 21/05/26 12:13PM, Zorro Lang wrote:
> On Tue, May 25, 2021 at 09:09:07AM -0700, Darrick J. Wong wrote:
> > On Tue, May 25, 2021 at 12:46:42PM +0800, Zorro Lang wrote:
> > > If a swapfile doesn't contain even a single page-aligned contiguous
> > > range of blocks, it's an invalid swapfile, and might cause kernel
> > > issue. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > > assignment to unsigned sis->pages in iomap_swapfile_activate").
> > >
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >  tests/generic/638     | 79 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/638.out |  2 ++
> > >  tests/generic/group   |  1 +
> > >  3 files changed, 82 insertions(+)
> > >  create mode 100755 tests/generic/638
> > >  create mode 100644 tests/generic/638.out
> > >
> > > diff --git a/tests/generic/638 b/tests/generic/638
> > > new file mode 100755
> > > index 00000000..74bc39cb
> > > --- /dev/null
> > > +++ b/tests/generic/638
> > > @@ -0,0 +1,79 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 638
> > > +#
> > > +# Test small swapfile which doesn't contain even a single page-aligned contiguous
> > > +# range of blocks. This case covered commit 5808fecc5723 ("iomap: Fix negative
> > > +# assignment to unsigned sis->pages in iomap_swapfile_activate").
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_require_scratch
> > > +_require_scratch_swapfile
> > > +_require_test_program mkswap
> > > +_require_test_program swapon
> > > +
> > > +make_unaligned_swapfile()
> > > +{
> > > +	local fname=$1
> > > +	local n=$((psize / bsize - 1))
> > > +
> > > +	# Make sure the swapfile doesn't contain even a single page-aligned
> > > +	# contiguous range of blocks. This's necessary to cover the bug
> > > +	$XFS_IO_PROG -f -t -c "pwrite 0 $(((psize + bsize) * n))" $fname >> $seqres.full 2>&1
> > > +	for((i=1; i<=n; i++));do
> > > +		$XFS_IO_PROG -c "fcollapse $(((psize - bsize) * i)) $bsize" $fname
> > > +	done
> > > +	chmod 0600 $fname
> > > +	$CHATTR_PROG +C $fname > /dev/null 2>&1
> > > +	$here/src/mkswap $fname
> > > +}
> > > +
> > > +_scratch_mkfs >> $seqres.full 2>&1
> > > +_scratch_mount
> > > +psize=`get_page_size`
> > > +bsize=`_get_block_size $SCRATCH_MNT`
> >
> > _get_file_block_size, since fcollapse requires arguments aligned to the
> > file's allocation unit, which isn't necessarily the same as the fs block
> > size (bigalloc, rt, etc.)...
>
> You're right.
>
> >
> > > +# Due to we need page-unaligned blocks, so blocksize < pagesize is necessary.
> > > +# If not, try to make a smaller enough block size
> > > +if [ $bsize -ge $psize ];then
> > > +	_scratch_unmount
> > > +	_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
> >
> > ...which leads me to the next question, which is: Should the above
> > helper override mkfs options as necessary to enforce that the allocation
> > unit is 1024 bytes?  Or is it time for a new helper?
>
> Hmm... the _scratch_mkfs_blocksized() does:
>
>     xfs)
>         _scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
>
> _scratch_mkfs_xfs() already use $MKFS_OPTIONS internally, don't need to give
> $MKFS_OPTIONS to it again. Although _scratch_mkfs_xfs deals with $MKFS_OPTIONS,
> it just drops whole $MKFS_OPTIONS if there're conflicts.
>
> The _scratch_mkfs_geom() does overwrite, but _scratch_mkfs_sized doesn't (sized
> filesystem is rarely seen in local.config). We might let _scratch_mkfs_blocksized
> learn _scratch_mkfs_geom.
>
> >
> > > +	if [ $? -ne 0 ];then
> > > +		_notrun "Can't make filesystem block size < page size"
> > > +	fi
> > > +	_scratch_mount
> > > +	bsize=1024
> >
> > You probably want to re-check _get_file_block_size to make sure that you
> > actually got blocksize < pagesize in the format attempt.
>
> Yes, you're right. _scratch_mkfs_blocksized can't make sure to get that blocksize.
>

Sorry, about delay in getting a test ready for this kernel bug. Also I only now
noticed this patch of yours, after I had sent a patch generic/639 to cover this
bug. (sheer coincidence).

I have tested [1] on both x86 and Power platform for all filesystems config.
(ext4-1k, ext4-4k. ext4-64k, ext2, xfs-1k, xfs-4k, xfs-64k, btrfs) (64k if for Power)
But I am fine if you would like to push your patch upstream.

[1]: https://patchwork.kernel.org/project/fstests/patch/e1f9798462ef60648db24b6291e1b149b114f2f2.1622105066.git.riteshh@linux.ibm.com/

-ritesh
