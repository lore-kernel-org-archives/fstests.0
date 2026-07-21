Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0C3BADB2
	for <fstests@vger.kernel.org>; Tue, 21 Jul 2026 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622804; cv=none; b=YgWv4DEWsu+JcicaIh0RFzjGEE0/dFacinE463tuswY61sSB/tvPpH+Ndy6RnD1DcH5aSTt/UuTp+6QNVrP0y5gFuHIRlIc6CjEORVzjn/4WX/WIv6MWPiBaaVsWGCvmNuYCU1S4gqaIYB4oVVmEf3gp9RmQrWMDxvDmpjQU/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622804; c=relaxed/simple;
	bh=C2TR7QZjMCPzr/lXcFSICxJA7+AANydMQ/K9zb8auLE=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=uVROrqwGeV/p6vXn+OdHI/ZADtnzqPymwY51mpjjdlE68qGBOQ2ZhimMo2hT69SYXVPq38AWd9+AjXCKMt210GLmxktLowUmMkXYTxH15UFEsaU/O8MM7Umz83v1vG4a8Q9ve8p1mcKfZURCUefzSYIk5rIH60RKwvAA0aQfTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGcUyx+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGcUyx+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765511F00A3A
	for <fstests@vger.kernel.org>; Tue, 21 Jul 2026 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784622803;
	bh=ylm9wlyJ+1dm3BpgXDrmMGNw9AIv+ZpYHwdcjKJ0Wm4=;
	h=Date:From:To:Subject;
	b=dGcUyx+reWNk/C0u0i9+Yw8TkzERLWvThSg3L6oUh5FEQ7XUc6FROWR6P6vKT4dfR
	 T+Zzxm5h+y7u5vzv90n+W3MaAtdMwtzQGqHWKuvH/Ym6XFHdecapXnIqHgQ+z9Dgoy
	 HkjL53RQvJOLgNSTdtWTPkj+h+hNCmufxcVq/Ah2a1k3SchfN3gUA7nJ8k24rTQU7+
	 kqgatbHuL5u0QSb339/N4vW6XpdDISvjmBpajh0UalPEvZy/dGcJia1kGFXS+s7oQu
	 tcdOGvQUaYE8disIDht3NbYeFutwCRxj7g637OMZN00tY25ueu5L8VOhmDAlDvrXMB
	 +kg3MVJFHS2/g==
Date: Tue, 21 Jul 2026 16:33:18 +0800
Message-ID: <6562bac89ba8a61d6cb92f360a0dbec7@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.06.21 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="v5CH4hLhj7yo"
Content-Disposition: inline

--v5CH4hLhj7yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.06.21 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--v5CH4hLhj7yo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmpfLr4ACgkQlNbPkfr2
tMyrXA//QozHLFnJCsa6dFLz3J5OL37WzcjWSBZ+3Osmt0S6EYbdQeQ2nZaKGxnf
xsH+JdwowrDFpIDgU+HW+niL6rKKUpUeJsM42uySBVngvNHvcNj1jxmLnHQRX5bI
zqNIJld6RqtRtosAnWY7cwMTz6UZ1+mqzNxPdw2sgmQvVtc2iA2Ndm6+tKIiOKrj
vqBSZgL/6xWfH/+k3/jnKM31osLBSyoZpjd0TfAa+n9RXv7dWF6ZFAIF8Zr35lxi
A9YPlvz40H+4gqjOmFrwbUODd2Qt7jYJQFIN4kh09jmBWA7D8+YC9EQmE6YF23o+
lDDpjwEXwq9OofSnNpmIjYzQnD7VUEOAh3xgc+fb4J7LaA7s2GoGxr3HOK+SxzhQ
gPR7kSt23PAia26suYxBe5G1Zt3Xt3UPbqdlaDBlhB9wf5jRY1cfFvSFgaiS74PJ
QdNw6UMe7FIRroL3GwCub6d9CGy0M6S9qTyLFhzQQWUsXkQALidkh5Cy/4bh8Won
zdt32GgyY89C4YwByzPUOm61G8UqrjTCR3p9GC0VIWsyLsUrKUJL0OoWKqjz+mgs
7WuOsfsxTbf011tG1gr826m2HQatpvlS2qv2O1bnsPdAmheDlZSS2Re8HrsU3H06
VQ9biHxhsS1ZDwJJ3PxP+T/2Y0jFcyWJdV1NhUNvvjyqGwCOMPw=
=a390
-----END PGP SIGNATURE-----

--v5CH4hLhj7yo--
