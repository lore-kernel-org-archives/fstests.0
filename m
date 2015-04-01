Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:54628 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751533AbbDAXGO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 1 Apr 2015 19:06:14 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1YdRey-000767-Ks
	for fstests@vger.kernel.org; Thu, 02 Apr 2015 10:02:56 +1100
Date: Thu, 2 Apr 2015 10:02:56 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to facff60
Message-ID: <20150401230256.GH28621@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks.

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

I'd like to say a big THANKS to all the people who have reviewed
patches in this cycle - it's been a big help to me, especially with
the volume of changes that have been coming through. I've picked up
all the reviewed patches, but there were a few that still hadn't
completed review that I didn't pick up. I'll pick them up once
reviews have completed on them.

-Dave.

The new head of the master branch is commit:

facff60 generic: test full dm snapshot devices

New Commits:

Dave Chinner (1):
      [afd025f] xfs/078: remove loop device on failure

Eric Sandeen (3):
      [cf1b6d6] filter: btrfs-progs keeps changing version string
      [552dcfb] filter: btrfs-progs subvolume delete output changed
      [b2aa857] btrfs: fix _filter_mkfs regression

Eryu Guan (5):
      [822390a] generic: test some mount/umount corner cases
      [6000122] nfs: recognise IPv6 export in _require_scratch_nocheck()
      [c8ea6c0] xfs/014: replace df with $DF_PROG
      [998f59d] generic/077: add missing _require_scratch
      [facff60] generic: test full dm snapshot devices

Filipe Manana (4):
      [672a9f0] generic: test fsync after moving files across directories
      [a752266] btrfs: test incremental send with directory renames
      [40851f9] btrfs: test incremental send/receive
      [9edaf22] btrfs: test cloning of zero length ranges

Jan Tulak (1):
      [03c633b] build: Allow alphanumeric test name suffixes

Jeff Mahoney (1):
      [dd26ee3] btrfs: test orphan item cleanup

Omer Zilberberg (1):
      [856ff26] generic: test that mmap-write updates c/mtime

Xiaoguang Wang (1):
      [cbc98cd] generic: add test for truncate/collapse range race


Code Diffstat:

 README                |   8 ++-
 check                 |   9 ++-
 common/config         |   1 +
 common/filter         |   4 --
 common/filter.btrfs   |   9 +--
 common/rc             |  26 +++++++-
 new                   |  54 +++++++++++++++--
 tests/btrfs/082       |   2 +-
 tests/btrfs/083       | 159 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
 tests/btrfs/083.out   |   2 +
 tests/btrfs/084       | 132 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/084.out   |   2 +
 tests/btrfs/085       | 161 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/btrfs/085.out   |   4 ++
 tests/btrfs/086       |  77 ++++++++++++++++++++++++
 tests/btrfs/086.out   |   2 +
 tests/btrfs/group     |   4 ++
 tests/generic/067     | 143 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/067.out |   2 +
 tests/generic/072     |  70 ++++++++++++++++++++++
 tests/generic/072.out |   2 +
 tests/generic/073     | 113 +++++++++++++++++++++++++++++++++++
 tests/generic/073.out |  11 ++++
 tests/generic/077     |   1 +
 tests/generic/080     |  78 ++++++++++++++++++++++++
 tests/generic/080.out |   2 +
 tests/generic/081     |  86 +++++++++++++++++++++++++++
 tests/generic/081.out |   2 +
 tests/generic/204     |   1 +
 tests/generic/group   |   5 ++
 tests/xfs/014         |   2 +-
 tests/xfs/078         |   6 +-
 32 files changed, 1156 insertions(+), 24 deletions(-)
 create mode 100755 tests/btrfs/083
 create mode 100644 tests/btrfs/083.out
 create mode 100755 tests/btrfs/084
 create mode 100644 tests/btrfs/084.out
 create mode 100755 tests/btrfs/085
 create mode 100644 tests/btrfs/085.out
 create mode 100755 tests/btrfs/086
 create mode 100644 tests/btrfs/086.out
 create mode 100755 tests/generic/067
 create mode 100644 tests/generic/067.out
 create mode 100755 tests/generic/072
 create mode 100644 tests/generic/072.out
 create mode 100755 tests/generic/073
 create mode 100644 tests/generic/073.out
 create mode 100755 tests/generic/080
 create mode 100644 tests/generic/080.out
 create mode 100755 tests/generic/081
 create mode 100644 tests/generic/081.out
--=20
Dave Chinner
david@fromorbit.com

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVHHkgAAoJEK3oKUf0dfodkAwP/1zJqr88cv3PkMLzeJzfj9sw
m3Pn23KpzzTsMJI8yQKo8GVRqLuiiEsibDIXiWA6EQUnQZSZwTZT7+VOhuQiSSQC
7SU5oQgw5Qn/3KJ8QR4HcSb0uDvPRX0BsHyjPpbgYrmr8ChxkALiaLz9LbyFFisq
0BUg+fxlKZvhZUc1WQETu+5OBNeeDX2qzWmE2GgMzAygYIWKjqCKJ68g8FbVZBVv
BflBjV0zQMXCYT9O9cZ5AHxBY+4CncD0LFlyFsX6zPb/aaU6ucBLde3vHxZjEWvY
OZgaDtdFaL97k0A4S4gXyiGbLjovtBl076++GNffMBVDKE3+J5XoFEK70kCeLtY6
3lH1cn2j2Jqf/Fb5G/bANKxs292ai3C5tadKIk1jyjFKtxk/KedUomtfhUfY2FD0
EMWaz098kp+aY41UFuZp/MQgKmdpVZyCCjf00fyyKYzSQrvhL1ZPvf2xBAritpTU
KQTyfsTv1ezvEjNaDDRf8XNkJpFiQiPSI6peMZuHlgZgoJvBUHzSgZ+XlnfKtb8y
Qe3ojYZf8YDyFS+z/9XCdJKFCjY6h/4ffEyNq778LVchFqUIz+AoaWEFrQjxcjBN
A8RW/1on2m8Pgc6etVA3MUh4XVgJlznFD5MradV6xaOHATGGxxAu8/l9OS5ZMVor
2HRkcAxkw3cTYzOs+U3d
=QOCR
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
