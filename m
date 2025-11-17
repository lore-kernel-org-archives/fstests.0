Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51202749D6
	for <fstests@vger.kernel.org>; Mon, 17 Nov 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400276; cv=none; b=clMI4QlBIdNNdcEPdpUgtIho8tpjLv99G8IAtJAG+ktnKAOQ+tha817guS1YBksGtMDUbVZsJ61u3vmufka2gpC2F8s5+/UMOArEdle6aiCz3gaDF+0n723RDZJQJ7nbhFaiogimQ6RkBMgrv21K4DkSZlzurG2o7rhddN7fiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400276; c=relaxed/simple;
	bh=T2n4tPH9A4meEbxTy+PrcaPSbf4rio46XpiOFK4mVAI=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=iU/+2H9ybKEVI2FFDT2m4iVNtLdtRnTnzyPfQVUPEY05L/7fpj8Hyku/eY9DdEa7HxdJpy32NmZI/9eST8HzvEJbqmL4W8mfIELcdt6awRS+Xtz8wA9CygNMng8cojV5kQ0iUxL7YgxAwHRAzqcw/F1GNoW0+42LFw6nMBR0Jy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1TzToBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1TzToBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8A6C2BCAF;
	Mon, 17 Nov 2025 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763400276;
	bh=T2n4tPH9A4meEbxTy+PrcaPSbf4rio46XpiOFK4mVAI=;
	h=Date:From:To:Subject:From;
	b=A1TzToBG86Yu2Peb2r71byW9pwZW/fGlNSzxamZYsfJJEjmZwJ/L3jXEd/Lvpt/6N
	 6InuccPUTsoXhrM3Ygl35jKTzLioagkhiV4swkmRcmBnteAWXzMDj7qbpFNbYDMF8e
	 uaeTc4IWtNyL+RyhcprEjPTzA7mv1Pbmzogjw3+ESHEb7tS/6isjHpeiCtxhlvBoKL
	 Wa9RDLXBWcbfE8+Q/I3iBXHOVb62xfPP9MjQUZrxi21dCWx+EM+aOLaxts7cMwyRuE
	 SUer7zYXeFtzvdBrrXctwxZCRbDiDVova0vBuu5/67/DwaGowWHrTkpl7b/8ZaPDmL
	 b5WO/eZHD/S3w==
Date: Tue, 18 Nov 2025 01:24:31 +0800
Message-ID: <7c12cda01b85629a4440bda281732c1a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.11.04 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l7noTP2QWknP"
Content-Disposition: inline


--l7noTP2QWknP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.11.04 version.

Thanks,
Zorro

The new head of the master branch is commit:

5b75444bc912 ceph: test snapshot data integrity after punch hole operations

New commits:

Andrey Albershteyn (2):
      [43761bafd7b5] generic/772: require filesystem to support file_[g|s]etattr
      [e4bcfeb065b0] generic/772: split this test into two tests for regular and special files

Chao Yu (2):
      [930ef1140392] f2fs: add commit id to _fixed_by_kernel_commit for f2fs/02[1-2]
      [fea0ae7e9d7a] f2fs/022: fix to run testcase correctly

Darrick J. Wong (12):
      [462c5419fcdd] generic/427: try to ensure there's some free space before we do the aio test
      [39809c7a56b2] common/rc: fix _require_xfs_io_shutdown
      [e9f38cc0a97a] generic/742: avoid infinite loop if no fiemap results
      [ae421bd93cf4] generic/{482,757}: skip test if there are no FUA writes
      [706b5f0f78a4] generic/772: actually check for file_getattr special file support
      [10b3cbd86d0d] common/filter: fix _filter_file_attributes to handle src/file_attr.c file flags
      [9cff03b40a9f] common/attr: fix _require_noattr2
      [ae2728de5cb9] common: fix _require_xfs_io_command pwrite -A for various blocksizes
      [be294eb15eee] check: line up stdout columns
      [4d5b1462c0d4] fsx: don't print messages when atomic writes are explicitly disabled
      [6e853e735338] fsstress: don't abort when stat(".") returns EIO
      [9886baabdec3] check: collect core dumps from systemd-coredump

Filipe Manana (2):
      [6930df3fd6e8] generic: test fsync of directory after renaming new symlink
      [3db9a5c44737] generic: test a scenario of dir fsync after adding a link to a subdir

Joanne Chang (1):
      [8d3cb85a8b9d] f2fs/011: use random data to avoid file compression

Johannes Thumshirn (3):
      [41f4ef18a442] common/zoned: add _require_zloop
      [e7d008d1fed2] common/zoned: add helpers for creation and teardown of zloop devices
      [c055aae8d958] generic: basic smoke for filesystems on zoned block devices

Ojaswin Mujoo (1):
      [1035b332a57f] ext4/048: Fix hangup due to no free inodes

Yong Sun (1):
      [55cf5e5ba4f6] generic/270: replace pidwait to wait

Zorro Lang (1):
      [606ec307b361] common/atomicwrites: fix _require_scratch_write_atomic when awu_max_fs is empty

ethanwu (1):
      [5b75444bc912] ceph: test snapshot data integrity after punch hole operations


Code Diffstat:

 README                | 20 +++++++++++
 check                 | 10 +++++-
 common/atomicwrites   |  9 +++--
 common/attr           |  4 +++
 common/ceph           | 77 ++++++++++++++++++++++++++++++++++++++++
 common/filter         | 33 +++++++++++++-----
 common/rc             | 97 ++++++++++++++++++++++++++++++++++++++++++++++++---
 common/zoned          | 61 ++++++++++++++++++++++++++++++++
 ltp/fsstress.c        | 29 +++++++++++++--
 ltp/fsx.c             |  1 -
 src/fiemap-fault.c    | 14 +++++++-
 tests/ceph/006        | 63 +++++++++++++++++++++++++++++++++
 tests/ceph/006.out    |  2 ++
 tests/ext4/048        |  7 +++-
 tests/f2fs/011        |  2 +-
 tests/f2fs/021        |  2 +-
 tests/f2fs/022        | 10 +++---
 tests/f2fs/022.out    |  2 +-
 tests/generic/270     |  2 +-
 tests/generic/427     |  3 ++
 tests/generic/482     |  2 +-
 tests/generic/757     |  2 +-
 tests/generic/772     | 54 ++++++----------------------
 tests/generic/772.out | 14 --------
 tests/generic/779     | 60 +++++++++++++++++++++++++++++++
 tests/generic/779.out |  2 ++
 tests/generic/780     | 86 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/780.out | 20 +++++++++++
 tests/generic/781     | 44 +++++++++++++++++++++++
 tests/generic/781.out |  2 ++
 tests/generic/782     | 73 ++++++++++++++++++++++++++++++++++++++
 tests/generic/782.out | 10 ++++++
 tests/xfs/648         |  3 +-
 33 files changed, 727 insertions(+), 93 deletions(-)
--
Zorro Lang
zlang@kernel.org

--l7noTP2QWknP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmkbWSUACgkQlNbPkfr2
tMwtwg//V84tkmfi+RPfON7FOX1NRvtWOjtXt4mUbEptv0eyTuyyOOEpgxttZ+mF
LpOQBtiK9G0uek3x2QJXo2ldsBGH1TL5XC+yInFNp2RieZqd+cGyqCgDehsw1hH9
Xw2idwh619camCwN74NghZ0zZEllOtlhzQbkrqTy0QLR9hpeV/ljEBaz5rRM86Ob
2j4G+4mbL12NhOc6yF0QIBhMs1D7OlboI9UD+YVx+nYnVFmaeAdtrJ+4P89s5Vqw
ufml1rGDOST2/ptAWNQRBz0BQOdBzbHBH+o6JrzBcVKUXl38ESbho0YInQOsiJGX
BdDMtYk+T8qfMhSNBflsOw4uhUjx3inR/X1ChLseGykVJS2FuZmQMTuexW2TAaB5
yQN1Bz57jLUHXtqRWuShwHnG6FM3g9InhBEtX67T4noFtInlxYe8KsLdONxSIATC
s7F8+FNaYXNQYplHMx3H2GBafdxF4eOpRnq22queTv/2AbXdTuCckvJUzYjlEDqK
77nVy3zo9Yj7EFVE6pOAA+0tuygv2ZAzqxO6c5yq4WqbUxFNOqJQ5sMl9vpzrq7c
lYP3SxrNvFsig7sQ8XHmUM5Ch6dUsf4FwRPn1NLqIFzKBhCHqMbh+hWTLB6WeNLe
ty7TiPmDW41lqJ0RSPH2V6ND91c1qZTcOC+Z4AMr0RM490tiYFU=
=p+L6
-----END PGP SIGNATURE-----

--l7noTP2QWknP--
