Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884E3E51F8
	for <fstests@vger.kernel.org>; Sat, 16 May 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778950745; cv=none; b=Or9hsyE+yY1a+QJSGI3r6a/aJN391W+ziKyPbyxx5U8r0eToreofuClz1Jz7e8uN9i1XJZBJYmzUlpdhRb0/9FFnn/ODpzRTsBJqQbYS4ibQp44/aL6E+5BaAnFcB3zu+UGOlh+OGBFo8rY2udFR8eKLPb0IprCQ6Lko+v27wys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778950745; c=relaxed/simple;
	bh=AAK4rE8IRJWq8HznxfrSoJbOuua+Jk7jU2Jh8ZTwal4=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=uXCzFbkDV7PvISqGIA0/N4WqNa8IeO5aJWnlJTQ3zzOM1tBF0xl5m+1cYC0v3hyHY5Sirv/wRVoWRmEGIuMffQ33jtmlnggCG/PyC8NYUCpDRjKtSoTUdYX1qT+qZz5TY9T4vAKVqqyVvr6fNUROjNax1fvBB/eSIh1GnWGDpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nedQRLmi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nedQRLmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93FCC19425;
	Sat, 16 May 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778950744;
	bh=AAK4rE8IRJWq8HznxfrSoJbOuua+Jk7jU2Jh8ZTwal4=;
	h=Date:From:To:Subject:From;
	b=nedQRLmia/qvQxUv2Z/2Hk2zIWuU71qGpjawxZYS9TMyTI5Gfw2QESs3rsfrt2RFU
	 mLwaW2/oDH69yv+BEMq7hLmvhNIFg+jc0l0ThEOSNDl7fYDy+fT4DjFjloK9kn21ju
	 TD0FgsuaI2mUvBIdRvy0X0k0K5dWUJ3IIN5NqgH8BA2LWMJFc+KOcuGqdty8aFDRhN
	 aMxffd7Y8DoRDPQ8ciSpZBjYRgHQQZWtzYStVOwAJnIwbjsm+P68A91jY2rZVA6EBw
	 ZkZevjH4djkqEy1y/AxvDfsrkpBrF9UcomNQkgvs8YFIPXeUw+7+mOC8hMCRZfF6vJ
	 NJMAmJ3XWj1LA==
Date: Sun, 17 May 2026 00:58:55 +0800
Message-ID: <67d62a761193724de52de145edc71d22@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.04.20 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DmMDkARAaXim"
Content-Disposition: inline


--DmMDkARAaXim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.04.20 version.

Thanks,
Zorro

The new head of the master branch is commit:

cac9fe2b8dc3 generic: test premature ENOSPC in zoned garbage collection

New commits:

Christoph Hellwig (1):
      [d59865ddf8e4] xfs: add a test for number of open zones on conventional devices

Darrick J. Wong (4):
      [04ee3a4f0d19] common: ignore stderr for the two new svcname helpers
      [78b8a11f8c2f] xfs/6{59-61}: force xfs_healer to run
      [c17136d0c6c4] xfs/805: adjust for new autofsck fsproperty defaults
      [dde983e4419a] xfs/841: actually compare the new filesystem contents to the proto dir

Disha Goel (1):
      [0bece2e05be1] generic/730: skip test if DAX mount option is enabled

Filipe Manana (2):
      [c34c06b9728c] fstests: add kernel commit IDs for patches already merged upstream
      [c4e03688706d] generic: test fsync against a removed directory

Hans Holmberg (2):
      [7a2fe2c2f7be] xfs/647: turn rt dev block device lookup into a common helper
      [8deafb5c487e] xfs: test that zone_gc_low_space writes start gc for rw fses

Jan Prusakowski (1):
      [56b35283cf8e] generic/050: handle f2fs as nojournal filesystem

Johannes Thumshirn (1):
      [cac9fe2b8dc3] generic: test premature ENOSPC in zoned garbage collection

Leo Martins (2):
      [a44a26f93b05] generic/301: skip extent count check on btrfs
      [2d614deaed29] btrfs: fix stale errno check in btrfs_encoded_read/write helpers

Long Li (1):
      [29dbf0703917] xfs/018: test log attr replay with zero-length attr value

Ojaswin Mujoo (6):
      [ea4d04e7b676] ext4/061,062: Minor fixes and refactoring
      [2c002c3a86c0] common/rc: Add _sysfs_queue_path helper with partition support
      [4dc8a079a670] generic/765: Fix sysfs queue path for nvme partitions
      [fb11f06d9026] generic/765: Ignore mkfs warning
      [53e68c2afbb9] generic/775: Fix an infinite loop due to variable name clash
      [f3e91c87aa9f] treewide: Use _sysfs_queue_path helper in all queue access locations

Yangyang Zang (2):
      [271d7a1257f7] common/config: export F2FS_RESIZE_PROG
      [39b31fe6e746] f2fs: add testcase to check resize corrupting root inode


Code Diffstat:

 common/config             |  1 +
 common/encrypt            |  7 ++---
 common/rc                 | 36 +++++++++++++++++++++---
 common/report             | 20 +++++++------
 common/xfs                | 30 +++++++++++++++++++-
 common/zoned              |  5 ++--
 src/btrfs_encoded_read.c  |  1 +
 src/btrfs_encoded_write.c |  1 +
 src/unlink-fsync.c        | 39 +++++++++++++++++++------
 tests/btrfs/076           | 11 +++++---
 tests/btrfs/237           |  5 ++--
 tests/btrfs/273           |  4 ++-
 tests/btrfs/283           |  4 ++-
 tests/btrfs/340           |  2 +-
 tests/btrfs/345           |  2 +-
 tests/btrfs/346           |  2 +-
 tests/btrfs/347           |  2 +-
 tests/ext4/061            | 28 ++++++++++++------
 tests/ext4/062            | 26 ++++++++++++-----
 tests/f2fs/024            | 39 +++++++++++++++++++++++++
 tests/f2fs/024.out        |  7 +++++
 tests/generic/050         | 12 ++++++++
 tests/generic/301         |  8 +++++-
 tests/generic/730         |  3 ++
 tests/generic/762         |  2 +-
 tests/generic/765         | 12 ++++----
 tests/generic/775         |  3 +-
 tests/generic/789         |  2 +-
 tests/generic/790         |  2 +-
 tests/generic/792         | 69 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/792.out     | 10 +++++++
 tests/generic/793         | 53 ++++++++++++++++++++++++++++++++++
 tests/generic/793.out     |  2 ++
 tests/xfs/018             | 26 ++++++++++++++---
 tests/xfs/018.out         | 20 +++++++++++++
 tests/xfs/647             | 10 +------
 tests/xfs/659             |  3 ++
 tests/xfs/660             |  3 ++
 tests/xfs/661             |  4 +++
 tests/xfs/668             | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/668.out         |  2 ++
 tests/xfs/669             | 68 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/669.out         |  1 +
 tests/xfs/805             |  7 +----
 tests/xfs/805.out         |  1 -
 tests/xfs/841             | 25 +++++++++++++++-
 46 files changed, 604 insertions(+), 88 deletions(-)
--
Zorro Lang
zlang@kernel.org

--DmMDkARAaXim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmoIn+YACgkQlNbPkfr2
tMzpRg/9HK4AQtn1t6Yx7NFiGA6Y56HWhghEJMWZQQL62sHOzIonj1Z2gcEqDEFM
lgzSlZ0WMMWGq0YiUgmJh8AUsXJVH11mFtr9iqoSqM7I9sk+vqC2Hl+uInL4234C
J20jSQwoQhVEdQTYGDxVTswKvQ+TyMuGnpMdc0+PrnB68wVDzgYseoiXtrRKAA+p
cxcAmZBMNmcQZHNGzOCIvvjXaY6WwysFPXUWRqaFHPy/icbMgepw7uCQyd4i19Qa
Jhuv4RZU0c1gpGODdNou9AcF014ae8pEA52+ZveQWfjiQqDrB2IpRRQtn7MoclQp
aZvMmd5hpfjlRR0PyuqX5lseJdMjNJZEPybzN2uiemIwwrtz03WqzSoyyREHx7JN
dqS/HOufU8FrXFz4KnN0heIlHA7Gq8Ufbr5PnNbq3AB22/KaUYgwX+25Yc+Ah4Qf
TWObKzYizlTEgYzbureZugVfQwl5hjU9FYbHt/z4U88jvC2zBP4FVxr4Iokl3kKm
TQ7keXIWaEhsj6HBDiZWlLTE5yXqdq02DkRzTQrKHruHyOgqQy/+8HxVaaUaj+8H
BoTcFXG7MKeGhsuK9qWXMhF+VgcXqHo/GvR5tta1VVpoGtcr1yrOjhp4wPnqAb2i
a7rkdJeNJOGLiX+UBflaNFPXjSqweGHxRMBxkYNR4WlRWGQR3eQ=
=cdIl
-----END PGP SIGNATURE-----

--DmMDkARAaXim--
