Received: from mail-pg0-f47.google.com ([74.125.83.47]:36217 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdLXNuT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Dec 2017 08:50:19 -0500
Received: by mail-pg0-f47.google.com with SMTP id k134so16225085pga.3
        for <fstests@vger.kernel.org>; Sun, 24 Dec 2017 05:50:19 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id q24sm53245130pfk.168.2017.12.24.05.50.14
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Dec 2017 05:50:17 -0800 (PST)
Message-ID: <5a3fb099.9890620a.13e63.f98f@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 24 Dec 2017 21:50:03 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 39fa7d89bce5
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LvpI4AFsCuRT"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--LvpI4AFsCuRT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly picks up patches from Chengguang
that add shutdown support to overlayfs and a new syncfs(2) test using shutdown
to test an overlayfs bug. Other patches are random bug fixes. There're still
some pending patches from Darrick that need review & merge, hopefully I'll get
them done next week. (But again, no promise, I'm on PTO till 2018.)

Happy Holidays!

Thanks,
Eryu

The new head of the master branch is commit:

39fa7d89bce5 xfs/040: document purpose

New commits:

Ari Sundholm (2):
      [6db67b725296] fsstress: Eliminate valgrind noise
      [db71085194be] fsstress: getcwd() return value fixes

Chengguang Xu (3):
      [2b4eae7fd825] common/rc: add scratch shutdown support for overlayfs
      [c3594bec4e7f] common/rc: check syncfs support
      [0f2373e045cf] generic: add syncfs test

Luis R. Rodriguez (1):
      [39fa7d89bce5] xfs/040: document purpose


Code Diffstat:

 common/rc             | 44 ++++++++++++++++++++++++---
 ltp/fsstress.c        | 11 ++++++-
 tests/generic/042     |  1 +
 tests/generic/043     |  2 +-
 tests/generic/044     |  2 +-
 tests/generic/045     |  2 +-
 tests/generic/046     |  2 +-
 tests/generic/047     |  2 +-
 tests/generic/048     |  2 +-
 tests/generic/049     |  2 +-
 tests/generic/050     |  1 +
 tests/generic/051     |  2 +-
 tests/generic/052     |  2 +-
 tests/generic/054     |  2 +-
 tests/generic/055     |  2 +-
 tests/generic/388     |  3 +-
 tests/generic/392     |  2 +-
 tests/generic/417     |  2 +-
 tests/generic/461     |  2 +-
 tests/generic/468     |  2 +-
 tests/generic/474     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/474.out |  2 ++
 tests/generic/group   |  1 +
 tests/xfs/040         |  5 +++
 24 files changed, 161 insertions(+), 21 deletions(-)
--
Eryu Guan
eguan@redhat.com

--LvpI4AFsCuRT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaP7AuAAoJECZSqilcj+djqngP/jmMcpCx0+ZtNpLho4Wqpb/M
GcUeQk7EPb7lcRy+U0bBMGuBPa1muSwfqBV4+NkWDWgT2ET7JfoZbnZFzvqzJus7
MKaLAXAvNbwHbfIhFgvdiofoQ3Tkw5xxCDx5uIyT+mr+vMeR5HL+fMUe3+vEDIb2
CunmYk2mWCFWGYJeFrmeSYFiAql9AdV5mm2sP3YpP9xg5YrLPLxApjuC2FwE73lx
BobY9L58teYwb9lI9l4mTw+UEYjdvFNXImKZ7/hlf6lQidbjOwe/bYC9MYucW90i
BQJDt93QmxlrD0uwW4WwqhbRCoB0pQZHOC3Mx6UCZZCQ/4V38a53g6/qhbzLCewf
+pwfK3rqnPPlaQ4W3qlvcmMJvvtDuZjC/BpNVBqTmfRdDAcH4p0y741gIzHY+wyo
PPXGjcLLhcao614RxrHkiq+tyNF40S47VUeI/aaezjFAFrAsNn7TEFmEKD1Qqp7G
iuI8ZtJwATqo5RpnP3zRxn2OTzHF5Iz0iwkYdB/DmW0BK4eoQMuYfMH6qlyNQfpb
e0LReUqSbWPF/haeqHyKBiUpA82FEi9DMdlRgfOx+inO7rX4WGBheByxle8EtaCe
Jk4A7VNg6Ee92FOGa033MynGcuY/0etmXt54v75cHsv4YEAqMisE1j+X4i5+XPSr
4hbp1Ti6RL6/SSm6+0g+
=ezqz
-----END PGP SIGNATURE-----

--LvpI4AFsCuRT--
