Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB429CEF
	for <fstests@vger.kernel.org>; Sun, 25 Aug 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724591503; cv=none; b=nNM1IKzPYPi941nVJ1jc57blAqNYem9HJOtaCgqLWYsfZiqcNzrMTTxREV0Vg4ajcSM7mYLMm3J2hmGzO7UFDW4tKjFHyyJ+LCqYStMHr932HaH6J+ERNhRzFlf5iy2ndDfzgr6NEHAOx0HoYHzLr3VLv/LbP6JVIDS3B5VtkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724591503; c=relaxed/simple;
	bh=gzrS1mJI1/tstkwVe12kRFrOtLiFJqeg/wZiTEwJqJg=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ZAt68KG5LiNJBsYhTFyYdWVJOffMIr847EW4Olq7J5vGaUxfSOH4QDoaR9tO3q7JHWgCmGjb/7J3CZ/O+v+s+QmBzD0RyXtOP8WsyfmtjktDbGRS9ItfyR4A9O9ztis/7DAa35Too89Z3R0nESvmSmsrhYZDuBOh+QvHB7QtF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+b+Akcd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+b+Akcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1085DC32782;
	Sun, 25 Aug 2024 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724591503;
	bh=gzrS1mJI1/tstkwVe12kRFrOtLiFJqeg/wZiTEwJqJg=;
	h=Date:From:To:Subject:From;
	b=p+b+AkcdOqF6Yqju4Mtnjms6FWUfZ25+z1y9U0NCOv12wvzOPt/8nfmDwZuNyNTMk
	 voezwR70zLaPyVGo2KbY89bgM6OAYOQ7tMbQGFTPHO9gZHoJSHQVzqwmEHGr/aqAeY
	 OGZoj8+mnxFB2zbb+oRttHmQRDZZh5DmOnhln5sM2OLlbTxf6c/prznLYEZGgAccZb
	 /x4NT8INmjrVoNT7Qs94uAe3rKH4pFMjqjGzkA3qGsHsdLgPc29nZjkTXGPcY+TEq5
	 CX7yyv4so2G+wLhErs27QfrDiYvAvu8fbC5ziGt3wk6TMtQ/nlbXaY0cBHI1d3XGkO
	 /X5OA2WbVbapg==
Date: Sun, 25 Aug 2024 21:11:40 +0800
Message-ID: <338a89763b1c987bda43ccb92d0f2811@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.08.11 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4B7ETsp1ogxs"
Content-Disposition: inline


--4B7ETsp1ogxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.08.11 version.

Thanks,
Zorro

The new head of the master branch is commit:

d9423fec7293 xfs/516: use _scratch_mkfs_xfs

New commits:

Boris Burkov (1):
      [7e21e6a40c2a] btrfs: add test for btrfstune squota enable/disable

Christoph Hellwig (6):
      [f30ec93e2dba] add more tests to the growfs group
      [6bff79ece871] xfs/233: don't require rmap
      [8b8f3868f30f] common: _notrun if _scratch_mkfs_sized failed
      [98624c9a2cc1] common: _notrun if _scratch_mkfs_xfs failed
      [e8b62c703c93] xfs/432: use _scratch_mkfs_xfs
      [d9423fec7293] xfs/516: use _scratch_mkfs_xfs

Darrick J. Wong (2):
      [ce857227fb0a] xfs: remove all traces of xfs_check
      [518896a7b483] xfs: test online repair when xfiles consists of THPs

Filipe Manana (5):
      [bd6eec9ad858] generic: test page fault during direct IO write with O_APPEND
      [bc6988106a32] generic/019: redirect fsstress output to log file instead
      [4e9a16bd7dd1] fstests: remove unnecessary stdout/stderr redirection for run_check calls
      [72bac4e8a42e] btrfs/312: add git commit ID
      [84ac13724ed5] btrfs/287: wait for subvolume deletion to complete

Yang Erkun (2):
      [52a36bfba58b] generic/732: remove unused code
      [50da3fd9f044] generic/732: don't run it on tmpfs


Code Diffstat:

 .gitignore                 |   1 +
 README                     |   6 +-
 common/attr                |   4 +-
 common/filestreams         |   2 +-
 common/fuzzy               |  11 ----
 common/log                 |   4 +-
 common/rc                  |  11 ++--
 common/xfs                 |  97 +++++++-----------------------
 crash/xfscrash             |  18 ------
 src/Makefile               |   2 +-
 src/dio-append-buf-fault.c | 145 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/004            |   4 +-
 tests/btrfs/030            |   4 +-
 tests/btrfs/038            |   6 +-
 tests/btrfs/039            |   4 +-
 tests/btrfs/040            |   4 +-
 tests/btrfs/057            |   6 +-
 tests/btrfs/284            |   2 +-
 tests/btrfs/287            |  21 +++++++
 tests/btrfs/312            |   2 +-
 tests/btrfs/332            |  66 +++++++++++++++++++++
 tests/btrfs/332.out        |   2 +
 tests/generic/019          |   2 +-
 tests/generic/083          |   3 +-
 tests/generic/362          |  28 +++++++++
 tests/generic/362.out      |   2 +
 tests/generic/482          |   2 +-
 tests/generic/732          |  10 ++--
 tests/xfs/002              |   2 +-
 tests/xfs/004              |   2 +-
 tests/xfs/005              |   2 +-
 tests/xfs/009              |   2 +-
 tests/xfs/017              |   9 ++-
 tests/xfs/019              |   3 +-
 tests/xfs/021              |   3 +-
 tests/xfs/022              |   2 +-
 tests/xfs/023              |   2 +-
 tests/xfs/024              |   2 +-
 tests/xfs/025              |   2 +-
 tests/xfs/026              |   2 +-
 tests/xfs/027              |   2 +-
 tests/xfs/028              |   2 +-
 tests/xfs/030              |   2 +-
 tests/xfs/034              |   3 +-
 tests/xfs/035              |   2 +-
 tests/xfs/036              |   2 +-
 tests/xfs/037              |   2 +-
 tests/xfs/038              |   2 +-
 tests/xfs/039              |   2 +-
 tests/xfs/041              |   2 +-
 tests/xfs/042              |   2 +-
 tests/xfs/043              |   2 +-
 tests/xfs/044              |   2 +-
 tests/xfs/045              |   2 +-
 tests/xfs/046              |   2 +-
 tests/xfs/047              |   2 +-
 tests/xfs/055              |   2 +-
 tests/xfs/056              |   2 +-
 tests/xfs/059              |   2 +-
 tests/xfs/060              |   2 +-
 tests/xfs/061              |   2 +-
 tests/xfs/063              |   2 +-
 tests/xfs/064              |   2 +-
 tests/xfs/066              |   2 +-
 tests/xfs/068              |   2 +-
 tests/xfs/070              |   1 -
 tests/xfs/072              |   2 +-
 tests/xfs/077              |   2 +-
 tests/xfs/090              |   2 +-
 tests/xfs/094              |   2 +-
 tests/xfs/103              |   2 +-
 tests/xfs/114              |   2 +-
 tests/xfs/121              |   3 +-
 tests/xfs/127              |   2 +-
 tests/xfs/153              |   2 +-
 tests/xfs/168              |   4 +-
 tests/xfs/178              |   6 +-
 tests/xfs/181              |   3 +-
 tests/xfs/183              |   3 +-
 tests/xfs/202              |   3 +-
 tests/xfs/233              |   5 +-
 tests/xfs/244              |   4 +-
 tests/xfs/266              |   2 +-
 tests/xfs/267              |   2 +-
 tests/xfs/268              |   2 +-
 tests/xfs/281              |   2 +-
 tests/xfs/282              |   2 +-
 tests/xfs/283              |   2 +-
 tests/xfs/287              |   3 +-
 tests/xfs/291              |   3 +-
 tests/xfs/296              |   2 +-
 tests/xfs/300              |   3 +-
 tests/xfs/301              |   2 +-
 tests/xfs/302              |   2 +-
 tests/xfs/306              |   3 +-
 tests/xfs/307              |   6 --
 tests/xfs/307.out          |   3 -
 tests/xfs/308              |   3 -
 tests/xfs/308.out          |   1 -
 tests/xfs/310              |   2 -
 tests/xfs/432              |   2 +-
 tests/xfs/445              |   3 +-
 tests/xfs/448              |   1 -
 tests/xfs/516              |   6 +-
 tests/xfs/520              |   2 +-
 tests/xfs/596              |   1 -
 tests/xfs/801              |  76 ++++++++++++++++++++++++
 tests/xfs/801.out          |   2 +
 108 files changed, 478 insertions(+), 261 deletions(-)
--
Zorro Lang
zlang@kernel.org

--4B7ETsp1ogxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmbLLWsACgkQlNbPkfr2
tMzmpg/9EerLqzxwJu75VUGEOsc2s/dt8DO+TuqOd8J9ogHy3E0QJjOCzFCVf0i6
UbGo1plCnIzsdlYzA0riH4A7j9alKuTEGguOAgpJ1CzzvH1mY7umKWVY5ApzOeO7
4/vaxJyRE3J/AZi7Z0GI3QCaVHsQiTa9DOUEzlZiyFECoz3GaibS8kBH+St1Y49+
iynhruK+H99i5VHKI+JPcWtvSj4pnay9Ci7gXhK4L14UXeDTDpAEaelt3ZAyAYAv
WOfnVvNi3xVT21aspGa/4ZawVQgC7oFrRcTW5cGq2aQJOCeyX6J+plcbZy5bEpX3
jLXmclaXt2a4ctkqhDQYyvwcdqI+UFkpRZHnKVUBjKt90LD5BNyPUk9zvTY5yS0G
FSkmQNmAq0mr3z6lU1CiWT5GtfNaQTlv25LC/fYQlRqXa6MezQIhDcaq/4Hdp447
B5lJZnBGU2Fa4xwBLWP9lUpqSYMfYcf+0qdjUcZ8dzdqNAcD3f7d85yUpnnnRwXG
rdYTq4hw6T3f6tpV54xYMmoMgvvlGvrxHCRt5dCGhPVtNwefLnEbfOetg0r65pTk
85TYHBjilP/mRs3Nm/CvFD3mxse4/HPfUBaqgSJEEU0/tmUSQX6/i+voO9n7xhAQ
En3uhV3WfmPYa1Y8R8dBbwJBT8NSxiBfoCSP/lbYkGsdQ8ynqAI=
=BrlQ
-----END PGP SIGNATURE-----

--4B7ETsp1ogxs--
