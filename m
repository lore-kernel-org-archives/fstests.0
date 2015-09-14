Received: from mail-ig0-f174.google.com ([209.85.213.174]:33493 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbbINIf2 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 14 Sep 2015 04:35:28 -0400
Received: by igbkq10 with SMTP id kq10so84838198igb.0
        for <fstests@vger.kernel.org>; Mon, 14 Sep 2015 01:35:27 -0700 (PDT)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <CAPBX1x+GZ0iorNojS90o7eAw4-0Z3LWsLN_8Bz8vscwJ0vEjQQ@mail.gmail.com>
References: <1441971691-26427-1-git-send-email-xuw2015@gmail.com>
	<CAL3q7H48_juhy1vagw6KR5MPgjc2GO4Spy7PU8tLMUiaqReCWw@mail.gmail.com>
	<CAPBX1x+GZ0iorNojS90o7eAw4-0Z3LWsLN_8Bz8vscwJ0vEjQQ@mail.gmail.com>
Date: Mon, 14 Sep 2015 09:35:27 +0100
Message-ID: <CAL3q7H7+do645WXZkvVeFhyzcxdWuv=EvgXMVeT1kKN-RcLvcQ@mail.gmail.com>
Subject: Re: [PATCH] generic/027: enlarge fs size for btrfs in bigger
 page-size machine
From: Filipe David Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: George Wang <xuw2015@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 14, 2015 at 4:40 AM, George Wang <xuw2015@gmail.com> wrote:
> On Fri, Sep 11, 2015 at 8:06 PM, Filipe David Manana <fdmanana@gmail.com> wrote:
>> On Fri, Sep 11, 2015 at 12:41 PM,  <xuw2015@gmail.com> wrote:
>>> From: George Wang <xuw2015@gmail.com>
>>>
>>> btrfs on bigger page-size machine(such as ppc64/ppc64le), the min fs
>>> size shoule be more than 480MB. Otherwise, the mount will fail.
>>
>> Interesting, wasn't aware of that.
>> How does it fail? What error message do you get?
>
> The ppc64/ppc64le page size is 64KB, and if the fs size is less than
> 480MB, the first
> mount operation failed, the 2nd time succeeded.

(adding back fstests list)

Yes, but can you please mention if there's any btrfs
error/warning/stack trace in syslog?

> The following is my analysis:
>
> btrfs do the space allocation by do_chunk_alloc, but this function
> does not care about
> the size wanted to allocate, it just alloc the chunk size on its rule.
>
> the open_ctree will try to create the uuid tree, which needs to
> reserve some space in
> btrfs_start_transaction. if no engough space, the
> reserve_metadata_bytes will call the
> flush_space for space reclaiming. it will call flush_space many times,
> every time with
> different flush level. when the flush level is ALLOC_CHUNK, it will call the
> do_chunk_alloc to allocate a chunk. Unfortunately, the new chunk may be smaller
> than the size we want, so the first time to mount will fail. And we
> mount it again, it
> will allocate a chunk again, then the size can meet our requirement.

So the second mount succeeds and it's able to allocate a big enough
chunk while the first mount isn't?
If so, than that's more likely to be a bug in btrfs rather than a
problem in the test imho.

On x86 running the test with MKFS_OPTIONS="-n 65536" should then
theoretically allow to reproduce the issue, since the size of the
files the test creates are multiples of both 4K and 64K. For me that
(the mount "failure") doesn't happen, but instead the test has been
running for over 2 hours with such a node size when it usually takes a
couple minutes.

thanks

>
>>
>> How did you calculate those values (480Mb and 512Mb)?
>
> I did not calculate, just test many times by binary-search method. for example:
> (256~512)->(384~512)->...
> And I do not think 480MB is the accurate number, but for reproduce the
> problem, it's
> enough.
>
> Thanks
>
> George
>
>>
>> thanks
>>
>>> So we shoud adjust the fs size to 512MB for btrfs to run this test
>>> correctly. And we also provide a double check: if mount fails, we should
>>> never run this test.
>>>
>>> Signed-off-by: George Wang <xuw2015@gmail.com>
>>> ---
>>>  tests/generic/027 | 19 +++++++++++--------
>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/tests/generic/027 b/tests/generic/027
>>> index d2e59d6..c42b9a6 100755
>>> --- a/tests/generic/027
>>> +++ b/tests/generic/027
>>> @@ -65,8 +65,17 @@ _require_scratch
>>>  rm -f $seqres.full
>>>  echo "Silence is golden"
>>>
>>> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
>>> -_scratch_mount
>>> +loop=100
>>> +fs_size=$((256 * 1024 * 1024))
>>> +# btrfs takes much longer time, reduce the loop count
>>> +# btrfs takes much more space when first mount on bigger page-size machine
>>> +if [ "$FSTYP" == "btrfs" ]; then
>>> +       loop=10
>>> +       fs_size=$((512 * 1024 * 1024))
>>> +fi
>>> +
>>> +_scratch_mkfs_sized $(fs_size) >>$seqres.full 2>&1
>>> +_scratch_mount || _notrun "scratch dev is not mounted successfully"
>>>
>>>  echo "Reserve 2M space" >>$seqres.full
>>>  $XFS_IO_PROG -f -c "pwrite 0 2m" $SCRATCH_MNT/testfile >>$seqres.full 2>&1
>>> @@ -75,12 +84,6 @@ $XFS_IO_PROG -f -c "pwrite 0 254m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
>>>  echo "Remove reserved file" >>$seqres.full
>>>  rm -f $SCRATCH_MNT/testfile
>>>
>>> -loop=100
>>> -# btrfs takes much longer time, reduce the loop count
>>> -if [ "$FSTYP" == "btrfs" ]; then
>>> -       loop=10
>>> -fi
>>> -
>>>  dir=$SCRATCH_MNT/testdir
>>>  echo -n "iteration" >>$seqres.full
>>>  i=1
>>> --
>>> 1.9.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Filipe David Manana,
>>
>> "Reasonable men adapt themselves to the world.
>>  Unreasonable men adapt the world to themselves.
>>  That's why all progress depends on unreasonable men."



-- 
Filipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
