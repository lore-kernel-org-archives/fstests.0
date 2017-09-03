Received: from mail-pf0-f174.google.com ([209.85.192.174]:35167 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbdICOW7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Sep 2017 10:22:59 -0400
Received: by mail-pf0-f174.google.com with SMTP id g13so11768356pfm.2
        for <fstests@vger.kernel.org>; Sun, 03 Sep 2017 07:22:59 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id v19sm7254618pfd.63.2017.09.03.07.22.57
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Sep 2017 07:22:57 -0700 (PDT)
Message-ID: <59ac1041.1389620a.c9918.3905@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 03 Sep 2017 22:22:52 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 948b1881f6ee
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CI2AWNR6aMAt"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--CI2AWNR6aMAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Notably, fsx was fixed so that random seed could do its
work, previously all tests ran fsx were running the same operation sequences.
And fsstress was fixed so that it could run direct I/O on non-XFS filesystems.
These two widely used test programs are changing there behaviors, so there're
changes new bugs can be found, though I didn't see any in my release testing.
Other commits are normal new tests, bug fixes and improvements.

It was a busy week last week, many patches were posted for review, 20 of them
are reviewed & accepted in this update. Thanks a lot to who have contributed
patches and/or helped review patches. But there're still some outstanding
patches waiting for review, especially patches from Amir/Josef that add power
failure test frame work using dm-log-write target. Hopefully I'll get them
reviewed in the comming week.

Though there're many updates, I didn't see any new failures in auto group when
running tests with 4.13-rc7 kernel and for-next branch of upstream xfsprogs. If
you see any new failure introduced by test bug please help report and/or
contribute fixes.

Thanks,
Eryu

The new head of the master branch is commit:

948b1881f6ee fstests: filter test and scratch together safely

New commits:

Amir Goldstein (5):
      [5bbc4ffa0d0e] common/rc: convert some egrep to grep
      [9b1358a22b93] common/rc: fix _require_xfs_io_command params check
      [14ceec4027ad] fsx: fixes to random seed
      [048b95ffd4bd] fsx: fix path of .fsx* files
      [211cb9170c19] fsx: fix compile warnings

Darrick J. Wong (7):
      [fc3c28b30784] xfs/{319,323}: don't checksum files after log recovery
      [a0c125b49666] xfs/013: exit cleaner thread if fsstress dies
      [d2f2947517ae] generic/173: don't dump core when mwrite fails
      [34141fb5f3cc] common/rc: fix xfs_io scrub command existence test
      [5cec561327e0] xfs/122: fix the size of fsop_ag_resblks structure
      [1c7f4dbf37c8] xfs: test rmapbt updates are correct with insert/collapse range
      [0e641bc6ebcc] generic: try various unicode normalization games

Ilya Dryomov (1):
      [af04d7247fa3] generic/420: truncate testfile before executing the test

Misono, Tomohiro (1):
      [948b1881f6ee] fstests: filter test and scratch together safely

Ross Zwisler (1):
      [41ab66699051] generic: add test for executables on read-only DAX mounts

Tuomas Tynkkynen (2):
      [d7286fbaa69d] src/t_mtab: Add newlines to error messages
      [8d085f7a03d4] fsx: Fix -Wformat-security warnings

Zorro Lang (3):
      [53600ec6d3f3] generic: test data integrity with mixed buffer read and aio dio write
      [fb3c560d49a8] xfs/095: require 512b sector size SCRATCH_DEV
      [b669b303d02e] fsstress: fallback to block size for min dio size


Code Diffstat:

 .gitignore                                |   1 +
 common/filter                             |  13 +-
 common/rc                                 |  17 +-
 ltp/fsstress.c                            |  23 ++-
 ltp/fsx.c                                 |  41 +++--
 src/aio-dio-regress/aio-dio-cycle-write.c | 271 ++++++++++++++++++++++++++++++
 src/punch-alternating.c                   |  20 ++-
 src/t_mtab.c                              |   8 +-
 tests/btrfs/029                           |  11 +-
 tests/generic/173                         |   3 +
 tests/generic/409                         |   3 +-
 tests/generic/410                         |   3 +-
 tests/generic/411                         |   3 +-
 tests/generic/420                         |   4 +-
 tests/generic/451                         |  90 ++++++++++
 tests/generic/451.out                     |   2 +
 tests/generic/452                         |  73 ++++++++
 tests/generic/452.out                     |   3 +
 tests/generic/453                         | 171 +++++++++++++++++++
 tests/generic/453.out                     |   6 +
 tests/generic/454                         | 167 ++++++++++++++++++
 tests/generic/454.out                     |   6 +
 tests/generic/group                       |   4 +
 tests/xfs/013                             |   4 +
 tests/xfs/095                             |   4 +
 tests/xfs/114                             | 128 ++++++++++++++
 tests/xfs/114.out                         |   9 +
 tests/xfs/122.out                         |   2 +-
 tests/xfs/319                             |   5 -
 tests/xfs/319.out                         |   4 -
 tests/xfs/323                             |   4 -
 tests/xfs/323.out                         |   3 -
 tests/xfs/group                           |   1 +
 33 files changed, 1033 insertions(+), 74 deletions(-)
--
Eryu Guan
eguan@redhat.com

--CI2AWNR6aMAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZrA/aAAoJECZSqilcj+dj2xEP/0tWTisIdYU8XmGIFiiD2XWb
wRXhTxJ58nzVi2r2fABBI02YL5wC6ppFA4RlRldV5fvAHBi5sBi13Xmo73QV7mZ+
CVmB0JZPrEOu9qccu8/GBgecXYXIez6e9hXE3kUTaBy5/4J6BKMMpEHCpGSkHsiM
R/LkJDna+THWFjB9KPNzay3n+L11gbRDoVRxIPMWoC8VRLeC0RoXzJT9U/illzYA
fi9CZv4IkYBBEU1znqhyngjiA2ocOpkYIjM1EqtbNPEMzXLsMCFmIW5jRtGbPzb5
Qm7YRNLgf4cB68HkMZavXCwvWb/kJw0tucXkkXf+QFR+wnqhs6HiPt9xXL4CiGEx
0M+3z+PAJznHhn0heOuPrtV61fqlX/XLEPKo8E65EW678g58awh/1U0R279LFlhe
4iEyu62qHWxiKMuO0am7ZrBn//KVXF59laIY8sxXv5rIrxIpSZzEwfHnytVrPfFk
RTa78HuynyVdzIxRFbtFQkra6coIwTz+vufppqlI4QRwzzPKu6Bl2WgMV99h82TQ
FgNZ/fZHoqr96My5xe7X1WoDDJ22ZZEcwAIb/5ix8AOd8K7bA/978tX5IyZlURpg
ko0dLXqc20gj53L2Tctqs1rfHdEg6jF4PM5o3SKDjtd3Ib+nUE06x2d8TY0karOX
welF6dr5JaORfgzA4xKK
=WewS
-----END PGP SIGNATURE-----

--CI2AWNR6aMAt--
