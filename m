Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:5963 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752244AbbBYEo5 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Feb 2015 23:44:57 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1YQTpJ-0005Zb-9S
	for fstests@vger.kernel.org; Wed, 25 Feb 2015 15:44:01 +1100
Date: Wed, 25 Feb 2015 15:44:01 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to e020a49
Message-ID: <20150225044401.GC18360@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--+HP7ph2BbKc20aGI
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

e020a49 fstests: generic test for fsync after removing xattrs

New Commits:

Chandan Rajendra (1):
      [1310589] generic/325: Fix test case to work on 64K page size.

Eric Sandeen (2):
      [6f6c471] btrfs/049: btrfs test, not generic
      [68d3b93] create _require_metadata_journaling, and add to tests that =
need it

Filipe Manana (2):
      [036a163] fstests: generic test for directory fsync after adding hard=
 links
      [e020a49] fstests: generic test for fsync after removing xattrs

Namjae Jeon (7):
      [520b9de] generic: Simple insert range tests
      [abe1802] generic: Delayed allocation insert range
      [045d133] generic: Multi insert range tests
      [e3b6221] generic: Delayed allocation multi insert
      [91843cb] generic: Test multiple fallocate insert/collapse range calls
      [6e5194d] fsstress: Add fallocate insert range operation
      [788b134] fsx: Add fallocate insert range operation

Omar Sandoval (1):
      [cd21040] build: add missing files to gitignore


Code Diffstat:

 .gitignore            |   7 ++
 common/punch          |   5 ++
 common/rc             |  34 +++++++++-
 ltp/fsstress.c        |  19 +++++-
 ltp/fsx.c             | 124 +++++++++++++++++++++++++++++++++---
 src/global.h          |   4 ++
 tests/btrfs/049       |   2 +-
 tests/generic/034     |   1 +
 tests/generic/040     |   1 +
 tests/generic/041     |   1 +
 tests/generic/056     |   1 +
 tests/generic/057     |   1 +
 tests/generic/058     |  65 +++++++++++++++++++
 tests/generic/058.out |  78 +++++++++++++++++++++++
 tests/generic/060     |  65 +++++++++++++++++++
 tests/generic/060.out |  78 +++++++++++++++++++++++
 tests/generic/061     |  65 +++++++++++++++++++
 tests/generic/061.out |  80 +++++++++++++++++++++++
 tests/generic/063     |  65 +++++++++++++++++++
 tests/generic/063.out |  80 +++++++++++++++++++++++
 tests/generic/064     |  95 ++++++++++++++++++++++++++++
 tests/generic/064.out |   2 +
 tests/generic/065     | 172 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/generic/065.out |  11 ++++
 tests/generic/066     | 121 +++++++++++++++++++++++++++++++++++
 tests/generic/066.out |  10 +++
 tests/generic/311     |   1 +
 tests/generic/321     |   1 +
 tests/generic/322     |   1 +
 tests/generic/325     |  10 +--
 tests/generic/325.out |  10 +--
 tests/generic/group   |   7 ++
 tests/xfs/068         |   2 +
 33 files changed, 1194 insertions(+), 25 deletions(-)
 create mode 100644 tests/generic/058
 create mode 100644 tests/generic/058.out
 create mode 100644 tests/generic/060
 create mode 100644 tests/generic/060.out
 create mode 100644 tests/generic/061
 create mode 100644 tests/generic/061.out
 create mode 100644 tests/generic/063
 create mode 100644 tests/generic/063.out
 create mode 100644 tests/generic/064
 create mode 100644 tests/generic/064.out
 create mode 100755 tests/generic/065
 create mode 100644 tests/generic/065.out
 create mode 100755 tests/generic/066
 create mode 100644 tests/generic/066.out
--=20
Dave Chinner
david@fromorbit.com

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJU7VMQAAoJEK3oKUf0dfodLBAQAIzOCrnp0wOWtNS1JPE5qH0h
cyi5VsrMhsnE2PXD9TjYIEtBe5fVer893ATj0qMucIMzikrGBSxxTk7MGi43mqQc
R+ss5p3NK3dpCCo2pKwh2zjlojuEJ4N1IBS77+GaOivs4h2SfclS1lHOUfSIWqSK
qFD9R+y13qT47HKr0ayQXpBhUnyQ3Bct6uX3fl5hSWXairxKhUEzJA2Xm4VolA4G
4qqj/PbQcp4MBFmftyrRfbKnb0H+khLhCb0+l4AWCMP9kJs+clt42NlKY0GiIusz
H2Ww3jYrQvU68qVLaexu1PqwFtV/G1NwYgSPC7aIDX3MgqS3gGghVGwJ3rqdbLrp
56kOIa0FP9nWahIoLVClJWQB3rScFvQZv/NGPk6OQjGLYILuMWKrTha6sLi3RaeS
+2KljVoziHwikZnbUsbYkJEzSmt8A6L6rz+DIUYpvPpT3lOv3gzvVqbn91lsFU88
Fk2UzyQrKU7u2byDYIP4BkCHjYs+ukBjDuNF7ErhdhtvCc3ZKSnNdS0NqkKd934l
+ckrpS1BFh4WPBzzeHnEFcYoSmB0Gf/T228OrGlhUu/CnHxwUQEqUmzu2nYAUPKQ
psO93F3p3rY/rsJPVzRfXuaNXMTxwye70A+ble6xDwcBlfsQ/01WNxOgtdTDGr4l
tjHTMdCNgw8C7MRr3dDE
=zqSW
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
