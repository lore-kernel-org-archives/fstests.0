Received: from mail-vk0-f48.google.com ([209.85.213.48]:32953 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbcCNXX6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 14 Mar 2016 19:23:58 -0400
Received: by mail-vk0-f48.google.com with SMTP id k1so463863vkb.0
        for <fstests@vger.kernel.org>; Mon, 14 Mar 2016 16:23:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160314222433.GC11812@dastard>
References: <1457525199-15355-1-git-send-email-agruenba@redhat.com>
	<20160314222433.GC11812@dastard>
Date: Tue, 15 Mar 2016 00:23:57 +0100
Message-ID: <CAHc6FU4MqOqfzEeig-73An-9tQEgZE2BtWpjrs6ZPWB26x9AxQ@mail.gmail.com>
Subject: Re: [XFSTESTS v4 0/4] Richacl tests
From: Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: XFS Developers <xfs@oss.sgi.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 14, 2016 at 11:24 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Mar 09, 2016 at 01:06:34PM +0100, Andreas Gruenbacher wrote:
>> Hello,
>>
>> here is a new version of the richacl tests.
>
> xfstests patches need to be sent to fstests@vger.kernel.org (added
> to CC list), not xfs@oss.sgi.com.

Sorry for that.

>> According to feedback from the
>> previous posting (http://oss.sgi.com/archives/xfs/2015-12/msg00316.html), each
>> of the richacl tests is not run separately, on a new scratch filesystem.
>
> Oh, my. So, you've taken this one comment:
>
>         "The rule of thumb is that there should be one xfs test per
>         individual regression test. You've got at least 10 separate
>         regression tests there, so there should be at least 10
>         xfstests.  They should not be aggregated into a single test
>         - if you need to run them all at once, then that is what the
>         richacl test group is for..."
>
> And then *implemented your own execution infrastructure* so that the
> tests are /listed/ as separate tests in a group file but you still
> /run them/ as one test?
>
> I'm almost lost for words.

What? Each test runs separately; not sure what makes you think otherwise.

> It seems to me that you've ignored all the comments Eric and I have
> made to you about properly integrating the tests into xfstests so
> that they are able to be maintained by anyone who works with
> xfstests. Instead, you've kept most of the wacky stuff and instead
> made the richacl tests even more of a special snowflake than they
> were before.
>
> This is not rocket science, Andreas. Both Eric and I have spelt out
> exactly how to convert the richacl test scripts to use xfstests
> scripts and infrastructure (e.g.
> http://oss.sgi.com/archives/xfs/2015-11/msg00506.html), but you seem
> to be willfully ignoring the feedback you are being given. i.e.
>
>         - the separation of tests between richacl/<test> and
>           tests/<fs>/<test number> is wrong. Implement the
>           tests directly inside tests/<fs>/<test number>, using
>           xfstests infrastructure, please.
>
>         - still not using .out files and instead are using your own
>           internal frankenstein output matching to determine success
>           or failure. Use the xfstests infrastructure for golden
>           output matching, please.
>
>         - now has weird-ass richacl test execution from generic/338
>           and execute the tests correctly from the test harness
>           itself. Again, use the xfstests infrastructure correctly
>           rather than reinventing your own, please.
>
> Most of this is as simple as copying the execution parts of your
> scripts to the xfstests test scripts, and the output parts of the
> test scripts into the test.out file. There's no new infrastructure
> needed for running tests, no separate richacl/ script directory,
> etc.

I've said again and again that maintaining one set of richacl tests in
xfstests and another in the richacl package is going to really
painful, and that because of that, I'm trying to find a way of using
the same test scripts in both places. That message obviously didn't
get through at all though. That is just sad.

Andreas
