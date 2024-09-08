Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD23156243
	for <fstests@vger.kernel.org>; Sun,  8 Sep 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807061; cv=none; b=Gz9/b5AQRdv3zBN9/svyYT7iOm33q80UW1upVPUKN8GQxaxj0rMpnKsnkPBGrlyANtjtoENwW1ZKNaoA5JE+81kwc6ILSB/3RENkT/V+Vb3sp2DR6R2atm33QKU7L4bQ0vQP+nJeHLbjO4+MJjtUd6fqrjYFdyi3RSiNWeMpEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807061; c=relaxed/simple;
	bh=bEigyyk3fUL2OXWbaymh7zs5XvmqwrDi1/7z+AS+3rM=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=XNGthI7yZiG1r5igWc8Nc0xqExp1vPZfrhGAiGruE+YXCtOgysgYDW/h1akrRrpnmvO+t8bIInpTjstrnKXSkfdwmMtub7gW6zEY3AnSsz3P0YUpMWL6ooIz+WvzuiV1mqdlbqLGuwiJFeqohTFtiPsnlz5tTK56V/Srt/HtfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXKIrL4z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXKIrL4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031CDC4CEC3;
	Sun,  8 Sep 2024 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725807058;
	bh=bEigyyk3fUL2OXWbaymh7zs5XvmqwrDi1/7z+AS+3rM=;
	h=Date:From:To:Subject:From;
	b=ZXKIrL4zPbnlPlcleKvXjo9H2kfoNX+0wMtPAvByhiCc4SgkCSg8i7TBs9lwpYVna
	 mpn09uT4lol1HvAJasBGXsGkmdSyzWI8hdDZESmBXCxmPCgrDqIheW6/R8e3svEIF9
	 2F2z4MJBWrN6h+0fZVL95kJ2oNt0ORcGMQGkPeKj2us0BblnKSjuTz4ncFswoPsQt4
	 zWEHUch5YCIfW+8qYNsUDYYUxffE0nUpYUd1wfJEB/jbiE4O+Zb9f5M+fs79eFzTp8
	 rN/peCLin4Un73+fDrabswozFT/XO9RBN40esGxX/7dpUl91TNkXsV4UyghLZwp8Qg
	 DM9PnRaoaCnWg==
Date: Sun, 08 Sep 2024 22:50:55 +0800
Message-ID: <06928d2fd388655d9e8178862357cedd@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.09.08
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poQGE7lQIX5s"
Content-Disposition: inline


--poQGE7lQIX5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.09.08 release.

Release Notes:
1) There're 8 new test cases in this release, include btrfs/321, g/363,
   g/364, x/802 x/803, x/804, x/805 and x/806.
2) The fsx.c is improved, to support eof page pollution for eof zeroing
   test coverage. New test case g/363 runs that.
3) The overlay/013 has been removed.
4) New tests for xfs_scrub services and xfs properties, refer to x/802~806.
5) Two regression test cases for btrfs known issues, they're btrfs/321 and
   g/364.

More updates and fixes refer to below, thanks for all these contributions!

Thanks,
Zorro

Thanks,
Zorro

The new head of the for-next branch is commit:

f71228e304b2 btrfs/319: make the test work when compression is used

New commits ([N]ew, [U]pdate, [D]elete):

Aleksa Sarai (2):
[U]      [1e207662b3ce] open_by_handle: verify u32 and u64 mount IDs
[U]      [6171b03c92a6] generic/756: test name_to_handle_at(AT_HANDLE_MNT_ID_UNIQUE) explicitly

Amir Goldstein (1):
[D]      [55158bfc9946] overlay: deprecate test t_truncate_self

Brian Foster (4):
[U]      [bc0c52655c5a] fsx: don't skip file size and buf updates on simulated ops
[U]      [11dbbdff1737] fsx: factor out a file size update helper
[U]      [9e2b0f4c9579] fsx: support eof page pollution for eof zeroing test coverage
[N]      [fea26871799f] generic: test to run fsx eof pollution

Chao Yu (1):
[U]      [c88734099723] f2fs/003: add missing _fixed_by_kernel_commit line

Chen Hanxiao (1):
[U]      [0afb586a7e77] generic/362: skip test on NFS mount

Darrick J. Wong (7):
[U]      [1dbd10d1bbca] generic/453: test confusable name detection with 32-bit unicode codepoints
[U]      [c63a6fe02353] generic/453: check xfs_scrub detection of confusing job offers
[N]      [652692a8e475] xfs: test xfs_scrub services
[U]      [18c331d98c29] xfs/004: fix column extraction code
[U]      [fff4042b60be] xfs: refactor statfs field extraction
[U]      [c9b3c1c392fd] common/xfs: FITRIM now supports realtime volumes
[N]      [87f14ee1f79f] xfs: functional testing for filesystem properties

Filipe Manana (3):
[U]      [a8d61229a949] btrfs/319: add git commit ID
[N]      [136c5099d07e] generic: test concurrent direct IO writes and fsync using same fd
[U]      [f71228e304b2] btrfs/319: make the test work when compression is used

Qu Wenruo (2):
[U]      [869685f2f308] fstests: btrfs/125: do not use raid5 for metadata
[N]      [66a2179efbde] fstests: btrfs: test reading data with a corrupted checksum tree leaf


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

--poQGE7lQIX5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmbduagACgkQlNbPkfr2
tMxrehAApFdyD0tbq1937TI45yGn1QTkNPmnVckgXKmVPPJ0rcDpr0SMslpbENO9
barH4FFyvCz+bq4ibaKsyBYFkJshU592f1S5E8/+n+Hz4/nQXDMLkiVQivwObcYe
FaU/eGCnBs/3SD/MsfkBSTAAXkTloIJ7R9kBSXyFr6cpYFaFxYdMd0G3VBgZOsMW
IvcgDe+M2Di8b5M0aEwo/BUzgUZQsMTgoAfGDUfMerrjTgVEFbN/gU2u0XIgi20M
gn3qPVpa6g1txPD/Tpgdn4EOkHHvwMmAZVeKwEwNlWw75DG5vjgeGeqdEAWLqqRq
mDgu+YtVr4+FWTmgRFATbAhRU24LGvpGSOsg+G6SViELq4vbThIwurhqBNaBqB/c
ZAUdVwvbFGbkVci8KgL+nvE1TyaMmMRblwOuTqbpqSYpffIkDoR34hbIIiA4y6Yb
rmXV4IeepzTkzolIXwslU1lHzpXXl+IiCwjXRQ/KokuIAvEchJQyuUkN99UyAFMJ
dFURSYNVl/a2aVEBucnZh8rQD0NkHLwghDOTqU/HMCsR2p4yYPCkGj9hC8Ll5Ovv
xXLUZs7nPzvxh0hyRgVftLySixhizWESXlT/QWR8q2BlBywUykeeGLXYpSqoGa04
PByvzqVduEpE2lMDI8TgxwDGXohcz8leceaVPmpo4x1drGdIay4=
=VvHM
-----END PGP SIGNATURE-----

--poQGE7lQIX5s--
