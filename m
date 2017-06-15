Received: from sandeen.net ([63.231.237.45]:58546 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdFOOTs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Jun 2017 10:19:48 -0400
Subject: Re: [PATCH V2] xfs/289: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
 <fbad53d8-9807-1912-c3e4-e932020c19d3@sandeen.net>
 <591E5BEB.5070008@cn.fujitsu.com>
 <a511db57-db7f-6a7c-39ea-e6d3b003970c@sandeen.net>
 <9940cc65-677e-eeac-7a7c-ec3ba5ef2db4@sandeen.net>
 <35eca5c0-1cab-e27c-f5e5-a35a30530c85@sandeen.net>
 <59424158.3040401@cn.fujitsu.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <f58a62ec-9017-fd5e-7e5d-de259ac3c638@sandeen.net>
Date: Thu, 15 Jun 2017 09:19:44 -0500
MIME-Version: 1.0
In-Reply-To: <59424158.3040401@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

On 6/15/17 3:12 AM, Xiao Yang wrote:
> On 2017/05/20 10:25, Eric Sandeen wrote:
>>
>> On 5/19/17 11:39 AM, Eric Sandeen wrote:
>>> On 5/18/17 10:30 PM, Eric Sandeen wrote:
>>>
>>>> That's an odd failure; I wrote the test for upstream...
>>>>
>>>> On that kernel, despite free inodes:
>>>>
>>>> # df -i /mnt/scratch
>>>> Filesystem     Inodes IUsed IFree IUse% Mounted on
>>>> /dev/loop1      10260   490  9770    5% /mnt/scratch
>>>>
>>>> and xfs_db concurs (more or less?):
>>>>
>>>> icount =3D 10240
>>>> ifree =3D 9750
>>>>
>>>> creating a new inode fails:
>>>>
>>>> # touch /mnt/scratch/testdir/12345678901234567890169
>>>> touch: cannot touch =E2=80=98/mnt/scratch/testdir/123456789012345678=
90169=E2=80=99: No space left on device
>>>>
>>>> Everything about the fs looks the same as if we run it upstream, inc=
luding
>>>> the reserved blocks:
>>>>
>>>> reserved blocks =3D 6553
>>>> available reserved blocks =3D 6553
>>>>
>>>> But, it's failing to allocate the space:
>>>>
>>>>             touch-12302 [005] d... 118038.499302: ret_xfs_mod_fdbloc=
ks: (xfs_trans_reserve+0x123/0x200 [xfs]<- xfs_mod_fdblocks) arg1=3D0xfff=
fffe4
>>>>
>>>> (arg1 is the return value, -ENOSPC)
>>>>
>>>> It's not clear to me at this point why we can't create another inode=
 on this fs.
>>> Ugh, I can't believe I missed this - I actually didn't do anything to=
 ensure that
>>> there is free space to grow the actual directory into.
>>>
>>> If I add this just prior to the last 1300-file touch loop:
>>>
>>> ./src/punch-alternating $SCRATCH_MNT/spacefile1>>  $seqres.full 2>&1
>>>
>>> that seems to let the test proceed w/o ENOSPC, and properly fragment =
the
>>> dir.
>>>
>>> (OTOH upstream, now the test is reporting fs corruption, though I don=
't
>>> see it after the test completes.  Very confused now.  It might be
>>> confusing xfs_check?  Repair is happy...)
>>>
>>> I'm still not sure why the rhel kernel differs from upstream, though.
>> The more I look at this, the more I realize how fragile the test is.  =
It's
>> trying to control allocation, which is almost nearly impossible to do
>> reliably in a test.
>>
>> I'm not quite sure how to make this one better...
> Hi Eric
>=20
> Sorry for the late reply.
>=20
> Firstly, The following command works abnormally on RHEL7.3 and RHEL7.4.
> dd conv=3Dfsync if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile2 bs=3D1M cou=
nt=3D64
>=20
> If bs is set to 1M and the remaining freespace is less than 1M, dd coul=
d not write any data
> into spacefile2.  However, it still writes data into spacefile2 and lea=
ds that there is no
> enough free space to grow the actual directory.
>=20
> Secondly, I tested this case with upstream kernel in RHEL7.3 on virtual=
 machine, but i awlays don't
> trigger this bug.  Is there some specific settings?
>=20
> Could we use the following command to consume a lot of remaining free s=
pace, but reserve
> some free space to create the last 1300-file:
> dd conv=3Dfsync if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile2 bs=3D1K cou=
nt=3D35000
>=20
> I am not sure if this change can still trigger kernel bug.  :-)

Honestly, I think this test should probably be removed.  It's trying too =
hard to
control allocation behavior, which is not possible in general.

The only other approach I can think of is to create a lot of one-block fi=
les,
map them all, and then decide which ones to remove (or perhaps better, tr=
uncate to
0 length) in an effort to create perfectly fragmented freespace.  At leas=
t that
way we would not be trying control or expect allocation patterns ahead of=
 time.

-Eric
