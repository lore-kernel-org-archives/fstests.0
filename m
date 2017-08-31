Received: from mail-yw0-f177.google.com ([209.85.161.177]:36066 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdHaE3J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Aug 2017 00:29:09 -0400
MIME-Version: 1.0
In-Reply-To: <20170831033818.GH27835@eguan.usersys.redhat.com>
References: <1504104706-11965-1-git-send-email-amir73il@gmail.com>
 <CAOQ4uxh8av5H87SHdFw92BDTvCtYgd9chS2Nfv5fA4=upoqRfA@mail.gmail.com>
 <20170830152326.vil3fhsrecp2ccql@destiny> <CAOQ4uxjE20+vY4OPWM3Z=FU-+4oC1KrYtJ5e7-rQDW4xx5t4RA@mail.gmail.com>
 <20170831033818.GH27835@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 31 Aug 2017 07:29:07 +0300
Message-ID: <CAOQ4uxhUsBMEeEbFA2PCBBZ1md+vSqQvdQ21RW6PuNoGNymBsA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Crash consistency xfstest using dm-log-writes
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Josef Bacik <jbacik@fb.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@lst.de>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Theodore Tso <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 31, 2017 at 6:38 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Wed, Aug 30, 2017 at 09:39:39PM +0300, Amir Goldstein wrote:
...
>> >> > For this posting, I kept the random seeds constant for the test.
>> >> > I set these constant seeds after running with random seed for a little
>> >> > while and getting failure reports. With the current values in the test
>> >> > I was able to reproduce at high probablity failures with xfs, ext4 and btrfs.
>> >> > The probablity of reproducing the failure is higher on a spinning disk.
>> >> >
>> >
>> > I'd rather we make it as evil as possible.  As long as we're printing out the
>> > seed that was used in the output then we can go in and manually change the test
>> > to use the same seed over and over again if we need to debug a problem.
>>
>> Yeh that's what I did, but then I found values that reproduce a problem,
>> so maybe its worth clinging on to these values now until the bugs are fixed in
>> upstream and then as regression tests.
>>
>> Anyway, I can keep these presets commented out, or run the test twice,
>> once with presets and once with random seed, whatever Eryu decides.
>
> My thought on this with first glance is using random seed, if a specific
> seed reproduce something, maybe another targeted regression test can be
> added, as what you did for that ext4 corruption?
>

Sure. Speaking of ext4 corruption, I did not re-post this test with this
series because its quite an ugly black box test. I figured if ext4 guys
would take a look and understand the problem they could write a more
intelligent test. OTOH maybe its better than nothing?

BTW, Josef, did/could you write a more intelligent test to catch the
extent crc bug that you fixed? if not, was it easy to reproduce with the
provided seed presets? and without them?
I am asking to understand if a regression test to that bug is in order
beyond random seed fsx.

BTW2, the xfs bug I found is reproduced with reasonable likelihood
with any random seed. By using the provided presets, I was able to
reduce the test run time and debug cycle considerably. I used
NUM_FILES=2; NUM_OPS=31 to reproduce at > 50% probability
within seconds. So this bug doesn't require a specialized regression test.

...
>
> The first 6 patches are all prepare work and seem fine, so I probably
> will push them out this week. But I may need more time to look into all
> these log-writes dm target and fsx changes.
>
> But seems that there're still problems not sorted out (e.g. this
> log-write bug), I'd prefer, when they get merged, removing the auto
> group for now until things settle down a bit.
>

Good idea. Anyway, I would be happy to see these tests used by N > 1
testers for start.
If some version is merged so people can start pointing this big gun to
their file systems, I imagine more interesting bug will come surface.

Amir.
