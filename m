Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:35341 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757276AbcKXUSE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Nov 2016 15:18:04 -0500
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1cA0Mk-00080d-On
        for fstests@vger.kernel.org; Fri, 25 Nov 2016 07:11:30 +1100
Date: Fri, 25 Nov 2016 07:11:30 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 083ff5827b60
Message-ID: <20161124201130.GU31101@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Eryu's pull request described the update as:

	This update contains patches from last two weeks, in which
	we have new xfs, btrfs and generic tests added, and require
	xfs_io binary to be mandatory for fstests run.  There're
	also updates to make xfs_copy tests without "-d" option on
	v5 XFS possible and to fix bugs in ocfs2 testing, and other
	small fixes.

	New failure I noticed in this update:
	- xfs/118 is a new test that may crash your kernel if you're
	  not using latest kernel from linux-xfs tree (for-next
	  branch)
	- generic/391 is a new test and fails on btrfs

Thanks to everyone who has contributed to this update!

-Dave.

The new head of the master branch is commit:

083ff5827b60 fstests: Introduce check for explicit SHARED extent flag repor=
ting

New Commits:

Amir Goldstein (1):
      [cbc87660d50c] generic/37[3-4]: use bind mount instead of 2nd _scratc=
h_mount

Christoph Hellwig (1):
      [e53bdf39d44f] fstests: fix fsx fallocate error messages

Darrick J. Wong (1):
      [ea889e3d5cff] fstests: fix some minor problems testing ocfs2

Eric Sandeen (1):
      [052b0777d7cc] xfs: testcase for kernelspace xfs_fsr extent handling =
flaw

Eryu Guan (4):
      [ae254a9f9f6e] fstests: make xfs_io mandatory
      [00d42708c223] xfs/021: filter out detailed array element info from x=
fs_db
      [23f60ef304d6] generic/38[3-6]: require project quota to be enabled o=
n SCRATCH_DEV
      [1b244cdab292] generic: fix $tmp path in tests

Liu Bo (1):
      [775e2d0c0317] generic/098: update test for truncating a file into th=
e middle of a hole

Omar Sandoval (2):
      [9c5a3fa344a8] xfs/298: cd to / instead of ~
      [21616145d294] generic: concurrent non-overlapping direct I/O on the =
same extents

Qu Wenruo (2):
      [089ecbf48630] btrfs: Check false ENOSPC bug caused by incorrect meta=
data reserve
      [083ff5827b60] fstests: Introduce check for explicit SHARED extent fl=
ag reporting

Zorro Lang (2):
      [5e885bfedb71] generic: multi-thread freeze/unfreeze test under fsstr=
ess
      [08adb2554ea2] fstests: test xfs_copy V5 XFS without -d option


Code Diffstat:

 .gitignore            |   1 +
 common/config         |   4 +-
 common/quota          |   2 +-
 common/rc             |  48 +++++++++++++----------
 common/reflink        |  44 +++++++++++++++++++++
 ltp/fsx.c             |  10 ++---
 src/Makefile          |   2 +-
 src/dio-interleaved.c |  98 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/132       | 103 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/btrfs/132.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/generic/018     |   2 +-
 tests/generic/094     |   2 +-
 tests/generic/098     |  60 +++++++++++++++++++----------
 tests/generic/098.out |  10 +++++
 tests/generic/225     |   2 +-
 tests/generic/249     |   2 +-
 tests/generic/372     |   1 +
 tests/generic/373     |   4 +-
 tests/generic/374     |   4 +-
 tests/generic/383     |   1 +
 tests/generic/384     |   2 +-
 tests/generic/385     |   2 +-
 tests/generic/386     |   2 +-
 tests/generic/390     |  94 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/390.out |   2 +
 tests/generic/391     |  76 +++++++++++++++++++++++++++++++++++++
 tests/generic/391.out |   2 +
 tests/generic/group   |   2 +
 tests/xfs/021         |   2 +-
 tests/xfs/032         |  21 +++++++---
 tests/xfs/073         |   8 +---
 tests/xfs/094         |   1 -
 tests/xfs/103         |   1 -
 tests/xfs/118         |  99 ++++++++++++++++++++++++++++++++++++++++++++++=
++
 tests/xfs/118.out     |   2 +
 tests/xfs/298         |   2 +-
 tests/xfs/group       |   1 +
 38 files changed, 648 insertions(+), 74 deletions(-)
 create mode 100644 src/dio-interleaved.c
 create mode 100755 tests/btrfs/132
 create mode 100644 tests/btrfs/132.out
 create mode 100755 tests/generic/390
 create mode 100644 tests/generic/390.out
 create mode 100755 tests/generic/391
 create mode 100644 tests/generic/391.out
 create mode 100755 tests/xfs/118
 create mode 100644 tests/xfs/118.out
--=20
Dave Chinner
david@fromorbit.com

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYN0lyAAoJEK3oKUf0dfodPOkQALkuShPmjYGl3JdT2Kn8Df53
bTuLb0x/T2/KFxHuLHAXwj8zWbIUlu5y4xajpEUmBFnMwuKyfus/MBwuumSt/Ypz
AKI+cNKWAP6oAdL4G6NCLHRg04eUPTevfTH7w52x+mWEbZumlzcgPcOv4wpF13xY
Fc9vtZvoFRdRZaWZR+wONqHV3fWsKcFDv3mBLtrXscSIkMn3JeuZJBBLXOF2gL5E
GFqgdxdYoglhsHLAn43Qs3224MXJcLGz7fz6GMsOBcxF+9a3hbvHrNy9CHJG4g5N
v/j7RBSgZfHLLMe4aul1dOounaw6nzwpOZQa0fg3Ru7nwl668s5mo7lenI8dPU6g
b/MBi5O2lSZbCjmQ4EwjRVJshYlem/WbaCkWwez9KMTJpYd4VMaJKMhJAE3zzH2/
q96fI6K7ilFb7V59uBCgBqrzMF8vcqXIxqEnowzzHSX2OArEP/Sk55+7eTIBiyWO
6DBk/c2+kIVORFmJJ8Tzi8ag3//KcvMmUcpZTceiE9CwsepDlQh/3CkOiPmGrTM+
Np1uEkXpXC27KNINL22TOEopc3D/zNmN/Vj1zmsJV983Hd6Y0Y1GoDtP6C7XmVFp
EtgBmDsddk87pBoBZly6BYoUrlkyZqEkdH9VZ3fD9IMXL7yaIOpzIvCEj7h6M6lb
bYU7ycNxJwtfAVxOrXst
=LTNI
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
