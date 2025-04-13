Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17E18A95A
	for <fstests@vger.kernel.org>; Sun, 13 Apr 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744550432; cv=none; b=Ax2NzGQkg3Zxl1qW9aNHQ1RDEJkC3P9uqL89a0yuB3I1LKDD7CEbwxP+I2E4P5U9laF+J+OboPGQvtERKzNGdXYrjHHH/UZpeUTjfEXikAh0EyUtw8OLQV3vMjk/juzCFMvHgiJvOde2VQFlGMy9HIhy4Ll/hkyKTD1aABKPsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744550432; c=relaxed/simple;
	bh=Eqduiq3uTFr+Y+c65/eYbgtTxIxmNeoMB9MQqT+jZMk=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=eabubHOGPl83PozMJTk9/QWvKZbUEK/zsN4OShwlyNYpmnu35HtLaBy5DWgnP0djfG2T9NcbHj6Uxup0KVj0P1rXI6dBv8gqzj/nTqFcvy19EVa5A7dziTD4H2fD4JQWdcH2Dmi4wFMfkaZUyYFSpNMZj5SWti3XmPBu1g+xkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpP1nD7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpP1nD7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B252FC4CEDD;
	Sun, 13 Apr 2025 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744550431;
	bh=Eqduiq3uTFr+Y+c65/eYbgtTxIxmNeoMB9MQqT+jZMk=;
	h=Date:From:To:Subject:From;
	b=tpP1nD7CdMTMcfjE304l4EDEsbRSsIj8gjrJY+3aZ+iehc4zO/j2qr9swLyaY8Kdj
	 gC+KzqwWF158Zv+sv13sK+a/nPWrAo1dQJd9A6ji2v/FOKd/pn6QDzFW/QCVrhMCne
	 k7c/j7Nin/GEjkpwtr5HJE0ggUwdfHA7VepkIHbYthwGwiBvr01fYfyJkPjGM8zf0e
	 t9LIPOxAnA2ALKr/a3qwpRytB2V1mddrfBOVuhBa/MDit7LH8lSw02/lwVRigwIWp6
	 EMvswSCt94EE903gMuZgqAw11EqhFMA5b6E4HZicPhvbhfeOn/EZNzEtjtPSb9vQdq
	 +/ai4FxXfTtzQ==
Date: Sun, 13 Apr 2025 21:20:27 +0800
Message-ID: <06046144b202a37027b7987d6df8527f@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.03.30 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="74y213tzgmPS"
Content-Disposition: inline


--74y213tzgmPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.03.30 version

Thanks,
Zorro

The new head of the master branch is commit:

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

--74y213tzgmPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmf7ufYACgkQlNbPkfr2
tMxJYQ/+NgiVwZdoMh6o/5F5quvnBP2+4RQyrvGDxx1uXmwERPOD0jI6USgOShY1
Q3d+kqUooabctFHB7H2HwdOKpaFE0wq2V/cxBX/Ue0ZVKk2rVHjn0ISGSHolR5bh
f3kDZTuRsh+bEUOkATuOXLDb+AgCqxcQOOVdjFgmjfiUAfpv/rm6wXiKlEMzXxQm
dphXPGhd4kjF8Hytsuk6WaA+/Zy9NHJiA9UoeAge5BaddtmGTkVQ0u7xx5yx4AxZ
jFugx5R3hZ+8/L8WW1HSHFC2SmFJCHfYCdTet/cH3pS0x82cm9JzQqm5Dk1fJ7L9
k0sJWOcPQJpyuoJGD0Vm4pgec7lSCX29SUKapyH51rZcwAA97TCpS+Jo5y8gc3az
I53p18UjQTF0bBJholoIY8w/agcHLZcTrvjU/eYZO5HX6xzjelkIk/DLH4wpWFPZ
56XzMruL2Wm19g8KrsFDfsu36YO9++w+EOfhL6LoaxOFaMIK5Gi+WGR/TFFr6qGW
AhPHE8qoYe94TdoghIXItjbMjPUiWH/Au6dnN4zcXDSy9CiGpYt3mxlyMwnnGZ8F
GsamVvH0H76XMjEqhqYAGBZgW4zJ2Q6G3fMGSGh96c6/LJC1Vv+8wP+uU7WfGO71
4an3sKBFd+B0Qe1McuTIG+tOCIH+1CI14WGK5jmPng/OFPIBDVM=
=hK/t
-----END PGP SIGNATURE-----

--74y213tzgmPS--
