Received: from mail-pf0-f181.google.com ([209.85.192.181]:37355 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbeESOXu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 19 May 2018 10:23:50 -0400
Received: by mail-pf0-f181.google.com with SMTP id e9-v6so5067590pfi.4
        for <fstests@vger.kernel.org>; Sat, 19 May 2018 07:23:50 -0700 (PDT)
Message-ID: <5b003374.1c69fb81.dc914.ea23@mx.google.com>
Date: Sat, 19 May 2018 22:23:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 60300eb6e150
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HTmSFuq16lVq"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--HTmSFuq16lVq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains 5 new tests that are for generic,
and xfs, along with some quota test fixes for ext2/3.

New failures I've noticed in this update:
- generic/44[89] currently fails on btrfs
- generic/490 fails on ext3, and ext2 when driven by ext4 module
- generic/491 triggers WARNING on ext4

Thanks,
Eryu

The new head of the master branch is commit:

60300eb6e150 generic/459: use xfs_freeze instead of fsfreeze

New commits:

Amir Goldstein (4):
      [e401bc28c1ba] generic/484: add missing _require_test_program
      [ab4c48e3aee4] fstests: define and use TIMEOUT_PROG
      [5018cd1c0f9f] generic: test first read with freeze right after mount
      [60300eb6e150] generic/459: use xfs_freeze instead of fsfreeze

Dave Chinner (1):
      [5fc65da0a6ff] xfs: test mount vs superblock shrinker races

Filipe Manana (1):
      [fd0607faf234] generic: test for fsync of file with xattrs

Jan Kara (3):
      [5761a6eaade2] generic: Add SEEK_DATA tests for offsets in the middle of holes
      [b2bffe5c77d6] common/quota: Make project quota handling work for ext2 & ext3
      [3d112df8bdc3] common/quota: Fix _qmount_options for ext4 journalled quotas

Omar Sandoval (1):
      [5c19a58f7d99] btrfs: test ENOSPC caused by many orphan items

Xiao Yang (1):
      [287b2e05b527] generic/486: Get rid of the redundant error=%d printing

Zorro Lang (1):
      [a82e9464ddfb] xfs: skip growfs test on large device


Code Diffstat:

 common/config           |  1 +
 common/quota            | 10 +++---
 src/attr_replace_test.c |  2 +-
 src/seek_sanity_test.c  | 71 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/297       |  4 +--
 tests/generic/298       |  4 +--
 tests/generic/459       |  6 ++--
 tests/generic/479       |  0
 tests/generic/484       |  1 +
 tests/generic/488       | 62 +++++++++++++++++++++++++++++++++++
 tests/generic/488.out   |  2 ++
 tests/generic/489       | 86 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/489.out   | 11 +++++++
 tests/generic/490       | 60 ++++++++++++++++++++++++++++++++++
 tests/generic/490.out   |  1 +
 tests/generic/491       | 75 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/491.out   |  2 ++
 tests/generic/group     |  4 +++
 tests/xfs/002           |  1 +
 tests/xfs/127           |  1 +
 tests/xfs/233           |  1 +
 tests/xfs/447           | 72 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/447.out       |  2 ++
 tests/xfs/group         |  1 +
 24 files changed, 468 insertions(+), 12 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--HTmSFuq16lVq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbADCqAAoJECZSqilcj+djA0UQAORVvNeKR0ATuDUcb4/cd0O5
x4yKEb3dxdjet6ZqqGwi0JkIpotX5VGs55c3wbhoCf+JyH3xnbqq7t5IF/UAsSpa
uw4/7a4EHOifMdpp+97AMWNIbsoflk14hKpe6qi2Q3LMPenQzEWWn1TS8df/ktHr
ZIA0BHZfpmUESuOjqyFo2AkrZ+VSuoRTxlc+GT94smZO/HHkhYyN5srjM9AHguZ3
x5ujexbdGN09E9zgcu1ESCZdHnpRNlp3cL4JuNAnaAksR1O6LHdc/iXMxKphMZs6
7qW0y64vusUQ9L0VHPvd3CPAxXNL43QCHl8biO//6kDh0dhOjBbISSBwYv094Q9/
mo2hWiIrCScw9EKKCH8WF3vQ//mvM3cCls233JZOsOm0NqZjEh4xggI/5+FoYxri
ANMxO4OlrHE/5QzJWDfA1Iqp50AAV0NQXI2Cxdkmy9XCoMWlmh9l38BkWBThJQYt
p2p7ZYIWn+D99p2PjaEncoUU/pGh4Cn01JGSTTRudnWOo2B6EQwV3+W1WQAS5Ua1
s7IdmIjSL8V2ffqdfGcXq/54tRxFQbVhr7q7OfPL7g9jaSJISRiF3glwMlH26qw7
oNgE1qtUzCNLt7otXP+HkslinMFW3QU/43zxuFAtYEmua9hi/YezfL4NjCisa+Jw
PWbV2DjHP7gu9/iPZ4MB
=EjRw
-----END PGP SIGNATURE-----

--HTmSFuq16lVq--
