Received: from mail-oi0-f52.google.com ([209.85.218.52]:35509 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932654AbdHVNrd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Aug 2017 09:47:33 -0400
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxiQfL1Apm1KhVvubupSZXYC7T07UeAigzn1Rxy-PSWEHw@mail.gmail.com>
References: <CAOQ4uxgSkzxqoH0T+WpKdsCLJw0439fEG+C7y+d1eEJ=obkGAQ@mail.gmail.com>
 <20170821164815.GA23225@destiny> <CAOQ4uxiQfL1Apm1KhVvubupSZXYC7T07UeAigzn1Rxy-PSWEHw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 22 Aug 2017 16:47:32 +0300
Message-ID: <CAOQ4uxhj9oBXczhvykzxvAHGFQ2vsTtkm+L1BQHGGvmb28R9Wg@mail.gmail.com>
Subject: Re: Crash Consistency xfstests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 21, 2017 at 9:49 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Mon, Aug 21, 2017 at 6:48 PM, Josef Bacik <josef@toxicpanda.com> wrote:
...
>>
>>> I noticed that if SCRATCH_DEV is a dm target itself (linear), then
>>> log-writes target creation fails. Is that by design? Can be fixed?
>>> If not, the test would have to require_scratch_not_dm_target or so.
>>>
>>> Please let me know if have any other tip or pointers for me.
>>
>> Huh that's weird, I was using it with dm-snapshot and it worked fine.  Maybe I
>> was doing something else and it's never worked, but it's definitely not by
>> design.  I'll look into this when I get some time.  Thanks,
>>
>
> Well, if it's not by design, I'll try to figure out the root cause of the error
> with my logical volume SCRATCH_DEV setup.
>

I could not reproduce the logical volume SCRATCH_DEV issue with upstream
kernel, so chalking it up to setup error or whatever.

BTW, is there a reason I am missing why you needed to compose FSX_OPTS
on the fly for the test using the new helper _test_falloc_support?
I see that fsx already detects if any of the falloc ops are not supported
via test_fallocate() and auto-disabled the unsupported ops.
I started fixing _test_falloc_support() which was a bit broken before I realized
it's not needed. Am I missing something?

I am still seeing test failures from time to time (checksum errors),
but they do not always reproduce on same system with same random seed
and when they reproduce its not always the same checksum that fails,
so I'm still gathering test results.

Thanks,
Amir.
