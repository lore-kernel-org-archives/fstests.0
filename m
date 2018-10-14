Received: from mail-pf1-f193.google.com ([209.85.210.193]:34054 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeJNXz3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Oct 2018 19:55:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id f78-v6so2691789pfe.1
        for <fstests@vger.kernel.org>; Sun, 14 Oct 2018 09:13:57 -0700 (PDT)
Message-ID: <5bc36b43.1c69fb81.5b833.048f@mx.google.com>
Date: Mon, 15 Oct 2018 00:13:50 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 6fe6c772f66a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UhUpTQrp4CGd"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--UhUpTQrp4CGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relatively big update that contains 9 new
tests and various bug fixes & improvements. Many thanks to all the
contributors!

There're also some patches not reviewed yet. Specifically, Chandan Rajendra's
patches for xfs/{139,140} may need some reviews from XFS folks and it'd be good
to get an ACK from btrfs folks on Anand Jain's btrfs test agains duplicate
fsid.

generic/{509,510} currently fail on btrfs, other than that I didn't notice any
new failures.

Thanks,
Eryu

The new head of the master branch is commit:

6fe6c772f66a src/fiemap-tester: fix getting blocksize on overlayfs

New commits:

Amir Goldstein (1):
      [6fe6c772f66a] src/fiemap-tester: fix getting blocksize on overlayfs

Anand Jain (1):
      [32cb15945075] geneirc/077: fix min size for btrfs

Anthony Iliopoulos (1):
      [60d700e885ff] common/reflink: fix error messages in _require_scratch_dedupe()

Chao Yu (3):
      [9ca1f65a7bf9] generic: test project id recovery after power failure
      [1c29d399b6eb] generic: test i_flags recovery after power failure
      [28c8fb706fee] generic: test creation time recovery after power failure

Darrick J. Wong (5):
      [d98d483b74a6] generic: another mread-after-eof test
      [a62490a11844] xfs: test mount time summary counter check and fix
      [ed9251da1e26] xfs/189: skip 'barrier' mount option test on newer kernels
      [8cd8fa12e1e4] xfs/270: use _scratch_xfs_set_metadata_field to fuzz rocompat bits
      [9200725300a1] xfs/288: shut up verifier error

Filipe Manana (2):
      [2fdaeccead93] generic: test mounting filesystem after fsync of a tmpfile
      [1b61fc81a568] generic: test for file fsync after moving it to a new parent directory

Johannes Thumshirn (1):
      [45d1dd73754b] common/rc: fix check for yp

Yufen Yu (1):
      [1fe8a4d08f86] ext4/018: fix mismatch wildcard with debugfs


Code Diffstat:

 common/config         |   1 +
 common/rc             |  12 ++++-
 common/reflink        |   6 +--
 src/fiemap-tester.c   |  15 +++++-
 tests/ext4/018        |   2 +-
 tests/generic/077     |  22 ++++++---
 tests/generic/506     |  97 ++++++++++++++++++++++++++++++++++++
 tests/generic/506.out |   2 +
 tests/generic/507     | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/507.out |   2 +
 tests/generic/508     |  96 ++++++++++++++++++++++++++++++++++++
 tests/generic/508.out |   2 +
 tests/generic/509     |  58 ++++++++++++++++++++++
 tests/generic/509.out |   3 ++
 tests/generic/510     |  71 +++++++++++++++++++++++++++
 tests/generic/510.out |   7 +++
 tests/generic/511     |  54 ++++++++++++++++++++
 tests/generic/511.out |   2 +
 tests/generic/group   |   6 +++
 tests/xfs/189         |  14 +++++-
 tests/xfs/270         |   4 +-
 tests/xfs/288         |   2 +-
 tests/xfs/491         |  58 ++++++++++++++++++++++
 tests/xfs/491.out     |   4 ++
 tests/xfs/492         |  58 ++++++++++++++++++++++
 tests/xfs/492.out     |   4 ++
 tests/xfs/493         |  66 +++++++++++++++++++++++++
 tests/xfs/493.out     |   4 ++
 tests/xfs/group       |   3 ++
 29 files changed, 790 insertions(+), 18 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--UhUpTQrp4CGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbw2rAAAoJECZSqilcj+djufAP/3eHKJpKiSG1CMN+NF0gCWJy
7BFp+UjTjKusbfYjmorFQv7bMlaTxt1tLrsG73sgJhP/tWog02pQ8CQs0osySO66
oLUHWQ4qjq//fLRTgwZaV55dnZKd6iGbpk+rrsPCrRJIO1LLua+zwWHgws/fV3FU
xK8f95rdt6CTKjCy4hKM2n8nDweWEekFtTfRclk4sxboTZxXhR9+t57m+HemvnT5
ZZcZg+h1Ux1e13AqdI8cePgXbXKQ9XAhl9ecJzoW6x+eCM2YrNAFTpl/jzMSsQfP
y+U9hwRm+fcNWGmXVIU2OBi99XLb4S9VXU8s91IvqYXhmOqw2/yjjSFhmV5PabKK
dnL1xNCBY3iDIYiQ0qwE6vLH7OGv+urAlFt2a7s70pPeDYtSkJ1G3bk7UQBNb3Ro
timCEkw6AXs5mc+AoWGomGwyOkGziTP7luBRDnXVo7QFAap7dBfrHd0cWHsyLpjM
4ZG+CjR+32s6rX7gxDule4FiUTslPufcXckBZW0EuwuB19MLymLI/7sj3MbAPcdQ
YyXdQM4ezMg0OGYaw0aqgSFD86mSDrzme6/afbel1DallWfw9ZbVGKK+g0N9/xSM
Bv4eF1vz26BSOuu2//ojQnTCJY1uy2aAEh2a5B1mQEFNVTZRGIHZQAIzYCDfBXew
kOK3DKKZJ5YoGGDYpHGf
=Cw33
-----END PGP SIGNATURE-----

--UhUpTQrp4CGd--
