Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBA6C27C40
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Aug 2023 18:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbjHXSX6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Aug 2023 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242966AbjHXSX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Aug 2023 14:23:26 -0400
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 11:23:23 PDT
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDA331BEC
        for <fstests@vger.kernel.org>; Thu, 24 Aug 2023 11:23:23 -0700 (PDT)
Received: from [10.0.0.71] (liberator.sandeen.net [10.0.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 8F1195CC13E;
        Thu, 24 Aug 2023 13:16:25 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 8F1195CC13E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
        s=default; t=1692900985;
        bh=HZjW0mfC1vIt9TpRa52jmXUL0r+kauPuotYJ6Br+iDI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DIZVFL5Q10na2R5UD8+QutMsCEgF+RX+Qgv1h6MzpsBTMU75y1JGIef0eIKD5r8TZ
         mfzPwn+I/h72eS5e7YysW13BQG7X4nJM7T23Mqpu/zBmRD+/O1eOIGVcnufr5iRkY5
         q5Z0Ys9sgKpLJWvd2PjYslWeCszE4u9B8XRlU9//jwYa6sa5IQPa2oyj92hr86WkdB
         Uxvr0mcZMCLaX2gbM4JniMkfspixlyHXH949YvtNuysHkxb72HcBpe5tplCyLBN6nL
         bI+C1f+VQSvgpWJ9Es4z3t2ZonvYaIKnOeRoUmQw9wTAieQQlHZ9Yw5TnEBHKWcdMO
         hxxrK0OKaabog==
Message-ID: <301c9a5a-562e-d1ca-2ab0-b1cf72fd4721@sandeen.net>
Date:   Thu, 24 Aug 2023 13:16:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] fstests: generic/352 should accomodate other pwrite
 behaviors
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Bill O'Donnell <bodonnel@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20230823154350.18829-1-bodonnel@redhat.com>
 <20230823164641.GA11251@frogsfrogsfrogs> <ZOaFmhnUAM9gjNFv@redhat.com>
 <20230823222754.GB11251@frogsfrogsfrogs>
 <9e0d9bcd-0820-4dd0-a43f-519a9b54c656@gmx.com>
From:   Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <9e0d9bcd-0820-4dd0-a43f-519a9b54c656@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 8/23/23 7:03 PM, Qu Wenruo wrote:
> 
> 
> On 2023/8/24 06:27, Darrick J. Wong wrote:
>> On Wed, Aug 23, 2023 at 05:18:02PM -0500, Bill O'Donnell wrote:
>>> On Wed, Aug 23, 2023 at 09:46:41AM -0700, Darrick J. Wong wrote:
>>>> On Wed, Aug 23, 2023 at 10:43:50AM -0500, Bill O'Donnell wrote:
>>>>> xfs_io pwrite issues a series of block size writes, but there is no
>>>>> guarantee
>>>>> that the resulting extent(s) will be singular or contiguous.
> 
> However this doesn't make much difference, at least for btrfs.
> 
> Btrfs would do the merging emitting the fiemap entry, thus even if the
> write didn't result a singular extent, as long as they are contiguous
> (under most cases they are) the fiemap result would still be a single one.

btrfs may merge physically adjacent extents in fiemap output, but if the
write happened to create physically discontiguous extents for the
logical range for the single pwrite, I think you would run into the same
problem as Bill has described (golden output expects a single extent
from fiemap), yes?

"under most cases" is the problem here, and results in a flakey test. :)

>>>>> This behavior is
>>>>> acceptable, but the test is flawed in that it expects a single
>>>>> extent for a
>>>>> pwrite.
> 
> I'm more interested in if you're hitting any test failure?

As Bill noted, yes - under some circumstances the pwrite on XFS creates
physically discontiguous extents for the range.  (Why it does so is also
an interesting question, for later...)

<snip>

>> Qu: Question for you:
> 
> Thanks a lot for referring it to me.
> 
>>
>>>> I don't know why $blocksize is set to 128k above.  If this test
>>>> needs to
>>>> guarantee that there would only be *one* extent (and the golden output
>>>> implies this as you note), then it should have been written to say:
>>>>
>>>>     blocksize=$(_get_file_block_size $SCRATCH_MNT)
>>>>
>>>> But I don't know if the "btrfs soft lock up and return wrong shared
>>>> flag" behavior required sharing a (probably multi-block) 128k range, or
>>>> if that was simply what the author selected because it reproduced the
>>>> problem.
> 
> It's quite sometime ago, thus my memory may not be reliable, but IIRC
> the blocksize has no specific requirement other than allowing all
> possible blocksize (4K to 64K).
> 
> And at that time, at least I was preferring to use golden output to
> detect errors, thus I choose a larger blocksize to allow all blocksizes
> to work.

Ok, if it was simply "accomodate maximum blocksize" then I like
Darrick's suggestion to simply get the actual filesystem block size, and
use that.

>>
>> Any thoughts?
>>
>> --D
>>
>>>>
>>>>>
>>>>>   # success, all done
>>>>>   status=0
>>>>> diff --git a/tests/generic/352.out b/tests/generic/352.out
>>>>> index 4ff66c21..ad90ae0d 100644
>>>>> --- a/tests/generic/352.out
>>>>> +++ b/tests/generic/352.out
>>>>> @@ -1,5 +1,3 @@
>>>>>   QA output created by 352
>>>>>   wrote 131072/131072 bytes at offset 0
>>>>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>> -0: [0..2097151]: shared
>>>>> -1: [2097152..2097407]: shared|last
>>>>
>>>> Also I suspect from the test description that the goal here was to
>>>> detect the golden output failing because the shared flag does not get
>>>> reported correctly.
> 
> Could explain more on why the shared flag detection is not correct here?
> 
> If a file extent is shared, no matter if it's shared by another inode or
> not, shouldn't it be marked with SHARED flag?

I think that what Darrick meant was that Bill's patch removed "shared"
from the golden output, and if the entire point of the test was to
detect proper sharing:

# This test case will check if reserved extent map searching go
# without problem and return correct SHARED flag.
# Which btrfs will soft lock up and return wrong shared flag.

then it was no longer testing as originally designed.

-Eric

> Thanks,
> Qu

