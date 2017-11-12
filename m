Received: from mail-pf0-f194.google.com ([209.85.192.194]:55804 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbdKLJKW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Nov 2017 04:10:22 -0500
Received: by mail-pf0-f194.google.com with SMTP id 17so9749004pfn.12
        for <fstests@vger.kernel.org>; Sun, 12 Nov 2017 01:10:22 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id p21sm30442601pfk.185.2017.11.12.01.09.48
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 01:10:21 -0800 (PST)
Message-ID: <5a080ffd.958d620a.7689f.68d1@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 12 Nov 2017 17:09:36 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 1e24e5173efa
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NYGIdkIlv1mp"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--NYGIdkIlv1mp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains a new open_by_handle test from
Amir and the remaining bits from Darrick to prepare for v4.15 merge window.
Other commits are random bug fixes.

New failures I've noticed in this update:
- generic/467 fails on NFSv3 and NFSv4.0 (passes on NFSv4.[12] though)

Thanks,
Eryu

The new head of the master branch is commit:

1e24e5173efa generic/204: use available blocks to determine the number of files to create

New commits:

Amir Goldstein (7):
      [80bfe0c15864] open_by_handle: add filename to error reports
      [91a6f4c5779f] open_by_handle: test file handles of renamed files
      [31ce8beba2ed] open_by_handle: test content of open file handle
      [fcaeb02ed177] open_by_handle: test directory file handle
      [48a67c354304] open_by_handle: test file handles of open files
      [d732a15548ef] generic/426: factor out helper functions
      [d360eeaff8ad] generic: add test with more open by file handle use cases

Darrick J. Wong (4):
      [ee3f35961f3c] xfs/31[2-7]: hide pwrite fsync errors that are supposed to fail
      [c0c26cecab8a] common/fuzzy: ignore padding fields on xfs
      [a9df2f23dfc8] xfs: test that we don't leak inodes and dquots during failed cow recovery
      [1e24e5173efa] generic/204: use available blocks to determine the number of files to create

Eryu Guan (2):
      [8fd019ba7a44] ltp/fsx: allow comments when reading operations from logs
      [32a8ebcbe6cf] fstests: do not call _scratch_mkfs_sized in a pipe

Misono, Tomohiro (1):
      [7988dbbcebff] common/filter.btrfs: add 'zstd' to compress property filter


Code Diffstat:

 common/filter.btrfs   |   2 +-
 common/fuzzy          |  14 ++-
 common/rc             |   1 +
 ltp/fsx.c             |   2 +-
 src/open_by_handle.c  | 247 ++++++++++++++++++++++++++++++++++++++++++++------
 tests/generic/204     |  18 +++-
 tests/generic/426     |  40 +++++---
 tests/generic/426.out |   4 +
 tests/generic/467     | 119 ++++++++++++++++++++++++
 tests/generic/467.out |  10 ++
 tests/generic/group   |   1 +
 tests/xfs/015         |   3 +-
 tests/xfs/312         |   2 +-
 tests/xfs/313         |   2 +-
 tests/xfs/314         |   2 +-
 tests/xfs/315         |   2 +-
 tests/xfs/317         |   2 +-
 tests/xfs/326         |   2 +-
 tests/xfs/434         | 111 +++++++++++++++++++++++
 tests/xfs/434.out     |   9 ++
 tests/xfs/435         |  89 ++++++++++++++++++
 tests/xfs/435.out     |   5 +
 tests/xfs/436         | 105 +++++++++++++++++++++
 tests/xfs/436.out     |   9 ++
 tests/xfs/group       |   3 +
 25 files changed, 749 insertions(+), 55 deletions(-)
--
Eryu Guan
eguan@redhat.com

--NYGIdkIlv1mp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaCAjTAAoJECZSqilcj+djlVwQALttukY3V8Ng/LrhHl86o5zN
2vfRPV6P7M7W3PW88vLo1ODdCSZRHy5G5qh6jd9Wyuqhb7u8kCgc78ZXoNyAilbr
7sGu3U+rXzFc9cjVsIT+Sye93Ep+7jfxCvfY71fuCan6NwlF77xGMO6dDsuenBnI
4zCQG4sdgaiekZz4tmzzPW6PftI0qJDaPyXjkiC3Z3L5edGeErr43NiPv2U4n6U9
/ceHP0xSUfxu7mCXJxwrRwj7QXzsclS1ybMtYM4O0liAS0dvbcReDP2AyWIJJH+H
yqtX5HO4PddyesoS0hdGNFxx5QmFk/+SiUNdu4n+S6phQ6GAa4fpSFKEYd1uOxHu
AgPbJGZL1eGzr6kixLiHFiFE3LX8FFH82er+D3zsAGxSyIY3w6MMj8cSJOd/O/lI
y3dQ/TbXf/1nhrF8cieDOWf2VieyHfR4cfy6z01LRngOJnb6ekJMl5IGkKo/vUFL
xs9GWW/FZRYbTMCr3nqYaImD8TQnJBeaMUtneCNAgV7fjlL468QhAxj9cvy7X8a0
erjJfWMo6paseuK8i3OIsn7zpwqoanP56foQlLknNZKMFKp/IQ5IZwJRpelH6e9/
TrRk68tRaAJ8ob0EXFeFJINhhOv/sOTmE+kIDblUvnMYDEM0MPb1UdE3hv3NbHX2
h3Xd6QsTevC3/pnY0kJD
=0M8X
-----END PGP SIGNATURE-----

--NYGIdkIlv1mp--
