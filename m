Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077553ECF5
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079612; cv=none; b=J52OvfWwxqDtKxxx7H9nJpoTwVLIXw5mPtBH7GZPb3n0pmvr6SH51KFRqKZadPMWP7NRV8KdKnozsbPbYpzoPNa1JBhjR1Ry9LsMaPQEtohr51OyopwE22lD2ygLstZkwuzzTBZfAQe/h+damprC/260i/B1J2HqgzcddIre6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079612; c=relaxed/simple;
	bh=zn8dMnHafpKDw9//wOto73N1aV7MisniFQ06a+bfI6s=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=eHHqNG1Nyt6Eej7UYPZxMei15uhFQf+g41TeyxXwFqT4y0IGtAerK2rIcoBsS/lZ9+9WeY6BZpbHebJgPfyQExiMSwOzaD1PCMgZ4P2ZUtVzocTBr9AggnmPe4z8RL0nqSBcGhBebiCd384rNt2JuiRl2fyKhC/RLu70kevKg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAvclYQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAvclYQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56561F000FF
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079610;
	bh=r0BRR1e0SyThPq9GGuRutP9RdUQ5wYtMk6Lw1Btw7vM=;
	h=Date:From:To:Subject;
	b=SAvclYQ4f//2D+ZpSEujen9AZYfnIReBonCpFlHOnWM+ZTwQafj1u9E/ZflB8XUfh
	 WCBkn+6tHhQ/EIsbze8BnT8p4iBdXm9AA0lrw4Qv4m99Po0N+9MfXsDztWJ5tN8gdP
	 Ne4n60x7P04OrxS48sm7UAlveMk7tPaek1jyfjTq4PsZGcI4KXxwnrRRTm7e/kKbIP
	 z7oSLqEsNvZmJHQBumvKLvcwkJaBZejhnEg7lLMiRYaxk9scOVDPHg/o1xjLxJ3KCe
	 /RljOFrvjcHvN3lxwEiiQDLKBGL6gq8gEx/Ent+ep3OfIEIymP/z/XQeCZ+hSrwMR9
	 XTUYgXaDzAnog==
Date: Tue, 22 Sep 2026 20:20:06 +0800
Message-ID: <be1e08e1ab925877096aaaaf521e5c5c@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.09.22
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="QyA7haoXllPI"
Content-Disposition: inline

--QyA7haoXllPI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.09.22 release.

Release Notes:
1) There're 4 new test cases in this release, include btrfs/354, generic/803,
   generic/804 and generic/805. Note for downstream testing: g/803 might
   trigger a crash on unfixed kernel.
2) Introduced a new group "pi" for protection information testing.
3) New method to query dio read alignment.
4) Fix missing _require_scratch .

More updates and fixes refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--QyA7haoXllPI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmqyclIACgkQlNbPkfr2
tMwGtRAAxfEzF5ecV74HfMYcEKm8KZVJS+R1MWiB3G0kLMK64Bbk0ZPAZtSj7bsp
DSVT4YbbguHqAdWFehK8HsZv/9yPzOkbaXmSLAVRvaRbWKGTz52I8hK55RKxl9if
KR99c+rM5l0J6eYsTo0i2i+JK6ObXT1hmHanpBTXsECLOhSalQXkwgAIluBDQC/L
ixZc5xozK1JgGF4bmLaYTYXTATGPm6UbshiBku1ja0G61mEWZ7G9jFkQUCW5IFH2
Tflx3WfGGLdZPbIw6TeUswEq6S5aGXr1+prG6WtzGZfSorfBP6W7xQlKn79IDb/t
E0nFGXBcGFSTyb9lHH9Cy858904WV3smh/DDqCIENS9gUHoJfMbLVwMqEH+b/a47
I1z/+kWo5eyx1E+YYQUTutTagM77NUunZNDomKC/EunoQyfIS1DwQ9mLxkzd+/oe
PzATizreZFCG/ipOgaZcWcUtNW7N6Y6JBHGL8+jpmmdXBDY9tO1PIcmDUh0TJNvf
XpG0/GKt/ukTO0vHHIhrGC+R4MM8BA91RDl2hG0qO+pgwSQOV8GB37dI1hTJ3KBf
3vGbO2OuFzSzyqoVNJ2fgOmM8tkJSGIZhnS+6Gf8u6mdFCxEe53iK2kHOAKvPaIR
TlhhZ4phUh9QL8DpuGQ1R5M9780HFQsK5dI7Ga6cfCv3tz2RdRo=
=Er4c
-----END PGP SIGNATURE-----

--QyA7haoXllPI--
