Received: from sandeen.net ([63.231.237.45]:48316 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbdESDa1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 May 2017 23:30:27 -0400
Subject: Re: [PATCH V2] xfs/289: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
 <fbad53d8-9807-1912-c3e4-e932020c19d3@sandeen.net>
 <591E5BEB.5070008@cn.fujitsu.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <a511db57-db7f-6a7c-39ea-e6d3b003970c@sandeen.net>
Date: Thu, 18 May 2017 22:30:25 -0500
MIME-Version: 1.0
In-Reply-To: <591E5BEB.5070008@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Xiao Yang <yangx.jy@cn.fujitsu.com>, Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>



On 5/18/17 9:43 PM, Xiao Yang wrote:
> Hi Eric and Eryu
>=20
> I tested it on RHE7.3GA and RHEL7.4Alpha=EF=BC=8C i got ENOSPC error in=
stead of hang.  Is it expected behavior?
>=20
> Please see the following detailed message:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> [root@RHEL7U4Alpha_Intel64 xfstests]# ./check xfs/294
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 RHEL7U4Alpha_Intel64 3.10.0-657.el7.x86_6=
4
> MKFS_OPTIONS  -- -f -bsize=3D4096 /dev/sda11
> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sda11 /m=
nt/xfstests/scratch
>=20
> xfs/294 10s ... - output mismatch (see /var/lib/xfstests/results//xfs/2=
94.out.bad)
>     --- tests/xfs/294.out    2017-05-19 10:39:31.798010275 +0800
>     +++ /var/lib/xfstests/results//xfs/294.out.bad    2017-05-19 10:40:=
02.112008755 +0800
>     @@ -1,2 +1,1234 @@
>      QA output created by 294
>     -23accd029fad51ec02e4ec1f24799878  -
>     +touch: cannot touch '/mnt/xfstests/scratch/testdir/123456789012345=
67890169': No space left on device
>     +touch: cannot touch '/mnt/xfstests/scratch/testdir/123456789012345=
67890170': No space left on device
>     +touch: cannot touch '/mnt/xfstests/scratch/testdir/123456789012345=
67890171': No space left on device
>     +touch: cannot touch '/mnt/xfstests/scratch/testdir/123456789012345=
67890172': No space left on device
>     +touch: cannot touch '/mnt/xfstests/scratch/testdir/123456789012345=
67890173': No space left on device
>     ...
>     (Run 'diff -u tests/xfs/294.out /var/lib/xfstests/results//xfs/294.=
out.bad'  to see the entire diff)

That's an odd failure; I wrote the test for upstream...

On that kernel, despite free inodes:

# df -i /mnt/scratch
Filesystem     Inodes IUsed IFree IUse% Mounted on
/dev/loop1      10260   490  9770    5% /mnt/scratch

and xfs_db concurs (more or less?):

icount =3D 10240
ifree =3D 9750

creating a new inode fails:

# touch /mnt/scratch/testdir/12345678901234567890169
touch: cannot touch =E2=80=98/mnt/scratch/testdir/12345678901234567890169=
=E2=80=99: No space left on device

Everything about the fs looks the same as if we run it upstream, includin=
g
the reserved blocks:

reserved blocks =3D 6553
available reserved blocks =3D 6553

But, it's failing to allocate the space:

           touch-12302 [005] d... 118038.499302: ret_xfs_mod_fdblocks: (x=
fs_trans_reserve+0x123/0x200 [xfs] <- xfs_mod_fdblocks) arg1=3D0xffffffe4

(arg1 is the return value, -ENOSPC)

It's not clear to me at this point why we can't create another inode on t=
his fs.

-Eric

