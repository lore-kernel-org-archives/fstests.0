Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6F1D04A9
	for <fstests@vger.kernel.org>; Sun,  1 Dec 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733060287; cv=none; b=sGvgjA7lX/5EejCDsD4jsUAMSn+yIN3LQC1hvP5ge93xSAB/qT1T6U/3XU/7JZbCnaeSqdXHAlvetbHtnh6djXKS1/Z9JblgcC/8TNJsfA+W7pl9/MiiYqe/IUa/AAy8T+E6c/myXRlUBbUnhkcKsT8gtWXXOGIjiQBXnt3aqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733060287; c=relaxed/simple;
	bh=xFovV559JE4A6V0r4uFKELrwgNa2iLenwS2qddZxfBg=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=uac45YmPeNd7VHk16jPLU4TwoYw0c8MZ6bwrzpq9cTP3jccQtpvFD7o7Fng/WeIWaxRUmVKdo38/3X61fmMsdaVO7SpKuMXxTNc+sLyRltH2Xnxb+jguOewRENWLDa+ULXBkhmUIBh/SuWjmqtxNz1IeustLiYTSC9GdF3dASts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXlIb4FP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXlIb4FP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C04C4CECF;
	Sun,  1 Dec 2024 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733060287;
	bh=xFovV559JE4A6V0r4uFKELrwgNa2iLenwS2qddZxfBg=;
	h=Date:From:To:Subject:From;
	b=eXlIb4FPR8srGrmYAvhNQTjwZ+b8Vl866iTVMFQ5i1ucgCPGHri+lSSnNsd6yuuC8
	 HDQjHnbygAWN3610hD64b9/BMPadz0ZZPX0lmtX+HvgEIR+HnGdT1Pfpec0717yaSi
	 ywlfGDhyiVFgm9gG8gGSDJ8t+InLGtZdrtMgBxGdYepTZ7OsNVrGU7lM5ATvPRcnMJ
	 i5q5AMRwYT+C1ykiBo9frh23DIDAXXGbqEemXXLc984SYXvKozMPpvrwy9n+S88zSG
	 gqvBACxlBFdvvZjpRKarbOU5BURF52AlK+LVWT/i41wyr7Xgragavy00NiWVkanw5w
	 BMZ71fAfRZO4g==
Date: Sun, 01 Dec 2024 21:38:03 +0800
Message-ID: <08c64977b30bd55f30f5a366c81851e5@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.11.17 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E0ry1u5P8bo2"
Content-Disposition: inline


--E0ry1u5P8bo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.11.17 version.

Thanks,
Zorro

The new head of the master branch is commit:

88be6071da67 xfs/185: don't fail when rtfile is larger than rblocks

New commits:

Alexander Mikhalitsyn (1):
      [cdbcb808ecc1] ext4/032: add a new testcase in online resize tests

André Almeida (1):
      [c3a28053dc09] common/casefold: Support for tmpfs casefold test

Brian Foster (2):
      [2fe95b92d6da] xfs: online grow vs. log recovery stress test
      [083bb0ea9473] xfs: online grow vs. log recovery stress test (realtime version)

Chao Yu (3):
      [5089b050a672] f2fs/005: add testcase to check checkpoint disabling functionality
      [23ebca50151d] f2fs/006: add testcase to check out-of-space case
      [7838e3082b15] f2fs/007: add testcase to check consistency of compressed inode metadata

Darrick J. Wong (2):
      [47aa187fb226] xfs/273: check thoroughness of the mappings
      [88be6071da67] xfs/185: don't fail when rtfile is larger than rblocks

Filipe Manana (2):
      [d9228b41b30f] btrfs/287: make the test work when compression is enabled
      [1e990ee9aaa0] btrfs: add a test for defrag of contiguous file extents

Johannes Thumshirn (1):
      [e2affc453cf5] btrfs/136: check for ext3 support

Qu Wenruo (3):
      [4c1629ae3a3a] generic: new test case to verify if certain fio load will hang the filesystem
      [81477600d363] btrfs: a new test case to verify mount behavior with background remounting
      [3fc00cd4ab98] btrfs/321: make the filter to handle older btrfs-progs

Zorro Lang (1):
      [66434a1cb731] xfs: notrun if kernel xfs not supports ascii-ci feature


Code Diffstat:

 common/casefold       |  46 +++++++++++++++++++++
 common/rc             |   3 ++
 common/xfs            |  10 +++++
 tests/btrfs/136       |   2 +
 tests/btrfs/287       |  10 ++---
 tests/btrfs/287.out   |   4 --
 tests/btrfs/321       |   2 +-
 tests/btrfs/325       |  83 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/325.out   |  22 ++++++++++
 tests/btrfs/326       | 107 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/326.out   |   2 +
 tests/ext4/032        |   6 +++
 tests/ext4/032.out    |  18 +++++++++
 tests/f2fs/005        |  47 ++++++++++++++++++++++
 tests/f2fs/005.out    |   2 +
 tests/f2fs/006        |  42 ++++++++++++++++++++
 tests/f2fs/006.out    |   2 +
 tests/f2fs/007        | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/007.out    |  16 ++++++++
 tests/generic/366     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/366.out |   2 +
 tests/generic/556     |  12 ++++--
 tests/xfs/185         |   6 ++-
 tests/xfs/188         |   1 +
 tests/xfs/273         |  47 ++++++++++++++++++++++
 tests/xfs/597         |   1 +
 tests/xfs/598         |   1 +
 tests/xfs/609         |  79 ++++++++++++++++++++++++++++++++++++
 tests/xfs/609.out     |   2 +
 tests/xfs/610         |  81 +++++++++++++++++++++++++++++++++++++
 tests/xfs/610.out     |   2 +
 31 files changed, 856 insertions(+), 16 deletions(-)
--
Zorro Lang
zlang@kernel.org

--E0ry1u5P8bo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmdMZpIACgkQlNbPkfr2
tMwu5xAAsBpbq57w0teeGD+79VpZna8PxJ8/awytFBonRJa2s4Zielv4YSZ0KBeU
2tg42ON+kdxWIv1qpg+kaoWqTEdA6uzIkQTuG1nenrGvagpY6FhSG2aQB6gBZv6o
pmcpPCSanQkXpdAIcI9mtu9xCKvrA9L60tRYuJ0IZc4b9Yo1g4ZsdH+5lN73TUlp
J9kSGJY4jUz9a01WRdI0j/6ZUUd33QfTEmq+f1ka45/9y6rjSFAHKluxsWOpkCXQ
zCxMGQ5IVtebpPWgkGsg2WRPGgfT9fumB3K8TvZHHqZSZFFZLUygepvaNb+5PA44
d16gbPSZgFVOytX5LQw7todS7Di3TuijPo6p7gIUH+k2Lhed7mkZxjQAMr109ASG
lTJHbSLKx+K3Deg3k3rMohPNYHKcl+I838w1ZO/soIPA/3Yih3iCkWSn/YlIbgMq
KkXQt5BesFt9rBp8VBqHZUlss+FshkF+Dz3Il0WhROz8yHaF0qXlQEqhWT6I75il
axJ3sE0K9KZEeU8zh7VAIowWYM16BCLOwhCvCA1fdXRHkHDT8I8um7PIus2dI1Y+
tG1Ze5jBYA9n77YcEJeyolAdA2NJn80+JRcvL6CPdeGqPfN/NYdYitrvUe3F/yjg
3mVcHDWC7p9LQD6zbpy50Ab9xmwCckHTN7ob3Y65KcqLREDIMQU=
=CrJe
-----END PGP SIGNATURE-----

--E0ry1u5P8bo2--
