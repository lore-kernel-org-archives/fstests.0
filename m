Received: from mail-pf0-f176.google.com ([209.85.192.176]:33561 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdDBOPj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Apr 2017 10:15:39 -0400
Received: by mail-pf0-f176.google.com with SMTP id s16so22726293pfs.0
        for <fstests@vger.kernel.org>; Sun, 02 Apr 2017 07:15:39 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id b10sm20584748pga.39.2017.04.02.07.15.37
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Apr 2017 07:15:37 -0700 (PDT)
Message-ID: <58e10789.0a34630a.21b0.eb31@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 02 Apr 2017 22:15:33 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 98ac3be36022
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qywp53FxmPPY"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--qywp53FxmPPY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. In this update, mmap read/write operations are added to
fsstress, many thanks to Zorro! Also there're new punch hole test and fs
encryption test, and btrfs command line fixes.

New failures I've noticed:
- generic/420 fails on XFS, the fix is in XFS list for review

Thanks,
Eryu

The new head of the master branch is commit:

98ac3be36022 generic: test encryption key revocation during concurrent I/O

New commits:

Calvin Owens (1):
      [9d0c04653458] generic: Add test for fallocate() PUNCH_HOLE|KEEP_SIZE

David Sterba (2):
      [df8c7225ba00] btrfs: reorder arguments so that options come first
      [2fd80caf7175] btrfs: use full subcommand names

Eric Biggers (1):
      [98ac3be36022] generic: test encryption key revocation during concurrent I/O

Zorro Lang (2):
      [4e7d1c5e09eb] fsstress: add mwrite/mread into test operation list
      [5d36d8585afc] xfs/068: update golden output due to new operations in fsstress


Code Diffstat:

 common/encrypt        |   8 +++
 configure.ac          |   1 +
 ltp/fsstress.c        | 159 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/global.h          |   4 ++
 tests/btrfs/008       |   4 +-
 tests/btrfs/016       |   7 ++-
 tests/btrfs/019       |   2 +-
 tests/btrfs/025       |  10 ++--
 tests/btrfs/027       |   2 +-
 tests/btrfs/030       |  10 ++--
 tests/btrfs/034       |  10 ++--
 tests/btrfs/036       |   2 +-
 tests/btrfs/038       |  12 ++--
 tests/btrfs/039       |  10 ++--
 tests/btrfs/040       |  10 ++--
 tests/btrfs/043       |  10 ++--
 tests/btrfs/044       |  10 ++--
 tests/btrfs/045       |  10 ++--
 tests/btrfs/046       |  10 ++--
 tests/btrfs/048       |  10 ++--
 tests/btrfs/050       |   4 +-
 tests/btrfs/051       |   4 +-
 tests/btrfs/053       |  10 ++--
 tests/btrfs/054       |  10 ++--
 tests/btrfs/058       |   2 +-
 tests/btrfs/077       |  10 ++--
 tests/btrfs/083       |  10 ++--
 tests/btrfs/084       |  10 ++--
 tests/btrfs/085       |   6 +-
 tests/btrfs/087       |  10 ++--
 tests/btrfs/092       |  10 ++--
 tests/btrfs/094       |  10 ++--
 tests/btrfs/097       |  10 ++--
 tests/btrfs/105       |  10 ++--
 tests/btrfs/108       |   4 +-
 tests/btrfs/109       |   4 +-
 tests/btrfs/110       |  12 ++--
 tests/btrfs/111       |  20 +++----
 tests/btrfs/117       |  12 ++--
 tests/btrfs/127       |  10 ++--
 tests/btrfs/128       |  10 ++--
 tests/btrfs/129       |  10 ++--
 tests/btrfs/133       |  18 +++---
 tests/btrfs/134       |  12 ++--
 tests/btrfs/135       |  18 +++---
 tests/btrfs/137       |  10 ++--
 tests/generic/420     |  65 +++++++++++++++++++++
 tests/generic/420.out |   4 ++
 tests/generic/421     | 110 ++++++++++++++++++++++++++++++++++
 tests/generic/421.out |   2 +
 tests/generic/group   |   2 +
 tests/xfs/068         |   2 -
 tests/xfs/068.out     |   2 +-
 53 files changed, 547 insertions(+), 197 deletions(-)
--
Eryu Guan
eguan@redhat.com

--qywp53FxmPPY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJY4QbgAAoJECZSqilcj+djlt8QALtjFtNbZMPQGj6uOX0/W8YN
oGJtX7pbWnPt7+B4tr8Q3LD4AFS/brb3L+kPbZtrympFPQ51wWYk8TnE6dDFkdEp
84JXDRV84JrSNLiP4XoCIEmfDtyZ+f6puhHO92xGbWkSy/+G/cqmZYrpCy+fZCSw
RLVTH4aXrh76Ed/fo1EDbDHw400h0z1SB/8kpbgcJ/cV0ZZScDeTr9mDq+QlHd8e
MXQ+SQrCneLLM55SJoYZ9v5FootANKuDaODRsNJnXQtmu+bwr1T7JGr71sD35Fq+
ARkTfv8CieGxvnnFcgTM5b6O6ikPodI3dS1UgKFRP6Pjf6p9Xmh7lmtX8J804+g0
AsAqnpvbMXFXQQw3UE5p7isXqJs1Xs8iX/1MwYRFNc75h4expFR9JkZ5ecDMnukV
u12QdsJQwQrwxpj+9RvaN9fV8Op7tUtf8mRq3NAvuCjoY/QT7ZHxm6J7oArU8NuH
kINIi9MPXMT3CYS4zRFYsdnDbTbK352YEB+0LIeP5dDD2Bz1CAT95WYRgAA4FT65
Rqa0hIfg7d2p8+KBdQtVrKSLX60YHL8fgwynKkWQz1ClKtTOZZgFq9Ft7doAC9NL
BFJtiQPRJ0Rox/WSxc/7KNNw59J5F4UxbL+kW1ocZSvCGZJMA04mFfs38mX3Q6I1
bLoZKpLU4nw6MolMsSr4
=DTjr
-----END PGP SIGNATURE-----

--qywp53FxmPPY--
