Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7D19046E
	for <fstests@vger.kernel.org>; Sat, 20 Jun 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973461; cv=none; b=hbXj5sZ6DQB/1TSpJa8U7PRfWd2EfFJcJX3iojLxmYFEn9dw0ANm4xidNT0rhy1KFBZYOWa057uldMPy9oaHbd6iFoZM4oKINz4CjfvX2JLl0ZgwZ/oMLtMMhFRmsN+igUulSGGl9V1+ZcIw4oru12hFm48UQbS03rjRN73NdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973461; c=relaxed/simple;
	bh=rZlMT4Jzv4mdGNLVGQTkJl+s98yRmWnsZ+ScEd8GlvU=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=hz42Rmefg9jTcXbiD1HD9DUufy2LUPRaJRuFxCok5apPMjYwvr4gzyz7oot3Kg28sKHtSBbplHO5RdjX+7jub+HNBMn+ZO5CdRS+zYULFUUPpScJ7qkPs1eYXDJ2bzbhK4LzJNM5c/tJiJXjARd7HpPo1pg8BxS4wwZ0emTUsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpxmooaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpxmooaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290D91F000E9
	for <fstests@vger.kernel.org>; Sat, 20 Jun 2026 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781973460;
	bh=QgPEzCYxqgfM5nFTjgxQ86Gb4xytDYuQCnBJo7kykM8=;
	h=Date:From:To:Subject;
	b=CpxmooaDGJ7yK+bYkxtVUlhhAW1UyJp7MZu17gw/CuTvNHrO60mfvtOePH9bIvh18
	 Wck9/ZljNgdagPPHjkwekScohxhdqLl0TyoVaN+Vqee8Oa8CMa81EUmzsjA4VxnTzr
	 YXXYh+w0ab9Io63Ky9baK2zZajoeMYLYiXkKOxXCrk2tu1O2tcSaSxxJV2JKsSZseg
	 dYGvUlpx36Q49fuyfduMfAx+ySkUfQF31vBDWVKHy7acQ8gNTZtLzFa4/3w+Y4j3Bk
	 sCXTKIYU549VsXPiqzs5SC3k3nuhthh5wxnDUS3DvEmFH/K4b3hoLxUsPZUirnZS5t
	 tVQJdpl7//bBw==
Date: Sun, 21 Jun 2026 00:37:34 +0800
Message-ID: <28d7fdb6a5b309dbcb71e36401473145@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.05.17 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="S4AcRqFQcDOn"
Content-Disposition: inline

--S4AcRqFQcDOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.05.17 version.

Thanks,
Zorro

The new head of the master branch is commit:

ffc8bad17e5b xfs/21{6,7} Use default -l concurrency=0 on mkfs.xfs that supports it

New commits:

Christian Brauner (1):
      [8c69a37c4f4c] vfs: fix dumpable race in create_userns_hierarchy()

Christoph Hellwig (1):
      [12c729c1a296] xfs/216: pass -t xfs to _mount

Darrick J. Wong (4):
      [078f3204e049] treewide: convert all $MOUNT_PROG to _mount
      [832a6d9ac226] check: capture dmesg of mount failures if test fails
      [f61ba0fde3ec] generic/45[34]: add detection of confusable variation sequences
      [cdd9140a2f78] generic/45[34]: don't warn on mixed bidirectional characters

David Disseldorp (1):
      [4192c9e2266c] common/rc: add default _udev_wait timeout

Disha Goel (2):
      [a974318c5bfa] common/dmlogwrites: add _require_log_writes_sized helper
      [3aca6733f6cd] btrfs/291: fix state transition logic and add size requirement

Filipe Manana (1):
      [528c7ba2a275] fstests: add commit IDs for kernel fixes already merged

Joanne Chang (1):
      [b8bcadc36c36] f2fs/{022,023}: clear MOUNT_OPTIONS alongside MKFS_OPTIONS

Johannes Thumshirn (1):
      [d9b1d9c6f43e] generic/793: limit number of overwrites

Lukas Herbolt (4):
      [55f45a620c55] common/rc: Add helper to calculate percentage of free space available
      [7f162f5bcf50] common/xfs: helper function to check if -l/-d/-r concurrecy flags.
      [393a4e58584d] generic/{102,172,347}: Adapt test for XFS on systems with 128+CPUs + SSDs
      [ffc8bad17e5b] xfs/21{6,7} Use default -l concurrency=0 on mkfs.xfs that supports it

Ojaswin Mujoo (1):
      [0d6ed520323d] ext4/307: Calculate donor size to avoid failures for 64k bs

Qu Wenruo (1):
      [8413f58d843f] fstests: support new mkfs.btrfs help string

Zhang Yi (1):
      [95155ec233fa] generic: test post-EOF gap zeroing persistence

Zorro Lang (1):
      [55e172c4c914] xfs/227: fix bad variable expansion


Code Diffstat:

 check                  |  20 +++++-
 common/btrfs           |   4 +-
 common/config          |   2 +-
 common/dmdelay         |   2 +-
 common/dmerror         |   2 +-
 common/dmlogwrites     |  18 +++++-
 common/overlay         |   6 +-
 common/rc              |  31 ++++++++-
 common/report          |   8 +++
 common/xfs             |   9 +++
 doc/xunit.xsd          |  12 +++-
 src/vfs/utils.c        |  20 ++++++
 tests/btrfs/012        |   6 +-
 tests/btrfs/075        |   2 +-
 tests/btrfs/089        |   2 +-
 tests/btrfs/136        |   4 +-
 tests/btrfs/208        |   2 +-
 tests/btrfs/291        |  19 ++++--
 tests/btrfs/330        |   2 +-
 tests/btrfs/335        |   2 +-
 tests/btrfs/343        |   2 +-
 tests/btrfs/344        |   4 +-
 tests/ext4/032         |   2 +-
 tests/ext4/307         |  18 ++++--
 tests/f2fs/022         |   1 +
 tests/f2fs/023         |   1 +
 tests/generic/067      |   4 +-
 tests/generic/089      |   2 +-
 tests/generic/102      |   5 +-
 tests/generic/102.out  |  20 +++---
 tests/generic/120      |   2 +-
 tests/generic/172      |   8 +--
 tests/generic/306      |   2 +-
 tests/generic/347      |   9 ++-
 tests/generic/361      |   2 +-
 tests/generic/373      |   2 +-
 tests/generic/374      |   2 +-
 tests/generic/395      |   4 +-
 tests/generic/409      |   6 +-
 tests/generic/410      |   8 +--
 tests/generic/411      |   8 +--
 tests/generic/453      |  45 +++++++++++++
 tests/generic/454      |  46 ++++++++++++++
 tests/generic/504      |   4 +-
 tests/generic/589      |   8 +--
 tests/generic/631      |   2 +-
 tests/generic/717      |   2 +-
 tests/generic/792      |   2 +-
 tests/generic/793      |   9 ++-
 tests/generic/794      | 168 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/794.out  |   4 ++
 tests/overlay/005      |   4 +-
 tests/overlay/025      |   2 +-
 tests/overlay/062      |   2 +-
 tests/overlay/083      |   6 +-
 tests/overlay/086      |  12 ++--
 tests/selftest/008     |  22 +++++++
 tests/selftest/008.out |   1 +
 tests/xfs/044          |   2 +-
 tests/xfs/049          |   8 +--
 tests/xfs/149          |   4 +-
 tests/xfs/206          |   2 +-
 tests/xfs/216          |   8 ++-
 tests/xfs/217          |   7 ++-
 tests/xfs/227          |   6 +-
 tests/xfs/250          |   2 +-
 tests/xfs/289          |   4 +-
 tests/xfs/300          |   2 +-
 tests/xfs/507          |   2 +-
 tests/xfs/544          |   2 +-
 70 files changed, 553 insertions(+), 120 deletions(-)
--
Zorro Lang
zlang@kernel.org

--S4AcRqFQcDOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmo2waAACgkQlNbPkfr2
tMyRIw//X97N5iFnEngjUyq1FGJuXIMQTk2PnHXFoITx6OsvDbJQoKXWj5jsgOV2
b56Ocmhl2h1s0y7/QXSSkLaEK5yhKh+EcViRMvmZTFfN1VjTrnZEec7BtuRIZQQU
iFrogL6MZ7jnx9vEBOH6D88+p5FXkdGQwGHWSxFwn2TjhakhnH9lgbigb+2tRp0a
tC4WPywWKBu6FEXFY+puTWshnXeXBh7g+Og7I3D6xL39v+EFYMCgzI57aBG6XuG9
w4klNwAxEvL61dmhVThNimZ5a/ZErUTEz7yhcio65WO8QRBHcI0zjfs5BFJL6bmX
dctCruVWBbgLVMR4v8FzNApBn2HYgQevVfZWddlSAfr2WtvcXEhcg6MNpzif7cVF
7Nd29J6v57lZ4KSnHN+4MGiClURINAQdrRXgQyw6vS6XspPfQabbrv3IASdphQgz
zVJ6Ow2YaV6Ck7hOqE5KrMaXtPypunrOpJNpq8RLJZxri+BfwErGmJEFBFnemAtP
VuTvSNpdhqt9z/iguNdqlIwB7iQKW2ZlZ+BkJ3gXUErlnu4TIGUJ8UVjvqx0nExl
8Ml9WjfSSkpdj3R89eIlTYYhKvWxwXkVQdwzjpKE+5cJW0UtetR+yd47o0Wi1cWm
6EM+z5Q15KQuS4em0zH/LRoF1i7DEHWKW6DkoA/0I3oidRD9mXI=
=UO+Q
-----END PGP SIGNATURE-----

--S4AcRqFQcDOn--
