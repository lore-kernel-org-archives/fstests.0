Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A721D1F40
	for <fstests@vger.kernel.org>; Sun,  1 Dec 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733061340; cv=none; b=EmV0Vqj000YbPs0fV103UKD+7N6soofb6IfhApe/c1sUYOtn4ged6RFQ/FC3SfV3bJlFOWSp5BLcBr20Of8u5Jb1lCvUrpuRFlQtGwXSNP/b8N5CYHp1nftmG0txw5NiG8RXpGZF9U5X9NcMhlLG1p60UcQlEN8Wq/xcUlpbtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733061340; c=relaxed/simple;
	bh=MD+7enNgee783UwJ4ezJ9e79Q/GwUWHU5H2wGhZT6N8=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Kn4K96/0irORyqpj8VVSWol01n34tQDJZyDH4k4Qq7YDen4u2ZlK7SWiZVEYPMWvKqQgCQTH3WiClx/8xHJymJO8ed+9Fn8wga8OC/zqr5hMcrNmAjdRk3kysFu7JV7yDqtOcnqUqTUJmAXgrF6vWPpOFMjBP8DYJd7TWs1a3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urep+MVf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urep+MVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4533BC4CECF;
	Sun,  1 Dec 2024 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733061340;
	bh=MD+7enNgee783UwJ4ezJ9e79Q/GwUWHU5H2wGhZT6N8=;
	h=Date:From:To:Subject:From;
	b=Urep+MVfUSUU6LqHAQtqbFdzEnmjNLqD9VzhjVNt38TnsVBOuSOsWSaxscnv7iz7x
	 ttm0qImTZ/mhLRanmTPgoQEaxqA06Jht1RV1uSCcx9YWgKY5pn83P8fnVkzcRTn8HZ
	 Y8rA5KMR+zIKR9ZERQLJQW4XF40NC8ysF1yRlEKnwf1VhjnDhmakNCBdepyTRU7bOH
	 grJF1DFz1SDr19fLmtmtWJ4nmdmkRZ0xSwl+7uhKoeIbRAMPC7GU47aT/jnerjEsX9
	 xc6DYjZXdWta6l2e3OZOi5xFruV/0k469qLeQWLYQ9wblNM4Ql4DRqJdsvfpxFjtmE
	 cFEWqo4vItiog==
Date: Sun, 01 Dec 2024 21:55:35 +0800
Message-ID: <45db57f80bac6fe94dd7c4a1eb62ce94@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.12.01
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WacYjfUZt71M"
Content-Disposition: inline


--WacYjfUZt71M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.12.01 release.

Release Notes:
1) There're 2 new test cases, include generic/367 and btrfs/327.
2) Lots of bug fixes in this release, more details refer to below.

Thanks for all these contributions!

I'll try to merge a big patchset from Dave Chinner in next release (except there
are big issues). It changes so many things, later merging will cause more and
more conflicts.

  https://lore.kernel.org/fstests/20241129042216.u2f2sl5pc553gxqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m331c898ccf49c2d557e45a1a27bf80a43123bf14

I provide a temporary branch "for-dave-check-parallel" for testing this
patchset, I've fixed some conflicts and small issues on that branch. Feel
free to give it a test from your side, to avoid this change break your
regular testing later :)

Thanks,
Zorro

The new head of the for-next branch is commit:

8467552f09e1 btrfs/327: add a test case to verify inline extent data read

New commits:

Anand Jain (1):
      [4906a5ab94ee] fstests: fix blksize_t printf format warnings across architectures

Christoph Hellwig (1):
      [c8114d98186a] xfs/229: call on the test directory

Darrick J. Wong (15):
      [92aad87ec067] generic/757: fix various bugs in this test
      [e21e278065bf] generic/757: convert to thinp
      [fa95cde52dcd] xfs/113: fix failure to corrupt the entire directory
      [27ce2a47a773] xfs/508: fix test for 64k blocksize
      [67e01fc52bbc] common/rc: capture dmesg when oom kills happen
      [93a8e88d0f6e] generic/562: handle ENOSPC while cloning gracefully
      [38257f559615] xfs/163: skip test if we can't shrink due to enospc issues
      [d9352ed5e24a] xfs/009: allow logically contiguous preallocations
      [2d6e7681acff] generic/251: use sentinel files to kill the fstrim loop
      [dbdbe1ec8591] generic/251: constrain runtime via time/load/soak factors
      [f06e93a4b1af] generic/251: don't copy the fsstress source code
      [f4ac46a85121] generic/366: fix directio requirements checking
      [d78afe6b6f0c] generic/454: actually set attr value for llamapirate subtest
      [ab1ece9ee32d] xfs/122: add tests for commitrange structures
      [0c01033c834f] generic/459: prevent collisions between test VMs backed by a shared disk pool

Filipe Manana (1):
      [09d86a113f0a] btrfs/028: kill lingering processes when test is interrupted

Nirjhar Roy (3):
      [e715441790b8] common/rc,xfs/207: Add a common helper function to check xflag bits
      [5c42ec5b9fd3] common/rc: Add a new _require_scratch_extsize helper function
      [a9c233162ef3] generic: Addition of new tests for extsize hints

Qu Wenruo (1):
      [8467552f09e1] btrfs/327: add a test case to verify inline extent data read

Zorro Lang (2):
      [98a76c6c51da] common/rc: _scratch_mkfs_sized supports extra arguments
      [d6596effc4df] xfs/157: do not drop necessary mkfs options


Code Diffstat:

 common/rc               |  59 +++++++++++-----
 src/attr_replace_test.c |   2 +-
 src/seek_sanity_test.c  |   2 +-
 tests/btrfs/028         |  14 ++++
 tests/btrfs/327         |  56 ++++++++++++++++
 tests/btrfs/327.out     |   2 +
 tests/generic/251       |  42 ++++++------
 tests/generic/366       |   2 +-
 tests/generic/367       | 174 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/367.out   |  26 ++++++++
 tests/generic/454       |   8 +--
 tests/generic/459       |  15 +++--
 tests/generic/562       |  10 ++-
 tests/generic/757       |  26 ++++++--
 tests/xfs/009           |  29 +++++++-
 tests/xfs/113           |  33 +++++++--
 tests/xfs/122.out       |   1 +
 tests/xfs/157           |   3 +-
 tests/xfs/163           |   9 ++-
 tests/xfs/207           |  15 ++---
 tests/xfs/229           |   4 +-
 tests/xfs/508           |   4 +-
 22 files changed, 456 insertions(+), 80 deletions(-)
--
Zorro Lang
zlang@kernel.org

--WacYjfUZt71M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmdMarAACgkQlNbPkfr2
tMzZHxAAi+Qj0pnX2vOTPBqCyrHVR+GUdQa410pBfLXeJl0a4/NBK6NWZ0tM7hWK
/91zqkKDS8Js9COWJUAE5XQ1Rp9b1D3xH184bmYO9YwAeULFxMKNQI1MVtHuDriM
jlbljXmxZt9XXSK77qimTR7OoYjY4UKBM2kk0W3emP9/7Q1jyted7VDVqUzBVXlh
i/8vYx9fA4BcZtkn+Iml1nrRsIxcDk8IaKUdYBlKOscKHDgYIFOU7tAN12Cm51so
zrLIpIzyXdZCFE2rXm7KPrbzPeK/iIb5xTNB9SOyBxS9dVEYeP5US5QXHG0Z1O9/
tTv7+1OlcWFwWqdlQB74B4so3YRzQCEmrQcgMSHBH719A+jJuHuGFT02QsRWOUJB
ztxiqnDk6d4sCOaDRoqGnL39gePNq0oo3gdeKNImEoYBgfOIyfF00kPzXbP5baSz
ltWWOzNSgjMpg2B7xBw0K+33/tCv9ncUP4ZZ1cobF2ndvPMxE9un8Sc03zeyKku3
Q3sbVsJLM4C1qn4r8cSaBOH3RZLBgUZtsiVLWW9e9ujnZIeQQwvU37/R6uzUj6nh
6AzymH58Z0z1vD8jb2DdHkCzOrVFVyTreGyOW6w1118x3pRaQCW5LXNFuVGgbuKs
vgVcSs/WXkwDq0dglFd2jYiFaVhogHKMYBRgIsggT3xyty23PRQ=
=mb2i
-----END PGP SIGNATURE-----

--WacYjfUZt71M--
