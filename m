Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A72566F7
	for <fstests@vger.kernel.org>; Sun, 19 Apr 2026 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617378; cv=none; b=eHW1ImvdVGJGrdngqT0zJ1S9gaeGayvrsrR23hSI0Ez2y11afNQ+cbhcbF1w+DkBXrQm48mPbKR49He6ZpHEKtU7Nv/bgQjgyYQoCxggdESPVslV2YPExDwRfgbaqMiZy2FDd828aY5vU4k5HuUp6wmF0qdMaRw6sV2LV0lT8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617378; c=relaxed/simple;
	bh=wQga6NlDna0VmwBngVrm+AMO9YNlusDINEerfuM1YLY=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=bfpYakWAnTO439mvd04eByFKMzW5DEI26UVFVdL+AXzPcBp784PK7zldnL9LHOeA6XhkI4Zev9k6S56li2s8PfJvmuvSvQeQkMORG+fUuJGZkDku/v+bKARaFqT1wI9nIfty/WjxohefG32SJuqCvEv5vesB7bXgzwnU9eu2FAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMig1Fxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMig1Fxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC383C2BCAF;
	Sun, 19 Apr 2026 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776617378;
	bh=wQga6NlDna0VmwBngVrm+AMO9YNlusDINEerfuM1YLY=;
	h=Date:From:To:Subject:From;
	b=cMig1FxjuSKdnzJYnThNRkKKla0+tzvG4Kb4CYTt3scehBhtWfe2kQJlJW6GMV2g6
	 6LM/k3ny6aVFYnfAtFg0RUh3P700h/GYhN5qB6uR/+bwjYfRItVLvLVMoE1yNSWdql
	 d6+gA53wPpfjWyZsypxmFXzKdGWyHxQcpmEwbb9Oyl3j9D2NJuQJZFTCL46qL5Rb15
	 D/9GwN/BeZMJvv3mJ681nrL1FHk5LZoqLaZLvVr7hB5OWInkDsrGebjcliXO/YYdiq
	 MM/HNCnkIxrb42qaDfcRoLV5Xn2PYnXIbtfsXfhy3jKWYK/vMQdDl39y33R7oXz/cB
	 McXMfjLuwh0yw==
Date: Mon, 20 Apr 2026 00:49:32 +0800
Message-ID: <bc0bc8bc447a8eb8dd0ef53c657e7906@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.04.20
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vgcRDo9pqS98"
Content-Disposition: inline


--vgcRDo9pqS98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.04.20 release.

Release Notes:
1) There're 5 new cases in this release.
2) g/792, g/793 and f2fs/024 provide coverage for known btrfs and f2fs
   regressions. x/668 and x/669 are new zoned related tests on XFS.
3) Fix and refactor atomic write test cases.

More ext4, xfs, btrfs, f2fs related fixes and updates refer to below, thanks
for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--vgcRDo9pqS98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmnlB3MACgkQlNbPkfr2
tMx6ww//VCOVTJCxICg+maGWpS/A0jm03LNqUUuQkAfyOuruJ/HdvTCeW3JG5mHZ
pgfq2/tBf/5h97KcmsFanKV9F4ASzxzNVNukX8vugb879HyX7QPNXENZ65eDh4sB
lSPH33f6KFwi1tWsSQDqs8D7QnPMpx8DBpY2up9KvxB9oNQ7eu5CGhc8+a4OJxFe
s4/oDf1igutre38FHyfvmqUT5qkG7Z4EJqGmFoT138PH7NX6vo3FH/kKq/JdJywW
NQj26ZzQKcTFMcJDJVTaAOFYQGrD33NtbXHil/VvxjksPBpp9bJ5pFF49YfVIz3a
sDLwWdyaEYTRzervCdqWupBLJuS8UQkuxTTr5can28PQbt0VFfuXBCOkzAOEWVMc
bmu/RSgjpuPi7KKLysvgUYCQwueAUtqV7zDZdBJuVlMpsMd4KZrAlFnC7+igdJ2d
ip0zCUkiQ0cenq1Sgcohz2QVhPxiw9+Rus0DEMFa1E4cYAf3Kfxc+d7l7xk8QVel
gcc5xH425JipL7RLakd5Q4rRU4EW4LlNzhUX/46I18tqBNzjjr+kK/0IlbuML5I+
eGZJxuNlk+2KSuQ4ug3oP/3etFI/Ye2cI2jLcnDF+XuoIuAGZJGSLPDotc8NVdYw
vPXWrhG7D/PwTiytgz5u5eJcCeHCQqcl/y+LEHQbKxNTmTTUShk=
=NizU
-----END PGP SIGNATURE-----

--vgcRDo9pqS98--
