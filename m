Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8502FC1D
	for <fstests@vger.kernel.org>; Sun, 25 May 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748177418; cv=none; b=KjpvKFDyCrmzkaAZvxc++SWXbODk7NuNRrzU+qKQO8hJPQrLU+CQ3pAqnpRGoUbKqo8NvTkKG9Ks/8C9RZ/lITe1RB3wHtkIPY3OhA58xONcfn49F3OmArAe+aoD2tzpclorkiivO9fZaDkdphuHekzT1nMKqZn9hqkHIr6wOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748177418; c=relaxed/simple;
	bh=8LDTnStyBQCAW0rbyC7J9vIPomGsKpdStl0tbpjEp0E=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=kGbrKRZUyiVRdIALQTc2gO77zH2SBQwi/5+CTR+7G6h7qlbm8HS7tuRdEaM588a5XXiXKTCYBT256A8vhQbqWXNAogT5VMLXewT3gjLAgj8fB4UvpzvEQGHBz1YbcurogJIYyamicpg8+b4tnl6XeiP9BIB9UJHezx9AgghuVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzrZNnGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzrZNnGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9750C4CEEA;
	Sun, 25 May 2025 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748177418;
	bh=8LDTnStyBQCAW0rbyC7J9vIPomGsKpdStl0tbpjEp0E=;
	h=Date:From:To:Subject:From;
	b=pzrZNnGnu75qXjMlumax0HPhy1CxkEoMw+U4znhyPaGRyPyEbyOMz2x7QNaKqWtA3
	 fq4v8fMTKWcO3I5xq7uHJ96WEo33jaCcKhDLtczZbMdPES8FVetr/0u5oVxCzUYscd
	 VANIgrR2R2kKLAl77JRlGc7tjE90acR6b3OUe2EPR8Jrq1TU0sWKydfNzeypkFhfFm
	 51cTC5MzgesjfXhHBdMXnm1mxhz21fYqBZjUp9k7f+B7kCDpP9NWy1MgIPifd3pgfK
	 eaCnKOSRJYOnQ/akl2omXcK/TJonHnmqCWBI1vZcu8RLF3jH+z1b78N2hHw0ttnBsY
	 44rNE+dY/EcnA==
Date: Sun, 25 May 2025 20:50:15 +0800
Message-ID: <9a36c5b77e0b7261ff07fd7c1491338e@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.05.25
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SorwFb4WBbkF"
Content-Disposition: inline


--SorwFb4WBbkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.05.25 release.

Release Notes:
1) There're 3 new test cases in this release, include btrfs/336, f2fs/013
   generic/777 and selftest/007. The g/777 tests connectable file handles.
2) A new group name "mmap", please add proper test cases into this group.
3) A new optional interactive input for "./new" script.

More updates and fixes refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

b7680adf9ff7 open_by_handle: add a test for connectable file handles

New commits:

Amir Goldstein (2):
      [67b823d4a832] open_by_handle: add support for testing connectable file handles
      [b7680adf9ff7] open_by_handle: add a test for connectable file handles

Chao Yu (1):
      [75372b7617a2] f2fs/013: test to check potential corruption on atomic_write file

Christoph Hellwig (1):
      [0e88b42adfbc] xfs: skip test that want to mdrestore to block devices on zoned devices

Darrick J. Wong (4):
      [c0de6df76100] generic/251: fix infinite looping if fstrim_loop configuration fails
      [34d0c55a92b5] generic/251: skip this test if fstrim geometry detection fails
      [cc0dcbf48849] check: unbreak iam
      [68fa350e1e77] check: check and fix the test filesystem after failed tests

Filipe Manana (3):
      [aac2e9fee68b] fstests: add a mmap test group
      [3c21ae673e70] btrfs: add tests that exercise raid profiles to the raid group
      [282e4fe8cf47] btrfs/023: add to the quick group

Johannes Thumshirn (1):
      [1e1d98c85d73] fstests: btrfs: add git commit ID to btrfs/335

Nirjhar Roy (IBM) (3):
      [f0477f43d203] tests/selftest: Add a new pseudo flaky test.
      [359cb24a11d8] new: Add a new parameter (copyright-owner) in the "new" script
      [7e41a4a04bdf] new: Replace "status=0; exit 0" with _exit 0

Qu Wenruo (4):
      [f405f5f6cc8e] fstests: generic/537: remove the btrfs specific mount option
      [3bbdf4241a5f] fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
      [49170253afef] fstests: btrfs/220: do not use nologreplay when possible
      [22cc9e29bdf8] fstests: btrfs/020: use device pool to avoid busy TEST_DEV


Code Diffstat:

 check                  |  9 +++++--
 common/populate        |  2 +-
 common/rc              | 16 +++++++++---
 common/xfs             | 14 ++++++++++
 doc/group-names.txt    |  1 +
 new                    |  8 +++---
 src/open_by_handle.c   | 53 ++++++++++++++++++++++++++++++-------
 tests/btrfs/003        |  2 +-
 tests/btrfs/011        |  2 +-
 tests/btrfs/020        | 51 +++++++++++++-----------------------
 tests/btrfs/020.out    |  2 +-
 tests/btrfs/023        |  2 +-
 tests/btrfs/027        |  2 +-
 tests/btrfs/060        |  2 +-
 tests/btrfs/061        |  2 +-
 tests/btrfs/062        |  2 +-
 tests/btrfs/063        |  2 +-
 tests/btrfs/064        |  2 +-
 tests/btrfs/065        |  2 +-
 tests/btrfs/066        |  2 +-
 tests/btrfs/067        |  2 +-
 tests/btrfs/068        |  2 +-
 tests/btrfs/069        |  2 +-
 tests/btrfs/070        |  2 +-
 tests/btrfs/071        |  2 +-
 tests/btrfs/072        |  2 +-
 tests/btrfs/073        |  2 +-
 tests/btrfs/074        |  2 +-
 tests/btrfs/100        |  2 +-
 tests/btrfs/101        |  2 +-
 tests/btrfs/124        |  2 +-
 tests/btrfs/125        |  2 +-
 tests/btrfs/140        |  2 +-
 tests/btrfs/141        |  2 +-
 tests/btrfs/142        |  2 +-
 tests/btrfs/143        |  2 +-
 tests/btrfs/146        |  2 +-
 tests/btrfs/148        |  2 +-
 tests/btrfs/150        |  2 +-
 tests/btrfs/151        |  2 +-
 tests/btrfs/160        |  2 +-
 tests/btrfs/175        |  2 +-
 tests/btrfs/184        |  2 +-
 tests/btrfs/195        |  2 +-
 tests/btrfs/197        |  2 +-
 tests/btrfs/198        |  2 +-
 tests/btrfs/209        |  2 +-
 tests/btrfs/220        |  7 ++---
 tests/btrfs/223        |  2 +-
 tests/btrfs/242        |  2 +-
 tests/btrfs/249        |  2 +-
 tests/btrfs/254        |  2 +-
 tests/btrfs/265        |  2 +-
 tests/btrfs/266        |  2 +-
 tests/btrfs/267        |  2 +-
 tests/btrfs/268        |  2 +-
 tests/btrfs/269        |  2 +-
 tests/btrfs/270        |  2 +-
 tests/btrfs/286        |  2 +-
 tests/btrfs/296        |  2 +-
 tests/btrfs/335        |  4 +--
 tests/btrfs/336        | 35 +++++++++++++++++++++++++
 tests/btrfs/336.out    |  2 ++
 tests/f2fs/013         | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/013.out     |  2 ++
 tests/generic/019      |  2 +-
 tests/generic/029      |  2 +-
 tests/generic/030      |  2 +-
 tests/generic/068      |  2 +-
 tests/generic/074      |  2 +-
 tests/generic/080      |  2 +-
 tests/generic/095      |  2 +-
 tests/generic/127      |  2 +-
 tests/generic/140      |  2 +-
 tests/generic/141      |  2 +-
 tests/generic/173      |  2 +-
 tests/generic/215      |  2 +-
 tests/generic/219      |  2 +-
 tests/generic/246      |  2 +-
 tests/generic/247      |  2 +-
 tests/generic/248      |  2 +-
 tests/generic/251      | 29 ++++++++++++---------
 tests/generic/279      |  2 +-
 tests/generic/281      |  2 +-
 tests/generic/282      |  2 +-
 tests/generic/283      |  2 +-
 tests/generic/325      |  2 +-
 tests/generic/340      |  2 +-
 tests/generic/344      |  2 +-
 tests/generic/345      |  2 +-
 tests/generic/346      |  2 +-
 tests/generic/413      |  2 +-
 tests/generic/428      |  2 +-
 tests/generic/437      |  2 +-
 tests/generic/438      |  2 +-
 tests/generic/446      |  2 +-
 tests/generic/462      |  2 +-
 tests/generic/469      |  2 +-
 tests/generic/470      |  2 +-
 tests/generic/499      |  2 +-
 tests/generic/503      |  2 +-
 tests/generic/511      |  2 +-
 tests/generic/537      |  1 -
 tests/generic/567      |  2 +-
 tests/generic/569      |  2 +-
 tests/generic/570      |  2 +-
 tests/generic/574      |  2 +-
 tests/generic/578      |  2 +-
 tests/generic/605      |  2 +-
 tests/generic/614      |  2 +-
 tests/generic/623      |  2 +-
 tests/generic/630      |  2 +-
 tests/generic/638      |  2 +-
 tests/generic/647      |  2 +-
 tests/generic/651      |  2 +-
 tests/generic/652      |  2 +-
 tests/generic/653      |  2 +-
 tests/generic/654      |  2 +-
 tests/generic/655      |  2 +-
 tests/generic/657      |  2 +-
 tests/generic/658      |  2 +-
 tests/generic/659      |  2 +-
 tests/generic/660      |  2 +-
 tests/generic/661      |  2 +-
 tests/generic/662      |  2 +-
 tests/generic/663      |  2 +-
 tests/generic/664      |  2 +-
 tests/generic/665      |  2 +-
 tests/generic/666      |  2 +-
 tests/generic/669      |  2 +-
 tests/generic/670      |  2 +-
 tests/generic/671      |  2 +-
 tests/generic/672      |  2 +-
 tests/generic/708      |  3 ++-
 tests/generic/729      |  2 +-
 tests/generic/742      |  3 ++-
 tests/generic/743      |  2 +-
 tests/generic/749      |  2 +-
 tests/generic/758      |  2 +-
 tests/generic/777      | 70 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/777.out  |  4 +++
 tests/overlay/061      |  2 +-
 tests/selftest/007     | 21 +++++++++++++++
 tests/selftest/007.out |  2 ++
 tests/xfs/090          |  2 +-
 tests/xfs/108          |  2 +-
 tests/xfs/166          |  2 +-
 tests/xfs/194          |  2 +-
 tests/xfs/284          |  1 +
 tests/xfs/550          |  2 +-
 tests/xfs/551          |  2 +-
 tests/xfs/552          |  2 +-
 tests/xfs/559          |  2 +-
 tests/xfs/598          |  1 +
 154 files changed, 467 insertions(+), 203 deletions(-)
--
Zorro Lang
zlang@kernel.org

--SorwFb4WBbkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmgzEeQACgkQlNbPkfr2
tMzdSxAAtMgiezfCFmK0d3ZP8GH46Dlt6ij+hvP7nnhpvJD6n4Lilhu06qF0Qxzm
tDLRqpAYBvdzDq6FxN1QpwAn5NM32A1+QT2KntlNgc6pmV4QE3zhzV57OZj0KShw
MDv3NGF9g4Nh/dCqwC6iVmW6Mr6lXzdDYGiYmlUxnXhmP6UB6j7dXmswBCObRXTV
IurfyTmpCmBIZHUzFgGe7UBn1X4GVPPBtT9uQ44Vdg/WxSzKwOGQehUD1/CBpCkV
kO1Z3bHkhTT46dnGYzYW3pHxwThqzOkV/PQVekF8njAsKnmHPd1rwPaxT08df2hf
9owFebi6M6ShOZQfNhjJ6Hk+pF0zOCOavPnFsEsrDacq/pAG18l88NHV6mxMofTe
aRnqyvuPldZNTIJ+wBUs+sjZwYcv4MsZErHd0m0kw4NwqBpKS6tJ2rJgw87U5tCZ
IFY9QuWPx78HF7Gd0pcHBs5zifAcGTfeF/MzXJZEFxbVUUZdmSGxAOl/CkPbTbEv
/3Pte/w9ibilDQDdObdXIfUDH4QnvSDLJI5EWDOCDqU0JPdksk9dds4TZeV3fhHG
rm1Rrm0iJajiznKilX0dR7AnCOvveKYYOkWGgDaP853OAMfCsMXIvjBXLdvMnOeq
SwJUB0ymo/sU91M0hC41YP+j8NTSGZNnXpz6kBpsJNo2F1laINY=
=Ww+h
-----END PGP SIGNATURE-----

--SorwFb4WBbkF--
