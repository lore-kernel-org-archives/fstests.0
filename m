Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CB101D9
	for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6cTUa0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40D3C433C8;
	Sun, 19 Nov 2023 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700401365;
	bh=NQRp1WeZiR7SJkWWk75kXAwp2rHHB7y3SB7FMlBVOA0=;
	h=Date:From:To:Subject:From;
	b=W6cTUa0JsfL2oiVlvhM/yMs6TYEMp7MXbb/PY1lFzV3MhThxE+MO5c3XaRcD9YpAm
	 Vl1nvVB3GgFkWugWdgNfdMtCFBJQqnbtftoo9m8PDEsp4I/x8AD4ncHuSI8AFmxo9L
	 qG2MF4vABqelE+bI4WA5Do79uFzgEXL2m7YIr2GMb8Q0YRb1cbJpnXUXvEP58N523X
	 ibej3RRIjqkE+qucH4p5XQly6NbS7wUOFUSZGVqAWAs1Zm93IylGgL0JKxW255gkPA
	 T4OAZ91qMOP7WunN4aTDe8o4X9Yt/A9rNhivTDcbkil8X5DALLQ3ljHpuoSpFUL0vJ
	 bYrKozVQwgOig==
Date: Sun, 19 Nov 2023 21:42:41 +0800
Message-ID: <5fbaeebad0ffc8fc6944b35631ebc117.Zorro Lang <zlang@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.10.29 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KRw6TZXJf1o0"
Content-Disposition: inline


--KRw6TZXJf1o0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.10.29 version.

Thanks,
Zorro

The new head of the master branch is commit:

119146147847 fstests: generic/353 should accomodate other pwrite behaviors

New commits:

Amir Goldstein (1):
      [30fc8ed13aa2] overlay: add test for lowerdir mount option parsing

Bill O'Donnell (1):
      [119146147847] fstests: generic/353 should accomodate other pwrite behaviors

Christoph Hellwig (2):
      [78469c97a208] xfs/556: call _require_dm_target later
      [053719c18877] xfs: add missing _require_scratch calls

Darrick J. Wong (6):
      [cdd662862926] xfs/178: don't fail when SCRATCH_DEV contains random xfs superblocks
      [ba2905da44e7] generic/465: only complain about stale disk contents when racing directio
      [bbeaf7d1cbf2] generic/269,xfs/051: don't drop fsstress failures to stdout
      [39f88c553cb6] generic: test FALLOC_FL_UNSHARE when pagecache is not loaded
      [949b7ac96e56] generic/251: don't snapshot $here during a test
      [95b0db739400] generic/251: check min and max length and minlen for FSTRIM

Filipe Manana (2):
      [6409d61958c5] btrfs/298: fix failure when added device supports trim
      [6b4920afad0f] btrfs: test snapshotting a subvolume that was just created

Su Yue (1):
      [d9323ad7a05e] generic/245: Filter mv error message


Code Diffstat:

 .../aio-dio-append-write-read-race.c               |  2 +-
 tests/btrfs/298                                    |  2 +-
 tests/btrfs/302                                    | 61 +++++++++++++++
 tests/btrfs/302.out                                |  4 +
 tests/generic/245                                  |  5 +-
 tests/generic/245.out                              |  2 +-
 tests/generic/251                                  | 67 ++++++++++++++---
 tests/generic/269                                  |  2 +-
 tests/generic/353                                  | 29 ++++----
 tests/generic/353.out                              | 15 +---
 tests/overlay/083                                  | 76 +++++++++++++++++++
 tests/overlay/083.out                              |  2 +
 tests/xfs/051                                      |  2 +-
 tests/xfs/178                                      |  9 ++-
 tests/xfs/178.out                                  |  2 -
 tests/xfs/184                                      |  1 +
 tests/xfs/192                                      |  1 +
 tests/xfs/200                                      |  1 +
 tests/xfs/204                                      |  1 +
 tests/xfs/232                                      |  1 +
 tests/xfs/556                                      |  2 +-
 tests/xfs/601                                      | 87 ++++++++++++++++++++++
 tests/xfs/601.out                                  |  4 +
 23 files changed, 332 insertions(+), 46 deletions(-)
--
Zorro Lang
zlang@kernel.org

--KRw6TZXJf1o0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmVaEK4ACgkQlNbPkfr2
tMzb6xAAsJhCfyHL3wCUbqrkLJ+qzUwfl3VfBpVzLjuXzeePiKiFjoiW4d6KiOGt
hX641iydlhFzi3M6dLmsohAI3mwAO24xvyNOQBosUwVaMdnvEphv4TIgr9pSYP5R
udkQon+LZspVkBU5DbbgVTPyDDTNtUkm4Pxi90qDcNQ8v9xM0cCfHcoXRJX9+JNH
5+i6aC205/JIYUaLL9Z4apxgQp3zax9XT4bAvhgtx/c+ejY52SUNSecBCrYA+fYY
NWBJdYRH8LrFtdQ0G7B0fRKZ4kz1NqGc2fmpzTZ6VrorVaAnLVVjQMwHVNWUKffV
za1a0wREKAVh5lEX21JpaiNwT3+xUwrxYgqSPnFlB9pT52jSPLPZuGMuKnEoQjdT
0gMnUsufxAghGY+LNksM1tJr3eKsGctwum02Iq83buVOL8/uRf/NX1MPCHMM7Utr
+redsHOvFTNCFMmoUfUE2X1gclU0DRhtt4rYxrXnfd1bhmtNt4J5rjbxR2CWDg74
fiXPt3PbL9/gS2A8IFrIrWLlsH+SCrmmMIGx4GByYvBGz2Ev63UPsslkctFluUU6
zLnqFTDuNGgoztaRT/DI047tT6IRgIIo8/vfmbuYxsXrJ2gTiAGE79ez+FVPNHhH
fT9wqcxJMjpk3wdVkKOPIVOnC3m+xCaBF9bUQiGhTYbXSStfWH0=
=u0cK
-----END PGP SIGNATURE-----

--KRw6TZXJf1o0--
