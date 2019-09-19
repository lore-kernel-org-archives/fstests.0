Received: from mail.cn.fujitsu.com ([183.91.158.132]:13565 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387987AbfISKtI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Sep 2019 06:49:08 -0400
Subject: Re: question of xfs/148 and xfs/149
References: <4BF2FD5A942B1C4B828DDAF5635768C1041AB0E2@G08CNEXMBPEKD02.g08.fujitsu.local>
 <20190917163933.GC736475@magnolia>
 <20190918025915.GK7239@dhcp-12-102.nay.redhat.com>
 <7b5d5797-afff-90bc-0131-38fd13eced34@cn.fujitsu.com>
 <20190918163711.GX2229799@magnolia>
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <638537d9-ce38-7285-c598-8637adbebd8f@cn.fujitsu.com>
Date: Thu, 19 Sep 2019 18:49:03 +0800
MIME-Version: 1.0
In-Reply-To: <20190918163711.GX2229799@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



on 2019/09/19 0:37, Darrick J. Wong wrote:
>>   I am finding the reasion. It seems wipefs wipes important information and
>> $DSIZE option(using single agcount or dsize, it also fails ) can not format
>> disk completely. If we use other options, it can pass.
> How does mkfs fail, specifically?
> 
> Also, what's your storage configuration?  And lsblk -D output?

I only guess it from result. Even though, mkfs.xfs $DSIZE 
successfully($? is 0), but UUID mismatch in 030.full, so it may
format the first superblock failed.  This is just my guess.

 From your detailed explanation, I understand why it fails.

Thanks
Yang Xu
