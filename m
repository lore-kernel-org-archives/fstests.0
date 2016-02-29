Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:25277 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750923AbcB2Gqh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 29 Feb 2016 01:46:37 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1aaHav-0000Nc-8B
	for fstests@vger.kernel.org; Mon, 29 Feb 2016 17:46:13 +1100
Date: Mon, 29 Feb 2016 17:46:13 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 9f7bf79
Message-ID: <20160229064613.GI29057@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ZmUaFz6apKcXQszQ
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

9f7bf79 attr: add maximum acl count for f2fs

New Commits:

Chao Yu (1):
      [9f7bf79] attr: add maximum acl count for f2fs

Eryu Guan (1):
      [219077f] fstests: update autoconf rules to define _GNU_SOURCE where =
needed

Filipe Manana (1):
      [40d2678] fstests: generic test for listing an inode's xattrs

Hugh Dickins (1):
      [ab0fd68] generic/312: remove dependency on /proc/partitions

Theodore Ts'o (3):
      [d0a255e] generic/125: add _require_odirect
      [902223b] defrag: require extents support for ext4 defrag
      [a94334a] common: filter warning messages from mkfs.ext4


Code Diffstat:

 common/attr           |  3 +++
 common/defrag         |  4 ++-
 common/rc             |  2 +-
 configure.ac          |  4 ++-
 m4/package_xfslibs.m4 | 19 ++++++++------
 tests/generic/125     |  1 +
 tests/generic/312     |  5 ----
 tests/generic/337     | 72 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/generic/337.out |  8 ++++++
 tests/generic/group   |  3 ++-
 10 files changed, 105 insertions(+), 16 deletions(-)
 create mode 100755 tests/generic/337
 create mode 100644 tests/generic/337.out
--=20
Dave Chinner
david@fromorbit.com

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW0+k0AAoJEK3oKUf0dfodTysQAJQg0MsTww7kRMeId1tvpr4F
tv9z+7jSdzhb4BNnYStOEj7o6uL4TBWEeq6K1HhCwLQ04zIKrqifndBeZ8v0famW
1Nfjx1R7+iHXh8L8ss045bZjTO8IVaVKFtcb0V8z0KztiiKkkiPbttNKbSwqZ8Iy
3b/BPuVT27CkygKv7X5PUZe7qehAZozoTWLfFiAkex/LkdmpdHr76qAbWw9/mSyL
x2/7e4xREoSGlzW+7tbzypehUvfd3bl4ghN4NaQHWxU9rE64geUJmGYwoOjppMl0
5oHs1cPJzC8c4SR1mBUNgqXwMkidWZz3xruHoObA3arwvbmdghrCCznRnkLMAA+3
6YmpodwrXopr3wjPK4ZeuQg8+UgP4vXatdWNVSLqFuwPMEUx8REdzjoB+duHFted
Fupf2n7YZWryBMRWP7qRp2xkrljdCCagDHD8MbLJAdCjx6vkxzd/aViaxjjtyzIw
aoggpSdzbBfOvkDP1cXOKTcOVHEZsLNDDihqXHak2t+MjIBnMi6NMlj3u9o4eD/R
AnEqj+f+zm+8+cnnDhAUOlsGmI+kRBCbqL5KVx70a8ox9cA8NL8hbkf7FfgIZ2/l
DP9hfspBouvj7ExlYh6iYPQqCuC6HouFpF8hLBQFZjNgFW76WQwCPYStiWm8aDrm
uIpFJ/642xQ0H0ZDNec5
=vtFo
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
