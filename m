Received: from cn.fujitsu.com ([59.151.112.132]:53092 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750784AbcIWFBV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Sep 2016 01:01:21 -0400
Subject: Re: [PATCH v3] generic: check whether we can truncate heavily
 reflinked file
References: <57E38D6D.90007@cn.fujitsu.com>
 <20160923031207.30977-1-wangxg.fnst@cn.fujitsu.com>
 <20160923045803.GX27776@eguan.usersys.redhat.com>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <57E4B5DF.8040901@cn.fujitsu.com>
Date: Fri, 23 Sep 2016 12:55:59 +0800
MIME-Version: 1.0
In-Reply-To: <20160923045803.GX27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

On 09/23/2016 12:58 PM, Eryu Guan wrote:
> On Fri, Sep 23, 2016 at 11:12:07AM +0800, Wang Xiaoguang wrote:
>> In btrfs, there is a bug about btrfs' truncate codes, it'll leak
>> some fs space as the truncate operation proceeds. If this truncate
>> operation is very large, later metadata request in this truncate
>> operation may fail for enospc error. I also have sent a kernel
>> patch fot btrfs to fix this issue.
>>
>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>> ---
>> V3: Reduce test run time according to Eryu's suggestions.
> This version looks good to me. Just one more thing to confirm with you,
> did you verify that test passed with your btrfs patch applied?
Yes, with my fixing patch, this case will pass for btrfs.

Regards,
Xiaoguang Wang
>
> Thanks,
> Eryu
>
>



