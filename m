Received: from mail-pf0-f195.google.com ([209.85.192.195]:37830 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeGOQ51 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Jul 2018 12:57:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id a26-v6so3036426pfo.4
        for <fstests@vger.kernel.org>; Sun, 15 Jul 2018 09:33:58 -0700 (PDT)
Message-ID: <5b4b7774.1c69fb81.5107.5f58@mx.google.com>
Date: Mon, 16 Jul 2018 00:33:52 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 08ec45b0b131
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1N7xlkrjihV4"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--1N7xlkrjihV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in two new generic tests from Filipe
and Zorro and several quota fixes from Darrick. Also we're reaching the 500th
generic test milestone!

Thanks,
Eryu

The new head of the master branch is commit:

08ec45b0b131 src/: add license and copyright info to files

New commits:

Darrick J. Wong (5):
      [beae6dead91f] generic/{279, 28[1-3]}: hide SIGBUS reporting from golden output
      [75337edb8cda] xfs/001: update to handle v5 filesystems
      [b3cf8b72334f] xfs/288: update for v5 filesystem support in xfs_db
      [26cfcac29506] generic/338: don't check fs after crashing it
      [76b5a9d535eb] common: filter out quota regeneration messages

Filipe Manana (1):
      [fcc3f3b9c392] generic: add test for fsync after cloning file range

Ross Zwisler (1):
      [08ec45b0b131] src/: add license and copyright info to files

Zorro Lang (3):
      [1b5cd501190e] generic/499: filter fsx stderr output
      [94fa25ded894] common/xfs: remove bad xfs_repair -t option
      [2c14233d9175] generic: test dm-thin running out of data space vs concurrent discard


Code Diffstat:

 common/repair                       |  1 +
 common/xfs                          | 16 ++++++-
 src/t_ext4_dax_inline_corruption.c  |  2 +
 src/t_ext4_dax_journal_corruption.c |  2 +
 src/t_mmap_cow_race.c               |  2 +
 src/t_mmap_stale_pmd.c              |  2 +
 tests/generic/279                   |  6 +++
 tests/generic/281                   |  6 +++
 tests/generic/282                   |  9 +++-
 tests/generic/283                   | 14 ++++--
 tests/generic/338                   |  2 +-
 tests/generic/499                   |  2 +-
 tests/generic/500                   | 92 +++++++++++++++++++++++++++++++++++++
 tests/generic/500.out               |  2 +
 tests/generic/501                   | 70 ++++++++++++++++++++++++++++
 tests/generic/501.out               |  5 ++
 tests/generic/group                 |  2 +
 tests/xfs/001                       | 18 +++++---
 tests/xfs/288                       |  8 +---
 19 files changed, 240 insertions(+), 21 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--1N7xlkrjihV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbS3cBAAoJECZSqilcj+djVisQAKqp7/YrYKUjjXQY6AZSX73A
2EcQI9wQzSHuIyljhMnPhABdsL8K4imZASTW3xDffjRxowg6losoefIJsP5tUU69
q0ntxzPb6YfdG3wIk9sVcmr8MIinc6vL3rzPwbbooz7notspl7WK6pZmsyR15UdN
+D7oEAFhk9Dk7xCMmy9Tw8oXZM8Tm3CiVNoBiEL8j/Eyfs7ClbADF5gJNbjL/nNV
KLup3v7017WsTs80Qln0ediuSMSqQ+kgRXm0foQIDZ208bGEh7DXUtGfxsBjCfo6
Fioe3/bVFB1yr//I9cqNmdE/CWVq5RIJogvigBZ0b0wmZTyKaajo+RWxZaFClQg1
T7eNGH2S+aKux/udN7QEvXCRoCrhrK9xz4qVGxtWbYZ2BjGOGDwQW2G+Gs+OKPn0
475RmdI9IfJ73bDsDn19S4KwYfr/T3/iVquWqk8mNHF/wf8UHmNhAPv3kxPs7Zqd
KM3CKs4H1LmUE9PT43E58xDepU4zWBW7w1Dr4v5aRS1JNGdfMlsAuz6Eb3WFwEcp
YcMApdDEjLhnS/kDiGoHn+jrn6j+w2/P9uSzrU5CoOPliYqJkU68AZHIXMFGW7Jk
h/KeMP/4pNCgWCxKTFwqCaiKEFte4mazYyxVDvusmYSVgMGnb19pFDap21+gKOrM
BVzHXBZ9/b32xo/t2xok
=2JMp
-----END PGP SIGNATURE-----

--1N7xlkrjihV4--
