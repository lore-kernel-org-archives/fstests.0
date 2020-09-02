Return-Path: <SRS0=Km02=CL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0A8C433E2
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Sep 2020 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BA820829
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Sep 2020 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fRVUR6h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIBQoN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:44:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgIBQoK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Sep 2020 12:44:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082GhnuB148690;
        Wed, 2 Sep 2020 16:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1SKghxvR7y4Ha1ggTXJzwwj3wTtP05V3IBH03BAwu8c=;
 b=fRVUR6h1xghxqnwNRL/147hRlZ5BF2m//tShUQghKEezeg9HV8fles1K517TBCQlPvdM
 ee3wboHGbcWKuRQKx7iaoLgM9Nbe+0haNb2L419tySdLOmPMO62pBJ6oQTrBhV9p4A++
 q/XdXWGgfOWRCb36RfWwitnn0q69zIZr2B0zF786ufvlAFiiqvh8jDbFcT5gfxazRWYO
 CiH997r6ElnivrlL3ZfTqjRYyoS8T5iHUnihG2aDKF2dil5QJEmMV9Wh66jR49VNTTVq
 JshchawcmI35ZKrEtn24J+egzTJvpZJV9wuHDYNjs0m5tjvf4bniTIJn1ADl6nWqsKWR wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmn28tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 16:43:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082Gf40D046776;
        Wed, 2 Sep 2020 16:43:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3380su9x4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 16:43:49 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082GhkEH006971;
        Wed, 2 Sep 2020 16:43:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 09:43:46 -0700
Date:   Wed, 2 Sep 2020 09:43:45 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     guaneryu@gmail.com, richard@nod.at, yuchao0@huawei.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] generic: add test for race between listxattr and
 setxatr
Message-ID: <20200902164345.GD191798@magnolia>
References: <364596a1-c9bb-3a10-a132-0f43907c2241@huawei.com>
 <20200822114132.61227-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822114132.61227-1-houtao1@huawei.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020160
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 22, 2020 at 07:41:32PM +0800, Hou Tao wrote:
> Add reproducer for a bug on ubifs where listxattr() copies
> the newly created xattr names regardless of the remaining
> buffer size, fails the assertion of used buffer size,
> and may corrupt buffer memory.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> v2: accommodate f2fs by reducing the number of created xattrs for f2fs
> 
>  tests/generic/998     | 67 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/998.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 70 insertions(+)
>  create mode 100644 tests/generic/998
>  create mode 100644 tests/generic/998.out
> 
> diff --git a/tests/generic/998 b/tests/generic/998
> new file mode 100644
> index 00000000..26a5b620
> --- /dev/null
> +++ b/tests/generic/998
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Huawei. All Rights Reserved.
> +#
> +# FS QA Test 998
> +#
> +# Test race between listxattr() and setxattr(). It reproduces a bug
> +# on UBIFS where listxattr() copies the newly created xattr names
> +# regardless of the remaining buffer size, fails the assertion of
> +# used buffer size, and may corrupt buffer memory.
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
> +	rm -f $TEST_DIR/$seq
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_attrs
> +
> +target=$TEST_DIR/$seq
> +touch $target
> +
> +# start a background listxattr
> +runfile="$tmp.listxattr"
> +touch $runfile
> +while [ -e $runfile ]; do
> +	${GETFATTR_PROG} $target >/dev/null 2>&1

Er, if the listxattr corrupts the buffer memory, how does this test
detect that?  Does the kernel crash or something?

> +done &
> +
> +# add new xattr continuously
> +largename=`for i in $(seq 0 128); do echo -n a; done`
> +cnt=100
> +# f2fs has limited spaces for xattr
> +[ $FSTYP == "f2fs" ] && cnt=30
> +for i in $(seq 1 $cnt); do
> +	${SETFATTR_PROG} -n user.${largename}.$i -v $i $target

Seeing as each filesystem has different xattr limits, I wonder if
instead of special casing of f2fs we ought to capture the
stdout/stderr of SETFATTR_PROG and filter out the ENOSPC message?

AFAICT this test isn't trying to check that setting xattrs succeeds, but
I'm a little confused on how we detect the corrupted buffer...

--D

> +done
> +
> +rm -f $runfile
> +wait > /dev/null 2>&1
> +rm -f $target
> +
> +echo Silence is golden
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/998.out b/tests/generic/998.out
> new file mode 100644
> index 00000000..d2679ae0
> --- /dev/null
> +++ b/tests/generic/998.out
> @@ -0,0 +1,2 @@
> +QA output created by 998
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index d9ab9a31..62697ac5 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -605,3 +605,4 @@
>  600 auto quick quota
>  601 auto quick quota
>  602 auto quick encrypt
> +998 auto quick attr
> -- 
> 2.25.0.4.g0ad7144999
> 
