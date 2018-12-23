Received: from mail-pf1-f196.google.com ([209.85.210.196]:33349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLWOl4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Dec 2018 09:41:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so4813061pfb.0
        for <fstests@vger.kernel.org>; Sun, 23 Dec 2018 06:41:55 -0800 (PST)
Message-ID: <5c1f9eb2.1c69fb81.7ff65.5744@mx.google.com>
Date: Sun, 23 Dec 2018 22:41:46 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to a190cead9ed2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CmQhJsUOONIJ"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--CmQhJsUOONIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains some random fixes and a new test
for xfs. The new xfs test currently fails with latest kernel, the fixes are
still pending in xfs list.

Thanks a lot to all for fixing all the bugs! Happy Holiday!

Thanks,
Eryu

The new head of the master branch is commit:

a190cead9ed2 xfs: look for stringified constants in ftrace formats

New commits:

Darrick J. Wong (5):
      [4ee8c0c855b5] xfs/111: fix golden output
      [6cef63e66835] xfs/123: fix remote symlink block size calculation
      [b0415daaa968] generic/050: fix ro blockdev mount of xfs with quota
      [3a2aed3ae46f] xfs: filter out mount options that don't work on v4 filesystems
      [a190cead9ed2] xfs: look for stringified constants in ftrace formats

David Disseldorp (1):
      [3a9ba205f2db] check: fix -X exclude_file behaviour

Johannes Thumshirn (1):
      [7fc034868d5d] common/config: create $RESULT_BASE before dumping kmemleak leaks

Xiao Yang (1):
      [03f550bd493b] common: Fix mismatched output from standard mkswap


Code Diffstat:

 check             | 25 +++++++++----------
 common/config     | 11 +++++++++
 common/rc         | 15 ++++++++++-
 common/xfs        | 24 ++++++++++++++++++
 tests/btrfs/173   |  2 +-
 tests/generic/050 | 62 ++++++++++++++++++++++++++++++++++------------
 tests/xfs/111     |  2 +-
 tests/xfs/111.out |  1 -
 tests/xfs/123     |  7 +++---
 tests/xfs/419     |  2 +-
 tests/xfs/499     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/499.out |  3 +++
 tests/xfs/group   |  1 +
 13 files changed, 191 insertions(+), 38 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--CmQhJsUOONIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcH544AAoJECZSqilcj+djbMYP/ib0jqoIi4CKAAAsc5L+Qs2p
1MhnNMIL84RM4YpDgTS3l4XWJmBuokCmSnM/Jp1Ute/dle8VZnrdg8+hSO4g5T24
mD0yrDE8N6mUpDYlOaiiKWw5bZMmCggdf8bQb+DS1ycCUyi2N520/mut3cit2aD6
zg+dlC+RDIqy+YbFbjKS5pskbTB7z1UcNKc0aOvY7V+vglbF2Sc2G2ts3wOd3Jz7
dwLiSHqen7t9Nve82WQ9oBielmXQBfbCfLlLp3cJ602B5LOMkskSUzAkmRDl1CLI
w2bAractjKqaLVgAqrWRrSN3BAxwL1pbKIJD38PuVaVa2k3gmVeN8z7tb645ZpLk
q0gqtikSHrOqWtyKhttMLsFpBRDVy9vN9JRVEC2Vu2PuJo7mqfYy2bZ/nNWrAhv+
cOo7vqnH9VY0/oDDJ+MtubiSIROgNeO/k6NXlmFbbNO75NxaCLAFpjTEdcZLL5HC
bobYaAT3OWjfnSIiCoNag/HHl5ouyaQUKdLLqRSzZvob0Z4S6fL7xzKtk2dmXVJh
4nkqCGvvKRIHgvBn0MyGYJ/H8xT/ftuOOzx69w7YtRdwowkdTtCJ5EZswf1YEfbg
9lzl4PbkPfEDF7XVazwIc7/nlASB987+BhrIiZbYThdS8RBp0ALJAb71gLLFmz5n
Ltwhvtao8fzvbraz0wic
=r3B7
-----END PGP SIGNATURE-----

--CmQhJsUOONIJ--
