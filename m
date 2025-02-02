Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1A1CAA7B
	for <fstests@vger.kernel.org>; Sun,  2 Feb 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738507611; cv=none; b=FTVS911UAohrYViZlJNyWy6pKHHXsYIc47gUk+XnG0yGIi5uBxR69ZYrGXfyFEizqEexEWOKTX3S3T8m0OcoR6Txb3uvHwr6EG9tAH74gC4c05tOWcHC1yrBWcXwuzJmYxZc3cGoCfZhD752fmKOgm1er0cLg6xqqUtLyt/b0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738507611; c=relaxed/simple;
	bh=5o8tQIBErNVwbWZ/RUwka93tW4tOF8h6ZhyVTZK9/X8=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=legyxBKcgYhMAlAAETCkTWNQ8gIWh+RUnVrUoEUkUWsrUnAoPucwpLpaL/dxdalrtdFXha+C5tMjOlB8fgUjZT211DffI5Kq8K3dgtJBux3cTuQgLRpx+4WbVcxclMy3QEuzEm4Y51CP5XY07QTyprgN+ZInmkVe0II5GrGKZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN1tSprD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN1tSprD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887FDC4CED1;
	Sun,  2 Feb 2025 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738507611;
	bh=5o8tQIBErNVwbWZ/RUwka93tW4tOF8h6ZhyVTZK9/X8=;
	h=Date:From:To:Subject:From;
	b=mN1tSprDCFM/+j2ORzKznvYh0TYb40To7vco0UnSWzePkkwnxL3ROinlJ/8bp4vdY
	 PoxqLAmmZInYIXSotfmE2SXFPanppTpnXWLOUcUnutsPjNhPC0B6M71sOcwRvdV2xj
	 /4JdgPsF5iCtj8Q+a+d3Jlw1V6lj4FUwaco12kLr6iSgQPcRk3FcTpCovEic5vxfIn
	 2+3AoE2o+9ktALVyrFuJBhRJRk4s74maf+CCAmU85sQjzKXOfcleSZmQtj2Xh4237U
	 v2BGFCPvYAesx/FIpMUnED9dnhvVUNovr32DFuzFvq2g0RMrXW88FXa6AARPG6KDWM
	 qpA8XF2dK+CXQ==
Date: Sun, 02 Feb 2025 22:46:47 +0800
Message-ID: <c052fc0100e3f0cb157f31ecbeb89ce0@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.02.02
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2vdJqhqsSB3v"
Content-Disposition: inline


--2vdJqhqsSB3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.02.02 release.

Release Notes:
1) There're 3 new test cases -- generic/370, generic/759 and generic/760. The
   g/759 and g/760 fail on old system which doesn't support MADV_COLLAPSE. It
   might be fixed later.
2) The _supported_fs is removed totally, please use _exclude_fs if you need
   to skip a test for a fs.

More bug fixes or updates refer to below, thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

d1adf462e4b2 check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE

New commits:

Christoph Hellwig (6):
      [329e47e375fb] xfs/541: _notrun if the file system can't mount
      [d2f055fd91a2] generic/363: remove _supported_fs xfs
      [1f193e75d3f1] common: remove the $FSYP check in _cleanup_dump
      [9d6ea111e5b9] replace _supported_fs with _exclude_fs
      [1246241aa954] generic/418: use min_dio_alignment
      [a4163647375c] common: skip tests using LVM when the device is no known

Eric Sandeen (1):
      [3fa459d162c9] fix vfs/utils.c for big-endian systems

Filipe Manana (1):
      [fa47c4d8affa] generic: test swap activation on file that used to have clones

Joanne Koong (2):
      [40150a936449] fsx: support reads/writes from buffers backed by hugepages
      [627289232371] generic: add tests for read/writes from hugepages-backed buffers

Nirjhar Roy (IBM) (1):
      [d1adf462e4b2] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE

Shin'ichiro Kawasaki (1):
      [a7d82369dcae] fsx: fix compile error for preadv2()

Theodore Ts'o (1):
      [6bf32d1a46d4] xfs/032: fix test failure on kernels which don't support bs > ps


Code Diffstat:

 check                 |  12 +---
 common/dump           |   6 --
 common/rc             |  43 +++++++------
 ltp/fsx.c             | 167 ++++++++++++++++++++++++++++++++++++++++++++++----
 src/vfs/utils.c       |   6 +-
 tests/ext4/001        |   4 +-
 tests/ext4/002        |   2 +-
 tests/ext4/003        |   3 +-
 tests/ext4/004        |   3 +-
 tests/ext4/005        |   4 +-
 tests/ext4/006        |   3 +-
 tests/ext4/007        |   3 +-
 tests/ext4/008        |   3 +-
 tests/ext4/009        |   3 +-
 tests/ext4/010        |   3 +-
 tests/ext4/011        |   3 +-
 tests/ext4/012        |   3 +-
 tests/ext4/013        |   3 +-
 tests/ext4/014        |   3 +-
 tests/ext4/015        |   3 +-
 tests/ext4/016        |   3 +-
 tests/ext4/017        |   3 +-
 tests/ext4/018        |   3 +-
 tests/ext4/019        |   3 +-
 tests/ext4/020        |   4 +-
 tests/ext4/021        |   4 +-
 tests/ext4/022        |   4 +-
 tests/ext4/023        |   4 +-
 tests/ext4/024        |   4 +-
 tests/ext4/025        |   4 +-
 tests/ext4/026        |   4 +-
 tests/ext4/027        |   4 +-
 tests/ext4/028        |   4 +-
 tests/ext4/029        |   4 +-
 tests/ext4/030        |   4 +-
 tests/ext4/031        |   4 +-
 tests/ext4/032        |   3 +-
 tests/ext4/033        |   4 +-
 tests/ext4/034        |   3 +-
 tests/ext4/035        |   3 +-
 tests/ext4/036        |   3 +-
 tests/ext4/037        |   2 +-
 tests/ext4/038        |   3 +-
 tests/ext4/039        |   3 +-
 tests/ext4/040        |   1 -
 tests/ext4/041        |   1 -
 tests/ext4/042        |   3 -
 tests/ext4/043        |   2 +-
 tests/ext4/044        |   4 +-
 tests/ext4/045        |   3 +-
 tests/ext4/046        |   3 +-
 tests/ext4/047        |   4 +-
 tests/ext4/048        |   3 +-
 tests/ext4/049        |   3 +-
 tests/ext4/050        |   3 +-
 tests/ext4/051        |   3 +-
 tests/ext4/052        |   3 +-
 tests/ext4/053        |   1 -
 tests/ext4/054        |   4 +-
 tests/ext4/055        |   4 +-
 tests/ext4/056        |   4 +-
 tests/ext4/057        |   4 +-
 tests/ext4/058        |   4 +-
 tests/ext4/059        |   4 +-
 tests/ext4/060        |   4 +-
 tests/ext4/271        |   4 +-
 tests/ext4/301        |   4 +-
 tests/ext4/302        |   4 +-
 tests/ext4/303        |   4 +-
 tests/ext4/304        |   4 +-
 tests/ext4/305        |   3 +-
 tests/ext4/306        |   3 +-
 tests/ext4/307        |   4 +-
 tests/generic/081     |   6 +-
 tests/generic/108     |   6 +-
 tests/generic/187     |   8 ++-
 tests/generic/294     |   2 +-
 tests/generic/357     |   2 +-
 tests/generic/362     |   3 +-
 tests/generic/363     |   3 -
 tests/generic/370     | 109 ++++++++++++++++++++++++++++++++
 tests/generic/370.out |  25 ++++++++
 tests/generic/418     |   2 +-
 tests/generic/459     |   6 +-
 tests/generic/465     |   2 +-
 tests/generic/500     |   2 +-
 tests/generic/631     |   4 +-
 tests/generic/679     |   2 +-
 tests/generic/699     |   3 +-
 tests/generic/732     |   4 +-
 tests/generic/740     |   7 ++-
 tests/generic/759     |  22 +++++++
 tests/generic/759.out |   4 ++
 tests/generic/760     |  26 ++++++++
 tests/generic/760.out |   4 ++
 tests/xfs/032         |   2 +-
 tests/xfs/541         |   2 +-
 97 files changed, 570 insertions(+), 145 deletions(-)
--
Zorro Lang
zlang@kernel.org

--2vdJqhqsSB3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmefhTQACgkQlNbPkfr2
tMw3+A/9GTGJV8YvJM2y9Yv9mFOOoJm8Hy8p4A/K4AY0sGfvr49jkEUjV+aPhWpT
G/RrEYL0GgEifM9n95NnQGGF2PNYhjgyABAMmHc/jofzOevpILks7Tz93SkfKMT0
0i9AlLcan2oit6+oVhJt+nKb0keTUBcb4eLSF8oUVaaAe9VWY4zFwi2/fp0a9bIP
Tc1afBymHlC+t0/U4kftXfrly/kZ2wzGsdMgS1vDMuiJEcMf1PwDVo2tKTg6s8nC
pHkKODDiR20KEF9bQEFayNtEnzfQuKaGM2/LU63CORbUGAc+tr+NoxhCBNNkfQoH
fz4vqeio6x6RWxTJp1j0d0NGIiZUhotugwPlPJKan26Pg3fzE4Di31MnsJEPf12r
5cO5WoNTW2v31vRwZuCcYlTEs9X8Etbnd8XFehwVe8Vm0aHT+0PC8Gz2eawMlKdu
2snGqkYOzcf1lrGoY4hx04R9PUlHuZHq87SQaBHBUhHsdpWXrTAE22b2JaglqY9Y
hPYfgQAWBh+RFC5GNnVNMhIE6tr09lgAxYidLg+tTSARi5XNSK9nKlZBj5BuSVKF
/halO/jYiyyPQQsZtRamLp/WOqKQJZsxVE5gRVktkx+Mm7ZO7Pss2CknoUY29kSh
1ZAszYdC1RyWTvfK3dsx6Gb7IqPIZu/TlzqU3CY9rH5JuEPr3sk=
=Syyj
-----END PGP SIGNATURE-----

--2vdJqhqsSB3v--
