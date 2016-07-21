Received: from cn.fujitsu.com ([59.151.112.132]:2030 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751518AbcGUCFg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2016 22:05:36 -0400
Subject: Re: [PATCH] fstests: btrfs: Test send on heavily deduped file
References: <20160719024402.19324-1-quwenruo@cn.fujitsu.com>
 <20160719043524.GL27776@eguan.usersys.redhat.com>
 <fb7acb1e-3835-1511-d66e-7d186c94e35e@cn.fujitsu.com>
 <20160720070100.GU27776@eguan.usersys.redhat.com>
 <01fb32c1-4662-ba9e-6bab-5b01790bd1d3@cn.fujitsu.com>
 <20160720233742.GZ12670@dastard>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <409140dc-6c77-7e20-33ff-c533d0054bf6@cn.fujitsu.com>
Date: Thu, 21 Jul 2016 10:05:25 +0800
MIME-Version: 1.0
In-Reply-To: <20160720233742.GZ12670@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 07/21/2016 07:37 AM, Dave Chinner wrote:
> On Wed, Jul 20, 2016 at 03:40:29PM +0800, Qu Wenruo wrote:
>> At 07/20/2016 03:01 PM, Eryu Guan wrote:
>>> On Tue, Jul 19, 2016 at 01:42:03PM +0800, Qu Wenruo wrote:
>>>>>
>>>>> This test uses $LOAD_FACTOR, so it should be in 'stress' group. And it
>>>>> hangs the latest kernel, stop other tests from running, I think we can
>>>>> add it to 'dangerous' group as well.
>>>>>
>>>>
>>>> Thanks for this info.
>>>> I'm completely OK to add this group to 'stress' and 'dangerous'.
>>>>
>>>>
>>>> However I'm a little curious about the meaning/standard of these groups.
>>>>
>>>> Does 'dangerous' conflicts with 'auto'?
>>>> Since under most case, tester would just execute './check -g auto' and the
>>>> system hangs at the test case.
>>>> So I'm a little confused with the 'auto' group.
>>>
>>> I quote my previous email here to explain the 'auto' group
>>> http://www.spinics.net/lists/fstests/msg03262.html
>>>
>>> "
>>> I searched for Dave's explainations on 'auto' group in his reviews, and
>>> got the following definitions:
>>>
>>> - it should be a valid & reliable test (it's finished and have
>>>  deterministic output) [1]
>>> - it passes on current upstream kernels, if it fails, it's likely to be
>>>  resolved in forseeable future [2]
>>> - it should take no longer than 5 minutes to finish [3]
>>> "
>>>
>>> And "The only difference between quick and auto group criteria is the
>>> test runtime." Usually 'quick' tests finish within 30s.
>>>
>>> For the 'dangerous' group, it was added in commit 3f28d55c3954 ("add
>>> freeze and dangerous groups"), and seems that it didn't have a very
>>> clear definition[*]. But I think any test that could hang/crash recent
>>> kernels is considered as dangerous.
>>>
>>> * http://oss.sgi.com/archives/xfs/2012-03/msg00073.html
>>
>> Thanks for all the info, really helps a lot.
>>
>> Especially for quick and auto difference.
>>
>> Would you mind me applying this standard to current btrfs test cases?
>
> It shoul dbe applied to all test cases, regardless of the filesystem
> type.

It's straightforward for specific fs test cases.

But for generic, I'm a little concerned of the quick/auto standard.
Should we use result of one single fs(and which fs? I assume xfs though) 
or all fs, to determine quick/auto group?

For example, generic/127 involves quite a lot metadata operation, while 
for some fs (OK, btrfs again) metadata operation is quite slow compared 
to other stable fs like ext4 or xfs.

So it makes quick/auto tag quite hard to determine.

Thanks,
Qu

>
>> BTW, does the standard apply to *ALL* possible mount options or just
>> *deafult* mount option?
>
> Generally it applies to the default case.
>
>> For example, btrfs/011 can finish in about 5min with default mount
>> option, but for 'nodatasum' it can take up to 2 hours.
>> So should it belong to 'auto'?
>
> Yes. Also, keep in mind that runtime is dependent on the type of
> storage you are testing on. The general idea is that the
> "< 30s quick, < 5m auto" rule is based on how long the test takes to
> run on a local single spindle SATA drive, as that is the basic
> hardware we'd expect people to be testing against. This means that a
> test that takes 20s on your SSD might not be a "quick" test because
> it takes 5 minutes on spinning rust....
>
> Cheers,
>
> Dave.
>


