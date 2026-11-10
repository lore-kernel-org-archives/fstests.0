Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316137;
	b=c8Yhb3CTemr6afxBoptOp63veFTXE+f0fuwnpNEyxC0UY2gWTmHrRzZRjVM+RnehEmeW
	 l4MFzRHEWN16EYuHsv0UDTFKHtDvHLSZE6e8iv3onCZkNZtwaTFcQVCpagCYR4WCxckZP
	 r+MFOptyaJ4gFDyajOfy/OT4G8Gvv9yz3pgres3k5i42vF6t2GXw8fJPmzb9zNBzOHk2e
	 IyJPHuYpFYhNyhg2u0pNM+hqOxpMStBQeAe5ZPQum+iXPoE93y4ysBoh/dZORUele7K/H
	 hOQpqjzW0gW6Ng27/qxiuhTTzMhFkb/RKHB7PqAU/PAfyuF3yk9bE+TXxVSLejzbvNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316137;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Subject:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=u47JvccUwWCMjiRsNSRCT+bwCzRLBNEqAif/jdOuU5s=;
	b=HXsEif/+7xMM2dpUB+rkxygGKbB0cgJ++DmMRNfMH4D0dFb0pynz3iHw/WY0xJxAIrQQ
	 RTJCCtouC9U57os1i2lGDDFOjZtOiqC48pghHdwNNrARhghaS0sXlZCZrNllmTsihp+GG
	 cFedE2c7xFZt2cubOD6kKn6+aHCJLmRuUAcbIsnC5BPR0/4NhalR+cOCrwAOZdnSOoiuA
	 XbECuf8xio8CfAhhdgUi+tokqsGDuWJiktX8NWyLP80W6cezns0SDOrmYokwjMt8yBHhu
	 dBZcsPVEq5O0ZaUvYgNcf8HmJWMRxv7C/FAvKphbw2DEx5DrsnWzA4pbIkHcAMcTUFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDq5UFjb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B2D606A7E3
	for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDq5UFjb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF91F00929
	for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 13:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316136;
	bh=u47JvccUwWCMjiRsNSRCT+bwCzRLBNEqAif/jdOuU5s=;
	h=Date:From:To:Subject;
	b=aDq5UFjb/DFjaUX0VDxadFmkDeDos+YFM1imdT0pDkOVHP7ihEW7ZKdnOdQiW3Kp5
	 urEByhrVdoS2ahLhoHRD7H9kGUc5X7tcv+5JWagsR4Y9rwbpNx/3eqXksY2HWSJUHP
	 UAOkPjYMA6M8NQc5ORKn4vDIeKwzOONUoPu85guMewa/C1L+g98tZ/zLkWMmP9zal8
	 u45C5LNRxwhB7gWt9o6QzorGJ7RY1LVxIwEusTw4MZq1uzlIbY6yD+k9yAO7B0sIyE
	 hRBuSU/HHZUTwBAVZbXq5cCBJHBUk8VOpMieUuRt3siPUof2zjvnYQAP9wZp93zh9a
	 OZoH7sMkdBhUw==
Date: Tue, 10 Nov 2026 21:08:52 +0800
Message-ID: <24b0aba3f8df82fb0773a01ad73a9b19@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.10.15 onto master branch
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="GgWBGKlyfaLR"
Content-Disposition: inline

--GgWBGKlyfaLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.10.15 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--GgWBGKlyfaLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmrzF00ACgkQlNbPkfr2
tMxmcBAAmGUM874GWRAN21BXtwjiVF5FAgH46m7aK7vODNwBOUNlcEfyQbKnBnfi
gR373fuHYGRRY/ezbXK7nkNWl7MTHx96UizJELoSLEePbodHFDLv2Pj8AHvQ6HAU
2A6LEHHkeaQQ4UhhjTGvn9hxmnoXI2kbSasQYVMpOhj2q3b2yxDmgwfs2rfqRwSY
S+9hF8+3UDi6YBxC3BuK7438qjcppaLo7aiKIAiMXnapixtRdrQRf7ESk1Z6OLAy
2aBGlVMqcK48CYTCsEwkO/51SX2GBi5DJ/sXN7V0ks/b7nTYxwNSVUYURrzNVdAS
HOujOCVblfJGWRometERug/TCI1UDuIU0ySkSNsaG2VUFQIum5PzQsexFp31+q5D
9vfU1pEj8iHEyedDBQw0PQEbVsZ38/DHPb4nzEzCJbzMG5Olw7050jF+9RUd0lJt
OcECnjKA+0iuWEkiI44XFOckzVWA03oxbV8cjZZGKUd4h0LmllGTmfTrIQKhJnai
JDgNLe7+Rh6GxvTadrbg7Es5O3i2YFZiOCVhSkxofWVG+2/ZfbZ3Hh0Ay3qZTaeM
wxaOuwvju7Vkny/PjDXgaRiZCoa38rECm2pepB+u8KL6UqIQy4unq93OYfP77gAh
EFQAVf5Ns8PlvfI+xgMjVHh02judB0juPpto0zBp27noskTQ++Q=
=Wftp
-----END PGP SIGNATURE-----

--GgWBGKlyfaLR--
