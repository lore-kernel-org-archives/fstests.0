Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B0136A
	for <fstests@vger.kernel.org>; Sun, 17 Mar 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710674900; cv=none; b=kcTDuIYyXcKTbBtdBv8VI9mZ8+uPh7q1HmsaSSHZ/KCCiLBsSI5iV5/KIkzBZsoZHp0g0j/64wvmqojAtog6uUmVeUTxibpyUCE1iPr9KCTvCJPrcu8iDOXk7t30HYMoGcEdvPpAykb9TiFnAGz+AH++ZRbNYK5gmc4uFqc5s6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710674900; c=relaxed/simple;
	bh=y7rRJwWfUDQlJdNBMCHvFqFINV0T5eC3JcFC8KkrWxY=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=V4oV3/fEKGU6Z2ayPsDcbJMdLvI2r0kfrvilgHFaXjUXYUyiTv++ClYQHsOfC2HaROfLq6whAHG55qe/JbWMxPfvpP5IGXPfLgGKRLV7RV0T3AM9bckaYNABduTDAC+5qIpBkOTy/fjEXFd1Itw2kyB0YhPpO2aBnv+Bg6KTVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cknnVmgN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cknnVmgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF6AC433C7;
	Sun, 17 Mar 2024 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710674900;
	bh=y7rRJwWfUDQlJdNBMCHvFqFINV0T5eC3JcFC8KkrWxY=;
	h=Date:From:To:Subject:From;
	b=cknnVmgNzTSA5J/YwXuL0kX6F5paICPqSFI1hHYyS8Ifq2COiKQL0o/OneZHjT2AH
	 VzsSENVpNqidZ1uulmywvMOOapqxauWrfsoqVbJ+rmoAmsBbp/nOufLmoOeBaHORl1
	 6FkhM8HwGtSAC7rq38UWb3sOhFvROKaQbdADCvpPPgxJVd5aBN/flmuZPi5+xO8uxr
	 gNtV7pgfJ4W/UT1i014OFH1/FiB7nsUhq2EYQQwDxO6yfVvpaSycpzW1EGXnbDR19Y
	 yDtJdzY8CfvxFWgqHwgyS1M4fz2ozG2qxjeaFZA8Qdn1p2k3EKwpU4PDYzPSzNiQBL
	 Oo3Hz3Flye4yw==
Date: Sun, 17 Mar 2024 19:28:16 +0800
Message-ID: <6d76d834958855be9cd3ec718b671765@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.03.03 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fcqlIT9RaFq8"
Content-Disposition: inline


--fcqlIT9RaFq8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.03.03 version.

Thanks,
Zorro

The new head of the master branch is commit:

9b6df9a01ac8 btrfs/016: fix a false alert due to xattrs mismatch

New commits:

Anand Jain (10):
      [c5c8a2223881] common/rc: assign SCRATCH_DEV_POOL to an array
      [b89613e85fe2] btrfs: introduce tempfsid test group
      [257d00e13dca] btrfs: create a helper function, check_fsid(), to verify the tempfsid
      [e6c1d2ab76a9] btrfs: verify that subvolume mounts are unaffected by tempfsid
      [408376708514] btrfs: check if cloned device mounts with tempfsid
      [5673516f9824] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
      [3ec2d4378c6c] btrfs: introduce helper for creating cloned devices with mkfs
      [0a50ae6c2006] btrfs: verify tempfsid clones using mkfs
      [4af68c15504d] btrfs: validate send-receive operation with tempfsid.
      [a6c984e10159] btrfs: test tempfsid with device add, seed, and balance

Anthony Iliopoulos (2):
      [cc23dcb3ebe6] generic/68[12]: use the dir blocksize for xfs filesystems
      [28928ea7af86] generic/682: update and fix-up golden output

Filipe Manana (6):
      [faabc4852ad9] btrfs: test incremental send on sparse file with trailing hole
      [15c084fe1137] btrfs: require no nodatacow for tests that exercise compression
      [45d779c9d241] btrfs/173: make the test work when mounting with nodatacow
      [d9d267ada5a0] btrfs/299: skip test if we were mounted with nodatacow
      [07e9d3d39c3c] btrfs: require no nodatacow for tests that exercise read repair
      [3f740470e96b] generic/736: fix a buffer overflow in readdir-while-renames.c

Johannes Thumshirn (3):
      [43f4d620203e] filter.brtfs: add filter for conversion
      [fe6326040eb3] filter.btrfs: add filter for btrfs device add
      [8c9102789fec] btrfs: check conversion of zoned fileystems

Luis Chamberlain (1):
      [cb1f76a28453] common/config: fix CANON_DEVS=yes when file does not exist

Martin Jansa (1):
      [a8fbb364834f] tests/*/Makefile: make sure group.list DIRT exists before install

Qu Wenruo (4):
      [00989655e212] btrfs: validate inconsitent qgroup won't leak reserved data space
      [779ae21a305d] btrfs: btrfs/224 do not assign snapshot to a subvolume qgroup
      [662db2673538] btrfs: detect regular qgroup for older kernels correctly
      [9b6df9a01ac8] btrfs/016: fix a false alert due to xattrs mismatch


Code Diffstat:

 common/btrfs                | 76 ++++++++++++++++++++++++++++++++++++-
 common/config               |  2 +-
 common/filter.btrfs         | 15 ++++++++
 common/rc                   | 29 ++++++++++++--
 doc/group-names.txt         |  1 +
 src/readdir-while-renames.c | 10 ++++-
 tests/btrfs/016             | 53 +++++++++++---------------
 tests/btrfs/024             |  1 +
 tests/btrfs/048             |  1 +
 tests/btrfs/059             |  1 +
 tests/btrfs/138             |  1 +
 tests/btrfs/140             |  3 +-
 tests/btrfs/141             |  2 +
 tests/btrfs/157             |  2 +
 tests/btrfs/158             |  2 +
 tests/btrfs/173             |  5 +++
 tests/btrfs/215             |  2 +
 tests/btrfs/224             |  6 +--
 tests/btrfs/234             |  1 +
 tests/btrfs/265             |  2 +
 tests/btrfs/266             |  2 +
 tests/btrfs/267             |  2 +
 tests/btrfs/268             |  2 +
 tests/btrfs/269             |  2 +
 tests/btrfs/281             |  1 +
 tests/btrfs/289             |  2 +
 tests/btrfs/299             |  3 ++
 tests/btrfs/303             | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/303.out         | 24 ++++++++++++
 tests/btrfs/311             | 87 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out         | 24 ++++++++++++
 tests/btrfs/312             | 78 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out         | 19 ++++++++++
 tests/btrfs/313             | 52 +++++++++++++++++++++++++
 tests/btrfs/313.out         | 16 ++++++++
 tests/btrfs/314             | 78 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out         | 23 ++++++++++++
 tests/btrfs/315             | 91 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out         | 10 +++++
 tests/btrfs/316             | 59 +++++++++++++++++++++++++++++
 tests/btrfs/316.out         |  2 +
 tests/btrfs/317             | 67 +++++++++++++++++++++++++++++++++
 tests/btrfs/317.out         |  9 +++++
 tests/btrfs/Makefile        |  2 +-
 tests/ceph/Makefile         |  2 +-
 tests/cifs/Makefile         |  2 +-
 tests/ext4/Makefile         |  2 +-
 tests/f2fs/Makefile         |  2 +-
 tests/generic/681           |  2 +-
 tests/generic/682           | 10 ++++-
 tests/generic/682.out       |  2 +-
 tests/generic/Makefile      |  2 +-
 tests/nfs/Makefile          |  2 +-
 tests/ocfs2/Makefile        |  2 +-
 tests/overlay/Makefile      |  2 +-
 tests/perf/Makefile         |  2 +-
 tests/selftest/Makefile     |  2 +-
 tests/shared/Makefile       |  2 +-
 tests/tmpfs/Makefile        |  2 +-
 tests/udf/Makefile          |  2 +-
 tests/xfs/Makefile          |  2 +-
 61 files changed, 942 insertions(+), 62 deletions(-)
--
Zorro Lang
zlang@kernel.org

--fcqlIT9RaFq8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmX204YACgkQlNbPkfr2
tMyE8g/+ORAcMVzmyJoeKoN3neJQlP/MN/I9qX8HtKBBfZ5243q9S5Sh3U4DYNfF
wVdSN78R5EyBSiwVMQq/YlOiWdXCaAy6EgNAafIotXCkboL4tMERs7iDgylBXuNH
WsWsUkqQnbCX5QDRwnXjLog1M0itYOmqPdjPfw7VsUMzxnTP8nnAPCQDqIRfHXgP
tqDH+JXHDj0toL8bgm+4pDdIhtxNMPmjp7eMXDlf5eIUn6+sKR/nmNoNwzvpTrQg
fFyvhMxJZ/k59ixZatHzfN1+OshgjBYgNMUSU/simqo3AzQf176zp+W7sN2aQTlU
eYSMzJg9F2YoO0zEGX/zaEId6oG/dP/jnJAG/WNtF+xtCy8Bw6/2PT5It24iOUED
us8E55Frjy3XsQUpjJRawDU/KzARBi03ATZmn0Wu4WYzPCle5LgpQG+utKTU5ugB
bf5Buaa/8t01gxCv8J+5h8b6eUXSH6dMkNbcG5D7VHL6IsW6oylsUVF2CnPnjGbE
7T3X7MMvayeVvEqk8vn3zORu69/1LmWxN/jEUpDEp/p/wIUDGIKFbefXC7U8PAIH
59rgo4hZMW8/nXvn80rgNNkCropnOQxtB4RGmDXfKTx9omIoby2QSoww2vu825TD
G/BCvMOvPT6XMd7oRM78/ZF3+t3azvCecgcpHteS5+dOg7OKhcs=
=nrza
-----END PGP SIGNATURE-----

--fcqlIT9RaFq8--
