Received: from cn.fujitsu.com ([59.151.112.132]:49084 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752140AbdFOIMU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Jun 2017 04:12:20 -0400
Message-ID: <59424158.3040401@cn.fujitsu.com>
Date: Thu, 15 Jun 2017 16:12:08 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH V2] xfs/289: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net> <fbad53d8-9807-1912-c3e4-e932020c19d3@sandeen.net> <591E5BEB.5070008@cn.fujitsu.com> <a511db57-db7f-6a7c-39ea-e6d3b003970c@sandeen.net> <9940cc65-677e-eeac-7a7c-ec3ba5ef2db4@sandeen.net> <35eca5c0-1cab-e27c-f5e5-a35a30530c85@sandeen.net>
In-Reply-To: <35eca5c0-1cab-e27c-f5e5-a35a30530c85@sandeen.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

On 2017/05/20 10:25, Eric Sandeen wrote:
>
> On 5/19/17 11:39 AM, Eric Sandeen wrote:
>> On 5/18/17 10:30 PM, Eric Sandeen wrote:
>>
>>> That's an odd failure; I wrote the test for upstream...
>>>
>>> On that kernel, despite free inodes:
>>>
>>> # df -i /mnt/scratch
>>> Filesystem     Inodes IUsed IFree IUse% Mounted on
>>> /dev/loop1      10260   490  9770    5% /mnt/scratch
>>>
>>> and xfs_db concurs (more or less?):
>>>
>>> icount =3D 10240
>>> ifree =3D 9750
>>>
>>> creating a new inode fails:
>>>
>>> # touch /mnt/scratch/testdir/12345678901234567890169
>>> touch: cannot touch =E2=80=98/mnt/scratch/testdir/1234567890123456789=
0169=E2=80=99: No space left on device
>>>
>>> Everything about the fs looks the same as if we run it upstream, incl=
uding
>>> the reserved blocks:
>>>
>>> reserved blocks =3D 6553
>>> available reserved blocks =3D 6553
>>>
>>> But, it's failing to allocate the space:
>>>
>>>             touch-12302 [005] d... 118038.499302: ret_xfs_mod_fdblock=
s: (xfs_trans_reserve+0x123/0x200 [xfs]<- xfs_mod_fdblocks) arg1=3D0xffff=
ffe4
>>>
>>> (arg1 is the return value, -ENOSPC)
>>>
>>> It's not clear to me at this point why we can't create another inode =
on this fs.
>> Ugh, I can't believe I missed this - I actually didn't do anything to =
ensure that
>> there is free space to grow the actual directory into.
>>
>> If I add this just prior to the last 1300-file touch loop:
>>
>> ./src/punch-alternating $SCRATCH_MNT/spacefile1>>  $seqres.full 2>&1
>>
>> that seems to let the test proceed w/o ENOSPC, and properly fragment t=
he
>> dir.
>>
>> (OTOH upstream, now the test is reporting fs corruption, though I don'=
t
>> see it after the test completes.  Very confused now.  It might be
>> confusing xfs_check?  Repair is happy...)
>>
>> I'm still not sure why the rhel kernel differs from upstream, though.
> The more I look at this, the more I realize how fragile the test is.  I=
t's
> trying to control allocation, which is almost nearly impossible to do
> reliably in a test.
>
> I'm not quite sure how to make this one better...
Hi Eric

Sorry for the late reply.

Firstly, The following command works abnormally on RHEL7.3 and RHEL7.4.
dd conv=3Dfsync if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile2 bs=3D1M count=
=3D64

If bs is set to 1M and the remaining freespace is less than 1M, dd could =
not write any data
into spacefile2.  However, it still writes data into spacefile2 and leads=
 that there is no
enough free space to grow the actual directory.

Secondly, I tested this case with upstream kernel in RHEL7.3 on virtual m=
achine, but i awlays don't
trigger this bug.  Is there some specific settings?

Could we use the following command to consume a lot of remaining free spa=
ce, but reserve
some free space to create the last 1300-file:
dd conv=3Dfsync if=3D/dev/zero of=3D$SCRATCH_MNT/spacefile2 bs=3D1K count=
=3D35000

I am not sure if this change can still trigger kernel bug.  :-)

Thanks
Xiao Yang.
> -Eric
>
>
> .
>



