Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DF256D
	for <fstests@vger.kernel.org>; Sun,  7 Sep 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757254365; cv=none; b=CTRWhm1LyBbJmW1liPAR2sMvrXdEM5PgHl0gqfE42Lwx7qPCNpnVDnn6vILzRufvbbtYIi+mNTckcNdXq02tL2TStIBgt2NmFYkLtzjHF1nNobY5pYSW8Uf3Zzsmnyl2kW3UmO4dpJLeGNUvmGSSqK4GHz9LzVAffa2wdgz/p4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757254365; c=relaxed/simple;
	bh=NRfTljH1bndAZroHJ8fLuFeOdJGH+ZXXxR8P4KOIZeY=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=JF8gniAbsRiRNufQ6/dBUBilZcPslEdkV2kDLq/oEWxqu76UH+Ty47CDEJ6rc8KklRpZc/zNDr5c1an1V0LxVZxbUFgvviN0I8UGTLXkSY24VqFFa4SqnNg5YflNr9ZAoEAZfFkBSdIqZl+1aNKmB2NSGdvGwEMo0Uo8sfmBNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqHEZZG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqHEZZG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019EFC4CEF0;
	Sun,  7 Sep 2025 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757254364;
	bh=NRfTljH1bndAZroHJ8fLuFeOdJGH+ZXXxR8P4KOIZeY=;
	h=Date:From:To:Subject:From;
	b=XqHEZZG/rKhxbjzimxM3vdWPd58GfggBJYGTktt4yPCs5aKx0QjUvLiHIlLKcK2Ys
	 9cmjsOrTYQJegPO6K6BGwiUXzzjQkQOtxcUCkjGyUoQ7eIoRVNWn/0M3MxRJGoqk49
	 Xec0it2qCLkdbkAEPa6gZcuFg9/0gt4iVrZBNk72rUb3VWr6clocw8p3Ov1R5nWUze
	 qJzMKnf2ib5Jdp1UkSQ+3QAQ29FJe358bWM6zDyGRddQv0+LtIJ3UJl0I7FQXOIbM9
	 90iii71ahkoUMMtBgh4nUv3Tob/WpQdjLrdZbmCeDfrZI88l22u3MO+W06HTUrSv0V
	 TtzngrTcZqdzA==
Date: Sun, 07 Sep 2025 22:12:41 +0800
Message-ID: <3fce608933f544a86400b30d38af0e8b@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.09.07
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mjGEEm269lI6"
Content-Disposition: inline


--mjGEEm269lI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.09.07 release.

Release Notes:
1) There's 1 new test case in this release -- btrfs/337.
2) btrfs/301 is changed to uncover one more known issue.
3) Behavior change, if _dmthin_init fails, it will _notrun, not _fatal.
4) Fix some test failures on the newest bash.

More fixes on btrfs and generic sides, please refer to below. Thanks for all
these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

911e9f168004 fstests: generic/733: avoid output difference due to bash's version

New commits:

Boris Burkov (1):
      [cf73c0adc635] btrfs/301: test nested squota teardown

Christoph Hellwig (3):
      [86a1a51cf62e] dmthin: _notrun when dm-thin setup fails
      [aff1e92c3f47] generic/081: don't hang when running on devices with protection information
      [fa19801cda23] generic/450: don't hang when running on devices with protection information

Filipe Manana (2):
      [6dca84887d87] generic/363: mention btrfs kernel fix for block size < page size scenario
      [bfa369f55a2b] fstests: add commit IDs for kernel fixes already merged upstream

Johannes Thumshirn (1):
      [9d618786c0d1] btrfs/237: skip test on devices with conventional zones

Nirjhar Roy (IBM) (4):
      [579a65fc0de0] btrfs/301: Make the test compatible with all the supported block sizes
      [d6506d38a3ee] generic/274: Make the pwrite block sizes and offsets to 64k
      [6ec632659993] btrfs/137: Make this test compatible with all supported block sizes
      [f5822b2bced6] generic/563: Increase the iosize to cover for btrfs higher node sizes

Ojaswin Mujoo (1):
      [8735e3e15fc7] generic/365: Fix false failure when mapping ends with free space

Qu Wenruo (3):
      [6ca32795a99e] fstests: btrfs: add a new test case to verify compressed read
      [8dd133d0763b] fstests: generic/228: do not rely on the bash core dump output
      [911e9f168004] fstests: generic/733: avoid output difference due to bash's version


Code Diffstat:

 common/dmthin         | 10 ++++----
 tests/btrfs/137       | 11 +++++----
 tests/btrfs/137.out   | 66 +++++++++++++++++++++++++--------------------------
 tests/btrfs/237       |  9 +++++--
 tests/btrfs/301       | 13 ++++++++--
 tests/btrfs/337       | 53 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/337.out   | 23 ++++++++++++++++++
 tests/generic/081     |  3 ++-
 tests/generic/211     |  2 +-
 tests/generic/228     | 28 ++++++----------------
 tests/generic/228.out |  2 +-
 tests/generic/274     |  8 +++----
 tests/generic/363     |  8 +++++--
 tests/generic/365     |  6 +++++
 tests/generic/459     |  6 +++--
 tests/generic/563     |  2 +-
 tests/generic/733     | 17 +++++++++++--
 tests/generic/733.out |  1 -
 tests/generic/771     |  2 +-
 19 files changed, 186 insertions(+), 84 deletions(-)
--
Zorro Lang
zlang@kernel.org

--mjGEEm269lI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmi9krAACgkQlNbPkfr2
tMwRTw/+OJVmFmXVwETc6VxdIGPGqI6o+168rQGZrDRtT+CQ99ulaS7LAp9gp+C6
EZ9xGKyTf8rJxTaFNRJiT+7Ke7l/QXN5821CXF3F95JARmUWbXyciWpsaqtd/DUP
rYfBKM4KDvSGU7lxjkcn1sp+bWFvfxavlUEy3DZlRJz+HAvcppvit3x0junZw2M2
ir30Yfd8GLQqb+tBl8OwFHd9OCV7xxZYzQr9hO/dRhBQNZ6BkCFRe0pCmTB3NhJx
SCKyyT7tRWgDn10bdA/6JLT7bMtHq9Do6lphGAUArLrMLFNcxtHkNR1nzyaKhS/2
kUdDwvU4n0o1JzWMXQf+wMsBFzSqr/FRzd/XY0xxo0Lg4pvnd1/Afjcibc6IzO9M
m2D8zWAleyCVIk1pubJoT+NyO//PWtWXvgE0OhtmqazuGnluL9yUcxKBXkl+548j
FqbC6SsEv4IipBtKANwmoglimjNmNBSAzy99re+beAASXu5RrXVwzfAmNo0gixlw
PAt5L2bNyBGbguOSLGBTs54DZQuzcfYAHOFHjHIZniRPCh9sAXwwbOkQYt046gdI
K6ky2zVLnobRlidl6loWDvgvnLr+6P5DjCaAArad/qY/wC7Frd/g36LICFiqaCXv
USVgHFrY2RzExB5gQKebDcDMe+za2O7kj21dgAwVuTkBDZT7Y7c=
=r1Xd
-----END PGP SIGNATURE-----

--mjGEEm269lI6--
