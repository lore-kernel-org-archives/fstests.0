Received: from mx1.redhat.com ([209.132.183.28]:44528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbdBUFXf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Feb 2017 00:23:35 -0500
Date: Tue, 21 Feb 2017 13:23:33 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [xfstests v3 0/8] bunch of overlay tests
Message-ID: <20170221052333.GO24562@eguan.usersys.redhat.com>
References: <1487580524-21503-1-git-send-email-xzhou@redhat.com>
 <CAOQ4uxhzYPkp3YHEuGHrvQ8+0SCmQuiXDO=2osOAga2NEWeZUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhzYPkp3YHEuGHrvQ8+0SCmQuiXDO=2osOAga2NEWeZUw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, linux-unionfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 20, 2017 at 01:37:57PM +0200, Amir Goldstein wrote:
> On my mobile email client so can't post to the list, but ACK on the ser=
ies.

Thanks for the review! I'll give them some test runs and queue them in
stage tree.

Thanks,
Eryu

>=20
> Cheers,
> Amir.
>=20
> On Feb 20, 2017 9:49 AM, "Xiong Zhou" <xzhou@redhat.com> wrote:
>=20
>     v3:
>     =C2=A0 cc linux-unionfs
>     =C2=A0 rm -rf $tmp in cleanup
>     =C2=A0 checking exact errno in set/getfattr case
>     =C2=A0 sleep less in flock case
>=20
>     Xiong Zhou (8):
>     =C2=A0 overlay: disallow overlayfs as upperdir
>     =C2=A0 overlay: work dir in overlay inherits no ACLs
>     =C2=A0 overlay: test workdir cleanup in mounting
>     =C2=A0 overlay: permission check with cached acls in tmpfs
>     =C2=A0 overlay: filter out xattr starts with "trusted.overlay."
>     =C2=A0 overlay: can not change underlying immutable file
>     =C2=A0 overlay: test flock after copied up
>     =C2=A0 overlay: accessing stacked overlayfs files
>=20
>     =C2=A0tests/overlay/022=C2=A0 =C2=A0 =C2=A0|=C2=A0 82 +++++++++++++=
++++++++++++++++++++++++++++
>     =C2=A0tests/overlay/022.out |=C2=A0 =C2=A02 +
>     =C2=A0tests/overlay/023=C2=A0 =C2=A0 =C2=A0|=C2=A0 81 +++++++++++++=
+++++++++++++++++++++++++++
>     =C2=A0tests/overlay/023.out |=C2=A0 =C2=A08 ++++
>     =C2=A0tests/overlay/024=C2=A0 =C2=A0 =C2=A0|=C2=A0 80 +++++++++++++=
+++++++++++++++++++++++++++
>     =C2=A0tests/overlay/024.out |=C2=A0 =C2=A02 +
>     =C2=A0tests/overlay/025=C2=A0 =C2=A0 =C2=A0|=C2=A0 85 +++++++++++++=
+++++++++++++++++++++++++++++
>     =C2=A0tests/overlay/025.out |=C2=A0 =C2=A02 +
>     =C2=A0tests/overlay/026=C2=A0 =C2=A0 =C2=A0|=C2=A0 99 +++++++++++++=
+++++++++++++++++
>     +++++++++++++++++++
>     =C2=A0tests/overlay/026.out |=C2=A0 =C2=A05 +++
>     =C2=A0tests/overlay/027=C2=A0 =C2=A0 =C2=A0|=C2=A0 87 +++++++++++++=
++++++++++++++++++++++++++++++
>     =C2=A0tests/overlay/027.out |=C2=A0 =C2=A02 +
>     =C2=A0tests/overlay/028=C2=A0 =C2=A0 =C2=A0|=C2=A0 80 +++++++++++++=
+++++++++++++++++++++++++++
>     =C2=A0tests/overlay/028.out |=C2=A0 =C2=A02 +
>     =C2=A0tests/overlay/029=C2=A0 =C2=A0 =C2=A0| 100 ++++++++++++++++++=
++++++++++++
>     ++++++++++++++++++++
>     =C2=A0tests/overlay/029.out |=C2=A0 =C2=A05 +++
>     =C2=A0tests/overlay/group=C2=A0 =C2=A0|=C2=A0 =C2=A08 ++++
>     =C2=A017 files changed, 730 insertions(+)
>     =C2=A0create mode 100755 tests/overlay/022
>     =C2=A0create mode 100644 tests/overlay/022.out
>     =C2=A0create mode 100755 tests/overlay/023
>     =C2=A0create mode 100644 tests/overlay/023.out
>     =C2=A0create mode 100755 tests/overlay/024
>     =C2=A0create mode 100644 tests/overlay/024.out
>     =C2=A0create mode 100755 tests/overlay/025
>     =C2=A0create mode 100644 tests/overlay/025.out
>     =C2=A0create mode 100755 tests/overlay/026
>     =C2=A0create mode 100644 tests/overlay/026.out
>     =C2=A0create mode 100755 tests/overlay/027
>     =C2=A0create mode 100644 tests/overlay/027.out
>     =C2=A0create mode 100755 tests/overlay/028
>     =C2=A0create mode 100644 tests/overlay/028.out
>     =C2=A0create mode 100755 tests/overlay/029
>     =C2=A0create mode 100644 tests/overlay/029.out
>=20
>     --
>     1.8.3.1
>=20
>     --
>     To unsubscribe from this list: send the line "unsubscribe fstests" =
in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.=
html
>=20
