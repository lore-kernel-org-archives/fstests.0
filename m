Received: from mail-pf0-f193.google.com ([209.85.192.193]:35096 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdFXPTc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 24 Jun 2017 11:19:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so11701761pfs.2
        for <fstests@vger.kernel.org>; Sat, 24 Jun 2017 08:19:32 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id v205sm15218497pgb.51.2017.06.24.08.19.30
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Jun 2017 08:19:30 -0700 (PDT)
Message-ID: <594e8302.d661630a.13d0d.d751@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sat, 24 Jun 2017 23:19:28 +0800
Subject: [ANNOUNCE] fstests: master branch updated to a00c51a0816a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p54zNeEW08uU"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--p54zNeEW08uU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains 8 new tests, notably I've merged
tests for the new behavior on writeback error handling from Jeff, so you'll see
these tests fail on latest 4.12-rc6 kernel. Other than that, there're also new
xfs, overlayfs and generic tests added, and ext3/ext4 gain external journal
device support.

New failures I've noticed in this update
- generic/441 tests the new writeback error handling and fails on ext2, it also
  fails on ext3/4 and xfs when testing with external log device set
- generic/442 also tests the new writeback error handling, but it tests the
  block device, so it's not in auto group and probably you won't see this
  failure
- generic/444 is a new sgid test when working with default ACL, it currently
  fails on ext2/3/4, xfs, btrfs and NFSv3. The fixes are still in review
- overlay/031 tests an overlay bug which hasn't been fixed yet

Thanks,
Eryu

The new head of the master branch is commit:

a00c51a0816a generic: Test SGID inheritance with default ACLs

New commits:

Darrick J. Wong (3):
      [6813e5213df8] xfs: don't allow realtime swap files
      [1bd599745efd] xfs/040: use compare-libxfs in xfsprogs
      [ca9c67734661] xfs: seek data and holes that are in the CoW fork only

Jan Kara (1):
      [a00c51a0816a] generic: Test SGID inheritance with default ACLs

Jeff Layton (5):
      [86e398347685] ext4: allow ext4 to use $SCRATCH_LOGDEV
      [39c3f812deb7] ext3: allow it to put journal on a separate device when doing scratch_mkfs
      [702421f52891] generic: add a writeback error handling test
      [d6b986f3cb39] generic: test writeback error handling on dmerror devices
      [5d599421defe] btrfs: make a btrfs version of writeback error reporting test

Zorro Lang (1):
      [a8b4891d0f90] generic: test writev with page fault when it processes iov

zhangyi (F) (1):
      [10ad7501694a] overlay: test whiteout check in impure dir


Code Diffstat:

 .gitignore                 |   2 +
 common/dmerror             |  13 +-
 common/rc                  |  14 +-
 doc/auxiliary-programs.txt |  16 +++
 src/Makefile               |   6 +-
 src/dmerror                |  44 +++++++
 src/fsync-err.c            | 223 ++++++++++++++++++++++++++++++++
 src/writev_on_pagefault.c  | 114 ++++++++++++++++
 tests/btrfs/146            |  97 ++++++++++++++
 tests/btrfs/146.out        |   3 +
 tests/btrfs/group          |   1 +
 tests/generic/441          |  84 ++++++++++++
 tests/generic/441.out      |   3 +
 tests/generic/442          |  63 +++++++++
 tests/generic/442.out      |   2 +
 tests/generic/443          |  61 +++++++++
 tests/generic/443.out      |   2 +
 tests/generic/444          |  71 ++++++++++
 tests/generic/444.out      |   3 +
 tests/generic/group        |   4 +
 tests/overlay/031          |  97 ++++++++++++++
 tests/overlay/031.out      |   2 +
 tests/overlay/group        |   1 +
 tests/xfs/040              |  30 ++---
 tests/xfs/040.good         |  16 ---
 tests/xfs/040.out          | 171 +++++++++++++++++++++++-
 tests/xfs/419              |  74 +++++++++++
 tests/xfs/419.out          |   5 +
 tests/xfs/420              | 160 +++++++++++++++++++++++
 tests/xfs/420.out          |  52 ++++++++
 tests/xfs/421              | 160 +++++++++++++++++++++++
 tests/xfs/421.out          |  52 ++++++++
 tests/xfs/group            |   3 +
 tools/srcdiff              | 316 ---------------------------------------------
 34 files changed, 1607 insertions(+), 358 deletions(-)
--
Eryu Guan
eguan@redhat.com

--p54zNeEW08uU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZToJVAAoJECZSqilcj+djHqYP/icvhZim3U5hxf1Hx3yZEEy+
P5V1mk9gq0IpzmoZDug4O+wRvyGKTNKqM5sh/1NfXcf3S5lysRezjjk624ch3avZ
BcDezMFJV/EYPUel3LvEF1Id3Hlky0xTKtl4xdLDC1HRtKn3tLpid+6m4MffzCY0
2kIIWDknNxK1UMj51mlKV/zP6dZy4Nko30+mcCtVLRG0Yzap8hPjSDZMljWIB16r
hxtwqadZptb+zPhwJGTJcYLbtGiRu84iNmNquVQytaXzNrU+KtiiuexdVzul6VpO
tFxmjDT3FDf3KeqpQqJBP2zREffFoHYEdKfta1XFkRHCUduRgqBZODv3uI8rvLPE
oc+UNrNTP5Rbr95fepuYvGiEuaDSXMSyIJ2bPDfzmCo1TboNN1GnjUleI7U8sFQQ
FLBssw/JuFRd/X72iR9jLAqfpyz1ELqGZ4SvVIRIMSHmG6Q/0O0Wuvb06N2IhlvI
dXOHXSU0UBNoJAVoXIF45+FmEMgbExUfkCLeFzwPKiRPOAXbLAkAd/ZD6l8XWSwE
qsQ0i2X6EH6wjd/ns1+Ryrw86FwzvWeC+0blCDxX18WHMYMJUB8YI9RNYDyc6gtn
wtRPiHYXQqxGMCaKgw19AVuoPCqe/1sdxld3gLubNmqt5IhQ1fW8fRAzzSdLADCl
alAD7otP3GhJSVxSjAtX
=gLOy
-----END PGP SIGNATURE-----

--p54zNeEW08uU--
