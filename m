Received: from mail-it0-f49.google.com ([209.85.214.49]:36014 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbcGKJ2H (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 11 Jul 2016 05:28:07 -0400
Received: by mail-it0-f49.google.com with SMTP id f6so49123702ith.1
        for <fstests@vger.kernel.org>; Mon, 11 Jul 2016 02:28:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160704014617.GB27480@dastard>
References: <1467389347-2055-1-git-send-email-jtulak@redhat.com>
 <1467389347-2055-3-git-send-email-jtulak@redhat.com> <20160704014617.GB27480@dastard>
From: Jan Tulak <jtulak@redhat.com>
Date: Mon, 11 Jul 2016 11:27:46 +0200
Message-ID: <CACj3i72RAhA+pSGGp2Tp-qq2CrqR0cnL5_tNqhofPOMWLE2ctg@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfstests: filename handling for extended names in
 ./check was on a wrong place
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi,

On Mon, Jul 4, 2016 at 3:46 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Jul 01, 2016 at 06:09:07PM +0200, Jan Tulak wrote:
>> The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
>> was moved at the earliest position, so everything working with the test
>> name/path will know the full name, and no 123/123-bar-baz mix is possible.
>>
>> When moving the code, put qutation marks around a wildcard name to prevent
>> early expansion
>
> Can you put this in a separate patch so it's easy to see and review?
> i.e. move the code in one patch, change the code in a second?
>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> ---
>>  check | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/check b/check
>> index 5be183f..10ae375 100755
>> --- a/check
>> +++ b/check
>> @@ -543,6 +543,20 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>       for seq in $list
>>       do
>>           err=false
>> +             if [ ! -f $seq ]; then
>> +                     # Try to get full name in case the user supplied only seq id
>> +                     # and the test has a name. A bit of hassle to find really
>> +                     # the test and not its sample output or helping files.
>> +                     bname=$(basename $seq)
>> +
>> +                     full_seq=$(find $(dirname $seq) -name "$bname*" -executable |
>> +                             awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
>> +                                     END { print shortest }')
>> +                     if [ -f $full_seq ] \
>> +                             && [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
>> +                             seq=$full_seq
>> +                     fi
>> +             fi
>>
>>           # the filename for the test and the name output are different.
>>           # we don't include the tests/ directory in the name output.
>
> This now has whitespace issues - the indentation does not match the
> surrounding context.
>

I'm back from holiday. I split the patch and the whitespaces should
now match the code around.

Thanks,
Jan


-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
