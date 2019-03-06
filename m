Received: from szxga06-in.huawei.com ([45.249.212.32]:45212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727480AbfCFC3M (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 5 Mar 2019 21:29:12 -0500
Subject: Re: [PATCH v2] generic: test i_mode recovery after power failure
References: <20190305114744.129633-1-yuchao0@huawei.com>
 <20190305205344.GC26298@dastard>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com>
Date: Wed, 6 Mar 2019 10:29:10 +0800
MIME-Version: 1.0
In-Reply-To: <20190305205344.GC26298@dastard>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, linux-f2fs-devel@lists.sourceforge.net, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On 2019/3/6 4:53, Dave Chinner wrote:
> On Tue, Mar 05, 2019 at 07:47:44PM +0800, Chao Yu wrote:
>> After fsync, filesystem should guarantee inode metadata including
>> permission info being persisted, so even after sudden power-cut,
>> during mount, we should recover i_mode fields correctly, in order
>> to not loss those meta info.
>>
>> So adding this testcase to check whether generic filesystem can
>> guarantee that.
> 
> Can I make a suggestion here?
> 
> I've noticed that we are getting a lot of these one-off, random
> "fsync persists one specific piece of metadata in one specific case"
> tests, mainly in response to some fsync bug that was found in btrfs.
> This is reactive, and does not find new bugs in this area.
> 
> We are also beyond the point where the number of tests is
> maintainable (e.g. to be able to make infrastructure changes), so we
> really should be looking to consolidate largely similar tests into
> single tests where possible.
> 
> I'd strongly suggest that a robust fsync tester should be written
> for all the cases that are currently being addressed in an ad hoc
> fashion. Then they can be consolidated into a single test run, and
> we can get rid of all the one-off "fsync failed on this <specific
> thing>" tests from the harness.

Thanks for the suggestion, and that makes sense.

> 
> Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> and generic/311.
> 
> Can we please consider rolling all of these "do something, fsync,
> drop-writes, remount check" into fsync-tester.c and do the same for
> all future one-off "did fsync persist X" tests?

Let me add this testcase into fsync-tester.c, still we need add new
testcase in generic/ directory instead of changing generic/311 directly,
right? since as I remember that Eryu mentioned that:

"Usually we don't add new sub-tests to existing tests, so new failures
introduced by the new sub-tests won't be treated as false regressions.
Please add a new test instead."

https://patchwork.kernel.org/patch/10042149/

Or to avoid redundant copied code from generic/311 in each fsync related
patch, do I need just add my case into fsync_tester.c? and before
announcement of fstests master branch, we can add one testcase into
generic/ directory, in that testcase we gather/test all new added cases in
fsync_tester.c recently.

Which one is easier for you to maintain?

Thanks,

> 
> Cheers,
> 
> Dave.
> 
