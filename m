Received: from mx1.redhat.com ([209.132.183.28]:57808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbdBTCr4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 19 Feb 2017 21:47:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9102681229
        for <fstests@vger.kernel.org>; Mon, 20 Feb 2017 02:47:56 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v1K2ltqP026137
        for <fstests@vger.kernel.org>; Sun, 19 Feb 2017 21:47:55 -0500
Message-Id: <201702200247.v1K2ltqP026137@int-mx09.intmail.prod.int.phx2.redhat.com>
Date: Mon, 20 Feb 2017 10:47:49 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to f438604bd954
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JQJw4tJJZYwC"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--JQJw4tJJZYwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're more new tests added in this update than
before (9 new tests), we have new xfs, btrfs and generic tests added. Thanks to
those who have contributed new tests!

Note that I added "_require_odirect" to generic/412, which is doing direct I/O
in test and causes failures on CIFS in my release testing.

New failures I've noticed in this update:
- generic/412 fails on btrfs when testing with MKFS_OPTIONS="-O no-holes"
- generic/413 and xfs/260 are failing with brd based ramdisk on xfs and ext4

Thanks,
Eryu

The new head of the master branch is commit:

f438604bd954 generic: test mmap io through DAX and non-DAX

New commits:

Brian Foster (1):
      [e78ae074b2ab] xfs: stress XFS delalloc indirect block reservations

Filipe Manana (2):
      [c8abfdd9303b] btrfs: send/receive with sparse files
      [b665875fa5eb] generic: truncate after a mix of dio and buffered writes

Omar Sandoval (2):
      [6936aa907505] common/rc: remove unnecessary cat in _ddt
      [69924090d335] btrfs: test decompression in the middle of large extents

Xiao Yang (1):
      [0e13e40b247a] shared/005,7: make sure debugfs sets negative i_size

Xiong Zhou (2):
      [456581661b4d] xfs: test per-inode DAX flag by IO
      [f438604bd954] generic: test mmap io through DAX and non-DAX

Zorro Lang (4):
      [74a84259c5a8] common/rc: new functions for multi-level mount/umount operations
      [71691c261f5c] generic: test bind mount operations
      [101cb277500f] generic: test mount shared subtrees state transition
      [8a02ca3bcc62] generic: test two vfsmount no peers


Code Diffstat:

 .gitignore            |   1 +
 common/btrfs          |   8 +
 common/rc             |  50 +++-
 src/Makefile          |   2 +-
 src/t_mmap_dio.c      | 111 +++++++
 tests/btrfs/137       | 141 +++++++++
 tests/btrfs/137.out   |  63 ++++
 tests/btrfs/138       |  97 ++++++
 tests/btrfs/138.out   |   2 +
 tests/btrfs/group     |   2 +
 tests/generic/409     | 179 +++++++++++
 tests/generic/409.out | 365 ++++++++++++++++++++++
 tests/generic/410     | 212 +++++++++++++
 tests/generic/410.out | 813 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/411     | 147 +++++++++
 tests/generic/411.out |  12 +
 tests/generic/412     |  76 +++++
 tests/generic/412.out |   9 +
 tests/generic/413     | 153 ++++++++++
 tests/generic/413.out |   2 +
 tests/generic/group   |   5 +
 tests/shared/005      |   7 +
 tests/shared/007      |   7 +
 tests/xfs/196         | 109 +++++++
 tests/xfs/196.out     |   2 +
 tests/xfs/260         | 158 ++++++++++
 tests/xfs/260.out     |   2 +
 tests/xfs/group       |   2 +
 28 files changed, 2735 insertions(+), 2 deletions(-)
--
Eryu Guan
eguan@redhat.com

--JQJw4tJJZYwC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYqU1fAAoJECZSqilcj+dj4VgP/2AVjJFTQPd4ttL9nuQSDRZQ
k0Tiord3kykhbhZ+ssGgW0RnuijNAVh0CcI801N33aJ8nb9tj/GBzVB2GDlmVezO
a0RCKkncKV3t5v4QN6C7KkvPlLSKQ3kcRxMk0uXC0ZWkPvSj2g+xmIheQP61WKUo
IwOoreMVaxk7BrvipvqSPxOmB9hLKLs1Ehh7tSqrif+OXqz5x/e4EDvhLAsbY/TT
8IPeaO5KHwkFSGeo8PCLJB1o6BnszFfSsGIlvjzthWuwBAgWxpknyGNvSFBR+FEc
Gy2kZp+CeF7IBRR0340Ri9GfRUbMbZ6LJjhUZ+p2Mg/NbIC+qOi7sZse/ZKD3iaz
/fGag47/DZ7aOBUNmsRhakrryLYb7TThsovpC9h/roSCALCC+65uNIeIMCDyu1WH
5BTPL9Xvj8kXARa8nFT/82Nr8PExNYDZCoCHk1TDyd/sVK34No3BJkgJno3oHyVy
aduLZ5/ml2iCQwGb9EfLYsiy+pn21kod+nHx9PSWXdJ5k4q5gUfg8Kb76jbbFLaM
BeD4/x2XHybqutO2wc5/RnT1EbZ6sKfEQxfQkFNBAuEKWCpr6WrCr59y4sa5qXzd
ol5iY4f6oJ7l6KRjaDg2iZDLw4Ll6zP6FJQaPB5lIXzl05gLSuuE8oFpoT6xS5e/
DFKsWvkEEo9QAqGANGUV
=vZeZ
-----END PGP SIGNATURE-----

--JQJw4tJJZYwC--
