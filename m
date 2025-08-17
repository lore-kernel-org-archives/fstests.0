Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208E1D514B
	for <fstests@vger.kernel.org>; Sun, 17 Aug 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443171; cv=none; b=fcT1XuJtpaAeTKs35eG2AY91F1WEvZw6XDkUZKsNhMqFFpwmSC4ugugYQtn8P5BaamZTMc6Gr8MOhfwntj3pR8EjJJzgwetc4UwTCQ+WbaGBqd4W2AfoOClK4ITvnUN61l+9rwNra5cLZUGczdwscfD9ViF7Bk1zd1p1EnUtGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443171; c=relaxed/simple;
	bh=VtOAcb2X8jxo9938CXMY3n1CgI7ylAkYI1bdQE0nGrI=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=QzEIcx/caMXf+16jcaQzCXZahtzR5ME9X3rCQZV0aMD2bKrEhjgeMEpokIKvbaw1h8kmuzw4pq0nzxj4BKsyqdu28ysulm3Ltej5BHKD+LJS0FuZesnhJ9qyAPU+Wc8zZKlVYzJn+Z6b4UfOSIkTSXihHLNZOKX/LMZjca98xp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZzyVf3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZzyVf3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7B4C4CEEB;
	Sun, 17 Aug 2025 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755443170;
	bh=VtOAcb2X8jxo9938CXMY3n1CgI7ylAkYI1bdQE0nGrI=;
	h=Date:From:To:Subject:From;
	b=FZzyVf3rXzVBEihEjQAvR7y79LQJr8WbsRKEpgYmltWxAM6INuCyn38ccju0xyKuU
	 Z0u37NfPBH19MmYdKMzsD1fFXsTyg4SnAj99RSUiC3EUaK2JD3bHzzo3jl/Hy3WJR5
	 cMiJEsIrCgg0Jb6MHUM6eSJJJFhQrXBWpAnJKG7cw86+QeH0cStkl6DxnxkHpuRvE4
	 GT32cp1jM2qsNUfsnurhY8jeinKcRaGNXsGpFIVUhAt5ZFgWJP+FbEGJsnK3Mz+RUS
	 mg1iy9JxfBphLnLMX6LNnGQxkMMM5bKOIg1GD+VeXz5V3d2SHxSzoiddhjcYQfwae0
	 XL0RyZPFj7GOA==
Date: Sun, 17 Aug 2025 23:06:06 +0800
Message-ID: <4eaf5933d0ba456957e3d69ea43668e9@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.08.17
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PDBYp6yhesud"
Content-Disposition: inline


--PDBYp6yhesud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.08.17 release.

Release Notes:
1) There're 7 new test cases in this release, include xfs/131, and f2fs/015,
   f2fs/016, f2fs/017, f2fs/018, f2fs/019 and f2fs/020.
2) This release is for f2fs testing updates mainly, f2fs has more and more
   test cases now.

More updates and fixes refer to below, thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

5a9cd3ef1b33 f2fs/012: adapt lookup_mode=x mount option

New commits ([N]ew, [U]pdate):

Brian Foster (1):
[N]      [3e802fc7c387] xfs: test iomap zero range via fsx and error tag

Chao Yu (7):
[N]      [88aa818b3325] f2fs: test common mount options
[N]      [f1cb492c2b65] f2fs: test special mount options
[N]      [785d75ac4918] f2fs: test mount options for zoned device
[N]      [3c4fce2127c9] f2fs: check data eof after partial truncation on compressed cluster
[N]      [7d38f690bf85] f2fs: do sanity check on mapping table
[N]      [97faf40fc28d] f2fs: do sanity check on i_xattr_nid
[U]      [5a9cd3ef1b33] f2fs/012: adapt lookup_mode=x mount option

John Garry (1):
[U]      [00dced3f6730] generic/765: modify some steps to fix test

Zorro Lang (1):
[U]      [b076a3a72941] overlay/005: only run for xfs underlying fs


Code Diffstat:

 common/rc          |   3 +
 tests/f2fs/012     |  13 +++-
 tests/f2fs/015     | 121 +++++++++++++++++++++++++++++++++++++
 tests/f2fs/015.out | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/016     |  50 ++++++++++++++++
 tests/f2fs/016.out |  33 ++++++++++
 tests/f2fs/017     |  40 +++++++++++++
 tests/f2fs/017.out |  21 +++++++
 tests/f2fs/018     |  84 ++++++++++++++++++++++++++
 tests/f2fs/018.out |   2 +
 tests/f2fs/019     |  42 +++++++++++++
 tests/f2fs/019.out |   2 +
 tests/f2fs/020     |  51 ++++++++++++++++
 tests/f2fs/020.out |   2 +
 tests/generic/765  |  40 +------------
 tests/overlay/005  |   1 +
 tests/xfs/131      |  26 ++++++++
 tests/xfs/131.out  |   2 +
 18 files changed, 666 insertions(+), 40 deletions(-)
--
Zorro Lang
zlang@kernel.org

--PDBYp6yhesud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmih78UACgkQlNbPkfr2
tMxaIhAAl2vsnsy+Heo2Iza9Pj8KgQugE+PhSEVPn558RFky1jNthxHfkIiQCIda
DB+MTat6RQjVHo283EtkJKqmva0zhZ2ZZ3oSeeTK36OyJELcA9zoPqdxhjompS40
EYQS7m+X+ijmV19R+tv7Ie6qFtZ45ikwMhe64ePT0MnBgaXK+GWXqt70t5nk+A0p
gkLjJ7Q5Gc/GmR+m8PZZyuiFCfUwaslbfmrf3cEf7sI+WiPSOyHVGQqeilxdNY4g
Sn5rlvneLU/xSNcXNCqr7kYCqo7yY3akmS/x7ypliBZ1TMM1w7mdu5c5LZUEwdAj
4sO0VPVl3660n+Itd3+dvlMCHzKOz0TL+LeHnwnBZIsBS0ED7fjxYfUWteWKfyoZ
Yg9usBS438Onf813rlrYHv5HloK2Uz1ibmv6nn2G1TiXtitLHSsFcgU2JbgG27zp
nKH3/VfuN84PYavd7vmbXG+bV/+ooqln4xrTD72tdj8mwnS23fCOSSCqR2nvtbcG
H+p+W3yQuVAXMz4RIMCPp03j2CXKQr5sjvMcuN2U/RzAaU9ADaSp0gwDCdSwPvFm
GZg8fXiiBO2cwDn3KiU4yQaoT15eV+FRafsBIHVLbA8xJqY8fdrTEOnwCCP2x22d
gWO2swwk67ZjYRBkmCunswiM4zjHkMRocJqlX4nkBzp3NoUIOYA=
=Goig
-----END PGP SIGNATURE-----

--PDBYp6yhesud--
