Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4628371
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970654; cv=none; b=QHtPVeg6GajI1NIGzYV3ip4zKGGlcVjz3SFvse9i0x4tozBol+1t/zOyKtf1T1JpsQtW52JxqRxWQ6i9eSR8wQC7Q4CRetBH1z3bknuUYEpMJ43frbtIkwcXiKJVbbQXTNxF4jXUHlPK1Nk0Dg5HNnt7CJfyCmuNQAYHxMVaIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970654; c=relaxed/simple;
	bh=f66oFHxPsfgrk595tE2oPmOfe/pNPiqlt5+BFWFbyA4=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=nxCp3KSQwlRkcffWCki+VssW/zmmqJh6qMp9tQZ/w7EyG0hVIE/QAOCOs0PvyWCnS+g4ZYpWfeZjuWx4myOoZlzmO14D+XXSjZzVIvGrLhH8d7Xv8dO1IPRsrbLmCSxYi/O+CJ2yEUv2A9sdnBnzZZAxFByliRbmoNibmRAsP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIbJFTy5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIbJFTy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B8AC4CEF9;
	Mon, 20 Oct 2025 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760970653;
	bh=f66oFHxPsfgrk595tE2oPmOfe/pNPiqlt5+BFWFbyA4=;
	h=Date:From:To:Subject:From;
	b=bIbJFTy5p1E8ZrwzhQFNRuDyjkWXda/rmMFwmli43LNPY9lx3F7YRTcHW6x/NeuJz
	 10h/Q2AhZW9iFXj9zhVhsmQrsvDr5Ylfz1IqgAajI5Q1bEC5pI7/rqMe1KkwNVnw2D
	 LO8taiDL6bUqrGeVjeOZ8CGXp0DCipUPVr716jYJ+I3UjV+BSNRC/F6Y8L8OY83qbX
	 tGf4E2O53y8M1dSjQ9Io0x9e8YKFmC8fW9kMgS/lI0OMl4FIHZbqVveld8Ta2zjHfP
	 U4R+bqj4515sWyLgHJZzm1ZHmRv2ztrSTyG1Q3eLMwzscX2G82x/xiEbi85SkEnMXU
	 UCKyz3GpOFepw==
Date: Mon, 20 Oct 2025 22:30:50 +0800
Message-ID: <c7014cf20a69300494388a6826d2bb92@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.10.05 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CQ3k44AKZI5P"
Content-Disposition: inline


--CQ3k44AKZI5P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.10.05 version.

Thanks,
Zorro

The new head of the master branch is commit:

2cba4b54e6ab xfs: test quota's project ID on special files

New commits:

Andrey Albershteyn (3):
      [ef1028cf0379] file_attr: introduce program to set/get fsxattr
      [4eb40174d77c] generic: introduce test to test file_getattr/file_setattr syscalls
      [2cba4b54e6ab] xfs: test quota's project ID on special files

Brian Foster (1):
      [986a4cc1f5a7] common/rc: destroy loop dev before fallback recreation

Carlos Maiolino (3):
      [e2932df1b5d0] xfs/513: remove attr2 and ikeep tests
      [21d6c88606ce] xfs/613: remove attr2 tests
      [c3b7b05756d6] xfs/539: Remove test for good

Chao Yu (2):
      [38ae4c5048a0] f2fs/021: test quota mount option
      [9460a05243ac] f2fs/022: do sanity check on footer of non inode dnode

Qu Wenruo (3):
      [ebfd9f1ea7c6] btrfs/012 btrfs/136: skip the test if ext* doesn't support the block size
      [f8d78645f2ab] btrfs/192 btrfs/30[456]: explicitly specify block size to avoid false alerts
      [57589265bf74] btrfs/26[67]: update the stale comments


Code Diffstat:

 .gitignore            |   1 +
 common/filter         |  15 +++
 common/rc             |   3 +
 configure.ac          |   1 +
 include/builddefs.in  |   1 +
 m4/package_libcdev.m4 |  16 +++
 src/Makefile          |   5 +
 src/file_attr.c       | 274 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/012       |   3 +
 tests/btrfs/136       |   3 +
 tests/btrfs/192       |   8 +-
 tests/btrfs/266       |   4 +-
 tests/btrfs/267       |   2 +-
 tests/btrfs/304       |   5 +-
 tests/btrfs/305       |   5 +-
 tests/btrfs/306       |   5 +-
 tests/f2fs/021        |  30 ++++++
 tests/f2fs/021.out    |   2 +
 tests/f2fs/022        |  54 ++++++++++
 tests/f2fs/022.out    |   2 +
 tests/generic/772     | 109 ++++++++++++++++++++
 tests/generic/772.out |  37 +++++++
 tests/xfs/513         |  11 --
 tests/xfs/513.out     |   7 --
 tests/xfs/539         |  72 -------------
 tests/xfs/539.out     |   2 -
 tests/xfs/613         |   6 --
 tests/xfs/613.out     |   4 -
 tests/xfs/648         |  73 ++++++++++++++
 tests/xfs/648.out     |  15 +++
 30 files changed, 655 insertions(+), 120 deletions(-)
--
Zorro Lang
zlang@kernel.org

--CQ3k44AKZI5P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmj2Rx4ACgkQlNbPkfr2
tMz8JA/+MXK5K4a3HQ17BPZZIgYFrEk3QRj8sKygUEc9Y9J6QeJzluHyXhIQe/U1
Olo79iCiOkYLAdGrEEzP/eD2/5sadQphl9FHEEUCEMJweLzVC63nF7yBzteV8OvF
JICqDvyM8S5U/5FsbjYI2GP1zn9V8WBWII+vGHpdBJnRFGwkayr2y1Ems6LsBEjk
Y8GtU2/BQUvUZUAUk78QceNQryN0jKm86nTOM3xi4qbOhvNfG0C2YZM1+K0d19Vr
UqMTjX7D9UEEDLjolDqifKQiYS+fQSX3Kk9X2AoO9TFprfshNFqXnmguys61FVww
YrJPrJa55Tu7ZaxAEBAOK96vZKgm/Tml1lkZhXUCk0rIth3XkT5F54gCNnefu3Cd
9teXx1ugnzLukGv75Ie3g5I6jNIA5FDo0n99kaxuesR6xCWWkWik9zU/pth8kWMV
nUVR7XTa1My+SX73uYd22Z0R8ijAdyjqoJ3hkZ1CTFtCcdb5KpxgbXb2tSOqmxQM
Uq/yqp70UZmpFc7Hm13JAR1rg82cYxeERTgzHyG5ku/xBzOdcZZr0JSohTfyDtRb
VsbfoJNurdrLD0x8359ML6ozEDWcFZeDSMO9uBa9i8z5pAIuQX9iu9YLptKRTDkS
LsF4WZ/dFT8tZ670+wwfD67nh6qo1ewDnhq8+B4JtQzdYcrRJL8=
=ks1W
-----END PGP SIGNATURE-----

--CQ3k44AKZI5P--
