Received: from cn.fujitsu.com ([59.151.112.132]:64660 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751644AbcKJAeb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Nov 2016 19:34:31 -0500
Subject: Re: [PATCH] fstests: btrfs: Check false ENOSPC bug caused by
 incorrect metadata reserve
References: <20161108091515.20867-1-quwenruo@cn.fujitsu.com>
 <20161108105826.GN27776@eguan.usersys.redhat.com>
 <d9a9d224-2f21-5b77-a3e9-de271cd4e755@cn.fujitsu.com>
 <20161109094341.GY27776@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <6ae5fc6d-afbb-c284-190e-a0d2625cff25@cn.fujitsu.com>
Date: Thu, 10 Nov 2016 08:34:20 +0800
MIME-Version: 1.0
In-Reply-To: <20161109094341.GY27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 11/09/2016 05:43 PM, Eryu Guan wrote:
> On Wed, Nov 09, 2016 at 08:24:38AM +0800, Qu Wenruo wrote:
>>
>>
>> At 11/08/2016 06:58 PM, Eryu Guan wrote:
>>> On Tue, Nov 08, 2016 at 05:15:15PM +0800, Qu Wenruo wrote:
>>>> Due to the fact that btrfs uses different max extent size for
>>>> compressed and non-compressed write, it calculates metadata reservation
>>>> incorrectly.
>>>>
>>>> This can leads to false ENOSPC alert for compressed write.
>>>>
>>>> This test case will check it by using small fs and large nodesize, and
>>>> do parallel compressed write to trigger it.
>>>>
>>>> The fix is not merged and may change in the future, but the function is
>>>> good enough:
>>>> btrfs: improve inode's outstanding_extents computation
>>>> btrfs: fix false enospc for compression
>>>>
>>>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>>>> ---
> [snip]
>>>> +
>>>> +# Use small filesystem with maximum nodesize.
>>>> +# Since the false ENOSPC happens due to incorrect metadata reservation,
>>>> +# larger nodesize and small fs will make it much easier to reproduce
>>>> +_scratch_mkfs -b 512M -n 64k >> $seqres.full 2>&1
>>>
>>> How about override MKFS_OPTIONS and call _scratch_mkfs_sized? e.g.
>>>
>>> export MKFS_OPTIONS="-n 64k"
>>> _scratch_mkfs_sized $((512 * 1024 * 1024))
>>
>> Overriding MKFS_OPTIONS makes us unable to parse more mkfs options, for
>> example to test some incompatible features.
>>
>> So I'd just parse this mkfs options as extra options.
>
> We should use helpers and not open-code when helpers are available. So
> we should really use _scratch_mkfs_sized here.
>
> And "-n 64k" is only to make bug easier to reproduce, but I don't think
> it's necessary. In my testings, 50%-75% runs hit the ENOSPC failure on
> my x86_64 test vm, even I removed the "-n 64k" mkfs option from the
> test.
>
> So I'd say remove "-n 64k" and test whatever mkfs options user
> specified.

I really don't like the idea to allow user to override any mount option 
to reduce the possibility.

If using 4K nodesize, the possibility to trigger the bug will be quite 
low. (default is 16K, so you still have chance to reproduce the bug)

And further more, this testcase is not a generic test, but a 
regression/pinpoint test to expose one specific bug.

So I'll put anything to improve the possibility and won't allow user 
options to override it.


>
>>>
>>>> +_scratch_mount "-o compress"
>
> And compress mount option is not necessary to me either. btrfs compress
> is a commonly tested configuration, there's no need to force the
> compress option in the test. So we can test other configurations too.

As stated above, this is a regression test, not a generic test.

So I still need the "-o compress" mount option.
We shouldn't dependent on user to specify any special mount option, 
since tester/user are never reliable.

Further more, there are already lots of test cases specifying their own 
mount option.
So I don't see there is anything wrong using specified mount option.

Thanks,
Qu
>
> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


