Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3A2913
	for <fstests@vger.kernel.org>; Sun, 22 Dec 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734878027; cv=none; b=t36WOxEYVU069n+j2TwXnI4+dTvT/v32aKADSsQ7yMu3yaRfm/s6c6MtEXNA2YfEFgBr7ubsVLkjh0ScNzZWMAoJ6haru+dPlRM5BMxBvRfw8LUM3ipoG+vq7AvJZlU+TGLIJrPcAuX2Ppj6QNzqhVXsZhUCiFqeBXdYx31nz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734878027; c=relaxed/simple;
	bh=09sg357ez1Oa1bn3vGEh9Ooa/K1Dau6/6VHwLcMCj4M=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=On5X9OdjqXD2raSsNAsurs736riU7ZYoHYueAfZ5dCk5dI7V95rnABSB5bprDgtFrNwz7UxQKL+MFmZUXNRr+fmmNkI5l3cKoZSc+0ez/Z6odlPBx0rdqgGHbYt9LouLptG1rI2lUuwOaUZJ6Qt+4hYKJy3kHAKJ8Zjto7qV0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5jiDdDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5jiDdDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98144C4CECD;
	Sun, 22 Dec 2024 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734878027;
	bh=09sg357ez1Oa1bn3vGEh9Ooa/K1Dau6/6VHwLcMCj4M=;
	h=Date:From:To:Subject:From;
	b=I5jiDdDLL5iBtY4hhBF3GJlx1pF2SRLF/5YjbC0c8MyNb2ir68Hg3i8FCDXwhrHzK
	 tuph/HMHXZGexdUBY+Yp6FWF/rGGvXFVb5MiQecVlW9+wn1QpAuHGp7pJ6+mEhlwQB
	 1gVow+1uSQy5T6T3X/Qb/OF1JGuScFREbam9d85IgTSAg3cxWWhSca435v0BtQoxR6
	 hgzZPQVQk1VIjx16KPUM9eiodNZ+3+3R5dwxC2GrVd9EUhH82GR19nqpHzxeToycKz
	 CngmSZ3AA2b68lAgq7QoDQI97ZJriqVmrhlB7D5+WDccbEH63EwUC+8uW6aBhHVZtq
	 82vQbIsFYrgHQ==
Date: Sun, 22 Dec 2024 22:33:44 +0800
Message-ID: <f181e6f3383c1e9db12c16abcb2a268c@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.12.22
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tw67LmalBufo"
Content-Disposition: inline


--tw67LmalBufo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.12.22 release.

Release Note:
Since a big feature updated on last version, we get some updates and fixes for
stable this time. There's not new test case in this release. More details
refer to below.

Thanks,
Zorro

The new head of the for-next branch is commit:

023070744cef generic/530: only use xfs-specific mkfs options when testing on xfs

New commits:

Chao Yu (1):
      [4a33c5b1dd0c] f2fs: add commit id to _fixed_by_kernel_commit

Christoph Hellwig (3):
      [2b66be5f5cfc] common: loop device work on zoned file systems
      [825950c8cab7] common: cleanup scratch_mkfs_sized
      [3b9f5fc7d7d8] common: call _require_scratch_dedupe from _require_scratch_duperemove

Filipe Manana (6):
      [1f32af6a4ce9] fstests: fix argument passing to _run_fsstress and _run_fsstress_bg
      [06626fb70ae7] btrfs/100, btrfs/101: fix device name in their golden output
      [9b12a1a8a35b] btrfs/142, btrfs/143: fix dmdust device names
      [8212e1ada5e0] btrfs/146: fix failure due to missing test number argument for fsync-err
      [7c5604ec86b8] generic/442: fix failure due to missing test number argument for fsync-err
      [a1d583fa0062] generic/590: fix test failure when running against fs other than xfs

Theodore Ts'o (2):
      [f7262fd49cf8] generic/135: don't try to rm $SCRATCH_MNT/*
      [023070744cef] generic/530: only use xfs-specific mkfs options when testing on xfs


Code Diffstat:

 common/rc           | 24 ++++++++++++------------
 common/reflink      |  2 ++
 tests/btrfs/100.out |  2 +-
 tests/btrfs/101.out |  2 +-
 tests/btrfs/142     |  4 ++--
 tests/btrfs/143     |  4 ++--
 tests/btrfs/146     |  2 +-
 tests/f2fs/005      |  2 +-
 tests/f2fs/006      |  2 +-
 tests/f2fs/007      |  2 +-
 tests/generic/135   |  2 --
 tests/generic/442   |  2 +-
 tests/generic/530   |  9 ++++++++-
 tests/generic/563   |  4 ++++
 tests/generic/590   |  2 --
 15 files changed, 37 insertions(+), 28 deletions(-)
--
Zorro Lang
zlang@kernel.org

--tw67LmalBufo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmdoIy4ACgkQlNbPkfr2
tMyxJQ/6AxtIrrDpWDLB22KqRWlZBrbydxf8/r3w4IDcffFjKh73ZbsfN52TDfR+
sAsyeu4poblzlT/JoH1v8qFJdU6KP4wHiNDKORDYOxgKi91WpXC89KHghN6XDFzP
imqQEMYKjDDEeghicBzJcujF+IQGrd9znKGKqHLga0HKhkVc9VKWRTlfkCLr1eaB
50xSG8Tm/QQipd4VjKUzfY+fTBWTEr2mC+Q9GrDaLoD+IEvkmFziFpmpGStLnxfa
IbOsslA4rLUqk44fLec0pPrQekvK4YMxFb3/CzSPvvJ1KlTccDmY42TCKC/Qn7ab
MgOjLtraUheeJJz/Rz4brBlYCrgp20FY5dsWnU1rUbxoOPzxMKlMlVrWsEW47GW/
iZ3LIxjfteLacDyHz9yL+wpQ9uwW2k5H+xhKtCnIbGBi6d+yJ6sCczQKwE1vjx3z
jZceuOkPGuFhJgK6lAUCOMC8K8gxi9X7cM4Crh3kVBfpTXEs2CYezaR1xDPgxZAc
T6QRQuTbV/+VyTGqL6pjvhiZ335yYbl2EoXfOjn5k2c+bcUCQn6I1IrhYK8kzc+H
s5iKKxy0m2XKgnFIH0xUxY92aupXkln90rNppJAa83KO5a3s6Kqj35+yADw0+bCI
X0UyVYy7r+Hr23ZbRMM7/hab4KSXGIjpw+5QzFBujVo8j7DI+Lk=
=ckJ9
-----END PGP SIGNATURE-----

--tw67LmalBufo--
