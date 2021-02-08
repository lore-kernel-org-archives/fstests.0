Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45148C433E6
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Feb 2021 01:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2AF64E25
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Feb 2021 01:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBHB2J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Feb 2021 20:28:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3624 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229618AbhBHB2J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Feb 2021 20:28:09 -0500
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="104306040"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 09:27:20 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 172944CE6F81;
        Mon,  8 Feb 2021 09:27:19 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 09:27:19 +0800
Message-ID: <60209375.8060802@cn.fujitsu.com>
Date:   Mon, 8 Feb 2021 09:27:17 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     XiaoLi Feng <xifeng@redhat.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>
Subject: Re: [PATCH v1] generic/608: verify S_DAX is active immediately for
 DONTCACHE
References: <20210205141708.2558-1-xifeng@redhat.com>
In-Reply-To: <20210205141708.2558-1-xifeng@redhat.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 172944CE6F81.AE4CF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi XiaoLi,

I prefer to update the existing tests because both writing drop_caches
and remount are unnecessary since Li Hao's patches.
test_drop_caches --> test_drop_cache
test_cycle_mount --> test_nocache

The detail of test_drop_cache:
-------------------------------
test_caches()
{
local t_file=$SCRATCH_MNT/testfile

rm -f $t_file
touch $t_file
_check_xflag $t_file 0
_check_s_dax $t_file 0

exec 3< $t_file

$XFS_IO_PROG -c 'chattr +x' $t_file
_check_xflag $t_file 1
_check_s_dax $t_file 0

# One application is using test file and check if S_DAX on
# the file doesn't take effect immediately
_check_s_dax $t_file 0

exec 3<&-

# No application is using test file and check if S_DAX on
# the file takes effect immediately
_check_s_dax $t_file 1
}
-------------------------------

Best Regards,
Xiao Yang
On 2021/2/5 22:17, XiaoLi Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
>
> After upstream linux patches(77573fa310d, 88149082bb8), if
> FS_XFLAG_DAX is set, DONTCACHE is also set. So S_DAX on the file
> should be active immediately once FS_XFLAG_DAX is set.
>
> Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> ---
>  tests/generic/608 | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tests/generic/608 b/tests/generic/608
> index dd89d91c..278fb4d1 100755
> --- a/tests/generic/608
> +++ b/tests/generic/608
> @@ -7,6 +7,7 @@
>  # the file can take effect immediately by the following steps:
>  # 1) Stop all applications which are using the file.
>  # 2) Do drop_caches or umount & mount cycle.
> +# 3) DONTCACHE is set.
>  
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -91,6 +92,20 @@ test_cycle_mount()
>  	_check_s_dax $t_file 0
>  }
>  
> +test_nocache()
> +{
> +	local t_file=$SCRATCH_MNT/testnocache
> +
> +	rm -f $t_file
> +	touch $t_file
> +	_check_xflag $t_file 0
> +	_check_s_dax $t_file 0
> +
> +	$XFS_IO_PROG -c 'chattr +x' $t_file
> +	_check_xflag $t_file 1
> +	_check_s_dax $t_file 1
> +}
> +
>  do_tests()
>  {
>  	local mount_option=$1
> @@ -100,6 +115,8 @@ do_tests()
>  
>  	test_drop_caches
>  
> +	test_nocache
> +
>  	test_cycle_mount "$cycle_mount_option"
>  
>  	_scratch_unmount



