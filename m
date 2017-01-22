Received: from mx1.redhat.com ([209.132.183.28]:43060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdAVF0u (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 22 Jan 2017 00:26:50 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22C5A51440
        for <fstests@vger.kernel.org>; Sun, 22 Jan 2017 05:26:51 +0000 (UTC)
Received: from localhost (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0M5QnTT003455
        for <fstests@vger.kernel.org>; Sun, 22 Jan 2017 00:26:50 -0500
Message-Id: <201701220526.v0M5QnTT003455@int-mx13.intmail.prod.int.phx2.redhat.com>
Date: Sun, 22 Jan 2017 13:26:48 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 8485d738b418
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VYG6C5jB6OQk"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--VYG6C5jB6OQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're new generic, overlay and btrfs tests in this
update, and as usual, various fixes.

New failures I've noticed in this update:
- xfs/348 fails, new tests added to it but the fixes are not in Linus tree yet
- btrfs/13[3-5], these new btrfs incremental send tests fail
- generic/405 fails on extN filesystems, it's an e2fsprogs bug

Thanks,
Eryu

The new head of the master branch is commit:

8485d738b418 btrfs: incremental send after replacing directory

New commits:

Amir Goldstein (3):
      [91e16aa7c502] overlay: test concurrent copy up
      [707a5890cadb] xfs: test fstat with malformed inode mode
      [9b80c46ed0d3] xfs: test readlink/readdir with malformed inode mode

Boyang Xue (2):
      [6f4776c4b50b] common/dmthin: call $UDEV_SETTLE_PROG before 'dmsetup remove'
      [66768bcaec8c] generic/405: test mkfs against thin provision device

Christoph Hellwig (1):
      [8c3d7ebd2390] xfs/004: account for XFS reservations changes in 4.10-rc

David Sterba (1):
      [acb8acd2367a] common/btrfs: add helper to detect dump-super or btrfs-show-super

Eric Sandeen (1):
      [2ad516747539] tools: compare-failures script

Filipe Manana (3):
      [6fc65f42eb9b] btrfs: incremental send after replacing a top level inode
      [7cf665d9a422] btrfs: incremental send after moving a directory
      [8485d738b418] btrfs: incremental send after replacing directory

Lakshmipathi.G (1):
      [8a0831c03ce5] README: Fix Quick start typo

Xiao Yang (1):
      [3241b54ed48e] common/rc: Fix _supports_filetype function


Code Diffstat:

 README                 |   5 +-
 common/btrfs           |  11 ++++
 common/dmthin          |   3 +
 common/rc              |   6 +-
 tests/btrfs/011        |   2 +-
 tests/btrfs/133        | 127 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/133.out    |   8 +++
 tests/btrfs/134        | 125 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/134.out    |   6 ++
 tests/btrfs/135        | 159 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/135.out    |   8 +++
 tests/btrfs/group      |   3 +
 tests/generic/405      |  73 +++++++++++++++++++++++
 tests/generic/405.out  |   2 +
 tests/generic/group    |   1 +
 tests/overlay/021      | 135 +++++++++++++++++++++++++++++++++++++++++
 tests/overlay/021.out  |   2 +
 tests/overlay/group    |   1 +
 tests/xfs/004          |  23 ++-----
 tests/xfs/348          |  25 ++++++++
 tests/xfs/348.out      | 112 ++++++++++++++++++++++++++++++++++
 tools/compare-failures |  67 +++++++++++++++++++++
 22 files changed, 882 insertions(+), 22 deletions(-)
--
Eryu Guan
eguan@redhat.com

--VYG6C5jB6OQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYhED+AAoJECZSqilcj+djBDYQAN/fie4/XK6e/KWYwRk1xTcp
EPWMs2EvJ185CylN0JKRYE6JyNnVpqpEiTw5W4UB0jebPIupGyxcBTBmVOsZAv55
BOdcF7xS1j8dWu0DSu8LHOogr/2qRZz1Hh04tamWB1fDZDHPVB2j4fy4L+g6HfZk
YelrYLrdSRqwDH2gnIWBDnLw6R3I62Hl0xGp11mui+KmMtDE7OIa9zcUTIScBssp
wR8xwVmIdMSipdsrYvoVaUK1NleKCalPHwNBubZ1dEEfg2+Kb7yDbmopfHJskUBx
T7yZmXZvfwRIe2UqgXddOG42xRknnf5CKU/tLzW6b+rSetRJ0ZYqWoFlro2NckKz
FAVaIrnwlwgKSxjvYoouAARMHYcHlXP8XFoXPlKaOF74HqROiDPJuYhD/FUrmR6W
jRBo7TU8duObt4regf4qOxx20yRNVSdyxIDW9NFv+tOwHEOL/tbEdeBbCz8mN3y4
/JNa8IDIens6Xsxn6b7ZaQRlU/NjasWpejEI+WGfuydrFfq8tZp+VN5ErksuuHJW
5EOR12/LPcS2ElKYGZhWPLn6V+PWevMB2LqGdKuBleLTk6Fjly5Bj/MyHpBAKI/6
N5+p6SU1mGyF40LMCyF7SiYcLYX3aZKoRPyBMiNKK4GpE3jYeZnPIjFCDzn0vkOG
SfSr9qwLEW0DPe+TCZa9
=uTtR
-----END PGP SIGNATURE-----

--VYG6C5jB6OQk--
