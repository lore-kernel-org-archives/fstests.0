Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2697AC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Feb 2021 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C599164EEC
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Feb 2021 08:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhBXIc7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Feb 2021 03:32:59 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44491 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234189AbhBXIcS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Feb 2021 03:32:18 -0500
X-IronPort-AV: E=Sophos;i="5.81,202,1610380800"; 
   d="scan'208";a="104811855"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Feb 2021 16:31:27 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1BABD4CE76E3;
        Wed, 24 Feb 2021 16:31:27 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 24 Feb 2021 16:31:18 +0800
Message-ID: <60360ED3.40709@cn.fujitsu.com>
Date:   Wed, 24 Feb 2021 16:31:15 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     XiaoLi Feng <xifeng@redhat.com>
CC:     <fstests@vger.kernel.org>
Subject: Re: [PATCH v3] generic/608: verify S_DAX is active immediately for
 DONTCACHE
References: <20210219164438.26747-1-xifeng@redhat.com>
In-Reply-To: <20210219164438.26747-1-xifeng@redhat.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 1BABD4CE76E3.ABB84
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/2/20 0:44, XiaoLi Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
>
> After upstream linux patches(77573fa310d, 88149082bb8), if
> FS_XFLAG_DAX is set, DONTCACHE is also set. So S_DAX on the file

What do you mean that if FS_XFLAG_DAX is set, DONTCACHE is also set?
It seems that enabling FS_XFLAG_DAX will set DCACHE_DONTCACHE and
I_DONTCACHE automatically.

> should be active immediately once FS_XFLAG_DAX is set.
> ---
>  tests/generic/608 | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/tests/generic/608 b/tests/generic/608
> index dd89d91c..b207602e 100755
> --- a/tests/generic/608
> +++ b/tests/generic/608
> @@ -6,7 +6,10 @@
>  # Change FS_XFLAG_DAX on an existing file and check if S_DAX on
>  # the file can take effect immediately by the following steps:
>  # 1) Stop all applications which are using the file.
> -# 2) Do drop_caches or umount & mount cycle.
> +# 2) Enable the dax flag on the file that no applications are using. 

How about the following comment:
1) When no applications are using an existing file, changing FS_XFLAG_DAX
on the file make S_DAX take effect immediately.
2) When some applications are using an existing file, changing FS_XFLAG_DAX
on the file make S_DAX take effect immediately util all applications stop
using it.

> +# The upstream commit 88149082bb8 make the S_DAX take effect 
> +# immediately because the inode is no longer cached and will re-read
> +# from disk.

Commit 77573fa310d makes S_DAX take effect immediately(i.e. don't depend
drop_caches or umount & mount cycle).
Commit 88149082bb8 is trying to resolve another bug.

>  
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -36,7 +39,7 @@ _require_dax_iflag
>  _require_xfs_io_command "lsattr" "-v"
>  _require_xfs_io_command "statx" "-r"
>  
> -test_drop_caches()
> +test_caches()
>  {
>  	local t_file=$SCRATCH_MNT/testfile
>  
> @@ -49,24 +52,19 @@ test_drop_caches()
>  
>  	$XFS_IO_PROG -c 'chattr +x' $t_file
>  	_check_xflag $t_file 1
> -	_check_s_dax $t_file 0
> -
>  	# One application is using test file and check if S_DAX on
> -	# the file doesn't take effect immediately by drop_caches
> -	echo 2 > /proc/sys/vm/drop_caches
> +	# the file doesn't take effect immediately.
>  	_check_s_dax $t_file 0
>  
>  	exec 3<&-
>  
>  	# No application is using test file and check if S_DAX on
> -	# the file takes effect immediately by drop_caches
> -	echo 2 > /proc/sys/vm/drop_caches
> +	# the file takes effect immediately
>  	_check_s_dax $t_file 1
>  }
>  
> -test_cycle_mount()
> +test_nocache()
>  {
> -	local option=$1
>  	local t_dir=$SCRATCH_MNT/testdir
>  	local t_file=$t_dir/testfile
>  
> @@ -77,30 +75,30 @@ test_cycle_mount()
>  	_check_xflag $t_file 1
>  	_check_s_dax $t_file 1
>  
> -	exec 3< $t_file
> -
> -	$XFS_IO_PROG -c 'chattr -x' $t_file
> +	$XFS_IO_PROG -c 'chattr -x -R' $t_dir
>  	_check_xflag $t_file 0
> -	_check_s_dax $t_file 1
> +	_check_s_dax $t_file 0
>  
> -	exec 3<&-
> +	$XFS_IO_PROG -c 'chattr +x' $t_file
> +	# Here S_DAX on the file will take effect immediately
> +	# because of inode DONTCACHE. 
> +	_check_xflag $t_file 1
> +	_check_s_dax $t_file 1

Why do you need the extra steps?
------------------------------------
78 $XFS_IO_PROG -c 'chattr -x -R' $t_dir
79 _check_xflag $t_file 0
80 _check_s_dax $t_file 0
81
82 $XFS_IO_PROG -c 'chattr +x' $t_file
83 # Here S_DAX on the file will take effect immediately
84 # because of inode DONTCACHE.
85 _check_xflag $t_file 1
86 _check_s_dax $t_file 1
------------------------------------

Best Regards,
Xiao Yang
>  
> -	# No application is using test file and check if S_DAX on
> -	# the file takes effect immediately by umount & mount
> -	_scratch_cycle_mount "$option"
> +	$XFS_IO_PROG -c 'chattr -x' $t_file
> +	_check_xflag $t_file 0
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
> -	test_drop_caches
> +	test_caches
>  
> -	test_cycle_mount "$cycle_mount_option"
> +	test_nocache
>  
>  	_scratch_unmount
>  }
> @@ -108,7 +106,7 @@ do_tests()
>  _scratch_mkfs >> $seqres.full 2>&1
>  
>  # Mount with dax option
> -do_tests "-o dax=inode" "dax=inode"
> +do_tests "-o dax=inode"
>  
>  # Mount without dax option
>  export MOUNT_OPTIONS=""



