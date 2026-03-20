Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451622D94B0
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001503; cv=none; b=pQTuBRx0a09CZuVSw6/31wbN7rjv5Q/2EG3sYsnuuuYQbnGqY0+XZ/Q7z9PPRuAEB3NhYq3cYicay+4bU2DkmzW9/m9EMbT/qLYFNjrIlfZB/A0bM2sg8KbWGkeXcaU/ibjv93/foueBdQtk7zZ6qzh5ASCHPaCT/xDTtoGEV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001503; c=relaxed/simple;
	bh=AZXr8+Bk/79TbMLRq8s2yRXAvGaxEwWJIPfJ46ylPnE=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=UYTSPFJM3kBxgMUe/r/jMUrIv2EUFEpOFBIAZjc1MSsBU2RJK2PjKkScg5lI3N+JHwfW40Pjo8AoZ8i3uzFKc3Wq1gU56ZIGoEhzSYclKOqiI7XZI3MaI+6AzYIrrYn125atXHIHry2/WpLu5APiiffgB7lrVyeMfaIhTm4TOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXjfcKEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXjfcKEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BB0C4CEF7;
	Fri, 20 Mar 2026 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774001503;
	bh=AZXr8+Bk/79TbMLRq8s2yRXAvGaxEwWJIPfJ46ylPnE=;
	h=Date:From:To:Subject:From;
	b=iXjfcKEloCILwPRzr8Tv278h27+P8yocArA7ZAXtKZ4aZfN6F5MeYIyMttzc72Mzp
	 aM9aYMHUXWMZWJEhBwWb7IkSZ+Lp+C4q7+yC9TkYorQRTttdPIqjzb7nhQ84PLmP56
	 CALojqx+aV4zpOYXK96uhv7tDXdLXm0sJr0ZEueZgm//x3KxTXVeRsuEPIXjqIQnJW
	 llo4TDVWBwZb5yNbgw5sG+Pc/YwSr0pbMhEWchcdQC9lPGsfr5bk7W20Rh3kCRkC6d
	 f1ohgnqm7q15oPlOSQoP2do0myqpERw7XsBrw/w/rwIp2V9q1clAePnmz0OGdV2XVy
	 Ve9LuAbyqmrDQ==
Date: Fri, 20 Mar 2026 18:11:40 +0800
Message-ID: <2c426292a3ab7aec770bb7d7c0cbefaa@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.02.26 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="66B9PZxf2yxp"
Content-Disposition: inline


--66B9PZxf2yxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.02.26 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--66B9PZxf2yxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmm9HS8ACgkQlNbPkfr2
tMz5iw/+OtzyEMTEAC2YNYjeMutcLX70J2aQ47DkqBOUwZ1kfKEH1VXsAFKOfrYY
vUzkElHrWPqCXlJ+82WLBc4FX9l/TYqwmgpcaj9EFnbDVSmHPxSRFWZIUat0Qccz
7KF0aL5jfy7T749anTjpFY0foOJxAclLDjwwwO/+X5JpNE5wSMQoAgW+KovBrfmK
uChWkIkbcZN9hvQfO/oPKHdI50d/sDcVjEFnT/kFkDC7UHaHNE4hoQefsS4pl/Ts
nHmt5W383gXfe5zhWsqzK3kAsAimvlLxGrR6S4quED1wdxxzAZdcntrPwaVB53Kw
qGcwCg4eRUDdfG9SOCnO4ykjaWHnfcgq7u2jWBP+jWajoQctoOgxuUW8rUoNlWEl
DJhi8P6wbYrYkQ7nIyRHHXZZLTdEvfdJdpVWLs9JIrDteVzbGMvDeBTmss8ap4Ql
qvf2Erhvec0fkivHm1PLi6ia7fgprXldjoFKfiYvBYCLVyI/MAuchkcc1VtEWYMB
9Y8CA5m/wXR/rY7FpWQ/ETkxx2W64upFO6ZWWpI5rfjQ1e4+Oz47lqku6LP3X+wC
Sy59egtCaEoGHCBvyEhCONgLEUDk7C1dmaXDqlp6Pc+GinfpECCXqWPl4oc7otaA
+/4ibcD+OeZGDwfYfKU1Ay86uapaErvmR2RQSla++axZo6Uanic=
=gRpB
-----END PGP SIGNATURE-----

--66B9PZxf2yxp--
