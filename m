Received: from cn.fujitsu.com ([59.151.112.132]:43299 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751126AbcGUHy6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 03:54:58 -0400
Subject: Re: [PATCH] btrfs: Update quick and auto tag for btrfs group
References: <20160721020607.28258-1-quwenruo@cn.fujitsu.com>
 <20160721074724.GC27776@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <e407f66e-5ff9-11de-cd27-58dbafcda80e@cn.fujitsu.com>
Date: Thu, 21 Jul 2016 15:54:19 +0800
MIME-Version: 1.0
In-Reply-To: <20160721074724.GC27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 07/21/2016 03:47 PM, Eryu Guan wrote:
> On Thu, Jul 21, 2016 at 10:06:07AM +0800, Qu Wenruo wrote:
>> Update the following quick/auto tag based on their execution time
>> 007
>> 011
>> 050
>> 100
>> 101
>>
>> Two systems are used to determine their execution time.
>> One is backed by an SATA spinning rust, whose maximum R/W speed is
>> about 100MB/s, modern desktop performance. (VM1)
>>
>> Another one is a VM inside a openstack pool, with stronger CPU and
>> memory performance along with high latency storage.
>> Maximum R/W speed is around 150MB/s, latency is much higher than normal
>> HDD though. (VM2)
>>
>> The 'quick' standard is a little more restrict, only when both systems
>> pass the test within 30s(+/- 10%), while 'auto' is less restrict, any
>> system can pass within 5min(+/- 10%) will still stay in 'auto' group.
>>
>> Other test cases don't fit both standards on both systems will not be
>> modified.
>>
>> Execution time result: (Unit: seconds)
>> ------------------------------------------------------
>> Test case No. | VM1        | VM2      | Modification |
>> ------------------------------------------------------
>> 007           | 4          | 2        | +quick       |
>> 011           | 669        | 1748     | -auto        |
>> 050           | 4          | 13       | +quick       |
>> 100           | 57         | 151      | -quick       |
>> 101           | 45         | 59       | -quick       |
>> ------------------------------------------------------
>
> Hmm, I'm a bit hesitated to take this. We usually try to make new tests
> run quick enough to fit auto/quick group, or reduce the run time of
> existing tests if they're taking too long time (e.g. 86c1b55 xfs/042:
> reduce runtime of the test).
>
> But we usually don't remove 'auto' group from a test just because of
> test time, so we don't lose test coverage, especially when the test is
> potent. (I think btrfs/011 is one of these potent tests, it finds
> hang/crash/failure from time to time. BTW, btrfs/011 took 210s on my
> test vm, which has 4vcpu and 8G memory.)
>
> I think the "<30s <5m" rule is more like a guidance, not a hard rule.
>
> But 007 and 050 clearly belong to 'quick' group.
>
> Thanks,
> Eryu

Right, 011 is really helpful, so I'm OK to keep the 'auto' tag.

I'll update the patch soon.

Thanks,
Qu


