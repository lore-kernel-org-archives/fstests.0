Return-Path: <SRS0=C+DF=BN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CB9C433DF
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 19:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBF022BF3
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgHCTyg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:54:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:15668 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgHCTyf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 3 Aug 2020 15:54:35 -0400
IronPort-SDR: 4p8RPS0BVlZpg8e0J3VGrN/Vfs/SLkC+Kekbvj8X1+/H5bm2HphnKifOYGNAdcwVjE9DfD8NEa
 vOfZheQsVxqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="139778265"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="139778265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 12:54:35 -0700
IronPort-SDR: gdenbtF9/TimXTQFd/TDisS2TRXv3Mmd38vqNQD3Wza59lv1AqEJzD14K/XjogwypgR7XASiwi
 AiXCjFUlGDRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="396255062"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2020 12:54:35 -0700
Date:   Mon, 3 Aug 2020 12:54:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v8 7/7] generic: Verify the inheritance behavior of
 FS_XFLAG_DAX flag in various combinations
Message-ID: <20200803195434.GG1573827@iweiny-DESK2.sc.intel.com>
References: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
 <20200803083838.26222-8-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803083838.26222-8-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 03, 2020 at 04:38:38PM +0800, Xiao Yang wrote:
> Also factor out _check_xflag() so that other tests can use it in future.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  common/rc             |  12 +++
>  tests/generic/607     | 187 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/607.out |   2 +
>  tests/generic/group   |   1 +
>  4 files changed, 202 insertions(+)
>  create mode 100644 tests/generic/607
>  create mode 100644 tests/generic/607.out
> 
> diff --git a/common/rc b/common/rc
> index a358702e..9af0aa72 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3209,6 +3209,18 @@ _check_s_dax()
>  	fi
>  }
>  
> +_check_xflag()
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
>  # Only accept dax/dax=always mount option becasue dax=always, dax=inode
>  # and dax=never are always introduced together.
>  # Return 0 if filesystem/device supports the specified dax option.
> diff --git a/tests/generic/607 b/tests/generic/607
> new file mode 100644
> index 00000000..f7e17cb3
> --- /dev/null
> +++ b/tests/generic/607
> @@ -0,0 +1,187 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
> +#
> +# FS QA Test 607
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
> +# If a/ is +x, check that a's new children
> +# inherit +x from a/.
> +test_xflag_inheritance1()
> +{
> +	mkdir -p a
> +	$XFS_IO_PROG -c "chattr +x" a
> +	mkdir -p a/b/c
> +	touch a/b/c/d
> +
> +	_check_xflag a 1
> +	_check_xflag a/b 1
> +	_check_xflag a/b/c 1
> +	_check_xflag a/b/c/d 1
> +
> +	rm -rf a
> +}
> +
> +# If a/ is +x and b/ is -x, check that:
> +# 1) b's new children inherit -x from b/.
> +# 2) a's new children(b/ is old) inherit +x from a/.
> +test_xflag_inheritance2()
> +{
> +	mkdir -p a/b
> +	$XFS_IO_PROG -c "chattr +x" a
> +	mkdir -p a/b/c a/d
> +	touch a/b/c/e a/d/f
> +
> +	_check_xflag a 1
> +	_check_xflag a/b 0
> +	_check_xflag a/b/c 0
> +	_check_xflag a/b/c/e 0
> +	_check_xflag a/d 1
> +	_check_xflag a/d/f 1
> +
> +	rm -rf a
> +}
> +
> +# If a/ is -x and b/ is +x, check that:
> +# 1) b's new children inherit +x from b/.
> +# 2) a's new children(b/ is old) inherit -x from a/.
> +test_xflag_inheritance3()
> +{
> +	mkdir -p a/b
> +	$XFS_IO_PROG -c "chattr +x" a/b
> +	mkdir -p a/b/c a/d
> +	touch a/b/c/e a/d/f
> +
> +	_check_xflag a 0
> +	_check_xflag a/b 1
> +	_check_xflag a/b/c 1
> +	_check_xflag a/b/c/e 1
> +	_check_xflag a/d 0
> +	_check_xflag a/d/f 0
> +
> +	rm -rf a
> +}
> +
> +# If a/, c/ are +x and b/ is -x, check that:
> +# 1) c's new children inherit +x from c/.
> +# 2) b's new children(c/ is old) inherit -x from b/.
> +test_xflag_inheritance4()
> +{
> +	mkdir -p a
> +	$XFS_IO_PROG -c "chattr +x" a
> +	mkdir -p a/b/c
> +	$XFS_IO_PROG -c "chattr -x" a/b
> +	mkdir -p a/b/c/d a/b/e
> +	touch a/b/c/d/f a/b/e/g
> +
> +	_check_xflag a 1
> +	_check_xflag a/b 0
> +	_check_xflag a/b/c 1
> +	_check_xflag a/b/c/d 1
> +	_check_xflag a/b/c/d/f 1
> +	_check_xflag a/b/e 0
> +	_check_xflag a/b/e/g 0
> +
> +	rm -rf a
> +}
> +
> +# If a/ is +x and b/ is -x, check that:
> +# 1) new b/c and b/g inherit -x from b/ by cp.
> +# 2) new a/e inherits +x from a/ by cp.
> +# 3) new b/d preserves +x from a/ by mv.
> +# 4) new a/f and a/h preserve -x from b/ by mv.
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
> +	_check_xflag b/c 0
> +	_check_xflag b/d 1
> +	_check_xflag a/e 1
> +	_check_xflag a/f 0
> +	_check_xflag b/g 0
> +	_check_xflag a/h 0
> +
> +	rm -rf a b
> +}
> +
> +do_xflag_tests()
> +{
> +	local option=$1
> +
> +	_scratch_mkfs >> $seqres.full 2>&1
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
> +do_tests()
> +{
> +	# Mount without dax option
> +	do_xflag_tests
> +
> +	# Mount with 'dax' or 'dax=always' option if fs supports it.
> +	_check_scratch_dax_mountopt "dax" && do_xflag_tests "-o dax"
> +
> +	# Mount with 'dax=inode' and 'dax=never' options if fs supports them.
> +	if _check_scratch_dax_mountopt "dax=always"; then
> +		for dax_option in "dax=inode" "dax=never"; do
> +			do_xflag_tests "-o $dax_option"
> +		done
> +	fi
> +}
> +
> +do_tests
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/607.out b/tests/generic/607.out
> new file mode 100644
> index 00000000..d02de53b
> --- /dev/null
> +++ b/tests/generic/607.out
> @@ -0,0 +1,2 @@
> +QA output created by 607
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 05c6b02d..5bd289c3 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -609,3 +609,4 @@
>  604 auto quick mount
>  605 auto attr quick dax
>  606 auto attr quick dax
> +607 auto attr quick dax
> -- 
> 2.21.0
> 
> 
> 
