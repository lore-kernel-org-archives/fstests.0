Received: from mail-pg1-f193.google.com ([209.85.215.193]:39191 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfFPOys (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Jun 2019 10:54:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so4316146pgc.6
        for <fstests@vger.kernel.org>; Sun, 16 Jun 2019 07:54:48 -0700 (PDT)
Message-ID: <5d065837.1c69fb81.8cee2.9fbd@mx.google.com>
Date: Sun, 16 Jun 2019 22:54:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 12b7dddbc265
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pu0350APJwYP"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Pu0350APJwYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. New infrastructure and new test to test filename
casefold feature (mainly for ext4 at the moment) have been added in this
update. There's also a new generic test to exercise FS_IOC_FSSETXATTR ioctl
without proper capability. And as usual, there're a bunch of random fixes are
included as well.

overlayfs would fail generic/555 with v5.2-rc4 kernel. Hopefully the mentioned
fix in commit log will be merged soon.

Thanks,
Eryu

The new head of the master branch is commit:

12b7dddbc265 generic: Add tests for filename casefolding feature

New commits:

Amir Goldstein (6):
      [dfc4506cf450] generic/553: fix test description
      [803d3afd2f0d] generic/554: test only copy to active swap file
      [c42c8e6c2adc] fstests: don't oom the box opening tmpfiles (take 2)
      [8de6e5535b31] common/rc: print out xfs_io parameter when command fails
      [e28c4e69a433] fstests: check for filesystem FS_IOC_FSSETXATTR support
      [654a7814ad1b] generic: check CAP_LINUX_IMMUTABLE capability with FS_IOC_FSSETXATTR

Filipe Manana (1):
      [71400f712a42] btrfs/146: remove unnecessary scratch unmount to avoid test failure

Gabriel Krisman Bertazi (1):
      [82feab4079b5] common/casefold: Add infrastructure to test filename casefold feature

Lakshmipathi.G (1):
      [12b7dddbc265] generic: Add tests for filename casefolding feature

Theodore Ts'o (2):
      [ffdecf7498a1] report: gracefully handle XML report creation when no tests are run
      [2b42b7e164cb] ext4/035: skip this test if DAX is in use


Code Diffstat:

 common/casefold              |  90 ++++++++
 common/rc                    |  30 ++-
 common/report                |   7 +-
 doc/requirement-checking.txt |   2 +-
 tests/btrfs/146              |   1 -
 tests/ext4/035               |   1 +
 tests/generic/531            |   4 +-
 tests/generic/553            |  10 +-
 tests/generic/554            |   6 +-
 tests/generic/554.out        |   1 -
 tests/generic/555            |  74 +++++++
 tests/generic/555.out        |   9 +
 tests/generic/556            | 509 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/556.out        |  16 ++
 tests/generic/group          |   2 +
 tests/xfs/260                |   2 +-
 tests/xfs/431                |   2 +-
 tests/xfs/502                |   4 +-
 18 files changed, 744 insertions(+), 26 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Pu0350APJwYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJdBlfuAAoJECZSqilcj+dj5BYP/ju+t/ln8mD3nAkbuEYgUiJM
yaYDsPSsv+r0DViJQwFKV3qPTirSb7JJPdVDCApsHqKbGbrheBY+uhJHJwMLfo+v
3cD9ykrn6MWel8miLrKsZm16Ke9BvFVc/pTOxK7LRZGHJrmbIQlYmxcV7n5UJuCU
pqOm+O0+5LUz6le3pujs4QUMPZH+DmPghxOpBkc8l2nu8Qls8C3ZXO0FMg+FnwGc
fwYx6VB1yBW9pd4Xsx1DkulQnWLzRRn6OwTWUruNKrjmqcub5e3f4TXJskoJXWE6
bCVu4RFezuOvQtBZW+yYQ/DdwO/BLwqv9Y94R5rhTOSZsRtVkgaZvXrFjc4kgnKC
vVWpinWaDkdMhR6HGyofN5mVBYjmBWkivZxuKu02F2trUFpqI13BzWmWa1TpZ9wy
KN6LrtNe5z/jNxgXHxmzl7+/sMjx4FplnvUemJD/77xyKXQYwsG9Ma3TyIU4FX33
U+boknJ6LQlVCUBnzj/FopHVnYZ8eWSK9VZKve9VnU540MT2HmXVUIzYVYg1yzCf
R2BNsy3yRGzfR27oSiQ+9qO5E0JWGMqE8I/HAcE5y0EBzNdQUO3DOvfWb8zMkFWx
19lr5nBMlMgxt3yGb04kn+Q8eEtATtqypYFnbvzzvvy0C+sad/wUQWX9KdqGNPhB
9NttJM5u8i9VxumwYR1P
=NcGU
-----END PGP SIGNATURE-----

--Pu0350APJwYP--
