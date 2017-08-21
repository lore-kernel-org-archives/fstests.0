Received: from mail-oi0-f46.google.com ([209.85.218.46]:36213 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753774AbdHUStN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Aug 2017 14:49:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170821164815.GA23225@destiny>
References: <CAOQ4uxgSkzxqoH0T+WpKdsCLJw0439fEG+C7y+d1eEJ=obkGAQ@mail.gmail.com>
 <20170821164815.GA23225@destiny>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 21 Aug 2017 20:49:12 +0200
Message-ID: <CAOQ4uxiQfL1Apm1KhVvubupSZXYC7T07UeAigzn1Rxy-PSWEHw@mail.gmail.com>
Subject: Re: Crash Consistency xfstests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 21, 2017 at 6:48 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> On Mon, Aug 21, 2017 at 05:35:02PM +0200, Amir Goldstein wrote:
...
>> Joseph,
>>
>> FYI, while testing your patches I found that on my system (Ubuntu 16.04)
>> fsx was always generating the same pseudo random sequence, even
>> though the printed seed was different.
>>
>> Replacing initstate()/setstate() with srandom() in fsx fixed the problem for me.
>> When I further mixed pid into the randomized seed, thus, generating
>> different sequence of events in the 4 parallel fsx invocations, I
>> started getting
>> checksum failures on replay. I will continue to investigate this phenomena.
>>
>> BTW, I am not sure if it is best to use a randomized or constant random seed
>> for an xfstest. What is the common practice if any?
>>
>
> Oops I thought fsx was generating different sequence each time.  My preference
> is that we be as random as possible and we just print out the seed at the start
> so that if we hit a problem we can go back and reproduce with the same seed for
> debugging.  Fsstress prints out the seed it's using, we should do the same for
> fsx.
>

fsx does print the seed it is using, but there was a bug (at least on my system)
where that seed had no effect on resulting random sequence.
Also, compared to fsstress, fsx was initializing seed with current seconds
and fsstress is initializing seed with seconds ^ nanoseconds + procid.

...
>
>> I noticed that if SCRATCH_DEV is a dm target itself (linear), then
>> log-writes target creation fails. Is that by design? Can be fixed?
>> If not, the test would have to require_scratch_not_dm_target or so.
>>
>> Please let me know if have any other tip or pointers for me.
>
> Huh that's weird, I was using it with dm-snapshot and it worked fine.  Maybe I
> was doing something else and it's never worked, but it's definitely not by
> design.  I'll look into this when I get some time.  Thanks,
>

Well, if it's not by design, I'll try to figure out the root cause of the error
with my logical volume SCRATCH_DEV setup.

Thanks,
Amir.
