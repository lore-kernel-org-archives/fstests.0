Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442D8C3DA79
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Dec 2022 12:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiL2Mws (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiL2MwZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Dec 2022 07:52:25 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866A13EB1
        for <fstests@vger.kernel.org>; Thu, 29 Dec 2022 04:52:23 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NjSqb4P31z9t1R;
        Thu, 29 Dec 2022 20:48:27 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 29 Dec 2022 20:52:21 +0800
Message-ID: <918b74a0-0451-6eb9-9d4a-6ae540cdc5f8@huawei.com>
Date:   Thu, 29 Dec 2022 20:52:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: supporting overlay+tmpfs breaks check -n -overlay -g auto
To:     Murphy Zhou <jencce.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <CADJHv_sJHyhgaJoAJCZY0VpO6u8vGHOzD3qBgv5EW3vYSNjfuA@mail.gmail.com>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
CC:     "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
In-Reply-To: <CADJHv_sJHyhgaJoAJCZY0VpO6u8vGHOzD3qBgv5EW3vYSNjfuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/12/12 9:42, Murphy Zhou wrote:
> Hi,
>
> Bisecting points me to this commit:
>
> commit 92fb58afaa2f38a9369ad5791a4cbf135545617d
> Author: Baokun Li <libaokun1@huawei.com>
> Date:   Wed May 11 16:34:04 2022 +0800
>
>      common: xfstests support overlay+tmpfs
>
>
> It breaks this command:
> ./check -n -overlay -g auto
>
> As a result, it fails to show me the list of testcases.
>
> Please help to check.
>
> Thanks!
> Murphy

Thank you very much for reporting this issue!
I think I figured out the cause of the problem.

In the above commit, the "-t $OVL_BASE_FSTYP" command is used to
specify the overlay base mount file system type. If FSTYP is used to
specify BASE_FSTYP in config, the file system type can be identified.
However, if you use the environment variable FSTYP to specify BASE_FSTYP,
there is no corresponding logic. Sometimes, even FSTYP is not specified.
In this case, the mounting command is similar to

      "_mount -t /dev/sdb /tmp/scratch".

As a result, the preceding problem is triggered.

I will send a patch to fix the problem.
Thanks!
--
With Best Regards,
Baokun Li
