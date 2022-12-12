Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA5AC4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 02:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiLLCIi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Dec 2022 21:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiLLCIh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Dec 2022 21:08:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0FA2C2
        for <fstests@vger.kernel.org>; Sun, 11 Dec 2022 18:08:35 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NVlQ20YrTzmWZ9
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 10:07:38 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 10:08:33 +0800
Message-ID: <a4844c99-77f4-470f-f351-a82155b5eca7@huawei.com>
Date:   Mon, 12 Dec 2022 10:08:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: supporting overlay+tmpfs breaks check -n -overlay -g auto
To:     Murphy Zhou <jencce.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>
References: <CADJHv_sJHyhgaJoAJCZY0VpO6u8vGHOzD3qBgv5EW3vYSNjfuA@mail.gmail.com>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CADJHv_sJHyhgaJoAJCZY0VpO6u8vGHOzD3qBgv5EW3vYSNjfuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

I tried to run the command on the latest version, and everything was fine.

Did I miss anything?

What is the version, environment, and config for reproducing the problem?


-- 
With Best Regards,
Baokun Li
.
