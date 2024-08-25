Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306261E492
	for <fstests@vger.kernel.org>; Sun, 25 Aug 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724592367; cv=none; b=vFyK63Icbw1PkDkOe1cvhbapAoLC6HFY3Hv8gQSotGhsyfY7OdkCsjNaWO++SUT0L2Bh1N4P7bJ8NY+r/tfI334cJ4Ik5WwEjDrxgF4OIi6Kcc2R1e7/wtxsypgcRMnZBj4Cf7iA8FZBIiCUcX3V9nSsPA7URjqqsHBB37M8nQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724592367; c=relaxed/simple;
	bh=vUd+HegS7YZe5Mxgr68NUh5Y8M/eORK6v4JDKK/uv5M=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=na+cvZgKB6Oc/m4T/ofWL+v/btmNnS4Yq7KPQNbBqzWJ1KbKjIWC49BrFw5xaafLPxmkwyz4WSG4/sNim7OyamCpvevCmzYf7NAjzmpBPMJJeXSopjPjEVn8aoJzJ8LySDIGNzQCuBz5+U/yoB9ir4Yb6lbW51EYbiGJqgcxICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcxcna6n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcxcna6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E352C32782;
	Sun, 25 Aug 2024 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724592366;
	bh=vUd+HegS7YZe5Mxgr68NUh5Y8M/eORK6v4JDKK/uv5M=;
	h=Date:From:To:Subject:From;
	b=Dcxcna6nePGwo0IprhtHqFrXgjbEorhaM8E7ZjEN9qDL+hhlyvdRomWxkewC2/0gl
	 AGMxhl7avdU/bgXFYDr6Z0zhjg6L5rOL670fj6wZ6mz5wF80qjZpaGKtQFcPXwnsad
	 afPMy9RZb4hZnJY0332kvXZ1VgxJI/r5bqYwnd/sv35aWnXI2QmKpMKSYr/+o+qp1l
	 vy7cotf3/GAryW9n3iBbEBEowf9Qt2/o+DwUfdx9oGUBm2ATX8l2xRBIjXOSpDk27X
	 Nr5fARLs+FmzPefRv1Lz4B3/BrGSsduBx9RfruySau8fHyk6+ENQUJOg+kkS4Dwjea
	 df7ji9gL6Bk0Q==
Date: Sun, 25 Aug 2024 21:26:03 +0800
Message-ID: <33252d05e104ddda106d576c6dd72ed9@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.08.25
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k8lIGax9oHrp"
Content-Disposition: inline


--k8lIGax9oHrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.08.25 release.

Release Notes:
1) There're 3 new test cases -- b/319, g/755 and x/608. They're all regression
   test cases. Failed on old kernel, but won't cause crash or hang.
2) A new program src/min_dio_alignment helps to the minimum DIO alignment
   by using statx stx_dio_offset_align field.
3) Fix a small tmpfs test regression.

More updates and fixes refer to below, thanks for all your contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

b14652801e2e generic/615: add to the quick group

New commits ([N]ew, [U]pdate):

André Almeida (1):
[U]      [5381898ebaef] common/config: Correctly ignore {TEST|SCRATCH}_DEV for tmpfs

Christoph Hellwig (6):
[U]      [873e36c9c3cc] statx.h: update to latest kernel UAPI
[N]      [0e5f196d0a6a] add a new min_dio_alignment helper
[U]      [4a571eaae784] xfs/424: don't use _min_dio_alignment
[U]      [515e61fdc791] generic: don't use _min_dio_alignment without a device argument
[U]      [ee799a0cf1d4] replace _min_dio_alignment with calls to src/min_dio_alignment
[U]      [b14652801e2e] generic/615: add to the quick group

Darrick J. Wong (1):
[N]      [d77a99817574] xfs: add a test for v1 inodes with nonzero nlink and onlink fields

Filipe Manana (1):
[N]      [e4030c9b6b00] btrfs: test send clones extents with unaligned end offset ending at i_size

Jeff Layton (1):
[N]      [a49385587950] generic/755: test that inode's ctime is updated on unlink

Ma Xinjian (1):
[U]      [1a7f5bbcdd51] xfs/348: add helper tags


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

--k8lIGax9oHrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmbLMM4ACgkQlNbPkfr2
tMx2DBAAnOnWOivianWQmvJfck906NGS1pPQXyoIaALj6f5K2NhkCGiBYHtifFD7
asfT6P0oo91JZAZge3sJ9hTlDN0RrzyS+I2kxMmUE9URL5m3cdEWg2BcEMIcC1HH
ccxGlZNhRZsiY3rv6o/vy5hNgZFKidzllOcAwSzWSu88VBbirndwG35j62NCPZpe
bUPisji3zVy4BDb61i1KZ8oodBZdCTNwlU8PgwlSck6jfUPSimlfrZkza7ktEGMA
fFNsasnaqnvWPRZt+so+93TXJpq+T/N13G8b79eLkpel3hQeEX9MODSW6S5NDx0K
HyDJKZDY5+SO22tB68ByfOkP92CiM/iVFyN0BpaysEpPfRAtFMJM09cJ70WQvIRP
iR9m3A3DMQ/US1GTAcwo2+CZ75RAI6xNG5QKqQFJeGM56mqusCyjw57JXewD/zpd
BKy/eketwMn1prB24K5jJ2CEQaBv1nAd4szFoQAMB4l17zTK67byX2blIEKJAdbL
kX2WEdg+NQ4DmvVTjuWWKdfPtlmdX8iLUcX+76ehrjk5J93D1i21TSPmL1QDIhNa
+fbKB/aFFGlwLhRDcEEO2oAoECKSh1TpWaJeH0fpdWRMBZZYsTClzwNa+2MNr1KJ
uHnT29XARBsanyFSAynWSkWocDSkHnYlu9YjFCETEpRzCr45nb4=
=u1Og
-----END PGP SIGNATURE-----

--k8lIGax9oHrp--
