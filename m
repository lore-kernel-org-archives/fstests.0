Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D718A957
	for <fstests@vger.kernel.org>; Sun, 28 Jul 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182974; cv=none; b=XNDtETDYKxKnXaQLh9Jez9g09h/yhPjmnOB0CIfMZ+jpsOwmSPmwPNUGoqY4CIiAEdD9m4G3u04oqbW3gku0PLgWpt67/b625guzM9iAOKBitWE01BkVNPAA3SjJHasFI9pQQ2QrNy9byc5uMMNwwPHcLRAOpgZ3hdtRf0R1Xig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182974; c=relaxed/simple;
	bh=ETHVmpL86cD+QGpuQEXQxLA7IqxKdh4jSLQnmxTMfVo=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=eRq4NjTKcQI82yehqPP6GSsFSwkeTlz57ZbBkvSlpYCZojCotSkdN1OVB8+GgJohTeAeWgvFtEOaP4Uc/6MnxvERo/LRKacYWFpWTjqIAr7LtMwNwv7QRuwMrJYpZrfrGb2cjV9gVrebgW/8AUrBigftkgzLG29YXsgyx4TanSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTJWt+x2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTJWt+x2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC917C4AF0A;
	Sun, 28 Jul 2024 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182974;
	bh=ETHVmpL86cD+QGpuQEXQxLA7IqxKdh4jSLQnmxTMfVo=;
	h=Date:From:To:Subject:From;
	b=eTJWt+x2cQ8KrHsQIs/r9qpZ0SMLzKIlYUTvshi2ytVObn5eFVVGi3gkurF5f12H7
	 w7FHgTNYez2KZkcmVsjYnURGimm3V2oHLSgwc7+W7tdAiGSlVo4g6Azsf6tdpz1uHV
	 PrmCBKwJiaDZy0xMvyLmkDKl7pOBL1GUJ6ptEhWxfhu0ZNTf2q1mdKBa6743oSoonK
	 j6Rz4PKYd5o3noJn6beQ/c3JjX6GOaoVaFIQ9iZ+iuRQMBb/LsoiZT+e/9VQB+lHUh
	 9skTQQcguyjCgcDW7BzS/lBonrcpZIOtyN5+PtEjPargeSu7o+vKhbmRjHP2tNbB0S
	 JOUCWRSTR//7w==
Date: Mon, 29 Jul 2024 00:09:31 +0800
Message-ID: <74eba5b56b78f2d6b465fae7c3262ad9@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.07.28
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7uQS7KzyAqS2"
Content-Disposition: inline


--7uQS7KzyAqS2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.07.28 release.

Release Notes:
1) There're 3 new test cases in this release, include btrfs/312, f2fs/003
   and f2fs/004.
2) More updates and fixes for xfs and btrfs.

Thanks for all these contributions.
Zorro

The new head of the for-next branch is commit:

f5ada754d583 generic/754: fix _fixed_by tags

New commits ([N]ew, [U]pdate):

Chao Yu (2):
[N]      [c62c3d1cfbc7] f2fs: test for race condition in between atomic_write and gc
[N]      [410ab2ebf3b8] f2fs: test for race condition in between atomic_write and dio

Christoph Hellwig (2):
[U]      [7cb775459424] xfs/011: support byte-based grant heads are stored in bytes now
[U]      [0bc89993579b] xfs: add a few more tests to the repair group

Darrick J. Wong (1):
[U]      [f5ada754d583] generic/754: fix _fixed_by tags

David Sterba (1):
[U]      [9b6922eb610c] btrfs/220: remove integrity checker bits

Filipe Manana (2):
[N]      [592f6a79f56e] btrfs: test a compressed send stream scenario that triggered a read corruption
[U]      [02a689b7aa07] btrfs: properly shutdown subvolume stress worker to avoid umount failures

Qu Wenruo (1):
[U]      [b548b23fd4e9] fstests: btrfs/012: fix a false alert due to socket/pipe files


Code Diffstat:

 common/btrfs        |   2 +
 tests/btrfs/012     |  29 +++++++------
 tests/btrfs/012.out |   6 +++
 tests/btrfs/060     |   9 ++--
 tests/btrfs/065     |   9 ++--
 tests/btrfs/066     |   9 ++--
 tests/btrfs/067     |   9 ++--
 tests/btrfs/068     |   9 ++--
 tests/btrfs/220     |   5 ---
 tests/btrfs/312     | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out |   7 ++++
 tests/f2fs/003      |  65 +++++++++++++++++++++++++++++
 tests/f2fs/003.out  |  11 +++++
 tests/f2fs/004      |  48 ++++++++++++++++++++++
 tests/f2fs/004.out  |   3 ++
 tests/generic/754   |   7 +++-
 tests/xfs/011       |  77 ++++++++++++++++++++++++-----------
 tests/xfs/337       |   2 +-
 tests/xfs/338       |   2 +-
 tests/xfs/339       |   2 +-
 tests/xfs/340       |   2 +-
 tests/xfs/341       |   2 +-
 tests/xfs/342       |   2 +-
 23 files changed, 364 insertions(+), 68 deletions(-)
--
Zorro Lang
zlang@kernel.org

--7uQS7KzyAqS2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmambC4ACgkQlNbPkfr2
tMxoJQ//aPl+zQWElmKhWDaGDrC0/6x6GaOMX7x8z96FjULRcUsGcq2j2jkr/ck4
le92pQmCbMx7Zi6anZiH0gO7kRUtKj8w9CpmeSHWj4MecEcyub4KKdK6vTiQepIZ
uCi+U2+l8Uej+MbUKGFRNda3QyP4UAtbr/rIH3BdyxMu21/mFuCgc8f1WjciBwgE
yDwoczB4eSEJsbBx+TcIvxjrM73Gzh1PWwNuwOaca0+medYKHiVldL9pQ0l7pa6O
sjU/44SiSYeRudasa+OAgJAAXH4O+LWBwvDK1jJZ9G2BZPELrtlip2mmM+hcB398
bsBF15FLbuCUF4qvlXXL/50q7sOdPS0I6icpE1xk1QpSTjxbMq/JvtnQyZYOOCEQ
ZQhzlui5MZW3dbIOY0A6PtUXShq3+ctYe9aWGxm/Uttu9nBPZ6vQUPUHBsIYJSKr
pphhzB/SuIGrGRb0FRlzl3hlFssmrcVtLI7Hf9AQm6m8CZjBizpTNrt/A0Qi8UG4
yKEYIQ/oM77PbpoqKWp4djj1KneARXzJOcQSHodM8r3kGGesEVIzNyITGhKQgcGX
wE2bVi1Z8Gu16Crvb44FSlnSyD1QBk2KeZDFPA3a58s/rSCV+Brhja9tJwnBsQoc
kgudXN3SF8v4uYiaXdgXyunbNbKirmEyAh2m4oQxQV4Rfath9AI=
=5t7i
-----END PGP SIGNATURE-----

--7uQS7KzyAqS2--
