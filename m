Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF2CC433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828746193A
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 18:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhC2SVG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:21:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:63208 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231527AbhC2SU6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Mar 2021 14:20:58 -0400
IronPort-SDR: 7sggpyIcD5XabmH2Ib5tJt3BN0ct2QBRrySLDq3lgOIQ/A5MwN8NpfVYaUdGFqi8UnD7yg7G1c
 RYklvQvFW/bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="188337297"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="188337297"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 11:20:58 -0700
IronPort-SDR: YdQYC2/+NK8xmblWmdvCOCrjsBhTq+rZKoZ2N5GFBHg06rbdIVGYOiQNwq7dUqZVa/kPc51fJN
 0yP4wwSHBhHQ==
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="437997229"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 11:20:58 -0700
Date:   Mon, 29 Mar 2021 11:20:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        lihao2018.fnst@fujitsu.com, david@fromorbit.com, xifeng@redhat.com
Subject: Re: [PATCH v2 1/2] generic/608: Remove drop cache and umount & mount
 cycle
Message-ID: <20210329182058.GY3014244@iweiny-DESK2.sc.intel.com>
References: <20210329092054.5278-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329092054.5278-1-yangx.jy@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 29, 2021 at 05:20:53PM +0800, Xiao Yang wrote:
> Since commit e7bed0b5bc4b, toggling FS_XFLAG_DAX on an existing file can make
> S_DAX on the file change immediately when all applications close the file.
> As a result, we don't need the redundant drop cache and umount & mount cycle.
> 
> Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

LGTM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  tests/generic/608 | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/generic/608 b/tests/generic/608
> index 861bbff5..d81a2488 100755
> --- a/tests/generic/608
> +++ b/tests/generic/608
> @@ -3,10 +3,10 @@
>  # Copyright (c) 2020 Fujitsu.  All Rights Reserved.
>  #
>  # FS QA Test 608
> -# Change FS_XFLAG_DAX on an existing file and check if S_DAX on
> -# the file can take effect immediately by the following steps:
> -# 1) Stop all applications which are using the file.
> -# 2) Do drop_caches or umount & mount cycle.
> +# Toggling FS_XFLAG_DAX on an existing file can make S_DAX on the
> +# file change immediately when all applications close the file.
> +# It's a regression test for:
> +# 'commit e7bed0b5bc4b ("fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set")'
>  
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -36,7 +36,7 @@ _require_dax_iflag
>  _require_xfs_io_command "lsattr" "-v"
>  _require_xfs_io_command "statx" "-r"
>  
> -test_drop_caches()
> +test_enable_dax()
>  {
>  	local t_file=$SCRATCH_MNT/testfile
>  
> @@ -49,24 +49,19 @@ test_drop_caches()
>  
>  	$XFS_IO_PROG -c 'chattr +x' $t_file
>  	_check_xflag $t_file 1
> -	_check_s_dax $t_file 0
> -
> -	# One application is using test file and check if S_DAX on
> -	# the file doesn't take effect immediately by drop_caches
> -	echo 2 > /proc/sys/vm/drop_caches
> +	# One application is using test file and S_DAX
> +	# on the file is not changed immediately
>  	_check_s_dax $t_file 0
>  
>  	exec 3<&-
>  
> -	# No application is using test file and check if S_DAX on
> -	# the file takes effect immediately by drop_caches
> -	echo 2 > /proc/sys/vm/drop_caches
> +	# No application is using test file and S_DAX
> +	# on the file is changed immediately
>  	_check_s_dax $t_file 1
>  }
>  
> -test_cycle_mount()
> +test_disable_dax()
>  {
> -	local option=$1
>  	local t_dir=$SCRATCH_MNT/testdir
>  	local t_file=$t_dir/testfile
>  
> @@ -81,29 +76,29 @@ test_cycle_mount()
>  
>  	$XFS_IO_PROG -c 'chattr -x' $t_file
>  	_check_xflag $t_file 0
> +	# One application is using test file and S_DAX
> +	# on the file is not changed immediately
>  	_check_s_dax $t_file 1
>  
>  	exec 3<&-
>  
> -	# No application is using test file and check if S_DAX on
> -	# the file takes effect immediately by umount & mount
> -	_scratch_cycle_mount "$option"
> +	# No application is using test file and S_DAX
> +	# on the file is changed immediately
>  	_check_s_dax $t_file 0
>  }
>  
>  do_tests()
>  {
>  	local mount_option=$1
> -	local cycle_mount_option=$2
>  
>  	_scratch_mount "$mount_option"
>  
>  	# Make sure the root dir doesn't have FS_XFLAG_DAX set before we start.
>  	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT &>> $seqres.full
>  
> -	test_drop_caches
> -
> -	test_cycle_mount "$cycle_mount_option"
> +	# Do test for commit e7bed0b5bc4b
> +	test_enable_dax
> +	test_disable_dax
>  
>  	_scratch_unmount
>  }
> @@ -111,7 +106,7 @@ do_tests()
>  _scratch_mkfs >> $seqres.full 2>&1
>  
>  # Mount with dax option
> -do_tests "-o dax=inode" "dax=inode"
> +do_tests "-o dax=inode"
>  
>  # Mount without dax option
>  export MOUNT_OPTIONS=""
> -- 
> 2.21.0
> 
> 
> 
