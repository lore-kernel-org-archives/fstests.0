Return-Path: <SRS0=clGf=3F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726EAC33CB1
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447192073A
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 09:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAPJ21 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:28:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10208 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726535AbgAPJ20 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jan 2020 04:28:26 -0500
X-IronPort-AV: E=Sophos;i="5.70,325,1574092800"; 
   d="scan'208";a="81969360"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Jan 2020 17:28:25 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 44B2D49E9331;
        Thu, 16 Jan 2020 17:19:18 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 16 Jan 2020 17:28:24 +0800
Subject: Re: [PATCH v2] generic/520: Remove sync in clean_dir
To:     <fdmanana@gmail.com>
CC:     <darrick.wong@oracle.com>, <fstests@vger.kernel.org>
References: <1577096499-23471-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1da0408c-1570-7b2a-d3b7-44748f6b480e@cn.fujitsu.com>
Date:   Thu, 16 Jan 2020 17:28:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1577096499-23471-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 44B2D49E9331.AC09F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


on 2019/12/23 18:21, Yang Xu wrote:
> When I test this case on xfs, it may fail as below:
> --------------------------------------------
>   === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
> +umount: /mnt/xfstests/scratch: target is busy.
> +        (In some cases useful info about processes that use
> +         the device is found by lsof(8) or fuser(1))
> ---------------------------------------------
Does someone review this?
> 
> It fails because somethings is still using the fs when we call sync and then
> try to unmount it. We can simply remove sync as the unmount is supposed to
> persist the file/directory removals.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   tests/generic/520 | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/520 b/tests/generic/520
> index 167d7077..d4457370 100755
> --- a/tests/generic/520
> +++ b/tests/generic/520
> @@ -58,7 +58,6 @@ clean_dir()
>   {
>   	_mount_flakey
>   	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
> -	sync
>   	_unmount_flakey
>   }
>   
> 


