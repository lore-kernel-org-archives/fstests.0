Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78189BA27
	for <fstests@vger.kernel.org>; Sun,  3 Mar 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468544; cv=none; b=S1gxbwgWQx4nPq0+Ojfo16zE80EswolctTk1TQbcVE1kr7tQidAOj5DgAE0ZL1pqEYVc/nuVKzFd30REoS3EA78Sus4XxuyMfp2mnW7DYVV0d5Osz4I6bwZa9iCT3ZLPAk7Ce5TVrd8lxrxnl5sR9Ahy6xiBh79L1pg2aLvwsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468544; c=relaxed/simple;
	bh=lN1UHQf2EO9zLmhMy6QAwJNGhE3bIzbkxLWVP9R4bKw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=n8IcZIYJIh2EMfjg10AGIc8dI9bPlQjDxrJXCsuBZVRymhCa1UAySdOqlhslm1c5+2XEqGCssOPLSawZmF1eH0kMm6Ry8Prhy64UsQ1sSL6MFB2Jomwqo+ri9iKvQCE16TJYYt5hC5cxUt16EbC2N7h0YJw6EipYB4a51Z8DfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXXU0t6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXXU0t6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC1AC433C7;
	Sun,  3 Mar 2024 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709468544;
	bh=lN1UHQf2EO9zLmhMy6QAwJNGhE3bIzbkxLWVP9R4bKw=;
	h=Date:From:To:Subject:From;
	b=cXXU0t6LG+DHKEBn714VI2c2C/cqANgYE2+08QJdKgbyTjRm8XKoWLi2c0Uq/zVM4
	 EnfZyW6LwQypHjh2fgKamKxumJaZHxMuVZA2AeCJLdnWzdBwUm8fhg8nGWoSx4wJDO
	 1jMRyKCxp25NANWasRfr2QqupzSMx8aHw/j8y1dsPTj5fRy6/P35Dl1/6yObUDYRrd
	 kfgSLHGYLONJzXX94S45/wQAccgExO4twUDR7wapbnU8H4gl3NmhH7vyh114wsXzKc
	 agwYylx7fGOQ6Aca3xxMxAoqzEj+t120Q/eKoHLdGm7U5zTii4JhghJGJYUPAoetFd
	 ODsB4qKG/+jTw==
Date: Sun, 03 Mar 2024 20:22:20 +0800
Message-ID: <b57d8c60db51700b9f061fa95a2de046@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.02.09 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SToSNO7yGPVt"
Content-Disposition: inline


--SToSNO7yGPVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.02.09 stable version.

Thanks,
Zorro

The new head of the master branch is commit:

386c7b6aa69e xfs/122: fix for xfs_attr_shortform removal in 6.8

New commits:

Amir Goldstein (1):
      [c3eff0947047] overlay/084: Fix test to match new xwhiteouts dir on-disk format

Anthony Iliopoulos (2):
      [4e90abbc4d23] src/af_unix: drop unused offsetof macro definition
      [d2c077611de7] build: remove unused m4 macros

Boris Burkov (1):
      [750daa897667] btrfs: Remove btrfs/303

Darrick J. Wong (10):
      [20e0cf8b78d4] generic/256: constrain runtime with TIME_FACTOR
      [a5339f1aeb00] common/xfs: simplify maximum metadump format detection
      [1b36ec27ecfc] common/populate: always metadump full metadata blocks
      [5261c7b46fd4] xfs/336: fix omitted -a and -o in metadump call
      [31238f2b0f50] common: refactor metadump v1 and v2 tests, version 2
      [9c01c6997c30] xfs/{129,234,253,605}: disable metadump v1 testing with external devices
      [76bfc02c31b8] xfs/503: test metadump obfuscation, not progressbars
      [b809844c72b9] xfs/503: split copy and metadump into two tests
      [e595ffddd23e] common/xfs: only pass -l in _xfs_mdrestore for v2 metadumps
      [386c7b6aa69e] xfs/122: fix for xfs_attr_shortform removal in 6.8

Jeff Layton (2):
      [b3da25544c60] common/rc: NFSv2/3 do not support negative timestamps
      [cf72e89fdc2d] src/t_mtab.c: increase the lock timeout to 120s

Li Zhijian (1):
      [acff198213e3] gitignore: Add missing /src/t_reflink_read_race

Pavel Reichl (1):
      [c689690fa3b0] xfs/598: Add missing "fixed_by" hints

Qu Wenruo (1):
      [52c6d0f30ae5] btrfs: verify the read behavior of compressed inline extent

Richard Weinberger (2):
      [ef62fdb75bc6] generic/020: Compute correct max_attrs for UBIFS
      [8ba89cc8bff1] generic/597,598: Require groups

Ritesh Harjani (IBM) (1):
      [d99636b8efdc] xfs/604: Make test as _notrun for higher blocksizes filesystem

Su Yue (2):
      [f836422ec228] fstests: introduce MKFS_BCACHEFS_PROG for bcachefs
      [79e87ccf207f] common/rc: improve block_size support for bcachefs

Yang Xu (1):
      [6b0efdc02753] t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2

Zorro Lang (1):
      [7e1ca29d3038] xfs: test xfs_growfs with too-small size expansion


Code Diffstat:

 .gitignore                         |   1 +
 acinclude.m4                       |   5 --
 common/config                      |   4 +-
 common/metadump                    | 152 +++++++++++++++++++++++++++++++++++++
 common/populate                    |   2 +-
 common/rc                          |  63 +++++++++++----
 common/ubifs                       |   9 +++
 common/xfs                         |  51 +++++++++++--
 configure.ac                       |   2 +-
 m4/manual_format.m4                |  17 -----
 m4/package_libcdev.m4              |  95 -----------------------
 m4/package_ncurses.m4              |  27 -------
 m4/package_pthread.m4              |  19 -----
 m4/package_types.m4                |  50 ------------
 m4/package_xfslibs.m4              |  28 -------
 m4/visibility_hidden.m4            |  22 ------
 src/af_unix.c                      |   2 -
 src/t_mtab.c                       |   2 +-
 src/t_snapshot_deleted_subvolume.c |  10 +--
 tests/btrfs/303                    |  77 -------------------
 tests/btrfs/303.out                |   2 -
 tests/btrfs/310                    |  83 ++++++++++++++++++++
 tests/btrfs/310.out                |   2 +
 tests/generic/020                  |   6 ++
 tests/generic/256                  |   7 ++
 tests/generic/597                  |   2 +
 tests/generic/598                  |   2 +
 tests/overlay/084                  |   8 +-
 tests/xfs/122.out                  |   2 +
 tests/xfs/129                      |  91 ++--------------------
 tests/xfs/234                      |  92 ++--------------------
 tests/xfs/253                      |  90 ++--------------------
 tests/xfs/284                      |   4 +-
 tests/xfs/291                      |  32 +++-----
 tests/xfs/336                      |   2 +-
 tests/xfs/432                      |  31 ++------
 tests/xfs/503                      |  82 +++-----------------
 tests/xfs/503.out                  |   6 +-
 tests/xfs/598                      |   5 ++
 tests/xfs/601                      |  54 +++++++++++++
 tests/xfs/601.out                  |   4 +
 tests/xfs/604                      |   4 +-
 tests/xfs/605                      |  92 +---------------------
 tests/xfs/606                      |  56 ++++++++++++++
 tests/xfs/606.out                  |   2 +
 45 files changed, 556 insertions(+), 843 deletions(-)
--
Zorro Lang
zlang@kernel.org

--SToSNO7yGPVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmXka08ACgkQlNbPkfr2
tMyY1w/+NMnqdCH0+QXs+NU/FNcKqAx5US3SjQMhBVy2cuU9n/DqOzVPWDiVk8kR
o0kx4tXRhcjqUig6SXJsCL/xOsdyjotjXZOpx/93AJ6TwLt7i3KcXrk/9BXT2TwY
lAlk+oM5Qrz0IZXUPPyFYmYCefnXmRloMHPPRkgzyFMZiZHt8SuO4rmHLXJ3bqws
D2ud/y/MbA4JN/P/Q68WqVoC+hnkhkvPhrsZWvs0D2z/PBMyvAiHDKv7harg19xG
T10Uufe0MAV0k4WJsarTSAS5klRbZOXp1DWLcZcqB2qvvnNUHcxtG5XAsSU0Rayh
S1bSKVPhPO9a29HneH+rI2Z485tQ6RzCT4XSa+tVmYBgaMw4SHp2vF3kab97N848
ihE2Pd7Q809EqaMphzKWf10sDmMp518OKmZj0eM/c1Eq2gGlt7LMQx6g/N52v2Vh
Gh0nh4FIenTsaOXPg6zCaLXezXxm1WKBGOFHve/aENti73D8qzsH07B2Yp/p/qQG
826SHSBjgnLLj53pNraMzhTYHHxhbiHRjFz/7/wh8TMiRNfR+6oWlJSVe7cogGqi
Hs+wEalKO4DeM4iakepJOPAhsRzxk3MOUft4LwtiXu/6mPuG4/RIblb0sIwtHy6A
9BFQE8BqLAolTa1buzVQJ01yX9rCKzr1254mylb3zIlANQcBa00=
=j6d2
-----END PGP SIGNATURE-----

--SToSNO7yGPVt--
