Received: from mail-pf0-f171.google.com ([209.85.192.171]:34205 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754504AbdDPBMX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 15 Apr 2017 21:12:23 -0400
Received: by mail-pf0-f171.google.com with SMTP id c198so53276758pfc.1
        for <fstests@vger.kernel.org>; Sat, 15 Apr 2017 18:12:23 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id s65sm10325396pgb.34.2017.04.15.18.12.21
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Apr 2017 18:12:21 -0700 (PDT)
Message-ID: <58f2c4f5.445e630a.ddd1e.8dd3@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 16 Apr 2017 09:12:16 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 7e0b48b33d1c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jrjhC0FDTIYd"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--jrjhC0FDTIYd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The new statx(2) syscall tests have been added in this
update, many thanks to David Howells and those who have helped review these
tests! Also, pvfs2 (orangefs) support has been added. And as usual, there're
new generic test and other bug fixes as well.

New failures I've noticed in this update:
- generic/425 fails on XFS

Thanks,
Eryu

The new head of the master branch is commit:

7e0b48b33d1c xfs/348: update error message when transmogrifying symlink into directory

New commits:

Darrick J. Wong (2):
      [0e613380dcf3] generic: test FIEMAP on extended attribute blocks
      [7e0b48b33d1c] xfs/348: update error message when transmogrifying symlink into directory

David Howells (4):
      [29f8137fcb43] fstests: Add an auxiliary program to create an AF_UNIX socket
      [d1ba8b79a600] generic: Add first statx test
      [b22a8fe0c7af] doc: Partially expand the documentation
      [c3ff9ee3fe1b] generic: Check the stx_attributes settable by chattr

Eryu Guan (1):
      [0b6b693c632f] generic/422: check fallocate KEEP_SIZE flag correctly

Liu Bo (1):
      [9fefd025d875] btrfs: remove snapshot aware defrag test

Martin Brandenburg (1):
      [85c95c7f24b1] fstests: add orangefs (pvfs2) support


Code Diffstat:

 .gitignore                   |   2 +
 check                        |   2 +
 common/attr                  |   4 +-
 common/rc                    |  53 ++-
 doc/auxiliary-programs.txt   |  56 +++
 doc/requirement-checking.txt |  97 ++++++
 src/Makefile                 |   4 +-
 src/af_unix.c                |  66 ++++
 src/stat_test.c              | 790 +++++++++++++++++++++++++++++++++++++++++++
 src/statx.h                  | 174 ++++++++++
 tests/btrfs/010              |  93 -----
 tests/btrfs/010.out          |   2 -
 tests/btrfs/group            |   1 -
 tests/generic/422            |   2 +-
 tests/generic/423            | 180 ++++++++++
 tests/generic/423.out        |  11 +
 tests/generic/424            | 155 +++++++++
 tests/generic/424.out        |   2 +
 tests/generic/425            |  92 +++++
 tests/generic/425.out        |   5 +
 tests/generic/group          |   3 +
 tests/xfs/348.out            |   2 +-
 22 files changed, 1693 insertions(+), 103 deletions(-)
--
Eryu Guan
eguan@redhat.com

--jrjhC0FDTIYd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJY8ijmAAoJECZSqilcj+djRS4QALRjPEwCyIuwRne3WbGnabVQ
h8WJ5Oi2h6K4+wKeQRPt7tjNJK9blM6tXkWIEvcA4x36/jW0lDWAzioUtfthqTi8
Q1qUWiIskmZhDiq2AntwrITnMSe9xZFxPALHpRMSWwwfmzFjkxRJVtfPVxGYc4EF
fSDgn4WsI7uhliCqtVTKIUTO7xI3DAB3vfs9yhNGAo87WxMEqBcNR2kKeRSFj9wo
m2w8FdmLDyv882Er3yFLB1lAWGjbdLfpXy2wZ9XbfERF5FQyEN4Wojv4bR5SXrk1
FLZpGiLqkz4b6Jf+B/Hqj8Vzf6/5l04ygjctOJvueD7UapiDB6DJYKsQDbmfHQsh
qkhuKC6n4J2uIuqRj/zGQXQQUxaePHsrUlvnuK2R1MyBmoO4B3FKpo836tC988vv
qSehDXXIoG9hSiLKOOi+//u1mIKf5loo8rTTWN1I0X57cMyo0T8e4Lkh08sbLPDx
hiBJbDs/Q1W+qsjXnF6+MqsOf+y6NnQx0dZhvZxT8BK75jXAGSAPVtLt3yMR2WQk
yXEX1sqHfWlByjuZt9v3jz1QlWkCL/GItg/D45+3ZI7G34nT108M1qM0/sU8XwBX
7Bm9V3ujg6HjFjNJuu9Km7qyJfNTL1dVGvOhAmT+F0Gyp8itKQN5ADXgMCGQiT2w
HTuqkF0bQJyS9txidtXz
=1fCw
-----END PGP SIGNATURE-----

--jrjhC0FDTIYd--
