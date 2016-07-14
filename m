Received: from mail-io0-f171.google.com ([209.85.223.171]:33594 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcGNJLi (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 Jul 2016 05:11:38 -0400
Received: by mail-io0-f171.google.com with SMTP id 38so70085820iol.0
        for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 02:11:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160713123454.GW2432@eguan.usersys.redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
 <1468229169-24045-3-git-send-email-jtulak@redhat.com> <20160713123454.GW2432@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 14 Jul 2016 11:11:17 +0200
Message-ID: <CACj3i71hZQ6U=s-EwP-jRs3TJwwCQ7KKB6=Bv7gK-ug8V_Tb9Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] fstests: filename handling for extended names in
 ./check was on a wrong place
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, "Chinner, Dave" <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 13, 2016 at 2:34 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Jul 11, 2016 at 11:26:07AM +0200, Jan Tulak wrote:
>> The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
>> was moved at the earliest position, so everything working with the test name or
>> path will know the full name. Thus, no "123" and "123-bar-baz" mix is possible.
>>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>
> Can you please include more details in the description? It seems not so
> clear to me what the problem is from the description.
>
> If I understand it correctly (after playing around), prior to the patch:
> [root@dhcp-66-86-11 xfstests]# ./check xfs/999
> ...
> xfs/999 0s ... 0s
> Ran: xfs/999-test-case
> Passed all 1 tests
>
> After applying the patch:
> [root@dhcp-66-86-11 xfstests]# ./check xfs/999
> ...
> xfs/999-test-case 0s ... 0s
> Ran: xfs/999-test-case
> Passed all 1 tests
>
> So the test name is always correct, right?
>

Yes. Most importantly, this fixes issues around other name-based
operations, see the new message:
---
The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
was moved to the earliest position, so everything working with the test name or
path will know the full name. Thus, no "123" and "123-bar-baz" mix is possible.

An example of this issue is $testname.notrun file. When _notrun "foo" was run
during ./check foo/$name command, it created $name.notrun. But few lines later,
it wanted $fullname.notrun. So if you did ./check foo/999, but the file was
999-bar-baz, then you got comparing outputs (and most likely a fail)
instead of a skip.

Another example of this mix is in xfstests output:
./check xfs/999
[...]
xfs/999 0s ... 0s
Ran: xfs/999-test-case
---

Do you like it now? And do want it as a new version of the patch? :-)

Cheers,
Jan

> Thanks,
> Eryu
>
>> ---
>>  check | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/check b/check
>> index 5be183f..ef6bd47 100755
>> --- a/check
>> +++ b/check
>> @@ -543,6 +543,20 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>       for seq in $list
>>       do
>>           err=false
>> +         if [ ! -f $seq ]; then
>> +             # Try to get full name in case the user supplied only seq id
>> +             # and the test has a name. A bit of hassle to find really
>> +             # the test and not its sample output or helping files.
>> +             bname=$(basename $seq)
>> +             full_seq=$(find $(dirname $seq) -name $bname* -executable |
>> +                 awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
>> +                     END { print shortest }')
>> +             if [ -f $full_seq ] \
>> +                 && [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
>> +                 seq=$full_seq
>> +                 seqnum=${full_seq#*/}
>> +             fi
>> +         fi
>>
>>           # the filename for the test and the name output are different.
>>           # we don't include the tests/ directory in the name output.
>> @@ -566,19 +580,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>               if $showme; then
>>                       echo
>>                       continue
>> -             elif [ ! -f $seq ]; then
>> -                     # Try to get full name in case the user supplied only seq id
>> -                     # and the test has a name. A bit of hassle to find really
>> -                     # the test and not its sample output or helping files.
>> -                     bname=$(basename $seq)
>> -                     full_seq=$(find $(dirname $seq) -name $bname* -executable |
>> -                             awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
>> -                                     END { print shortest }')
>> -                     if [ -f $full_seq ] \
>> -                             && [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
>> -                             seq=$full_seq
>> -                             seqnum=${full_seq#*/}
>> -                     fi
>>               fi
>>
>>               if [ ! -f $seq ]; then
>> --
>> 2.5.5
>>



-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
