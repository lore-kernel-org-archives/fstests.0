Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942017BB0C
	for <fstests@vger.kernel.org>; Sun, 29 Sep 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727617054; cv=none; b=GQHD1f2D6WuD3ZGkTvpmdHHpd7iVQmIXKPmU1ge3KZv2e/tSC874M55wZ+354sPLeyO6au2cvZCZJJa7pZr1YNbDzucV9UV8QQdqAEwX9ZWmBdaiQ+e5FD/8toF+7CxUpABCeBRpC0H+7YqlKg0xRBAHjswHNXFbdi7Nii9eWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727617054; c=relaxed/simple;
	bh=DHctoUP+bKs/JBfNf4KMaMtmZ+LdkxDuzfjAGLImL0s=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Ds2PgdgqhoVuPKZuGQ/W4QM36UfjBTpGrfPv/xxlESUcG6ZfaooDo8Nn3iU/00ni5AO+pIxcsX5SMR7GOh2ihGAFnmRpRhJOBw/lDGlUS20wCrtbH5rEWo6OCn0Kj/5P+LW25kbUVM8+z1F8oocV1Ed6u23tB6/YEoOR+530WDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+aCohnP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+aCohnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E26C4CEC6;
	Sun, 29 Sep 2024 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727617054;
	bh=DHctoUP+bKs/JBfNf4KMaMtmZ+LdkxDuzfjAGLImL0s=;
	h=Date:From:To:Subject:From;
	b=E+aCohnPL6wRivoExL1TeV7PQg7YVAY/RwK2YDpfvwnPzRy1/kP2eUgRyoHsO5qGu
	 WDGfRaWCOtDu6P+7IcNm/ajZou8aKUhEb4twqKklnBgi5o5oOSnhLBoXUYBK+u0AcT
	 oY9LxL27h6ycQDUJyPtdnS53Ky4nT193mjQiZEECJVBDZX7bALvDHCA2BZr0kxPOCt
	 VrmV4mJeDeD+KZtqHTqHeeMtTy36wkF5KPUAraiUWs6GPY8LuuyunsOpsyfEsIa8vq
	 v9n5FBZ4WrUAJ29LoC3nT3DmlQC6VXyMb3zcEqcLQ0Z8Xq+wFtfDXddV6tQhjYkMaA
	 MDkVhk1XgYFgA==
Date: Sun, 29 Sep 2024 21:37:31 +0800
Message-ID: <f4d2a1fe4625b4f62ab5f8b01f55e12a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.09.29
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pElkqSY9MYPx"
Content-Disposition: inline


--pElkqSY9MYPx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.09.29 release.

Release Notes:
1) There're 8 new test cases in this release, include btrfs/322, ext4/060
   generic/365, xfs/629~632 and overlay/087.
2) The fsx.c is enhanced, it supports unshare range fallocate mode test. If
   you hit new failure on fsx test, please think about this change.

More details refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

790f4d8444fa xfs: new EOF fragmentation tests

New commits ([N]ew, [U]pdate):

Amir Goldstein (1):
[N]      [d6433d8c8402] overlay: create a variant to syncfs error test xfs/546

Brian Foster (1):
[U]      [34ce77ce867d] fsx: support unshare range fallocate mode

Darrick J. Wong (1):
[N]      [c3140a6b8794] generic: add a regression test for sub-block fsmap queries

Dave Chinner (1):
[N]      [790f4d8444fa] xfs: new EOF fragmentation tests

Filipe Manana (4):
[U]      [9b41da945b20] fstests: add missing kernel git commit IDs to some tests
[U]      [185d797c73e1] fstests: fix min_dio_alignment logic for getting device block size
[U]      [10e6c6772b3d] btrfs/321: make the test work when compression is enabled
[N]      [d26d32028a78] btrfs: test an incremental send scenario with cloning of unaligned extent

Srivathsa Dara (1):
[N]      [7ba74c6a3c69] ext4: Regression test for corruption during on-line resize


Code Diffstat:

 ltp/fsx.c               |  67 ++++++++++++++++++++++-------
 src/min_dio_alignment.c |   2 +-
 tests/btrfs/321         |  10 +++--
 tests/btrfs/322         | 109 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/322.out     |  24 +++++++++++
 tests/ext4/060          |  45 ++++++++++++++++++++
 tests/ext4/060.out      |   2 +
 tests/generic/364       |   2 +-
 tests/generic/365       |  79 +++++++++++++++++++++++++++++++++++
 tests/generic/365.out   |  15 +++++++
 tests/overlay/087       |  62 +++++++++++++++++++++++++++
 tests/overlay/087.out   |   4 ++
 tests/xfs/608           |   2 +-
 tests/xfs/629           |  67 +++++++++++++++++++++++++++++
 tests/xfs/629.out       |   9 ++++
 tests/xfs/630           |  70 +++++++++++++++++++++++++++++++
 tests/xfs/630.out       |   9 ++++
 tests/xfs/631           |  70 +++++++++++++++++++++++++++++++
 tests/xfs/631.out       |   9 ++++
 tests/xfs/632           |  78 ++++++++++++++++++++++++++++++++++
 tests/xfs/632.out       |  33 +++++++++++++++
 21 files changed, 745 insertions(+), 23 deletions(-)
--
Zorro Lang
zlang@kernel.org

--pElkqSY9MYPx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmb5V/sACgkQlNbPkfr2
tMzK/Q/8CDOqdyUjCTMuxlOew667m04ugDqpsMv6hb7dYZDhqFgh0WR5GSEwbOSt
UaCZLmQHGmS44tPvk3X12nIW4Pil1HRUi08Lcw66bof8FkIAzu+u5iQGiraPtNvT
9wCYqLy5/kCdg9RWM0t71oc0wcXFuHjoQGFM73fSqc60dCYcoyJRivme8b6JwC1C
tmGToCi2ZktZgbgfFBN9m1DvIpwSxNkMxgnaAJKSUPSSXwRRByyb7TtOhMdJWBA+
MU7GWU8AcndOSa/QtQneRG8ADgu1yXGkPB0Zaz/BWQK1uerCFwOFbgtB6+utybB0
bw/DhZ0VkDkmGNIR6rfddECQxtYwA6oxKxN5IN2s1xXM/sUTvotsHbvARCrr7kl4
q+/IjnMM8XxeGO6BKcS4bKEhwFB4FGJP5QWz2fGoOs22DnWK7Q+8oXfKF5lS9D7k
c9n/DHc4VA55q608qMbCSViO6bf2rjyaCU1s3NB/uJEMKBO54p/9RCRUqN/caYTT
GFo7nV6PRPfwj+7yvfnxxzj9ejGpxl1R0g8ZrSK2OjSdbF7/9pQtMDNF/3pxZ1Hy
kls016eFj3kw2nrIfFXktTvcAMg4hJHv7Ty48K3Y9Dofda8gc9JIw6zLN1zGG/Zi
2p8//mMyYWnTVryNgK3Qq/vHVZkxjlApfGltVZdkt9RWLG+AOvA=
=uRQv
-----END PGP SIGNATURE-----

--pElkqSY9MYPx--
