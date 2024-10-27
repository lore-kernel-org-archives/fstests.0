Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CD1CD2C
	for <fstests@vger.kernel.org>; Sun, 27 Oct 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730048759; cv=none; b=no841vQsOfcHx59HHYNHhpPFKWcmhzK7lgTuV1IG7Sg4zPS1ueY//pCLGGsuEK7cEQCNSt2tZEAj1UWlk8MngT5ciDOBsOj7U1tUW8oCebRLjtb4Uvw7jtKODCoj/i6/kuzeDnzkFPeS9kMD5yz3vKGyfF290mGbA5txvWqz2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730048759; c=relaxed/simple;
	bh=UwhE23ZsAdk2yS+gGts3tFXhkglNlKsl8GE4YrnwisY=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=J7A1YrPOzhhNa1oQtO/QlOWl+08vumRiOJLnqtKlQk34aJPGXMuhgvenlJ0ugYucGXKjEfAxTOGhaR0F5KPgYX628puhQ9UzhisZjGYdsuuxMIGsH3p8GEAV4F2Mms3LESh5GlJZc/cpzB0DKG+i+eo8gf5rGqnPcmLAcUOUzAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNCPxh5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNCPxh5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4DBC4CEC3;
	Sun, 27 Oct 2024 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730048758;
	bh=UwhE23ZsAdk2yS+gGts3tFXhkglNlKsl8GE4YrnwisY=;
	h=Date:From:To:Subject:From;
	b=YNCPxh5PMSYgCwGi/aWn8jYNHqt82cmNYygOa5PoBw0dPaWErKYxvTY/K6Cayo2pL
	 ZOTy5YYFeL4vF73/57NZotpPngEDrevZLzyBYKSBDgOX4Q5JrxxbqOTFqcIXW5fVK6
	 cbOZ7HDXayGqsaN+zL7G2hQE4bnSNtSAak6sAa06R+hlOoWhaQJ+ts/5gkL1SLvOLG
	 gGSVLDoru2MDQTQTSz7YXiWMg7WfNHXSMWMxeUQTyiRiTl/z5yUk8ofMFm0uMjQ4As
	 /bkncOOLWlX4b9yV4KQOTeuaaq9gHqzJe8skkVPoP9XT5zhD77wlW3AYtO3gU8VP9V
	 7LQ/7LzYV9K4w==
Date: Mon, 28 Oct 2024 01:05:55 +0800
Message-ID: <1f4b48e1e9349e3a890858395ed24068@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.10.14 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dBa6enpZe4r2"
Content-Disposition: inline


--dBa6enpZe4r2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.10.14 version.

Thanks,
Zorro

The new head of the master branch is commit:

891f4995ab07 src/fiexchange.h: add the start-commit/commit-range ioctls

New commits:

An Long (2):
      [e0c84186bfda] src/Makefile: install two necessary files
      [37f61a8fd323] btrfs/315: update filter to match mount cmd

Chao Yu (1):
      [4c9c08ec05c6] src/min_dio_alignment: don't return invalid dio_offset_align

Christoph Hellwig (1):
      [74777e97c56b] generic/694: sync before sampling i_blocks

Daniel Gomez (1):
      [dd0eeae9ead0] common/config: fix RECREATE_TEST_DEV initialization

Darrick J. Wong (3):
      [cf838edbaec7] common/populate: fix bash syntax error in _fill_fs
      [ff07e0a32936] fsstress: add support for FALLOC_FL_UNSHARE_RANGE
      [891f4995ab07] src/fiexchange.h: add the start-commit/commit-range ioctls

Filipe Manana (2):
      [b37aa9c8b0f9] btrfs: update some tests to be able to run with btrfs-progs v6.11
      [8babf87596c8] btrfs/322: add git commit ID

Hans Holmberg (2):
      [0ffcda29e8a0] common: make rt_ops local in _try_scratch_mkfs_sized
      [2f7e1b8a6f09] xfs/157,xfs/547,xfs/548: switch to using _scratch_mkfs_sized

Mark Harmstone (2):
      [c9a2881aa6f8] common/fail_make_request: fix error message
      [f4b00fafa4ef] btrfs/318: add _require_loop

Qu Wenruo (1):
      [034e56559337] fstests: generic/563: use fs blocksize to do the writes


Code Diffstat:

 common/config            |  2 +-
 common/fail_make_request |  2 +-
 common/filter.btrfs      |  5 ++++-
 common/populate          |  2 +-
 common/rc                |  1 +
 ltp/fsstress.c           | 14 ++++++++++++++
 m4/package_xfslibs.m4    |  2 ++
 src/Makefile             |  2 +-
 src/fiexchange.h         | 26 ++++++++++++++++++++++++++
 src/global.h             |  4 ++++
 src/min_dio_alignment.c  |  2 +-
 tests/btrfs/006.out      |  2 --
 tests/btrfs/100.out      |  2 --
 tests/btrfs/101.out      |  2 --
 tests/btrfs/218.out      |  1 -
 tests/btrfs/254.out      |  1 -
 tests/btrfs/315          |  7 ++++++-
 tests/btrfs/318          |  1 +
 tests/btrfs/322          |  2 +-
 tests/generic/563        | 10 ++++++----
 tests/generic/694        |  4 ++++
 tests/xfs/157            | 12 ++++++++----
 tests/xfs/547            |  4 +++-
 tests/xfs/548            |  2 +-
 24 files changed, 86 insertions(+), 26 deletions(-)
--
Zorro Lang
zlang@kernel.org

--dBa6enpZe4r2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmcectIACgkQlNbPkfr2
tMyMPxAAoMU6/9LC87Ud4Yjj2rK80tEzPXukQ2ClnX454b1W/dWB6s5t/NzL/e5U
evTsNUHSXw+J2xAa1l0p+UiCq1Mj7VSFwd1jUmacCWMNY9NYOyFNS38AmLfqImYY
c+rdNO0Gx4L8Quv8o4+UVk4H3T6qDjl4BAdvyBDeIJYo8UmfVdtW4L4de1ondMfb
+wUadEawGfvEd9wYTCbojBJOHVzxm5VSkwe+M9VMH/77pIe9b9YWRZbHxiYje+4/
xOvL9UEMgzHqOqBJ8CHLxyPyiD4WgAv6RwcDmQD89CQq90oXdg7AA+8rJ7NVAZjw
9QeLhoKbOfbUsudIi4VZUrQ5D3hUaZWzKnEjtg04zBAHiOFmr5oIBjJUPDIXobfx
DFwE3FQ1Sa1S/8ZqkapeC5IeZXf5EZIOKZxejyW3a0n1rG+bxFXv6sL6zN2d0iaY
Yfswe+CefnYw5Xxv3NJup05zjriT1E88LLt2Afvs6tQ4LrjhjcGoCka8qx/zlell
zVZ5rkH4oA15IWrmvyzOAp5xnyI8v4HLidulSLOxL1yXQKqDZZReHUqh8b2CVi7h
KpMevCvIR92ym5lRTI3Ch5MvTlgWlth85Nfgb5YkeeuEFvEGQIf6aL3aA8UuDYPs
tI6gGV0KXyAprK68G0jz11TdzV2BIHQ/HqjsTCFjnPTKNfYyZjw=
=7pp3
-----END PGP SIGNATURE-----

--dBa6enpZe4r2--
