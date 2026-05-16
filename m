Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE572777FC
	for <fstests@vger.kernel.org>; Sat, 16 May 2026 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778957062; cv=none; b=A+4wd4K9BuFOBsn5wwTNYszVXPs7zu4STsoOzjtO7cSI4NqmW94373ykKHKPIVAm3m+FUvPqGofLw3wetYWYIXbFpMEaDP8ymktFa5d1yUilRmN9LC0rD6vGS6DkIk8IoVK9FAMcPu9rfNEoyQRh08QBlrDE8DJz5MK6HTsKEvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778957062; c=relaxed/simple;
	bh=UY+9XQjl8U6GOn7A4Nb1Md/NwU5IG/Ep+Iq24bDdUb8=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=aJTC+WbUbyACdJ7V19XLV9h7Yo06ZwDC1E3id0LqDY+/d2UfZWTeF0MmX8S03+1k3z452q6j/jLW9+TgT6KX/bXsaz03X7+pmmWzMfY0kkXWIYoiRofgU8n2W2nE5WEJJMBDgJDzj0k1AIgjokOxYFW69bFvPRN05RxuaSaHNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwsEhhDf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwsEhhDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC6DC19425
	for <fstests@vger.kernel.org>; Sat, 16 May 2026 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778957061;
	bh=UY+9XQjl8U6GOn7A4Nb1Md/NwU5IG/Ep+Iq24bDdUb8=;
	h=Date:From:To:Subject:From;
	b=XwsEhhDf3KEJRF15S/gQPj/fVtjnEoHIfdguXRSDT3ABcJI9Oq8YWTTczBV9N+rcO
	 mhwuhvHdn3acAFjyftw6/0YydYho9PvRLEPjg9uSLEvVOY5nz5COH76Pk40xN1lMi/
	 CrCVF/y7AV4MHL4OcfbEXQTNz0bmNS2WCVf2xLqjXc5gZ0JaNKw6ryuQNRTk0BB1m4
	 iySPMjCcmMgCYIu6G7/g5KG60rGsS9cMhUE+QF/74a/OR5dGrENLPgkbz0thkMmJxZ
	 G3oQ9CkI1Qc65dbF8GUCCmWA/c9Oy+WAsgIs9msxBkop6/Yc+xGkIVXVS7LhpUSGye
	 znlBej3RqofnQ==
Date: Sun, 17 May 2026 02:44:18 +0800
Message-ID: <38d35ac74a34b48b01bfd1fb87a57a11@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.05.17
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OhT8n27wj4A2"
Content-Disposition: inline


--OhT8n27wj4A2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.05.17 release.

Release Notes:
1) This release introduces 1 new test case -- generic/794, which currently
   fails on ext4 and xfs. Bug fixes are under review, we need to update
   _fixed_by_fs_commit once those fixes are merged.
2) Nearly all $MOUNT_PROG has been converted to _mount helper.
3) Lots of random fixes for ext4, xfs, btrfs and vfs testing.

More details refer to below, thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--OhT8n27wj4A2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmoIupEACgkQlNbPkfr2
tMxRvBAAmL4Vr7i2OOYCADbke/bHyXZmc8qOYrs52SoQO4IgKtuwcdnFLMSYGbEr
IyhnG85yW+fqrzTctExUXvPxiQLh6zfGXLeu1h0oMJxOmQdUjcT2N5GoD4EsUiFM
dgnHDdkVriGyaYi4zs4V+4Pvej9YoPMSAW98elOSENncG801gM/LpnOSap+9tNej
+a849ib7dP2tTfyPpNnInNYQZmcvgWROgaIsRZSJ4b0Bcd9MXRzuYRN0+r0Pr4mW
I/PBAJNq4SjrVSnWGHEahTrmPqSux+0Lp3VZi7rbI7phmjCpBZ/ZMWeHS5Z3YUyn
eX6eq24Lsm9dtJ+fS5HAt5f5HHT+DFLnCaLpbpccC6dHA3gNUpX2bKCEDhwd7/X2
fs1xEOZlcby0fboVweQIeKB5bfbriMcGXfxhLeqrOOhm7ZtVzCvCOZcnBP1JUwur
puQR4YQznHX96Rh4tcHTlChQtK2CIVSc4b3cGylurkZQdD88DTDHHhay/cq+jF2X
aovCI1FvVBw25yNankGxeLUk4ArX3mXgQl2v76Qy3PFwF6TaE2lTi8VUn6C1tx51
yjWWH+8la0DMvM62JdKMfGhj6UbMKdyythwnGnRezatPSR0bZyKKe8fopYEzB2wf
8TlN/zulVbFROd8p2KfimmbPp4w8oZTShSrNfyuqD0BdAgkqw44=
=rw0A
-----END PGP SIGNATURE-----

--OhT8n27wj4A2--
