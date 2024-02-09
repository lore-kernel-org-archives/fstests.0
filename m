Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541920315
	for <fstests@vger.kernel.org>; Fri,  9 Feb 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475274; cv=none; b=YvmvMsAvBr5baBE9j/vm6wEDA2FEroVqPrpcePpBM7LtCVqseBe715ASQSNHkMypjdNQhxBzz0vsuU0p+E/JrpnGwrpu3fJVqcKD7ZNRUg4ipKJPUpckDbIviUEXnuBONg11sKy4+B8rTFkNiM9E2rPgLBCSEbZbqRK2Y9k/ots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475274; c=relaxed/simple;
	bh=gbXpBqCYubKuKJGur3AW3oY+Cbhj7IQL1jQ77nUof8U=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=jqPxpcDiW5kHLBNAWSYSel65re6uOt7bpsjtWBWPMuYw/yzoqjxtANnjGdp1Exu9mMVOlgUJbcMbZmL+eg2Te8Jut3OOZnG/a5Qr8bNlmGvxpwddhIs+toQDwsOG7R8pXRhqXYi3IbDu4eTtH3hnwPxP3wgkM1BBxkNdYcd8Wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuPj+K0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuPj+K0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668BBC433F1;
	Fri,  9 Feb 2024 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707475274;
	bh=gbXpBqCYubKuKJGur3AW3oY+Cbhj7IQL1jQ77nUof8U=;
	h=Date:From:To:Subject:From;
	b=WuPj+K0WyBOx2QLsQ0Qnd8yf37ZKsAkKmSCf2a5CYxikzanju0jFJdesnkVAHZOga
	 FUGuhef56BoZsnbgTn7hW1f91bEtlaZoWB2keTb7RgsGFbFvWbQZ1mdLphhPkcSzeY
	 3V3hyzp+8J5oseWNHF/BO1CJbxnR0+BS/giARxBEOxnSj7OPXyMbYWcNZae9Byy2xc
	 GjcgzXzp7/DZuZy99iGCDzgW5DEhx8Ia3Bgn3oTxBuEr8WZihCRb3uJnQw1pc60Usd
	 0m9r8ZPkjZwR1j2KNx7JKUFYQy8b4AH077xDbL958UVzcnI8+gkSluft8Al0SJjmyE
	 oFOEhPQjKeOfQ==
Date: Fri, 09 Feb 2024 18:41:09 +0800
Message-ID: <773dc4e2d0eee4ded4fd596f17b9dfc2@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.02.09
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFFI9DzAgfI0"
Content-Disposition: inline


--KFFI9DzAgfI0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.02.09 release.


Release Notes:
This's a respin of v2024.02.04 due to a critical issue:
https://lore.kernel.org/fstests/20240205125746.tmr6wvhut5oiraut@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m441ca40d45dc5e8039f8cbe72b9b90ea86e69771
contains below changes:
1. Fix a critical bug of "common: refactor metadump v1 and v2 tests, version 2"
2. Remove "generic: add fcntl lock corner cases tests", to have more disscission
   with cifs list.
3. Add "overlay/084: Fix test to match new xwhiteouts dir on-disk format" patch.

So this version has:
1) There's 3 new test cases in this release -- btrfs/310, xfs/601 and xfs/606.
2) btrfs/303 is removed.
3) Supports XFS metadump V1 and V2 testing, refer to common/metadump new file.
4) Some fixes and updates for UBIFS, BCACHEFS, overlay and NFS testing, welcome
   more updates for more filesystems.
5) Some updates/fixes for source building, if anyone find building issues in
   this release, please report to us.

More details refer to below. Today is Lunar New Year, please let me show my best
wishes to all of you, thanks for all your contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--KFFI9DzAgfI0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmXGARMACgkQlNbPkfr2
tMy6DQ/+M4wJqQc5Q0scrzFlKzPNAkLWOEtT57A+XN03bAJBkxkUDKK4hZIGw2dZ
UTYSuOMljKqIDbt7EoiSGR8G8UooC/eu8KqB1rwgUS76cnsPOH1cCoDWly3FQlQp
oVar5viXiDfTcQ3g1vOA4qKNA0B6a7vn2ohV3R1Ref57RJ2B1WhOeNAExEgM//Z/
bXfuq19vz6i3rT30fq4gka4KYLRVDUnkyX2mSO7EfJEnT5OLFm4FQJLGxF2+bu6Y
ZB9ifoj4FdDQSEEAI8Qq+HJS5+BanW1qH5kNONnN1OWD2XKStlwKbo1yxAqarBMP
eQfy9tJpp4pd7QtpTwZLUWoDYRQ8LbrRutSUXxqU/pa6Beg5ziDO0fhSc1d7VkJ2
eoygKos8yyEnjrJBdCJWthyg0mTiKL3/zQU0Zcv8HyePiUj+FmkYC6LGTrTENrX9
KjhO9RLQ7JCjZGJj7MkQLCIZGohpOJPEwbVM75McS1sEPlK6oaG8MDro7kPzNlzB
sCab8ayibZ1NSUMVPSsfwPm3ahFtUk93VnmBly+AtPGngh+wjrXQLUoz8QRWh4jC
lkxqpoVdLarw6Hzg6nuyVh6KZn2ujC6btphe78K9PAmYjYp8xV7uocOU/ODufRzw
aClb/fYYSRLwnxIWKpo+5E7iy4hkk60ozhkiuv3zxHN3mt3WxcM=
=0CdB
-----END PGP SIGNATURE-----

--KFFI9DzAgfI0--
