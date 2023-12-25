Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837F524CB
	for <fstests@vger.kernel.org>; Mon, 25 Dec 2023 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0z354aD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CE7C433C8;
	Mon, 25 Dec 2023 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703525761;
	bh=rUCMLG1gkDHorvZ4lFUbdMvS6jjCO5OqlykNW/h88VE=;
	h=Date:From:To:Subject:From;
	b=J0z354aDKyqxdDi65XCU6NHWfO51Ff9ks7Qnn6WgwYQy86eWd19Nq5zAi5KogmZDF
	 uzQLM11WP+bSmUfy3zBmFVCkk8AZ+tpb1N/yYEiXpGd4WNVnaPcCbCAlq5yk/zMhjU
	 N3+hVf3qILzfZM/45s/Fo0mvTQa7kjGET8CEuAUiErkNm8M1jXhd9TAcvIko7X3ktM
	 mYKfaN3zErsZuyUaDZL2oA20y9KKEuLXHN438r9CkhcJUZjQSgkPQ21015YzapWWZc
	 6brz34njn8pFaUdrMQ/5u3l6mjVqgLWB8V+nJP6vrMFnjVW2VmnKb7mb628mr/gQg7
	 dD8CJHSNV8nIg==
Date: Tue, 26 Dec 2023 01:35:58 +0800
Message-ID: <0abcdfc27517e9205c0f0a3ea9168cf2@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.12.10 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sgfzb0u0YzAM"
Content-Disposition: inline


--Sgfzb0u0YzAM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.12.10 version.

Thanks,
Zorro

The new head of the master branch is commit:

f814a0d8b89c generic: Add integrity tests with synchronous directio

New commits:

Alexander Larsson (1):
      [2a4fef036ee7] overlay/026: Fix test expectation for newer kernels

Anand Jain (1):
      [1d7a8c3a4d95] tests/btrfs: add tests to the remount group

Baokun Li (1):
      [b05c808ce4a4] generic: regression test of ext4_lblk_t overflow

Boris Burkov (3):
      [dd50c6276098] btrfs/303: use quota rescan wrapper
      [bd64bed75325] btrfs/301: fix hardcoded subvolids
      [c71b4e620375] btrfs/301: require_no_compress

Brian Foster (1):
      [86f0e4f7c18a] generic/459: improve shutdown/read-only check to accommodate bcachefs

Darrick J. Wong (2):
      [65e59370567a] xfs/601: move this to tests/generic
      [19cf4208e749] xfs/604: add missing falloc test

Filipe Manana (3):
      [fac81f816d7c] btrfs: add some tests to the 'compress' group
      [98865122ed3c] btrfs/048: add missing groups 'subvol', 'snapshot' and 'send'
      [ed058f1c6474] generic: test reading a large directory while renaming its files

Josef Bacik (1):
      [72e7d9bfdd8b] fstests: don't test -o norecovery in btrfs/220

Ritesh Harjani (IBM) (2):
      [985df7ef3051] aio-dio-write-verify: Add sync and noverify option
      [f814a0d8b89c] generic: Add integrity tests with synchronous directio

Shiyang Ruan (1):
      [9812168a1255] fsstress: unify verbose output format

Yang Xu (1):
      [95a41c18dd45] generic/733: use correct kernel commit id


Code Diffstat:

 .gitignore                                 |   1 +
 common/overlay                             |  19 ++++
 ltp/fsstress.c                             |   8 +-
 src/Makefile                               |   3 +-
 src/aio-dio-regress/aio-dio-write-verify.c |  29 +++--
 src/readdir-while-renames.c                | 146 ++++++++++++++++++++++++
 tests/btrfs/004                            |   2 +-
 tests/btrfs/005                            |   2 +-
 tests/btrfs/015                            |   2 +-
 tests/btrfs/048                            |   2 +-
 tests/btrfs/052                            |   2 +-
 tests/btrfs/056                            |   2 +-
 tests/btrfs/059                            |   2 +-
 tests/btrfs/094                            |   2 +-
 tests/btrfs/112                            |   2 +-
 tests/btrfs/150                            |   2 +-
 tests/btrfs/163                            |   2 +-
 tests/btrfs/164                            |   2 +-
 tests/btrfs/167                            |   2 +-
 tests/btrfs/173                            |   2 +-
 tests/btrfs/174                            |   2 +-
 tests/btrfs/220                            |   8 +-
 tests/btrfs/233                            |   2 +-
 tests/btrfs/258                            |   2 +-
 tests/btrfs/259                            |   2 +-
 tests/btrfs/263                            |   2 +-
 tests/btrfs/276                            |   2 +-
 tests/btrfs/293                            |   2 +-
 tests/btrfs/301                            | 174 +++++++++++++++++------------
 tests/btrfs/303                            |   2 +-
 tests/generic/459                          |  28 +++--
 tests/generic/733                          |   5 +-
 tests/{xfs/601 => generic/734}             |   3 +-
 tests/{xfs/601.out => generic/734.out}     |   2 +-
 tests/generic/735                          |  54 +++++++++
 tests/generic/735.out                      |   2 +
 tests/generic/736                          |  37 ++++++
 tests/generic/736.out                      |   2 +
 tests/generic/737                          |  54 +++++++++
 tests/generic/737.out                      |  22 ++++
 tests/overlay/026                          |  42 ++++---
 tests/overlay/026.out                      |   2 -
 tests/xfs/604                              |   3 +-
 43 files changed, 551 insertions(+), 137 deletions(-)
--
Zorro Lang
zlang@kernel.org

--Sgfzb0u0YzAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmWJvQEACgkQlNbPkfr2
tMw8GxAAyTrPQgS4ZQ5MtjbOOg/R+Phmm573pSsIrJeHqNv7Ujz1M4UDwxzylB/j
duQM3yiarp4KxmGO4UYo3rkexWI8fKGq8SosttUaS+7rYr627g4kOqTzDgNKTd2C
nDGYTIsfhlq64q4oG/LVoyFBzWxIa7Ua2osH7hEGu8TRKoWS+pZXXaPYiLcXJMRe
BqR/CVbGQJKED3R+GxjalqABzNUSlbuTrHa2ylPSbgWvEkfgCG4g7zaHIf9vDKz+
1d3720xNy6FVJyBLJK+gKDGcYZGG9rvVRnJajVixO2WXFJWIJlZuoCfrHQw96aqg
m/tFUDYbcy3XAW7pYT53KEpseC4qeVru4GaPswUBAqQBlXPOkd0EoNo5lB6Y76i1
TrP4YvEIgxe7Kfbi3lP+/Iik5d2OXu7SC0201SsrPsxb/pl2VWMIDWkZ3Gtwvf+E
+TB774skNSep40TU2PdRVr9RdBUctM4ihcSiSHfc/s0XKlb2pxfGGmugRa68Cg2D
uoHcX0Gwhg+gxCmriX6xEPn8Kmv29f1ilXIB+Ms78WHDTlXPqcdNRglpbM4Cyg6+
7Vxs3MjsJgOSsn89YC+qBZpZcHKIlw4xe1N57lCY9TA2X6cL1k9iCwUTyMfZcjcK
k+1a0iS5uuQdYgBrIyEj0NvhDvhg7J18Q+RUzfJovMz6TIgwYP4=
=cTCr
-----END PGP SIGNATURE-----

--Sgfzb0u0YzAM--
