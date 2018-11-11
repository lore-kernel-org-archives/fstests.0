Received: from mail-pl1-f194.google.com ([209.85.214.194]:36610 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbeKLBfu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Nov 2018 20:35:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id w24-v6so3114211plq.3
        for <fstests@vger.kernel.org>; Sun, 11 Nov 2018 07:46:57 -0800 (PST)
Message-ID: <5be84eef.1c69fb81.4f2bc.2e57@mx.google.com>
Date: Sun, 11 Nov 2018 23:46:48 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to c236d588140d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lhJ5g4Td6NOO"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--lhJ5g4Td6NOO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relative big update that pulls in 10 new
tests, most of them are for btrfs. And as usual, there're also some minor bug
fixes. Many thanks to those who helped review patches!

New failures introduced by this update:
- overlay/062 is a regression test for a bug that hasn't been fixed
- generic/51[78] fail on btrfs, the fixes are not in Linus tree yet
- ext4/034 fails post-test fsck and dmesg check, the fix is still pending

Thanks,
Eryu

The new head of the master branch is commit:

c236d588140d ext4: regression test for a ENOSPC warning

New commits:

Amir Goldstein (1):
      [8e1e3cd84f53] overlay: test file handle decode with multi lower layers on same fs

Darrick J. Wong (1):
      [3ed4ce655d00] populate: fix leafn creation test for v4 filesystems

Filipe Manana (4):
      [91540ef98011] generic: test attempt to dedup eof block into the middle of a file
      [b5d3e961fe0a] generic: test attempt to reflink eof block into the middle of a file
      [f6879e8a7856] btrfs: add new filter for file cloning error translation
      [97b35b3db97a] btrfs: fix computation of max fs size for multiple device fs tests

Liu Bo (1):
      [c236d588140d] ext4: regression test for a ENOSPC warning

Omar Sandoval (5):
      [d69918100b1a] btrfs: test swap file activation restrictions
      [42fc98da1bdf] btrfs: test invalid operations on a swap file
      [1ab8f151db83] btrfs: test swap files on multiple devices
      [7f67220a2327] btrfs: test device add/remove/replace with an active swap file
      [96c40c9fc4e1] btrfs: test balance and resize with an active swap file

Xiong Murphy Zhou (1):
      [3dc717c148c0] generic/398: filter out extra string from newer mv

Zorro Lang (1):
      [426518fa2e65] generic: verify FIBMAP address overlap


Code Diffstat:

 common/filter         |   6 +++
 common/filter.btrfs   |  17 +++++++++
 common/populate       |   4 +-
 common/rc             |  14 +++++++
 tests/btrfs/035       |   3 +-
 tests/btrfs/035.out   |   2 +-
 tests/btrfs/096       |   7 ++--
 tests/btrfs/096.out   |   2 +-
 tests/btrfs/112       |  25 ++++++++----
 tests/btrfs/112.out   |  48 +++++++++++------------
 tests/btrfs/113       |   4 +-
 tests/btrfs/113.out   |   2 +-
 tests/btrfs/124       |   2 +-
 tests/btrfs/125       |   2 +-
 tests/btrfs/154       |   2 +-
 tests/btrfs/173       |  56 +++++++++++++++++++++++++++
 tests/btrfs/173.out   |   5 +++
 tests/btrfs/174       |  66 ++++++++++++++++++++++++++++++++
 tests/btrfs/174.out   |  10 +++++
 tests/btrfs/175       |  72 ++++++++++++++++++++++++++++++++++
 tests/btrfs/175.out   |   8 ++++
 tests/btrfs/176       |  82 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/176.out   |   5 +++
 tests/btrfs/177       |  63 ++++++++++++++++++++++++++++++
 tests/btrfs/177.out   |   6 +++
 tests/btrfs/group     |   5 +++
 tests/ext4/034        |  78 +++++++++++++++++++++++++++++++++++++
 tests/ext4/034.out    |   8 ++++
 tests/ext4/group      |   1 +
 tests/generic/398     |   8 ++--
 tests/generic/517     |  98 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/517.out |  45 ++++++++++++++++++++++
 tests/generic/518     |  60 +++++++++++++++++++++++++++++
 tests/generic/518.out |  10 +++++
 tests/generic/519     | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/519.out |   3 ++
 tests/generic/group   |   3 ++
 tests/overlay/062     |  86 +++++++++++++++++++++++++++++++++++++++++
 tests/overlay/062.out |   2 +
 tests/overlay/group   |   1 +
 40 files changed, 977 insertions(+), 48 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--lhJ5g4Td6NOO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJb6E6NAAoJECZSqilcj+dj8B4P/1WpQaSOJH8sda7/FBkwmfpO
Lpwei9B8LzaZTdCVg4HeIfI4f6un8A/Mrt/niG78AKz0UigC96EMc88vYc+ZFDYx
3KcXXHMSwHVCpIeJwFSL5jbsBw1BpibEJ/R1as/Xg338AuA3oSpbwe8r1zKwmmLh
QlOgVAzOYvzzMg6OuaQEXTJKnL+B/P2Gkz9AnHaW+yhFuWUUhpVqgHocR7XEyDD6
CztRrzilPhCQ9QvQbUAYkBGE9+6ybWX26Xol17BZZAwSx6LYqULKlrUSzTRrjYel
BGXliZptJYy98ZWW8kuzG4L5wzM8l4Mu9NuUvXaGGqYlAd7vKeqVLBdHBqZhYiXa
N4kJLe2xl8rKRkf+l6oTac+rtMmCCL2v1zDxbuYLZ+zBhJ+7xAtIEteZJ81W2tPM
5vx2b7pih8m7lh/h9xoTt4BUJuzdtXS0XfYEP2GvVM/0PIpS+UQx3i3WEs9ZKCNB
IqAtKan13tA0LQbXrorFp6L52x0sQvxdQ3r5A0Zmo/8t9jOzj5BLAEiUmG3uvRXY
7yqUlQEdnPUTwRlM9/qOkxY9SjoG6ynfDNXl/AzowRawZ3/n5DuiZ/TO8HXL8x4v
J5WtRDUJKNiZwM4SI4sG1nyvo2KEpAs0wHxGyN6YO1iT6ZR8E+Nny7lDiZ7j8f2/
Wxe/d4o4jfy6KJkANbYm
=xwaE
-----END PGP SIGNATURE-----

--lhJ5g4Td6NOO--
