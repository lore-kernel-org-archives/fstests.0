Received: from mail-yw0-f194.google.com ([209.85.161.194]:45760 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbeBFIvo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Feb 2018 03:51:44 -0500
Received: by mail-yw0-f194.google.com with SMTP id b16so767757ywh.12
        for <fstests@vger.kernel.org>; Tue, 06 Feb 2018 00:51:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206081154.GQ18267@eguan.usersys.redhat.com>
References: <94286394-157a-421b-7f73-52f10529f23f@intel.com>
 <20180206035443.GN18267@eguan.usersys.redhat.com> <CAOQ4uxgFYZR6kEVjRcwFOdTN8q=m5L5fyQdhE4dT=dghC5vnMA@mail.gmail.com>
 <20180206081154.GQ18267@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2018 10:51:43 +0200
Message-ID: <CAOQ4uxhGGLposGsgJo8TrkMiDKZNQTyucxBviJgZ=fbLFWg3Ag@mail.gmail.com>
Subject: Re: xfstests failures
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>, fstests <fstests@vger.kernel.org>, "Zwisler, Ross" <ross.zwisler@intel.com>, Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 6, 2018 at 10:11 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Feb 06, 2018 at 08:45:24AM +0200, Amir Goldstein wrote:
>> On Tue, Feb 6, 2018 at 5:54 AM, Eryu Guan <eguan@redhat.com> wrote:
[...]
>>
>> Eryu,
>>
>> This short thread has shown how much the information about failing tests is
>> not documented. And that the information is stored only in our
>> collective brain hive.
>>
>> For example, how many people out there are able to dig through the
>> list the find out
>> the following information about overlay test failures:
>> 016 - long standing known issue - time for a fix unknown
>> 041,42,43 - known issue - resolved by RFC "xino" patches -
>>                    time for merge unknown
>> 049 - mainline issue - resolved by today's overlayfs-next merge
>> 054,55 - new failing tests with today's mainline - fix patch posted
>>
>> I know even you did not have the correct information about 017
>> and thought it should have been failing...
>>
>> How about maintaining an "expunge" format file with all failing test in
>> the repository with comment like the above?
>
> I'm fine with providing a mechanism to let fstests know which tests are
> known failures, like what Andreas just proposed just 3 days ago
>
> check: Add -F option to specify failing tests
> https://www.spinics.net/lists/fstests/msg08901.html
>
>> We could have 2 files, one for long standing issues like 016,041,042,043
>> and one for temporary failures, like 054,055
>>
>> We can debate whether long standing issues should be in auto or not,
>> but it doesn't hurt to mark them with some group (e.g. "known") that will
>> point users at the expunge.known file for a reason and for easy way to
>> exclude those tests.
>
> But I agreed with Dave[1] here that we should not maintain known
> failures in fstests itself, because the list can vary based on testers'
> configurations and hardware/software environments. I think the list
> should be maintained by testers according to their test configs and
> environments.
>
> I know Dave and Josef discussed the idea of making perf results public
> somewhere online in your "[LSF/MM TOPIC] Filesystem performance
> regression tests" thread[2]. Perhaps each filesystem maintainer could
> public their "official" results there too when the infrastructure is
> available?
>

Hmm, yeh, maintaining failure information per configuration is a challenge.
Creating a subset of tests that could be run on stable kernels/stable xfsprogs
is another worthy yet controversial goal. I read that Linaro have started an
effort to run LTP on stable kernels.

But how about long standing issues. Maybe overlay/016 is the only
example of a long standing issue?
When I posted the test, over a year ago the commit message read
"This issue is about to be fixed with a patch set by Miklos Szeredi"
Said patch did not sit well with Al, but the issue is still at the top
of the agenda
and has just been discussed last week [1].

How about a statement in the test _expect_failure that will automatically
add the test to the -F list?
Alternatively, or in addition to the statement we can add the list to
"failing" group, so that the -F code can easily count the expected
failures on run start.

Thanks,
Amir.

[1] https://marc.info/?l=linux-unionfs&m=151707113630958&w=2
