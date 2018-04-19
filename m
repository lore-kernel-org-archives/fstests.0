Received: from mail.cn.fujitsu.com ([183.91.158.132]:14119 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754100AbeDTDTH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Apr 2018 23:19:07 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id E18DB4D0EFD1
        for <fstests@vger.kernel.org>; Fri, 20 Apr 2018 11:19:03 +0800 (CST)
From: lst <leist.fnst@cn.fujitsu.com>
Subject: the test xfs/191 need update now
Message-ID: <3b7d4e57-e66a-0b93-9592-30964cebe5d3@cn.fujitsu.com>
Date: Thu, 19 Apr 2018 19:19:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hi
I have some question about xfs/191.
It seems the usage of mkfs.xfs is update, but the test xfs/191 didn't=20
update timely.
For example: tests/xfs/191-input-validation
line 265:=C2=A0 do_mkfs_pass -n log=3D15 $SCRATCH_DEV
it will execute
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/mkfs.xfs -f -N -n log=3D15 $SCR=
ATCH_DEV
but there is no option "-n log" now.
---------------------------------------------------------
# /usr/sbin/mkfs.xfs -f -N -n log=3D15 /dev/vdd
unknown option -n log=3D15
Usage: mkfs.xfs
/* blocksize */=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [-b size=3Dnum]
/* metadata */=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [-m=20
crc=3D0|1,finobt=3D0|1,uuid=3Dxxx,rmapbt=3D0|1,reflink=3D0|1]
/* data subvol */=C2=A0=C2=A0=C2=A0 [-d agcount=3Dn,agsize=3Dn,file,name=3D=
xxx,size=3Dnum,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 (sunit=3Dvalue,swidth=3Dvalue|su=3Dnum,sw=3Dnum|noalign),
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 sectsize=3Dnum
/* force overwrite */=C2=A0=C2=A0=C2=A0 [-f]
/* inode size */=C2=A0=C2=A0=C2=A0 [-i log=3Dn|perblock=3Dn|size=3Dnum,ma=
xpct=3Dn,attr=3D0|1|2,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 projid32bit=3D0|1,sparse=3D0|1]
/* no discard */=C2=A0=C2=A0=C2=A0 [-K]
/* log subvol */=C2=A0=C2=A0=C2=A0 [-l agnum=3Dn,internal,size=3Dnum,logd=
ev=3Dxxx,version=3Dn
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 sunit=3Dvalue|su=3Dnum,sectsize=3Dnum,lazy-count=3D0|1]
/* label */=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [-L label (maximum 12 ch=
aracters)]
/* naming */=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [-n size=3Dnum,version=3D=
2|ci,ftype=3D0|1]
/* no-op info only */=C2=A0=C2=A0=C2=A0 [-N]
/* prototype file */=C2=A0=C2=A0=C2=A0 [-p fname]
/* quiet */=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [-q]
/* realtime subvol */=C2=A0=C2=A0=C2=A0 [-r extsize=3Dnum,size=3Dnum,rtde=
v=3Dxxx]
/* sectorsize */=C2=A0=C2=A0=C2=A0 [-s size=3Dnum]
/* version */=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 [-V]
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 devicename
<devicename> is required unless -d name=3Dxxx is given.
<num> is xxx (bytes), xxxs (sectors), xxxb (fs blocks), xxxk (xxx KiB),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xxxm (xxx MiB), xxxg (xxx GiB), xxxt (xxx=
 TiB) or xxxp (xxx PiB).
<value> is xxx (512 byte blocks).
---------------------------------------------------------
And also have other cases which were expected fail but pass now.
Here I paste 10 cases which reprot error at my environment.
-------------------
do_mkfs_fail -n size=3D2b $SCRATCH_DEV
do_mkfs_fail -d agsize=3D8192b $SCRATCH_DEV
do_mkfs_fail -d agsize=3D65536s $SCRATCH_DEV
do_mkfs_fail -d sunit=3D0,swidth=3D64 $SCRATCH_DEV
do_mkfs_fail -d su=3D0,sw=3D64 $SCRATCH_DEV
do_mkfs_fail -d su=3D4096s,sw=3D64 $SCRATCH_DEV
do_mkfs_fail -d su=3D4096b,sw=3D64 $SCRATCH_DEV
do_mkfs_fail -l su=3D10b $SCRATCH_DEV
do_mkfs_pass -n log=3D15 $SCRATCH_DEV
do_mkfs_pass -i log=3D10 $SCRATCH_DEV
-------------------

Can you update this case according to the current version of mkfs.xfs?


thanks,

 =C2=A0=C2=A0=C2=A0=C2=A0 Shaoting Lei




