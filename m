Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08522615
	for <fstests@vger.kernel.org>; Sun,  4 Feb 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056632; cv=none; b=M0JGtDJGqx2GtnysuyjY4s9J5FQvzQ9e9/Ib2Cgq3mqVIGH9v6scrhoxJQjLBdpq3S1/lvfdf8JAc6tdr+6dcq/IgZ/WIJbghe3o/19OVQlfkoMfmtyIgJrLOAhM3INOz4LKcKZsZDY4/cHqcm/+tu8ZubcG9lc8GaO8Fuqntn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056632; c=relaxed/simple;
	bh=CjEJuyFJsTnFhSqjDWXzkz2KUyUnoIflgZ5EX+wQksw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=tZNbMQO0V2WaLLpwYzHlIgUska86y0mKyNGMOlXuaRPweCE7V4Z4+ElKVAoz9OYHqdjWWf+Bu/48HWKN13AltCIQrJBAL9HABkpXbrEM4WSRNTg7E58R5HqoRC16lLcvO3WRD72Vh+vRBlVLoilazA6qyUjgcQjf2MDEVeRpJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN9SzI/G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN9SzI/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D10DC433F1;
	Sun,  4 Feb 2024 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707056631;
	bh=CjEJuyFJsTnFhSqjDWXzkz2KUyUnoIflgZ5EX+wQksw=;
	h=Date:From:To:Subject:From;
	b=jN9SzI/G6IcJEYPj4ep7DJoes4Wvmcj2woa5mIh6htSmJzwqpjv96DEo4+Y/jvokd
	 tzTkSRn1737bjdJ0tw1DCoU05xuQmTDtpWKtLAaCE9D14z2USeOUoc8/mY12I1YQ8T
	 DXCDs6TEa+CafxAX5OfKbNipTvoRVfIDhBp8hOuqQuFXhF06GOuqptsPcYyDyqousu
	 BbZg4HpSr4jAYXeUMrqMmA2bUXKHPd3mOXTM4KLVOy7QzIU088swypAddvKTgjF/+F
	 NHucS4+0mIlCMTLAi48QYcD09UL1TOAR8BOMNqp3bEE990aUj8JnR1P/a7u/Bqeetp
	 2dYVRklKy77aA==
Date: Sun, 04 Feb 2024 22:23:48 +0800
Message-ID: <da480c1cbd70a88598f5d445e1f76469@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.01.14 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cgdfwFX15KAF"
Content-Disposition: inline


--cgdfwFX15KAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.01.14 version.

Thanks,
Zorro

The new head of the master branch is commit:

c46ca4d1f6c0 generic: add test for custom crypto data unit size

New commits:

Amir Goldstein (1):
      [a5c3a12796cf] overlay: create helper _overlay_scratch_mount_opts()

Anand Jain (1):
      [08dbb837f1a8] common: add _filter_trailing_whitespace

Andreas Gruenbacher (1):
      [3b2312704846] generic/390: Fix test number in comment

Chandan Babu R (5):
      [e443cadcea48] common/xfs: Do not append -a and -o options to metadump
      [b0d63321c777] common/xfs: Add function to detect support for metadump v2
      [5011eb3e04e8] _scratch_xfs_mdrestore: Pass scratch log device when applicable
      [15356e83bed7] xfs: Add support for testing metadump v2
      [045050256e1a] xfs: Check correctness of metadump/mdrestore's ability to work with dirty log

Christoph Hellwig (4):
      [4d04485207fe] xfs: check that the mountpoint is actually mounted in _supports_xfs_scrub
      [e0864962b2d6] xfs: add a _require_scratch_xfs_scrub helper
      [35c3794f9d92] xfs/262: call _require_scratch_xfs_scrub
      [ab0c766d2017] xfs/506: call _require_scratch_xfs_scrub

Chung-Chiang Cheng (1):
      [66c7b4a49404] README: add a missing necessary package

Eric Biggers (4):
      [72dad8092e62] fscrypt-crypt-util: rename block to data unit
      [8716ac9a3eea] common/rc: fix _require_xfs_io_command with digits in argument
      [077698f5211d] common/encrypt: support custom data unit size
      [c46ca4d1f6c0] generic: add test for custom crypto data unit size

Filipe Manana (1):
      [b35af508fb98] btrfs/303: add git commit ID to _fixed_by_kernel_commit

Jeff Layton (2):
      [8729dc6d13cb] generic/465: don't run it on NFS
      [4fd042e0465c] generic/732: don't run it on NFS

Johannes Thumshirn (9):
      [103e0a619bdc] fstests: doc: add new raid-stripe-tree group
      [81af9975ac4d] common: add _require_btrfs_no_nodatacow helper
      [91cb623078b3] common: add _require_btrfs_free_space_tree
      [807b93a1cec7] common: add filter for btrfs raid-stripe dump
      [9d812702919c] btrfs: add fstest for stripe-tree metadata with 4k write
      [ba96d1853ac0] btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
      [102b2efcf91e] btrfs: add fstest for writing to a file at an offset with RST
      [477f3f136125] btrfs: add fstests to write 128k to a RST filesystem
      [26990e6db2a6] btrfs: add fstest for overwriting a file partially with RST

Omar Sandoval (1):
      [3a0381a4595e] btrfs: test snapshotting a deleted subvolume


Code Diffstat:

 .gitignore                         |   1 +
 README                             |   3 +-
 common/btrfs                       |  17 ++++
 common/encrypt                     |  42 ++++++---
 common/filter                      |   5 ++
 common/filter.btrfs                |  15 ++++
 common/overlay                     |   8 +-
 common/populate                    |   2 +-
 common/rc                          |   2 +-
 common/xfs                         |  42 +++++++--
 doc/group-names.txt                |   1 +
 src/Makefile                       |   2 +-
 src/fscrypt-crypt-util.c           |  93 +++++++++----------
 src/t_snapshot_deleted_subvolume.c | 102 +++++++++++++++++++++
 tests/btrfs/303                    |   2 +-
 tests/btrfs/304                    |  58 ++++++++++++
 tests/btrfs/304.out                |  58 ++++++++++++
 tests/btrfs/305                    |  63 +++++++++++++
 tests/btrfs/305.out                |  82 +++++++++++++++++
 tests/btrfs/306                    |  61 +++++++++++++
 tests/btrfs/306.out                |  75 ++++++++++++++++
 tests/btrfs/307                    |  58 ++++++++++++
 tests/btrfs/307.out                |  65 ++++++++++++++
 tests/btrfs/308                    |  62 +++++++++++++
 tests/btrfs/308.out                | 106 ++++++++++++++++++++++
 tests/btrfs/309                    |  27 ++++++
 tests/btrfs/309.out                |   2 +
 tests/f2fs/002                     |   6 +-
 tests/generic/390                  |   2 +-
 tests/generic/465                  |   2 +-
 tests/generic/732                  |   4 +-
 tests/generic/739                  |  31 +++++++
 tests/generic/739.out              |  11 +++
 tests/overlay/011                  |   2 +-
 tests/overlay/035                  |   3 +-
 tests/overlay/052                  |   4 +-
 tests/overlay/053                  |   4 +-
 tests/overlay/062                  |   2 +-
 tests/overlay/079                  |   4 +-
 tests/overlay/085                  |   4 +-
 tests/xfs/129                      |  97 +++++++++++++++++---
 tests/xfs/129.out                  |   4 +-
 tests/xfs/234                      |  97 +++++++++++++++++---
 tests/xfs/234.out                  |   4 +-
 tests/xfs/253                      | 118 ++++++++++++++++++++----
 tests/xfs/262                      |   3 +
 tests/xfs/291                      |  25 +++++-
 tests/xfs/336                      |   2 +-
 tests/xfs/432                      |  29 ++++--
 tests/xfs/432.out                  |   3 +-
 tests/xfs/503                      |  96 ++++++++++++--------
 tests/xfs/503.out                  |  12 +--
 tests/xfs/506                      |   3 +
 tests/xfs/556                      |   2 +-
 tests/xfs/605                      | 178 +++++++++++++++++++++++++++++++++++++
 tests/xfs/605.out                  |  14 +++
 tests/xfs/716                      |   2 +-
 57 files changed, 1628 insertions(+), 194 deletions(-)
--
Zorro Lang
zlang@kernel.org

--cgdfwFX15KAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmW/nbgACgkQlNbPkfr2
tMzOdRAAnZtxImd6HAPFC4TzG+TwINgzivsRM5vwpMa4Ww1TxC5Av1Bcte2K4D/A
ST12fZfTrhoU8w2Wy9y4PkFy2fliGk1CM7U57CBM3hb62MXBsqZ5wslORCY2gFH0
FzA/elATj/GGGXbwKTdHIcYzcgG+3reX9mW8DkYh850O0ITpxIo6uCb0QV1ZHV7p
inxkUrS+cHyJy4/XxOqBk+UPOYWqZQKRTZXu+baS18B24IVGbKSCFHC4PD2isO/e
RAS0FznSwzRQkGLScmGVBKfgdondo0/BAVwjdznrplMjE4P4ZTlJ62sXEYuaGSQ5
RwycId9GTZejvLmyux6baTS8CyzSF5X726k8IcMGu7d30KYJUXGTwObwTSdfRDLn
suviR6rJDZ5pxNO/jxdBjq711fUD4J6mdszdoWU5Tlz9z+On3JxdHIlWe6Hz7qbV
tyt0pYmVzNbe+sTURj9vfJNvBSJzh2zq8Vw5k+srAI3RKHTQImG5zIawvh4bs8yE
nkXSAuiEYUMBTmPpioR9buxkHtZWmjiYv6QMcbgrTSHtz+gs9JlsiA1NiWn/o/4M
7ViQwT8mN/GlvAIH8XOKjbi/wSuJ13usfP1A7TOpVZCkdtS4bZ1rQMRbOMaxOzS1
sbkc9CfoKqW00eSFYyc+PrHbynYoHJqeDMQK01gn0QFzjYCyBFs=
=Urx3
-----END PGP SIGNATURE-----

--cgdfwFX15KAF--
