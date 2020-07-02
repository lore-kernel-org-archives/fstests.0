Return-Path: <SRS0=RsO5=AN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E08C433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jul 2020 15:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EF9206B7
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jul 2020 15:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MImYZM9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgGBPUs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:20:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgGBPUr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Jul 2020 11:20:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EvRE8018123;
        Thu, 2 Jul 2020 15:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=feEHxVjghYNPiIgqlO2xGdShq48nv6V4l4vjrVFvT+E=;
 b=MImYZM9F9ST1dwcj++Pqk4EI1gOo3QeaXJgD39HWyIw2zt5nRTo8wME7443/M57J4i5I
 QgMlWhJQgxJYgkc/d6eGx2uk5SKiCXUr4X0ONQYY2djtoO7KQAoZX/330rS5Csb0q/+n
 Sje8BU6aZOx+1zXoj7a0pw1q9/MdFsAG+ToOkDHRGeth9KIzXVSoiXzPy2d3zl7zoTjN
 mR5Lv87JAlKzNt/KCvCGuERf5ZvvlXfgXiotOcU8XAdBpQ0tlDC02F5TSCoVLtFl7Ia7
 q0FEQutRFxzlRxwqbubgEOBDsBET5DL4GKSuerWlXq41K0KIUgm6vBNe39yqpQCWk8UH hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31ywrbya25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:20:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EwoS0089741;
        Thu, 2 Jul 2020 15:18:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31xg19hxu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:18:33 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 062FIWag017268;
        Thu, 2 Jul 2020 15:18:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:18:32 +0000
Date:   Thu, 2 Jul 2020 08:18:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH] generic: Verify if statx() can qurey S_SAX flag on
 regular file correctly
Message-ID: <20200702151831.GR7625@magnolia>
References: <20200702063544.17106-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702063544.17106-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020106
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 02, 2020 at 02:35:44PM +0800, Xiao Yang wrote:
> With new kernel(e.g. v5.8-rc1), statx() can be used to qurey S_SAX flag

No, we don't have a VFS flag for saxomophone. ;)

Maybe you meant S_DAX?

--D

> on regular file, so add a test to verify the feature.
> 
> Reference:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=712b2698e4c024b561694cbcc1abba13eb0fd9ce
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
> 
> Note: this patch depends on the following patch set:
> https://www.spinics.net/lists/fstests/msg14252.html
> 
>  tests/generic/604     | 100 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/604.out |   2 +
>  tests/generic/group   |   1 +
>  3 files changed, 103 insertions(+)
>  create mode 100644 tests/generic/604
>  create mode 100644 tests/generic/604.out
> 
> diff --git a/tests/generic/604 b/tests/generic/604
> new file mode 100644
> index 00000000..b0baa781
> --- /dev/null
> +++ b/tests/generic/604
> @@ -0,0 +1,100 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
> +#
> +# FS QA Test 604
> +#
> +# By the following cases, verify if statx() can query S_SAX flag
> +# on regular file correctly.
> +# 1) With dax=always option, FS_XFLAG_DAX is ignored and S_SAX flag
> +#    always exists on regular file.
> +# 2) With dax=inode option, setting/clearing FS_XFLAG_DAX can change
> +#    S_SAX flag on regular file.
> +# 3) With dax=never option, FS_XFLAG_DAX is ignored and S_SAX flag
> +#    never exists on regular file.
> +#
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
> +_require_scratch_dax_iflag
> +_require_xfs_io_command "statx" "-r"
> +
> +PARENT_DIR=$SCRATCH_MNT/testdir
> +TEST_FILE=$PARENT_DIR/testfile
> +
> +check_s_dax()
> +{
> +	local exp_s_dax=$1
> +
> +	local attributes=$($XFS_IO_PROG -c 'statx -r' $TEST_FILE | awk '/stat.attributes / { print $3 }')
> +	if [ $exp_s_dax -eq 0 ]; then
> +		(( attributes & 0x2000 )) && echo "$TEST_FILE has unexpected S_DAX flag"
> +	else
> +		(( attributes & 0x2000 )) || echo "$TEST_FILE doen't have expected S_DAX flag"
> +	fi
> +}
> +
> +test_s_dax()
> +{
> +	local dax_option=$1
> +	local exp_s_dax1=$2
> +	local exp_s_dax2=$3
> +
> +	# Mount with specified dax option
> +	_scratch_mount "-o $dax_option"
> +
> +	# Prepare directory
> +	mkdir -p $PARENT_DIR
> +
> +	rm -f $TEST_FILE
> +	$XFS_IO_PROG -c "chattr +x" $PARENT_DIR
> +	touch $TEST_FILE
> +	# Check if setting FS_XFLAG_DAX changes S_DAX flag
> +	check_s_dax $exp_s_dax1
> +
> +	rm -f $TEST_FILE
> +	$XFS_IO_PROG -c "chattr -x" $PARENT_DIR
> +	touch $TEST_FILE
> +	# Check if clearing FS_XFLAG_DAX changes S_DAX flag
> +	check_s_dax $exp_s_dax2
> +
> +	_scratch_unmount
> +}
> +
> +do_tests()
> +{
> +	test_s_dax "dax=always" 1 1
> +	test_s_dax "dax=inode" 1 0
> +	test_s_dax "dax=never" 0 0
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
> diff --git a/tests/generic/604.out b/tests/generic/604.out
> new file mode 100644
> index 00000000..c06a1c7f
> --- /dev/null
> +++ b/tests/generic/604.out
> @@ -0,0 +1,2 @@
> +QA output created by 604
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 1d0d5606..676e0d2e 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -606,3 +606,4 @@
>  601 auto quick quota
>  602 auto quick encrypt
>  603 auto attr quick dax
> +604 auto attr quick dax
> -- 
> 2.21.0
> 
> 
> 
