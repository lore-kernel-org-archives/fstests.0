Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD30C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 06:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B22D64E2F
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 06:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBRGQ3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Feb 2021 01:16:29 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55044 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232005AbhBRGKI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Feb 2021 01:10:08 -0500
X-IronPort-AV: E=Sophos;i="5.81,186,1610380800"; 
   d="scan'208";a="104596658"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Feb 2021 14:09:09 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 818804CE6F85;
        Thu, 18 Feb 2021 14:09:03 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 18 Feb 2021 14:08:59 +0800
Message-ID: <602E0478.401@cn.fujitsu.com>
Date:   Thu, 18 Feb 2021 14:08:56 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     XiaoLi Feng <xifeng@redhat.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] generic/608: verify S_DAX is active immediately for
 DONTCACHE
References: <20210210075815.13958-1-xifeng@redhat.com>
In-Reply-To: <20210210075815.13958-1-xifeng@redhat.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 818804CE6F85.A9842
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/2/10 15:58, XiaoLi Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
>
> After upstream linux patches(77573fa310d, 88149082bb8), if
> FS_XFLAG_DAX is set, DONTCACHE is also set. So S_DAX on the file
> should be active immediately once FS_XFLAG_DAX is set.
> ---
>  tests/generic/608 | 38 +++++++++++---------------------------
>  1 file changed, 11 insertions(+), 27 deletions(-)
>
> diff --git a/tests/generic/608 b/tests/generic/608
> index dd89d91c..92f368e0 100755
> --- a/tests/generic/608
> +++ b/tests/generic/608
> @@ -6,7 +6,7 @@
>  # Change FS_XFLAG_DAX on an existing file and check if S_DAX on
>  # the file can take effect immediately by the following steps:
>  # 1) Stop all applications which are using the file.
> -# 2) Do drop_caches or umount & mount cycle.
> +# 2) DONTCACHE is set.
Hi XiaoLi,

It is better to add the related commits here.

>  
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -36,7 +36,7 @@ _require_dax_iflag
>  _require_xfs_io_command "lsattr" "-v"
>  _require_xfs_io_command "statx" "-r"
>  
> -test_drop_caches()
> +test_caches()
>  {
>  	local t_file=$SCRATCH_MNT/testfile
>  
> @@ -51,56 +51,40 @@ test_drop_caches()
>  	_check_xflag $t_file 1
>  	_check_s_dax $t_file 0
>  
> -	# One application is using test file and check if S_DAX on
> -	# the file doesn't take effect immediately by drop_caches
> -	echo 2 > /proc/sys/vm/drop_caches
> -	_check_s_dax $t_file 0

I want to add a similar comment in front of "_check_s_dax $t_file 0":
-------------------------------------
50 $XFS_IO_PROG -c 'chattr +x' $t_file
51 _check_xflag $t_file 1
52 # One application is using test file and check if S_DAX on
53 # the file doesn't take effect immediately
54 _check_s_dax $t_file 0
-------------------------------------

> -
>  	exec 3<&-
>  
>  	# No application is using test file and check if S_DAX on
>  	# the file takes effect immediately by drop_caches

Please remove the 'by drop_caches'

> -	echo 2 > /proc/sys/vm/drop_caches
>  	_check_s_dax $t_file 1
>  }
>  
> -test_cycle_mount()
> +test_nocache()
>  {
> -	local option=$1
> -	local t_dir=$SCRATCH_MNT/testdir
> -	local t_file=$t_dir/testfile
> +	local t_file=$SCRATCH_MNT/testnocache
>  
> -	mkdir -p $t_dir
> -	$XFS_IO_PROG -c 'chattr +x' $t_dir
>  	rm -f $t_file
>  	touch $t_file
> +	_check_xflag $t_file 0
> +	_check_s_dax $t_file 0

Inheriting xflag and S_DAX from the parent directory is a good variety
so I want to keep the $t_dir which has enabled xflag.

Best Regards,
Xiao Yang

> +
> +	$XFS_IO_PROG -c 'chattr +x' $t_file
>  	_check_xflag $t_file 1
>  	_check_s_dax $t_file 1
>  
> -	exec 3< $t_file
> -
>  	$XFS_IO_PROG -c 'chattr -x' $t_file
>  	_check_xflag $t_file 0
> -	_check_s_dax $t_file 1
> -
> -	exec 3<&-
> -
> -	# No application is using test file and check if S_DAX on
> -	# the file takes effect immediately by umount & mount
> -	_scratch_cycle_mount "$option"
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
> @@ -108,7 +92,7 @@ do_tests()
>  _scratch_mkfs >> $seqres.full 2>&1
>  
>  # Mount with dax option
> -do_tests "-o dax=inode" "dax=inode"
> +do_tests "-o dax=inode"
>  
>  # Mount without dax option
>  export MOUNT_OPTIONS=""



