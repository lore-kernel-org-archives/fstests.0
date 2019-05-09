Received: from aserp2130.oracle.com ([141.146.126.79]:37084 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEIB4c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 May 2019 21:56:32 -0400
Date: Wed, 8 May 2019 18:54:24 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [Fail] generic/530 check failed on overlay
Message-ID: <20190509015424.GA5352@magnolia>
References: <6f12fb93-59b8-ac1e-f182-e4340ede64a2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6f12fb93-59b8-ac1e-f182-e4340ede64a2@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: JeffleXu <jefflexu@linux.alibaba.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

On Wed, May 08, 2019 at 03:30:11PM +0800, JeffleXu wrote:
> When I run "./check -overlay generic/530", it failed with following log
>=20
>=20
> ```
>=20
> generic/530 1s ... - output mismatch (see
> /root/xfstests/results//generic/530.out.bad)
> =A0=A0=A0 --- tests/generic/530.out=A0=A0 2019-05-07 16:18:55.951796117=
 +0800
> =A0=A0=A0 +++ /root/xfstests/results//generic/530.out.bad 2019-05-08
> 14:55:30.976816701 +0800
> =A0=A0=A0 @@ -1,2 +1,3 @@
> =A0=A0=A0=A0 QA output created by 530
> =A0=A0=A0 +shutdown: Inappropriate ioctl for device

Odd... I would've thought the _require_scratch_shutdown would have
stopped this test?  What's the underlying filesystem?

--D

> =A0=A0=A0=A0 silence is golden
> =A0=A0=A0 ...
>=20
> ```
>=20
>=20
> xfstests version: 1.1.1.1
>=20
> kernel: linux 4.19
>=20
> the commit that imports generic/530: e6703b90
>=20
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3De67=
03b903a5025b3eccac758f5bdd8e847f62c39
>=20
>=20
>=20
> I find that the error is due to the following snippet in
> src/t_open_tmpfiles.c
>=20
>=20
> ```c
>=20
> ret =3D ioctl(min_fd, XFS_IOC_GOINGDOWN, &flag);
> if (ret) {
> =A0=A0=A0 perror("shutdown");
> =A0=A0=A0 exit(2);
> }
>=20
> ```
>=20
>=20
> XFS_IOC_GOINGDOWN is specifically defined in XFS filesystem, while it i=
s not
>=20
> supported in overlay filesystem.
>=20
>=20
> In my understanding, test cases in "tests/generic" should be generic fo=
r all
>=20
> filesystem types, and the XFS_IOC_GOINGDOWN macro used by generic/530 i=
s
>=20
> obviously against this rule. Or maybe I missed something important and =
would
>=20
> approciate if someone could give me some indication.
>=20
>=20
> thx
>=20
