Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33997A55
	for <fstests@vger.kernel.org>; Sun,  3 Aug 2025 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754240707; cv=none; b=iqVUzf2E3qeY5P/BWezjm8h6YVpIUt5fQWU9TIiIKVFlqao48IIyFqquCL7CUJfYoECIQpBi+ZpScDorgb3P1sv5FF8NHoVfg4UjebRLCzb5Bv5OH73zhRPZlazKjT0VSWIKXkpH17kX7P+5ItKevqRUWrP+nx4JnGdtxJeqS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754240707; c=relaxed/simple;
	bh=cE0lwxnx3eqzmNC2z3j+G4EFe9NSe0WWinxjkwo58Gw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Jku112dO1Zn4FwtcmB0pnmbAo8TEfbyyG4BJWnjsUDEKZCTQVt7JBdFcFralsfyMaejrW5A9RwmngnNaZBIsCZGkQX1T9KWIZbinAV1LNauszZwQiwTiUTiFiLltMz9dmuH1MBkxf99/rzSiBzDq4ISdcHBcLMrH+YwVIdoxCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuU7CW5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuU7CW5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B533C4CEEB;
	Sun,  3 Aug 2025 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754240706;
	bh=cE0lwxnx3eqzmNC2z3j+G4EFe9NSe0WWinxjkwo58Gw=;
	h=Date:From:To:Subject:From;
	b=GuU7CW5mHopEmw3x6cf+h+kb+JRA2WsNMAl04oe5FO9eZgfYvBYo5o9Jtcj1dGUxl
	 veGN9Xc3vXJy0VqLl9Vhkxfltj1xirYY/mcYflaJCfPtJwjUUO3/5cp65oio5056pv
	 dZhKwOPDPfS6c8GY8y7I2HtEUdg9lQx9QylD2DAAmnu4PrsyvKs4TrEgUYEA1+REOX
	 8QHWDYctVYp1f/vtvpPzc0rmLCvlUCCvzxeQ+Rn9wUsGu9kP/XK5olZIszMMcmlqNp
	 r/+hexF+9ltMBW8/wJ9Bd/6eEBVaZr+8FmXrE/+w1fRfDNVR0zfJ6ZmiYxC6Aadven
	 eRpJ/Rn17aYgw==
Date: Mon, 04 Aug 2025 01:05:03 +0800
Message-ID: <fbf587151a610be1b48d11b892aaf7bf@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.08.04
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tpOV81gjp1Y9"
Content-Disposition: inline


--tpOV81gjp1Y9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.08.04 release.

Release Notes:
1) There's 1 new test case -- generic/771 in this release. It's a regression
   test case for a known btrfs, and *might* cause crash on old btrfs.
2) New common helpers _require_inplace_writes (and _force_inplace_writes),
   and _require_scratch_ext4_feature_enabled, welcome to use them properly.
   I think they will be helpful for others.

More fixes on xfs, btrfs and ext4 parts, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

3d57f543ae0c xfs/838: actually force usage of the realtime device

New commits:

Anthony Iliopoulos (1):
      [9f6c59e0d485] xfs/189: fix remount barrier test failure

Boris Burkov (1):
      [5dae2b3ca547] btrfs/301: enhance nested simple quotas test

Darrick J. Wong (6):
      [aa14b84a8d1a] xfs/259: try to force loop device block size
      [dca21d3724df] xfs/432: fix metadump loop device blocksize problems
      [86950a4e23c1] generic/767: require fallocate support
      [ca57558daefe] generic/767: only test the hardware atomic write unit
      [8b81cf5ce725] generic/767: allow on any atomic writes filesystem
      [3d57f543ae0c] xfs/838: actually force usage of the realtime device

Filipe Manana (2):
      [57e68bd5c6bb] generic/211: verify if the filesystem being tested supports in place writes
      [d8b702f89e01] generic: test fsync of file with 0 links and extents

Theodore Ts'o (1):
      [c8434d36096d] ext4/028: require that the scratch file system has the extent feature enabled


Code Diffstat:

 .gitignore            |   1 +
 common/atomicwrites   |   6 +++
 common/ext4           |  23 ++++++++---
 common/metadump       |  12 ++++--
 common/rc             | 108 ++++++++++++++++++++++++++++++++++++++++++++++++--
 src/Makefile          |   2 +-
 src/unlink-fsync.c    |  45 +++++++++++++++++++++
 tests/btrfs/301       |  10 ++++-
 tests/ext4/028        |   1 +
 tests/generic/211     |   9 +----
 tests/generic/563     |   2 +-
 tests/generic/767     |  19 +++++++--
 tests/generic/771     |  60 ++++++++++++++++++++++++++++
 tests/generic/771.out |   4 ++
 tests/xfs/078         |   4 +-
 tests/xfs/189         |   2 +-
 tests/xfs/259         |   2 +-
 tests/xfs/613         |   3 +-
 tests/xfs/838         |   1 +
 19 files changed, 282 insertions(+), 32 deletions(-)
--
Zorro Lang
zlang@kernel.org

--tpOV81gjp1Y9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmiPlkUACgkQlNbPkfr2
tMw0Uw/9G5aGGN4qBC4mdYww/rOuP4c86WawrBbZKKZALhXPazlJbIMUxZbiHeWS
WTts9sN8KaIcBMJy4lqu14K8T/Bhr9c5Qvf16Q+k6gIb6qSEg9tuxd9cV+GwhTbK
XRS8cR880M6H3icgVb7Y3Bf2kl2Zu+B2gGFMmJNTZooPYk8yerTfUlw2BQRHpAsl
tGg1EB/j8McMpE4peoDTuKT538bAdAbJ9PjcHxCjbRFiWnD3ZPMg959yvl24VDj9
nxgwECSSPamC7fqwIIOqM8DhF4b5W5zZH5zwHuHzte4VI7DVlrocTi4IFwq+VPWz
M4ZcRyn7rXN4dRX1jf2SJFl7Uq0dM2oAHkB7Z9FUKgEoCzioHTEOqizBX4M8ixTI
Oi0erYMRfldkGG3NOpZKDy7vfSw8L4s69ZBm+vYH5+/mxfjNqaz7NdBdVESjMK5w
b9EnvKRka61dlKek1a3A7Bega8pnbMWsNoQV/CoUNe6d9Q7KjMYd+Zo3Tw4y0QtH
BpqkO8Xxkj89Ct+Clt7yycqD5GriabZREE5RIyAumbPA3PIKyX5O1PzVygA2+gRB
NggmZZqkBRieTTxaI06C1ufJbkku+e/Wa30n/aPMaL8qFUSkiArnpUdP3CzcCepg
qADWyVCgqub+IncjkK+afwEJgVLPi8KAG96ld358t8MsXblXeZ0=
=chlZ
-----END PGP SIGNATURE-----

--tpOV81gjp1Y9--
