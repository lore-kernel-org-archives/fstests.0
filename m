Received: from mail-yw0-f170.google.com ([209.85.161.170]:36763 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754885AbdIGKKd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 06:10:33 -0400
MIME-Version: 1.0
In-Reply-To: <20170907085527.GS8034@eguan.usersys.redhat.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-11-git-send-email-amir73il@gmail.com> <20170907075019.GN8034@eguan.usersys.redhat.com>
 <CAOQ4uxgDMHacq1C0SSnV3t3djSWStu=sQ6zOJB7pqGow0cE3eQ@mail.gmail.com> <20170907085527.GS8034@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Sep 2017 13:10:31 +0300
Message-ID: <CAOQ4uxjrE-A1Hp-Hd_MMo5PjmZQte5usR=CMcf1MW90S06HOJg@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] fstests: crash consistency fsx test using dm-log-writes
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 7, 2017 at 11:55 AM, Eryu Guan <eguan@redhat.com> wrote:

>> >> +NUM_FILES=4
>> >> +NUM_OPS=200
>> >> +FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
>> >> +# Set random seeds for fsx runs (0 for timestamp + pid)
>> >> +seeds=(0 0 0 0)
>> >
>> > Hmm, is this array necessary? Why not pass 0 to -S directly in the
>> > commandline? And generic/502 follows the same pattern.
>> >
>>
>> The reason for the array is trying to follow your guidelines for running
>> the test:
>> - Normally test runs with random seed (for which the array is not needed)
>>   and every fsx process prints out the seed to the full log
>> - When test detects a failure, you want to retry the test with same seed
>>   numbers, but those are different seed numbers for every fsx process
>> - So the array is here to make setting those presets possible
>
> Yeah, an array makes debug easier. Then I think a comment about the
> debug usage of the array would be sufficient. Thanks!
>

FYI, I removed the array from generic/502, because it was never useful
during debugging. I guess the randomness stems mostly from timing
of forking the fsx processes in that test.

I reduced NUM_OPS in cloned files test to 10 in v4, because after a few
holes and writes the clone is no longer a clone anyway.
I already found a seed value to reproduce a failure of generic/502 on xfs
failures are still random, but on spinning disk, I get them every 2 test runs.

Amir.
