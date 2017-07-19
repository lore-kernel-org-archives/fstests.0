Received: from cn.fujitsu.com ([59.151.112.132]:29176 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932177AbdGSKiK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jul 2017 06:38:10 -0400
Message-ID: <596F3689.7020304@cn.fujitsu.com>
Date: Wed, 19 Jul 2017 18:38:01 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/448: don't disable extent zeroing if extent_max_zeroout_kb
 isn't supported
References: <1500366470-10647-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170718131852.GX2478@eguan.usersys.redhat.com> <596EC555.7020404@cn.fujitsu.com> <20170719095634.GD2478@eguan.usersys.redhat.com>
In-Reply-To: <20170719095634.GD2478@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/07/19 17:56, Eryu Guan wrote:
> On Wed, Jul 19, 2017 at 10:35:01AM +0800, Xiao Yang wrote:
>> On 2017/07/18 21:18, Eryu Guan wrote:
>>> On Tue, Jul 18, 2017 at 04:27:50PM +0800, Xiao Yang wrote:
>>>> On some old kernel(e.g. v3.5), this case fails because it can not create
>>>> extent_max_zeroout_kb file, as below:
>>>>     Silence is golden
>>>>    +./tests/generic/448: line 54: /sys/fs/ext4/sda5/extent_max_zeroout_kb: No such file or directory
>>>>     seek sanity check failed!
>>>>
>>>> The extent_max_zeroout_kb file is introduced by:
>>>>     67a5da564f97('ext4: make the zero-out chunk size tunable')
>>> This is available since v3.7-rc1 kernel
>>> $ git describe --contains 67a5da564f97
>>> v3.7-rc1~91^2~63
>>>
>>> But ext4 SEEK_DATA/SEEK_HOLE support was added in v3.8-rc1
>>> $ git describe --contains c8c0df241cc2
>>> v3.8-rc1~89^2~40
>>>
>>> IMO, you shouldn't hit this error at all, because test won't pass
>>> _require_seek_data_hole rule. (Unless you're testing some customized
>>> kernel with seek_data/hole backported but not that ext4 sysfs entry.)
>> Hi Eryu
>>
>> Thanks for your explanation.
>>
>> I test it in v3.5 kernel without seek_data/hole backported, please see the
>> following message:
>> [root@localhost xfstests]# uname -r
>> 3.5.0
>> [root@localhost xfstests]# src/seek_sanity_test -t
>> /mnt/xfstests/test/testfile 2>&1
>> File system magic#: 0xef53
>> Allocation size: 4096
>> File system supports the default behavior.
> OK, I see why the test was *not* _notrun on 3.5 kernel now (without
> seek_data/hole support added to ext4, but with SEEK_DATA/SEEK_HOLE flags
> recognized by vfs, which was introduced by 982d81658 in v3.1-rc1),
> because ext4 had the "default behavior" support, and that means "just
> return i_size for SEEK_HOLE and will return the same offset for
> SEEK_DATA".
>
>> File system does not support unwritten extents.
> This means the file system doesn't treat unwritten extents as a hole,
> but data, which has nothing to do with SEEK_DATA/HOLE support status.
Hi Eryu,

Thanks for your detailed explanation, i got it.

Could you tell me whether generic/448 should be fixed or not?

Thanks,
Xiao Yang
>> _require_seek_data_hole could not catch "File system does not support" if
>> ext4 SEEK_DATA/SEEK_HOLE
>> support was not added.
>>
>> I think we should update  _require_seek_data_hole to catch both "Kernel does
>> not support" and
>> "File system does not support".   This case could be skipped when meetting
>> either of them.
> So this is wrong, IMO.
>
> Thanks,
> Eryu
>
>
> .
>



