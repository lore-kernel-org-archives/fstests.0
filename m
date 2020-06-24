Return-Path: <SRS0=2U3A=AF=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6414BC433E1
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Jun 2020 15:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265EC20723
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Jun 2020 15:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s15CNwwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbgFXPVB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:21:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36320 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403781AbgFXPVA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Jun 2020 11:21:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OEw7dZ100172;
        Wed, 24 Jun 2020 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5fGT2LGRw7/FQJ+bs4A0WrUMpE7kw+rawoEl5OWoOu4=;
 b=s15CNwwNVvkNmGQ0mjbkXBTCZwVsfCAUsIMo9ttS5bPJPvp/j+v9raRWKJJsrah35Lzh
 SwSBfthiOiNV6hih7zrlLcOjtYTVemDe2kgMopgituedw2qMI6R8rOpJ037fsjF45yO4
 wp9U0nq2pAGZ8lTYnTh3ukLbFHEfMMurAzoY/nQ7seNprL32qYX3jhH9mHZJl7D2VxKa
 8xWifIMMxFd3uIoD1qlr/X9j/gpFQ9ivEDwRtQExWJAdHJ/7qIoZA80FkZZm7njF4g5S
 LFGLLDuohlfpobtS0sV7VJpIccRmxqP7S9HH01TLPx3JBcdg6sw4OumHI5L1ICZ6ipYh dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31uustugf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 15:20:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OExZME115007;
        Wed, 24 Jun 2020 15:18:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31uurqynw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 15:18:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05OFItxp003136;
        Wed, 24 Jun 2020 15:18:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 15:18:55 +0000
Date:   Wed, 24 Jun 2020 08:18:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v3] xfs: add test for CVE-2020-12655
Message-ID: <20200624151851.GI7625@magnolia>
References: <20200623020447.5924-1-hsiangkao@redhat.com>
 <20200624010630.4728-1-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624010630.4728-1-hsiangkao@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240107
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 24, 2020 at 09:06:30AM +0800, Gao Xiang wrote:
> Add a regression test to see if kernel hangs in order to
> look after CVE-2020-12655 and check if the corresponding
> fix is applied as well.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> changes since v2:
>  - print mounted, hasmsg out if fails (Darrick);
> 
>  - remove dangerous group since the fix has been
>    in kernel for a while (Darrick)
> 
>  tests/xfs/520     | 86 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/520.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 89 insertions(+)
>  create mode 100755 tests/xfs/520
>  create mode 100644 tests/xfs/520.out
> 
> diff --git a/tests/xfs/520 b/tests/xfs/520
> new file mode 100755
> index 00000000..bdc05f7a
> --- /dev/null
> +++ b/tests/xfs/520
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 520
> +#
> +# Verify kernel doesn't hang when mounting a crafted image
> +# with bad agf.freeblks metadata due to CVE-2020-12655.
> +#
> +# Also, check if
> +# commit d0c7feaf8767 ("xfs: add agf freeblocks verify in xfs_agf_verify")
> +# is included in the current kernel.
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
> +	_scratch_unmount > /dev/null 2>&1
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
> +
> +_supported_fs xfs
> +_supported_os Linux
> +_disable_dmesg_check
> +_require_check_dmesg
> +_require_scratch_nocheck
> +
> +force_crafted_metadata() {
> +	_scratch_mkfs_xfs -f $fsdsopt "$4" >> $seqres.full 2>&1 || _fail "mkfs failed"
> +	_scratch_xfs_set_metadata_field "$1" "$2" "$3" >> $seqres.full 2>&1
> +	local kmsg="xfs/$seq: testing $1=$2 at $(date +"%F %T")"
> +	local mounted=0
> +	local hasmsg=0
> +
> +	echo "${kmsg}" > /dev/kmsg
> +	_try_scratch_mount >> $seqres.full 2>&1 && mounted=1
> +
> +	if [ $mounted -ne 0 ]; then
> +		dd if=/dev/zero of=$SCRATCH_MNT/test bs=65536 count=1 >> \
> +			$seqres.full 2>&1

Just FYI we conventionally use:

$XFS_IO_PROG -f -c 'pwrite 0 64k' $SCRATCH_MNT/test >> $seqres.full

to create files in fstests with less typing, but no need to reroll this
whole thing just for that.

> +		sync
> +	fi
> +
> +	_dmesg_since_test_start | tac | sed -ne "0,\#${kmsg}#p" | tac | \
> +		egrep -q 'Metadata corruption detected at' && hasmsg=1
> +
> +	_scratch_unmount > /dev/null 2>&1
> +	[ $mounted -eq 0 -o $hasmsg -eq 1 ] || \
> +		_fail "potential broken kernel (mounted=${mounted},hasmsg=${hasmsg})"
> +}
> +
> +bigval=100000000
> +fsdsopt="-d agcount=1,size=64m"
> +
> +force_crafted_metadata freeblks 0 "agf 0"
> +force_crafted_metadata longest $bigval "agf 0"
> +force_crafted_metadata length $bigval "agf 0"
> +
> +_scratch_mkfs_xfs_supported -m reflink=1 >> $seqres.full 2>&1 && \
> +	force_crafted_metadata refcntblocks $bigval "agf 0" "-m reflink=1"
> +
> +_scratch_mkfs_xfs_supported -m rmapbt=1 >> $seqres.full 2>&1 && \
> +	force_crafted_metadata rmapblocks $bigval "agf 0" "-m rmapbt=1"
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/520.out b/tests/xfs/520.out
> new file mode 100644
> index 00000000..2a59b872
> --- /dev/null
> +++ b/tests/xfs/520.out
> @@ -0,0 +1,2 @@
> +QA output created by 520
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index daf54add..d6e8d1c3 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -517,3 +517,4 @@
>  517 auto quick fsmap freeze
>  518 auto quick quota
>  519 auto quick reflink
> +520 auto quick reflink

Er... this will hang unpatched kernels, right?  Tests that are known to
do that probably ought to have /some/ warning about that.  Oh, I guess
you do warn about that in the test comment itself.  Ok, good enough
for me.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> -- 
> 2.18.1
> 
