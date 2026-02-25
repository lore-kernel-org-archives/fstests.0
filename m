Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0DA3D6491
	for <fstests@vger.kernel.org>; Wed, 25 Feb 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036747; cv=none; b=HNgcIwej0zwr+IQ4QgKyNC9v8Q8CZN6W1PyMipJWVXeEW0vjxuFWk1rCfn5m5Zl6IQvBL2jdZ3MW9wCdhitNHpMcHGDt+UaPrh4pRsepZ4KPoCWU8Ewx2Slwge+8rXiNgZpJ8SSdL1HQsBlFR5O7cIppD86QsZbVjAKrdYktvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036747; c=relaxed/simple;
	bh=JYMKVQPJg1jH4KtaPw25n289PlOQOWDBSUtCharWy8I=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=aQabh7T+ACN9aDekTFZGugEClNKG7pO9eufBVCWkZGT91IJBmxfRlmaz/Lyws0Tun6iQU50Ys2kX9sWl08hpdRmTrkurGzztSfVMYRKZ/IYgv9sR67QW6voBkrXdPWrvTg+b9tHPQHw+ryv3LqVy1YJWVR7WQ1CauB3ZbHBlKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVB7bl2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVB7bl2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20133C116D0;
	Wed, 25 Feb 2026 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772036746;
	bh=JYMKVQPJg1jH4KtaPw25n289PlOQOWDBSUtCharWy8I=;
	h=Date:From:To:Subject:From;
	b=RVB7bl2q7/QaFFKKquSGIC2LkeNl4Vvwe3OW1zf9AXvLjt95HjzpF6YVx31gwFHY1
	 aNZjYGyEsq4Bg0gF/TTdwc+4MK2cjoLbbVKtLJ3iiFkxLvm0iCK8L4JKYsRwyVSBT+
	 kjnwHN2tYxr2TwZGhaW97ctMhl8l3+CwjANVH3wT6nbq9iiW5/jaC2q22R0bv1euwV
	 0vCE6uQYBTDVAst/Cg09qDKbXDXRHX8xifBkdeDtGelKCEPEXlN+5sAqUp+OigR+ZG
	 SS1QLOPpBtxPSZ1ynfIK1LJNLDtW5sOnL1CC+00DMLrVthXlkRLD9+w7u/BRMosRyU
	 a7r9Wt2k5bIgw==
Date: Thu, 26 Feb 2026 00:25:42 +0800
Message-ID: <680e30e02982bf96d6749d431609f1aa@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.01.27 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A4AwWgV1joPD"
Content-Disposition: inline


--A4AwWgV1joPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.01.27 version.

Thanks,
Zorro

The new head of the master branch is commit:

69cd20bd0498 xfs: test reproducible builds

New commits:

Darrick J. Wong (2):
      [754368070ac5] xfs/614: fix test for parent pointers
      [31f7192f90a8] misc: allow zero duration for fsstress and fsx

Filipe Manana (2):
      [8dad086a4701] btrfs: test power failure after fsync and rename exchanging directories
      [e0ded76267f9] fsx: add missing -T option to getopt_long()

Jaegeuk Kim (1):
      [096adc20b3df] f2fs/015: Test correct mkfs options for error cases

Luca Di Maio (1):
      [69cd20bd0498] xfs: test reproducible builds

Nirjhar Roy (IBM) (1):
      [725b08a6d61a] generic/371: Fix the test to be compatible block sizes upto 64k

Ojaswin Mujoo (1):
      [a4dbdc5486b4] generic/108: fix test hand upon failure to create LV

Qu Wenruo (2):
      [8d2e1bd3d294] fstests: btrfs/131: add explicit v1 space cache requirement
      [bc74aaf6859c] fstests: btrfs: add a new test case that is future-proof

Viacheslav Dubeyko (1):
      [facf3325d90d] xfstests: hfs/hfsplus don't support metadata journaling

caokewu (1):
      [42c2ccaf3700] ext4/307: allocate donor file size dynamically


Code Diffstat:

 common/btrfs                     |  25 ++++++
 common/rc                        |   2 +-
 common/xfs                       |   3 +
 ltp/fsstress.c                   |   5 +-
 ltp/fsx.c                        |   7 +-
 tests/btrfs/131                  |  12 ++-
 tests/btrfs/341                  |  73 ++++++++++++++++
 tests/btrfs/341.out              |  15 ++++
 tests/btrfs/342                  | 103 +++++++++++++++++++++++
 tests/btrfs/342.out              |  15 ++++
 tests/ext4/307                   |   5 +-
 tests/f2fs/015                   |  10 ++-
 tests/f2fs/015.out               |  92 ++++++++++----------
 tests/generic/108                |   7 +-
 tests/generic/371                |   2 +-
 tests/xfs/614                    |   1 +
 tests/xfs/614.cfg                |   4 +
 tests/xfs/614.out.lba1024_parent | 177 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/614.out.lba2048_parent | 177 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/614.out.lba4096_parent | 177 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/614.out.lba512_parent  | 177 +++++++++++++++++++++++++++++++++++++++
 tests/xfs/841                    | 173 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/841.out                |   3 +
 23 files changed, 1205 insertions(+), 60 deletions(-)
--
Zorro Lang
zlang@kernel.org

--A4AwWgV1joPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmmfImAACgkQlNbPkfr2
tMxcyQ/9EJlI6hHYaDdAop87EKF6sUJv2IL5CV0P6QdjtlVEzlKoqFFTeTnG5deo
bJ1dhuFmWlu2qnnwPeEFianPXDAkG1aFiUHz2g5NwnJpGlqxWgkRNtNr5XM4bQ9m
PwAaALtftyrbmnsaKj1tSNhflZM0s+PA+PDQ72SuFD3j7wYo/4xdxJgjHuzSM8Zo
6twoEtYqXVUO60YL1VR2ToLcCBQscjegEeDORLU1mfWer9gzJS7aCw0OH8FvAy8E
ND20vq2m7HTFFTdGuWgw4lvdWqJtZKk9xZwsA31SmqkTbT7LWcFjQtPYG6yabdtz
NtdEFmq1G/vANcijYnzTHXA6qkMYVmBWBpG3sV+FLjFzoxCAjIMcSe+S8Ww1fgM3
1OwhZ3DybzTWO63QjzM0kCsLRlwDVhhOYDb8McnnPVzR92KsEozDPlxs8uqdJ59a
KIt6U/HA0XHEUZzFMdghLJjuKPTNAyXpkN4KlJlwsVz0oFi2sGvQKJ+wYpcKYk45
mhS14BCIDV+x8Dy96IKbkq8UUvvOUEyUfA4/PlV11V0n/aqXLKC8otQLhZPz2jYO
k5fma2u8SmT3Fm+dhVsgs4vaxKmEJgsk1i4SIHoGIP2rE4qXS4t5lEeiYfaz0q4I
5CgotXy+chnFJh/qrlwrZntT2PSG5GDwkPJeRw990nu9Rx3qsXM=
=dd0G
-----END PGP SIGNATURE-----

--A4AwWgV1joPD--
