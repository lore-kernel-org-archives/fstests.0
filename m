Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE888C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Feb 2022 02:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiBRCd5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Feb 2022 21:33:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiBRCdx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Feb 2022 21:33:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D42D6E7D
        for <fstests@vger.kernel.org>; Thu, 17 Feb 2022 18:33:37 -0800 (PST)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K0G1l6xQ5zbkCf;
        Fri, 18 Feb 2022 10:32:27 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 10:33:35 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 10:33:35 +0800
Subject: Re: [PATCH] common/attr: adbjust acl_max of f2fs
To:     <fstests@vger.kernel.org>, <guan@eryu.me>
CC:     <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20220208071624.1095904-1-sunke32@huawei.com>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <99822864-808b-0672-ba5b-efebaa05d9ef@huawei.com>
Date:   Fri, 18 Feb 2022 10:33:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220208071624.1095904-1-sunke32@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Friendly ping...

ÔÚ 2022/2/8 15:16, Sun Ke Ð´µÀ:
> f2fs has set inline_xattr as a default option, and introduced a new
> option named 'noinline_xattr' for disabling default inline_xattr option.
> So in _acl_get_max we need to check 'noinline_xattr' string in fs
> option, otherwise we may select the wrong max acl number since we always
> found the string 'inline_xattr' in fs option.
>
> Additionally, f2fs has changed disk layout of xattr block a bit, so will
> contain one more entry in both inline and noinline xattr inode, this
> patch will modify the max acl number to adjust it.
>
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>   common/attr | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/common/attr b/common/attr
> index 35682d7c..dae8a1bb 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -26,11 +26,24 @@ _acl_get_max()
>   		echo 8191
>   		;;
>   	f2fs)
> -		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
> +		# If noinline_xattr is enabled, max xattr size should be:
> +		# (4096 - 24) - (24 + 4) = 4044
> +		# then ACL_MAX_ENTRIES should be:
> +		# (4044 - (4 + 4 * 4)) / 8 + 4 = 507
> +		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
>   		if [ $? -eq 0 ]; then
> -			echo 531
> +			echo 507
>   		else
> -			echo 506
> +			# If inline_xattr is enabled, max xattr size should be:
> +			# (4096 - 24 + 200) - (24 + 4) = 4244
> +			# then ACL_MAX_ENTRIES should be:
> +			# (4244 - (4 + 4 * 4)) / 8 + 4 = 532
> +			_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
> +			if [ $? -eq 0 ]; then
> +				echo 532
> +			else
> +				echo 507
> +			fi
>   		fi
>   		;;
>   	bcachefs)
