Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D81804A
	for <fstests@vger.kernel.org>; Sun, 13 Jul 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752418121; cv=none; b=b4qCgP/TQdW14kWKn2gemZis4eysCuuCNemFxDBvRj5BE4ovsGNZsjq46/mAkLwwn+w/T1161Pumb2vd4JIj5hQinqphyp5tTeNTjY/GaYoPkSEdz65QOq41b8DUj4cStiPuJ3s1pPNojN/g/3PS46ha/p7LbTz25/7kAGPq/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752418121; c=relaxed/simple;
	bh=j5W5ET9SGIuqk1EUNP/VmWP0HIOS6P2mJZWhd6wq+WY=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=tj00XYsLzp3MRRuIcq5/YFeFHv9lsF6Et7URYTbsGJD2NkMcsP1O5Xo+pZ7n4+CZB4VyDLUQFMxu01Zx3nLLH/kPU9UEi7cRigXLlz3gjxpTSmF26SHBcfYGg9od/fxOPoyn4jre1Im7MduN3wFB7nwcUJ9F4Am+C3FxqswYbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTAVoMN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTAVoMN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CE4C4CEE3;
	Sun, 13 Jul 2025 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752418120;
	bh=j5W5ET9SGIuqk1EUNP/VmWP0HIOS6P2mJZWhd6wq+WY=;
	h=Date:From:To:Subject:From;
	b=kTAVoMN9VpWU32Sctz8I4yXZm0s6ZUdGiyHlRMYG9Qm6aGEDVzOoo18lFN/G5qG+2
	 3ha3m1hPy0jPIKu9/bXiJ1bH3E1Dh0seuGlniL+PeLXl8CB6h9woeJxHg7SWMuQSCT
	 aYJ6gZAyJyOu9nHFCWPQlkYQKofTCmUjZPfLtmIesCjnv4Hzn9kDxySDcWftwVP8o2
	 T5GJH0e4NpK/4Ztk6wQNFpTnO0G2RJWd2Vn4vqFiOoR2VIk6dWGo4hRmYQ3urc7l0h
	 cS54LazYkMUNntPwdoEZzM9+I78v/IqmJDbpj0NdkXiHu1ahM6VNutwJJERs51se7Z
	 d4DoRHKgcu67Q==
Date: Sun, 13 Jul 2025 22:48:37 +0800
Message-ID: <759e2f31d17b89f2da3f0803bff19563@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.06.22 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T2E6n7zd74xy"
Content-Disposition: inline


--T2E6n7zd74xy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.06.22 version.

Thanks,
Zorro

The new head of the master branch is commit:

e1e4a0ea3580 overlay: add tests for data-only redirect with userxattr

New commits:

Amir Goldstein (2):
      [8cde30495eb5] fstests: add helper _scratch_shutdown_and_syncfs
      [4b1cf3df009b] fstests: add helper _require_xfs_io_shutdown

Anthony Iliopoulos (2):
      [3893dd152f1c] src/fill2: fix segfault during fopen error cleanup
      [d0f634afb0e3] xfs/820: skip test when metadir is not supported

Christoph Hellwig (1):
      [4230bcb1d9f6] generic/740: move checking for a scratch device up

Daniel Gomez (1):
      [e17714ed9544] generic/551: prevent OOM when running on tmpfs with low memory

Filipe Manana (2):
      [ec9a19e72697] generic/032: fix failure due to attempt to wait for non-child process
      [2bade810290c] btrfs/300: set umask to avoid failure on systems with a different umask

Hans Holmberg (2):
      [e225772353e2] xfs: add mount test for read only rt devices
      [e7bc1e2427b4] ext4/002: make generic to support xfs

Li Chen (1):
      [c2acd19575e0] generic/738 : add missing _fixed_by_git_commit line to the test

Miklos Szeredi (1):
      [e1e4a0ea3580] overlay: add tests for data-only redirect with userxattr

Xinjian Ma (1):
      [5b6072bc96a4] xfs/603: add _require_scrub

Yuezhang Mo (3):
      [078937463f4a] generic/689: add _require_acls
      [a69ad67d48ba] generic/622: fix for exfat
      [595773191547] generic/633: add _require_chown


Code Diffstat:

 common/overlay                          |  29 ++++
 common/rc                               |  50 +++++-
 src/fill2.c                             |   2 +-
 tests/btrfs/300                         |   1 +
 tests/generic/032                       |  13 +-
 tests/generic/551                       |   4 +
 tests/generic/622                       |   7 +
 tests/generic/623                       |   2 +-
 tests/generic/633                       |   1 +
 tests/generic/689                       |   2 +
 tests/generic/738                       |   3 +
 tests/generic/740                       |   6 +-
 tests/{ext4/002 => generic/766}         |  11 +-
 tests/{ext4/002.out => generic/766.out} |   2 +-
 tests/overlay/087                       |  13 +-
 tests/overlay/088                       | 297 ++++++++++++++++++++++++++++++++
 tests/overlay/088.out                   |  39 +++++
 tests/overlay/089                       | 273 +++++++++++++++++++++++++++++
 tests/overlay/089.out                   |   5 +
 tests/xfs/546                           |   5 +-
 tests/xfs/603                           |   1 +
 tests/xfs/820                           |   2 +-
 tests/xfs/837                           |  65 +++++++
 tests/xfs/837.out                       |  10 ++
 24 files changed, 812 insertions(+), 31 deletions(-)
--
Zorro Lang
zlang@kernel.org

--T2E6n7zd74xy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmhzxxIACgkQlNbPkfr2
tMyMhQ/+Lxz9HV+sXOy3d7xfJYKJt6LFyXWof9vHCvJ296kHroGHWzLhioV7zFF/
6VL4N4IU63DB//3T5PMdEF9Syul8xM1geE6k03zubtnTrcOzZL821J/rTYD+fCUs
XXpI7Dg20CA0kBQhqiLfoB8q/s5Ams/tJJ+Y2Og+++J/1I/DqOjsR1hlxNueMCDb
gQkgn9UGGEddXF7ZwI8b5fckCs7VdpLl4N4h3slZVcNS8EERttYSPDR2vlY9vNWj
nNkz1PAlGt2Tso5r65oTTaXThvA/lPtF1+su4rpGJQYpwbkSYUC8ASLpDHIMqkHO
XLOepMNkcjpFU9x7SY+ASrXQD3S9bPvQeh63e2uLO7zfR9S6PlbOYGsRoclFdBde
/QLDry1kQn63igSalgIsCXlHZhxLhtgzTIeFkhwzqyZYYCERKouNRShcPIGL3+av
vRZ6509RI6c05vQXQ1qjNAJlG00GtUg5PEZHrcHVTgNhBDqEPhY6OEv+zugCO2Hc
s+EM5fblfBG3duQsitssc5TbJyjZiyqTCA5Kltk3+VztJs0fNwwOjZZFlKlAF0yQ
fkbhJUFcGgcWN+Z01ozFE/sj40zobcdl9sY6a5NKcqqEuRy41+64z0B+H52I8Avw
eKB8KOSJ9FARwRxh/wX8aUSReEGMbB6DXiUEBKaDh34Ajd/8Ano=
=9VHC
-----END PGP SIGNATURE-----

--T2E6n7zd74xy--
