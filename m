Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA019EEC2
	for <fstests@vger.kernel.org>; Sun,  8 Jun 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749390841; cv=none; b=GOaIslQGWYipWuPHsIEd05Ou8Akt1u5G9OLZ9fIVcuays6tk6gLhGx8RQB7HpihHbXg5Kt46W0MHwK00WugbD/ziMzdUg/oigeLgLi4pyE6bRyo8NPNzMpvhvufby77krUJKQTQDyRqMPVHiyUISuJjbwWfV0Rbc7vmhU4EHOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749390841; c=relaxed/simple;
	bh=a+xiqmE8RFRV0JnRKGkrAPFw7NsQq60GLUxYvfhBgaw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=cZdKKE3GHCDnWIHME/tfGzIFcJN+DTl98e86H5DPjKRekxciVZ1662CK+GLT2yfG52vy3qYw7QkTa6ahqxDSo9mPkGQbzvF17fK8d7blDcEuhralvVfC6xV7IdAqEITOIi61nrbCydiDJZwvuZxl9xmmStj21zrQWH5g39YN4NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5blWJE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5blWJE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1475C4CEEE;
	Sun,  8 Jun 2025 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749390841;
	bh=a+xiqmE8RFRV0JnRKGkrAPFw7NsQq60GLUxYvfhBgaw=;
	h=Date:From:To:Subject:From;
	b=H5blWJE1pxF8Upz6dlfWBlT2qMyWhKavGtzCCjBm5XG0L4Y2qEJ/0IRdUEKJFRnl8
	 V9Dhu4MBfFLCM452oKY/tEX68NGc7DL4vbfAYjSmy0ruF9n+qlsLVLymBSgIE1+npF
	 Br8maqjNv2zCCfYkZYWlkn0LFk7uOnAhg9A89pzB6BOMq2sXLaUThVra6WnskomCbu
	 eEaunYkmh5KBA1Y5ngxaerEEZzkMLk3cUkr1QW3zrt303ReOpy2e++zycUmlV7ZpoF
	 ymYjPm1X+L2dfl730YtD7Uxs5wofLZoKY0Aq0K/pg8QJ2LpJ19Hnx2WDpi0zJ1spUO
	 5bjwDLgC9ELGQ==
Date: Sun, 08 Jun 2025 21:53:58 +0800
Message-ID: <f1858d877638a8bffad5c90cecbf1fac@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.05.25 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yBAsQh6zFXJm"
Content-Disposition: inline


--yBAsQh6zFXJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.05.25 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--yBAsQh6zFXJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmhFldYACgkQlNbPkfr2
tMyXaxAAo70iZDv8waya0yZ2Oo6V8C27u9c4wnp8tV8RxhNc8+Z12zY4Nb3d5uI8
RuCDiWGCLj6rDfzfZ/KIbTyFmYwE3Lq00j1xSboXgA+0CFRp5UnOGfJhossphZd/
6YfAq7JLV4xShwSZ6m1xUINLV0OU4jhGU4tjfn/0Gb+1yd5R6Vj3RYir5iaXHF0x
QY1Zeehd/zY55vHSz4x9OJFoama90nhWCOyJ42kCC1zh69nJY9yQFswNzhfBT4tV
ZPGaoRs7rkZu7rA4vWOW1Qa5ZfkEvGwWA7IEcf2kiTtJptvs73umwDRQfZgG5aPt
lPTIbBYlASELCtBazcD/S15Vl1Nxsy+SgymYe0L+5PnwRhuZbXcOUMr5DnQyQMSt
GoTWvWOISPrFuV9qUVFtl3M0TwcHs+RTDGqhht+J7NlkglUl3AGS4dPo9znfx3OJ
I4Skl1wgG0RuvRm5G1BDjg2j0bHeKXGjO109f9qZ+HnHHSg7b80TNA7uybWS9xxp
oGeF/JQnE6ulq7caqjauLfTA2pDVS9E2GnapuwQawOB7+tx+/4Xbrh+5GKmYemp/
1V505tsHyCASswRzfOXZypwuosaPBLR+cthQ8v8YjBiQ6d76I0a8EnkQPmZ3T8AO
QWrjBGwl2LWbzqdhHU+HZxxvcAssTEc6hajs6X/BEUgFUnnSRVs=
=gNzi
-----END PGP SIGNATURE-----

--yBAsQh6zFXJm--
