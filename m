Received: from mout.gmx.net ([212.227.17.20]:51603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758634AbeAIA37 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Jan 2018 19:29:59 -0500
Subject: Re: [PATCH] generic/015: Change the test filesystem size to 101mb
References: <1515401010-26802-1-git-send-email-nborisov@suse.com>
 <2ee54197-b45a-c89d-80c0-e511b497d2e3@gmx.com>
 <CAGqmi76511+XemmB4Vz-vw=cq394fTn6tLnpCgPmuKZ_N0987A@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e2160640-68ce-477e-f7a1-981213a4ad6d@gmx.com>
Date: Tue, 9 Jan 2018 08:29:41 +0800
MIME-Version: 1.0
In-Reply-To: <CAGqmi76511+XemmB4Vz-vw=cq394fTn6tLnpCgPmuKZ_N0987A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4AABSLtJl6xpRI3By3ohlZdGvfpNRerxr"
Sender: fstests-owner@vger.kernel.org
To: Timofey Titovets <nefelim4ag@gmail.com>
Cc: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, David Sterba <dsterba@suse.cz>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4AABSLtJl6xpRI3By3ohlZdGvfpNRerxr
Content-Type: multipart/mixed; boundary="P63aXDjSjqHAl4ggNqvIb4FO344nMndxI";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Timofey Titovets <nefelim4ag@gmail.com>
Cc: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org,
 David Sterba <dsterba@suse.cz>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <e2160640-68ce-477e-f7a1-981213a4ad6d@gmx.com>
Subject: Re: [PATCH] generic/015: Change the test filesystem size to 101mb
References: <1515401010-26802-1-git-send-email-nborisov@suse.com>
 <2ee54197-b45a-c89d-80c0-e511b497d2e3@gmx.com>
 <CAGqmi76511+XemmB4Vz-vw=cq394fTn6tLnpCgPmuKZ_N0987A@mail.gmail.com>
In-Reply-To: <CAGqmi76511+XemmB4Vz-vw=cq394fTn6tLnpCgPmuKZ_N0987A@mail.gmail.com>

--P63aXDjSjqHAl4ggNqvIb4FO344nMndxI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B401=E6=9C=8808=E6=97=A5 21:55, Timofey Titovets wrote:
> 2018-01-08 15:54 GMT+03:00 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>
>> On 2018=E5=B9=B401=E6=9C=8808=E6=97=A5 16:43, Nikolay Borisov wrote:
>>> This test has been failing for btrfs for quite some time,
>>> at least since 4.7. There are 2 implementation details of btrfs that
>>> it exposes:
>>>
>>> 1. Currently btrfs filesystem under 100mb are created in Mixed block
>>> group mode. Freespace accounting for it is not 100% accurate - I've
>>> observed around 100-200kb discrepancy between a newly created filesys=
tem,
>>> then writing a file and deleting it and checking the free space. This=

>>> falls within %3 and not %1 as hardcoded in the test.
>>>
>>> 2. BTRFS won't flush it's delayed allocation on file deletion if less=

>>> than 32mb are deleted. On such files we need to perform sync (missing=

>>> in the test) or wait until time elapses for transaction commit.
>>
>> I'm a little confused about the 32mb limit.
>>
>> My personal guess about the reason to delay space freeing would be:
>> 1) Performance
>>    Btrfs tree operation (at least for write) is slow due to its tree
>>    design.
>>    So it may makes sense to delay space freeing.
>>
>>    But in that case, 32MB may seems to small to really improve the
>>    performance. (Max file extent size is 128M, delaying one item
>>    deletion doesn't really improve performance)
>>
>> 2) To avoid later new allocation to rewrite the data.
>>    It's possible that freed space of deleted inode A get allocated to
>>    new file extents. And a power loss happens before we commit the
>>    transaction.
>>
>>    In that case, if everything else works fine, we should be reverted =
to
>>    previous transaction where deleted inode A still exists.
>>    But we lost its data, as its data is overwritten by other file
>>    extents. And any read will just cause csum error.
>>
>>    But in that case, there shouldn't be any 32MB limit, but all deleti=
on
>>    of orphan inodes should be delayed.
>>
>>    And further more, this can be addressed using log tree, to log such=

>>    deletion so at recovery time, we just delete that inode.
>>
>> So I'm wonder if we can improve btrfs deletion behavior.
>>
>>
>>>
>>> Since mixed mode is somewhat deprecated and btrfs is not really inten=
ded
>>> to be used on really small devices let's just adjust the test to
>>> create a 101mb fs, which doesn't use mixed mode and really test
>>> freespace accounting.
>>
>> Despite of some btrfs related questions, I'm wondering if there is any=

>> standard specifying (POSIX?) how a filesystem should behave when
>> unlinking a file.
>>
>> Should the space freeing be synchronized? And how should statfs report=

>> available space?
>>
>> In short, I'm wondering if this test and its expected behavior is
>> generic enough for all filesystems.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>  tests/generic/015 | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/generic/015 b/tests/generic/015
>>> index 78f2b13..416c4ae 100755
>>> --- a/tests/generic/015
>>> +++ b/tests/generic/015
>>> @@ -53,7 +53,7 @@ _supported_os Linux
>>>  _require_scratch
>>>  _require_no_large_scratch_dev
>>>
>>> -_scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
>>> +_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
>>>      || _fail "mkfs failed"
>>>  _scratch_mount || _fail "mount failed"
>>>  out=3D$SCRATCH_MNT/fillup.$$
>>>
>>
>=20
> All fs, including btrfs (AFAIK) return unlink(), (if file not open)
> only then space has been freed.

AFAIK there is btrfs orphan inode item for delayed deletion.
So at least not for btrfs.

> So free space after return of unlink() must be freed.
> Proofs: [1] [2] [3]
> [4] - Posix, looks like do not describe behaviour.
>=20
> 1. http://man7.org/linux/man-pages/man2/unlink.2.html

"If that name was the last link to a file and no processes have the file
open, the file is deleted and the space it was using is made available
for reuse."

But when? I think that's the point, and no exact explain on this.

Thanks,
Qu

> 2. https://stackoverflow.com/questions/31448693/why-system-call-unlink-=
so-slow
> 3. https://www.spinics.net/lists/linux-btrfs/msg59901.html
> 4. https://www.unix.com/man-page/posix/1P/unlink/
>=20
> Thanks.
>=20


--P63aXDjSjqHAl4ggNqvIb4FO344nMndxI--

--4AABSLtJl6xpRI3By3ohlZdGvfpNRerxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlpUDPUXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhAlQf7Bi09T8EfMJ5HeugyX5ZwcnFy
GI/FHwKWxaGH7eWIoeLBID7UCsRQa2kV3/62KIF1Z7QWQvxPwQqzjbxO6XiRLpZg
6jSRQ+bDun7RsiDv2qIVDf+dez4SHMpRXpoKXkShJmwjFEdQ3a+YL4+s8SHNclCf
EI79NYk4dWy81IHBezw98+ata0FpGeMIWaDJzza4fokcOWBfYaNjaO7lfpZUsCNH
Ue+lywMXvjVoCwYcKyh15kmucdemUELAQA8/jTH+xcbpT38dKvAYXe1zQvuC0gDY
3ZeSBYcSfqEjSirOYEYgyAvoL/7/1hKYta99nvnhr60LHxO2eUO1v8b70wp2Cg==
=DYR/
-----END PGP SIGNATURE-----

--4AABSLtJl6xpRI3By3ohlZdGvfpNRerxr--
