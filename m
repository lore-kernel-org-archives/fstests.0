Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10DA2BE621
	for <fstests@vger.kernel.org>; Sat, 20 Jun 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975256; cv=none; b=lOXXp6lF6THqqNS33CWB7yOHOD8wtZ5QSbXeITMlijOFGuyikRVCQYI0daPSbplcsZ8txk9U+AJ/D1FUHgGe2BoHLvD68iPuIbtCVmG3x1nP50TLSJbFgAAi8aevRvpE38qRt52SHmJlF3dEuh8PHRrWVG1XCBTEIf6ASM+LkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975256; c=relaxed/simple;
	bh=CDYntvtFmSJRBMDlEc8myWb96c/DKcbdaeYYz3zvfTI=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=YZkTYnNyNluDpXWAd2KA+RG+vdfYCfLzqz6BUTDWmGd2fCxwe7TdVvKJnyEdrQR1lh1pAyf0s97bGUmRwzjh5Q9W2dASko1xL3GJ4K6/3+VkwMRPiQFVJB0qubAQY6sqPmGmSK+px4yA5+6o2qLQ2WlosfcZqltr8Uy9XbJgGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icVcvXhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icVcvXhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFF31F000E9
	for <fstests@vger.kernel.org>; Sat, 20 Jun 2026 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975254;
	bh=KqkWpSqBWJ+9K1fLBUtHnNghzh9xDRhXzaTtOiIpjbs=;
	h=Date:From:To:Subject;
	b=icVcvXhzuvEUOITH+I+XtNvCeYTb+4kTZ801pr1aOqfj0zt/UdDSg7qF1h6poSEO1
	 bksxU46nlq00RT5wz+h1sVGcYiOTU/abkK3FFgf25JbBBESGe5NzPXqvg5RzXY5+vV
	 jdTaDKR24yPYuQUQ01rpuZPIqvDoOsQZG8LctxzVoGFzZXHTlOg5kke0+hlUOVdK8l
	 S22PmYOgS8aSFAWrZfuRzdBUbmTNT2X7ASxCpe25MGxHw4VL23rCAMBljqOpv33zms
	 Qj4yE2OyUpkSEHfY8Zfj+SeNipOCgb2L1unpXZJIkLfecGF6k5qIlgoSwsO6eBM13f
	 +4tOeurIkN1+g==
Date: Sun, 21 Jun 2026 01:07:27 +0800
Message-ID: <ec3eb5b44299cc027effab62d9d1f572@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.06.21
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="1T0fFWOVGiVO"
Content-Disposition: inline

--1T0fFWOVGiVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.06.21 release.

Release Notes:
1) There're 9 new cases in this release, include generic/795, generic/796,
   generic/797, btrfs/348, btrfs/349, btrfs/350, f2fs/025 xfs/333, xfs/670
   and f2fs/025.
   Note: The new btrfs/350 triggers a kernel panic on unpatched kernels.
2) All f2fs shutdown operations have been unified to use the _scratch_shutdown
   helper.
3) Exclude HFS from atime testing
4) Skips defrag tests on DAX-enabled ext4
5) Zoned realtime XFS testing is enhanced.

More updates and fixes refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

acb6d4cb8420 common/defrag: skip defrag tests on DAX-enabled filesystems

New commits:

Andrey Albershteyn (1):
      [c1dcfe62b3f9] generic/791: don't run if kernel misses FANOTIFY

Boris Burkov (2):
      [d65330dd7de4] btrfs: inline enable_quota helper in test 301
      [26c2b701724a] btrfs: test qgroup deletion races with squota writes

Chao Yu (2):
      [4f599bae27e4] f2fs/025: test to do sanity check section type correctly in f2fs GC
      [88b140d74b3e] f2fs/009: use common _scratch_shutdown helper

Christoph Hellwig (4):
      [ce4e96a89a2b] generic: add a test that stresses metadata eviction
      [1104c45b26d0] common: add a _require_external_realtime_device helper
      [120ff814a4c9] xfs: test that a grown RT section can be filled
      [26eb955e4243] generic/366: check minimum dio size correctly

Disha Goel (1):
      [acb6d4cb8420] common/defrag: skip defrag tests on DAX-enabled filesystems

Filipe Manana (2):
      [32b4dfffbc08] generic: add a test case for fallocate i_size extension
      [973512e9c240] generic: add a test case for writes with prealloc extents beyond i_size

Jan Prusakowski (1):
      [d66e76fc5ab6] generic/563: allow read tolerance for f2fs in scenario 3

Joanne Chang (3):
      [55d8071bc4a8] f2fs/015: Fix mount syntax for disabling jquota
      [c5ddd1789ae1] f2fs/021: Fix mount syntax for disabling jquota
      [65caee6192ce] generic/63{4,5}: Modify criteria for passing test

Qu Wenruo (5):
      [748ae5ab4076] btrfs/340: add support for older kernels/progs
      [1418baaef1fa] fstests: btrfs: add a new test case for single data RAID56
      [239cc1d59866] fstests: cleanup old files to respect mount options needing new inodes
      [80d250af40ca] fstests: btrfs: add a new test case for fstrim crash
      [ace8d9c9dee5] fstests: btrfs/138: add requirement for datacsum

Shin'ichiro Kawasaki (2):
      [5d68212a7373] common/filestreams: check zoned device before mkfs with small dsize
      [6c5d1992fb3b] xfs/013: fix ENOSPC handling

Viacheslav Dubeyko (1):
      [d5fb5bbbd22d] common/rc: exclude HFS from atime testing

Yao Sang (1):
      [ec6d49da5d27] xfs: test zoned realtime writeback EIO shutdown


Code Diffstat:

 common/defrag         |   2 +
 common/filestreams    |  13 +++--
 common/rc             |  20 +++++---
 src/fs-monitor.c      |  19 ++++++-
 tests/btrfs/138       |   1 +
 tests/btrfs/301       |  14 +-----
 tests/btrfs/340       |   8 ++-
 tests/btrfs/348       |  68 +++++++++++++++++++++++++
 tests/btrfs/348.out   |   2 +
 tests/btrfs/349       | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/349.out   |  10 ++++
 tests/btrfs/350       |  39 +++++++++++++++
 tests/btrfs/350.out   |   2 +
 tests/f2fs/009        |   3 +-
 tests/f2fs/015        |  13 +++--
 tests/f2fs/015.out    |   6 +--
 tests/f2fs/021        |   4 +-
 tests/f2fs/025        |  82 ++++++++++++++++++++++++++++++
 tests/f2fs/025.out    |   2 +
 tests/generic/362     |   7 +++
 tests/generic/364     |   7 +++
 tests/generic/366     |  14 +++++-
 tests/generic/418     |   7 +++
 tests/generic/563     |   5 +-
 tests/generic/634     |   4 +-
 tests/generic/635     |   4 +-
 tests/generic/708     |   7 +++
 tests/generic/791     |   3 ++
 tests/generic/795     | 108 +++++++++++++++++++++++++++++++++++++++
 tests/generic/795.out |   2 +
 tests/generic/796     |  52 +++++++++++++++++++
 tests/generic/796.out |   5 ++
 tests/generic/797     |  54 ++++++++++++++++++++
 tests/generic/797.out |  10 ++++
 tests/xfs/013         |   4 +-
 tests/xfs/333         |  66 ++++++++++++++++++++++++
 tests/xfs/333.out     |   2 +
 tests/xfs/670         |  58 +++++++++++++++++++++
 tests/xfs/670.out     |   3 ++
 39 files changed, 822 insertions(+), 44 deletions(-)
--
Zorro Lang
zlang@kernel.org

--1T0fFWOVGiVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmo2yG0ACgkQlNbPkfr2
tMwo4xAAwR6rHjqdv/ddHUpiM1sf1soPYk61xQCcV6diSN5tK3c4wlg9SQ+yN1PJ
N9nPoO9I3VZhF7bmFspYQPXiA7EuH1zSgR/MdRkg4X0InAsBQijy5UupjU091E6N
nl7ywDQAhE4Jc9q05+6O8GNquEnEOhwHlc7AVb+dfYBPMo/FfLJFOwr5zHS+A0cY
v1bYA3KAgfhXiaJcdr6w8N3SK1+np/95ijWxh2dBSdLRe28PsoExGQNUmrHxWpnk
lAtz39qEXaCUA3RozsHqbDGV26fxtzrjJWiohfye3rhQirfDssoC9nm23RX3u+Ol
9VN2TdxiGpGU9xZf/yI4gj9JTmfQRN/W4gT2X1h1A+Av175zAVQcuSfsVQVVT6vY
00naVXXosBnqMSIcwVbohW7h4YZO6Kjw6RsrenN/E8iB1I08vAEbpHUBz3vngFro
gVgtPlqNxp6/w+kO/T5KczQ017+yd0hzGT9xDdSv03QFLdE3GG3Wtae0mI1ZbjNP
32CtNbOJ91edoEufW7ItWUXKipdMN+QkxVZ6qfgPBNalTOTaNYPh3TPs2Y9q/k1b
UfrB8kgGqGnX091s8qqpViaWKYKVHzfqw8tSMakDvnKFZ0lP2BRimLzNGkyqhYbe
bFWxkHSo8vaQ8jIjzIBClBUtXsc38f66eVsFpqT8GPVZVm71YLA=
=KDf+
-----END PGP SIGNATURE-----

--1T0fFWOVGiVO--
