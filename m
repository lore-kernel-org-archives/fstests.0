Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A18835
	for <fstests@vger.kernel.org>; Sun, 29 Oct 2023 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYdJ5u3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06EFC433C8;
	Sun, 29 Oct 2023 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698586898;
	bh=AipYcCrdLJYS2RZ0/Cq3AyMpse2AaYrDOw/ktcYu2XM=;
	h=Date:From:To:Subject:From;
	b=hYdJ5u3imTtiOONhbW3411Uj/sFHhhUok2wFlarSKDh0yQqHEr5jU8efEkwMR8oNH
	 QlVVfo4CxPdxUEAGexSdhKWtrIk6Q+NZn810loK5DvsFDf9pmf6uHRRXvCt5QJgb9s
	 ASuxvatV6rCDv8vzxaBV810fAw0YFz1TtJxZVPYNphgQPT4FhfS4NBFJmYqyD2f7LQ
	 GJUFXApB0rgMXwqOBB8IVZv9Dw5ZDagt84kBS33ztZeD+WvRG64lXAs2nq9WSQ/s4c
	 AgvrREsVsfWkLeqFobr9oUxnPekKc4sEIijpCfwyPWhYI3cPufEsVueLC66jCLOkgd
	 mnssvCVs3+NTw==
Date: Sun, 29 Oct 2023 21:41:35 +0800
Message-ID: <2cd8c0ff8a8c105c42da5f8570f612f5.Zorro Lang <zlang@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.10.08 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xxQ2aAPJYHZi"
Content-Disposition: inline


--xxQ2aAPJYHZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.10.08 version.

Thanks,
Zorro

The new head of the master branch is commit:

59299b65ac8f README: Update overlayfs instructions

New commits:

Anand Jain (1):
      [0b70188b651b] btrfs: test scan but not register the single device fs

Boris Burkov (6):
      [c0cafb48a892] common: refactor sysfs_attr functions
      [587984a47e44] btrfs: quota mode helpers
      [b887c9f7bd38] btrfs/301: new test for simple quotas
      [177848f09a13] btrfs: quota rescan helpers
      [c4e3b3d482d7] btrfs: use new rescan wrapper
      [15792e35ae9b] btrfs: skip squota incompatible tests

Chandan Babu R (1):
      [809fd13575df] _scratch_mkfs_geom: Fix regex used for matching block size option

Darrick J. Wong (3):
      [4609e9481fe8] xfs/018: make sure that larp mode actually works
      [9b88ac7ee508] btrfs/300: check existence of unshare arguments
      [975277cea4c4] xfs/{270,557,600}: update commit id for _fixed_by tag.

Filipe Manana (2):
      [f55e46d62968] fstests: redirect fsstress' stdout to $seqres.full instead of /dev/null
      [d213e332a32b] btrfs/192: use append operator to output log replay results to $seqres.full

Khem Raj (1):
      [ab81b565f360] fsx: Add a return type to aio_rw

Naohiro Aota (4):
      [0f4d4a18b397] btrfs/283: skip if we cannot write into one extent
      [80e277fd69a2] btrfs/076: fix file_size variable
      [7a093dfa66d6] btrfs/295: skip on zoned device as we cannot corrupt it directly
      [ffa82237277e] common/rc: check error case and fail the test

Vyacheslav Yurkov (1):
      [59299b65ac8f] README: Update overlayfs instructions

Yongcheng Yang (1):
      [fb817fa4be6b] generic: add a test to check move in mountpoints of the same export


Code Diffstat:

 README                |  12 --
 README.overlay        |   9 +-
 common/btrfs          |  64 ++++++++
 common/rc             | 139 ++++++++++------
 ltp/fsx.c             |   1 +
 tests/btrfs/017       |   1 +
 tests/btrfs/022       |   1 +
 tests/btrfs/028       |   4 +-
 tests/btrfs/049       |   2 +-
 tests/btrfs/057       |   1 +
 tests/btrfs/060       |   2 +-
 tests/btrfs/061       |   2 +-
 tests/btrfs/062       |   2 +-
 tests/btrfs/063       |   2 +-
 tests/btrfs/064       |   2 +-
 tests/btrfs/065       |   2 +-
 tests/btrfs/066       |   2 +-
 tests/btrfs/067       |   2 +-
 tests/btrfs/068       |   2 +-
 tests/btrfs/069       |   2 +-
 tests/btrfs/070       |   2 +-
 tests/btrfs/071       |   2 +-
 tests/btrfs/072       |   2 +-
 tests/btrfs/073       |   2 +-
 tests/btrfs/074       |   2 +-
 tests/btrfs/076       |   2 +-
 tests/btrfs/091       |   3 +-
 tests/btrfs/104       |   2 +-
 tests/btrfs/123       |   2 +-
 tests/btrfs/126       |   2 +-
 tests/btrfs/136       |   2 +-
 tests/btrfs/139       |   2 +-
 tests/btrfs/153       |   2 +-
 tests/btrfs/171       |   6 +-
 tests/btrfs/179       |   2 +-
 tests/btrfs/180       |   2 +-
 tests/btrfs/190       |   2 +-
 tests/btrfs/192       |   4 +-
 tests/btrfs/193       |   2 +-
 tests/btrfs/210       |   2 +-
 tests/btrfs/224       |   6 +-
 tests/btrfs/230       |   2 +-
 tests/btrfs/232       |   4 +-
 tests/btrfs/261       |   2 +-
 tests/btrfs/283       |   8 +
 tests/btrfs/286       |   2 +-
 tests/btrfs/295       |   2 +
 tests/btrfs/298       |  55 +++++++
 tests/btrfs/298.out   |   2 +
 tests/btrfs/300       |   2 +-
 tests/btrfs/301       | 444 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/301.out   |  18 ++
 tests/ext4/057        |   2 +-
 tests/ext4/307        |   2 +-
 tests/generic/068     |   2 +-
 tests/generic/269     |   2 +-
 tests/generic/409     |   2 +-
 tests/generic/410     |   2 +-
 tests/generic/411     |   2 +-
 tests/generic/589     |   2 +-
 tests/generic/732     |  58 +++++++
 tests/generic/732.out |   2 +
 tests/xfs/018         |  13 ++
 tests/xfs/051         |   2 +-
 tests/xfs/057         |   2 +-
 tests/xfs/270         |   2 +-
 tests/xfs/297         |   2 +-
 tests/xfs/305         |   2 +-
 tests/xfs/538         |   2 +-
 tests/xfs/557         |   2 +-
 tests/xfs/600         |   2 +-
 71 files changed, 828 insertions(+), 125 deletions(-)
--
Zorro Lang
zlang@kernel.org

--xxQ2aAPJYHZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmU+YNoACgkQlNbPkfr2
tMx3jA//erHZ8yn/KQrBiz+Aj68BEzLaQw3H6jFFEyf0zG9hYOawxV7HYUfaVy+j
RKxVNmjj3OTuSTcy95IG3+gELL0Rsm/61F9mvawIM8RkMd054sZnlR0jSGd1fpi0
+jEPt8hoyrvn8QonH+nBe/VJ4r4tdlo2nacdwx2pwZJnkP3jtBqnZiaJRvWGCElp
74PHo65k8a+akiLZipza/Yf1PiT1M8U8z/Zt9K+2No9yTIdxgWNIBSFY3s7J9wCN
NC9tesh2ufp5MdVwo7dt/vSmUXjAN95YK/WaGUJ7Q6O6JQ/1CZ8KJnhnViem6VQB
vrtTCBmc2DrOGxZx4QSwUK/9pUk+u+4q4lKWaxhepwIQXNRc1XLQxH97JtLqETwi
Kz6ae9BYzN0uiv5yaV5TO8tigYXg4usdjYx00NyDHI5Z+2alAgh9WkAids15/3hS
EbbUyBX1HF+FuCHw8oEzhUj8/fkdTx70gWA/GNV6s6adNxuFiP4L7c6/1L85S87s
rzE6DXhi88hbFrRZQN2FSXfeKwwkwkyz5v9dF6YOZVFNFcP8kdOLSeM1xNUSmQ68
ECERA0lp519Q75xrzhqCxnUoNy5p4EwkJnkScBKuTB3XbVEfZQT+NVI7v5UQPLqf
zJ0Hdo6IleaqOc1o1+6I+bDgD0OXYyl3qYPKAMn7uqYVsdU0/Rc=
=hymS
-----END PGP SIGNATURE-----

--xxQ2aAPJYHZi--
