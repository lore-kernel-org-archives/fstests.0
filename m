Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681A1B4F3E
	for <fstests@vger.kernel.org>; Sun, 12 Jan 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736691645; cv=none; b=TPM4MUbAe5nvFc+Kgfk5GkJ1ei1iQv91P3fmfrOos6cu5LyIaJyJNgAJQEygifdAiGOf/qnwK1QdjscE08E5hgrmglgziHs+HGQkqKLnptDwX1y7MqXahvwQwX7pcEr7ur+fOxgisXBtp6pELm2JLOpwmS1c5TDwqdYYdNPoyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736691645; c=relaxed/simple;
	bh=HsIZO8XMGVBDw/BvItqACYPZs66Hd1i4LuicJB3MmAI=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=HbkKS8JxMc9y1t6l8JpHHd5xChjhGnMxK+UKAblyn+FXFF3tNxUu9UFSafy0PWZV/eUutK6qFT73JN2RJz3lZzF8t9+0FuucLBRojBAqXmkzX9ycsJ7oFfi2QjrCWtJKJq701z3ri13aCmHRfQMgRz45E0RXnP7V8h/wWSoTYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYYgGkGA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYYgGkGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB0CC4CEDF;
	Sun, 12 Jan 2025 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736691644;
	bh=HsIZO8XMGVBDw/BvItqACYPZs66Hd1i4LuicJB3MmAI=;
	h=Date:From:To:Subject:From;
	b=uYYgGkGA8SXtwADYs1ECsfW8cwHNhR8ZEyOA5Or5kOARafR3S7y6dkwamSRWwTy7f
	 u+13C4qXDlcca1qqH/R4ILrEGAKhk2gc4T2947+lZLOWAg0bgNE+Hr/U245/ptIIwo
	 uKoIhbYRAYURME/Q3HsrmYo7ikwpQ9dTEiU5v+mlc4SHbQoo2MCtPyDocczAUVG/nD
	 /EJJfvJgHB+MJQy30ymrMG2QnjfLyMZ1tLvW0OvIPwVzR8mX9clq9me87FX2x2LPqV
	 hskBIeMMvFJKdLy/UdN8NIBuZ0r+BLTYq9dRS/arXKvMAAW9l3PoK/wri4yX4PHuij
	 ZlPjHUPq7bK+Q==
Date: Sun, 12 Jan 2025 22:20:41 +0800
Message-ID: <4d9312e8c1ea7ec410f3bdc816387ccf@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.01.12
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ptrPmKFYxZDN"
Content-Disposition: inline


--ptrPmKFYxZDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.01.12 release.

Release Notes:
1) There're 6 new test cases in this release. Include btrfs/328, btrfs/333,
   f2fs/008, generic/758, and 2 fscrypt test cases generic/368, generic/369.
2) New RWF_DONTCACHE test supporting in fsstress and fsx.
3) xfs/032 is updated to support LBS testing.
4) Some updates from ocfs2 and f2fs, welcome more patches from more fs lists.

More updates and fixes refer to below, thanks for all of these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

dec8cfb46ba0 btrfs: test cycle mounting a filesystem right after enabling simple quotas

New commits:

Chao Yu (2):
[U]      [0a9d09ab51d9] common/rc: support f2fs in _mkfs_dev()
[N]      [faf877ed05a0] f2fs/008: test snapshot creation/deletion on lvm device

Darrick J. Wong (2):
[U]      [0b66f6efd669] xfs/032: try running on blocksize > pagesize filesystems
[U]      [9163a3fd9fa1] xfs/43[4-6]: implement impatient module reloading

Eric Biggers (3):
[U]      [248ebfc3d7e2] fscrypt-crypt-util: add hardware KDF support
[U]      [91e779a8bed1] common/encrypt: support hardware-wrapped key testing
[N]      [59e3354dd1f7] generic: verify ciphertext with hardware-wrapped keys

Filipe Manana (1):
[N]      [dec8cfb46ba0] btrfs: test cycle mounting a filesystem right after enabling simple quotas

Jens Axboe (2):
[U]      [11ae4f7d0e88] fsstress: add support for RWF_DONTCACHE
[U]      [d6b9d8eff076] fsx: add support for RWF_DONTCACHE

Mark Harmstone (2):
[U]      [1ba4f6f4bcd2] configure: use pkg-config to find liburing
[N]      [b427797dc646] btrfs: add test for encoded reads

Qu Wenruo (1):
[U]      [7c7235962617] btrfs/326: update _fixed_by_kernel_commit

Su Yue (2):
[U]      [e2da1194fb7d] common/rc: add ocfs2 supported timesptamp range
[U]      [2fe8d7ccc993] common/quota: filter out option projquota in _qmount_option for ocfs2

Zhang Yi (1):
[N]      [253bfc2dc92d] generic: add a partial pages zeroing out test


Code Diffstat:

 .gitignore                      |   2 +
 VERSION                         |   8 +-
 common/btrfs                    |  32 +++++
 common/config                   |   1 +
 common/encrypt                  |  80 ++++++++++++-
 common/module                   |  11 ++
 common/quota                    |   3 +
 common/rc                       |   6 +
 ltp/fsstress.c                  | 144 +++++++++++++++++++++++
 ltp/fsx.c                       | 114 ++++++++++++------
 m4/package_globals.m4           |   4 +-
 m4/package_liburing.m4          |   8 +-
 release.sh                      |   2 +-
 src/Makefile                    |   1 +
 src/btrfs_encoded_read.c        | 195 +++++++++++++++++++++++++++++++
 src/btrfs_encoded_write.c       | 226 ++++++++++++++++++++++++++++++++++++
 src/feature.c                   |   4 +-
 src/fscrypt-crypt-util.c        | 251 ++++++++++++++++++++++++++++++++++++++--
 src/vfs/idmapped-mounts.c       |   6 +-
 src/vfs/idmapped-mounts.h       |   2 +-
 src/vfs/tmpfs-idmapped-mounts.c |   6 +-
 src/vfs/utils.c                 |   4 +-
 src/vfs/utils.h                 |   6 +-
 src/vfs/vfstest.c               |   6 +-
 tests/btrfs/326                 |   7 +-
 tests/btrfs/328                 |  31 +++++
 tests/btrfs/328.out             |   2 +
 tests/btrfs/333                 | 230 ++++++++++++++++++++++++++++++++++++
 tests/btrfs/333.out             |   2 +
 tests/f2fs/008                  |  57 +++++++++
 tests/f2fs/008.out              |   2 +
 tests/generic/368               |  24 ++++
 tests/generic/368.out           |   6 +
 tests/generic/369               |  24 ++++
 tests/generic/369.out           |   6 +
 tests/generic/758               |  68 +++++++++++
 tests/generic/758.out           |   3 +
 tests/xfs/032                   |  22 ++--
 tests/xfs/434                   |   2 +-
 tests/xfs/435                   |   2 +-
 tests/xfs/436                   |   2 +-
 41 files changed, 1520 insertions(+), 92 deletions(-)
--
Zorro Lang
zlang@kernel.org

--ptrPmKFYxZDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmeDz3sACgkQlNbPkfr2
tMyNsg/+LqaBoJ7BNi7uzt2ZyzFeVMkIHuy1BJ1EeDZFrhZuSCvsdDQfMsYxY1Fp
La++zZUlAnBqMHFKWB1KqHRObKo9UvMYJooMs4JfyiQCH3Rs80V9TbJ21O/vbGZi
yNrFuc0F6S8sJzg5prHxFv2o28AIlmIk5UfMTJMvWxYJVezBe2lNLtn2RkerEk5f
1rFG8TUZKhYC0EEsvBp9alNFB7ZIXKxGarszDMtaZJKD4d/BizzCfdHbwwxvSBgm
oe3pEOyjSOgLPcvyaqk/DlzbIZv1jLFIXUHh4fSTB4nFCR4lBrK7ze48kPS+76XA
ezcCsv00AanAGjxPmtp9nvCbZ+pxuqOYu7XxEC4W7fuFcpFw8dcy++bi3/o0Asd0
fAaeZajI1Y3dTM6CfY/+cW2S4Fpc3bOX69MLUksThid2/A4eTGcKc0fLh95O4t3J
91kEMZQQV8G7Vq3BSDNA/IEHcBN2c/w7T+JUiVT3m7LnFFyPWpGi0QOZNTsSBB55
3utgw7iJs5LHX0VEQ/B2iBa1YHNZ/hiv+JX+aIx9lW4u7D8OVdgfE1UckxZjwBvM
wOZcNKmFMvCf+UX5tD1H5xyjCsKRIkkRmGPAJ7M+ejBsQdlZ5uCxrJ8dzZXvjzsJ
U+9QDx6nFfFLoCDlg2D92rXYKvmal2bEjxgeLx6rDD7rO/ua8DE=
=z7Zx
-----END PGP SIGNATURE-----

--ptrPmKFYxZDN--
