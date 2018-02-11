Received: from mail-pg0-f42.google.com ([74.125.83.42]:36464 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKQC2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Feb 2018 11:02:28 -0500
Received: by mail-pg0-f42.google.com with SMTP id j9so4869748pgv.3
        for <fstests@vger.kernel.org>; Sun, 11 Feb 2018 08:02:28 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id 14sm23130317pfi.132.2018.02.11.08.02.25
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Feb 2018 08:02:26 -0800 (PST)
Message-ID: <5a806912.8e08620a.98999.5aec@mx.google.com>
Date: Mon, 12 Feb 2018 00:02:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 03cc97346b1d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hDAV6qu06GWt"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--hDAV6qu06GWt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the fsck.overlay basic
tests from zhangyi (F) (which require fsck.overlay binary), many thanks to Amir
for reviewing these tests! There're also three new reflink vs quota tests from
Darrick and one rmapbt swapext block test from Brian for XFS.

I didn't see any new failures when running with latest Linus tree.

Thanks,
Eryu

The new head of the master branch is commit:

03cc97346b1d xfs: rmapbt swapext block reservation overrun test

New commits:

Andreas Gruenbacher (2):
      [ebfd5ba86ada] check: Fix exit status
      [fe3aefba4d17] generic/270: Check for scratch mount success

Brian Foster (1):
      [03cc97346b1d] xfs: rmapbt swapext block reservation overrun test

Darrick J. Wong (3):
      [66f7b4c2ce14] xfs_scrub: remove -y parameter
      [60ba1274f5d7] xfs/348: dir->symlink corruption must not be allowed
      [f2d7e7573b34] xfs: regression tests for reflink quota bugs

Eryu Guan (1):
      [f03cfe78dac0] overlay: renumber tests after merge

zhangyi (F) (5):
      [ab5034f7beda] overlay: add filesystem check helper
      [a79cd9e16141] overlay: define common overlay xattr keys
      [5c1269a61f1d] overlay: add fsck.overlay whiteout test
      [2934b530b8b7] overlay: add fsck.overlay redirect directory test
      [a31eff7814f6] overlay: add fsck.overlay impure xattr test


Code Diffstat:

 check                 |   6 +-
 common/config         |   1 +
 common/fuzzy          |   2 +-
 common/overlay        |  22 +++++
 tests/generic/270     |   2 +-
 tests/overlay/045     | 230 +++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/045.out |  10 ++
 tests/overlay/046     | 266 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/046.out |  11 +++
 tests/overlay/056     | 143 +++++++++++++++++++++++++++
 tests/overlay/056.out |   4 +
 tests/overlay/group   |   3 +
 tests/xfs/286         |   4 +-
 tests/xfs/348.out     |   2 +-
 tests/xfs/440         |  93 ++++++++++++++++++
 tests/xfs/440.out     |  17 ++++
 tests/xfs/441         |  88 +++++++++++++++++
 tests/xfs/441.out     |  13 +++
 tests/xfs/442         | 119 ++++++++++++++++++++++
 tests/xfs/442.out     |   6 ++
 tests/xfs/443         | 106 ++++++++++++++++++++
 tests/xfs/443.out     |   2 +
 tests/xfs/group       |   4 +
 23 files changed, 1146 insertions(+), 8 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--hDAV6qu06GWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJagGiDAAoJECZSqilcj+djCGwQANjZu3Elr/rddpUpmtuIQYUZ
9hTJQpK/KIkNLxEYZFk+2V/fxNUyCo//QRR9+b6zw/VboltCcbm3O5DIDHhLzYit
nne9fzq7Y4PR1o6LMmOOLTjAh8Oj3wuN/NGkWMH0iqMV4MnoQgGzMA0A+fNUCZl4
nnSrLImcOt6PaZ5hnO80GmowIXnRtDKmu1JLtf2vrlzRLKMX5NsGQKtLPY0OxpMA
bXaMHYGqf8Km7Fm+aZ6o0JR/dSzcATyjR3QYbAsAC9cbc6Myb8pieh8Jbn8bChfV
G+TTWgbllXyAUzL9l+rAhbLAmmaXt6Ccu58XcsKZN9AuXUTQ1JKRdhDqALha0qEy
VD3WAAi9ACetW5aq8bGTI9cT9lxC3a0stqUiRBply7rS5dJBYh5wDx+ggFjGB7PN
bWR0dJcwTXhqP4HrePlGiFqiP/hRW70Mq1OyL9UQTwnTw0GzeOUQeVPB6Z7DGH2m
5dvGhepfaKHH3Cm26YjnNy18nXZLA4G4K0KJCkftJQMOt4uYrlh7o8f+8Lw89ZeE
MRlt1DOAnEG16Q9w5fbAfT//bbtnQ/xyCWHcww3PoFumSJa5SsCUm5zIYoOVV/Fq
88DUR7jTJC1Eyk+IEagM+1S6/phMEeZ2CTBa50ENWGsUTGgkhZ4G4Hk1j5Qgo1/F
NDks9kfLU/2Ju4lBB+cV
=Y75C
-----END PGP SIGNATURE-----

--hDAV6qu06GWt--
