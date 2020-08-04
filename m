Return-Path: <SRS0=m56w=BO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F90AC433DF
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Aug 2020 15:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205EB22B40
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Aug 2020 15:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iwBiIeOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgHDPlA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:41:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55572 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgHDPk5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Aug 2020 11:40:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074FcC99003582;
        Tue, 4 Aug 2020 15:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=AGDnFJi/kl8ZVeYYCoIv0mNwGrKH1VHoM/+XrEUno7o=;
 b=iwBiIeOLYZk9OUYSni5G3SO6Nk7E8+W86/WJscrgOZj+7ZwnrSnw2KT5gKXueB9vWu2v
 KNUA0vDL5xieRiOlSbu7Pqq15Tfsk2nl45XROentzCEi/oJDjJar6ztiyhcxQ3O7RXE4
 WSm3XjZSjosnB+rIybs8jS1o2FTN1+nVRd3rEEI6DicP1kyYPboYDpr+W+pCUfIiocuw
 az/oeMSIYPXjRzotPa8rQSfi6G0eoNUymQwt7HgnMKfqTEKrkcZBnJt9MOM4Ptpj6Aaw
 yV9Pk5imAscae42E2CQY+/N5w+qoX1TGR+YUKkheRJSLJkYM1qVM/iC4rTK+OoMfeN0C Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32nc9ykp5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 15:40:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074FJ0U8017500;
        Tue, 4 Aug 2020 15:38:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32pdhcbrwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 15:38:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 074Fchi2019121;
        Tue, 4 Aug 2020 15:38:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 08:38:43 -0700
Date:   Tue, 4 Aug 2020 08:38:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com, ira.weiny@intel.com
Subject: Re: [PATCH] generic: Verify how to change the S_DAX flag on an
 existing file
Message-ID: <20200804153841.GC1203354@magnolia>
References: <20200804011140.26674-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804011140.26674-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040117
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 04, 2020 at 09:11:40AM +0800, Xiao Yang wrote:
> Change FS_XFLAG_DAX on an existing file and check if S_DAX on the
> file can take effect immediately by the following steps:
> 1) Stop all applications which are using the file.
> 2) Do drop_caches or umount & mount cycle.

Slightly related question: is there a test to check that if a filesystem
recognizes dax=always, it will also accept dax=inode and dax=none?  This
test checks that dax=always and dax=inode work, but I don't think I saw
one that tests dax=always ensuring that dax=none works too.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Seems decent otherwise,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> Note: It is based on the following patch set:
> https://www.spinics.net/lists/fstests/msg14457.html
> 
>  tests/generic/608     | 110 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/608.out |   2 +
>  tests/generic/group   |   1 +
>  3 files changed, 113 insertions(+)
>  create mode 100644 tests/generic/608
>  create mode 100644 tests/generic/608.out
> 
> diff --git a/tests/generic/608 b/tests/generic/608
> new file mode 100644
> index 00000000..33c5235d
> --- /dev/null
> +++ b/tests/generic/608
> @@ -0,0 +1,110 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
> +#
> +# FS QA Test 608
> +# Change FS_XFLAG_DAX on an existing file and check if S_DAX on
> +# the file can take effect immediately by the following steps:
> +# 1) Stop all applications which are using the file.
> +# 2) Do drop_caches or umount & mount cycle.
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
> +_require_dax_iflag
> +_require_xfs_io_command "lsattr" "-v"
> +_require_xfs_io_command "statx" "-r"
> +
> +test_drop_caches()
> +{
> +	local t_file=$SCRATCH_MNT/testfile
> +
> +	rm -f $t_file
> +	touch $t_file
> +	_check_xflag $t_file 0
> +	_check_s_dax $t_file 0
> +
> +	exec 3< $t_file
> +
> +	$XFS_IO_PROG -c 'chattr +x' $t_file
> +	_check_xflag $t_file 1
> +	_check_s_dax $t_file 0
> +
> +	# One application is using test file and check if S_DAX on
> +	# the file doesn't take effect immediately by drop_caches
> +	echo 2 > /proc/sys/vm/drop_caches
> +	_check_s_dax $t_file 0
> +
> +	exec 3<&-
> +
> +	# No application is using test file and check if S_DAX on
> +	# the file takes effect immediately by drop_caches
> +	echo 2 > /proc/sys/vm/drop_caches
> +	_check_s_dax $t_file 1
> +}
> +
> +test_cycle_mount()
> +{
> +	local t_dir=$SCRATCH_MNT/testdir
> +	local t_file=$t_dir/testfile
> +
> +	mkdir -p $t_dir
> +	$XFS_IO_PROG -c 'chattr +x' $t_dir
> +	rm -f $t_file
> +	touch $t_file
> +	_check_xflag $t_file 1
> +	_check_s_dax $t_file 1
> +
> +	exec 3< $t_file
> +
> +	$XFS_IO_PROG -c 'chattr -x' $t_file
> +	_check_xflag $t_file 0
> +	_check_s_dax $t_file 1
> +
> +	exec 3<&-
> +
> +	# No application is using test file and check if S_DAX on
> +	# the file takes effect immediately by umount & mount
> +	_scratch_cycle_mount "dax=inode"
> +	_check_s_dax $t_file 0
> +}
> +
> +do_tests()
> +{
> +	test_drop_caches
> +
> +	test_cycle_mount
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +
> +_scratch_mount "-o dax=inode"
> +
> +do_tests
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/608.out b/tests/generic/608.out
> new file mode 100644
> index 00000000..1e534458
> --- /dev/null
> +++ b/tests/generic/608.out
> @@ -0,0 +1,2 @@
> +QA output created by 608
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 5bd289c3..aa969bcb 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -610,3 +610,4 @@
>  605 auto attr quick dax
>  606 auto attr quick dax
>  607 auto attr quick dax
> +608 auto attr quick dax
> -- 
> 2.21.0
> 
> 
> 
