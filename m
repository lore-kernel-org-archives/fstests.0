Received: from mail.cn.fujitsu.com ([183.91.158.132]:24351 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727728AbfCOKFc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Mar 2019 06:05:32 -0400
Subject: Re: Why generic/089 fails for NFSv4
References: <385c37ee-c0b9-2c87-0132-891726033b6a@linux.alibaba.com>
 <76f96e48-18cb-8b3c-41ae-c4adf82ac3a4@linux.alibaba.com>
From: "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
Message-ID: <507aeaed-1cb2-23a9-138c-ebcde73efb9f@cn.fujitsu.com>
Date: Fri, 15 Mar 2019 18:05:28 +0800
MIME-Version: 1.0
In-Reply-To: <76f96e48-18cb-8b3c-41ae-c4adf82ac3a4@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Yihao Wu <wuyihao@linux.alibaba.com>, fstests@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, linux-nfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


On 2019/3/15 17:06, Yihao Wu wrote:
> On 2019/3/14 4:46 PM, Yihao Wu wrote:
>> Hi, all
>>
>> Sorry to bother you.
>>
>> lock_mtab in xfstests/src/t_mtab.c waits only for LOCK_TIMEOUT, which is 10.
>> After that it emits an error message. However when NFSv4 client fails to
>> lock a file in nfs4_retry_setlk (eg. locking conflict), it backs off for 30s
>> before retrying. So generic/089 frequently fails for NFSv4.
>>
>> I'm wondering if there's a workaround to this problem. My kernel version is
>> 4.19.24

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/nfs?h=v4.20&id=a61246c96195fc5f7500f6842e883b9eb1567d8d

Maybe this patch can help u.

Thanks

Su

>> Thanks,
>> Yihao Wu
>>
> cc nfs list
>
>
