Received: from mail-io0-f177.google.com ([209.85.223.177]:33511 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbcGRMdt convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 18 Jul 2016 08:33:49 -0400
Received: by mail-io0-f177.google.com with SMTP id 38so157966259iol.0
        for <fstests@vger.kernel.org>; Mon, 18 Jul 2016 05:33:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACj3i71VOC8i_11hFn_fphsMfGqduHB6on5UawUHm6mtAaVRhQ@mail.gmail.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
 <1468500214-6237-7-git-send-email-jtulak@redhat.com> <20160716093358.GL2432@eguan.usersys.redhat.com>
 <20160717233003.GX1922@dastard> <CACj3i73TdnUcDT0J2QEBKQhoMsyYFVz6hBb_=bC99rL2ZbkCYQ@mail.gmail.com>
 <20160718114723.GG27776@eguan.usersys.redhat.com> <CACj3i71VOC8i_11hFn_fphsMfGqduHB6on5UawUHm6mtAaVRhQ@mail.gmail.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Mon, 18 Jul 2016 14:33:29 +0200
Message-ID: <CACj3i73hdbW4iAWufvxc_aJn1dj+UGzuud7Cj-qMiwe7aLeNxQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] xfstests: Add mkfs input validation tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, xfs-oss <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 18, 2016 at 1:54 PM, Jan Tulak <jtulak@redhat.com> wrote:
> On Mon, Jul 18, 2016 at 1:47 PM, Eryu Guan <eguan@redhat.com> wrote:
>> On Mon, Jul 18, 2016 at 01:29:47PM +0200, Jan Tulak wrote:
>>> On Mon, Jul 18, 2016 at 1:30 AM, Dave Chinner <david@fromorbit.com> w=
rote:
>>> > On Sat, Jul 16, 2016 at 05:33:58PM +0800, Eryu Guan wrote:
>>> >> On Thu, Jul 14, 2016 at 02:43:34PM +0200, Jan Tulak wrote:
>>> >> > +do_mkfs_fail -l lazy-count=3D1garbage $SCRATCH_DEV
>>> >> > +do_mkfs_fail -l lazy-count=3D2 $SCRATCH_DEV
>>> >> > +do_mkfs_fail -l lazy-count=3D0 -m crc=3D1 $SCRATCH_DEV
>>> >> > +do_mkfs_fail -l version=3D1 -m crc=3D1 $SCRATCH_DEV
>>> >>
>>> >> This test fails in my DAX testing, where SCRATCH_DEV is ramdisk. T=
he
>>> >> mkfs itself should fail, but it passed. Log version 2 was used
>>> >> automatically, instead of prompting "V2 logs always enabled for CR=
C
>>> >> enabled filesytems"
>>> >>
>>> >> [root@dhcp-66-86-11 xfstests]# mkfs -t xfs -f -l version=3D1 -m cr=
c=3D1 /dev/ram0
>>> >> meta-data=3D/dev/ram0              isize=3D512    agcount=3D1, ags=
ize=3D4096 blks
>>> >>          =3D                       sectsz=3D4096  attr=3D2, projid=
32bit=3D1
>>> >>          =3D                       crc=3D1        finobt=3D1, spar=
se=3D0
>>> >> data     =3D                       bsize=3D4096   blocks=3D4096, i=
maxpct=3D25
>>> >>          =3D                       sunit=3D0      swidth=3D0 blks
>>> >> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0 fty=
pe=3D1
>>> >> log      =3Dinternal log           bsize=3D4096   blocks=3D1605, v=
ersion=3D2
>>> >>          =3D                       sectsz=3D4096  sunit=3D1 blks, =
lazy-count=3D1
>>> >> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtex=
tents=3D0
>>> >>
>>> >> Is it a mkfs.xfs bug or the test case should handle the special ca=
se?
>>> >
>>> > Looks like it might be a side effect of using a 4k sector size. v1
>>> > logs only supported 512 byte sectors, so it's entirely possible tha=
t
>>> > the sector size is silently overriding the log version
>>> > specification. Probably should be fixed in mkfs.
>>> >
>>> >
>>>
>>> I tried to duplicate this, but in my config it didn't failed - how di=
d
>>> you create the ramdisk?
>>
>> I think you need to test on a 4k sector size disk. I use scsi_debug to
>> simulate physical 4k sector disk to reproduce this:
>>
>> [root@dhcp-66-86-11 xfsprogs-dev]# modprobe -r scsi_debug
>> [root@dhcp-66-86-11 xfsprogs-dev]# modprobe scsi_debug dev_size_mb=3D1=
28 physblk_exp=3D3
>> [root@dhcp-66-86-11 xfsprogs-dev]# blockdev --getbsz --getpbsz --getss=
 /dev/sdc
>> 4096
>> 4096
>> 512
>> [root@dhcp-66-86-11 xfsprogs-dev]# mkfs -t xfs -l version=3D1 -m crc=3D=
1 /dev/sdc
>> meta-data=3D/dev/sdc               isize=3D512    agcount=3D4, agsize=3D=
8192 blks
>>          =3D                       sectsz=3D4096  attr=3D2, projid32bi=
t=3D1
>>          =3D                       crc=3D1        finobt=3D1, sparse=3D=
0
>> data     =3D                       bsize=3D4096   blocks=3D32768, imax=
pct=3D25
>>          =3D                       sunit=3D0      swidth=3D0 blks
>> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0 ftype=3D=
1
>> log      =3Dinternal log           bsize=3D4096   blocks=3D1605, versi=
on=3D2
>>          =3D                       sectsz=3D4096  sunit=3D1 blks, lazy=
-count=3D1
>> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextent=
s=3D0
>>
>> If you remove the "physblk_exp=3D3" at modprobe time, mkfs failed as
>> expected.
>>
>
> Ah, thanks. :-) Now I can reproduce it and see what happens.

And the culprit is in mkfs, some forty lines before the crc & log version=
 check:

2026 =E2=87=A5       } else if (lsectorsize > XFS_MIN_SECTORSIZE && !lsu =
&& !lsunit) {
2027 =E2=87=A5       =E2=87=A5       lsu =3D blocksize;
2028 =E2=87=A5       =E2=87=A5       sb_feat.log_version =3D 2;
2029 =E2=87=A5       }

The possible solutions I can think of are:

1) Make a more complicated check.
This would change just a line or two, but most likely, we would test
the same thing multiple times and added unnecessary complexity.

2) Move the crc checks into an earlier place.
The only value that can be changed in crc checks from default is
finobt, and finobt is not read nor modified between argument parsing
and the crc check. This looks like a simple and safe thing, but it
will move some ~60 lines. I tested moving the crc testing block right
behind this:
1968 =E2=87=A5       memset(&ft, 0, sizeof(ft));
1969 =E2=87=A5       get_topology(&xi, &ft, force_overwrite);
And it works. I didn't run full test suite yet, though.

3) Change the silent autoupdating of log version. The default is 2 and
if user explicitly states v1, then we should either warn or fail
entirely if it is not possible to make such fs.

4) Do nothing with mkfs and instead, update the test to check the
sector size and expect pass/fail...

But this issue boils down to the question "what is the correct order
of doing things"? Should we try to autosolve what we can at first, and
check for remaining issues after that? Or should we check for issues
with the input ASAP, even if it can be solved by updating the input to
match the physical device? Right now, it looks like "someone wrote it
that way a long time ago" mix of both.

Your ideas, guys?

Thanks,
Jan

--=20
Jan Tulak
jtulak@redhat.com / jan@tulak.me
