Received: from mail-pf0-f193.google.com ([209.85.192.193]:36317 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdENJ2d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 May 2017 05:28:33 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so10965634pfb.3
        for <fstests@vger.kernel.org>; Sun, 14 May 2017 02:28:33 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id t66sm16025533pfe.134.2017.05.14.02.28.30
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 May 2017 02:28:31 -0700 (PDT)
Message-ID: <5918233f.45a6620a.43941.5330@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 14 May 2017 17:28:28 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 777e1d628029
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6Rgjq4rpTD5n"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--6Rgjq4rpTD5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're five new generic tests for copy_file_range(2)
syscall added in this update. Many thanks to Anna Schumaker, also thank Darrick
for reviewing these new tests! Besides that, there're improvements to
set_prog_path function to make things run a bit faster, more improvements to
overlayfs consistent inode test, and a bug fix to seek_sanity_test found in
cephfs testing.

New failures I've noticed in this update:
- copy_file_range(2) tests generic/430, generic/433 and generic/434 fail when
  testing cifs against a Linux samba server, tests return EIO if offset of
  source file is or greater than file size.

Thanks,
Eryu

The new head of the master branch is commit:

777e1d628029 overlay/017: test consistent st_ino/d_ino for hardlinks

New commits:

Amir Goldstein (3):
      [0b7318100594] src/t_dir_type: support filtering by inode number
      [a19298e36317] overlay/017: use t_dir_type to find file by d_ino
      [777e1d628029] overlay/017: test consistent st_ino/d_ino for hardlinks

Anna Schumaker (5):
      [330ba8b3c36a] generic: Add copy to new file test
      [7dada91d00b5] generic: Add small copies to new file test
      [cd3908f4dc07] generic: Add copy test that overwrites data
      [e52ffc092397] generic: Add a copy test for overwriting small amounts of data
      [dabd808a5233] generic: Add a copy test for invalid input

Eric Biggers (2):
      [7b1ae2457c81] common/config: make set_prog_path() accept one argument only
      [904a46958ca0] common/config: implement set_prog_path() using 'type -P'

Luis Henriques (1):
      [763008fd8800] src/seek_sanity_test: ensure file size is big enough


Code Diffstat:

 common/config              |  20 +--------
 common/rc                  |   6 +++
 doc/auxiliary-programs.txt |   7 ++++
 src/seek_sanity_test.c     |   6 +--
 src/t_dir_type.c           |  11 +++--
 tests/generic/430          | 102 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/430.out      |  25 +++++++++++
 tests/generic/431          |  83 ++++++++++++++++++++++++++++++++++++
 tests/generic/431.out      |  15 +++++++
 tests/generic/432          | 100 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/432.out      |  17 ++++++++
 tests/generic/433          |  87 ++++++++++++++++++++++++++++++++++++++
 tests/generic/433.out      |  17 ++++++++
 tests/generic/434          |  79 +++++++++++++++++++++++++++++++++++
 tests/generic/434.out      |  14 +++++++
 tests/generic/group        |   5 +++
 tests/overlay/017          |   9 ++--
 17 files changed, 575 insertions(+), 28 deletions(-)
--
Eryu Guan
eguan@redhat.com

--6Rgjq4rpTD5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZGB7AAAoJECZSqilcj+djE34QANJu1Yp/WFXlrm8pP5sI7z2m
AWXLTsNrjkcgSR/VkCfINdlHfwbAbkeBbFLeW9Zw5I8GDuOOOP+rmH9IMjA4cdm0
gXaz3GMPn7NcZKjp/ZFhhCZtYs6qijohUnLaLb9Af7ErSbh9u1FInczzq9AkuZ98
Kyua0YxdIqD/HwLwDwX0oP6EfNCwDbj+g0Qc+LoSV3UvKliekiQ3jdYlCrMIkiCE
urqYs5fuQ/3P3y8P8+ZRG0ICsIRiRfzn36WOtUeCcLcb3JX0W1SbIuFis7qrctIz
8xSiICn8/zG0MBp3ECXI+pGKLtTVvK/v9GMAF89YLFIFtnW4OlhCRy6lgXMNKwnK
sN4ypyfNsUuJyRp3jalF56ehRkNP6A65CoLiJ9QRC9tEgxPMBrzzYeIgH5o/gUtk
u+2g6DraSCilUroHZBmt22nYMd1pImRt1304tEWIDR8ck3irU/MOKMGmH6W++cYO
dg1n84vH+cPlmMGGot/p1dA8nf51AQEV+1zmcwg3Rn43aKzKKRH4KFKYoUstNpep
7PIW0aIxSKVKfsaAfgLHEuJAiyCZd3XegLYSCqDj2LURnkWkhFsIJGIxAjskxY8l
NQHxc1yVAYSo15Aj434i3PMN1jpepoy8YJXFTb0uppub3l8wUikO1moXtX9ccnf7
BbnFlGOIbb94IYYUjC8R
=zXNP
-----END PGP SIGNATURE-----

--6Rgjq4rpTD5n--
