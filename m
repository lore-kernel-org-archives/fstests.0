Received: from mail-wm0-f66.google.com ([74.125.82.66]:33621 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbcLIE5F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Dec 2016 23:57:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so1444651wmu.0
        for <fstests@vger.kernel.org>; Thu, 08 Dec 2016 20:57:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209041641.GL29149@eguan.usersys.redhat.com>
References: <1481204070-10881-1-git-send-email-amir73il@gmail.com> <20161209041641.GL29149@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Dec 2016 06:57:03 +0200
Message-ID: <CAOQ4uxifuW2DDm5B976XUbGCPLiUvct6RDZY6KQ5Sa_ZYT=zYQ@mail.gmail.com>
Subject: Re: [PATCH] common: fix excluding test groups
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 9, 2016 at 6:16 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Thu, Dec 08, 2016 at 03:34:30PM +0200, Amir Goldstein wrote:
>> The -x flag is used to exclude tests that belong to
>> certain groups from the test args list.
>>
>> When the test args list is expressed as a match pattern,
>> -x fails to exclude the tests that match the pattern
>> and belong to excluded groups.
>>
>> For example:
>> $ ./check -n -x xfs/??? | wc -l
>
> You mean "./check -n -x fuzzers,dangerous_fuzzers | wc -l" here?
>

No. I just wanted to present the total number of tests that match the
pattern to show in the next line that -x does not exclude any tests.

>> 341
>> $ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
>> 341
>>
>> After the fix:
>> $ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
>> 315
>>
>> This bug seems to date back to this git repo epoc.
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>  check | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/check b/check
>> index 8f2a1bb..9732460 100755
>> --- a/check
>> +++ b/check
>> @@ -158,11 +158,14 @@ _timestamp()
>>  _prepare_test_list()
>>  {
>>       unset list
>> +     touch $tmp.list
>>       # Tests specified on the command line
>>       if [ -s $tmp.arglist ]; then
>> -             cat $tmp.arglist > $tmp.list
>> -     else
>> -             touch $tmp.list
>> +             # flatten multi tests line (tests/$fs/???) to 1 test per line
>> +             list=$(cat $tmp.arglist)
>> +             for t in $list; do
>> +                     echo "$t" >> $tmp.list
>> +             done
>
> Perhaps a sed is more efficient? e.g.
>
> -               cat $tmp.arglist > $tmp.list
> +               sed 's/ \+/\n/g' $tmp.arglist > $tmp.list
>

I have considered that and decided that efficiency is not an issue here
and better have the robustness of the shell parser without having to worry
about all the possible whitespace cases that I may be missing.
Besides, this is exactly the same as the population of $tmp.arglist when
the args list is expanded by the shell, which is BTW a workaround for
this issue, e.g.:

$ ln -s tests/xfs xfs
$ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
315

Check gets the explicit list of tests in this case and not the match pattern.

Amir.
