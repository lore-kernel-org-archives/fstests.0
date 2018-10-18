Received: from szxga06-in.huawei.com ([45.249.212.32]:39816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbeJRLrz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Oct 2018 07:47:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 332014A1D8BA9
        for <fstests@vger.kernel.org>; Thu, 18 Oct 2018 11:49:00 +0800 (CST)
Subject: Re: [PATCH v2 3/4] overlay: add fsck.overlay stress test
References: <20181016074559.24728-1-yi.zhang@huawei.com>
 <20181016074559.24728-4-yi.zhang@huawei.com>
 <CAOQ4uxj_6CA1thOwwXOCtgZ3+oBW9g_sH=RY-Np5CmJkdH_+vA@mail.gmail.com>
From: "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <1d2c7919-64d6-5e2e-9908-5729d4e561df@huawei.com>
Date: Thu, 18 Oct 2018 11:48:52 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxj_6CA1thOwwXOCtgZ3+oBW9g_sH=RY-Np5CmJkdH_+vA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>
List-ID: <fstests@vger.kernel.org>

On 2018/10/16 18:07, Amir Goldstein Wrote:
> On Tue, Oct 16, 2018 at 10:32 AM zhangyi (F) <yi.zhang@huawei.com> wrote:
>>
>> Introduce a test case for fsck.overlay which runs on the underlying
>> directories created by fsstress (contain a lot of fs objects) to
>> find potential stability issue.
>>
> 
> Looks good.
> Did it help you find any stability issues?
> 

Not yet, it looks fine everytime I run this test, maybe could help to
find in the future. :)

Thanks,
Yi.
