Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:50050 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755170AbaFRBSa (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 17 Jun 2014 21:18:30 -0400
Date: Wed, 18 Jun 2014 11:18:26 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to c728752
Message-ID: <20140618011826.GA4453@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ReaqsoxgOBHFXBhH
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

c728752 generic/317,318: fail gracefully if userns not supported

New Commits:

Brian Foster (3):
      [c1ff85d] xfs/013: allow non-write fsstress operations in background =
workload
      [34ff5cd] xfstests: test speculative preallocation reclaim on ENOSPC/=
EDQUOT
      [f170290] xfstests: create a test for xfs log grant head leak detecti=
on

David Disseldorp (2):
      [c79bb5c] src/cloner: check filesystem type
      [f8c880d] src/cloner: add CIFS_IOC_COPYCHUNK_FILE support

Eric Sandeen (2):
      [bbe5d55] xfs/279: use MKFS_XFS_PROG, not hardcoded path
      [c728752] generic/317,318: fail gracefully if userns not supported

Eryu Guan (1):
      [76d0cfb] generic: new case to test getcwd(2)

Filipe David Borba Manana (2):
      [36271c9] btrfs: add test for btrfs cloning with file holes
      [7b564f3] btrfs: add test for btrfs clone + fsync durability

Jeff Moyer (1):
      [28f8c4c] resvtest.c: fix invalid use of sizeof()

Michael L. Semon (1):
      [c8dc487] JFS: Add maximum ACL count into common/attr


Code Diffstat:

 .gitignore            |   1 +
 common/attr           |   3 +
 common/rc             |  48 +++++++
 configure.ac          |   1 +
 src/Makefile          |   2 +-
 src/cloner.c          | 123 ++++++++++++++++--
 src/resvtest.c        |   8 +-
 src/t_getcwd.c        | 102 +++++++++++++++
 tests/btrfs/055       | 165 ++++++++++++++++++++++++
 tests/btrfs/055.out   | 347 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/btrfs/056       | 145 +++++++++++++++++++++
 tests/btrfs/056.out   | 129 +++++++++++++++++++
 tests/btrfs/group     |   2 +
 tests/generic/028     |  58 +++++++++
 tests/generic/028.out |   2 +
 tests/generic/317     |   2 +-
 tests/generic/318     |   3 +-
 tests/generic/group   |   1 +
 tests/xfs/011         | 116 +++++++++++++++++
 tests/xfs/011.out     |   2 +
 tests/xfs/013         |   2 +-
 tests/xfs/014         | 200 +++++++++++++++++++++++++++++
 tests/xfs/014.out     |   2 +
 tests/xfs/279         |   2 +-
 tests/xfs/group       |   2 +
 25 files changed, 1448 insertions(+), 20 deletions(-)
 create mode 100644 src/t_getcwd.c
 create mode 100755 tests/btrfs/055
 create mode 100644 tests/btrfs/055.out
 create mode 100755 tests/btrfs/056
 create mode 100644 tests/btrfs/056.out
 create mode 100755 tests/generic/028
 create mode 100644 tests/generic/028.out
 create mode 100755 tests/xfs/011
 create mode 100644 tests/xfs/011.out
 create mode 100755 tests/xfs/014
 create mode 100644 tests/xfs/014.out
--=20
Dave Chinner
david@fromorbit.com

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJToOjhAAoJEK3oKUf0dfoduTkQAMt14USQuwz6xGIK5SVo3hfK
AMf0SlWz1MQyVchXgTlWj8Pj5KJcp9ZPH4+k5oY7DaCa2L72xuzm/COYhGWtuyvo
aE3pBbfoQ68SdVYao3Y0X7gnQCIbAeUF0NeTYkxQEnYBnqBKaylRKB0rQGg46Usy
xmXocEjgbaNEUG0KTVzh5gXyIBjUs65O1b/EKyMxJFO5eapldzFrYtYM2+iOpzsm
fKs/cFC993fC2dIjuwR54nQvYgdeE0axc8lKNFBUF8Rqq8RxnMnpqR9zriEjyBB7
QwXzIvy9co9PPZ8IzEikecjhhGDnVJlyLCkozj2QK3E2yx/k0HpIY71tLvHwiuV3
NrMcwBpe6hnbpKJ1NIH6WpsRnOOV6uGvZ/NSHe8T7F2AQ569rVitIQmFhiLp8ml2
mKbv28zMrq3S06Z3r0iZI5mHs0brCBZCfAgl6nRcon4SYMxyxQBCJPZc4mQMN1x0
Ssg4meK3QRX47FRx9T8TBiV1S/QawgzBQBGglgbDFpYeW6VamFGJ9MDODDr+w4+c
i3hvrEE3Go/Fceelv2Dbblc+Yc9pDPxrxlqeU4j3o+7BFO0vlDveOBnyRPrTqasE
hz8LtEbFEtMX5xxqil/WObX2Asbr7/QlmcKi7eL79mlIGK4ASf4734kZ7PQ3Ryaf
+ANCW1KpbiQZfOQt7hdX
=zBK4
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
