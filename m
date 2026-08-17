Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06929DB6C
	for <fstests@vger.kernel.org>; Mon, 17 Aug 2026 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971008; cv=none; b=Ha2eIS8wzCPOv6HlYjyePwUgzmMEj4dpqQFpcDjwCHUaavLT2HAwdIHic4AFb9Hp0ndAn8mqJjPbN6i29rn14PDIAuhOizNocaYdY/Ba9Up73xmPwoOKE3y8V77jSWslfgzlees8mZ47urN8zXsOX+3i0ltGBvykr/Zp25CwBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971008; c=relaxed/simple;
	bh=WHjya17w7jVBLWbTL/plVJRk0m1s0WgSGjt0sR5qwDU=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=TwRqSRakBxgAC2mVK9W5P4eshp2Kp9LPAqzbo2fds8XkgYhljFQ4XWiWvxV88R0Pk5H6c9/5ripsxuaUVQnMdk7XmcvGIhU3mcUq3IyyyyLgTJYixgecGCl1JEfSNjOCmhA6mqj+jddNxiNV6Ijz0miSBXgZ6lOzbMpuChLe43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCTAKpZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCTAKpZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AD81F000E9
	for <fstests@vger.kernel.org>; Mon, 17 Aug 2026 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786971007;
	bh=cAVA5iABXlk8XXT69x5tzTH048EzEy1AmZKMlb+KS4M=;
	h=Date:From:To:Subject;
	b=kCTAKpZx0YhLp1cwk1Rr2wUZXMI7ZqqR5PGXVk+3aWbaGbW5ASbSH8FhV2/UQeQV9
	 E90N3X3mKveGmc13UrK2FFI0JwtLcjv4c/HfrW4iF6INxKday0vUPdELtlIThuZ8Gx
	 svXzf0qs5+3Can3FeHazIFl76ArjFLr00Qa00lrZ3zYckPnFwlTtPYno5I1RRWAO5O
	 u576NgsUwEKKAC7wKPejMmjaEpFrKYKpG5yucG0a0igqbx8nuydzCYPs1A1fzP/u8K
	 6CwansRoZeu0MSwuMvJsQOGigD1/zWdfjB8pAA/wMgQpDtxakZrOT0zZX8eQgPDcaP
	 YcAfdwJNb4P4Q==
Date: Mon, 17 Aug 2026 20:50:02 +0800
Message-ID: <db2cfe27ea504430fc90facc164e6ac0@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.07.21 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="xIB8SzEdxAFh"
Content-Disposition: inline

--xIB8SzEdxAFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.07.21 version.

Thanks,
Zorro

The new head of the master branch is commit:

56c410ad0f69 fstests: formalize and fix disabling the RT subvolume

New commits:

An Long (1):
      [b2e97cf30043] common/rc: fix mount options quoting in _mount

Andrey Albershteyn (1):
      [1cd5dcb0545d] generic/270: kill fsstress by exact name

Avinesh Kumar (1):
      [eb4a22ad79b9] generic/062: filter setfattr --restore symlink-safety warning

Chao Yu (1):
      [ce0dff4b555b] common/f2fs: introduce _require_f2fs_io_command

Christoph Hellwig (4):
      [86b976d0deae] xfs/078: disable all concurrency scaling
      [2c13d0a4a554] xfs: remove the v2log group
      [921e3466e0f7] common: log mkfs output in _test_streams
      [56c410ad0f69] fstests: formalize and fix disabling the RT subvolume

Darrick J. Wong (4):
      [60fa62e5e808] common/xfs: fix _scratch_mkfs_xfs_supports_concurrency
      [bd4a8258575a] xfs/21[67]: fix mkfs log concurrency detection
      [1e30cedac5ab] xfs/656: rearrange directio pread/pwrite for zoned filesystems
      [154d755aa1df] xfs/65[56]: don't unset SCRATCH_RTDEV here

Filipe Manana (1):
      [325e2e4daa40] btrfs: skip tests that fail when autodefrag is enabled

German Maglione (2):
      [d2286dbce7f6] vfstest: move sys_umount2() to cleanup path in tcore_acls()
      [b1a8621f6b48] generic/633: add _require_acls for tcore_acls() ACL dependency

Qu Wenruo (4):
      [78b2382e6ccf] fstests: add a test case for btrfs get_subvol_info ioctl
      [8c2fa9b73b15] fstests: generic: add a basic cachestat test case
      [b3ee9a117b00] fstests: btrfs: new test case for leaking BTRFS_FS_STATE_REMOUNTING flag
      [1cca2bc0d7a9] fstests: vfstest: skip rejected tmpfile creation

Shin'ichiro Kawasaki (1):
      [748bab28c593] xfs/333: require external scratch device

Yao Sang (1):
      [eb4cd02a3da5] common: skip data write EIO survival tests on fatal configs


Code Diffstat:

 .gitignore                |   1 +
 common/btrfs              |   7 ++++
 common/f2fs               |  16 +++++++
 common/filestreams        |   4 +-
 common/rc                 |  33 ++++++++++++++-
 common/xfs                |  11 +++--
 doc/group-names.txt       |   1 -
 src/Makefile              |   2 +-
 src/btrfs_ioctl.c         | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 src/vfs/idmapped-mounts.c |   5 +--
 src/vfs/utils.c           |   6 ++-
 tests/btrfs/004           |   3 ++
 tests/btrfs/308           |   2 +
 tests/btrfs/351           |  47 +++++++++++++++++++++
 tests/btrfs/351.out       |   2 +
 tests/btrfs/352           |  50 ++++++++++++++++++++++
 tests/btrfs/352.out       |   2 +
 tests/f2fs/003            |   1 +
 tests/f2fs/004            |   1 +
 tests/f2fs/007            |   1 +
 tests/f2fs/009            |   1 +
 tests/f2fs/010            |   2 +-
 tests/f2fs/011            |   2 +-
 tests/f2fs/012            |   2 +-
 tests/f2fs/013            |   2 +-
 tests/f2fs/025            |   2 +-
 tests/generic/054         |   2 +-
 tests/generic/055         |   2 +-
 tests/generic/062         |   7 +++-
 tests/generic/250         |   2 +-
 tests/generic/252         |   2 +-
 tests/generic/270         |   2 +-
 tests/generic/441         |   3 +-
 tests/generic/484         |   2 +-
 tests/generic/487         |   2 +-
 tests/generic/633         |   3 +-
 tests/generic/798         |  39 +++++++++++++++++
 tests/generic/798.out     |  16 +++++++
 tests/xfs/076             |   2 +-
 tests/xfs/078             |  13 ++++--
 tests/xfs/095             |   2 +-
 tests/xfs/119             |   2 +-
 tests/xfs/135             |   2 +-
 tests/xfs/137             |   2 +-
 tests/xfs/189             |   2 +-
 tests/xfs/205             |   2 +-
 tests/xfs/216             |   9 ++--
 tests/xfs/217             |   9 ++--
 tests/xfs/306             |   2 +-
 tests/xfs/333             |   2 +-
 tests/xfs/444             |   2 +-
 tests/xfs/445             |   2 +-
 tests/xfs/655             |   4 --
 tests/xfs/656             |   7 +---
 tests/xfs/656.out         |   4 +-
 55 files changed, 398 insertions(+), 62 deletions(-)
--
Zorro Lang
zlang@kernel.org

--xIB8SzEdxAFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmqDA2kACgkQlNbPkfr2
tMzBuxAAgxzYQa3UkZOfVI6e0e4Aam+/vd2GV/0FT92gER5QDHzQfCpW3GkOymeC
gGIGRTCudBmSHEDtfpmBfiCNX1NWq2ET4Cz2q2Ilq9xMIh9VGBvcugBckZyYYJJw
BGwpA1yS9ghoamm+48pl/IPheu5PpJo5Eggpyt8OLIrTvisUSw8DONZ7WkiSdOO4
aAKYdv78zcGqj0Ymg3Qw1EOhN+/6J5cllu4cmJfcPX9AgyMANrSN+r5X9qgTulm9
3IIWyfZeY+lzHEgnVSMr3REeu8qY+70W1d5h6JXMMorhK5T7FyL2ULTXNqS39JGB
nP4YJvSszqkTbPcFcNfYZPl9NBCWsIcUbIm46QXCgbmQB4lPLbx91c5X0vK2MOZG
KIiG/9DPwqTk6xesG54VFKrV9zEL0JMY2SD7DWlN0Xo5I+8nIvbOK0xepgrg4PuG
GmkGS+vBlfiUxPqRRqype8OBI0f1Vap5ZSREKEFcCQs5w+kICClf5ixWbWEFvZd1
pcLaTLkv2ZORi8SqNQOmc5ssap9rFBhu+mUOEi+1iSzUzckYZppIpQkPydLYVtrz
1Z35GhZrsJDRKjKg5vsB26uddrOaCkNoVVsKOWcslsIwQdKG5edrHiBnWfQNXe0G
Ewjoaaj38DyDSWQk9TXOOMNDjZYncLmOnV22Yy4QsOCZ7jshSPI=
=d06L
-----END PGP SIGNATURE-----

--xIB8SzEdxAFh--
