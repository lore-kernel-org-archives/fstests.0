Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:55115 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754894AbcJTI1j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Oct 2016 04:27:39 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1bx8hM-0005zx-3b
        for fstests@vger.kernel.org; Thu, 20 Oct 2016 19:27:36 +1100
Date: Thu, 20 Oct 2016 19:27:36 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 16ef0843f212
Message-ID: <20161020082736.GK23194@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

The new head of the master branch is commit:

16ef0843f212 xfs/122: remove dead code

New Commits:

Eric Biggers (2):
      [92846328baee] generic/375: test both regular file and directory
      [8cfd58a5dbb9] generic/314: don't test SGID behavior after setfacl

Eryu Guan (1):
      [16ef0843f212] xfs/122: remove dead code

Zorro Lang (1):
      [8425118bff45] common/rc: use real device name in _sysfs_dev function


Code Diffstat:

 common/rc             |  2 +-
 tests/generic/314     |  8 ++------
 tests/generic/314.out |  1 -
 tests/generic/375     | 54 ++++++++++++++++++++++++++++++++++-------------=
-------
 tests/generic/375.out |  8 ++++++++
 tests/xfs/122         |  4 ----
 6 files changed, 45 insertions(+), 32 deletions(-)
--=20
Dave Chinner
david@fromorbit.com

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYCH/3AAoJEK3oKUf0dfodyy8QAJqskxom1OhqLjYbUPJQ6LV6
8K0Vx/l8HVYaJNKkJYJQSorQoj5w9mdvqd/0OhvsdeJg6lOcl3elOqudvr3rlZEv
4DjoOLfc/ko+QUri/lL7kCUoxkmtmgsVZOrB6US7cKehu3NuchPbHMSwEcy8INDb
2G6NyM3l6/cH7nkNHArQl4GFrP40O8ZjfNdiYsENRtZa1RaXtg0aJPMqJrVFHNAa
ba5WQDJijdpN9AuieD7CjByXBFBTV9oGJDvlLQVwIBZfN5TmE8iUhX1BAk/EZIai
ryRaRxcp37Zu8R4+b0ZLsuLYBHy8M+ipRTExNp1BNrndatumvPvjjjCeenyZCsPm
gyOOMhTjQiBYnsEXDCoQ09UCqOnWdfanm9Ja4OsuTiAPkRTHEGK1nj+9yrArubBW
zMYGVUJgwo5STnOd8Yw6dOFNPIBWAm4h1Jf7+y5dLgnscPw1xQDu+3vx4gXfTRFh
0zgEQn/zc4QOMgAz6fDXuraAQ3VghnDB6oDtPADKZW0+0ayQgn+3eVJeqtU47kXL
CMd/5STrmmLLhNWYM9SsyhS48rA5UfTB62jByks9Fk4AbVO+rzXPk/CyZuW41Nbg
CwhZfMnJ/5q+NA+s5DzDNHRuASdhHWg0EJnYXtO7lNOvGh+M6uclxeig77Ne6z/t
avS0xxDadOBT68pRO7NG
=5ctY
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
