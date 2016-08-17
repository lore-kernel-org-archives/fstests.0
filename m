Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:51198 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268AbcHQGYb (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Aug 2016 02:24:31 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1bZuGy-0006ao-1H
	for fstests@vger.kernel.org; Wed, 17 Aug 2016 16:24:20 +1000
Date: Wed, 17 Aug 2016 16:24:20 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to c760a54
Message-ID: <20160817062419.GA22388@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Don't forget that the repository on
oss.sgi.com is no longer being updated, so you'll need to redirect
your repository source to the above kernel.org repo if you end up
with a non-working source tree after your next update.

-Dave.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

c760a54 src/t_immutable: allow EPERM on immutable inode

New Commits:

Darrick J. Wong (3):
      [72cdba7] reflink: test cross-mountpoint reflink and dedupe
      [7f6f53a] xfs: scrub fs at the end of the test
      [908ce96] xfs/122: add the realtime rmapbt inode and btree fields

Eryu Guan (1):
      [c760a54] src/t_immutable: allow EPERM on immutable inode


Code Diffstat:

 README                |   3 ++
 common/config         |   1 +
 common/rc             |   7 ++++
 src/t_immutable.c     | 108 ++++++++++++++++++++++++++--------------------=
-------
 tests/generic/373     |  90 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/373.out |   9 +++++
 tests/generic/374     |  88 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/374.out |  10 +++++
 tests/generic/group   |   2 +
 tests/xfs/122.out     |   6 ++-
 10 files changed, 269 insertions(+), 55 deletions(-)
 create mode 100755 tests/generic/373
 create mode 100644 tests/generic/373.out
 create mode 100755 tests/generic/374
 create mode 100644 tests/generic/374.out
--=20
Dave Chinner
david@fromorbit.com

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXtAMTAAoJEK3oKUf0dfodtXYP/2iuTVu0vDdXPYtV6j05r/D2
9q3gRpjE0LacaFDEhJ+nItTsqIWV4Mw6/nnOY2Zpk7oP5YkB6ohDEEdkk6ENOgTR
z9okMmWdNey4zEnW5yn4IucWMlmwYxc/vdiNDpBdkRtdlbum5RnMavxF/j4r2ZN/
pISauGsY66VjIAW4Gh0Bul5QDqGPjFZ9GlRmXrhwx3nzosNb0fTW9swOIa0Zsp+c
mbcMeDyEH7mvFrDGiJkIzK/jC+EUUkfIaqRHWrRW58nS+UrHMXMzddl+4h68G8hO
4UFv0k2gZsjiFcYfWuju2Nd5mX2kY/+Udhtw1TeKeQgwBp7PaOMNRCaMUVALJTPM
4ITPy/NV4Iip2WBZIiNFPI/b9ydblxo3D5ZC+qXP3boxo+k7/VZqsJfUBgBVfAbq
aJI/VvHPjWhy8Oeq9+qauHd7nh+ZF2nlhzdivSB/rtN0vK6lEOET1SbvdJWEA+gT
VvPY2BPrnif8M9av765yOzYczeqNaeKL/7aXlZ1bJTz+R7nHwdizaPWqCicqQgyl
CHM4jtZ4ZTXlDiQhLyUyQWJ7ewThgqVr7bdJA+jGdwqV0JATgzKjbSIjvDFTrZCJ
3se0cXfCoepWkrPkSV21Iq3sepKAF0UCOiJzIAYxAwETpmwWKZ9lVqdn70Bv4Bm9
2PYD9F0g47zQS45N89Zu
=bTcZ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
