Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3BBC43466
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 17:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F512085B
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 17:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sysABkR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgIURMH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 13:12:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49210 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIURMH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 13:12:07 -0400
X-Greylist: delayed 1731 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 13:12:06 EDT
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LGdV40145874;
        Mon, 21 Sep 2020 16:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Y2/BWtSbRk7hXsQd75ORBVbrmhAVRNg40nmFv8yzQSw=;
 b=sysABkR5rN7scJ6420g+dAbpt2aY4Q37E6VT7ebngajymG0jeINdV1Jf0dunWVs5zfTW
 /dLAfdcVRaCDE1eID6XsgJLUfKggQwruGbnKHrGrduHAmQ20jRpVq+qW1Drfit4d4xAJ
 RY4ooeVx1ogQYRdlg/DpqBs/EQM/vcI2bNtOiqkkq21WhWEeZmBKC87OvS40HG4F/3cp
 2EHbygqgcAaAtsuVNLyNC5tkOu3fE/CDpwyf0mhsaHHsG/mY/DBFdwtP+AiL3KZ459po
 2r05ZbE7rSDx1dFFNxP9Tsgf9d3xwKOHEOqKJZfPa/J73WxwLh3+X17WRlp+NFrKpfkx Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33n7ga9hd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 16:43:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LGgKv0033830;
        Mon, 21 Sep 2020 16:43:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33nurr4bhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 16:43:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08LGhBfZ026828;
        Mon, 21 Sep 2020 16:43:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 09:43:10 -0700
Date:   Mon, 21 Sep 2020 09:43:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] xfs: Add test for too-small device with stripe
 geometry
Message-ID: <20200921164309.GO7954@magnolia>
References: <20200921085511.98739-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921085511.98739-1-preichl@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=1 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210118
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 21, 2020 at 10:55:11AM +0200, Pavel Reichl wrote:
> Verify hat an attempt to create a too-small device with stripe geometry,
> is handled gracefully instead of hitting an assert in align_ag_geometry()
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

Looks ok (afaict the only change was removing _supported_os?)
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/260     | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/260.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 54 insertions(+)
>  create mode 100755 tests/xfs/260
>  create mode 100644 tests/xfs/260.out
> 
> diff --git a/tests/xfs/260 b/tests/xfs/260
> new file mode 100755
> index 00000000..f4da0302
> --- /dev/null
> +++ b/tests/xfs/260
> @@ -0,0 +1,51 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc.. All Rights Reserved.
> +#
> +# FS QA Test 260
> +#
> +# Verify that an attempt to create a too-small device with stripe geometry,
> +# is handled gracefully instead of hitting an assert in align_ag_geometry()
> +#
> +# This test verifies the problem fixed in xfsprogs with commit
> +# (mkfs.xfs: fix ASSERT on too-small device with stripe geometry)
> +#
> +
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
> +	rm -f $localfile
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +echo 'Silence is golden'
> +
> +_supported_fs xfs
> +_require_test
> +
> +localfile=$TEST_DIR/$seq.$$
> +
> +$XFS_IO_PROG -f -c "truncate 10444800" $localfile
> +
> +$MKFS_XFS_PROG -dsu=65536,sw=1 $localfile >> $seqres.full 2>&1
> +
> +[ $? -ne 1 ] && echo "${MKFS_XFS_PROG} should fail gracefully"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/260.out b/tests/xfs/260.out
> new file mode 100644
> index 00000000..18ca517c
> --- /dev/null
> +++ b/tests/xfs/260.out
> @@ -0,0 +1,2 @@
> +QA output created by 260
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index b8374359..c8713ca5 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -257,6 +257,7 @@
>  257 auto quick clone
>  258 auto quick clone
>  259 auto quick
> +260 auto quick mkfs
>  261 auto quick quota
>  262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>  263 auto quick quota
> -- 
> 2.26.2
> 
