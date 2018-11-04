Received: from mail-pg1-f169.google.com ([209.85.215.169]:43660 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbeKECGL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Nov 2018 21:06:11 -0500
Received: by mail-pg1-f169.google.com with SMTP id n10-v6so3091007pgv.10
        for <fstests@vger.kernel.org>; Sun, 04 Nov 2018 08:50:35 -0800 (PST)
Message-ID: <5bdf2359.1c69fb81.39ce.4a05@mx.google.com>
Date: Mon, 05 Nov 2018 00:50:27 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 70c4067285b0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mauI5fpQ9Ks4"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--mauI5fpQ9Ks4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls xfs leafn tests and quota
fixes from Darrick J. Wong. There're also some random bug fixes.

New failures I've noticed:
- xfs/495 fails when testing with xfsprogs 4.19-rc1, xfs_repair would crash

Thanks,
Eryu

The new head of the master branch is commit:

70c4067285b0 generic/{472,496}: fix swap file creation on Btrfs

New commits:

Darrick J. Wong (10):
      [37113e5f4fc6] xfs: test packaged crc32c code
      [0b0ef1d4213f] populate: create leafn dir when populating xfs filesystem
      [acada47e49b8] xfs: test repair regression of dir w/ single leafn block
      [a8d2e332b0af] xfs: fuzz directories containing single leafn blocks
      [a0e085215e05] quota: clean out speculative preallocations when checking quota usage
      [9f07f7a01655] xfs: force unlink metadata updates to disk
      [7bbc93e3352c] dump: don't fail if multi-file dumps don't all contain quota info
      [05b0bb8c7349] xfs/266: fix restore summary counter when quotas are enabled
      [f1e94da67c78] xfs/205: update for v5 filesystems
      [89985c90eab4] misc: force the exact quota options coded into the test

Dave Chinner (1):
      [168bae395822] check: use full paths for diff on error

Filipe Manana (1):
      [1deed13f69b2] fstests: fix fssum to actually ignore file holes when supposed to

Omar Sandoval (2):
      [290e7a5636e7] generic/{472,496,497}: fix $seeqres typo
      [70c4067285b0] generic/{472,496}: fix swap file creation on Btrfs

Qu Wenruo (1):
      [51fb534ecff1] btrfs/057: Fix false alerts due to orphan files


Code Diffstat:

 check               |  2 +-
 common/dump         |  9 ++++---
 common/populate     | 15 +++++++++++
 common/quota        |  8 +++---
 src/fssum.c         | 65 ++++--------------------------------------------
 tests/btrfs/057     | 18 +++-----------
 tests/btrfs/057.out |  3 +--
 tests/generic/230   |  3 +++
 tests/generic/472   | 16 ++++++------
 tests/generic/496   |  8 +++---
 tests/generic/497   |  2 +-
 tests/xfs/075       |  4 +++
 tests/xfs/116       |  3 +++
 tests/xfs/132       |  5 ++++
 tests/xfs/205       | 21 ++++++++++------
 tests/xfs/220       |  3 +++
 tests/xfs/266       | 17 ++++++++++++-
 tests/xfs/318       |  1 +
 tests/xfs/325       |  1 +
 tests/xfs/494       | 44 +++++++++++++++++++++++++++++++++
 tests/xfs/494.out   |  3 +++
 tests/xfs/495       | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/495.out   |  7 ++++++
 tests/xfs/496       | 52 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/496.out   |  5 ++++
 tests/xfs/497       | 52 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/497.out   |  5 ++++
 tests/xfs/498       | 52 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/498.out   |  5 ++++
 tests/xfs/group     |  5 ++++
 30 files changed, 399 insertions(+), 106 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--mauI5fpQ9Ks4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJb3yL8AAoJECZSqilcj+djfqAP+gPVbvsEAAcCU59VUMUu6q9M
+JzXHfskbQW43VJV/Xu0bOxrKj7bIHciOB93Qgwpp51ZsRuSPuCg/1HDOiobb70A
kciPsef0VIibVIRo79vEBfM7hCDOoj7mrOk6I9hXaNogTGsx2Rcqbl6ExiFUtLKa
LelDfk6exjHAyfz/HaaD+b/DaA6mJsqFxPrdQ2do2Vi2rJSG4G0N5kMIi+hpYTGb
MywVVSGRxe3sytit5BfM7DX3kbJhpBkXliWcsupmK9ataCtBfjWYBfaV3jjmEE/1
PAAZ43FXYzNjDEhpcy/oPn7EW92KZmr2hTIF473ad4kfT5/qSdZrKAtVQ81q31MF
i9ON8X2R9UUHxcVIhOYH+f7pEdJDbWVAqYBicMBuDvSCPZafiMWXPIQ65kjPseb8
KjCExmRIWnXL68ybV62kIpcnjYNE8n6kVEQG90bfv9uFfPNFQQxT3N7+0Ap4EymH
DJuMaTQ+nQrUaFjohPR3PItrxhgfZUs+TC0p2HU+o5hxy02JYVRHM3qPmWCtOUCP
TSZsltsJfQXLEmO6xMZiTTxQ91d/DYgPDEE1uxmdlY4piL+JPALwYfUP/K1RBsX6
BHTNSe2QhQAMt1MgkorEjWDVVYlO0CUonUFtVyGlQV0PQ3PyGZsTjQX+8Cu5N13S
cv6yY8Vp/2l9fIO8wejf
=49kW
-----END PGP SIGNATURE-----

--mauI5fpQ9Ks4--
