Received: from mail-pf1-f193.google.com ([209.85.210.193]:41820 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaQlx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 31 Aug 2018 12:41:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so5470001pfk.8
        for <fstests@vger.kernel.org>; Fri, 31 Aug 2018 05:34:35 -0700 (PDT)
Date: Fri, 31 Aug 2018 20:34:28 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: generic/482: always failed with xfs
Message-ID: <20180831123415.GE3651@desktop>
References: <d0a6d7b6-12dd-14eb-07d9-2ff28cb2af52@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0a6d7b6-12dd-14eb-07d9-2ff28cb2af52@intel.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Dai, XiangX" <xiangx.dai@intel.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 31, 2018 at 04:40:59PM +0800, Dai, XiangX wrote:
> generic/482 is unstable when we run it with xfs (it runs well with othe=
r fs
> type)
>=20
> run 10 times, failed 6 times
> ------
> generic/482=C2=A0=C2=A0=C2=A0 [failed, exit status 1]- output mismatch =
(see
> /lkp/benchmarks/xfstests/results//generic/482.out.bad)
> =C2=A0=C2=A0=C2=A0 --- tests/generic/482.out=C2=A0=C2=A0=C2=A0 2018-07-=
09 10:39:04.000000000 +0000
> =C2=A0=C2=A0=C2=A0 +++ /lkp/benchmarks/xfstests/results//generic/482.ou=
t.bad 2018-08-16
> 14:38:22.306000000 +0000
> =C2=A0=C2=A0=C2=A0 @@ -1,2 +1,3 @@
> =C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 482
> =C2=A0=C2=A0=C2=A0 -Silence is golden
> =C2=A0=C2=A0=C2=A0 +_check_xfs_filesystem: filesystem on /dev/vdd is in=
consistent (r)
> =C2=A0=C2=A0=C2=A0 +(see /lkp/benchmarks/xfstests/results//generic/482.=
full for details)
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 (Run 'diff -u tests/generic/482.out
> /lkp/benchmarks/xfstests/results//generic/482.out.bad'=C2=A0 to see the=
 entire
> diff)
>=20
> ------
> 482.full
> ------
> # ./ltp/fsstress -w -d /fs/scratch -n 512 -p 4
> seed =3D 1534216816
> mark mkfs has entry number 624
> next fua is entry number 674
> =3D=3D=3D replay to 674 =3D=3D=3D
> _check_xfs_filesystem: filesystem on /dev/vdd is inconsistent (r)
> *** xfs_repair -n output ***
> Phase 1 - find and verify superblock...
> Phase 2 - using internal log
>         - zero log...
>         - scan filesystem freespace and inode maps...
>         - found root inode chunk
> Phase 3 - for each AG...
>         - scan (but don't clear) agi unlinked lists...
>         - process known inodes and perform inode discovery...
>         - agno =3D 0
>         - agno =3D 1
>         - agno =3D 2
> bad symlink header ino 268697729, file block 0, disk block 33587215
> problem with symbolic link in inode 268697729
> would have cleared inode 268697729
>         - agno =3D 3
>         - process newly discovered inodes...
> Phase 4 - check for duplicate blocks...
>         - setting up duplicate extent list...
>         - check for inodes claiming duplicate blocks...
>         - agno =3D 0
>         - agno =3D 1
>         - agno =3D 2
> entry "l6" in shortform directory 268697728 references free inode 26869=
7729
> would have junked entry "l6" in directory inode 268697728
>         - agno =3D 3
> bad symlink header ino 268697729, file block 0, disk block 33587215
> problem with symbolic link in inode 268697729
> would have cleared inode 268697729
> No modify flag set, skipping phase 5
> Phase 6 - check inode connectivity...
>         - traversing filesystem ...
> entry "l6" in shortform directory inode 268697728 points to free inode
> 268697729
> would junk entry
>         - traversal finished ...
>         - moving disconnected inodes to lost+found ...
> Phase 7 - verify link counts...
> Maximum metadata LSN (1:338) is ahead of log (1:41).

Yeah, it's known to fail on xfs since the test was merged. Dave
suspected it was a bug in log-dev[1], but there's no conclusion yet ..

Thanks,
Eryu

[1] https://patchwork.kernel.org/patch/10312149/#21674087

> Would format log to cycle 4.
> No modify flag set, skipping filesystem flush and exiting.
> *** end xfs_repair output
> *** mount output ***
> rootfs on / type rootfs (rw)
> sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
> proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
> devtmpfs on /dev type devtmpfs
> (rw,nosuid,size=3D1776968k,nr_inodes=3D444242,mode=3D755)
> securityfs on /sys/kernel/security type securityfs
> (rw,nosuid,nodev,noexec,relatime)
> selinuxfs on /sys/fs/selinux type selinuxfs (rw,relatime)
> tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
> devpts on /dev/pts type devpts
> (rw,nosuid,noexec,relatime,gid=3D5,mode=3D620,ptmxmode=3D000)
> tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=3D755)
> tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=3D5=
120k)
> tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=3D755)
> cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,re=
latime,xattr,release_agent=3D/lib/systemd/systemd-cgroups-agent,name=3Dsy=
stemd)
> pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
> cgroup on /sys/fs/cgroup/cpuset type cgroup
> (rw,nosuid,nodev,noexec,relatime,cpuset)
> cgroup on /sys/fs/cgroup/rdma type cgroup
> (rw,nosuid,nodev,noexec,relatime,rdma)
> cgroup on /sys/fs/cgroup/cpu type cgroup
> (rw,nosuid,nodev,noexec,relatime,cpu)
> cgroup on /sys/fs/cgroup/devices type cgroup
> (rw,nosuid,nodev,noexec,relatime,devices)
> cgroup on /sys/fs/cgroup/net_cls type cgroup
> (rw,nosuid,nodev,noexec,relatime,net_cls)
> cgroup on /sys/fs/cgroup/blkio type cgroup
> (rw,nosuid,nodev,noexec,relatime,blkio)
> cgroup on /sys/fs/cgroup/hugetlb type cgroup
> (rw,nosuid,nodev,noexec,relatime,hugetlb)
> cgroup on /sys/fs/cgroup/freezer type cgroup
> (rw,nosuid,nodev,noexec,relatime,freezer)
> cgroup on /sys/fs/cgroup/perf_event type cgroup
> (rw,nosuid,nodev,noexec,relatime,perf_event)
> cgroup on /sys/fs/cgroup/pids type cgroup
> (rw,nosuid,nodev,noexec,relatime,pids)
> cgroup on /sys/fs/cgroup/memory type cgroup
> (rw,nosuid,nodev,noexec,relatime,memory)
> mqueue on /dev/mqueue type mqueue (rw,relatime)
> hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=3D2M)
> debugfs on /sys/kernel/debug type debugfs (rw,relatime)
> sunrpc on /run/rpc_pipefs type rpc_pipefs (rw,relatime)
> systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=3D37,=
pgrp=3D1,timeout=3D0,minproto=3D5,maxproto=3D5,direct,pipe_ino=3D1500)
> configfs on /sys/kernel/config type configfs (rw,relatime)
> tmp on /tmp type tmpfs (rw,relatime)
> inn:/result on /inn/result type nfs (rw,relatime,vers=3D3,rsize=3D10485=
76,wsize=3D1048576,namlen=3D255,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,=
sec=3Dsys,mountaddr=3D192.168.1.1,mountvers=3D3,mountport=3D32955,mountpr=
oto=3Dudp,local_lock=3Dnone,addr=3D192.168.1.1)
> *** end mount output
> device-mapper: remove ioctl on logwrites-test failed: No such device or
> address
> Command failed
>=20
> ------
