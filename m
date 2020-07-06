Return-Path: <SRS0=V6JG=AR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7288EC433DF
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jul 2020 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57140206E9
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jul 2020 18:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W3rZE9uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgGFS24 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:28:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45740 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbgGFS2z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jul 2020 14:28:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066ILvMk008025;
        Mon, 6 Jul 2020 18:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WWZk696N0SDuhvxDL8P74bW5m4kyH+QtbLs51loUcxM=;
 b=W3rZE9uoMthCArlHPkHxNe8FDSX1yg8F0sfjZzW30OZaIsyFLD6eubyDidACuljTTWO3
 SxKHKsxJKnStgwQKEpKQa3YGMGeDIGSaoe4NgjCizHmgmlpNzjFom4I80QOUPxFNqxzI
 Gz4/KfzwfM+NdsvpCO2w8iUo+lAvdPhrp6PD0Vlpu0lNiMogmkSUe09/DDkE5Mlun8VM
 /7DAVKbWTim/DuBXHiLamd6+Y7RgsFR79ZuK1e43S8WvfMRCu+9PWGdqqvynZvZ+LKxY
 8DKlsPjnU8hA2QO8hWdw8UAEflUKwCieOM4CNcOC+hdOVo9sXx3eaaBIBZ49zFCafVkF HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 323wacbx8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Jul 2020 18:28:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066IMu72059392;
        Mon, 6 Jul 2020 18:28:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3243pd8vcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jul 2020 18:28:38 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 066ISaap023555;
        Mon, 6 Jul 2020 18:28:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jul 2020 11:28:36 -0700
Date:   Mon, 6 Jul 2020 11:28:35 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH v2] generic: Verify if statx() can qurey S_DAX flag on
 regular file correctly
Message-ID: <20200706182835.GX7625@magnolia>
References: <20200703015145.21197-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703015145.21197-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9673 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9673 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 cotscore=-2147483648
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060127
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 03, 2020 at 09:51:45AM +0800, Xiao Yang wrote:
> With new kernel(e.g. v5.8-rc1), statx() can be used to qurey S_DAX flag
> on regular file, so add a test to verify the feature.
> 
> Reference:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=712b2698e4c024b561694cbcc1abba13eb0fd9ce
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

LGTM,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> Note: this patch depends on the following patch set:
> https://www.spinics.net/lists/fstests/msg14252.html
> 
> V1->V2:
> Fix a typo(S_SAX->S_DAX).
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
> index 00000000..3f0de4f4
> --- /dev/null
> +++ b/tests/generic/604
> @@ -0,0 +1,100 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
> +#
> +# FS QA Test 604
> +#
> +# By the following cases, verify if statx() can query S_DAX flag
> +# on regular file correctly.
> +# 1) With dax=always option, FS_XFLAG_DAX is ignored and S_DAX flag
> +#    always exists on regular file.
> +# 2) With dax=inode option, setting/clearing FS_XFLAG_DAX can change
> +#    S_DAX flag on regular file.
> +# 3) With dax=never option, FS_XFLAG_DAX is ignored and S_DAX flag
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
