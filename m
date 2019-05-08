From: JeffleXu <jefflexu@linux.alibaba.com>
Subject: [Fail] generic/530 check failed on overlay
Message-ID: <6f12fb93-59b8-ac1e-f182-e4340ede64a2@linux.alibaba.com>
Date: Wed, 8 May 2019 15:30:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

When I run "./check -overlay generic/530", it failed with following log


```

generic/530 1s ... - output mismatch (see=20
/root/xfstests/results//generic/530.out.bad)
 =C2=A0=C2=A0=C2=A0 --- tests/generic/530.out=C2=A0=C2=A0 2019-05-07 16:1=
8:55.951796117 +0800
 =C2=A0=C2=A0=C2=A0 +++ /root/xfstests/results//generic/530.out.bad 2019-=
05-08=20
14:55:30.976816701 +0800
 =C2=A0=C2=A0=C2=A0 @@ -1,2 +1,3 @@
 =C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 530
 =C2=A0=C2=A0=C2=A0 +shutdown: Inappropriate ioctl for device
 =C2=A0=C2=A0=C2=A0=C2=A0 silence is golden
 =C2=A0=C2=A0=C2=A0 ...

```


xfstests version: 1.1.1.1

kernel: linux 4.19

the commit that imports generic/530: e6703b90

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3De6703=
b903a5025b3eccac758f5bdd8e847f62c39



I find that the error is due to the following snippet in=20
src/t_open_tmpfiles.c


```c

ret =3D ioctl(min_fd, XFS_IOC_GOINGDOWN, &flag);
if (ret) {
 =C2=A0=C2=A0=C2=A0 perror("shutdown");
 =C2=A0=C2=A0=C2=A0 exit(2);
}

```


XFS_IOC_GOINGDOWN is specifically defined in XFS filesystem, while it is=20
not

supported in overlay filesystem.


In my understanding, test cases in "tests/generic" should be generic for=20
all

filesystem types, and the XFS_IOC_GOINGDOWN macro used by generic/530 is

obviously against this rule. Or maybe I missed something important and=20
would

approciate if someone could give me some indication.


thx
