Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4B4C433DB
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Feb 2021 03:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588E161492
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Feb 2021 03:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBADTS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Jan 2021 22:19:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11223 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhBADTS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Jan 2021 22:19:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTY5N6FvGzlDWs;
        Mon,  1 Feb 2021 11:16:56 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 11:18:30 +0800
Subject: Re: [PATCH] src/swapon.c: initiate p to NULL
To:     <fstests@vger.kernel.org>
References: <20210128065010.218830-1-sunke32@huawei.com>
 <20210130045817.GV14354@localhost.localdomain>
CC:     <zlang@redhat.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <c2e8fb2b-8878-1d59-6321-1b4688f881db@huawei.com>
Date:   Mon, 1 Feb 2021 11:18:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210130045817.GV14354@localhost.localdomain>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

hi Zorro

ÔÚ 2021/1/30 12:58, Zorro Lang Ð´µÀ:
> On Thu, Jan 28, 2021 at 02:50:10PM +0800, Sun Ke wrote:
>> when run make, show:
>> swapon.c:135:3: warning: 'p' may be used uninitialized in this function
>> [-Wmaybe-uninitialized]
>>     memcpy(p, buf, BUF_SIZE);
>>        ^~~~~~~~~~~~~~~~~~~~~~~~
>> fix it.
> If you don't have a situation to prove this's a real bug, I guess the gcc might
> think the 'p' can be used uninitialized at here when verb is TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:
>
>          case TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:
>                  memcpy(p, buf, BUF_SIZE);
>                  break;
>
> But from the code logic, if verb is TEST_MWRITE_BEFORE_AND_MWRITE_AFTER, the 'p'
> will be initialized by:
>
>          switch (verb) {
>          case TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:
>          case TEST_MWRITE_BEFORE:
>                  p = mmap(NULL, BUF_SIZE, PROT_WRITE | PROT_READ, MAP_SHARED,
>
>
> So I think this's a fake uninitialized warning (Maybe I'm wrong. But if I'm right,
> better to specify that in commit log).

Yes, you are right.

Sorry, I did not analyse the code logic carefully.

>
> Anyway, I personally don't object to initialize a pointer to NULL at beginning,
> and make a build warning disappear. Leave the decision to maintainer :)
I will improve the commit.
>
> Thanks,
> Zorro
Thanks,
Sun Ke
>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   src/swapon.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/swapon.c b/src/swapon.c
>> index afaed405..fe8949a3 100644
>> --- a/src/swapon.c
>> +++ b/src/swapon.c
>> @@ -41,7 +41,7 @@ int main(int argc, char **argv)
>>   		.sa_handler	= handle_signal,
>>   	};
>>   	enum verbs verb = TEST_SWAPON;
>> -	void *p;
>> +	void *p = NULL;
>>   	ssize_t sz;
>>   	int fd = -1;
>>   	int ret, c;
>> -- 
>> 2.13.6
>>
> .
