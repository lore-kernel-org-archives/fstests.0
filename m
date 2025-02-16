Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA8179A3
	for <fstests@vger.kernel.org>; Sun, 16 Feb 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739704695; cv=none; b=mjTVtmoV2wAJmDENxo8WxN0yH/w8WniJ0trRpui+E3A3F+bgCK+zm+kO+yfUr+0c+ZkDAULJ2ZqqfNJ6xJBgK3Hn75XRfjvKj26im6K+gxRS56E/cV7HkM79CIclGwEZNvQcOgRe6VlGbiB6IVK9V/15ha9a/borqFIfsPSMfbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739704695; c=relaxed/simple;
	bh=i2kC4ltCC75Ws8QBvXx0V/tU6d9NDkTqsOOveinWSpk=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=D50mYFLyaAk3iVHQRvO2aU/d//G65aETV+BlaxGUnbxWRY5SfMg8KlFt17TEn/zZddzoV7LcRDIqyWRtMd3maF5ikGoRySLI8RVf3kSDWUXI67gotIyy4Zc0opBJUrrT5BRptja4ikb9PxvWSpdp7eSnShk781k6gVCRe3IYOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZkcH2yO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZkcH2yO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168AAC4CEDD;
	Sun, 16 Feb 2025 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739704694;
	bh=i2kC4ltCC75Ws8QBvXx0V/tU6d9NDkTqsOOveinWSpk=;
	h=Date:From:To:Subject:From;
	b=TZkcH2yOIU18w3UfODrNPPjllGaMaMgMpopK6enUSNN9vj4I9e/kTMFjJeFrm5vVN
	 kYVaF8e8gy2eXiMb3OKP0FN1NiimZmHNZbGqgRGNJ7g3bXG2wiE90sFacajNK9x39C
	 8eUNt8/MhNU7Xo22fUSIS5UmESLODFmNCguYhuAg690Dq3XHIt09snTfxsePyrbRPj
	 czSFDkNGnMCH8bv1cFUOoEoWqRTqP1hpD9ZMh+6p171Im0vhCP1cAdfArNoJ8Nqo2e
	 TV4gaoWPvtuw1dyAwRjTaM5IQpZk7Oakoob8tQ3RR+nX9mhdzzq06nRwqLCf98KIUR
	 9JW7ZS5ZM01yw==
Date: Sun, 16 Feb 2025 19:18:10 +0800
Message-ID: <e94779b0b9fc94bb58847742aeebde0a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.02.16
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHi9CVqTunku"
Content-Disposition: inline


--eHi9CVqTunku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.02.16 release.

Release Notes:
1) There's 1 new test case -- generic/761 to cover a btrfs known issue.
2) Fix many test bugs/failures on btrfs, xfs and fscrypt.

More details refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

c41a7602d1eb btrfs: skip tests that exercise compression property when using nodatasum

New commits:

Christoph Hellwig (2):
      [47a2cc4e81ec] common: fix a spelling error in _require_zoned_device
      [27266caa0927] xfs/614: remove the _require_loop call

Eric Biggers (1):
      [a18fe0c141b0] fscrypt-crypt-util: fix KDF contexts for SM8650

Filipe Manana (9):
      [163a3e23ad0e] generic: suggest fs specific fix only if the tested filesystem matches
      [595c8433603d] btrfs: skip tests incompatible with compression when compression is enabled
      [2bc083d85e38] btrfs/290: skip test if we are running with nodatacow mount option
      [7d83ccfe3ef3] common/btrfs: add a _require_btrfs_no_nodatasum helper
      [e0ece7b8f497] btrfs/333: skip the test when running with nodatacow or nodatasum
      [d449f1724e93] btrfs/205: skip test when running with nodatasum mount option
      [0bdc1e525b3a] btrfs: skip tests exercising data corruption and repair when using nodatasum
      [4e822b538981] btrfs/281: skip test when running with nodatasum mount option
      [c41a7602d1eb] btrfs: skip tests that exercise compression property when using nodatasum

Qu Wenruo (2):
      [7e92cb991b0b] fstests: btrfs/226: use nodatasum mount option to prevent false alerts
      [17fb49493426] fstests: add a generic test to verify direct IO writes with buffer contents change


Code Diffstat:

 .gitignore               |   1 +
 common/btrfs             |   7 +++
 common/rc                |   2 +-
 src/Makefile             |   3 +-
 src/dio-writeback-race.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 src/fscrypt-crypt-util.c |   4 +-
 tests/btrfs/048          |   3 +
 tests/btrfs/059          |   3 +
 tests/btrfs/140          |   4 +-
 tests/btrfs/141          |   4 +-
 tests/btrfs/157          |   4 +-
 tests/btrfs/158          |   4 +-
 tests/btrfs/205          |   5 ++
 tests/btrfs/215          |   8 ++-
 tests/btrfs/226          |   7 ++-
 tests/btrfs/265          |   7 ++-
 tests/btrfs/266          |   7 ++-
 tests/btrfs/267          |   7 ++-
 tests/btrfs/268          |   7 ++-
 tests/btrfs/269          |   7 ++-
 tests/btrfs/281          |   2 +
 tests/btrfs/289          |   8 ++-
 tests/btrfs/290          |  12 ++++
 tests/btrfs/297          |   4 ++
 tests/btrfs/333          |   5 ++
 tests/generic/365        |  10 ++--
 tests/generic/366        |   2 +-
 tests/generic/367        |   2 +-
 tests/generic/623        |   2 +-
 tests/generic/631        |   2 +-
 tests/generic/646        |   2 +-
 tests/generic/649        |   2 +-
 tests/generic/695        |   2 +-
 tests/generic/700        |   4 +-
 tests/generic/701        |   2 +-
 tests/generic/702        |   2 +-
 tests/generic/704        |   4 +-
 tests/generic/707        |   4 +-
 tests/generic/761        |  41 +++++++++++++
 tests/generic/761.out    |   2 +
 tests/xfs/614            |   1 -
 41 files changed, 321 insertions(+), 36 deletions(-)
--
Zorro Lang
zlang@kernel.org

--eHi9CVqTunku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmexyR4ACgkQlNbPkfr2
tMzcDxAAqINb6OxzipOEtxTnb7kLgJPLn+NYn5jYBTgl5oIWEa4c+IPkOboGfMxN
Wu3fQJDxjRDxT2NsJIyymxZr2TbPkJzNCqnjXzBJ7SJdeRnh8bXx0uOesmkUKqyF
ykpNaeX7CB1HgVwMTgas0ZwG3Hip250Fj+lY/DDacDmkRSk/64mGzgRVrQ7rm3wi
U6m0FBZKOoADzc8KDUZKuar5F9veWal5EQvo0EpaY1EoZd4UByhtFAru7q6eWpfZ
TIn/r8fGiGDVYrsO/d4zTE5pWerALs9DT8kca953+YUrx4O95mWjnJI2aVzNHmzd
Ux24I6QUAbGdt/lx3qrTelpjFk942kWjgmxJuy9w90YVZQHHNVVUkrnKfuuRUpGH
US+0dDU87TQMDv0x6eE9x+opYAUtPeBsarLYVKn3PJbFPLiYZd61XuCcwln1/AuK
TOS6sCQiAJq4p5CqjYY9p2nef4j5CvtvfxrKkZy2pAl9PDB97jT6mS7P/Oi9LSEp
R7hfO9CMYIPD58V1j4Zj/I2DlseZJ9GUHvXUGDjMPH4uu0FVkuDmuHk13Ws5EKBt
X6uQI1LXUBnryWDOfaMrU3Rtgo2X53QrQ4Fdt8SvvgR62zJNTSqgNhwOjPk78le9
EbuGLR0bXVY4UjHYWZYjtzIEpdPtLAe9tqhHdjDmZSgkwGo1gBs=
=g05r
-----END PGP SIGNATURE-----

--eHi9CVqTunku--
