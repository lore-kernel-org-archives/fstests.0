Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:37426 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751543AbbKQDtQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 16 Nov 2015 22:49:16 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1ZyXGZ-0006vN-Ur
	for fstests@vger.kernel.org; Tue, 17 Nov 2015 14:49:12 +1100
Date: Tue, 17 Nov 2015 14:49:11 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to e597459
Message-ID: <20151117034911.GA19199@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This mostly contains Darrick's new
reflink/dedupe tests (without the new tools patch), plus a few other
small bits and pieces.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

-Dave.

The new head of the master branch is commit:

e597459 generic/269: Fix failure due to race killing fsstress job

New Commits:

Chao Yu (1):
      [b056c77] generic/285: fix the wrong result printed in full log

Darrick J. Wong (11):
      [5a7abc0] btrfs: move btrfs reflink tests to generic
      [20d7bfa] reflink: add test support routines to a separate file
      [cc8e860] reflink: basic tests of the reflink and dedupe ioctls
      [6a4e8b8] reflink: test CoW behaviors of reflinked files
      [c84e01b] reflink: test the various fallocate modes
      [bed1fed] reflink: test accuracy of free block counts
      [f3965fd] reflink: test error conditions due to bad inputs
      [212adba] xfs: test xfs-specific reflink pieces
      [5fb5ee4] reflink: concurrent operations tests
      [db4284f] reflink: test that CoW writes fail when we're out of space
      [727d477] reflink: test what happens when we hit resource limits

Filipe Manana (3):
      [71f68b4] fstests: generic test for fsync after hole punching
      [1a22b68] common: add helper function _flakey_drop_and_remount
      [e597459] generic/269: Fix failure due to race killing fsstress job

Jan Kara (2):
      [ffe3046] _filter_fiemap: Avoid awk interval regexps
      [1d2fc09] ext4/001: Update output

Justin Maggard (2):
      [7be74ad] btrfs: test unmount during quota rescan
      [b60c8ce] btrfs: test quota disable during quota rescan


Code Diffstat:

 common/dmflakey                  |  15 ++++
 common/punch                     |   2 +-
 common/rc                        |  51 ++++++-----
 common/reflink                   | 185 +++++++++++++++++++++++++++++++++++=
++++
 src/seek_sanity_test.c           |   4 +-
 tests/btrfs/026.out              |  16 ----
 tests/btrfs/027.out              |  25 ------
 tests/btrfs/028.out              |   7 --
 tests/btrfs/029                  |   1 +
 tests/btrfs/031                  |   1 +
 tests/btrfs/056                  |   9 +-
 tests/btrfs/095                  |   8 +-
 tests/btrfs/098                  |   8 +-
 tests/btrfs/108                  |   1 +
 tests/btrfs/109                  |   1 +
 tests/btrfs/114                  |  61 +++++++++++++
 tests/btrfs/114.out              |   2 +
 tests/btrfs/115                  |  62 +++++++++++++
 tests/btrfs/115.out              |   2 +
 tests/btrfs/group                |   5 +-
 tests/ext4/001.out               |   8 +-
 tests/generic/034                |   6 +-
 tests/generic/039                |   9 +-
 tests/generic/040                |   9 +-
 tests/generic/041                |   9 +-
 tests/generic/056                |   7 +-
 tests/generic/057                |   7 +-
 tests/generic/059                |   8 +-
 tests/generic/065                |   7 +-
 tests/generic/066                |  13 +--
 tests/generic/073                |   7 +-
 tests/generic/090                |   8 +-
 tests/generic/101                |   7 +-
 tests/generic/104                |   8 +-
 tests/generic/106                |   8 +-
 tests/generic/107                |   8 +-
 tests/{btrfs/026 =3D> generic/110} |   5 +-
 tests/generic/110.out            |  16 ++++
 tests/{btrfs/027 =3D> generic/111} |   5 +-
 tests/generic/111.out            |  25 ++++++
 tests/{btrfs/028 =3D> generic/115} |   5 +-
 tests/generic/115.out            |   7 ++
 tests/generic/116                |  92 +++++++++++++++++++
 tests/generic/116.out            |   8 ++
 tests/generic/118                |  93 ++++++++++++++++++++
 tests/generic/118.out            |  11 +++
 tests/generic/119                | 170 +++++++++++++++++++++++++++++++++++
 tests/generic/119.out            |  30 +++++++
 tests/generic/121                |  92 +++++++++++++++++++
 tests/generic/121.out            |   8 ++
 tests/generic/122                |  92 +++++++++++++++++++
 tests/generic/122.out            |  12 +++
 tests/generic/134                | 128 +++++++++++++++++++++++++++
 tests/generic/134.out            |  16 ++++
 tests/generic/136                | 128 +++++++++++++++++++++++++++
 tests/generic/136.out            |  17 ++++
 tests/generic/137                | 131 +++++++++++++++++++++++++++
 tests/generic/137.out            |   8 ++
 tests/generic/138                | 152 ++++++++++++++++++++++++++++++++
 tests/generic/138.out            |  19 ++++
 tests/generic/139                | 151 ++++++++++++++++++++++++++++++++
 tests/generic/139.out            |  19 ++++
 tests/generic/140                | 152 ++++++++++++++++++++++++++++++++
 tests/generic/140.out            |  19 ++++
 tests/generic/142                |  91 +++++++++++++++++++
 tests/generic/142.out            |   8 ++
 tests/generic/143                |  91 +++++++++++++++++++
 tests/generic/143.out            |   8 ++
 tests/generic/144                | 142 ++++++++++++++++++++++++++++++
 tests/generic/144.out            |  16 ++++
 tests/generic/145                | 142 ++++++++++++++++++++++++++++++
 tests/generic/145.out            |  19 ++++
 tests/generic/146                | 136 ++++++++++++++++++++++++++++
 tests/generic/146.out            |  19 ++++
 tests/generic/147                | 139 +++++++++++++++++++++++++++++
 tests/generic/147.out            |  19 ++++
 tests/generic/148                | 116 ++++++++++++++++++++++++
 tests/generic/148.out            |  15 ++++
 tests/generic/149                | 136 ++++++++++++++++++++++++++++
 tests/generic/149.out            |  19 ++++
 tests/generic/150                |  78 +++++++++++++++++
 tests/generic/150.out            |   4 +
 tests/generic/151                |  98 +++++++++++++++++++++
 tests/generic/151.out            |   8 ++
 tests/generic/152                | 103 ++++++++++++++++++++++
 tests/generic/152.out            |   8 ++
 tests/generic/153                | 102 +++++++++++++++++++++
 tests/generic/153.out            |   8 ++
 tests/generic/154                | 110 +++++++++++++++++++++++
 tests/generic/154.out            |  11 +++
 tests/generic/155                | 114 ++++++++++++++++++++++++
 tests/generic/155.out            |  11 +++
 tests/generic/156                | 124 ++++++++++++++++++++++++++
 tests/generic/156.out            |  12 +++
 tests/generic/157                | 122 ++++++++++++++++++++++++++
 tests/generic/157.out            |  25 ++++++
 tests/generic/158                | 123 ++++++++++++++++++++++++++
 tests/generic/158.out            |  24 +++++
 tests/generic/159                |  74 ++++++++++++++++
 tests/generic/159.out            |   5 ++
 tests/generic/160                |  74 ++++++++++++++++
 tests/generic/160.out            |   5 ++
 tests/generic/161                |  79 +++++++++++++++++
 tests/generic/161.out            |   6 ++
 tests/generic/162                |  95 ++++++++++++++++++++
 tests/generic/162.out            |   7 ++
 tests/generic/163                |  95 ++++++++++++++++++++
 tests/generic/163.out            |   7 ++
 tests/generic/164                | 105 ++++++++++++++++++++++
 tests/generic/164.out            |   7 ++
 tests/generic/165                | 105 ++++++++++++++++++++++
 tests/generic/165.out            |   7 ++
 tests/generic/166                |  93 ++++++++++++++++++++
 tests/generic/166.out            |   6 ++
 tests/generic/167                |  93 ++++++++++++++++++++
 tests/generic/167.out            |   6 ++
 tests/generic/168                |  97 ++++++++++++++++++++
 tests/generic/168.out            |   6 ++
 tests/generic/170                |  97 ++++++++++++++++++++
 tests/generic/170.out            |   6 ++
 tests/generic/171                | 107 ++++++++++++++++++++++
 tests/generic/171.out            |  10 +++
 tests/generic/172                | 107 ++++++++++++++++++++++
 tests/generic/172.out            |  10 +++
 tests/generic/173                | 109 +++++++++++++++++++++++
 tests/generic/173.out            |   8 ++
 tests/generic/174                | 107 ++++++++++++++++++++++
 tests/generic/174.out            |  10 +++
 tests/generic/175                |  99 +++++++++++++++++++++
 tests/generic/175.out            |   0
 tests/generic/176                |  81 +++++++++++++++++
 tests/generic/176.out            |   5 ++
 tests/generic/177                | 108 +++++++++++++++++++++++
 tests/generic/177.out            |  13 +++
 tests/generic/269                |   3 +-
 tests/generic/321                |  18 ++--
 tests/generic/322                |  12 +--
 tests/generic/325                |   6 +-
 tests/generic/group              |  49 +++++++++++
 tests/shared/002                 |   8 +-
 tests/xfs/127                    |  79 +++++++++++++++++
 tests/xfs/127.out                |   6 ++
 tests/xfs/128                    | 149 +++++++++++++++++++++++++++++++
 tests/xfs/128.out                |  27 ++++++
 tests/xfs/129                    |  87 ++++++++++++++++++
 tests/xfs/129.out                |   6 ++
 tests/xfs/130                    | 109 +++++++++++++++++++++++
 tests/xfs/130.out                |  13 +++
 tests/xfs/131                    |  76 ++++++++++++++++
 tests/xfs/131.out                |   6 ++
 tests/xfs/132                    | 130 +++++++++++++++++++++++++++
 tests/xfs/132.out                |  32 +++++++
 tests/xfs/group                  |   6 ++
 153 files changed, 6831 insertions(+), 247 deletions(-)
 create mode 100644 common/reflink
 delete mode 100644 tests/btrfs/026.out
 delete mode 100644 tests/btrfs/027.out
 delete mode 100644 tests/btrfs/028.out
 create mode 100644 tests/btrfs/114
 create mode 100644 tests/btrfs/114.out
 create mode 100755 tests/btrfs/115
 create mode 100644 tests/btrfs/115.out
 rename tests/{btrfs/026 =3D> generic/110} (97%)
 create mode 100644 tests/generic/110.out
 rename tests/{btrfs/027 =3D> generic/111} (98%)
 create mode 100644 tests/generic/111.out
 rename tests/{btrfs/028 =3D> generic/115} (97%)
 create mode 100644 tests/generic/115.out
 create mode 100755 tests/generic/116
 create mode 100644 tests/generic/116.out
 create mode 100755 tests/generic/118
 create mode 100644 tests/generic/118.out
 create mode 100755 tests/generic/119
 create mode 100644 tests/generic/119.out
 create mode 100755 tests/generic/121
 create mode 100644 tests/generic/121.out
 create mode 100755 tests/generic/122
 create mode 100644 tests/generic/122.out
 create mode 100755 tests/generic/134
 create mode 100644 tests/generic/134.out
 create mode 100755 tests/generic/136
 create mode 100644 tests/generic/136.out
 create mode 100755 tests/generic/137
 create mode 100644 tests/generic/137.out
 create mode 100755 tests/generic/138
 create mode 100644 tests/generic/138.out
 create mode 100755 tests/generic/139
 create mode 100644 tests/generic/139.out
 create mode 100755 tests/generic/140
 create mode 100644 tests/generic/140.out
 create mode 100755 tests/generic/142
 create mode 100644 tests/generic/142.out
 create mode 100755 tests/generic/143
 create mode 100644 tests/generic/143.out
 create mode 100755 tests/generic/144
 create mode 100644 tests/generic/144.out
 create mode 100755 tests/generic/145
 create mode 100644 tests/generic/145.out
 create mode 100755 tests/generic/146
 create mode 100644 tests/generic/146.out
 create mode 100755 tests/generic/147
 create mode 100644 tests/generic/147.out
 create mode 100755 tests/generic/148
 create mode 100644 tests/generic/148.out
 create mode 100755 tests/generic/149
 create mode 100644 tests/generic/149.out
 create mode 100755 tests/generic/150
 create mode 100644 tests/generic/150.out
 create mode 100755 tests/generic/151
 create mode 100644 tests/generic/151.out
 create mode 100755 tests/generic/152
 create mode 100644 tests/generic/152.out
 create mode 100755 tests/generic/153
 create mode 100644 tests/generic/153.out
 create mode 100755 tests/generic/154
 create mode 100644 tests/generic/154.out
 create mode 100755 tests/generic/155
 create mode 100644 tests/generic/155.out
 create mode 100755 tests/generic/156
 create mode 100644 tests/generic/156.out
 create mode 100755 tests/generic/157
 create mode 100644 tests/generic/157.out
 create mode 100755 tests/generic/158
 create mode 100644 tests/generic/158.out
 create mode 100755 tests/generic/159
 create mode 100755 tests/generic/159.out
 create mode 100755 tests/generic/160
 create mode 100755 tests/generic/160.out
 create mode 100755 tests/generic/161
 create mode 100644 tests/generic/161.out
 create mode 100755 tests/generic/162
 create mode 100644 tests/generic/162.out
 create mode 100755 tests/generic/163
 create mode 100644 tests/generic/163.out
 create mode 100755 tests/generic/164
 create mode 100644 tests/generic/164.out
 create mode 100755 tests/generic/165
 create mode 100644 tests/generic/165.out
 create mode 100755 tests/generic/166
 create mode 100644 tests/generic/166.out
 create mode 100755 tests/generic/167
 create mode 100644 tests/generic/167.out
 create mode 100755 tests/generic/168
 create mode 100644 tests/generic/168.out
 create mode 100755 tests/generic/170
 create mode 100644 tests/generic/170.out
 create mode 100755 tests/generic/171
 create mode 100644 tests/generic/171.out
 create mode 100755 tests/generic/172
 create mode 100644 tests/generic/172.out
 create mode 100755 tests/generic/173
 create mode 100644 tests/generic/173.out
 create mode 100755 tests/generic/174
 create mode 100644 tests/generic/174.out
 create mode 100755 tests/generic/175
 create mode 100644 tests/generic/175.out
 create mode 100755 tests/generic/176
 create mode 100644 tests/generic/176.out
 create mode 100755 tests/generic/177
 create mode 100644 tests/generic/177.out
 create mode 100755 tests/xfs/127
 create mode 100644 tests/xfs/127.out
 create mode 100755 tests/xfs/128
 create mode 100644 tests/xfs/128.out
 create mode 100755 tests/xfs/129
 create mode 100644 tests/xfs/129.out
 create mode 100755 tests/xfs/130
 create mode 100644 tests/xfs/130.out
 create mode 100755 tests/xfs/131
 create mode 100644 tests/xfs/131.out
 create mode 100755 tests/xfs/132
 create mode 100644 tests/xfs/132.out
--=20
Dave Chinner
david@fromorbit.com

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJWSqO3AAoJEK3oKUf0dfodMScP/1VXW3Xr5zeEZepDtyh4VDb1
uBjRdUAM1isVIsb3wS2xwAFyjKfmfadGFhMcBkts3W1UF8lSBU7puwYCjEYPTwFa
XxyesaTFbawuKbqzllQNvlAOZLjMsM+IMC3uUe4OztZYb2lSWqAegTe8M8SJwOZK
FZrHIDvvO3q2shlfyHuFf0PyD1ALZUwwF8rzLGLRW50y8k2wGxNDGlljkdh6woqO
Mne9lt8K/brkm3PPS9nbOCg+NwCbjrtV3A63yHW1yO88ikUGKekF7rtHhsXg679s
l0gByXdbqbc62oBYtIoDVhrAL/1MVaVAIq0V09MTvHs4RHxrIgla+GAWgR3D8kRI
ipL5K+J0SsaXe19BKqBL6tAygDO76i0AS8co/lVsxW6J3hulZuo6z8vh36osDjAa
X+UI0D/hpkQ/M52U5EJpa10/AzBGEQMhUG4MUOLDz2MWnlnU2hAedeR5wOypU2Yh
+eNm1o2xAS8PZoHnLa0R7pn9ZzeWcxzTJF94bOVRzevmB0qYGuLusj5xNdrJl+fM
rbF42/cgzycRE7v1WUohxARJl5oZszF8Ib/tgK0nISDLHp6F/mVFWKgJSjXcWCSE
Q+pOm1Xw/G9hSeA+rwpJwJKsMcCVs1a8X+VEncnPNi2I8/XvvTeJ/Pf8nhjKS5f/
o+Zt3Db0Vmvxstj4iI47
=GrNT
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
