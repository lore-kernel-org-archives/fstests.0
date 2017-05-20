Received: from sandeen.net ([63.231.237.45]:45168 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbdETCZU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 19 May 2017 22:25:20 -0400
Subject: Re: [PATCH V2] xfs/289: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
 <fbad53d8-9807-1912-c3e4-e932020c19d3@sandeen.net>
 <591E5BEB.5070008@cn.fujitsu.com>
 <a511db57-db7f-6a7c-39ea-e6d3b003970c@sandeen.net>
 <9940cc65-677e-eeac-7a7c-ec3ba5ef2db4@sandeen.net>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <35eca5c0-1cab-e27c-f5e5-a35a30530c85@sandeen.net>
Date: Fri, 19 May 2017 21:25:18 -0500
MIME-Version: 1.0
In-Reply-To: <9940cc65-677e-eeac-7a7c-ec3ba5ef2db4@sandeen.net>
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Xiao Yang <yangx.jy@cn.fujitsu.com>, Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>



On 5/19/17 11:39 AM, Eric Sandeen wrote:
> On 5/18/17 10:30 PM, Eric Sandeen wrote:
>=20
>>
>> That's an odd failure; I wrote the test for upstream...
>>
>> On that kernel, despite free inodes:
>>
>> # df -i /mnt/scratch
>> Filesystem     Inodes IUsed IFree IUse% Mounted on
>> /dev/loop1      10260   490  9770    5% /mnt/scratch
>>
>> and xfs_db concurs (more or less?):
>>
>> icount =3D 10240
>> ifree =3D 9750
>>
>> creating a new inode fails:
>>
>> # touch /mnt/scratch/testdir/12345678901234567890169
>> touch: cannot touch =E2=80=98/mnt/scratch/testdir/12345678901234567890=
169=E2=80=99: No space left on device
>>
>> Everything about the fs looks the same as if we run it upstream, inclu=
ding
>> the reserved blocks:
>>
>> reserved blocks =3D 6553
>> available reserved blocks =3D 6553
>>
>> But, it's failing to allocate the space:
>>
>>            touch-12302 [005] d... 118038.499302: ret_xfs_mod_fdblocks:=
 (xfs_trans_reserve+0x123/0x200 [xfs] <- xfs_mod_fdblocks) arg1=3D0xfffff=
fe4
>>
>> (arg1 is the return value, -ENOSPC)
>>
>> It's not clear to me at this point why we can't create another inode o=
n this fs.
>=20
> Ugh, I can't believe I missed this - I actually didn't do anything to e=
nsure that
> there is free space to grow the actual directory into.
>=20
> If I add this just prior to the last 1300-file touch loop:
>=20
> ./src/punch-alternating $SCRATCH_MNT/spacefile1 >> $seqres.full 2>&1
>=20
> that seems to let the test proceed w/o ENOSPC, and properly fragment th=
e
> dir.
>=20
> (OTOH upstream, now the test is reporting fs corruption, though I don't
> see it after the test completes.  Very confused now.  It might be
> confusing xfs_check?  Repair is happy...)
>=20
> I'm still not sure why the rhel kernel differs from upstream, though.

The more I look at this, the more I realize how fragile the test is.  It'=
s
trying to control allocation, which is almost nearly impossible to do
reliably in a test.

I'm not quite sure how to make this one better...

-Eric
