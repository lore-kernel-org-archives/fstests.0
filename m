Received: from [183.91.158.132] ([183.91.158.132]:55916 "EHLO
        heian.cn.fujitsu.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751374AbdHGAz1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Aug 2017 20:55:27 -0400
Message-ID: <5987BA77.4090909@cn.fujitsu.com>
Date: Mon, 7 Aug 2017 08:55:19 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/424: add check for crc and finobt
References: <1501761914-16445-1-git-send-email-yangx.jy@cn.fujitsu.com> <829dce2e-162c-4ad7-98e9-1a8a9ecb102b@sandeen.net> <59842020.9070908@cn.fujitsu.com> <f6dd5a90-4179-d4df-cf33-5a62b7c1aa26@sandeen.net>
In-Reply-To: <f6dd5a90-4179-d4df-cf33-5a62b7c1aa26@sandeen.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/08/04 22:37, Eric Sandeen wrote:
> On 8/4/17 2:20 AM, Xiao Yang wrote:
>> Hi Eric,
>>
>> When finobt is disabled, xfs_db gets double crc errors on upstream xfsporgs-dev.
>> as below(e.g. block size is 4096):
>> ...
>> xfs_db -c "daddr 16" -c "type finobt" /dev/sda11
>> Metadata corruption detected at xfs_inobt block 0x10/0x1000
>> Metadata corruption detected at xfs_inobt block 0x10/0x1000
>>
>> Is this expected behavor?  Because xfs_db gets one crc error on v4.5 xfsprogs-dev.
>> as below(e.g. block size is 4096):
>> ...
>> xfs_db -c "daddr 16" -c "type finobt" /dev/sda11
>> Metadata CRC error detected at xfs_inobt block 0x10/0x200
> So, errors is expected because you finobt is disabled, and you are asking
> it to print a not-finobt block as a finobt.
>
> I think the double printing is because upstream the code actually sets
> the cursor twice after the commit which tried to fix the type-setting,
> it's on my list to fix.
Hi Eric,

Thanks for your detailed explanation, and i got it.
Could you help me review the v2 patch.  Thanks a lot!

Thanks,
Xiao Yang
> Thanks,
> -Eric
>
>> Thanks,
>> Xiao Yang.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>



