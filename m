Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B175813
	for <fstests@vger.kernel.org>; Sun, 31 Mar 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893937; cv=none; b=Bni3GBCydhrKbROsBR7NTBPwQarw/V70XJH+VoR1b9yi9sw8S4k6i1N/ffvspjQKudtQ3Z9l8F9YGoFG1z5F2eGaoH+OpSU6cv+nPIyeS9xVLA1clOpEgpnRHKFxjI0S5uomMcJzakly954N5tMvcl3608ONpZ4SJHSTcBV4+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893937; c=relaxed/simple;
	bh=M9dpxIFgp8M0o97lKkr1/dE+DnH0NAEJ+YBhuu+aiyE=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=NMl9hj9KdkOPRryMM40vLEoZfkND17OBkOE0WDLB5ADQWZ03xnmYQaDC0m8t+YZLhIt6nFv779bZczqmZZqZw02ZVBEK/yg6g8pVB90pWbgljIs9mJFiG2K4XEmkf6WM6VkMNBOliRUsqZ8rtvJmidkIZG9GlNHTSkcmeCYEGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVC0682W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVC0682W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A4CC433C7;
	Sun, 31 Mar 2024 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711893937;
	bh=M9dpxIFgp8M0o97lKkr1/dE+DnH0NAEJ+YBhuu+aiyE=;
	h=Date:From:To:Subject:From;
	b=RVC0682W9c2mNgVzLALbYvXzK85xdl1Mmx+U2KO2uPsGN/xsIk02Vfm05KMuifW4I
	 gJobxAcMMZDbRQ/ZeBT5XpNdhyrja7Zj2URUu51DzBXIHdVIaHbFfbiMSrAaAOwcLe
	 5el0bjmBGonMBzHpcrwlIW4wO/RDM6Mw2D7Ez1jRgGD/KJ8bPD5IJvq/LLqwSNa0Hr
	 63+udH7aSmODCJKAAgLtIXhR3OaOMobIOC13XRX4vOn+mShnx0aa7ofP7KeiH8MOyT
	 U8Yks7AgM6JXmp85sunqy2t4yOHe6y2ukNMIcbGtDrA8qNSlSGTM/ZgOOhVvMk0Aap
	 edcLgshJmhlcQ==
Date: Sun, 31 Mar 2024 22:05:33 +0800
Message-ID: <3754ab4cf3a2401e53a2524ba11c9336@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.03.31
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uIlyServkbzd"
Content-Disposition: inline


--uIlyServkbzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.03.31 release.

Release Notes:
1) There're 3 new test cases in this release, include g/741, g/742 and g/743.
2) Some bug fixes on btrfs, ext4 and xfs sides.
3) The vfs/idmapped_mounts testing got a fix, thanks!

More updates refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

e72e052d56c3 generic: test MADV_POPULATE_READ with IO errors

New commits:

Anand Jain (2):
      [199d0a992536] common/btrfs: introduce _require_btrfs_send_version
      [7337c582d46a] generic: test mount fails on physical device with configured dm volume

Boris Burkov (3):
      [8e7f64fc6b5d] btrfs/320: skip -O squota runs
      [cb30473e15c9] btrfs/277: specify protocol version 3 for verity send
      [76bb0038ff8e] btrfs/316: use rescan wrapper

Darrick J. Wong (3):
      [1512b876e602] xfs/270: fix rocompat regex
      [b994c9c17398] xfs/176: fix stupid failure
      [e72e052d56c3] generic: test MADV_POPULATE_READ with IO errors

David Sterba (1):
      [ac004a25238c] common/rc: use proper temporary file path in _repair_test_fs()

Disha Goel (1):
      [a7958a7c6820] generic/735: improve test by incorporating extra hints

Josef Bacik (4):
      [534975459799] btrfs/131,btrfs/172,btrfs/206: add check for block-group-tree feature in btrfs
      [af82dc0ed203] btrfs/330: add test to validate ro/rw subvol mounting
      [805eeea406a7] fstests: btrfs/195: skip raid setups not in the profile configs
      [34cdaf0831ee] generic: add a regression test for fiemap into an mmap range

Luis Henriques (SUSE) (2):
      [3717a1ec4cf1] common/fuzzy: make _scratch_fuzz_modify work for non-xfs filesystems
      [ec7853cd6936] ext4/006: take into account updates to _scratch_fuzz_modify()

Pankaj Raghav (1):
      [8d61144d281c] xfs/558: scale blk IO size based on the filesystem blksz

Taylor Jackson (2):
      [c4d6d42f2109] vfs/idmapped_mounts.c: Incorrect array index for nested user ns
      [9e760cfa976b] vfs/idmapped_mounts.c: Change mount_setattr expected output

Zorro Lang (1):
      [f8fbdbe23309] common/rc: fix unknown _xfs_repair_test_fs function name


Code Diffstat:

 .gitignore                |  1 +
 common/btrfs              | 20 ++++++++++---
 common/fuzzy              | 16 +++++-----
 common/rc                 |  8 ++---
 src/Makefile              |  2 +-
 src/fiemap-fault.c        | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 src/vfs/idmapped-mounts.c |  9 ++----
 tests/btrfs/131           |  2 ++
 tests/btrfs/172           |  3 ++
 tests/btrfs/195           |  8 +++++
 tests/btrfs/206           |  3 ++
 tests/btrfs/277           |  3 +-
 tests/btrfs/281           |  2 +-
 tests/btrfs/284           |  2 +-
 tests/btrfs/316           |  3 +-
 tests/btrfs/320           |  6 ++--
 tests/btrfs/330           | 53 +++++++++++++++++++++++++++++++++
 tests/btrfs/330.out       |  6 ++++
 tests/ext4/006            |  2 +-
 tests/generic/735         | 13 +++++----
 tests/generic/741         | 60 ++++++++++++++++++++++++++++++++++++++
 tests/generic/741.out     |  3 ++
 tests/generic/742         | 50 ++++++++++++++++++++++++++++++++
 tests/generic/742.out     |  2 ++
 tests/generic/743         | 65 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/743.out     |  4 +++
 tests/xfs/176             |  2 +-
 tests/xfs/270             |  3 +-
 tests/xfs/558             |  7 ++++-
 29 files changed, 394 insertions(+), 38 deletions(-)
--
Zorro Lang
zlang@kernel.org

--uIlyServkbzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmYJbYsACgkQlNbPkfr2
tMx9Mw/+O6fZbyKWEZjJwjh5p10EP5+Q8vk0ni5U/v1dJP7q0JsPtQkwCKQd0/v8
Se2GGh7U+uNxpT898cwHx0mA6Ae6ayJOEi4YvoffEtedfmVQVyUsd7Ci3//z5CaW
oyTnwre1VO+QhG73IAMPCErAkAnHbFqYXMG4zjXMuFt+kYvazQ690cpzk4Y8i09z
5ktE47KG/SnZfcI+f5TJcX5bpNiC82RAuNRlvhoxLF7So7NgnJDsHUNfpFqMDebU
8FLVHLeEIKxzVfoYqjgIlsqfQyFvQkeFOxpR0N+lMhk1/LiHLGIVLKtDwMVSkNa5
NKZ1aDMMLBSN821AG4SOpxJxbHHYVtXri2AmGtTENno3oLigOMriAnAmBGCw9DGf
ygNILJbVl9JazyvI2jtdvf7xqrPlbBUMvAET5SWiCdGRrPEHOSx4OssweoDLTMsp
yq35VII7U6xKYsZpxh+gehc1Tq0mzMXINgWK9VzLucsGyRf2uxis5TFa22WQ5FMQ
zzZM+FP8dCJaTnrMq2O8UFStW0n8uIUmegweL3A+tnGE++RmONbtSzj2+6DbvTEw
lYIaioY/RoyEvDkPOfeVcKg0r/61JGVmUGJ9OXRc7V2zV/fa2/AweydRYp0pHWHz
QaDNut0fZK6+RzYRF4j7YywjTwWLOGsMVfGnCi1IBMnQfSnzDsM=
=b5ZX
-----END PGP SIGNATURE-----

--uIlyServkbzd--
