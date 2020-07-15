Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C59C433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 02:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D852072D
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 02:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGOCsk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:48:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:10144 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgGOCsj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Jul 2020 22:48:39 -0400
IronPort-SDR: Dyrb0UXyBzhOsYEZMAxbLO1SjsxxuAR/qtGUtbVKJHfa61zwv6N74kpJZG8U1PI/oOlSq74S78
 alSxW7gCIN4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="129159192"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="129159192"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 19:48:39 -0700
IronPort-SDR: kzzlk0c1uLfqDgq/Eaip5op2fssJ7ZMCL62jiDG9oo/F6mYy7+1nIfC6nVQsgZgEVm4EQOZ+D2
 soHErILjysEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="486091752"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2020 19:48:39 -0700
Date:   Tue, 14 Jul 2020 19:48:39 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v6 7/7] generic: Verify the inheritance behavior of
 FS_XFLAG_DAX flag in various combinations
Message-ID: <20200715024838.GI3008823@iweiny-DESK2.sc.intel.com>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-8-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714094009.8654-8-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 14, 2020 at 05:40:09PM +0800, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/generic/605     | 199 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/605.out |   2 +
>  tests/generic/group   |   1 +
>  3 files changed, 202 insertions(+)
>  create mode 100644 tests/generic/605
>  create mode 100644 tests/generic/605.out
> 
> diff --git a/tests/generic/605 b/tests/generic/605
> new file mode 100644
> index 00000000..6924223a
> --- /dev/null
> +++ b/tests/generic/605
> @@ -0,0 +1,199 @@
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
> +_require_scratch
> +_require_dax_iflag
> +_require_xfs_io_command "lsattr" "-v"
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

It really seems like 2 and 3 test the same thing?

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
> +do_xflag_tests()
> +{
> +	local option=$1
> +
> +	_scratch_mount "$option"
> +	cd $SCRATCH_MNT
> +
> +	for i in $(seq 1 5); do
> +		test_xflag_inheritance${i}
> +	done
> +
> +	cd - > /dev/null
> +	_scratch_unmount
> +}
> +
> +check_dax_mountopt()
> +{
> +	local option=$1
> +	local ret=0
> +
> +	_try_scratch_mount "-o $option" >> $seqres.full 2>&1 || return 1
> +
> +	# Match option name exactly
> +	_fs_options $SCRATCH_DEV | egrep -q "$option(,|$)" || ret=1
> +
> +	_scratch_unmount
> +
> +	return $ret
> +}

Should this be a common function?

> +
> +do_tests()
> +{
> +	# Mount without dax option
> +	do_xflag_tests
> +
> +	# Mount with old dax option if fs only supports it.
> +	check_dax_mountopt "dax" && do_xflag_tests "-o dax"

I don't understand the order here.  If we are on an older kernel and the FS
only supports '-o dax' the do_xflag_tests will fail won't it?

So shouldn't we do this first and bail/'not run' this test if that is the case?

I really don't think there is any point in testing the old XFS behavior because
the FS_XFLAG_DAX had no effect.  So even if it is broken it does not matter.
Or perhaps I am missing something here?

Ira

> +
> +	# Mount with new dax options if fs supports them.
> +	if check_dax_mountopt "dax=always"; then
> +		for dax_option in "dax=always" "dax=inode" "dax=never"; do
> +			do_xflag_tests "-o $dax_option"
> +		done
> +	fi
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
