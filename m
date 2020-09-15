Return-Path: <SRS0=6hky=CY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126BCC43461
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 01:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81E420771
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 01:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JU2Cibky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgIOBs6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:48:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42420 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOBs5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Sep 2020 21:48:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08F1iGSQ059093;
        Tue, 15 Sep 2020 01:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0nLjeKREjcgY0ZkuwH2Go1MgrUYiDmjnfkObdRsOblA=;
 b=JU2Cibkyw76uxAxq6k/3oSDOMA46CZ0pmQN6Z5XVrOReaZ1aEdDEjbt2v0hHDiTaA4UF
 CpwDrGx2cGWs9z7IDh9mu8aa+sFo1d2A2KCoCD5cen8qEWm3C5TQJh0cdzuA1SErVj4J
 cFrvkw7Oct7t3m5Oq30R2ymoas9j1LN79+SRW3MUi5HoYYJtOOJ6gi+AoFU7QhiHggTm
 Rm/7xIu8zNnx/PvGO0Zwb9/uGdi6B7xytF53q1mFHdG2oG4uxEvCUd5T62cvKtUSdYLp
 rxqkakGtLjabso7VRBy8gUnVzcGFAmV7VG+ohRJsD7Ek7yaQZcYyPu9jLwJuV5mCBbNV fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33j91dbj0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 01:48:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08F1jmhf133397;
        Tue, 15 Sep 2020 01:48:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33hm2ycrrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 01:48:54 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08F1mrUX003376;
        Tue, 15 Sep 2020 01:48:53 GMT
Received: from localhost (/10.159.147.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 01:48:53 +0000
Date:   Mon, 14 Sep 2020 18:48:51 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200915014851.GB7954@magnolia>
References: <20200914153213.76894-1-preichl@redhat.com>
 <20200914153213.76894-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914153213.76894-2-preichl@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150012
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 05:32:13PM +0200, Pavel Reichl wrote:
> Add a regression test to check that the boundary test
> for the fixed-offset parts of xfs_attr_sf_entry
> in xfs_attr_shortform_verify is not off by one.
> 
> This can be shown by:
> 
> touch file
> setfattr -n user.a file
> 
> With help from Zorro. Thanks very much.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

Looks good,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/611     | 61 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/611.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 64 insertions(+)
>  create mode 100755 tests/generic/611
>  create mode 100644 tests/generic/611.out
> 
> diff --git a/tests/generic/611 b/tests/generic/611
> new file mode 100755
> index 00000000..283327e4
> --- /dev/null
> +++ b/tests/generic/611
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
> +#
> +# FS QA Test 611
> +#
> +# Verify that metadata won't get corrupted when extended attribute
> +# name of size one is set.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# f4020438fab0 ("xfs: fix boundary test in xfs_attr_shortform_verify")
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
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_attrs
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +localfile="${SCRATCH_MNT}/testfile"
> +
> +touch "${localfile}"
> +"${SETFATTR_PROG}" -n user.a "${localfile}"
> +
> +# Make sure that changes are written to disk
> +_scratch_cycle_mount
> +
> +# If the target bug isn't fixed, getfattr fails
> +${GETFATTR_PROG} --absolute-names -n user.a $localfile | grep 'user.a'
> +
> +# Make sure the filesystem isn't corrupted manually
> +_scratch_unmount
> +
> +status=0
> +exit
> diff --git a/tests/generic/611.out b/tests/generic/611.out
> new file mode 100644
> index 00000000..1ab12434
> --- /dev/null
> +++ b/tests/generic/611.out
> @@ -0,0 +1,2 @@
> +QA output created by 611
> +user.a=""
> diff --git a/tests/generic/group b/tests/generic/group
> index 8eba6c98..4af4b494 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -613,3 +613,4 @@
>  608 auto attr quick dax
>  609 auto quick rw
>  610 auto quick prealloc zero
> +611 auto quick attr
> -- 
> 2.26.2
> 
