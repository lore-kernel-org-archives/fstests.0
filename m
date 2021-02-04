Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DECC433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Feb 2021 08:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD8B64F4E
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Feb 2021 08:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhBDIAn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Feb 2021 03:00:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12073 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhBDIAm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Feb 2021 03:00:42 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWWBg5yrpzMVLc;
        Thu,  4 Feb 2021 15:58:19 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 15:59:52 +0800
Subject: Re: [xfstests PATCH v3] ext4: Add a test for rename with
 RENAME_WHITEOUT
To:     <fstests@vger.kernel.org>, <zlang@redhat.com>
References: <20210202123956.3146761-1-sunke32@huawei.com>
 <20210202160527.GB14354@localhost.localdomain>
CC:     <yangerkun@huawei.com>, <tytso@mit.edu>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <53ef6abe-d01c-8ecd-d20d-1b2fc172676e@huawei.com>
Date:   Thu, 4 Feb 2021 15:59:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202160527.GB14354@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi, Zorro

在 2021/2/3 0:05, Zorro Lang 写道:
> On Tue, Feb 02, 2021 at 08:39:56PM +0800, Sun Ke wrote:
>> Fill the disk space, try to create some files and rename a file, mount
>> again, list directory contents and triggers some errors. It is a
>> regression test for kernel commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for
>> rename with RENAME_WHITEOUT")
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> v3: use _check_dmesg_for() and modify the group.
>> ---
> I helped to re-write this case(without loopdev, dmesg check and ext4 specific
> things) as below[1]. It can reproduce that bug[2], and test passed on fixed
> kernel[3].
Thanks for your help. Yes, it can reproduce the bug on ext4 test.
>
> But I found another problem, we can't 100% make sure that renameat2 hit ENOSPC,
> even if we can't create any empty file. That renameat2 line still succeed on
> my XFS test. And Eric Sandeen even can't trigger that rename ENOSPC on his
> machine.

The same as  Eric,  I can not trigger that rename ENOSPC on my machine 
on xfs test.

Thanks,

Sun Ke


> .
