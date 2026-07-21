Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B33C10A5
	for <fstests@vger.kernel.org>; Tue, 21 Jul 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624099; cv=none; b=RyBCGFOhCDq0TJL/LsAnuJX8x1bqgWUz+TnFUkLIR5jIZRnS060x2KEogULBESfBNIW/rCmwMMQYZNtYno9j3vVFpLg8Tz0J4bAMj5YjpOl2ugREVQCJB8NvHexdm8ir5jUEefUdN9MJUWRWGSqIPHMBzCteNEFF08z+sg1PSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624099; c=relaxed/simple;
	bh=i54mEWk87dMzs/bJuYVjYUBkEODdpdVGZ+KcCMdsGBo=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ny3JgCFrkjOhXL29RKnoyiBRNPTzmybm9GcxGIafy+N/18PDdtiNysHZ3K9Lj0qRaz3EWSK9YiR8fzZ9ZLYgQMgfRCw2FTBVecx3mN4FBlm0ZP7lraJHdyk2VxBwZa9DKceFLVy/8nM7z6wofdPHvk2C0pVNSkNBwlOmBEtKrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuUxNom/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuUxNom/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237C81F000E9
	for <fstests@vger.kernel.org>; Tue, 21 Jul 2026 08:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624097;
	bh=4j9drD1GQNrVzis6DkkF30CY91AOyEoz6gdkAzpsSxM=;
	h=Date:From:To:Subject;
	b=JuUxNom/sPkT+F0m5flJbgSnPu94wd9m2LokY4vZUVt/7moL5kCk0gEFDqLABPdLv
	 M7OzYD/8Bju7ElpZf73Oiapjx1N1CeQCq4as9ftJXGZ5m4wGn311jqTuWt/9BlDmoT
	 YZp07sq/RjjnmpRN08+vRWcFkcdqQDiDVhODALqf5sOdU4WLM+8F7M0/FvY3GvQV8M
	 O0Q/i9A++HWriNeRTeuTfUVJab8weccGzeMtpSl8jMeTpGy47IXyVa3jzenK8w+1nv
	 JI/zLi91f8sjmHpXxmni++b5bXWC7/qX+A0viFec2WjQGNjTJ9sVYLlYHtskTUdHA2
	 QKpCB/v32xE8Q==
Date: Tue, 21 Jul 2026 16:54:52 +0800
Message-ID: <3a82ff6642f00830fc588026ee521a42@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.07.21
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="PoXUUlzUpkj0"
Content-Disposition: inline

--PoXUUlzUpkj0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.07.21 release.

Release Notes:
1) There're 3 new test cases in this release, they're btrfs/351, btrfs/352
   and generic/798. b/351 and b/352 uncover known btrfs issues, g/798 is
   a new cachestat related test.
2) New common helpers _require_btrfs_no_autodefrag and _require_f2fs_io_command
   for btrfs and f2fs testing.
3) Random xfs RT related fixes.

More updates and fixes refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--PoXUUlzUpkj0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmpfM8oACgkQlNbPkfr2
tMyrkhAAzAvGOm7Ox4ypY1J3GEU5+AXFbZ/r9QAal910OsPE0UmQaFlW1hb2xvp0
99Dzgx/wtez+OYSiahwV+tOs6V0VnO9rIGseBh+5/6PF4m581ILiy9jWUSqHucR5
7+VHfi2yCHvirhNK43pO4IXMgIUBs/FMuFaDeTZkwaZeTBWnhsyGWb/5sQAY9A6w
ZinyA7aae28VQyJQoXU37252Yy1P+ZnnaQsxTGzGNcQhdIQGp2Wnen8UW6DzVBMB
5sXKYJLp95H7EL60in9PyRljNVk4rqMRI5anYAOmiuNB5qfBOYD3Y4ZWXpx3t+lL
vEx3ssYINkfyUGfX6a5VvqVNyHp2QV5anXvDjXXFOx6P5ooGSCYIVTMtPNJHbtDQ
u8lIIkbmwAyThCwgOhovv7d1nv+KLmS0pu0cC4WKYzoJgILD44VPRIfkJi5W8fSD
tBJXwPEm1wYNpza8f3zdi0d5kanm6BCG4tuFuqdsFeYElRFRUyEM4k1JeNoYkQhu
CuSifj/SYXt7oJ76PTmOgcoTDKujOS3N5VeDRG23gNIO+UTtwWQoL5xf4vngCzhC
jI3reKi3YBZcE/aKBNC0ebkKv7eaRHkMBWCEZx68hpzvU2zND2eW1eXn/6kuwo95
qbx7zkdwaUNzrpvbMdcrMK2t9o2yoiIHknxZVfEyDxLWSnq2UzM=
=lMS3
-----END PGP SIGNATURE-----

--PoXUUlzUpkj0--
