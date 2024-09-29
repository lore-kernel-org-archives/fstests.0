Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28D748A
	for <fstests@vger.kernel.org>; Sun, 29 Sep 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727616639; cv=none; b=ATh1U+RUsofuiMBK2OAtiLdkWx/aWtdkdKia22xE1cUGrh722dcq6ZIMMFfuCqYbwAGM5xrugGRpwobRBq8KhwHlRAcnM6TpNwfS5EqyiNyfpW9vzizG26ttWONnaaJ5pUlY8Q55q3oGYZanCSXRIm9JOi4+dmASRQrDxvdwtXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727616639; c=relaxed/simple;
	bh=B31dzkxfT515AkAX0379gntMyzendzuPC8XIto8VHew=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=XBPADgsb4j/6QrApvro5fJIz7z0b8e5Q4DWwC5FWkYMAzstofgrS4ENQutqI80c+yTmcHo+1xfvdRFmJS5fFEf47qxP1axgjVn93A9sCGj/7ljl3mhtv/Whq7vIi91+om1jGbQR0hnr9XnDD1wfajXQhAqBTXMCKbP470yDO5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVKTon2Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVKTon2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7FBC4CEC5;
	Sun, 29 Sep 2024 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727616639;
	bh=B31dzkxfT515AkAX0379gntMyzendzuPC8XIto8VHew=;
	h=Date:From:To:Subject:From;
	b=gVKTon2Q0s06Iy6sb7YAgTjzIkI5lt2DqUWXVY1qKeImUjtJvOXxjTm4tTdOD6nSd
	 7tNKM5CidKuzSU+x8RJf9+KG7EH5SaQKq7N/Zk8xba9GLioNFgtnfGc1MPzPb6JzTi
	 KMlu42PHaW0HsvYqqoa4uNyC3AYUM/oyuGazAjxsMc0IRgZhrrGwQ4NS0vN6CGo4Mf
	 ptWKjaxa5t0uJ23p3SaOUA3lg91Yy5dziCuChBtrQAYYqr6gUEbasCi2a0bSPHI6FH
	 CN7JgLbflsOKRP57zInafrbkoRSrMVB0SE/wZiwsJz/SdKsT9VpNE+7ZXGrqBvlCZk
	 7FUG3Q8m6ddpA==
Date: Sun, 29 Sep 2024 21:30:35 +0800
Message-ID: <90b79759d05894e49db05b9c4e1055e6@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.09.08 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i1Cfnq0OXrjD"
Content-Disposition: inline


--i1Cfnq0OXrjD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.09.08 version.

Thanks,
Zorro

The new head of the master branch is commit:

f71228e304b2 btrfs/319: make the test work when compression is used

New commits:

Aleksa Sarai (2):
      [1e207662b3ce] open_by_handle: verify u32 and u64 mount IDs
      [6171b03c92a6] generic/756: test name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) explicitly

Amir Goldstein (1):
      [55158bfc9946] overlay: deprecate test t_truncate_self

Brian Foster (4):
      [bc0c52655c5a] fsx: don't skip file size and buf updates on simulated ops
      [11dbbdff1737] fsx: factor out a file size update helper
      [9e2b0f4c9579] fsx: support eof page pollution for eof zeroing test coverage
      [fea26871799f] generic: test to run fsx eof pollution

Chao Yu (1):
      [c88734099723] f2fs/003: add missing _fixed_by_kernel_commit line

Chen Hanxiao (1):
      [0afb586a7e77] generic/362: skip test on NFS mount

Darrick J. Wong (7):
      [1dbd10d1bbca] generic/453: test confusable name detection with 32-bit unicode codepoints
      [c63a6fe02353] generic/453: check xfs_scrub detection of confusing job offers
      [652692a8e475] xfs: test xfs_scrub services
      [18c331d98c29] xfs/004: fix column extraction code
      [fff4042b60be] xfs: refactor statfs field extraction
      [c9b3c1c392fd] common/xfs: FITRIM now supports realtime volumes
      [87f14ee1f79f] xfs: functional testing for filesystem properties

Filipe Manana (3):
      [a8d61229a949] btrfs/319: add git commit ID
      [136c5099d07e] generic: test concurrent direct IO writes and fsync using same fd
      [f71228e304b2] btrfs/319: make the test work when compression is used

Qu Wenruo (2):
      [869685f2f308] fstests: btrfs/125: do not use raid5 for metadata
      [66a2179efbde] fstests: btrfs: test reading data with a corrupted checksum tree leaf


Code Diffstat:

 .gitignore                    |   2 +-
 common/config                 |   1 +
 common/rc                     |  38 +++++++++
 common/systemd                |  73 +++++++++++++++++
 common/xfs                    |  60 +++++++++++++-
 doc/group-names.txt           |   1 +
 ltp/fsx.c                     | 134 +++++++++++++++++++++++--------
 src/Makefile                  |   4 +-
 src/dio-write-fsync-same-fd.c | 106 +++++++++++++++++++++++++
 src/open_by_handle.c          | 178 ++++++++++++++++++++++++++++++++++--------
 src/t_truncate_self.c         |  26 ------
 tests/btrfs/125               |   2 +-
 tests/btrfs/319               |  21 +++--
 tests/btrfs/319.out           |   4 -
 tests/btrfs/321               |  83 ++++++++++++++++++++
 tests/btrfs/321.out           |   2 +
 tests/f2fs/003                |   3 +
 tests/generic/062             |   4 +
 tests/generic/362             |   2 +
 tests/generic/363             |  23 ++++++
 tests/generic/363.out         |   2 +
 tests/generic/364             |  31 ++++++++
 tests/generic/364.out         |   2 +
 tests/generic/453             | 111 +++++++++++++++++++++++---
 tests/generic/756             |  65 +++++++++++++++
 tests/generic/756.out         |   5 ++
 tests/overlay/013             |  41 ----------
 tests/overlay/013.out         |   2 -
 tests/xfs/004                 |  19 +++--
 tests/xfs/176                 |   4 +-
 tests/xfs/187                 |   6 +-
 tests/xfs/541                 |   6 +-
 tests/xfs/802                 | 140 +++++++++++++++++++++++++++++++++
 tests/xfs/802.out             |   5 ++
 tests/xfs/803                 | 137 ++++++++++++++++++++++++++++++++
 tests/xfs/803.out             |  53 +++++++++++++
 tests/xfs/804                 | 122 +++++++++++++++++++++++++++++
 tests/xfs/804.out             |  46 +++++++++++
 tests/xfs/805                 |  66 ++++++++++++++++
 tests/xfs/805.out             |   9 +++
 tests/xfs/806                 |  63 +++++++++++++++
 tests/xfs/806.out             |   8 ++
 42 files changed, 1532 insertions(+), 178 deletions(-)
--
Zorro Lang
zlang@kernel.org

--i1Cfnq0OXrjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmb5Vl0ACgkQlNbPkfr2
tMz8Aw/7B5ASoZReUee2z5ATH2avH8pFAEJqFMtzcOhCyka/f/+XVYxJ725/Luju
yAeGVJz/NfXb3eqbFkvTCTbh/gmmMEvp1ZTcLso2k5jbfFGbk22OOxUyfyDYrtLY
vyYbSQzsyRb9MYwp8PlEEG02NHNL3x/U4RKEXOLtzB5nqgL6T8drd4k3tnX+91FV
j8XrnsAeMtBtaHrPXgkg65Xq78+T0dDAhwMtdhIufEeWMc2xBnlBgBlXLAlIecah
RZ3AOkTb9A2fwj6wgUylxvXMNoABKlAm3njfANfDEhVmN7IvNoN8HvT1ejSu9d1+
m3rAn0084yPLih/7WvH0ceZ/XcmtL+Q9fvIou1o1BrRAAzxIFU66tAAxr+pApGzF
dQYnYqeP5BqeMdvrV9b4KhTEN39V0jrZTfMrBCcfT1Ua0cG/nbt1fUr516D4yE98
8g6nUZfZPnzVtwzBa+EHDNovoYwYnUTH6XCtTt6F+czvQ/00FvT89sO8QP0oqpVg
gUaDlkOk6o7YMqkmdi4rTPHGN58TP14OUzanVPsBVTHLr9ZktZSbKeZtdMUHrK8+
s3MtFUbmp1F6WhlyHbGEob5Co9UDh/kWVhZfb4XkUNzfZwNrbmiKV2LTyUX8Fg5k
Wnv08v+82XzqoV4a2H+oGHEaXyrIYJQyg23oZY4OKKc+dxfqXpo=
=GrqW
-----END PGP SIGNATURE-----

--i1Cfnq0OXrjD--
