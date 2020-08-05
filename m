Return-Path: <SRS0=/czi=BP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2DEC433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 15:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2EC23109
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 15:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TyponqGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHEPs6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Aug 2020 11:48:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49120 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgHEPsh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Aug 2020 11:48:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075FgA8k159618;
        Wed, 5 Aug 2020 15:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=N6QqiQ/5LRbcYCrLRXX6P5iyjyLX/UrO29rjCCcglxQ=;
 b=TyponqGi93/opJ46CoiRyxI2G7LPtD7ISnA62AMMQu6oE3aIjVbcEAm0HU4ZJ8Rkulz7
 vGZveVTZmXLwD8Mfwe6zEduHCo0JsBjezmDD43mVzxvWQ8ipbgMeFRzx0msdFZvz2xF6
 pkBArx+R9kcoz4Ps26rGdI5OVOj3dPpBilhmCOOgoQufIZXlPiM3rEl09Kan4HEPBOZF
 RYTVzO0V/N3GxgWkQon5o+8Rhh3t65ELO0/xmdJuCN16c/lGPwMLyF1qTywevEpOfcgE
 AHZxnSDKg0EPn3WxJyxcqErKsgxtNpnBQ1Div0h1O/PH2duD+is6cPoydPngyrkRMN/Y 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32n11natpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 15:45:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075Fgwjr104178;
        Wed, 5 Aug 2020 15:45:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32qy8kh7x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 15:45:50 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 075Fjn8d001686;
        Wed, 5 Aug 2020 15:45:49 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 08:45:48 -0700
Date:   Wed, 5 Aug 2020 08:45:47 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com, guaneryu@gmail.com
Subject: Re: [PATCH v2] generic: Verify how to change the S_DAX flag on an
 existing file
Message-ID: <20200805154547.GA191798@magnolia>
References: <20200805024507.32702-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805024507.32702-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050127
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 05, 2020 at 10:45:07AM +0800, Xiao Yang wrote:
> Change FS_XFLAG_DAX on an existing file and check if S_DAX on the
> file can take effect immediately by the following steps:
> 1) Stop all applications which are using the file.
> 2) Do drop_caches or umount & mount cycle.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> Note: It is based on the following patch set:
> https://www.spinics.net/lists/fstests/msg14457.html
> 
> V1->V2:
> Add a combination(without dax option) to do tests.
> 
>  tests/generic/608     | 121 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/608.out |   2 +
>  tests/generic/group   |   1 +
>  3 files changed, 124 insertions(+)
>  create mode 100644 tests/generic/608
>  create mode 100644 tests/generic/608.out
> 
> diff --git a/tests/generic/608 b/tests/generic/608
> new file mode 100644
> index 00000000..705ae4b3
> --- /dev/null
> +++ b/tests/generic/608
> @@ -0,0 +1,121 @@
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
> +	local option=$1
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
> +	_scratch_cycle_mount "$option"
> +	_check_s_dax $t_file 0
> +}
> +
> +do_tests()
> +{
> +	local mount_option=$1
> +	local cycle_mount_option=$2
> +
> +	_scratch_mount "$mount_option"
> +
> +	test_drop_caches
> +
> +	test_cycle_mount "$cycle_mount_option"
> +
> +	_scratch_unmount
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +
> +# mount with dax option
> +do_tests "-o dax=inode" "dax=inode"
> +
> +# mount without dax option
> +export MOUNT_OPTIONS=""
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
