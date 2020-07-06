Return-Path: <SRS0=V6JG=AR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE2C433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jul 2020 15:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA312070C
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jul 2020 15:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgGFPhm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:37:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:48878 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgGFPhl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 6 Jul 2020 11:37:41 -0400
IronPort-SDR: EcGNM1dFWkdYZT1V26yvKNN9iJYg5Ql+4ZmQNv2CHqX7Q/snY8NiZ+ZGYx1PFYP8nDm8yidkgt
 pDOiHICXUCwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="232286042"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="232286042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 08:37:41 -0700
IronPort-SDR: FqzpyIbQTVmbWX3qfbAhK+h6tN2YNh21N5xOnFg7Ah/Rt+OeOAzVvwuwzudy0anw1aloTnwA16
 TDBxiG8A+ZMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="315202236"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2020 08:37:41 -0700
Date:   Mon, 6 Jul 2020 08:37:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2] generic: Verify if statx() can qurey S_DAX flag on
 regular file correctly
Message-ID: <20200706153739.GA1123188@iweiny-DESK2.sc.intel.com>
References: <20200703015145.21197-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703015145.21197-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

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
