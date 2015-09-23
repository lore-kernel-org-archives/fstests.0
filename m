Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:38265 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752775AbbIWC4s (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Sep 2015 22:56:48 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1ZeaEH-000259-RO
	for fstests@vger.kernel.org; Wed, 23 Sep 2015 12:56:21 +1000
Date: Wed, 23 Sep 2015 12:56:21 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to f0c4b46
Message-ID: <20150923025621.GL3902@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0NB0lE7sNnW8+0qW"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--0NB0lE7sNnW8+0qW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a quick bug fix update for issues
introduced in yesterday's large update.

The new head of the master branch is commit:

f0c4b46 btrfs: Fix _filter_uuid golden output for device replace tests

New Commits:

Dave Chinner (1):
      [33ebff8] generic/109: fix status on completion

Filipe Manana (1):
      [f0c4b46] btrfs: Fix _filter_uuid golden output for device replace te=
sts


Code Diffstat:

 tests/btrfs/100.out | 4 ++--
 tests/btrfs/101.out | 4 ++--
 tests/generic/109   | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)
--=20
Dave Chinner
david@fromorbit.com

--0NB0lE7sNnW8+0qW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJWAhTVAAoJEK3oKUf0dfodrC4QALyW79XdZc94V2SVZd1vww8h
M3mWGV9FRv38hRX+bG6JtotkBlD0AT3mDzqh01pe1iApWcjsa5MXnAUHp/9959+0
H3eq2w/JD2AYMiak/snSBRlDvX5PCFUq1lBx7/DPS8Ktu/oCIDuO8uXb5ez35AY/
08uCvzo/cff8OLChiw5CekvvQMo8e2qzhRjRy1nqBOQWZDVK32+34ON+jf/Azrv5
kmLMy6q287Klx1cjSR9vmqF1CYj8QWcRamZQOrv3AzA8GEkhyL4FG7XK+9xFHjvV
IUM51WJaNBH3Ty6aaQCHpSaOZJGBrBun3LOJ+A50thiJO1B3c4E8T0zlVCrP3fpM
UmAMpE5VXALUW/kyh9Ul5tSKshkPfe5WroC/giK1fbyOMDvh7THo9optxQNSLsD5
rRMWg6PHwmeYOAgqeMK6Rx1fw8rd3o/4nOT82EJ3tgstz5XTe2I1TlNIZ4XOKSYi
I1T0jw+FfJ2UrbO1rla+s36iJUSb/dPdknJyAQ/fYblSm6DxplkjQeY2G6bMtBHD
Jc/moSfm4QAYj3M7NNIgSf2jV+EhLHpsyNh3jOOOmLL85IG8xuOg1W6oh/138733
giDUn/k6BiYHYIneq4hAVV6xpSPKW0RSqw6HAOVW9gUi7TiAd7IT1GSVIkLE/Ssr
6+xqk+0v5moh+1u9igVR
=xzIV
-----END PGP SIGNATURE-----

--0NB0lE7sNnW8+0qW--
