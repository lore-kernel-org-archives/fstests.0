Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441942D2385
	for <fstests@vger.kernel.org>; Wed, 25 Feb 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037693; cv=none; b=HKpbK4UIG/6ekQVZtC2+MiLrcM7VSLqXjr342OwEQ4Jdcy2lcCjO11RRIWSW8HMhXHk97DMkxITKFLO5qKZ0p6aw5fMqew8LOOtzeuXWyhthkkOvAaoCovZS+ZFimORGmIQyDLiWH6UWY3CYuaRUrd+yg9T74lFLtlaEv3pbmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037693; c=relaxed/simple;
	bh=OudVOdvti/B5LjpiO7nGE8v7MNR0UIOxrjw9Gg9Nlls=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Yxyx/OQk1OMGIU7ih6Bvz0KtXCH+Q+T/Yyv3cUSIDiA8aKmLjFYoJN0hmOS3BabNvSyB7UwEX5mA/Y3hpSL0/v+Ym+FNsA9kMgBqQdfiThjtK1jELkC62bGrwPUaVxSCunOtNfpkV212JAb9+6nzRDWOTNvwXeAlbV00Cj2jYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVbVR5Fo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVbVR5Fo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC63EC116D0;
	Wed, 25 Feb 2026 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772037692;
	bh=OudVOdvti/B5LjpiO7nGE8v7MNR0UIOxrjw9Gg9Nlls=;
	h=Date:From:To:Subject:From;
	b=jVbVR5FoPHbAdsV/D3DqJ74BvcICtQO2EIejMR3VpmTfrxoVSljK84Wtruqo24OgF
	 Rgpbv+QsBmZwDID+YZElAGUlSOKhGu5OR+8onsqSLPPhDVzY0JpCgbF9k0imtGspLe
	 ac8FgSzbHB0s2MW0o1oDWhBpcBNiplT3ycSyw1cWLmzRCvdpKnCxfspE8lUCWEccwo
	 S7LqpWDry5hnyapVnGuihIIDa6Gd57oxs8bawy7f7EVgsySyAJz13RgaE0MPOd99J8
	 TFhoYGvxNGtM25rcIUXRwZy1EhLK5+SOsWF2dV5YMDB6ILINFizGxWdjEIJ/vZLCgi
	 TUUOSgXJxvAFA==
Date: Thu, 26 Feb 2026 00:41:27 +0800
Message-ID: <06a8801c215faa2bb6e5ed812c881110@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.02.26
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CsLXRNsNEq1D"
Content-Disposition: inline


--CsLXRNsNEq1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.02.26 release.

Release Notes:
1) There're 4 new cases in this release, include btrfs/343, btrfs/344,
   generic/788 and generic/789.
2) Fix an issue from new diffutils. We haven't gotten more bug reports about
   xfstests running with new version diffutils, if anyone hit any issues,
   feel free to tell us or send patch to fstests.
3) Skip some shutdown related cases from fs without journalling (by calling
   _require_metadata_journaling)

More fixes and updates refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

3ded3e13c008 tests: Fix failure in nojournal mode

New commits:

Andrey Albershteyn (1):
      [6fe19be2ecc1] generic/579: handle quoted cmp output

Christoph Hellwig (2):
      [1ec21c2911f3] generic: test that truncate(2) on fsverity is blocked
      [163dbbfaacf0] xfs/841: create a block device that must exist

Darrick J. Wong (3):
      [98dd6070d7eb] xfs/018: remove inline xattr recovery tests
      [08989d57ae35] xfs/620: force xattr leaf format for this test
      [d290a3c1b673] generic/749: don't write a ton of _mread output to seqres.full

Filipe Manana (2):
      [6cc08eb81328] generic: add missing kernel commit IDs to tests 784 and 785
      [75bbf15c5629] generic: test fsync of a file truncated to a length of zero

Jan Kara (1):
      [3ded3e13c008] tests: Fix failure in nojournal mode

Joanne Chang (1):
      [66c8f2df3f3a] common/rc: add _require_max_file_range_blocks helper

Qu Wenruo (2):
      [eeb894a242c8] fstests: btrfs: add a regression test for incorrect inode incompressible flag
      [c26276f53d58] fstests: btrfs: add a test case for failed compressed inline attempt


Code Diffstat:

 .gitignore            |  1 +
 common/rc             | 16 ++++++++++++++
 src/Makefile          |  2 +-
 src/truncate.c        | 17 +++++++++++++++
 tests/btrfs/343       | 48 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/343.out   |  2 ++
 tests/btrfs/344       | 53 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/344.out   |  2 ++
 tests/ext4/051        |  1 +
 tests/generic/536     |  1 +
 tests/generic/579     |  1 +
 tests/generic/622     |  1 +
 tests/generic/635     |  1 +
 tests/generic/646     |  1 +
 tests/generic/705     |  1 +
 tests/generic/722     |  1 +
 tests/generic/735     |  1 +
 tests/generic/749     | 11 +++++++---
 tests/generic/784     |  2 +-
 tests/generic/785     |  2 +-
 tests/generic/788     | 38 +++++++++++++++++++++++++++++++++
 tests/generic/788.out |  4 ++++
 tests/generic/789     | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/789.out |  5 +++++
 tests/overlay/087     |  1 +
 tests/xfs/018         | 24 ---------------------
 tests/xfs/018.out     | 45 ---------------------------------------
 tests/xfs/620         |  7 ++++--
 tests/xfs/841         |  5 ++++-
 29 files changed, 275 insertions(+), 78 deletions(-)
--
Zorro Lang
zlang@kernel.org

--CsLXRNsNEq1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmmfJhMACgkQlNbPkfr2
tMx4TQ//ZFE3PFsDMFfgFkpvfhbHmNRTkmtRXrSS+WkUMh7DfVug6imhJ1Xbfpb6
LtwuCovJAyaND2zISs7OWQGNEEiRGBsPkdwl/gvENZGiuBRUqlFL0Gf6Z4S/h80g
RA3mpxFiSSMlko3xrbeo1wBE6u4ehwDQFBiSM1B3EjiQYKpeBVkaWXXNKWKT8QB5
0LkNis3+lnX4EZIDXBY3wp4tXj+AP0fUgXGXnxXoD4PhES5dswiHat8lHqG9vHoJ
4+dwBePLi0QMfcJ/+/OOkSO5OboRDtvMh2GqMZbmtpfZJmdmEC5UjcnAr2WAUoua
QdBa1UEQvp/RyqTjT9MXBMmAafHZ+JwPUfCynJ+TFv2Ymqj3zJR8hqZFN3PnTUBV
SNn1OcUk/suGeDsUFl5V8vBTq5I4CHut317B3f6TXGwMvarenpUcjrS/9kTGcPa0
90HKMl2v4ktTCfkhVmYXw07/W8Q60DT1xb9hYxnHhBUP5tGOI9eevXeb8DRTq/D+
1Xxygx7qaUuZgzMT3G2DTFAv+fsA5yQPGNS04pOeS6yK/VPIujhFCLMu01y70qQt
Q12Y/qw2vrJuu4BER0gH2Ydax1cTEIgwiyIeTMCF9GJ/MGrXY5XOkHBGr5oFIEyv
dwXdOmZfyvowcRxdzm8wDefsnFwg5GvDIIuabkdYOq0GGxQWPwA=
=zgHo
-----END PGP SIGNATURE-----

--CsLXRNsNEq1D--
