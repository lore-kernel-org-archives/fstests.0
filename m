Received: from cn.fujitsu.com ([59.151.112.132]:50955 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751652AbcKQBNN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Nov 2016 20:13:13 -0500
Subject: Re: [PATCH] fstests: Block btrfs from test case generic/372
References: <20161115081332.6432-1-quwenruo@cn.fujitsu.com>
 <20161116211241.GC28177@dastard>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <7b38e56a-65e7-682f-de00-cd94acc6c860@cn.fujitsu.com>
Date: Thu, 17 Nov 2016 09:13:03 +0800
MIME-Version: 1.0
In-Reply-To: <20161116211241.GC28177@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 11/17/2016 05:12 AM, Dave Chinner wrote:
> (Did you forget to cc fstests@vger.kernel.org?)
>
> On Tue, Nov 15, 2016 at 04:13:32PM +0800, Qu Wenruo wrote:
>> Since btrfs always return the whole extent even part of it is shared
>> with other files, so the hole/extent counts differs for "file1" in this
>> test case.
>>
>> For example:
>>
>>  /------ File 1 Extent 0-------------\
>> /                                     \
>> |<----------Extent A------------------>|
>> \         /                  \         /
>>  \ File 2/                    \ File 2/
>>    Ext 0~4K                    Ext 64k~68K
>>
>> In that case, fiemap on File 1 will only return 1 large extent A with
>> SHARED flag.
>> While XFS will split it into 3 extents,  first and last 4K with SHARED
>> flag while the rest without SHARED flag.
>
> fiemap should behave the same across all filesystems if at all
> possible. This test failure indicates btrfs doesn't report an
> accurate representation of shared extents which, IMO, is a btrfs
> issue that needs fixing, not a test problem....
>
> Regardless of this....

Considering only btrfs implements CoW using extent booking mechanism(*),
it does affect a lot of behavior, from such SHARED flag representing to
hole punching behavior.

I hope there is a well documented standard on what ever flag means and
how it should be represented.

While I'm not quite sure if it's worthy for btrfs to modify the
represent.
Even btrfs can report it as "SHARED" "NON-SHARED" "SHARED" for File 1,
hole punching the "NON_SHARED" range won't free any space.
(Which I assume it differs from xfs, and that's making things confusing)

>
>> This makes the test case meaningless as btrfs doesn't follow such
>> assumption.
>> So black list btrfs for this test case to avoid false alert.
>
> ...  we are not going to add ad-hoc filesystem blacklists for
> random tests.
>
> Adding "blacklists" without any explanation of why something has
> been blacklisted is simply a bad practice. We use _require rules
> to specifically document what functionality is required for the
> test and check that it provided.  i.e. this:
>
> _require_explicit_shared_extents()
> {
> 	if [ $FSTYP == "btrfs" ]; then
> 		_not_run "btrfs can't report accurate shared extent ranges in fiemap"
> 	fi
> }

Right, this is much more helpful than the blabla I wrote in commit message.

Although I'd prefer to detect it at runtime other than just checking
the fs type.

Maybe one day btrfs will support it.
(Although we should solve the above mentioned behavior difference first)

>
> documents /exactly/ why this test is not run on btrfs.
>
> And, quite frankly, while this is /better/ it still ignores the
> fact we have functions like _within_tolerance for allowing a range
> of result values to be considered valid rather than just a fixed
> value. IOWs, changing the check of the extent count of file 1 post
> reflink to use a _within_tolerance range would mean the test would
> validate file1 on all reflink supporting filesystems and we don't
> need to exclude btrfs at all...

I really agree on this idea, although for me the difference is too big.

For file 1, xfs reports 5 extents, while btrfs only reports 1.
If using _within_tolerance to cover the range, and one day some
mysterious xfs bug(OK, I don't really believe it will happen, since
it's xfs, not btrfs) makes it report 4 extents.

Or one btrfs bug(on the other hand, quite possible) makes btrfs report
2 extents, then we can't detect the bug either.

So I'd prefer the _require_explicit_shared_extents() method.

Thanks,
Qu

>
> Cheers,
>
> Dave.
>


