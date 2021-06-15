Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D480C48BDF
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Jun 2021 03:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4206140D
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Jun 2021 03:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFODbX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:31:23 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6369 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFODbW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Jun 2021 23:31:22 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G3txC2xY1z61BC;
        Tue, 15 Jun 2021 11:25:19 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:29:17 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 dggema759-chm.china.huawei.com (10.1.198.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:29:16 +0800
Subject: Re: [PATCH] generic/260: f2fs is also special
To:     <fstests@vger.kernel.org>, <guan@eryu.me>, <yuchao0@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210611112211.1408767-1-sunke32@huawei.com>
 <20210611112211.1408767-3-sunke32@huawei.com>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <87024647-0ece-929d-8aa6-8dab9609159c@huawei.com>
Date:   Tue, 15 Jun 2021 11:29:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210611112211.1408767-3-sunke32@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

to linux-f2fs-devel@lists.sourceforge.net

ÔÚ 2021/6/11 19:22, Sun Ke Ð´µÀ:
> It seem that f2fs also special like btrfs.
> 
>   [+] Default length with start set (should succeed)
>   [+] Length beyond the end of fs (should succeed)
>   [+] Length beyond the end of fs with start set (should succeed)
> +After the full fs discard 0 bytes were discarded however the file system is 12882804736 bytes long.
> +It seems that fs logic handling len argument overflows
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> I am not sure about that. o(¨s¡õ¨t)o
> 
>   tests/generic/260 | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/260 b/tests/generic/260
> index 8021aa68..6bd861d2 100755
> --- a/tests/generic/260
> +++ b/tests/generic/260
> @@ -100,7 +100,7 @@ fi
>   # It is because btrfs does not have not-yet-used parts of the device
>   # mapped and since we got here right after the mkfs, there is not
>   # enough free extents in the root tree.
> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
> +if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
>   	status=1
>   	echo "After the full fs discard $bytes bytes were discarded"\
>   	     "however the file system is $(_math "$fssize*1024") bytes long."
> @@ -160,7 +160,7 @@ _scratch_mount
>   # mapped and since we got here right after the mkfs, there is not
>   # enough free extents in the root tree.
>   bytes=$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
> +if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
>   	status=1
>   	echo "It seems that fs logic handling len argument overflows"
>   fi
> 
