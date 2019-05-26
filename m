Received: from mail-pg1-f195.google.com ([209.85.215.195]:39040 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEZPAB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 May 2019 11:00:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id w22so7634800pgi.6
        for <fstests@vger.kernel.org>; Sun, 26 May 2019 08:00:01 -0700 (PDT)
Message-ID: <5ceaa9ef.1c69fb81.295aa.84e9@mx.google.com>
Date: Sun, 26 May 2019 22:59:53 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 1113a8aa2051
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9rnsgoLDCi1D"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--9rnsgoLDCi1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relative big update that contains 13 new
commits, which adds 6 new tests (3 btrfs tests and 3 xfs tests) and fixes
various bugs in tests.

You may see btrfs/18[89] and btrfs/190 fail with latest kernel.

Thanks,
Eryu

The new head of the master branch is commit:

1113a8aa2051 xfs: basic testing of new xfs_spaceman health command

New commits:

Darrick J. Wong (5):
      [3fac0b7c31bc] generic/530: revert commit f8f57747222
      [afeb3b711cbe] generic/530, xfs/501: pass fs shutdown handle to t_open_tmpfiles
      [58937c3f24da] fstests: use _scratch_shutdown instead of calling src/godown
      [cf2030a0c398] xfs: validate unicode filesystem labels
      [1113a8aa2051] xfs: basic testing of new xfs_spaceman health command

Filipe Manana (2):
      [c37f9a66df67] btrfs: send with no-holes enabled, fallocate and hole punching
      [e6e98a855a76] btrfs: send after cloning and truncating source file

Luis Henriques (4):
      [c9589693233d] src/attr_replace_test: limit size of extended attribute value
      [b6d45325f822] generic/319: use numeric user and group IDs in getfacl
      [9f2e4554c53d] overlay/023: use numeric user and group IDs in getfacl
      [0eccec6cdbac] generic/{436,445}: define _cleanup function earlier in the tests

Murphy Zhou (1):
      [828d146a86c7] generic/54{0..3}: redirect FILEFRAG error output to .full too

Qu Wenruo (1):
      [cfbd28d6c4c1] btrfs: resume balance on mount with qgroup


Code Diffstat:

 common/rc               |  29 +++++++++
 common/xfs              |   7 +++
 src/attr_replace_test.c |   3 +
 src/t_open_tmpfiles.c   |  29 ++++++++-
 tests/btrfs/188         |  84 ++++++++++++++++++++++++++
 tests/btrfs/188.out     |  13 ++++
 tests/btrfs/189         | 105 +++++++++++++++++++++++++++++++++
 tests/btrfs/189.out     |  21 +++++++
 tests/btrfs/190         |  92 +++++++++++++++++++++++++++++
 tests/btrfs/190.out     |   2 +
 tests/btrfs/group       |   3 +
 tests/generic/050       |   2 +-
 tests/generic/319       |   4 +-
 tests/generic/319.out   |   8 +--
 tests/generic/436       |  14 ++---
 tests/generic/445       |  14 ++---
 tests/generic/453       |  16 +----
 tests/generic/454       |  16 +----
 tests/generic/530       |   4 +-
 tests/generic/540       |   8 +--
 tests/generic/541       |   8 +--
 tests/generic/542       |   8 +--
 tests/generic/543       |   8 +--
 tests/overlay/023       |   2 +-
 tests/overlay/023.out   |   4 +-
 tests/xfs/051           |   2 +-
 tests/xfs/079           |   2 +-
 tests/xfs/121           |   4 +-
 tests/xfs/181           |   4 +-
 tests/xfs/501           |   4 +-
 tests/xfs/504           | 153 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/504.out       |   2 +
 tests/xfs/505           |  52 ++++++++++++++++
 tests/xfs/505.out       |   2 +
 tests/xfs/506           |  82 ++++++++++++++++++++++++++
 tests/xfs/506.out       |   3 +
 tests/xfs/group         |   3 +
 37 files changed, 733 insertions(+), 84 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--9rnsgoLDCi1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJc6ql0AAoJECZSqilcj+djVUgQAKUZ84PPm729lFGwsheD++Tz
z0sg4QkCvZmLC5hjB7DQvmvBRiBkZgAE7ogPhy25H+vuXmIe3ifuIo2ipOfXNjW5
yqE31LUWpiQg5exlbJ1+1vXoKfyQLmuHai9RcA+LCdHqUUoRNNBwZjT9Bk5gw6Fl
8FDxBdke0PDZOg1X2pKNcQpp62G6PA6vSU4D8ocRmQT1QsGzQcwaWll7MQ420zxb
aNPR5arBwrCNov7wAVYqoQioDFR3SFGVcso7bEgxQ1TvIesSybAlXPWQJSTR9zS7
WsD+wsDd7cGCo7sBWPvbfHfW25uX4+4NWHCQnNC2txdR4WYJe5eREfYanPca2s7p
3LgNlzRD+CO9pqe3cndLbGfgbiScHG2MZTlMI1/hXqWcru2jfMd+tuarpnm1w5c7
0UY4hIoOwhlUa14oRZqVuFE7UUiYH2wrlx4dfYd6l0Qqe8P+G6qBn4s0LQlEg5hq
A9fCHWQ0iashiHvKN35qk0tR5qk05BVUIiMeL5vJIM7Xa49/t8CZBO9z/aTFfV++
UGRLAmbylE+LebqV6pQl4m2XhufKtpBiTQ6QDzaHZokYkxlskrq9vN1w0evYW1Dt
16krABOVLKbGBP82IxCLm2f03zcg81jcXqwDfpy6xj+q1iVfZftJ3ysqbqBZPvfR
3et/V4PhedS0KeBX1V1o
=DqDz
-----END PGP SIGNATURE-----

--9rnsgoLDCi1D--
