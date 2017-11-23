Received: from mail-yw0-f179.google.com ([209.85.161.179]:44361 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdKWIuM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Nov 2017 03:50:12 -0500
Received: by mail-yw0-f179.google.com with SMTP id d2so8207015ywb.11
        for <fstests@vger.kernel.org>; Thu, 23 Nov 2017 00:50:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171123082812.GU2749@eguan.usersys.redhat.com>
References: <20171118061906.11227-1-eguan@redhat.com> <20171123070804.GT2749@eguan.usersys.redhat.com>
 <CAOQ4uxhoD=zgXJ9UC2+6+jCL6u+3_sxPanRb4xJ9M2SZSrPysQ@mail.gmail.com> <20171123082812.GU2749@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Nov 2017 10:50:10 +0200
Message-ID: <CAOQ4uxhm5mzteF3+CQwQ1Uw9D+5ms_LWvnpqbgr=-YRwm4Bm0w@mail.gmail.com>
Subject: Re: [PATCH] ltp/fsx: really skip fallocate keep_size calls when
 replaying ops
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 23, 2017 at 10:28 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Thu, Nov 23, 2017 at 10:05:00AM +0200, Amir Goldstein wrote:
>> On Thu, Nov 23, 2017 at 9:08 AM, Eryu Guan <eguan@redhat.com> wrote:
>> > On Sat, Nov 18, 2017 at 02:19:06PM +0800, Eryu Guan wrote:
>> >> On start up, fsx checks for various fallocate(2) operation support
>> >> status and disables unsupported operations. But when replaying
>> >> operations from a log, fsx failed to skip KEEP_SIZE fallocate(2)
>> >> calls if underlying filesystem doesn't support it. For example,
>> >> NFSv4.2 supports fallocate(2) but not KEEP_SIZE, and this causes
>> >> generic/469 fails on NFSv4.2.
>> >>
>> >> Fix it by taking 'keep_size_calls' into consideration when replaying
>> >> ops from log file.
>> >>
>> >> Signed-off-by: Eryu Guan <eguan@redhat.com>
>> >> ---
>> >>
>> >> Note that generic/469 hasn't been pushed to upstream yet. Will do in
>> >> this week's update.
>> >
>> > generic/469 is upstream now, still need some reviews on this patch.
>> >
>>
>> I don't like the path we have taken starting with generic/456 (so partly
>> my own blame) that the test passes instead of "not run" for fs that
>> don't support the replayed fsx operations, because fsx skips them.
>
> Firstly thanks a lot for the review!
>
> IMHO, there's no harm to run more tests even if that's not the
> primary/original test goal, as long as test doesn't fail due to the
> unsupported operations. I've seen quite a few bugs found by totally
> unexpected test cases, you'll never know when and where bug happens :)
>
>>
>> Because the sub-test in question really wants to test KEEP_SIZE,
>> IMO we should explicitly:
>
> generic/469 also tests the non-KEEP_SIZE path for better test coverage,
> though that won't reproduce the original bug. But I agreed that it can
> be a bit confusing to test on filesystems without KEEP_SIZE support.
>
> So how about I adding some comments to generic/456 and 469 to state that
> it's intentional, for better test coverage, to run tests on filesystems
> that don't support the replayed operations?

OK, but I still don't like the patch.

Here is what I think you should do:

Test for KEEP_SIZE support and conditionally set
keep_size=keep_size

Use $keep_size in fsxops generation.

Explain is comment why.

The reason I do not like the patch is because I don't like the fact
that:
fsx --replay-ops=ops.in  --record-ops=ops.out

Results in ops.out different than opts.in.
I know it is already the case for the "skipped" operations, but
at least that is well annotated, whereas your patch silently
drops the keep_size argument from ops script.

I would even go further and suggest a command line option
to fsx that will fail unsupported scripted ops instead of
skipping them, because one might imagine that was the intention
of the author of an ops script. IMO that should be the default
behavior of fsx --replay-ops.

Amir.
