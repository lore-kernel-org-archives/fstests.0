Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D71D5CD6
	for <fstests@vger.kernel.org>; Sun, 30 Mar 2025 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743348104; cv=none; b=FWofLPAKpopCBBZAjBGci133SoU1abvlsOM/pI/3BJ+tyZ1o/SRu/65QRKkn2GEZAhcVUAGqg4NLETZB+yzahQb6fmk2BitMrV5RRMN65oWvW/GoK4ROIZdDBK6YmjopDwiQaYDf5DifCuND+zqGG6ofdDmpAuJ/2WaxHG2ED2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743348104; c=relaxed/simple;
	bh=mHVm9KW4Rl8UkzRDxg2awIwHmmXERHw1xbx1dpxOsR0=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=WmgiBHFyAWczr3wiOMvCyeUHhwI/+JI7gKrMc78rZ8zc5VRtm79sb2pLTvJCDd6wxw93ZH94VUUM499FkWJ4jtxeTNwgx/2Dmo2hTWv3lE77HJiuhkjKkW3rRemnegu2LQivBD+asUVgNT+oQ7WloCvCWNbM4zYZedPi4V08zsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr/Z0sIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr/Z0sIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9C3C4CEDD;
	Sun, 30 Mar 2025 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743348102;
	bh=mHVm9KW4Rl8UkzRDxg2awIwHmmXERHw1xbx1dpxOsR0=;
	h=Date:From:To:Subject:From;
	b=Dr/Z0sIkkdV3yu06hO0CPoz4tGc+QH0p5MjYhZTr5LazfNfQ1OGmVZJs1iOA5d9hY
	 FHl0Q1F4TYXeLE5uvFUItDnpg1Kpbk6s0XDa3cj2YTyk+oX+wWOUEju1CU6XQqL8+o
	 tY6PCB/9bpaIPGC9DNbjK6NYbhuySqMcXw4HKU9+ANxWNCUrkM+rU/mk4Dnbafs7zk
	 9FH1iU0I+/Vca2n69+43kbM9ANtJpRmqabQFYG4PeKfWc7/rIEyowGJ2seb/GFV5ZJ
	 4iDdc0luPwzWUXp04YKJO298i6FTz+2++j+7s7bvVvP+U6mgA9MMuZMS2G0zXbluwM
	 up7gCeP4NA1XQ==
Date: Sun, 30 Mar 2025 23:21:39 +0800
Message-ID: <8175022655a3be98435b302c33757239@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.03.30
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YbW0Z6orVSPe"
Content-Disposition: inline


--YbW0Z6orVSPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.03.30 release.

Release Notes:
1) There're 5 new test cases in this release, include btrfs/335, f2fs/009,
   f2fs/010, generic/764 and xfs/633.
2) Remove "privatens" and "setsid" test ways from ./check, isolate the
   codes of ./check and ./check-parallel.
3) Make fstests to support zoned XFS.
4) Enhance f2fs related codes.

More updates and fixes refer to below, thanks for all these contributions!

After the change 2), I think this version fstests might be stable enough.
I plan to merge it to master branch in next release, if there's not
critical bug reports. Please tell me, if there're still some issues block
or break your test.

Thanks,
Zorro

The new head of the for-next branch is commit:

0e33d528cf89 xfs/235: add to the auto group

New commits:

Chao Yu (7):
      [d3053a227494] common/config: remove redundant export variables
      [bf36679ee712] common/config: export F2FS_INJECT_PROG
      [b2c469debb76] common/config: export F2FS_FSCK_PROG
      [520d651ee9cc] common/rc: use -f for mkfs.f2fs by default
      [b9d1c36bcce4] common/rc: introduce _check_f2fs_filesystem()
      [82d0ff759c67] f2fs: new test to detect and repair nlink corruption
      [32272b1e895e] f2fs: test dirty status handling on database file

Christoph Hellwig (14):
      [415846d433df] xfs/177: force a small file system size
      [5f57ee3ad4f1] xfs/419: use _scratch_mkfs_xfs
      [332dd50da02b] xfs/540: use _scratch_mkfs_xfs
      [21810ac207c3] common: extend the zoned device checks in _require_dm_target
      [4d2283f87ed2] common: allow _require_non_zoned_device without an argument
      [9b6b461417ab] xfs: add helpers to require zoned/non-zoned file systems
      [2dbbf5debad1] xfs: handle zoned file systems in _scratch_xfs_force_no_metadir
      [8d221e7be774] xfs: no quota support with internal rtdev
      [54cabdaa03e6] xfs: xfs_copy doesn't like RT sections
      [9ec7d058eb92] xfs: skip filestreams tests on internal RT devices
      [ea888a5571e0] xfs: skip various tests when using the zoned allocator
      [283339e65cc7] xfs/049: skip on zoned devices
      [8893b54c0a60] xfs/206: filter out the zoned line from mkfs output
      [0e33d528cf89] xfs/235: add to the auto group

Darrick J. Wong (6):
      [3e73e52ad931] xfs: test filesystem recovery with rdump
      [5efe0accdc55] generic/45[34]: add colored emoji variants to unicode tests
      [8e4282818e57] xfs/614: determine the sector size of the fs image by doing a test format
      [768c74f45422] generic/537: disable quota mount options for pre-metadir rt filesystems
      [eff1baf42a79] common/populate: drop fallocate mode 0 requirement
      [faa0190b363d] xfs/818: fix some design issues

Eric Sandeen (1):
      [cd4ca5ac3512] fstests: test for CONFIG_QFMT_V2 in _require_quota

Filipe Manana (2):
      [6542628fc958] generic: test fsync of file with no more hard links
      [b8cbda37d9ce] btrfs/058: fix test to actually have an open tmpfile during the send operation

Johannes Thumshirn (1):
      [4368c82e2a7e] fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch

Zorro Lang (2):
      [0acf53d6d9d3] fstests: remove privatens test way from check
      [b6ccf1272734] fstests: remove run_setsid test way from check


Code Diffstat:

 check                   |  72 +++++------------------
 common/config           |   4 +-
 common/filestreams      |   5 ++
 common/populate         |   1 -
 common/quota            |   1 +
 common/rc               |  75 +++++++++++++++++++-----
 common/xfs              |  47 ++++++++++++++-
 src/multi_open_unlink.c |  24 +++++++-
 tests/btrfs/058         |  28 +++++++--
 tests/btrfs/335         |  62 ++++++++++++++++++++
 tests/btrfs/335.out     |   7 +++
 tests/ext4/053          |   1 -
 tests/ext4/055          |   2 +
 tests/f2fs/009          | 138 +++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/009.out      |   2 +
 tests/f2fs/010          |  69 ++++++++++++++++++++++
 tests/f2fs/010.out      |   2 +
 tests/generic/453       |  55 +++++++++++++++++
 tests/generic/454       |  55 +++++++++++++++++
 tests/generic/537       |  17 ++++++
 tests/generic/764       |  50 ++++++++++++++++
 tests/generic/764.out   |   2 +
 tests/xfs/015           |   7 +++
 tests/xfs/041           |   5 ++
 tests/xfs/049           |   2 +
 tests/xfs/177           |   4 +-
 tests/xfs/206           |   1 +
 tests/xfs/235           |   2 +-
 tests/xfs/272           |   5 ++
 tests/xfs/276           |   5 ++
 tests/xfs/306           |   4 ++
 tests/xfs/419           |   5 +-
 tests/xfs/449           |   3 +
 tests/xfs/521           |   3 +
 tests/xfs/524           |   4 ++
 tests/xfs/540           |   5 +-
 tests/xfs/541           |   3 +
 tests/xfs/556           |  13 ++++
 tests/xfs/596           |   3 +
 tests/xfs/614           |  13 ++--
 tests/xfs/633           | 153 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/633.out       |   6 ++
 tests/xfs/818           |  19 +++++-
 tools/Makefile          |   1 -
 tools/run_setsid        |  22 -------
 45 files changed, 890 insertions(+), 117 deletions(-)
--
Zorro Lang
zlang@kernel.org

--YbW0Z6orVSPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmfpYV4ACgkQlNbPkfr2
tMz0MRAAhUKZA5Z0S92vn3oxT5tpuiNitc8Z/Ic+UCEvhG7s0mVRn1C/RT9TKUlv
10pqE3frUDEj2n+4RzIpCW27QXvktV+/uXAdciM52/xFu34XTg5IuCY3YP42xnzP
eWRPkoK2mZxw76CQbOajYnEyauGki4TURInxgOyq5rNboD/PgADCNsUsoE0qpL2y
IXjPrBZxU9CQsWC3gJM6/xp6K7W9jFmWI6tM7spYoujEfVvJqX694gAJt9XNHdik
imRtdbzcOOoritleSWv3AzFE6UG3V6MtQtN9EtbkRtE1qV4o03J0sXz+RNNR/VIW
opNdAWGfXwQPypFiG/vSaShwn3djoDkYaYD9xSD2zGeacgLE4oXwevP0lIlQ7NjY
dG9DfCO/1KofDuFqLpdgcKGNHC3mxQ/0ayoxp+HMGvNfVQKQ+rFx3PNk+PPKsv/+
S39J03A7WAkO2xnv4mFeJ7w1ReV6r+CW77JBZhb8lO9ZSX3gArujSKuzffxe+JKe
UHDw6EdAdIdOR6KqsqhSeSUM+/bzdiN8nbEK9WT+6mQOWqpqtPirdQMOB/4cjETG
Ti3XL6ZbwhtofJocIHbjdq2Veq+a5ra04SZaJ9lHmWG1A2x/Ir7GL4dggG3EMhs5
fqWjN9bvNvTx5hQeKHhXyykZfpYraYIBbbFQWSGOeYhscihGCLM=
=7izf
-----END PGP SIGNATURE-----

--YbW0Z6orVSPe--
