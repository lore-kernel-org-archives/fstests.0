Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35770 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbbDGGcX (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 7 Apr 2015 02:32:23 -0400
Received: by widdi4 with SMTP id di4so5229481wid.0
        for <fstests@vger.kernel.org>; Mon, 06 Apr 2015 23:32:22 -0700 (PDT)
Message-ID: <552379F3.9090205@plexistor.com>
Date: Tue, 07 Apr 2015 09:32:19 +0300
From: Omer Zilberberg <omzg@plexistor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/076: fixed incorrect fsstress parameters
References: <1427990168-21503-1-git-send-email-omzg@plexistor.com> <CAL3q7H4KPH22AptJaSMFapp1iOECuWHKUjEYznrCwe7mV5SUcg@mail.gmail.com> <20150407022937.GB13731@dastard>
In-Reply-To: <20150407022937.GB13731@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Filipe David Manana <fdmanana@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 04/07/2015 05:29 AM, Dave Chinner wrote:
> On Thu, Apr 02, 2015 at 10:05:40PM +0100, Filipe David Manana wrote:
>> On Thu, Apr 2, 2015 at 4:56 PM, Omer Zilberberg <omzg@plexistor.com> wrote:
>>> Test was not run because directory parameter was omitted.
>>> Also return value was not tested, so this problem was not caught.
>>>
>>> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Tested-by: Filipe Manana <fdmanana@suse.com>
>>
>>> ---
>>>  tests/generic/076 | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/generic/076 b/tests/generic/076
>>> index aa0aae0..3e1aa1a 100755
>>> --- a/tests/generic/076
>>> +++ b/tests/generic/076
>>> @@ -74,9 +74,11 @@ echo "*** test concurrent block/fs access"
>>>  cat $SCRATCH_DEV >/dev/null &
>>>  pid=$!
>>>
>>> -FSSTRESS_ARGS=`_scale_fsstress_args -p 2 -n 2000 $FSSTRESS_AVOID`
>>> +FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p 2 -n 2000 $FSSTRESS_AVOID`
>>>  echo "run fsstress with args: $FSSTRESS_ARGS" >>$seqres.full
>>>  $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
>>> +rc=$?
>>> +[ $rc != 0 ] && echo "fsstress returned $rc - see $seqres.full"
>>
>> run_check $FSSTRESS_PROG $FSSTRESS_ARGS
>>
>> Would also do it (some other tests do this).
> 
> Please don't encourage run_check usage - it's cargo-cult programming
> at it's worst. It stops people from thinking about what errors they
> actually need to care about and capture exactly via other methods
> (such as output filtering).
> 
> To demonstrate: fsstress only ever returns non-zero when there's a
> config or setup problem. This basically never happens once the test
> has been written. Further, fsstress does not collect runtime errors
> from child processes because it is designed to trigger errors and
> still continue onwards. Finally, the output stream is really only
> debug information, so that's not useful for anythign other than
> debugging, either.
> 
> Hence there is never any need to check exit status of fsstress, nor
> do anything with the output stream except redirect it to the
> debug output file or the bit bucket.
run_check usage notwithstanding, I would argue that checking the exit 
status of fsstress would have prevented this problem - the dir argument
was omitted during the introduction of load factor into fsstress in b84aade,
and the test has been printing fsstress usage message to the debug output 
file ever since, when IMHO it should have failed.
> 
> Cheers,
> 
> Dave.
> 
Thank you both for your comments.
