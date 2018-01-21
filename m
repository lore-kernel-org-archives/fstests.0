Received: from mail-pg0-f51.google.com ([74.125.83.51]:35001 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeAUOTZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jan 2018 09:19:25 -0500
Received: by mail-pg0-f51.google.com with SMTP id d6so5046239pgv.2
        for <fstests@vger.kernel.org>; Sun, 21 Jan 2018 06:19:25 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id u26sm29076871pfk.126.2018.01.21.06.19.23
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jan 2018 06:19:23 -0800 (PST)
Message-ID: <5a64a16b.9a9c620a.f3b52.0088@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 21 Jan 2018 22:19:17 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 5acc29ad7048
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0zoIINlQiasN"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--0zoIINlQiasN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Thanks to Richard Wareing, who brought better test
experience to realtime XFS, though currently the efforts are mainly focusing on
tests in 'quick' group. Other updates are normal bug fixes and a new test for
XFS.

I didn't see any new failure introduced by this update.

Thanks,
Eryu

The new head of the master branch is commit:

5acc29ad7048 xfs: Regression test for invalid sb_logsunit

New commits:

Liu Bo (2):
      [372e96e92ce5] btrfs/011: umount device in _cleanup
      [67c2db9a1891] btrfs/027: unmount scratch device if test fails

Richard Wareing (3):
      [e3c3d4697802] xfs/realtime: Add require_no_realtime function
      [ee3e00103527] xfs/realtime: add _require_no_rtinherit function
      [21e739820378] xfs/realtime: Fix direct invocations of xfs_repair

Ross Zwisler (2):
      [1ee97207dce2] shared/272: don't use data journaling with DAX
      [7ae94a0462f3] common/dmthin: dm-thin lacks DAX support

xiao yang (3):
      [e33b0351dae3] common/xfs: Check if write supports [-c|-d] option in xfs_db
      [a3b3cf68fb90] common: Add _require_no_xfs_bug_on_assert and factor out filter_xfs_dmesg
      [5acc29ad7048] xfs: Regression test for invalid sb_logsunit


Code Diffstat:

 common/dmthin     |  5 ++++
 common/filter     | 11 +++++++
 common/rc         | 28 ++++++++++++++++--
 common/xfs        | 29 +++++++++++++++++--
 tests/btrfs/011   |  4 +++
 tests/btrfs/027   |  2 ++
 tests/generic/250 |  3 ++
 tests/generic/252 |  3 ++
 tests/generic/441 |  3 ++
 tests/shared/272  |  1 +
 tests/xfs/070     |  5 +++-
 tests/xfs/077     |  2 ++
 tests/xfs/098     | 18 ++++--------
 tests/xfs/115     |  5 ++--
 tests/xfs/170     |  1 +
 tests/xfs/189     |  1 +
 tests/xfs/284     |  2 ++
 tests/xfs/291     |  5 +++-
 tests/xfs/439     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/439.out |  2 ++
 tests/xfs/group   |  1 +
 21 files changed, 195 insertions(+), 21 deletions(-)
--
Eryu Guan
eguan@redhat.com

--0zoIINlQiasN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaZKDLAAoJECZSqilcj+djtucQAMY9bno5oOhLSV3Vl0vWBhSD
8q2zkEoNS8hcDczcRsGt3KjEgWOogUjsf8Bq6ZZyXktYyUO5f/m3pACQaTwIOF5/
7YQRv80csZyFq6Nl7NR/Ey5SXMNZOlU3/1MakKFYjswlEWZL9zbTPIprSJXHO9AT
eF4rL3UsptxoJ1zOgpMVV839ELdQRCyvGj/QWBOJ0fu/l3jwPWE/u7F9q9RjDSW5
XfOISk2xTMi02bzhSLj1bTDWN1aR9eiiuoxqY6/RQUgT98usjnInhVQIituju4Dc
KqZ5KL/7ck4AwIQIydeRV6l+mfNF8inQytFpeGxVCEOLT3FA0VrZyW/vZXdbYnzM
DKIjx7rUs44WjAYuaZxY6RbH0Nr+mSPOGLBtIwAn09PG07LHPVJ+Lq1/BtjGmuen
W6FbezK1MvelgA12dcdUkrieDVBziBLJQlTM/9EiNJ23s1UiduxZb6SQFfMyHrQg
JPICNgP55vNFn+GLGHBdYVCc8zk7SVkYPa63QAYflafD/oms2d2O/MsiThsPq1eY
YAQuEs6yHQdTpDg0aWUpAhEZfUT4nLjO7FmGsky6DaIWAqfkKINduftCbH2qYf9T
+c0N6iqKV0wN2CFqbcKXc38n3rYx759k2N/eArY4QMTVrI07tqKeJCuwb7clI7Gp
Ce/y6RgNJgGXb8aRYToG
=B6Cv
-----END PGP SIGNATURE-----

--0zoIINlQiasN--
