Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7F12CDBA
	for <fstests@vger.kernel.org>; Sun, 13 Oct 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728838412; cv=none; b=WlxAvxbSOJDRo85Phi8IkAVsaGBnrzIdtgxdzFpKTyRgwZWJoNTN86x+9m5V5A2piWdZXp8jvXtvXMLUGWSduHAPisijf3Ceqp/ofeDYdcUn4BWJF8SAUHsNP9c10BeEThxttQWLVdsUada6WRK3inpTIt8/LgYD3/yrUP+mi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728838412; c=relaxed/simple;
	bh=vHfSLtRYG1Dk+PniY+eIkZrYz01p1u+KhkM3UgNAh40=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=LWSZU4JFmEKmRZgScX2xuPatNJBXx038pfrbuLi2VA1F0VjHLnaKahUWMd7hvqEuIuH98k1y49lWLz76MNtJyy9duazdeB0KJDNTHshTgLmNUQqW0w68D/cWapPRCgBYNje7MtiTaKTVQhgi1FZe/o9tdTjGyLHA2B5yKABBxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp8pJuCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp8pJuCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A83C4CEC5;
	Sun, 13 Oct 2024 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728838410;
	bh=vHfSLtRYG1Dk+PniY+eIkZrYz01p1u+KhkM3UgNAh40=;
	h=Date:From:To:Subject:From;
	b=fp8pJuCrtmnGFRr6ELhCiPJ5NfqtMOzkk075GYNaFtu2x/bY9dWlHZcxxqavq1Bk5
	 17/xdYbJx0SZXy5x8vvgOjvRPW4CxeHem5w+gmQ2T29VaEeXqJa2h6M9mXEFynM2g7
	 VbOn58ta7NeqPTp3ZJ4JNbpp/Hee82R85nQOoSTcBYcsjDLjgq3ajfDiqpqY7JBQLZ
	 0wMKd8KHNK0pmiRKEo3TBvAFwso8mfaC6ALGVHd1rwtu44DRaQqnQ+EtzrrNKQK5h1
	 NV89BgW8VjNnOPMKwP8lkOlcBTWQZTYpScSfTC82j971+XAcM6LmnwfK9GvKZ5w8It
	 yM/4tOa4YJ0ww==
Date: Mon, 14 Oct 2024 00:53:27 +0800
Message-ID: <a9295329d0ee7f8e0e64980ac4fc18ff@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.10.14
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3CEQ8qcI3E3p"
Content-Disposition: inline


--3CEQ8qcI3E3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.10.14 release.

Release Notes:
1) There's not new test case in this relase.
2) The fsstress.c supports FALLOC_FL_UNSHARE_RANGE after fsx supported it.
3) Fix some bugs in common/ and src/ .
4) Improve some btrfs, xfs and generic test cases.

More details refer to below, thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--3CEQ8qcI3E3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmcL+t8ACgkQlNbPkfr2
tMzNXg//Q+O95yb345h8Z8+Dm+SSr7SBsVznEYG1+tut6yBDB8tLo2y2qx+NO8JR
PpTTKZvvltwA68mBRcbG6NV2loHZWJSXOAeQHAX4VG6PqZrRmdHyj5wuC0YGZBY8
PzfXYZKRDRbqvvrRzlzB7A9QGNLAqFdWUJOVqoqAdOa28mNsARKsThjGevLpYXi/
+8iGtwiMzifmELxvUmeruZJqOGM85Tp1rk11EXDmPh3ItHoJVzUhk5iQr5W3vu/W
7DxKC44sb1LCnwsSTTXR3eyN04VVs5fajMbKc//aYWVz6nfJ/FNdvDgSykGFNBWY
YjvFiML8IOPs0+WDMm/k37Ukvh72l/6oE5oMF+V2QZj+6vhzv/pCTEIYTJ26cF3O
RhGJ55JJxWsFWnKbdUF/oLdEht63k0RqkCxULp5EII93LkhxDQX9hvQV56I6abnX
7in3+otdhpSafhzfBFTZKbCuS+JigIUe2kvRWSc3dM8n0n8+OfKiHKpc2Mrz9tIe
/UfKaMUHRAkICwKJ33kZ5UoQdxJkc5zNT7H/ZnILuuEiaxtPb220sOD7PRPED6Cg
P6F6CjmVD9pPLrLW8Dd5LjB74taYhjZ8eXwFdpbesWrJccGT1/g0wgrzc94I0lB0
kxORIMcW0RA+JILWZxuC85RnAwQyo3va6vzOYWvk9qaleuTMySs=
=Lnxr
-----END PGP SIGNATURE-----

--3CEQ8qcI3E3p--
