Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33112 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728684AbfCOJHG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Mar 2019 05:07:06 -0400
Subject: Re: Why generic/089 fails for NFSv4
From: Yihao Wu <wuyihao@linux.alibaba.com>
References: <385c37ee-c0b9-2c87-0132-891726033b6a@linux.alibaba.com>
Message-ID: <76f96e48-18cb-8b3c-41ae-c4adf82ac3a4@linux.alibaba.com>
Date: Fri, 15 Mar 2019 17:06:50 +0800
MIME-Version: 1.0
In-Reply-To: <385c37ee-c0b9-2c87-0132-891726033b6a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, linux-nfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2019/3/14 4:46 PM, Yihao Wu wrote:
> Hi, all
> 
> Sorry to bother you.
> 
> lock_mtab in xfstests/src/t_mtab.c waits only for LOCK_TIMEOUT, which is 10.
> After that it emits an error message. However when NFSv4 client fails to
> lock a file in nfs4_retry_setlk (eg. locking conflict), it backs off for 30s
> before retrying. So generic/089 frequently fails for NFSv4.
> 
> I'm wondering if there's a workaround to this problem. My kernel version is
> 4.19.24
> 
> Thanks,
> Yihao Wu
> 

cc nfs list
