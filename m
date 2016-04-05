Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:22980 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751579AbcDED1W (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 Apr 2016 23:27:22 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1anHe9-0000nx-5J
	for fstests@vger.kernel.org; Tue, 05 Apr 2016 13:27:17 +1000
Date: Tue, 5 Apr 2016 13:27:17 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 74c3708
Message-ID: <20160405032717.GE11238@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

74c3708 generic/082: filter out project quota status

New Commits:

Eryu Guan (4):
      [3bc4c58] common: make sure dm device is all settled before removing =
it
      [021c6b6] generic/244: avoid creating too large random ID
      [a6b8c72] xfs/206: filter out reflink related outputs
      [3e026f5] xfs/030: filter out repeated lines from .out files

Filipe Manana (4):
      [c6de499] btrfs: test log replay with qgroups enabled and orphan roots
      [4548a76] btrfs: add test for fsync after snapshot deletion
      [5b13255] generic: add test for fsync after renaming directory
      [f02fe94] generic: add test for fsync after renaming file

Jaegeuk Kim (1):
      [829b475] attr: adjust acl_max of f2fs if inline_xattr is set

Jan Kara (1):
      [450d833] generic/338: Add mmap race test

Josef Bacik (2):
      [ddc9483] check: make results/check.log match everybody else
      [102ffa0] common: replace chattr with $CHATTR_PROG

Satoru Takeuchi (1):
      [281c087] lib/tlibio: Fix a build warning

Theodore Ts'o (2):
      [687a063] common: Mark tests which use direct I/O with _requires_odir=
ect
      [74c3708] generic/082: filter out project quota status


Code Diffstat:

 check                   |   7 +-
 common/attr             |   7 +-
 common/dmerror          |   3 +
 common/dmflakey         |   3 +
 lib/tlibio.c            |   2 +-
 src/Makefile            |   5 +-
 src/holetest.c          | 342 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/btrfs/024         |   2 +-
 tests/btrfs/059         |   4 +-
 tests/btrfs/119         | 116 +++++++++++++++++
 tests/btrfs/119.out     |   9 ++
 tests/btrfs/120         |  91 ++++++++++++++
 tests/btrfs/120.out     |  12 ++
 tests/btrfs/group       |   2 +
 tests/ext4/006          |   2 +-
 tests/ext4/007          |   2 +-
 tests/ext4/013          |   2 +-
 tests/ext4/014          |   2 +-
 tests/ext4/271          |   2 +-
 tests/ext4/301          |   1 +
 tests/ext4/302          |   1 +
 tests/ext4/303          |   1 +
 tests/ext4/304          |   1 +
 tests/generic/082       |   7 +-
 tests/generic/095       |   1 +
 tests/generic/244       |   2 +-
 tests/generic/250       |   1 +
 tests/generic/252       |   2 +-
 tests/generic/277       |   4 +-
 tests/generic/331       |   2 +-
 tests/generic/332       |   2 +-
 tests/generic/340       |  59 +++++++++
 tests/generic/340.out   |  73 +++++++++++
 tests/generic/341       |  93 ++++++++++++++
 tests/generic/341.out   |  21 ++++
 tests/generic/342       |  90 +++++++++++++
 tests/generic/342.out   |  15 +++
 tests/generic/group     |   3 +
 tests/shared/272        |   4 +-
 tests/xfs/030           |   2 +-
 tests/xfs/030.out.irix  |   3 -
 tests/xfs/030.out.linux |   5 -
 tests/xfs/083           |   2 +-
 tests/xfs/085           |   2 +-
 tests/xfs/086           |   4 +-
 tests/xfs/087           |   2 +-
 tests/xfs/088           |   4 +-
 tests/xfs/089           |   4 +-
 tests/xfs/091           |   4 +-
 tests/xfs/093           |   2 +-
 tests/xfs/097           |   2 +-
 tests/xfs/098           |   2 +-
 tests/xfs/099           |   2 +-
 tests/xfs/100           |   2 +-
 tests/xfs/101           |   2 +-
 tests/xfs/102           |   2 +-
 tests/xfs/105           |   2 +-
 tests/xfs/112           |   2 +-
 tests/xfs/113           |   2 +-
 tests/xfs/117           |   2 +-
 tests/xfs/120           |   2 +-
 tests/xfs/124           |   2 +-
 tests/xfs/125           |   2 +-
 tests/xfs/126           |   2 +-
 tests/xfs/130           |   2 +-
 tests/xfs/195           |   2 +-
 tests/xfs/206           |   2 +-
 tests/xfs/206.out       |   2 -
 tests/xfs/235           |   2 +-
 69 files changed, 1005 insertions(+), 65 deletions(-)
 create mode 100644 src/holetest.c
 create mode 100755 tests/btrfs/119
 create mode 100644 tests/btrfs/119.out
 create mode 100755 tests/btrfs/120
 create mode 100644 tests/btrfs/120.out
 create mode 100644 tests/generic/340
 create mode 100644 tests/generic/340.out
 create mode 100644 tests/generic/341
 create mode 100644 tests/generic/341.out
 create mode 100644 tests/generic/342
 create mode 100644 tests/generic/342.out
--=20
Dave Chinner
david@fromorbit.com

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAzCUAAoJEK3oKUf0dfodmnoQAKSPbeS0Voj6a3EJL36Z0qab
Wy9r23HwQoCQ2TMaZW3pKDz9AUNb2h37XIGh30pyOeag/K8SG9mr1maqvHIWHJ8K
AfaFcPX8eCJzftLDg0cQlWmTiG4WKX3YaIEq9v3Wl1FAhObLmNQLMow7hSWdpDKA
m0yZuY6Ir+D278ZhnPZie+bsN/kDZKWfLY/Rh5KyJEsoH61S1WeLZPS94qEZk1Ja
uEKbwpzwJm/QsSEN/NtVzSiLGWXqaTcc4sgJvpkGzZhcuxl/9HAW7F5IWNuo0sFn
3nIyCuWrSxpmdHO95FfsHuP9jioS4/DoRlgCqPKVNwAjxk+tY/SGilanXBkbmekb
jHPpmLtFZoYWVV96KekHv6en8roqj7OBh7mEuBOOXPhu0lSf6PqH3+McT/HyBiNn
tu5YGPENvU0WkDCkxrxOmi3Ko4dqNjYFA1Sm+ufw/6NlfjkN0Mq6XW7M6PbG0HLi
AxWCYcnC2b8pRATsSwsGChZ0UhtFagYN/a9ySGzLA3+M1SGRGkg/CBcXKrVjkxgF
91nGpwVQCj4rMn+OyiuE8POsR/2PA8FgPKb7zmeUfFjghPwJcrBHkFzs94AsbXPg
XB0L7v5p8sUJlkMQ48fBII9p9LaMklBNH2hAbqHWZb0DvTEl77S8QT1YtT5ufdPl
NjUjyFEcYCpBFL5JHVOU
=iOsI
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
