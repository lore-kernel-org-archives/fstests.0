Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD3214A9B
	for <fstests@vger.kernel.org>; Wed, 14 Oct 2026 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018043; cv=none; b=c6hqd+Tdw/jgC2kmCxGFUhprPLQBDCPeOJblTDwdn8DGFg5sAcj+qu4CA+1zGisd2vnI7K17c1ZrZsaxUJ+m+35L9SeJUBadiqH51VT4GAGKRX7SlnWWarR1WET/5FgmELQzvBoI/Syq1dVglAzW3gS0Riwo3QBUklCCLpjOL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018043; c=relaxed/simple;
	bh=1FXMMk1y6p0WbRApj7BikOPwQlUJO2ZVB1jtTeq1WUQ=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=M+8aO9/8sGmVhE0+PsQeKPNGCnUyVzu5de5SeMmOWA4VtAL4ABXXWzJFjPpK2tu9stg1YUvkKl/0ajCX+PqngDMVO/LI8y8Zbu3m1KULvtlls6qyGLy7Lu51fJ0z9BqzlT6CIOH3j7ICYE2EmZB7Pn1C1aaDOBQZhgSqeTKSdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mel92Gqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mel92Gqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EAD1F000C4
	for <fstests@vger.kernel.org>; Wed, 14 Oct 2026 22:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792018041;
	bh=N3cmOBSXcemD8GXrF0HQHz6nWN/omQz1FSs3Kq0wJcs=;
	h=Date:From:To:Subject;
	b=mel92Gqi8QrWMD3DTCg2VlOpX85GHm31apvI1TRKsOm84X+9b7ydop3E+sId7i0S0
	 ZbADpR2raDpFadPYElKfUKLEENSAxEBINtUYYZFys2CZsIX9G6wSa0SsfEEj4WqG6K
	 69n2eS48ymDMPc0P8F/m1YgXa0bjHdXASC7YyaO2Qx6SQd2edhi7tJttZpj+g3R9B2
	 UlbOWxcGCkzPgxG3BEUNljvoa7N69d4YkresP0ITbcRwiCxuxBFWAPQ9gauWFXVNR1
	 x6oc8xDMaCyYuBTpyM5GqwakugHHXYiO83GbIL3LfP1w93ElnmF+sA0VbUaFebbyPy
	 eWlCvpRsmpHOA==
Date: Thu, 15 Oct 2026 06:47:19 +0800
Message-ID: <7b2ae9bc5182b4255984d8b2e5ee20a9@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.10.15
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="bALHc5b3rnL4"
Content-Disposition: inline

--bALHc5b3rnL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.10.15 release.

Release Notes:
1) There are *18* new test cases in this release, including btrfs/355~360,
   generic/806~809, and xfs/672, xfs/675~681. Most of them are known
   regression tests.
2) Improve the _require_scratch_overlay_features function to make it more
   general.
3) Fix several bugs found during xfs and btrfs testing, and resolve compile
   errors caused by the new system/packages upgrade.

More details please refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

d07dca72d245 xfs: test unlinked inode list checking and repair with loops

New commits:

Andrea Parri (1):
      [aa81b654c837] xfs: exercise a failed CoW conversion during writeback

Andrey Albershteyn (4):
      [54752e4ad6f8] xfs/071: use _link_out_link instead of opencoding file picking
      [c89b2e0e88a3] common: link .out file to the output directory
      [28ac0c3bc5aa] generic/452: make coping work with multi-call binary
      [d991c20b7f8e] xfstests: fix permissions on system file installed by libtoolize

Christoph Hellwig (2):
      [f12f04acaa4a] generic/805: fix for external RT devices
      [0273012b9e8b] xfs: test libxfs handling of missing RT devices

Darrick J. Wong (9):
      [5e5da480660a] generic/{349,350,351}: fix scsi_debug parameter quoting issues
      [c464a8b02e3c] generic: regression test for refluxfs fixes
      [e185be955e42] common/xfs: add zoned/rtstart info to mkfs filter output
      [1984e2f4b080] xfs: basic functional testing of media verification command
      [1cfd8c36b0b1] xfs: test mkfs.xfs config file generation
      [5539523a6cb4] generic: add regression test for exchangerange-to-eof reflux
      [a0b9df430a3c] xfs: add regression test for swapext reflux
      [cfeeafad33d6] xfs: test rt group superblock repair
      [d07dca72d245] xfs: test unlinked inode list checking and repair with loops

Dhruva G (1):
      [a222e2ae265c] btrfs: test defrag --nocomp converts compressed extents to uncompressed

Filipe Manana (2):
      [29be244b281e] generic: test replacing a xattr with a larger value
      [46955fcfe579] btrfs: test setting attribute on nodatasum file that has inherited compression

Jan Prusakowski (1):
      [1d3c2050fc3d] generic/622: increase sleep time for lazytime expiration

Jeff Layton (1):
      [237b4ca04d20] btrfs: test graceful ENOMEM handling in synchronous dirops

Prabhakar Pujeri (3):
      [73a018cbf57b] common/overlay: let _check_overlay_feature handle param-less options
      [71ac20247d8a] tests/overlay: use _require_scratch_overlay_features for xino
      [8c99c7d0cb19] overlay/081: require uuid via _require_scratch_overlay_features

Qu Wenruo (4):
      [ad1c4f1f3561] fstests: btrfs: add a new test case to verify degraded RMW writes
      [83d0e8eb4e88] fstests: btrfs: add a test case for deleting partially owned qgroup
      [4c8396e1b55c] fstests: btrfs: test if btrfs control file rejects unknown ioctls
      [10c451127e02] fstests: generic: add a test case to check fsverity reads

Zorro Lang (1):
      [a952ecb1ccf1] src/locktest.c: fix build failure of struct delegation


Code Diffstat:

 .gitignore                                |   3 +
 Makefile                                  |   3 +
 check                                     |  14 +-
 common/inject                             |  51 ++++
 common/overlay                            |  16 +-
 common/rc                                 |   4 +-
 common/xfs                                |   3 +
 configure.ac                              |   4 +
 src/Makefile                              |   3 +-
 src/locktest.c                            |   2 +
 src/refluxfs.c                            | 435 ++++++++++++++++++++++++++++++
 src/xfs-exchange-to-dirty-eof.c           | 210 +++++++++++++++
 src/xfs-exchange-to-eof.c                 | 168 ++++++++++++
 src/xfs-swapext-reflink.c                 | 230 ++++++++++++++++
 tests/btrfs/355                           |  75 ++++++
 tests/btrfs/355.out                       |   2 +
 tests/btrfs/356                           |  92 +++++++
 tests/btrfs/356.out                       |   2 +
 tests/btrfs/357                           |  65 +++++
 tests/btrfs/357.out                       |   2 +
 tests/btrfs/358                           |  78 ++++++
 tests/btrfs/358.out                       |   2 +
 tests/btrfs/359                           |  26 ++
 tests/btrfs/359.out                       |   2 +
 tests/btrfs/360                           |  37 +++
 tests/btrfs/360.out                       |   2 +
 tests/generic/349                         |   2 +-
 tests/generic/350                         |   2 +-
 tests/generic/351                         |   4 +-
 tests/generic/452                         |   7 +-
 tests/generic/452.out                     |   4 +-
 tests/generic/622                         |   8 +-
 tests/generic/805                         |   4 +-
 tests/generic/806                         |  43 +++
 tests/generic/806.out                     |  11 +
 tests/generic/807                         |  58 ++++
 tests/generic/807.out                     |   2 +
 tests/generic/808                         |  65 +++++
 tests/generic/808.out                     |   2 +
 tests/generic/809                         | 138 ++++++++++
 tests/generic/809.out                     |  11 +
 tests/overlay/041                         |   6 +-
 tests/overlay/043                         |   6 +-
 tests/overlay/044                         |   6 +-
 tests/overlay/067                         |   4 +-
 tests/overlay/070                         |   7 +-
 tests/overlay/071                         |  12 +-
 tests/overlay/081                         |   4 +-
 tests/xfs/071                             |   7 +-
 tests/xfs/071.cfg                         |   1 +
 tests/xfs/{071.out.64 => 071.out.default} |   0
 tests/xfs/672                             |  68 +++++
 tests/xfs/672.out                         |   7 +
 tests/xfs/675                             |  39 +++
 tests/xfs/675.out                         |  14 +
 tests/xfs/676                             | 123 +++++++++
 tests/xfs/676.out                         |  28 ++
 tests/xfs/677                             | 163 +++++++++++
 tests/xfs/677.out                         |   2 +
 tests/xfs/678                             |  70 +++++
 tests/xfs/678.out                         |   2 +
 tests/xfs/679                             |  53 ++++
 tests/xfs/679.out                         |   2 +
 tests/xfs/680                             |  48 ++++
 tests/xfs/680.out                         |   2 +
 tests/xfs/681                             | 213 +++++++++++++++
 tests/xfs/681.out                         |  17 ++
 67 files changed, 2736 insertions(+), 60 deletions(-)
--
Zorro Lang
zlang@kernel.org

--bALHc5b3rnL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmrQBkoACgkQlNbPkfr2
tMyKDBAAgLvcLz5A1lnJURvPLFclr5Mj4BAlsB9D1LA2ScfBRnhIFumJW5uvw60k
HcCfxLncWZ0Tt78qx+yKS1xh1UeLWpZyDc+TsG4rMyY9lkak6iYkcY5Ea7fpsaiQ
OLm2LH6SSFOoHgRy/wseddT7oTZzT6oaLnxyZTBQfoi5TTs5txQsNd3hpqk5WJ0q
D5eJdde+lJhBFOsuPPBbaeKgVVPQQaVTui2zE14/u65EOMTGWdtiqGU4aKSgIc3z
6sIwxguKepE8ymMnSNc2ZunJIBrAksYg/25W0UApHDWuc1Jhu6tMBMi1WO5rZLNZ
emzdpmMnSi7jObyt0oyc6Fssmmt3vtGlBLfl4AuIv+lrdBMk6+TT0HwgC2kcvUZ6
doA2bSGXcm1dEHIZFXHmzQsB4vvuUZ1y1u7WfMD+MVJXwuSEjn5RuQesuwYN5VfG
CTic7iLQkUwynKzT4h9kmTP/GknUtsCbBxHltszLPE+jjOvkcBHXT1W18Q383aSb
VHSI3s1Q9IQtcFJvhOh2YwpPmxgUtCmh+BfMvcOy/D6EBLkYW3oLFdY3G+TL+bhR
KSqILM0vNo11ztRsqkA5j7H9/2T/w4TiB6EE3EqZEg1kLF8BCrwRMGOhJ1s8th1E
ht3vaBY5V8LNC/xMxQJdyF6BEf0aqZXdgHidpikmG8oNmOIifNM=
=cmZq
-----END PGP SIGNATURE-----

--bALHc5b3rnL4--
