Return-Path: <SRS0=zmF6=AT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF71C433E1
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jul 2020 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A69206DF
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jul 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="seAANjro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgGHPr7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:47:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44942 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbgGHPr5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Jul 2020 11:47:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068Fajhd189125;
        Wed, 8 Jul 2020 15:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6wj0STiAHFR5V1jEqtWWaXMEFLDJpcWwhd+f4yCIig8=;
 b=seAANjrons6nlV12/tseZkPiTykWnrkFxpJlWxzL2Kb0ZsE1AdL3+mM5vTk+8AcgLdGj
 TvbPXzKC6CBEzxhj/yCalChRs/fN6OHl3ckKZfNNVsIpTSm/ebsJPWxTSHFoRulL8ong
 gBaVIfK/EIEZqNAGYlhaWrzVHgPuPUqzfycbhq+uasY8EjK/Zy8wFs9QiaXjgTIVUet+
 OPAiGOD2EIkwBLOsuEghNH88Q4RFz135AGg5xUzk/wF1rfRmkd5Rd9DSK0t0zGiCBaX7
 U+bZ2bYV6crXH8Brum75VhbjImeFvYNumZP6wuXGZYO39/7VAaDfcvL2D3nRUdlH3HUd ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 322kv6kdds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 15:47:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068FdF3h132184;
        Wed, 8 Jul 2020 15:47:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3233br2b96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 15:47:41 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 068Flff6017356;
        Wed, 8 Jul 2020 15:47:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 08:47:40 -0700
Date:   Wed, 8 Jul 2020 08:47:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH] generic: Verify the inheritance behavior of FS_XFLAG_DAX
 flag in various combinations
Message-ID: <20200708154739.GF7600@magnolia>
References: <20200708082544.21624-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708082544.21624-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080106
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 08, 2020 at 04:25:44PM +0800, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
> 
> Note: this patch depends on the following patches:
> https://www.spinics.net/lists/fstests/msg14252.html
> https://www.spinics.net/lists/fstests/msg14272.html

You might want to add this test onto that series then...

> 
>  tests/generic/605     | 169 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/605.out |   2 +
>  tests/generic/group   |   1 +
>  3 files changed, 172 insertions(+)
>  create mode 100644 tests/generic/605
>  create mode 100644 tests/generic/605.out
> 
> diff --git a/tests/generic/605 b/tests/generic/605
> new file mode 100644
> index 00000000..c44271e8
> --- /dev/null
> +++ b/tests/generic/605
> @@ -0,0 +1,169 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
> +#
> +# FS QA Test 605
> +#
> +# Verify the inheritance behavior of FS_XFLAG_DAX flag in various combinations.
> +# 1) New files and directories automatically inherit FS_XFLAG_DAX from their parent directory.
> +# 2) cp operation make files and directories inherit the FS_XFLAG_DAX from new parent directory.
> +# 3) mv operation make files and directories preserve the FS_XFLAG_DAX from old parent directory.
> +# In addition, setting/clearing FS_XFLAG_DAX flag is not impacted by dax mount options.
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1        # failure is the default!
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
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_dax_mountopt "dax=always"

Do you actually need this?  I'd hate to leave this test out of reach for
people who don't have pmem or can't simulate it reliably.  We
deliberately left this flag separate from S_DAX so that the ondisk
metadata flag would always have consistent behavior no matter what
hardware is underneath.

OTOH I guess you're also trying to check that the FS_XFLAG_DAX behavior
is the same with all the dax= mount options applied.  Since this is one
of the 'silence is golden' tests, how about dropping this requirement
and running the test_xflag_inheritance* functions once with no dax
options at all; then we see if the fs will mount with dax=always, and if
so, run all those tests again with each of the dax= mount options?

The rest looks good to me.

--D

> +_require_scratch_dax_iflag
> +_require_xfs_io_command "lsattr"
> +
> +check_xflag()
> +{
> +	local target=$1
> +	local exp_xflag=$2
> +
> +	if [ $exp_xflag -eq 0 ]; then
> +		_test_inode_flag dax $target && echo "$target has unexpected FS_XFLAG_DAX flag"
> +	else
> +		_test_inode_flag dax $target || echo "$target doen't have expected FS_XFLAG_DAX flag"
> +	fi
> +}
> +
> +test_xflag_inheritance1()
> +{
> +	mkdir -p a
> +	$XFS_IO_PROG -c "chattr +x" a
> +	mkdir -p a/b/c
> +	touch a/b/c/d
> +
> +	check_xflag a 1
> +	check_xflag a/b 1
> +	check_xflag a/b/c 1
> +	check_xflag a/b/c/d 1
> +
> +	rm -rf a
> +}
> +
> +test_xflag_inheritance2()
> +{
> +	mkdir -p a/b
> +	$XFS_IO_PROG -c "chattr +x" a
> +	mkdir -p a/b/c a/d
> +	touch a/b/c/e a/d/f
> +
> +	check_xflag a 1
> +	check_xflag a/b 0
> +	check_xflag a/b/c 0
> +	check_xflag a/b/c/e 0
> +	check_xflag a/d 1
> +	check_xflag a/d/f 1
> +
> +	rm -rf a
> +}
> +
> +test_xflag_inheritance3()
> +{
> +	mkdir -p a/b
> +	$XFS_IO_PROG -c "chattr +x" a/b
> +	mkdir -p a/b/c a/d
> +	touch a/b/c/e a/d/f
> +
> +	check_xflag a 0
> +	check_xflag a/b 1
> +	check_xflag a/b/c 1
> +	check_xflag a/b/c/e 1
> +	check_xflag a/d 0
> +	check_xflag a/d/f 0
> +
> +	rm -rf a
> +}
> +
> +test_xflag_inheritance4()
> +{
> +	mkdir -p a
> +	$XFS_IO_PROG -c "chattr +x" a
> +	mkdir -p a/b/c
> +	$XFS_IO_PROG -c "chattr -x" a/b
> +	mkdir -p a/b/c/d a/b/e
> +	touch a/b/c/d/f a/b/e/g
> +
> +	check_xflag a 1
> +	check_xflag a/b 0
> +	check_xflag a/b/c 1
> +	check_xflag a/b/c/d 1
> +	check_xflag a/b/c/d/f 1
> +	check_xflag a/b/e 0
> +	check_xflag a/b/e/g 0
> +
> +	rm -rf a
> +}
> +
> +test_xflag_inheritance5()
> +{
> +	mkdir -p a b
> +	$XFS_IO_PROG -c "chattr +x" a
> +	mkdir -p a/c a/d b/e b/f
> +	touch a/g b/h
> +
> +	cp -r a/c b/
> +	cp -r b/e a/
> +	cp -r a/g b/
> +	mv a/d b/
> +	mv b/f a/
> +	mv b/h a/
> +
> +	check_xflag b/c 0
> +	check_xflag b/d 1
> +	check_xflag a/e 1
> +	check_xflag a/f 0
> +	check_xflag b/g 0
> +	check_xflag a/h 0
> +
> +	rm -rf a b
> +}
> +
> +do_tests()
> +{
> +	# Mount with various dax options
> +	for dax_option in "dax=always" "dax=inode" "dax=never"; do
> +		_scratch_mount "-o $dax_option"
> +		cd $SCRATCH_MNT
> +
> +		for i in $(seq 1 5); do
> +			test_xflag_inheritance${i}
> +		done
> +
> +		cd - > /dev/null
> +		_scratch_unmount
> +	done
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +
> +do_tests
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/605.out b/tests/generic/605.out
> new file mode 100644
> index 00000000..1ae20049
> --- /dev/null
> +++ b/tests/generic/605.out
> @@ -0,0 +1,2 @@
> +QA output created by 605
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 676e0d2e..a8451862 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -607,3 +607,4 @@
>  602 auto quick encrypt
>  603 auto attr quick dax
>  604 auto attr quick dax
> +605 auto attr quick dax
> -- 
> 2.21.0
> 
> 
> 
