Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7803F788F
	for <fstests@vger.kernel.org>; Wed, 14 Oct 2026 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016821; cv=none; b=JdPq8sF/mRzckesi2T2sTAFYeSud8ZsKYawivQRj3eS4zziaRpBvo3xG9qc45yMdGu+oNchXYieZcDWHNYsbNq+AdGJL1Dj6AvQRJDKhPVQkX6uTUSnk2B6h12riBBFfUCsJCHn77490qOFy6SCRZBLTCfPV38lTEUjtmNJ7o1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016821; c=relaxed/simple;
	bh=Al16hHClymCbRohxq47eiuHALsfYnY76wefahcRBoyw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=HaKaIO0+eiAbJE8ovD34GyT9wzRzbSA/99U1rtZuSauCn5OTcdCvvnhuyRXiKcPUPJZyAhCfBdmndMRP7JUOsiplknYSxD8a5zRiMEP2zD1SljWVs2JBIufMJ/leuYaUVasDA1YmLk30YXKbD0uqSSV4az8w258ZPJsdYzhWrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMrt+9i0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMrt+9i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE9B1F000C4
	for <fstests@vger.kernel.org>; Wed, 14 Oct 2026 22:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792016820;
	bh=6AA4z43fxCVDxTkXlcctgKnJDXacLS9uuxRCvmBvw1U=;
	h=Date:From:To:Subject;
	b=nMrt+9i0UveWRbaRo6bflZBqp2qFr592zbav5Np5wMkiV5pnsV3E+sBxHA2JDRIYf
	 o0nzQzJcNBN2GUXhWNWOMzSxUWlIXIAJkGW9VqxvdFftSYMGsLFsNpQsbr907hi8tJ
	 eqJptw3xN8M+ReUoDDxWVAVgSX/eR1Uj4tf3A6t3CNMjbWfzOIzGbOOiWPaBJeNg/5
	 bqggsyHtha2wfdUai2EUIoGX/cdv2JWmjOMEFgSWmO2/BhRt2deBWF3ri5e5C0szRH
	 /kuTpU2E5IUNqH+FE9f5E/QllK+V2KfhB9HjsopoKfl9XtLRWwhy5JYmvC9CoWoBL0
	 aWwdrQMB1s3UA==
Date: Thu, 15 Oct 2026 06:26:55 +0800
Message-ID: <5f96b1a15d3ac97d285e7fe507e8fca7@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.09.22 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="oMFddRZreklx"
Content-Disposition: inline

--oMFddRZreklx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.09.22 version.

Thanks,
Zorro

The new head of the master branch is commit:

22348afe338c generic: test bdev freeze count leak on nested thaw

New commits:

Avinesh Kumar (1):
      [06b50754a606] common: strip attr 2.6.0 --restore safety warnings

Chao Yu (1):
      [128ec7a21f60] f2fs/009: fix race condition in orphan inode test

Christoph Hellwig (12):
      [650bb021929c] common: fix spelling of SCRATCH_DEV_POOL
      [a90ba59dca44] common/scsi_debug: don't slow down I/O
      [78f86c0dc9ec] common: factor out a _bdev_disk_name helper
      [76f16d87f156] common: add a _sysfs_block_integrity_path helper
      [1b04c87913d8] add a "pi" group
      [44da803a375a] generic: test I/O on devices with T10 protection information
      [cde58dc40cd1] generic: test corruption detection using T10 protection information
      [c8bce2ea5356] statx.h: update to latest kernel UAPI
      [9adaa029b909] min_dio_alignment: add a -r option to query read alignment
      [104eabdc9af4] generic/091: enable sub-block reads
      [42ead55fbe17] generic/263: enable sub-block reads
      [b7bea12549dc] generic/760: enable sub-block reads

Filipe Manana (4):
      [a322765c0244] btrfs: test that we don't create pointless compressed inline extents
      [02257f07bef2] common/btrfs: exercise all algorithms in _btrfs_stress_remount_compress()
      [dd295117cd2d] common/btrfs: exercise all algorithms in _btrfs_stress_defrag()
      [77a27475bb0e] btrfs/255: add _cleanup function to kill the balance stress process

Moritz Tanner (1):
      [22348afe338c] generic: test bdev freeze count leak on nested thaw

Prabhakar Pujeri (7):
      [a6b4ebfc16fb] f2fs/024: add missing execute permission
      [dfdd743084df] common/rc: remove trailing space from _mread() default map_len
      [41791dc85838] generic/590,735,795: add missing _require_scratch check
      [39d4f2f0f91b] f2fs/015,016: add missing _require_scratch checks
      [078b7e600fdf] common/btrfs: require scratch before checking encoded reads
      [052ac516dbba] btrfs/273: add missing _require_scratch check
      [56c60b693f40] overlay/081: add missing _require_scratch check


Code Diffstat:

 common/btrfs            |  14 +++--
 common/overlay          |   2 +-
 common/populate         |   4 +-
 common/rc               |  60 +++++++++++++++++-----
 common/scsi_debug       |  16 ++++--
 doc/group-names.txt     |   1 +
 src/min_dio_alignment.c |  45 ++++++++++++----
 src/statx.h             | 126 ++++++++++++++++++++++++++++++++++-----------
 tests/btrfs/255         |  11 +++-
 tests/btrfs/273         |   1 +
 tests/btrfs/354         |  46 +++++++++++++++++
 tests/btrfs/354.out     |   2 +
 tests/f2fs/009          |   6 ++-
 tests/f2fs/015          |   1 +
 tests/f2fs/016          |   1 +
 tests/f2fs/024          |   0
 tests/generic/062       |   9 +---
 tests/generic/091       |   2 +-
 tests/generic/263       |   2 +-
 tests/generic/590       |   1 +
 tests/generic/735       |   1 +
 tests/generic/760       |   2 +-
 tests/generic/795       |   2 +
 tests/generic/803       |  97 +++++++++++++++++++++++++++++++++++
 tests/generic/803.out   |  73 ++++++++++++++++++++++++++
 tests/generic/804       | 133 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/804.out   |  21 ++++++++
 tests/generic/805       |  68 +++++++++++++++++++++++++
 tests/generic/805.out   |   2 +
 tests/overlay/081       |   1 +
 30 files changed, 673 insertions(+), 77 deletions(-)
--
Zorro Lang
zlang@kernel.org

--oMFddRZreklx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmrQAXcACgkQlNbPkfr2
tMxmkw//V9PHngq5rmmbDOtq90IOqG0Q9nIByDEwKBLliuYPbzfoI66D9kBBHBzw
2Wh5ztbSNLG8xajxwUjXf0IOv+gWfOAzFSrnNCw+OMgWebZ91X2LdNGM85bXrgQI
/vQmXb722SuZJtQwf7T6r7W8RA4sE/R2mueoHi6a8FwFOPDrhQWqsy87pUiS1B7Z
Ctdj0vNdLkA0wR1V4Wih8ILrxVlvD2Pvj5xpWb407ad0vG6ORYVDhHsT51E6ZsrD
f+j0p6UnRWEDUEqLqu4WxW1gBwG0NTqSebJXE1/KpcP+/J56Z3hLlNxe1mx4tVs7
tZmU/ImAo2DogufNc2dxuRg9UnJX69QltADJlYIdKIJK3V0qibYEMtZNjhud2dm5
NB4acO5VjDfTb+SRXbIZ2z9XZt1kFCRpZZBZBVnZT0UmB/2mr4A+cCKexCOE2G+D
maXYf/Vc8ocIRjXvtRdq3142VLYbSAVkZqzPGkOyLINFTJY8veiNgxE2W4eqqYRa
D7t0qoiKzF1yVdAp4igj9CoT9gCkFUwvIAspKmcm4dcIGLCrLJIFQ60kkt+K3il0
BbYXHBeMjFXcOqDZmzpg+svakNgY5ym65M4i3dom8I9q4fkIwYvUl7hBSjhSv872
d834pdUT9G4wYYoEmjSi5b/IYn5rc/PAsUww9Lrs5cPphnJx9zY=
=/dQ9
-----END PGP SIGNATURE-----

--oMFddRZreklx--
