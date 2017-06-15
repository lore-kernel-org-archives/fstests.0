Received: from sandeen.net ([63.231.237.45]:40904 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdFOQlz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Jun 2017 12:41:55 -0400
Subject: Re: [PATCH V2] xfs/289: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
 <fbad53d8-9807-1912-c3e4-e932020c19d3@sandeen.net>
 <591E5BEB.5070008@cn.fujitsu.com>
 <a511db57-db7f-6a7c-39ea-e6d3b003970c@sandeen.net>
 <9940cc65-677e-eeac-7a7c-ec3ba5ef2db4@sandeen.net>
 <35eca5c0-1cab-e27c-f5e5-a35a30530c85@sandeen.net>
 <59424158.3040401@cn.fujitsu.com>
 <f58a62ec-9017-fd5e-7e5d-de259ac3c638@sandeen.net>
 <20170615163026.GA4526@birch.djwong.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <b3661f51-8771-0bad-6f94-9deff430f556@sandeen.net>
Date: Thu, 15 Jun 2017 11:41:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170615163026.GA4526@birch.djwong.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

On 6/15/17 11:30 AM, Darrick J. Wong wrote:
> On Thu, Jun 15, 2017 at 09:19:44AM -0500, Eric Sandeen wrote:
>> On 6/15/17 3:12 AM, Xiao Yang wrote:
>>> On 2017/05/20 10:25, Eric Sandeen wrote:
>>>>
>>>> On 5/19/17 11:39 AM, Eric Sandeen wrote:
>>>>> On 5/18/17 10:30 PM, Eric Sandeen wrote:
>>>>>
>>>>>> That's an odd failure; I wrote the test for upstream...
>>>>>>
>>>>>> On that kernel, despite free inodes:
>>>>>>
>>>>>> # df -i /mnt/scratch
>>>>>> Filesystem     Inodes IUsed IFree IUse% Mounted on
>>>>>> /dev/loop1      10260   490  9770    5% /mnt/scratch
>>>>>>
>>>>>> and xfs_db concurs (more or less?):
>>>>>>
>>>>>> icount =3D 10240
>>>>>> ifree =3D 9750
>>>>>>
>>>>>> creating a new inode fails:
>>>>>>
>>>>>> # touch /mnt/scratch/testdir/12345678901234567890169
>>>>>> touch: cannot touch =E2=80=98/mnt/scratch/testdir/1234567890123456=
7890169=E2=80=99: No space left on device
>>>>>>
>>>>>> Everything about the fs looks the same as if we run it upstream, i=
ncluding
>>>>>> the reserved blocks:
>>>>>>
>>>>>> reserved blocks =3D 6553
>>>>>> available reserved blocks =3D 6553
>>>>>>
>>>>>> But, it's failing to allocate the space:
>>>>>>
>>>>>>             touch-12302 [005] d... 118038.499302: ret_xfs_mod_fdbl=
ocks: (xfs_trans_reserve+0x123/0x200 [xfs]<- xfs_mod_fdblocks) arg1=3D0xf=
fffffe4
>>>>>>
>>>>>> (arg1 is the return value, -ENOSPC)
>>>>>>
>>>>>> It's not clear to me at this point why we can't create another ino=
de on this fs.
>>>>> Ugh, I can't believe I missed this - I actually didn't do anything =
to ensure that
>>>>> there is free space to grow the actual directory into.
>>>>>
>>>>> If I add this just prior to the last 1300-file touch loop:
>>>>>
>>>>> ./src/punch-alternating $SCRATCH_MNT/spacefile1>>  $seqres.full 2>&=
1
>>>>>
>>>>> that seems to let the test proceed w/o ENOSPC, and properly fragmen=
t the
>>>>> dir.
>>>>>
>>>>> (OTOH upstream, now the test is reporting fs corruption, though I d=
on't
>>>>> see it after the test completes.  Very confused now.  It might be
>>>>> confusing xfs_check?  Repair is happy...)
>>>>>
>>>>> I'm still not sure why the rhel kernel differs from upstream, thoug=
h.
>>>> The more I look at this, the more I realize how fragile the test is.=
  It's
>>>> trying to control allocation, which is almost nearly impossible to d=
o
>>>> reliably in a test.
>>>>
>>>> I'm not quite sure how to make this one better...
>>> Hi Eric
>>>
>>> Sorry for the late reply.
>>>
>>> Firstly, The following command works abnormally on RHEL7.3 and RHEL7.=
4.
>>> dd conv=3Dfsync if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile2 bs=3D1M c=
ount=3D64
>>>
>>> If bs is set to 1M and the remaining freespace is less than 1M, dd co=
uld not write any data
>>> into spacefile2.  However, it still writes data into spacefile2 and l=
eads that there is no
>>> enough free space to grow the actual directory.
>>>
>>> Secondly, I tested this case with upstream kernel in RHEL7.3 on virtu=
al machine, but i awlays don't
>>> trigger this bug.  Is there some specific settings?
>>>
>>> Could we use the following command to consume a lot of remaining free=
 space, but reserve
>>> some free space to create the last 1300-file:
>>> dd conv=3Dfsync if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile2 bs=3D1K c=
ount=3D35000
>>>
>>> I am not sure if this change can still trigger kernel bug.  :-)
>>
>> Honestly, I think this test should probably be removed.  It's trying t=
oo hard to
>> control allocation behavior, which is not possible in general.
>>
>> The only other approach I can think of is to create a lot of one-block=
 files,
>> map them all, and then decide which ones to remove (or perhaps better,=
 truncate to
>> 0 length) in an effort to create perfectly fragmented freespace.  At l=
east that
>> way we would not be trying control or expect allocation patterns ahead=
 of time.
>=20
> <shrug> There are common/ helpers to fill up a filesystem, why not
> use that instead of open-coding it?

Filling a filesystem is not the problem; leaving /only/ discontiguous fre=
e blocks
available for directory allocation is the problem...

That was the original goal with the "punch every other (logical) block" b=
ut that
wasn't quite sufficient.

> This test uncovered a somewhat obscure corruption bug, which to me
> argues for /not/ kicking this one out.

Well, it was written as a regression test to demonstrate the bug, but it
is not reliably doing so...

It's "failing" due to problems in the test, not due to the bug, so it nee=
ds
to be fixed or removed, I think.

-Eric

> --D
>=20
