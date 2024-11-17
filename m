Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434E1898FC
	for <fstests@vger.kernel.org>; Sun, 17 Nov 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731855194; cv=none; b=s4s0u74VaMKvCNnShGUSFHUuKsWn1DMM0pfW8FJzKtdiIX4Mfx0Jh/37RU3yeMudBNot/FqBpezA7yyzHHWnVat/M1+V7foQKbHwJWjZPsaDyLPproyfZ0gVFm0PfHngrxVWJs/Nl3Uj1zzR4vvKATxfNfSJUHZNAkrAd9niowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731855194; c=relaxed/simple;
	bh=HOX8Jf3OKMTL3IWFxwRgB2VCLxA39+I4CXrt6yGGA5U=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=DkoD03QDoyIsQABWGKTRoJqyfHiEvPpHvLy6KKp9VX2xxX8snS4oYUEmfXktL9zv3fWCR8nQHU7AGnFL61tGK/iLKF/ckr904XgtXQOtD8RIBWYkC7pYK9iHnaRBHJbIMc9sEYZ5qKWXtz61edV2a/TbCwoBbGoA2vPTMaDQGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKRc/pqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKRc/pqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D5BC4CECD;
	Sun, 17 Nov 2024 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731855194;
	bh=HOX8Jf3OKMTL3IWFxwRgB2VCLxA39+I4CXrt6yGGA5U=;
	h=Date:From:To:Subject:From;
	b=OKRc/pqUBOXNtJhqtsScVWnbPmB5sIezv3fAm0jxlil71bghG1H3I8sWkMrrCnwGj
	 PhEp4RIJdQxKUaGnmKurFLl7b5tWW+PKACgJvyStVmEmiy/m3vM0gGW+rYLayMGfvw
	 pCtg/ue+X3eSc9tGtGP8aAcjI5kqy5hrK9u8P9EkIMSgRH2UnW45T54osnSZ0uLRfm
	 bKfYsqkGOQilUIWg0UOpPHyELgKeHft3giRvDeP9K3m3/deBOoD+Oy+rHFkNtRMUXn
	 RZQHoSBiCRzb2IkxfR43nJHzvY3W9xpBCj3C+yYNqOecos9xx86IiJEjVghrC7JOUO
	 /POzFZwEf8Tsw==
Date: Sun, 17 Nov 2024 22:53:11 +0800
Message-ID: <31a2b371c9ec7f1a55b603ab6131ad83@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.11.17
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mbCpsTJA5HdN"
Content-Disposition: inline


--mbCpsTJA5HdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.11.17 release.

Release Notes:
1. There're 8 new test cases in this release include btrfs/325, btrfs/326,
   generic/366, f2fs/005, f2fs/006, f2fs/007, xfs/609 and xfs/610. Thanks
   for these new test coverage, and glad to see f2fs has more and more test
   cases.
2. The casefold test supports tmpfs now.
3. ext4/032 and xfs/273 are old cases, but they're just updated to uncover
   new issues. So if you hit they fail on your system, that might not be
   regression from your new patch.

More updates refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

88be6071da67 xfs/185: don't fail when rtfile is larger than rblocks

New commits ([N]ew, [U]pdate):

Alexander Mikhalitsyn (1):
[U]      [cdbcb808ecc1] ext4/032: add a new testcase in online resize tests

André Almeida (1):
[U]      [c3a28053dc09] common/casefold: Support for tmpfs casefold test

Brian Foster (2):
[N]      [2fe95b92d6da] xfs: online grow vs. log recovery stress test
[N]      [083bb0ea9473] xfs: online grow vs. log recovery stress test (realtime version)

Chao Yu (3):
[N]      [5089b050a672] f2fs/005: add testcase to check checkpoint disabling functionality
[N]      [23ebca50151d] f2fs/006: add testcase to check out-of-space case
[N]      [7838e3082b15] f2fs/007: add testcase to check consistency of compressed inode metadata

Darrick J. Wong (2):
[U]      [47aa187fb226] xfs/273: check thoroughness of the mappings
[U]      [88be6071da67] xfs/185: don't fail when rtfile is larger than rblocks

Filipe Manana (2):
[U]      [d9228b41b30f] btrfs/287: make the test work when compression is enabled
[N]      [1e990ee9aaa0] btrfs: add a test for defrag of contiguous file extents

Johannes Thumshirn (1):
[U]      [e2affc453cf5] btrfs/136: check for ext3 support

Qu Wenruo (3):
[N]      [4c1629ae3a3a] generic: new test case to verify if certain fio load will hang the filesystem
[N]      [81477600d363] btrfs: a new test case to verify mount behavior with background remounting
[N]      [3fc00cd4ab98] btrfs/321: make the filter to handle older btrfs-progs

Zorro Lang (1):
[U]      [66434a1cb731] xfs: notrun if kernel xfs not supports ascii-ci feature


Code Diffstat:

 common/casefold       |  46 +++++++++++++++++++++
 common/rc             |   3 ++
 common/xfs            |  10 +++++
 tests/btrfs/136       |   2 +
 tests/btrfs/287       |  10 ++---
 tests/btrfs/287.out   |   4 --
 tests/btrfs/321       |   2 +-
 tests/btrfs/325       |  83 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/325.out   |  22 ++++++++++
 tests/btrfs/326       | 107 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/326.out   |   2 +
 tests/ext4/032        |   6 +++
 tests/ext4/032.out    |  18 +++++++++
 tests/f2fs/005        |  47 ++++++++++++++++++++++
 tests/f2fs/005.out    |   2 +
 tests/f2fs/006        |  42 ++++++++++++++++++++
 tests/f2fs/006.out    |   2 +
 tests/f2fs/007        | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/007.out    |  16 ++++++++
 tests/generic/366     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/366.out |   2 +
 tests/generic/556     |  12 ++++--
 tests/xfs/185         |   6 ++-
 tests/xfs/188         |   1 +
 tests/xfs/273         |  47 ++++++++++++++++++++++
 tests/xfs/597         |   1 +
 tests/xfs/598         |   1 +
 tests/xfs/609         |  79 ++++++++++++++++++++++++++++++++++++
 tests/xfs/609.out     |   2 +
 tests/xfs/610         |  81 +++++++++++++++++++++++++++++++++++++
 tests/xfs/610.out     |   2 +
 31 files changed, 856 insertions(+), 16 deletions(-)
--
Zorro Lang
zlang@kernel.org

--mbCpsTJA5HdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmc6AzEACgkQlNbPkfr2
tMyCVg/6AyH+X0Uf8r89J+MeUun7j307lVW6661kktEyQJI5Eo6ZuFjHCDbf/qfQ
4cH05g7immFPyhEQUNaevY3HUxcqxVMhN+yq4uvl+FEfERP5clA0jyldmtjQjZxS
qZbnQXQQMj2Nl6DAcIx40WGVtO3UtAGyGZMVyah+NiCqK5jcNV4OwW4Hcdn6GJ2C
GRTfWlAFqFVUduliTyE7hBqOn16GqNJzTQGUoDbhvpC++AS32IxEa4CamE4EvKwe
oFNojVuQQQM4NhJLCBlymMPBIlq+hB7reUbGzAqgD9xKkIehCb5q0Xrw2cP5L929
DJt6VC5yFk+KsLrPEenI1OqeAdHfQlo+h7+ArZbP/T8Sdn090ldj21bFM9OkW49+
Si4mYEyhLJ50Il79pE/FxLvm0LzAZ5BS/w2UmFdOOaA/0aHbnuk2jnpzalwH9Jcl
LPmPmMSHQRrKfQCSLA/w3wfhvut76jyrpCme54IZfhNACy/XqsYA6J/OIE3Tr5sJ
bnMz33a3c+NWrjSHP26ig78In1yXj0/ZCbzEXsreA30QW6MgJ8UvAAELUhFgNTUV
Grb8x3/6gRGLRKLldT/v8o2lhvXacfXvL1SklX8LVqB7cCqCJQgyD/cpWkOkaRI+
E+iq7UOEjwE2/0+lXBA5trtaWrbDCqOHAvutHI9IhJVPHAoXWfc=
=aIZo
-----END PGP SIGNATURE-----

--mbCpsTJA5HdN--
