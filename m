Return-Path: <SRS0=J6Lv=C3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84BBC43463
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Sep 2020 15:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E8C23888
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Sep 2020 15:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nwB2+QvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRPQP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:16:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRPQO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Sep 2020 11:16:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IF91nC157727;
        Fri, 18 Sep 2020 15:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BuTyfpCFYQbxnhFQNbbvjLxshHI6ZMXTdXV6OmdwrDI=;
 b=nwB2+QvIQDtjM/tke/nPg5kDefZExqfDKH2FnpZBTx2Yib1MEQQsOCUCLIz7lxiU4d6u
 BbO+MmM/PYxHaN3g7wsOQQeVpox0cWhkOmBDTz/qArJuOH3dKKVIVv/kXnkxTpaCoOtL
 vzM6Mq3vPNxE6SztnqQqMiTRM67yQ8fHnq/ppT6c2CnXofqJKoYPhH2BDtzXfVMGgSJH
 PbqxgZ5HUB/hP/9ciNJLp+gcicS0+Ee5JzOtdTZtNT9vqt9ofSAtnPbrQmSll4dOMnWi
 XGGum4sviZpO95TVqY3HsQvWVGckByAhIhgKnT3EK5TYtxnfy9+/qN3cAFe4wO21nNf1 Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33gp9mqr14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 15:16:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IFA5El037375;
        Fri, 18 Sep 2020 15:14:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33hm370mwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 15:14:11 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08IFEA9Q008178;
        Fri, 18 Sep 2020 15:14:10 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 15:14:09 +0000
Date:   Fri, 18 Sep 2020 08:14:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs: Add test for too-small device with stripe
 geometry
Message-ID: <20200918151409.GM7954@magnolia>
References: <20200918061514.115764-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918061514.115764-1-preichl@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180125
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 18, 2020 at 08:15:14AM +0200, Pavel Reichl wrote:
> Verify hat an attempt to create a too-small device with stripe geometry,
> is handled gracefully instead of hitting an assert in align_ag_geometry()
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/260     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/260.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 55 insertions(+)
>  create mode 100755 tests/xfs/260
>  create mode 100644 tests/xfs/260.out
> 
> diff --git a/tests/xfs/260 b/tests/xfs/260
> new file mode 100755
> index 00000000..4e81d634
> --- /dev/null
> +++ b/tests/xfs/260
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
> +#
> +# FS QA Test 260
> +#
> +# Verify that an attempt to create a too-small device with stripe geometry,
> +# is handled gracefully instead of hitting an assert in align_ag_geometry()
> +#
> +# This test verifies the problem fixed in kernel with commit
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
> +_supported_os Linux
> +_require_test
> +
> +localfile=$TEST_DIR/260.$$
> +
> +truncate --size=10444800 $localfile
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
> index ed0d389e..7a6dfed7 100644
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
