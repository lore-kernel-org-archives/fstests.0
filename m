Received: from mail-io0-f196.google.com ([209.85.223.196]:37975 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757308AbeAHNzn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Jan 2018 08:55:43 -0500
MIME-Version: 1.0
In-Reply-To: <2ee54197-b45a-c89d-80c0-e511b497d2e3@gmx.com>
References: <1515401010-26802-1-git-send-email-nborisov@suse.com> <2ee54197-b45a-c89d-80c0-e511b497d2e3@gmx.com>
From: Timofey Titovets <nefelim4ag@gmail.com>
Date: Mon, 8 Jan 2018 16:55:01 +0300
Message-ID: <CAGqmi76511+XemmB4Vz-vw=cq394fTn6tLnpCgPmuKZ_N0987A@mail.gmail.com>
Subject: Re: [PATCH] generic/015: Change the test filesystem size to 101mb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, David Sterba <dsterba@suse.cz>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

2018-01-08 15:54 GMT+03:00 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>
> On 2018=E5=B9=B401=E6=9C=8808=E6=97=A5 16:43, Nikolay Borisov wrote:
>> This test has been failing for btrfs for quite some time,
>> at least since 4.7. There are 2 implementation details of btrfs that
>> it exposes:
>>
>> 1. Currently btrfs filesystem under 100mb are created in Mixed block
>> group mode. Freespace accounting for it is not 100% accurate - I've
>> observed around 100-200kb discrepancy between a newly created filesystem=
,
>> then writing a file and deleting it and checking the free space. This
>> falls within %3 and not %1 as hardcoded in the test.
>>
>> 2. BTRFS won't flush it's delayed allocation on file deletion if less
>> than 32mb are deleted. On such files we need to perform sync (missing
>> in the test) or wait until time elapses for transaction commit.
>
> I'm a little confused about the 32mb limit.
>
> My personal guess about the reason to delay space freeing would be:
> 1) Performance
>    Btrfs tree operation (at least for write) is slow due to its tree
>    design.
>    So it may makes sense to delay space freeing.
>
>    But in that case, 32MB may seems to small to really improve the
>    performance. (Max file extent size is 128M, delaying one item
>    deletion doesn't really improve performance)
>
> 2) To avoid later new allocation to rewrite the data.
>    It's possible that freed space of deleted inode A get allocated to
>    new file extents. And a power loss happens before we commit the
>    transaction.
>
>    In that case, if everything else works fine, we should be reverted to
>    previous transaction where deleted inode A still exists.
>    But we lost its data, as its data is overwritten by other file
>    extents. And any read will just cause csum error.
>
>    But in that case, there shouldn't be any 32MB limit, but all deletion
>    of orphan inodes should be delayed.
>
>    And further more, this can be addressed using log tree, to log such
>    deletion so at recovery time, we just delete that inode.
>
> So I'm wonder if we can improve btrfs deletion behavior.
>
>
>>
>> Since mixed mode is somewhat deprecated and btrfs is not really intended
>> to be used on really small devices let's just adjust the test to
>> create a 101mb fs, which doesn't use mixed mode and really test
>> freespace accounting.
>
> Despite of some btrfs related questions, I'm wondering if there is any
> standard specifying (POSIX?) how a filesystem should behave when
> unlinking a file.
>
> Should the space freeing be synchronized? And how should statfs report
> available space?
>
> In short, I'm wondering if this test and its expected behavior is
> generic enough for all filesystems.
>
> Thanks,
> Qu
>
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  tests/generic/015 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/015 b/tests/generic/015
>> index 78f2b13..416c4ae 100755
>> --- a/tests/generic/015
>> +++ b/tests/generic/015
>> @@ -53,7 +53,7 @@ _supported_os Linux
>>  _require_scratch
>>  _require_no_large_scratch_dev
>>
>> -_scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
>> +_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
>>      || _fail "mkfs failed"
>>  _scratch_mount || _fail "mount failed"
>>  out=3D$SCRATCH_MNT/fillup.$$
>>
>

All fs, including btrfs (AFAIK) return unlink(), (if file not open)
only then space has been freed.
So free space after return of unlink() must be freed.
Proofs: [1] [2] [3]
[4] - Posix, looks like do not describe behaviour.

1. http://man7.org/linux/man-pages/man2/unlink.2.html
2. https://stackoverflow.com/questions/31448693/why-system-call-unlink-so-s=
low
3. https://www.spinics.net/lists/linux-btrfs/msg59901.html
4. https://www.unix.com/man-page/posix/1P/unlink/

Thanks.
--=20
Have a nice day,
Timofey.
