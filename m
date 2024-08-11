Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F4441F
	for <fstests@vger.kernel.org>; Sun, 11 Aug 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723380541; cv=none; b=eCdpeeAhruQ2R3VEtnR4jtsbf8vCOjXm/bVsbN1YIZU3D0LA/0P8e+FcpXhkgkzjQ+zaGPOLDHjk0FO40uMX1X/8CR1x2y8ZrcXGsR2vWJNAO3jh1e2hMtM2lUQnB+/hOYWF3uc59P6SuFtfuW6S17dVTQrbnC80eIe/vBWAo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723380541; c=relaxed/simple;
	bh=ifYTVGq+FeBimXgky+81GniosemTjrGqYhFxYSxFGfw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Ag7VRkC7ibYJOQORa5HPWiUWsDdJJtUKIRDcrtlhWhAshUC2JiO/oXEXhh27Jm/fpAsKiNONxM8K716PBhMW6KRhxmqDgn2AHe549msWfVlyxo6wbAfoYeDg5y+HIa0rzP9bjOzFudWq3ngQSCb8xOk4E1OYMln9PWc1MmWCA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leq2MHOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leq2MHOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2495C32786;
	Sun, 11 Aug 2024 12:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723380541;
	bh=ifYTVGq+FeBimXgky+81GniosemTjrGqYhFxYSxFGfw=;
	h=Date:From:To:Subject:From;
	b=leq2MHOdvT283XE4P1ja8niF6fOw7YuuXXkfTWsIa0ZG7iDXV5O3EIX7RlY50QU9F
	 i/xPDWCA4sBb7k8wIS2Z1gFrZAUce/Pqsgtd302ae6A51sG0GahVFXTDzLRQ3hcoII
	 6vHYoJS3wVVBH8MXZJQPHoVwNcDHJlWMPiUsN5mU2++BL2vXJaS5QcALJxxRuHbnYj
	 nUStGJuisNuTTYXDCko8/PwkIgkD8tJqnJ6duemjyzHvxelX/JlhvdmGPM7a1jKwmO
	 piXPes2xdaSBuWVT0HVzbFRSlorD/xrUt5GxbhdPQ1lRPm42/zMaiMB6vNXSHqQyXZ
	 +TUURrLtzeyug==
Date: Sun, 11 Aug 2024 20:48:58 +0800
Message-ID: <ed27a1c046c045a9273a5e2ccbabe1b9@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.08.11
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0A4GL7fAWak"
Content-Disposition: inline


--f0A4GL7fAWak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.08.11 release.

Release Notes:
1) There're 3 new test cases in this release --- generic/362,
   btrfs/332 and xfs/801.
2) _scratch_mkfs_xfs and _scratch_mkfs_sized behaviors changed,
   they'll _notrun if failed.
3) xfs_check has been removed totally.

More updates and fixes refer to below, thanks for all these
contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--f0A4GL7fAWak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAma4sxsACgkQlNbPkfr2
tMw0LhAAn8bRKO0GyXUCSVT7j1djOozR8TYJfDzQn9B5jhUSMrfMXckXRjPWAC8M
OZR7L4U+naneGwXNHQhlrRUN7GGiwQnVwRjs+l7Q+YN0l/cpUvUtkVxkkVtx3E8j
LFvabUa06HNoG3ePTyJnb2xve3mrPijBBLQD6VUso3ppeEWEB+OZHFGvqa1ZBNDC
BWLlaqjjZxYM/nIoEx0xRt6eluffYGMB2z2TNm9b57Fm3g4uU9mxvoUt9zHLtw6/
uZLHZiJrODv1D4Hx5pvPpDBVeTGKm5YeUNitBE25pcHKlNB3lil+Pv0DGgPDC8wo
AO/OFomQeQC5E2goO9HUlY8kJASAoZkg4x8TRMpk0OV+8zPhv3w7YiydXFEDAQKy
2gWVjgjg2G+QWQMwqtbFwG2EeLoxCfyRqm2mWk1rwQONmbE3bn7G+9yrvpFjiUr0
YG/on5j4k5AJdRJYUCiFzdK2nnKHQfo/znQIN5jaIgY4j75yPDB9dui1DJBLbH6j
7cye6moZ9db46BR21eZ5w8aJ+DBaFyPrv2gdRYbzTHExQHNX1SWtqIgr0ozt3cur
6dc7FzqhgjbyV4b1B6YeMHwg5hoqsNz8vQ+b8Yaje8yq8re+jEkMiskNbEJBeDDz
LmawpqqgYXCCCSzfY2SI3loJm+PAldYoADARqjH6pbzboNuD/Go=
=1NHi
-----END PGP SIGNATURE-----

--f0A4GL7fAWak--
