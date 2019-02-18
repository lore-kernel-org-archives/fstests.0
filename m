Received: from szxga05-in.huawei.com ([45.249.212.191]:3754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727486AbfBRBvU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 17 Feb 2019 20:51:20 -0500
Subject: Re: [PATCH] generic/299: limit max file size
References: <20190216120717.114983-1-yuyufen@huawei.com>
 <20190217222924.GC9805@dastard>
From: yuyufen <yuyufen@huawei.com>
Message-ID: <950b4532-1f5e-a894-7aaa-9799b7b8b77e@huawei.com>
Date: Mon, 18 Feb 2019 09:51:13 +0800
MIME-Version: 1.0
In-Reply-To: <20190217222924.GC9805@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 2019/2/18 6:29, Dave Chinner wrote:
> On Sat, Feb 16, 2019 at 08:07:17PM +0800, Yufen Yu wrote:
>> For some filesystem, such as vfat, the max support file size
>> is 4G. We limit the max size and let the test go on running.
> Can't this be probed?
>
> ext3/xfs/ext4/btrfs/etc:
>
> $ getconf FILESIZEBITS /
> 64
> $
>
> vfat:
>
> $ getconf FILESIZEBITS /mnt/scratch
> 32
> $
>
> Cheers,
>
> Dave.
Thanks a lot for your suggestion. I will send v2.
