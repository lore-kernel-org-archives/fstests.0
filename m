Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:54603 "EHLO
        mgwym03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdIAApP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Aug 2017 20:45:15 -0400
Subject: Re: [PATCH] btrfs/029: fix wrong usage of name filter
References: <2a13313b-d8f5-b6fd-58cb-72e05f5925c9@jp.fujitsu.com>
 <20170830110934.GF27835@eguan.usersys.redhat.com>
 <80ddf7d2-043c-6228-e1d8-e6a463668080@jp.fujitsu.com>
 <20170831073319.GI27835@eguan.usersys.redhat.com>
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Message-ID: <7ec7d078-9a33-91ca-ea68-652f58fb5d41@jp.fujitsu.com>
Date: Fri, 1 Sep 2017 09:44:59 +0900
MIME-Version: 1.0
In-Reply-To: <20170831073319.GI27835@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/08/31 16:33, Eryu Guan wrote:
> On Thu, Aug 31, 2017 at 08:53:09AM +0900, Misono, Tomohiro wrote:
>> On 2017/08/30 20:09, Eryu Guan wrote:
>>> On Wed, Aug 30, 2017 at 04:38:16PM +0900, Misono, Tomohiro wrote:
>>>> btrfs/029 uses _filter_testdirs() to filter the name of $TEST_DIR and
>>>> $SCRATCH_MNT directory.
>>>>
>>>> In this function, it calls both _filter_test_dir and _filter_scratch
>>>> concatenapted by pipe. Therefore if $TEST_DIR is a prefix of
>>>> $SCRATCH_MNT, this filter function gives wrong filtered name for
>>>> $SCRATCH_MNT and the test fails.
>>>
>>> Sorry, I'm a bit confused, how could $TEST_DIR be a prefix of
>>> $SCRATCH_MNT? Won't that fail the test at setup time?
>>
>> I used "/mnt" for $TEST_DIR and "/mnt_scratch" for $SCRATCH_MNT and hit
>> this problem because "/mnt_scratch" is filtered to "$TEST_DIR_scrach"
>> instead of "$SCRATCH_MNT".
>>
>> I think these are valid directory names and other btrfs tests run correctly
>> with these names.
> 
> Ah, yes, that's possible and a valid (though not usual) test setup. The
> filter becomes complex when one string is prefix of another string, we
> have similar problems when filtering TEST_DIR vs TEST_DEV and
> SCRATCH_MNT vs SCRATCH_DEV in _filter_test_dir and _filter_scratch.
> 
> But the fix only works around btrfs/029, but there're other places we
> use the two filters together, like in _filter_quota, TEST_DIR filter
> results would be wrong if SCRATCH_MNT is a prefix of TEST_DIR, because
> in _filter_quota it calls _filter_scratch first.
> 
> I think one solution is that we filter the longer string first, e.g.
> move _filter_testdirs to common/filter and update it to something like:
> 
> # filter both test and scratch mount points and devices, but always
> # filter the longer string if the other string is a substring of the
> # first one.
> _filter_testdirs()
> {
> 	if echo "$TEST_DIR" | grep -q "$SCRATCH_MNT"; then
> 		_filter_test_dir | _filter_scratch
> 	else
> 		_filter_scratch | _filter_test_dir
> 	fi
> }
> 
> And use this new helper when needed. I found 4 places that need update,
> they're btrfs/029, generic/409, generic/410, generic/411 and
> _filter_quota().
> 

Ok. I will do that if you won't, though I'm not sure other combination of 
filters would pose the similar problem.

Thanks,
Tomohiro

