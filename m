Return-Path: <SRS0=/czi=BP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D6BC433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 02:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C558E208C7
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 02:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHEC4A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:56:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:14937 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725950AbgHEC4A (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Aug 2020 22:56:00 -0400
X-IronPort-AV: E=Sophos;i="5.75,436,1589212800"; 
   d="scan'208";a="97628692"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Aug 2020 10:55:50 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 8061A4CE34E7;
        Wed,  5 Aug 2020 10:55:46 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 5 Aug 2020 10:55:46 +0800
Message-ID: <5F2A1FB1.9020403@cn.fujitsu.com>
Date:   Wed, 5 Aug 2020 10:55:45 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>, <guaneryu@gmail.com>
Subject: Re: [PATCH v2] generic: Verify how to change the S_DAX flag on an
 existing file
References: <20200805024507.32702-1-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200805024507.32702-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 8061A4CE34E7.AB978
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Darrick, Ira

If you prove the v2 patch, I will add the combination(without dax option)
into all related tests from my v8 patch set.

Thanks,
Xiao Yang
On 2020/8/5 10:45, Xiao Yang wrote:
> Change FS_XFLAG_DAX on an existing file and check if S_DAX on the
> file can take effect immediately by the following steps:
> 1) Stop all applications which are using the file.
> 2) Do drop_caches or umount & mount cycle.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
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



