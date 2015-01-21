Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:18955 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097AbbAUJOv (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 21 Jan 2015 04:14:51 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1YDrNA-0003Xt-Bd
	for fstests@vger.kernel.org; Wed, 21 Jan 2015 20:14:48 +1100
Date: Wed, 21 Jan 2015 20:14:48 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 573f9ca
Message-ID: <20150121091448.GI16510@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--bg08WKrSYDhXBjb5
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

573f9ca ext4/30[23]: ignore EBUSY error

New Commits:

Eric Sandeen (1):
      [39cbe04] check: log running test to dmesg

Eryu Guan (2):
      [47e5d7d] check: check dmesg log after each test
      [eceb679] common: add _disable_dmesg_check function

Filipe Manana (5):
      [90a5c23] common: fix function _require_batched_discard()
      [6cf4c16] generic: test fsync after unlink
      [dd0c4e8] generic: test fsync on inode with many hard links
      [b89defa] generic: test fsync on inode with many hard links different=
ly
      [afadb6e] btrfs/017: support all possible page sizes

Xiaoguang Wang (1):
      [573f9ca] ext4/30[23]: ignore EBUSY error


Code Diffstat:

 check                 |  33 +++++++++++++
 common/rc             |   8 ++-
 tests/btrfs/017       |   6 ++-
 tests/btrfs/017.out   |   4 +-
 tests/ext4/302        |   2 +
 tests/ext4/303        |   2 +
 tests/generic/039     | 112 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/039.out |   2 +
 tests/generic/040     | 130 ++++++++++++++++++++++++++++++++++++++++++++++=
++
 tests/generic/040.out |   4 ++
 tests/generic/041     | 133 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/generic/041.out |   3 ++
 tests/generic/group   |   3 ++
 13 files changed, 438 insertions(+), 4 deletions(-)
 create mode 100755 tests/generic/039
 create mode 100644 tests/generic/039.out
 create mode 100755 tests/generic/040
 create mode 100644 tests/generic/040.out
 create mode 100755 tests/generic/041
 create mode 100644 tests/generic/041.out
--=20
Dave Chinner
david@fromorbit.com

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUv24HAAoJEK3oKUf0dfod99oP/iDd9SiXeqNfKk3YjeFGHWQX
urVlkry61EuXbEKCEK3V68S9GUsRjElGWvWtnKFvLk/7sO41N1w8+e7+uhhH87VU
OkL/JurqJ0yFMv/eDpRlDfZCws4iN70Mx51g1ReanIH3Ys3nRlJGiKh1Igv0t5Ie
BhBcH/ceoScOhZNrCRM8/crtp4UK3q0FSxsNNOSJCupAp0GwjfrkEXXWFKPCqoAE
dbDa5MWLJUrB4Bg+lSjo7fG/AXmDX8QoJDIHxfJs5ZjoYCfaQ80mP+Gown+GEhnw
UFPYZCdQCkAGF8DndJUU0pq48meHc+YbI5TJDOM9iUJc1btLHVmQuIZbNzDFn72X
nnbz2k5dm6yxuR9dXsCcTKwt1iEtB8X+1ElquvMuI1IQGgakbM+caz1CsPgK/9tH
ZjfrXZ71KzkU2fxoRYHm85oHZevr/d2oYRqjDY0Uub9m9+QAiPMfqt/8W8ny0g5i
muZYnzZwo8xbFS7XKEU0TY4Db0UTc/1JIuoRV10MKME/MaqM8c4vMNM0nVvLYMGL
0aZ/qwYyHDc8HtIGsjUT7z9ph7mkSMYBijyU6F1/8Gh+/V5chgy/Xorh6YkINO/V
XqMPISOYGVzDMYOlwclgyGMBsik3nrPgsEf4bRW33bg84rBA4qjYq1GBZAL6FiBJ
4Ws1ycu8eEWS9GyU5Mox
=aHDA
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
