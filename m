Received: from mout.gmx.net ([212.227.15.19]:38775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0MWN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 08:22:13 -0400
Subject: Re: [PATCH 2/2] btrfs: Add test for btrfs balance convert
 functionality
References: <20190927105233.14926-1-nborisov@suse.com>
 <20190927105233.14926-2-nborisov@suse.com>
 <471ec614-1f19-445e-bb4f-cfceca68f93f@gmx.com>
 <178f1a6a-6c91-de5b-d1eb-a05050c1d5bf@suse.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <da92f869-47ab-4135-dd62-1f16fd6f27af@gmx.com>
Date: Fri, 27 Sep 2019 20:22:00 +0800
MIME-Version: 1.0
In-Reply-To: <178f1a6a-6c91-de5b-d1eb-a05050c1d5bf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 2019/9/27 =E4=B8=8B=E5=8D=887:50, Nikolay Borisov wrote:
>
>
> On 27.09.19 =D0=B3. 14:21 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/9/27 =E4=B8=8B=E5=8D=886:52, Nikolay Borisov wrote:
>>> This does an exhaustive testing of all possible conversion combination=
.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>
>>> This is a rather long test - it takes around 38 minutes, OTOH it exerc=
ies around
>>> 1780 combinations of source/destination test.
>>
>> Exactly the problem I'm concerning.
>>
>> However we all know that btrfs convert works by relocating old data to
>> new chunks.
>> It means the source doesn't matter that much.
>>
>> As long as the chunk read code works fine, converting from single to
>> RAID10 is not that different from converting from DUP to RAID10.
>> (ALthough there is still some difference due to different nr_disks and
>> dev extent layouts, but that's not the core problem)
>>
>> By that we can change from testing all the combinations to just testing
>> all destination profiles.
>>
>> This should only needs about 6 tests, and you can reuse all the same
>> setup to fulfill all tests.
>
> True, but thanks to the exhaustive tests I was able to catch xfstest
> special casing -mdup as source argument which resulted in patch 1 of
> this series. I will leave that here to gather some more feedback and
> will trim down the tests.
>
> And regarding the number of tests - do we want to mix the source
> profiles of data/metadata.

To me, unless we have some strong evident in how different data/metadata
profiles can cause different behavior, then using the same profile
should be OK.

> Because it's true that it takes 6 test to
> convert from
>
> SINGLE=3D>DUP, RAID1, RAID5, RAID0, RAID10, RAID6
> but we also need a 7th test e.g. DUP->SINGLE.

Ah, I forgot RAID6. Then it's indeed 7 tests.

BTW, with 7 tests, we can afford more extensive tests, like 15~30s
fsstress at the background, and after balance run a full scrub, then
umount and fsck.

Thanks,
Qu

>
>>
>> Just 4 devices, then you can go convert to SINGLE, DUP, RAID1, RAID5,
>> RAID6, RAID10.
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>>  tests/btrfs/194     | 1843 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>  tests/btrfs/194.out |    2 +
>>>  tests/btrfs/group   |    1 +
>>>  3 files changed, 1846 insertions(+)
>>>  create mode 100755 tests/btrfs/194
>>>  create mode 100644 tests/btrfs/194.out
>>>
>>> diff --git a/tests/btrfs/194 b/tests/btrfs/194
>>> new file mode 100755
>>> index 000000000000..7ba4555c12b0
>>> --- /dev/null
>>> +++ b/tests/btrfs/194
>>> @@ -0,0 +1,1843 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>>> +#
>>> +# FS QA Test 194
>>> +#
>>> +# Exercises all available combinations of btrfs balance start -d/-m c=
onvert
>>> +#
[...]
>>> +
>>> +for i in "${TEST_VECTORS[@]}"; do
>>> +	run_testcase $i
>>> +done
>>> +
>>> +echo "Silence is golden"
>>> +status=3D0
>>> +exit
>>> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
>>> new file mode 100644
>>> index 000000000000..7bfd50ffb5a4
>>> --- /dev/null
>>> +++ b/tests/btrfs/194.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 194
>>> +Silence is golden
>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>>> index b92cb12ca66f..a2c0ad87d0f6 100644
>>> --- a/tests/btrfs/group
>>> +++ b/tests/btrfs/group
>>> @@ -196,3 +196,4 @@
>>>  191 auto quick send dedupe
>>>  192 auto replay snapshot stress
>>>  193 auto quick qgroup enospc limit
>>> +194 auto volume balance
>>>
>>
