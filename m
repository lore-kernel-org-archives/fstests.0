Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A04204F
	for <fstests@vger.kernel.org>; Sun, 17 Nov 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853913; cv=none; b=u8DywvUtptLM060c4dZpnaFYayIssQk7sGvsXf4WeaLRUoCANkNHl+i3TAxyx7+3M75fQccfwOlM4T4aOfrI5g+YJKs9DSIvwcziGA0CSbDBeVmu7kCoAptB2ywL2ZgeLqe5yHsnKPIPJ0O8SJa5fpsJR/+5VqFRpXrO7X6CDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853913; c=relaxed/simple;
	bh=2KTDm2awSV4YEpoDoaiSRG3XRbi0PyyhC8hQt+Fqc7Y=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=HEdSo3Da4wgZEI/KsNSPWRbG5fssEol5blChsBfTs3KyILqb+OyGjNQ3aQ2e3CZaIH/kRpnKxoJF0I2dnNneJmhnmjUH87uSdc0qgTw5pePNsM3zXzPkwQUFYCojdhE/d4CZu06efr1sQRtum1TEUfxFRSNgWZxoXs4V3pjRjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFex0I/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFex0I/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEE5C4CECD;
	Sun, 17 Nov 2024 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731853912;
	bh=2KTDm2awSV4YEpoDoaiSRG3XRbi0PyyhC8hQt+Fqc7Y=;
	h=Date:From:To:Subject:From;
	b=JFex0I/oSB+Sq48Wvq57qJ39ciGRdz8meP9EB6Z64a9UPi9Q9gZJIoxKdecv4bm0U
	 qXJHV/cG6D07j5Cc0HqAiAdW27oDtLQgYB9MIZ49feZJurRuyFBgoBBMgB8Mq1L5d0
	 7USh857fnO8Vag0DN5GMrLsYDJnnCPLDdFmN+AG1K8rXPO76DzXZFUCWz2VmMSkxEH
	 mn1QK8F+3afZYU5nLNcG+9HD5q/IW41BiSiH66udr2H/+xhFSW1BVqkKHnLxFDavwR
	 vBtooNmYZ8U///ixwqyYhdRriP2lmBAE8A1bgbOxsd4rAnA9PhbotEhbc1Sw0EIcIK
	 YPEaa/Wxo0ZPA==
Date: Sun, 17 Nov 2024 22:31:46 +0800
Message-ID: <73f6693311a68a83b500ab8e8730a7aa@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.10.28 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wAN3OJKDd2VW"
Content-Disposition: inline


--wAN3OJKDd2VW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.10.28 version.

Thanks,
Zorro

The new head of the master branch is commit:

f056971a4d2f btrfs: test remount with "compress" clears "compress-force"

New commits:

Boris Burkov (1):
      [9eda73ff4695] btrfs: add test for cleaner thread under seed-sprout

Chao Yu (1):
      [18795160b0f3] f2fs/004: add missing _fixed_by_kernel_commit line

Darrick J. Wong (2):
      [1f8fedd08f06] common/xfs: _notrun tests that fail due to block size < sector size
      [9c3762ceafd4] misc: amend unicode confusing name tests to check for hidden tag characters

Filipe Manana (1):
      [f056971a4d2f] btrfs: test remount with "compress" clears "compress-force"

Mark Harmstone (1):
      [cf97fa373d61] generic: add test for missing btrfs csums in log when doing async on subpage vol

Pankaj Raghav (3):
      [bd0d0179baf1] xfs/161: adapt the test case for LBS filesystem
      [b71de9073a65] generic/219: use filesystem blocksize while calculating the file size
      [6d97ae8ddebf] generic: increase file size to match CoW delayed allocation for XFS 64k bs

Qu Wenruo (3):
      [0d203737049d] btrfs/012: fix false alerts when SELinux is enabled
      [0ee667ece05c] fstests: btrfs/330: enable the test case for both new and old APIs
      [6f4a6b5789d7] fstests: btrfs/002: fix the OOM caused by too large block size


Code Diffstat:

 common/xfs            |  5 ++++
 tests/btrfs/002       | 14 ++++-----
 tests/btrfs/012       |  5 ++++
 tests/btrfs/323       | 47 ++++++++++++++++++++++++++++++
 tests/btrfs/323.out   |  4 +++
 tests/btrfs/324       | 39 +++++++++++++++++++++++++
 tests/btrfs/324.out   |  2 ++
 tests/btrfs/330       |  9 ++++--
 tests/f2fs/004        |  3 ++
 tests/generic/219     | 18 ++++++++++--
 tests/generic/305     |  2 +-
 tests/generic/305.out | 12 ++++----
 tests/generic/326     |  2 +-
 tests/generic/326.out | 12 ++++----
 tests/generic/328     |  2 +-
 tests/generic/328.out | 16 ++++++-----
 tests/generic/453     |  8 ++++++
 tests/generic/454     | 29 ++++++++++++-------
 tests/generic/757     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/757.out |  2 ++
 tests/xfs/161         |  6 +++-
 tests/xfs/504         |  3 ++
 22 files changed, 272 insertions(+), 48 deletions(-)
--
Zorro Lang
zlang@kernel.org

--wAN3OJKDd2VW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmc5/iwACgkQlNbPkfr2
tMwgORAApU450S2ewaX112VjCmHGeC1nVuh5oZ4PB2ePwXByf36VZXhWOlCV/LDk
T0Qko+a8ui5LGLMoDgvoBNwmT7Mb9SVx62poAeWfdOE4jz6frt/oI0Fyt4Rpsd1M
r1qkyN5RGp4K8clxjgH902xAejirOq2fPIu6Q7p95QCTNv+8VMkdqBSgL2dutNhd
pzhG3yA5bfj7h6u3TFmwslqKmm5W41MgUPfc+qvuueCL3EO3WGsMrwZWKnnv8G3E
p6wsyi7ImqR5SFCB7KMlAxUs0f06DmMqm+SCDRM0LTO+ZoMlot7HPkkmluUmYi51
T+1ZJW4O2+isE15GC30x7TkQTGb2neYR6hSHC9VewjNOH9BI0t9BkWjZXL7qPxPl
D7k4RhIeRajYCOqsKchuEyflW7FYHruFrqtMTYBFvoznqWXHpmxqiCGhhPJ2RP5a
8f9oUJOTB2Yu9R8VdrHVFor7xttqICWCknzgCEGq/WPaZ5nGIqmvGwtB4/3+VpwA
wfVaLwFezf1/Ovmnx1e6hZULeSwF7JNqK5o31yGk63GdfR/GrHwNsyfec3vp2mcM
pdwPNi03kaScrsPOajlV7r+0+2WKy7AIrK5wZFLl9pmT7tsdx1PLyxxpiNJnXkLw
jxCwfA34htdM5WUW+MY8gAQT9PI7LqqQ0evX16gqHmJvgEjZHzY=
=IqYM
-----END PGP SIGNATURE-----

--wAN3OJKDd2VW--
