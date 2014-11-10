Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:53806 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750812AbaKJHIl (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 10 Nov 2014 02:08:41 -0500
Date: Mon, 10 Nov 2014 18:08:36 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to 6676905
Message-ID: <20141110070836.GP23575@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--mYCpIKhGyMATD0i+
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

6676905 generic: add test to verify xattr replace operations are atomic

New Commits:

Anna Schumaker (1):
      [73dfa4a] common: Fixes for testing NFS over IPv6

Brian Foster (1):
      [e62dbea] xfs/062: verify bulkstat finds all inodes

Dmitry Monakhov (2):
      [fd730cf] fstests: update 'new' script
      [33e0889] aio: add regression test race between write and fcntl

Eric Sandeen (1):
      [155cf51] xfs/068: fix expected output file for proper restore output

Eryu Guan (5):
      [76c5f3c] common: re-enable tests that require scratch dev on NFS
      [129444c] common: add _require_block_device() helper
      [f72abf5] generic: skip atime related tests on NFS
      [1bc9c1a] common: use _scratch_mount helper in _require_relatime()
      [664f1f0] generic/277: add _require_attrs

Filipe Manana (2):
      [8c7c07e] btrfs: regression test for ro snapshot creation
      [6676905] generic: add test to verify xattr replace operations are at=
omic

Jan Kara (1):
      [fa7f9fb] xfs/195: Use XFSDUMP_PROG instead of xfsdump directly

Liu Bo (1):
      [181ba03] aio: fix memory corruption in aio-last-ref-held-by-io

Qu Wenruo (1):
      [027bcfa] btrfs: regression test for btrfs extent merge


Code Diffstat:

 common/config                                 |    6 +-
 common/rc                                     |   58 +-
 new                                           |   85 ++-
 src/aio-dio-regress/aio-dio-fcntl-race.c      |  150 ++++
 src/aio-dio-regress/aio-last-ref-held-by-io.c |    4 +-
 tests/btrfs/078                               |   85 +++
 tests/btrfs/078.out                           |    2 +
 tests/btrfs/079                               |  126 ++++
 tests/btrfs/079.out                           |    2 +
 tests/btrfs/group                             |    2 +
 tests/generic/003                             |    1 +
 tests/generic/036                             |   51 ++
 tests/generic/036.out                         |    2 +
 tests/generic/037                             |  102 +++
 tests/generic/037.out                         | 1001 +++++++++++++++++++++=
++++
 tests/generic/076                             |    1 +
 tests/generic/192                             |    1 +
 tests/generic/277                             |    2 +
 tests/generic/group                           |    2 +
 tests/xfs/062                                 |  110 +++
 tests/xfs/062.out                             |   17 +
 tests/xfs/068.out                             |    2 +-
 tests/xfs/195                                 |    7 +-
 tests/xfs/group                               |    1 +
 24 files changed, 1782 insertions(+), 38 deletions(-)
 create mode 100644 src/aio-dio-regress/aio-dio-fcntl-race.c
 create mode 100755 tests/btrfs/078
 create mode 100644 tests/btrfs/078.out
 create mode 100755 tests/btrfs/079
 create mode 100644 tests/btrfs/079.out
 create mode 100755 tests/generic/036
 create mode 100644 tests/generic/036.out
 create mode 100755 tests/generic/037
 create mode 100644 tests/generic/037.out
 create mode 100755 tests/xfs/062
 create mode 100644 tests/xfs/062.out
--=20
Dave Chinner
david@fromorbit.com

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUYGR0AAoJEK3oKUf0dfodwmcQANTrzSrRC1ne6kFEErN8VTZU
4KaLsSlxb+IxGmFsdAC17YcaB1+9CMmK6Dv+sq5HLdiyQv7VcotJokG4hygmw6t5
cy8jI+uVvPOvF14eF9EgW2JlCx4gXFRARlQWeVIDNMkg5xpbMTZeEBWxJ5maTACk
vO/pf1dIUl/IIb/h8/dewBW2rUe0n+7ije+Dcfri5YqRbexQ9ROMzHErLwkFk4fr
Fq8teWFFQlbt+7dPgAL2mqv61U+kUTvbsQWVgz1WXtaGuUGTAtxI1zyUtE8DZSJb
HgX3tBD5NRsGkBAZKCGAUN8F0fwT3m1G22xAoC33OA+qgsvfFXC1VhfhlqHd1Gjg
vxik0InUZQNvXPZohprmQYuAqliO01/smYLmccQ0RD0D5aIEqfmldDsjPeK4Krjo
4MlyFlWa64JMKuCHuyZ/1C4iJzSAhxBZtiPAU8ErlfDGCzipW5ZwRnjrV1Wb4GaD
bE+w/Pf3dOe5fD9y3psuhj7jzZlC6RW42NZFB9mdx733t6o9N4Pi/5kyUWKgnKrN
G8CZDFZYdM78IUF/GHFKgyQpzusdXgcHhqccPc3eF595zXeCYboTdEQM0aM9uvKf
1zRFBXTGGUxYWvZDJPUlnIun90QrisFgZ94yRGhR31OxiSBdL2WUjCv6+kXGUHeH
IPIlU4bTsHkAZ9Vwzyrj
=xbmX
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
