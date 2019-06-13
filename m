Received: from mail.cn.fujitsu.com ([183.91.158.132]:26681 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730892AbfFMI2b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jun 2019 04:28:31 -0400
Message-ID: <5D020926.4040608@cn.fujitsu.com>
Date: Thu, 13 Jun 2019 16:28:22 +0800
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: question about generic/473 on xfs filesystem
References: <5D00F3BC.5000003@cn.fujitsu.com> <20190612162149.GB1872778@magnolia>
In-Reply-To: <20190612162149.GB1872778@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

on 2019/06/13 0:21, Darrick J. Wong wrote:

> On Wed, Jun 12, 2019 at 08:44:44PM +0800, Yang Xu wrote:
>> Hi Eryu, Darrick
>>
>> Currently, on lastest kernel, generic/473 fails ,as below:
>> # ./check generic/473
>> FSTYP         -- xfs (non-debug)
>> PLATFORM      -- 5.2.0-rc4+
>> MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda11
>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda11 /mnt/xfstests/scratch
>> generic/473 2s ... - output mismatch (see /var/lib/xfstests/results//generic/473.out.bad)
>>      --- tests/generic/473.out   2019-06-12 19:30:37.219753498 +0800
>>      +++ /var/lib/xfstests/results//generic/473.out.bad  2019-06-12 20:34:12.499984113 +0800
>>      @@ -6,7 +6,7 @@
>>       1: [256..287]: hole
>>       Hole + Data
>>       0: [0..127]: hole
>>       -1: [128..255]: data
>>       +1: [128..135]: data
>>       Hole + Data + Hole
>>       0: [0..127]: hole
>>
>> I have seen previous mail[1]that mentioned "new ranged fiemap test (generic/473) fails on XFS, because there's no
>> final decision on the expected behavior yet and discussion has stalled somehow.". This case has been merged in 2017.12,
>> but this case also fails on lastest kernel, does it have any update or I miss something?
> Nope, you haven't missed anything.  The FIEMAP documentation says that
> filesystems /can/ report more data than the range requested, but XFS
> and ext4 still differ as to whether or not they will.
>
> --D
Hi Darrick

   Thanks. I got it.

>> more question:
>> xfs/107 and xfs/136 also fail on lastest kernel on my machine.
Hi Eryu, Darrick

These cases(xfs/107, xfs/136) are too old and they still fail on lastest kernel.
Can you give me more information about them?

xfs/107 fail information
+++ /var/lib/xfstests/results//xfs/107.out.bad      2019-06-13 14:33:03.345457763 +0800
     @@ -9,1542 +9,980 @@
      ### populate filesystem
      ### initial report
      [SCR_DEV] ([SCR_MNT]) Project:
     +   96168    #0
     +    4968    #3
     +    4344    #1
     +    3804    #2
     ...

xfs/136 fail information
   +++ /var/lib/xfstests/results//xfs/136.out.bad      2019-06-13 14:30:14.662466225 +0800
     @@ -1,5 +1,5 @@
      QA output created by 136
     -inum=67
     +inum=131
      core.format = 2 (extents)
      core.size = 0
      core.extsize = 0
     @@ -7,6 +7,7 @@
     ...

Thanks

>> [1]https://www.spinics.net/lists/fstests/msg08426.html
>>
>>
>>
>
>
