Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21289C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 06:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C255364E7A
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 06:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhBRGhh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Feb 2021 01:37:37 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51575 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230356AbhBRGbd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Feb 2021 01:31:33 -0500
X-IronPort-AV: E=Sophos;i="5.81,186,1610380800"; 
   d="scan'208";a="104597204"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Feb 2021 14:30:45 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 134E94CE72EB;
        Thu, 18 Feb 2021 14:30:45 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 18 Feb 2021 14:30:40 +0800
Message-ID: <602E098E.9010509@cn.fujitsu.com>
Date:   Thu, 18 Feb 2021 14:30:38 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     XiaoLi Feng <xifeng@redhat.com>
CC:     <fstests@vger.kernel.org>
Subject: Re: [PATCH v2] common/rc: add filter in _test_inode_flag
References: <20210210083407.19184-1-xifeng@redhat.com>
In-Reply-To: <20210210083407.19184-1-xifeng@redhat.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 134E94CE72EB.AE161
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/2/10 16:34, XiaoLi Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
>
> Add _filter_scratch and _filter_test_dir to avoid _test_inode_flag failed when
> mount point contains flag string.
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/rc b/common/rc
> index 649b1cfd..f3bb665e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3112,7 +3112,7 @@ _test_inode_flag()
>  	local flag=$1
>  	local file=$2
>  
> -	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
> +	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_scratch | _filter_test_dir | grep -q "$flag" ; then
Hi XiaoLi,

Is it ok to use _filter_testdir_and_scratch directly?

Best Regards,
Xiao Yang
>  		return 0
>  	fi
>  	return 1



