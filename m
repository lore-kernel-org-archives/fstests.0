Received: from mx2.suse.de ([195.135.220.15]:37988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757037AbeAHORT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Jan 2018 09:17:19 -0500
Subject: Re: [PATCH] generic/015: Change the test filesystem size to 101mb
References: <1515401010-26802-1-git-send-email-nborisov@suse.com>
 <2ee54197-b45a-c89d-80c0-e511b497d2e3@gmx.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <e369fa1c-87cd-57e9-13ea-93e6d72f379d@suse.com>
Date: Mon, 8 Jan 2018 16:17:16 +0200
MIME-Version: 1.0
In-Reply-To: <2ee54197-b45a-c89d-80c0-e511b497d2e3@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On  8.01.2018 14:54, Qu Wenruo wrote:
>=20
>=20
> On 2018=E5=B9=B401=E6=9C=8808=E6=97=A5 16:43, Nikolay Borisov wrote:
>> This test has been failing for btrfs for quite some time,
>> at least since 4.7. There are 2 implementation details of btrfs that
>> it exposes:
>>
>> 1. Currently btrfs filesystem under 100mb are created in Mixed block
>> group mode. Freespace accounting for it is not 100% accurate - I've
>> observed around 100-200kb discrepancy between a newly created filesyst=
em,
>> then writing a file and deleting it and checking the free space. This
>> falls within %3 and not %1 as hardcoded in the test.
>>
>> 2. BTRFS won't flush it's delayed allocation on file deletion if less
>> than 32mb are deleted. On such files we need to perform sync (missing
>> in the test) or wait until time elapses for transaction commit.
>=20
> I'm a little confused about the 32mb limit.
>=20
> My personal guess about the reason to delay space freeing would be:
> 1) Performance
>    Btrfs tree operation (at least for write) is slow due to its tree
>    design.
>    So it may makes sense to delay space freeing.
>=20
>    But in that case, 32MB may seems to small to really improve the
>    performance. (Max file extent size is 128M, delaying one item
>    deletion doesn't really improve performance)
>=20
> 2) To avoid later new allocation to rewrite the data.
>    It's possible that freed space of deleted inode A get allocated to
>    new file extents. And a power loss happens before we commit the
>    transaction.
>=20
>    In that case, if everything else works fine, we should be reverted t=
o
>    previous transaction where deleted inode A still exists.
>    But we lost its data, as its data is overwritten by other file
>    extents. And any read will just cause csum error.
>=20
>    But in that case, there shouldn't be any 32MB limit, but all deletio=
n
>    of orphan inodes should be delayed.
>=20
>    And further more, this can be addressed using log tree, to log such
>    deletion so at recovery time, we just delete that inode.
>=20
> So I'm wonder if we can improve btrfs deletion behavior.

So the initial commit I'm talking about is this one:
28ed1345a50491d78e1454ad4005dc5d3557a69e and the function in question
is: btrfs_truncate_inode_items
>=20
>=20
>>
>> Since mixed mode is somewhat deprecated and btrfs is not really intend=
ed
>> to be used on really small devices let's just adjust the test to
>> create a 101mb fs, which doesn't use mixed mode and really test
>> freespace accounting.
>=20
> Despite of some btrfs related questions, I'm wondering if there is any
> standard specifying (POSIX?) how a filesystem should behave when
> unlinking a file.
>=20
> Should the space freeing be synchronized? And how should statfs report
> available space?

While digging a bit more into this I also found that we alway have a
discrepancy of 1mb when reporting statfs if we have unallocated device
space and if everything is allocated to chunks. The reason being that if
we have unallocated space on the device then btrfs_calc_avail_data_space
subtracts 1mb from the unallocated space of the device. This is
apparently done to mimics the allocator's behavior. However, when
everything is reported based on the status of the space_info struct i.e
btrfs_calc_avail_data_space return 0 in free_bytes then we don't do this
subtraction. So in the end the issue might not really be in the test but
in the way we report freespace from df. And 101mb happens to work
because the 1mb discrepancy falls within %1 error margin on a fs of
101mb size

>=20
> In short, I'm wondering if this test and its expected behavior is
> generic enough for all filesystems.
>=20
> Thanks,
> Qu
>=20
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
>> =20
>> -_scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
>> +_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
>>      || _fail "mkfs failed"
>>  _scratch_mount || _fail "mount failed"
>>  out=3D$SCRATCH_MNT/fillup.$$
>>
>=20
