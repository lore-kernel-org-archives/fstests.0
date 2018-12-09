Received: from mail-pl1-f180.google.com ([209.85.214.180]:36762 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeLIPrE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Dec 2018 10:47:04 -0500
Received: by mail-pl1-f180.google.com with SMTP id g9so4036619plo.3
        for <fstests@vger.kernel.org>; Sun, 09 Dec 2018 07:47:04 -0800 (PST)
Message-ID: <5c0d38f6.1c69fb81.87b14.4167@mx.google.com>
Date: Sun, 09 Dec 2018 23:46:56 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to b155c8b87c42
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1g4j3RsQu0Um"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--1g4j3RsQu0Um
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in the {copy,dedupe,clone}_file_range
additions to fsx/fsstress from Darrick. This may bring in new failures in
tests, but that means we enlarge the test coverage and find new issues in the
areas that we've never covered before. But if you find bugs in tests please
help report bugs and/or contribute fixes.

Thanks,
Eryu

The new head of the master branch is commit:

b155c8b87c42 generic: long fsx soak tests

New commits:

Darrick J. Wong (12):
      [b7b480a0ab37] fsstress: fix compiler warnings
      [39faacd27425] fsstress: check system call return values
      [1579ad7da484] fsx: shut up compiler warnings
      [155cd617f34b] fsx: always check buffer after each operation
      [7a9db35d5635] fsx: use an enum to define the operation commands
      [e05b9c781a71] fsx: add five-argument logging function
      [cff5b96016e8] fsx: add FICLONERANGE support
      [e7b6734822aa] fsx: add FIDEDUPERANGE support
      [50fa944e89be] fsstress: add copy_file_range support
      [f2c8acbf97a1] fsx: add copy_file_range support
      [722a0cf3d620] common/dump: disable copyrange
      [b155c8b87c42] generic: long fsx soak tests


Code Diffstat:

 common/dump           |   3 +
 configure.ac          |   2 +
 include/builddefs.in  |   1 +
 ltp/Makefile          |   4 +
 ltp/fsstress.c        | 207 +++++++++++++--
 ltp/fsx.c             | 691 ++++++++++++++++++++++++++++++++++++++++++++++----
 m4/package_libcdev.m4 |  19 ++
 tests/generic/521     |  61 +++++
 tests/generic/521.out |   2 +
 tests/generic/522     |  55 ++++
 tests/generic/522.out |   2 +
 tests/generic/group   |   2 +
 12 files changed, 978 insertions(+), 71 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--1g4j3RsQu0Um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcDTL6AAoJECZSqilcj+djQiwP/R5u5unWaX/EEkhKBzi9eiej
Xhq3kh7+UrVdh1UTvQvGp8O4023Iro9k7+ZElcafoLaJT4Uvaet7ebWJ4hyMS+kE
eaUwdDRUcLt54d3nL72TmA/sRUmrhT0rCcgCPWGA0zkI2GiJOXxus/XhyyiyiP2+
uw8Bzjt3+tRm/gxVZ142XsJdnfLhm+m5ACZNuqcbhqxZlDmaXBpPqXtt674VZgIw
hjP/6C6+1UnI584L+eMfK5tCxPFUTiEUJzc104veAa5ArGRAKzVUqIcQcRcYACm0
ofHjqyz309p4buE5ff0m6jY3aPTfnMu9mWtGj5tGMUjZUZ+ZvDwYkKtI2dU6JJjk
yOQhhoK4xLMTTFRZ1r1e8dj5hBW4mtDRLHqyNQ7PNWCulq1rM781Qc5LlysTtssF
A7mC5C272wkO3I8AcUH69c0I2stSXyDoLDSwME8mrhDKK5jSK8ZKgIYGpga7VQK5
jIGDYOLRDcjoKXnk2fPVlS5AEY3QF6S+p6GSdBvWbfEnhwShGXLk7lgy5zPsXYLw
1m2vpeoN7QdG0bmstmIBrwnGYGpT8XuuzRDc9qAXvYM3J6Kbz03CeQDH+t3x72jL
qXlyYePtfufK7gr1by6a5Gx5Ruc7WDkwvvBSUdyzIgpVv8TuAWUZ1iUj+rhrkOPs
Qxr//ZpGSeId/qxR4QLx
=9O3k
-----END PGP SIGNATURE-----

--1g4j3RsQu0Um--
