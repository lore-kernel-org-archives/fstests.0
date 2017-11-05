Received: from mail-pf0-f193.google.com ([209.85.192.193]:50313 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdKEIbf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Nov 2017 03:31:35 -0500
Received: by mail-pf0-f193.google.com with SMTP id b6so5457078pfh.7
        for <fstests@vger.kernel.org>; Sun, 05 Nov 2017 01:31:34 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f1sm17385351pfe.150.2017.11.05.01.31.32
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Nov 2017 01:31:33 -0700 (PDT)
Message-ID: <59fecc65.019c620a.2c7a4.e533@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 05 Nov 2017 16:31:25 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 68d2ebf90d94
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="48gDTwTKnZl9"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--48gDTwTKnZl9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. It mainly contains various fixes from Darrick for
preparation of xfs_scrub and the comming xfs updates in v4.15 merge window, but
there're also new tests for btrfs, xfs and overlay. Note that xfs online scrub
will be run by default after each test if there's an executable xfs_scrub
binary and kernel supports it, you don't have to set TEST_XFS_SCRUB=1 now.

New failures I've noticed in this update:
- btrfs/15[23] fail with current v4.14-rc7 kernel

Thanks,
Eryu

The new head of the master branch is commit:

68d2ebf90d94 xfs/020: check that we have enough space to write out a huge fs

New commits:

Amir Goldstein (1):
      [5f49f15cf496] overlay: test creating lower hardlinks for copied up files

Darrick J. Wong (12):
      [5cd65cb761d9] common/xfs: refactor xfs_scrub presence testing
      [ced4117fb924] common/xfs: standardize the xfs_scrub output that gets recorded to $seqres.full
      [a6ce8c2c9eb2] fstests: add module reloading helpers
      [8d021705b5cd] common/xfs: remove inode-paths cruft
      [0862b1d8b6a7] xfs/333: fix errors with new inode pointer verifiers
      [36ea1258684b] common/rc: force mkfs for xfs in _mkfs_dev
      [a9006d7c6227] generic/459: explicitly require thin_check
      [8b190e89fde1] xfs/122: add inode log formats
      [b934adce93a2] xfs: filter and record the unknown block state messages
      [14d062b1e9a8] xfs/013: don't fail because cp ran out of space
      [2d54a4cda310] generic: test IO at maximum file offset
      [68d2ebf90d94] xfs/020: check that we have enough space to write out a huge fs

Justin Maggard (2):
      [93dcb9861eea] btrfs: test if receive with qgroups corrupts metadata
      [230efa52a4c2] btrfs: test for qgroup reservation leaks with prealloc


Code Diffstat:

 README                |   6 +--
 common/btrfs          |  12 -----
 common/config         |   1 +
 common/module         |  99 ++++++++++++++++++++++++++++++++++++
 common/overlay        |   1 +
 common/rc             |  18 ++-----
 common/repair         |   9 ++++
 common/xfs            |  53 ++++++++++++++-----
 tests/btrfs/124       |   9 ++--
 tests/btrfs/125       |   9 ++--
 tests/btrfs/152       | 102 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/152.out   |  13 +++++
 tests/btrfs/153       |  72 ++++++++++++++++++++++++++
 tests/btrfs/153.out   |   2 +
 tests/btrfs/group     |   2 +
 tests/generic/453     |  12 +----
 tests/generic/454     |  12 +----
 tests/generic/459     |   1 +
 tests/generic/466     | 102 +++++++++++++++++++++++++++++++++++++
 tests/generic/466.out |   2 +
 tests/generic/group   |   1 +
 tests/overlay/042     | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/042.out |   2 +
 tests/overlay/group   |   1 +
 tests/xfs/010         |   2 +-
 tests/xfs/013         |  11 ++--
 tests/xfs/020         |   4 ++
 tests/xfs/030         |   2 +-
 tests/xfs/122.out     |   2 +
 tests/xfs/333         |  18 ++-----
 tests/xfs/333.out     |   7 +--
 31 files changed, 629 insertions(+), 96 deletions(-)
--
Eryu Guan
eguan@redhat.com

--48gDTwTKnZl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZ/svPAAoJECZSqilcj+djaHAP/0eyfE1GEVT3rxA0TQMwF7MZ
CQlS4i7AmSjDStpKHZWMMIVV539lq35z4/tcIA3j+5TM8dE7hT0m25j/SZ89VSRc
e9/6uf/+pnKJaxLluxSV2r2eBDPMxXEMMYnvxv/5c/ZTKb+9tZpXBn1mMb+UKRZi
7rcRcll/0K+RlsRthb3Z4iAHcoEdly9JeN9/UAklabj7xh3o7olpdKyFhBCHVuCV
F5Sq1V8ihjqQlANyAgvoAq9xCbCA1kkAH4d5qgzy5r6hO+Sbyb9SJT8iJFub+WcY
mnQ74huE0AN0ZBnD7fpmHeG1+Jy952fPs7gu/rcjmSNV/58NL5TssfLYxsi+ewCe
k2jrVC+woKKpslrOBWx2/Xw4G0Z2YpO75RqlMIUpdsG7jyMoVfIWtl3N25+Ya0tW
wpMBSlWKbJhcgLeUzHOewjlsQc2jweWndsx5qqZ8plIxdamkc1R8hmpspLgO7vlc
6+QvR+SH736J0eCq+MR2BroPdj0BN0tjHBI+YncAlzdTclDh0aqbXtOaZSnvF3Dz
2c78Bo6oO4w7yryKAAddUQj7XDxR9anO2sXKsqyToampCXJ/Gv5cTL9P7GLBrW+T
EWRfQOdXp5LMWa4nJd/bAEHd4F/WCaI7KKFRpDiot0S9WNNg/8sYfhOW08Q+kjW/
n3jLnXC03E3kvTqfctgb
=QI6t
-----END PGP SIGNATURE-----

--48gDTwTKnZl9--
