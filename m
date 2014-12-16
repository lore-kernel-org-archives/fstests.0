Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:61528 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862AbaLPUqp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Dec 2014 15:46:45 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1Y0z0z-0005Yk-RP
	for fstests@vger.kernel.org; Wed, 17 Dec 2014 07:46:41 +1100
Date: Wed, 17 Dec 2014 07:46:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 46a0854
Message-ID: <20141216204641.GD15665@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

The new head of the master branch is commit:

46a0854 Check O_DIRECT support before testing direct I/O

New Commits:

David Disseldorp (1):
      [9809bd2] cifs: add missing Makefile

Dushan Tcholich (2):
      [01d42b7] common: unify _require_batched_discard
      [a540897] generic/038: require fallocate support

Eryu Guan (2):
      [6a923ff] btrfs: add groups for btrfs tests
      [f5b137b] generic/299: make sure fio really exits

Filipe Manana (2):
      [0cfb617] fstests: btrfs, add test for snapshoting after file write +=
 truncate
      [22fc64e] btrfs: add regression test for clone ioctl

Junho Ryu (1):
      [46a0854] Check O_DIRECT support before testing direct I/O

Theodore Ts'o (2):
      [a5a2db3] common: use mke2fs -F instead of piping in yes
      [ba3fc9f] ext4/308: require fallocate support


Code Diffstat:

 common/rc             |  31 +++++++-
 tests/btrfs/080       | 169 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/080.out   |   2 +
 tests/btrfs/081       | 135 ++++++++++++++++++++++++++++++++
 tests/btrfs/081.out   | 210 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/btrfs/group     | 112 ++++++++++++++-------------
 tests/cifs/Makefile   |  20 +++++
 tests/ext4/308        |   1 +
 tests/generic/038     |   3 +-
 tests/generic/091     |   1 +
 tests/generic/130     |   1 +
 tests/generic/133     |   1 +
 tests/generic/135     |   1 +
 tests/generic/226     |   1 +
 tests/generic/251     |   7 +-
 tests/generic/251.out |   1 -
 tests/generic/260     |   3 +-
 tests/generic/263     |   1 +
 tests/generic/288     |   3 +-
 tests/generic/299     |   5 +-
 tests/generic/300     |   1 +
 tests/generic/324     |   1 +
 22 files changed, 638 insertions(+), 72 deletions(-)
 create mode 100755 tests/btrfs/080
 create mode 100644 tests/btrfs/080.out
 create mode 100755 tests/btrfs/081
 create mode 100644 tests/btrfs/081.out
 create mode 100644 tests/cifs/Makefile
--=20
Dave Chinner
david@fromorbit.com

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUkJoxAAoJEK3oKUf0dfodx9EP/2Xq+N1lJA7Ac0+7DogJvX/9
csU6jmmv14CIvyPDFBJS6cNGm1y961MUtApz4Gp6V7dS0K8nRUpdIz8KMQD0W3WY
d8v62nH/RK24DGq9a0Mpg62g6tGsoF1A7spcN9ZGoWsqao6Uvr5Lh4axDUJtYMjK
YfnjitH8YslwomNeq7nYFOKTDcnAbgqGfYALdICXtOCCJT4GyWCtPflcE87Bj02m
EMB5ZzFLyaAl3QbN060ALwtE825oacHYVpuaKHb4Zpb1CpP8532i8ndn7x0HIx6h
Tqm+qvznCMtxDGSCjKRvyzsBEAyc9F2VskhTw+f9+rOjywhDFkO4ZGH+TKB4F5/p
vIFci3suRvgBrTzetPwexcuvRPZWwbw8e8tfMICqHU2Qgx6DpB0m/Dbo7nWiyeXI
fH/rCHodCd7pGqnZVY7l7vjeB486ToQn5jhFWBaDJnwGyL+ENJTyEdL60jATM6zx
3+3rROLWk4Ok67RUrDQPzS9V8mgQo6QmYvNFmvS7+VqgiWB7i8CgIS3ytY/uB7Qg
IJmzj8GDCZLXi9zUfXnqYamJ0rmYb3ye022m9KseKbNIs+pCb/sCwHaBiDMfMOxu
D/HCQmprZcio0E1AIiwlEGnYU4/aIjZXXHvx/Mo9o5/zzfeGTTD5e5v7BObwv18u
bA97KgWK5rChkv/mqJkC
=3/YO
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
