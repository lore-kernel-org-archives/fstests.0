Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A94EACD
	for <fstests@vger.kernel.org>; Sun,  8 Sep 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805918; cv=none; b=TK2PjGAofnWnTEudg8hJ0bmcLRdoaYjc/C0fE6t9O1kGAgck96ctO6K2dbF+7yRQoi8RXGeCtXuW24QUjgqf9pfxtDY+JZ0FMDhicEixgZ+GU+bh60cHyytvkEaX/HCTLEKLXjbMnrbrIyH8YVnl0XxxXB0GbC2X0Z+UQr61F4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805918; c=relaxed/simple;
	bh=2Jj3fnYrsfV1mSbZOI1JwosoZRzQ0RBBtKdaowKIsB8=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Lwuk2Vjb4itMDv4FSbsfha6MZqc1XEaT5PKsVW4C8CBMhP/k0KE6dRjy1i0lq6hPHvOWExhBL3VO59OTR4xYI/JIWZ3p/fggnID+zdgTXiRwt0v3gFGW/AfkT6mmBhN5hSlNlqbwIpuVeMrePAJTuD3xboTMPvc3oezA3V3piuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raWgIBet; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raWgIBet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53837C4CEC3;
	Sun,  8 Sep 2024 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725805917;
	bh=2Jj3fnYrsfV1mSbZOI1JwosoZRzQ0RBBtKdaowKIsB8=;
	h=Date:From:To:Subject:From;
	b=raWgIBetg8bvh5FI1nnyBbelsxikqstw43sh7dL71Nq6BFniym3PiVx1nElm73HM4
	 02kARHOLKksEomhQEiJQALzpJfdjP5yod1Mw0ogpggUW9ImtKWi1ze6NSyLBRzc9k6
	 IwdaH/GyVvlLAg1yYTas9EMReGHotJONy+HsYs4Ip90fB4Gf0pJtr+4Y0PK/3wVSjd
	 SEo4nfCq+sDI9noKB0JMQwCkGIsgFDm/ke6jyX82ajxSwnQHtAHxqrbWNchae+8wki
	 d2rQVgQ5kPaXIaOhdwAGXWDXx4VQ6sUd1+5Puf0jS/8Nf6SOoehouopgQelrElL74t
	 ZDMuoz1+tqOnQ==
Date: Sun, 08 Sep 2024 22:31:54 +0800
Message-ID: <5129914522d6c2722a877ed68ab65059@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.08.25 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJjpZdnioHlm"
Content-Disposition: inline


--vJjpZdnioHlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.08.25 version.

Thanks,
Zorro

The new head of the master branch is commit:

b14652801e2e generic/615: add to the quick group

New commits:

André Almeida (1):
      [5381898ebaef] common/config: Correctly ignore {TEST|SCRATCH}_DEV for tmpfs

Christoph Hellwig (6):
      [873e36c9c3cc] statx.h: update to latest kernel UAPI
      [0e5f196d0a6a] add a new min_dio_alignment helper
      [4a571eaae784] xfs/424: don't use _min_dio_alignment
      [515e61fdc791] generic: don't use _min_dio_alignment without a device argument
      [ee799a0cf1d4] replace _min_dio_alignment with calls to src/min_dio_alignment
      [b14652801e2e] generic/615: add to the quick group

Darrick J. Wong (1):
      [d77a99817574] xfs: add a test for v1 inodes with nonzero nlink and onlink fields

Filipe Manana (1):
      [e4030c9b6b00] btrfs: test send clones extents with unaligned end offset ending at i_size

Jeff Layton (1):
      [a49385587950] generic/755: test that inode's ctime is updated on unlink

Ma Xinjian (1):
      [1a7f5bbcdd51] xfs/348: add helper tags


Code Diffstat:

 .gitignore              |  1 +
 common/config           |  4 +--
 common/rc               | 15 ----------
 src/Makefile            |  2 +-
 src/min_dio_alignment.c | 66 ++++++++++++++++++++++++++++++++++++++++
 src/statx.h             | 38 +++++++++++++++++++----
 tests/btrfs/319         | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/319.out     | 16 ++++++++++
 tests/generic/091       |  2 +-
 tests/generic/095       |  7 +++--
 tests/generic/114       |  2 +-
 tests/generic/240       |  2 +-
 tests/generic/252       |  2 +-
 tests/generic/263       |  2 +-
 tests/generic/329       |  2 +-
 tests/generic/330       |  2 +-
 tests/generic/450       |  2 +-
 tests/generic/465       |  2 +-
 tests/generic/521       |  2 +-
 tests/generic/538       |  2 +-
 tests/generic/551       |  2 +-
 tests/generic/591       |  2 +-
 tests/generic/615       |  2 +-
 tests/generic/617       |  2 +-
 tests/generic/755       | 39 ++++++++++++++++++++++++
 tests/generic/755.out   |  2 ++
 tests/xfs/194           | 11 +++----
 tests/xfs/201           | 47 +++++++++++++++--------------
 tests/xfs/237           |  2 +-
 tests/xfs/239           |  2 +-
 tests/xfs/348           |  7 +++++
 tests/xfs/424           |  2 +-
 tests/xfs/556           |  2 +-
 tests/xfs/608           | 39 ++++++++++++++++++++++++
 tests/xfs/608.out       |  7 +++++
 35 files changed, 345 insertions(+), 74 deletions(-)
--
Zorro Lang
zlang@kernel.org

--vJjpZdnioHlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmbdtTMACgkQlNbPkfr2
tMwEyBAAxjJ2iessxYwu621nd6Q9hie33h6hBD3AdpnBTYY8BWZaNTX2gFYvsQ0e
tx/nbBeoxQmzQ2NQAXLR1/vnPzcbUiBYXH1w1lhpeasuRnuDHGpr0sbQgxlQ9jS/
KQB/EiBCxGR4rBIKjPqsaTd8d83Xex1RLDAk3hBO3m9r2GQl7834N5hroeZEDtOe
0Ysplo8w0bzQCeKVgZS+sH6FH6xytqAe1DVZXJu84XR7iAYRysy930RGBfnOl15e
dHzzqfFicqOrXrjTiymivLG/RTwRB5FkIj2egE3CV4afy9rYBvsUZRekbfwohjy4
G7lQmOp0NbO/+egcM6mD+VHRvoonbofYdMaZ/C4lXYu8o6frY5BDW4Z/Et9nAJeh
eoIK7ppFGZ8Lp9pDKB8NNvbE9+r+MUaQ5HCjHGjfDS1JJFJjrqc9Lv+E8BTS77NS
7oqkw6VUuwoFfCWo9p8uC6plIReuE3AWhy32VMoTUfji6p3brgAdpeYD4rrIYwvg
8BlaeSOunNMyoJ0tRG7oTTJxw/UhJpZEA+sGW+i5TIX5EEIFwZ2U+hzP7VgDR2Y4
6m5+askfHzOb8A4IJOk6LvokFJG/fPEfzz99efFYYurOFA5kT0i4s8mFMCHYTqkU
5ZXIjvjV9QCUKKJw66NFxjnJmzLmsNPLY5S6fUKqrFaIK+yZTsk=
=H3wl
-----END PGP SIGNATURE-----

--vJjpZdnioHlm--
