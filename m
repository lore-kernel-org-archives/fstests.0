Received: from mail-pg0-f42.google.com ([74.125.83.42]:36807 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdGBIP3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Jul 2017 04:15:29 -0400
Received: by mail-pg0-f42.google.com with SMTP id u62so81405191pgb.3
        for <fstests@vger.kernel.org>; Sun, 02 Jul 2017 01:15:29 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id u9sm29992590pfg.127.2017.07.02.01.15.26
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jul 2017 01:15:27 -0700 (PDT)
Message-ID: <5958ab9f.09df620a.13922.076c@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 02 Jul 2017 16:15:24 +0800
Subject: [ANNOUNCE] fstests: master branch updated to f3a5cbbb34b7
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sxjkRfhOHIQw"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--sxjkRfhOHIQw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal "new tests and bug fixes" update. It's
a bit larger than previous updates, 9 contributors contributed 13 commits, many
thanks to all of them, and to those who have helped review patches!

New failures I've noticed in this update:
- generic/445 is a new SEEK_DATA/SEEK_HOLE test, it fails if page size is less
  than four times allocation size on ext4 and XFS
- generic/446 triggers warnings on XFS and fails _dmesg_check, still not 100%
  sure it's an expected result, if so we can fix it later
- btrfs/147 is a new regression test and it fails on latest 4.12-rc7 kernel

Thanks,
Eryu

The new head of the master branch is commit:

f3a5cbbb34b7 xfs: test freeze/rmap repair race

New commits:

Andreas Gruenbacher (3):
      [c56905614d9d] seek_sanity_test: Report the actual allocation size
      [d8e5df11f2b6] generic: Another SEEK_HOLE/SEEK_DATA sanity test
      [d1df9deaaba3] src/seek_sanity_test: Fix for filesystems without unwritten extent support

Brian Foster (1):
      [d55123c080cb] generic/247: filter out expected XFS warnings for mixed mmap/direct I/O

Darrick J. Wong (2):
      [95cf534f03e2] xfs/274: flip shared bits to reflect xfsprogs usage
      [f3a5cbbb34b7] xfs: test freeze/rmap repair race

David Disseldorp (1):
      [0f87c87f0c1b] README: remove incorrect check -udf usage

Eric Sandeen (1):
      [3ce66a229ddb] generic/401: Test mountpoint not subdir for filetype support

Filipe Manana (1):
      [97843b0910f5] btrfs: test incremental send after replacing directory with a file

Lu Fengqi (1):
      [591b5d75b834] btrfs/027: reorder the arguments of btrfs replace

Luis Henriques (2):
      [9f03a9a9ae66] generic/430: Fix filename in "copy beyond end" test
      [82012736f79d] common/rc: handle the case when syscall isn't available

Xiao Yang (1):
      [ff5eca9b68e6] generic: test a race between dio reads and mapped writes


Code Diffstat:

 README                 |   4 +-
 common/rc              |   2 +
 common/xfs             |  17 ++++
 src/seek_sanity_test.c | 268 ++++++++++++++++++++++++++++++++-----------------
 tests/btrfs/027        |   4 +-
 tests/btrfs/147        | 130 ++++++++++++++++++++++++
 tests/btrfs/147.out    |   6 ++
 tests/btrfs/group      |   1 +
 tests/generic/095      |  19 +---
 tests/generic/247      |  11 +-
 tests/generic/401      |   2 +-
 tests/generic/430      |   2 +-
 tests/generic/445      |  64 ++++++++++++
 tests/generic/445.out  |   2 +
 tests/generic/446      |  91 +++++++++++++++++
 tests/generic/446.out  |   2 +
 tests/generic/group    |   2 +
 tests/xfs/274          |   4 +-
 tests/xfs/422          | 109 ++++++++++++++++++++
 tests/xfs/422.out      |   4 +
 tests/xfs/group        |   1 +
 21 files changed, 622 insertions(+), 123 deletions(-)
--
Eryu Guan
eguan@redhat.com

--sxjkRfhOHIQw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZWKmkAAoJECZSqilcj+djaRcQAKBOnnueGzDn3G3mZYM/K8sE
NvUHsfWPZ7+7SPZOoNaU8AtmJGFotUBYYHF6r+JsZTy6j1attK/461q7TfzooQBj
xqoTXXFWFOHNCA+E6X1PB1LBOjyWSgv7YPGTlxy1uEMM02zhc9+zJtm1zOleZm3N
2gui8K9Y5zZcGBmARd+GysqWNj3vvWVz4tYiccss8qrwb9f/0KHoKlDuuRBczMFR
ed04kGASeDOJgsQYjqek4N5Acy66HC+6sJGEQLHT28O4mVuyMsubq8PqCglhbDHM
gCucaCU5RCknNwOev4BdEpdkgJFbcytIueG0ICpK8AjDS4Y5KOqAfw7FlvnQfzM/
KAvqbQoqZmzsoGNvsSHcwuLgaDusm+a6Xx4Oquv7CxNgKAMXVSL1CLhr92Yj95kr
g/J7SSUQxRUPT+bE/2eagktJfWKJSM/kCWoLHKpar+MsHmp+7djmbQtrHFnkvI1r
pLFZ/Njv9tBAX+2SnlRsR7yf2k/54Awu5ErheqBRZkzpobjgtQqmu9zrZPstGBu6
FiZYm4ViFUFgXL0IhWn0KUIvSRXqwFXozxrnCNveBoHBX/A5+czgHJHl7eeXlXiX
xzKRpe7FkX+BRPHV/13W8IcYyibRqanF7Sk9jx3deeM/HjIUSqenL/whXJNNjfHe
asQrBIoOm0koxMsXONI7
=GUPR
-----END PGP SIGNATURE-----

--sxjkRfhOHIQw--
