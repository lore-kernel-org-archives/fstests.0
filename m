Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B924C92
	for <fstests@vger.kernel.org>; Sun, 22 Jun 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750604471; cv=none; b=Tw7IrnmximaZcvCOtJoWga8Fkua4XAp0TTK4veRsDXkwuuShZgmX6yi/mdILcZbLoez1WYq2XMz+sm0n20n/3yyBbhW0V8G2TSPcfgp0vfwmoso8HUvdZHy8YCWunGwpAgcf7ocpX/IC+sc7G5aIddA9q6mV6kZI8BZcOYiEK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750604471; c=relaxed/simple;
	bh=/7zu3smcarMHn1pt12Sp7Q6Mp84N1oJn2h1jZgbnDj8=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=pO0XtROFF8Asn0zlRpwNenp2oy0xuESWksKk5Yg8z368qZj9IM0KG2MuWFLQMnnH/Le9QuLX1yRceMJkbp+aWGSqtpMDmR5RwW5yHIeHl196Se7O1ZthlE78oGsH20JD7hYajhuAmGU54atQd13ky4t3SRCutLyaGSjlxPxaPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb3kDClZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb3kDClZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC92CC4CEE3;
	Sun, 22 Jun 2025 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750604471;
	bh=/7zu3smcarMHn1pt12Sp7Q6Mp84N1oJn2h1jZgbnDj8=;
	h=Date:From:To:Subject:From;
	b=tb3kDClZ6L0SkQlVEyGbRjxz1o/usYKdcLC8iPLgFMFBvfUQQMx9cYnTadPYs0Ymf
	 sPGkEelyqamudojSaFS106uH7Zihvn5lgar1UwruWTi1M8LZHpheyrwbKHgeEXK828
	 VRN1Fhz61GT9iIshKyykObdQivetcGKXSuw4iAYd/FtIXyJLATWOktnsOcAZIwz+qo
	 6KXgq8C30ncuBiGnR5yxceiqn9IsrvjKtmEHmkoJoRlRVNmtNN/bfskdWVHKkl0Q8u
	 QpitlWDxbC4MfYAPwp6WqaQ8LaXGMdOmD6H9wX/0+/ZEEtJbTDGeatiJ6VOJcn6p5Y
	 V2kfbKmocnIRQ==
Date: Sun, 22 Jun 2025 23:01:08 +0800
Message-ID: <f1ebd78a328bce8c4e8f00f7e8cf90d1@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.06.22
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0YczpuPVs8nn"
Content-Disposition: inline


--0YczpuPVs8nn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.06.22 release.

Release Notes:
1) There're N new test cases in this release, include overlay/088,
   overlay/089 and xfs/837.
2) An ext4 specific test case ext4/002 is moved to be a generic test
   case generic/766.
3) Two new helpers for shutdown, _scratch_shutdown_and_syncfs and
   _require_xfs_io_shutdown. Please note the difference between
   _require_xfs_io_shutdown and _require_scratch_shutdown, and use
   them properly.
4) More fixes and updates for btrfs, exfat, tmpfs, xfs, and so on

More details please refer to below commits. Thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--0YczpuPVs8nn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmhYGoIACgkQlNbPkfr2
tMyihg//XI6hIeainjY8Zde+CCVqaTpaiXpiVhJ7XRToQ4gjw5B3OG9j47VVXF1M
LFpp5FJLeOhVSXrWAEzG9CR2JZKUI9c5dp3pKE9dPcn8jKx4xlUaltXCG1tkIftu
jIgEWlmJJCxbFBl9t6boC3O/XEFFqYhpy3pwTjvH3us93trpNpwgssyb1lfnD4jA
OLCy4D9Tavus2CZtUbEwCijVNTbbh2Pe8JDmOEACzSCzM5lov6R35yGI2KiPvts7
Ma6HnLC13EeqWlcjahefVAhiLuX3wsxKzxiOdhzBnkdTPRCYcZru/tXSJPsFA5di
fzZdstwIKkTtFgA0KNAFXj71Het3dum9yT7reKgOuQbVMTa0EssQqT/VlagBgXsA
hJxBmE+0k+vDG82FXu+a1F0hCuH6ekb648hO8u4ZxwF3tGGIb5ndmPblLWt41Ix6
GpXv0M0dGVSM6gUXn9CXJpjpJg+9+XoYQpKLeNW6yJsuYOIYednU88z2I7uzMvJM
Awfw1KQ7In2iysYZUKx7KaZNEmI5fn8TOylWj9MvvqUZCYDZbg57z3NyO9CY7Wem
km7Sb+vEbowgAIdxzqvInuED5mVFRNrG9XLXF1GsyVm35SecDAu0aCZ+Ef+KijDx
RQGMMGJ3IheLA2m+PGSaAg6NQBZtO/jpb3lEIpkvcbHYiBq6SdI=
=XKGa
-----END PGP SIGNATURE-----

--0YczpuPVs8nn--
