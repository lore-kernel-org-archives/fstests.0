Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C512645
	for <fstests@vger.kernel.org>; Sun, 11 May 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746975561; cv=none; b=eRk5Guv2DJ0P+ZaYjB9V4XEO7ZGScq61UoaPwZKTYpznR8360VZDjgDIg2qd5JHxYboDZquaS/QX3TldVWaXAxu4FIrOotr62sgc0qnNzHc1sr3hNZE4wWj9tYvjGSS5K+OQ7ZzWnXRKW5ghQch20bjPvqEnrIxEPZrhKJA8kzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746975561; c=relaxed/simple;
	bh=NcWAHwERBoJc4oYegLeCkPF7HPb1zubAIY3pbk9kYJ8=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=XtJciFCNuzFigE+7PQ6x0XqZ+SB+TG5NBlU9CtKa7ktWxBF6H12tS3w93ElkDYKKKN+n/3Buw57muw8G0hpO/vVtYx1a42AHnLfBioPrI7SFw7otOQ/Q2AYG2REvZvKC0YeaSXTE/2Ludu/pRKNs5nLNhuAEiOFfNGFXO5T4D+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrbFURqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrbFURqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C6C4CEE4;
	Sun, 11 May 2025 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746975559;
	bh=NcWAHwERBoJc4oYegLeCkPF7HPb1zubAIY3pbk9kYJ8=;
	h=Date:From:To:Subject:From;
	b=KrbFURqabSLyP/5CxLkeCSNrH4uQ8ypxVIaEsV1KkQG7scXcq6TkuwuU+N41/A5Hm
	 ggaZNl+d3dSVgQXedWRZkgNSMNKpPJRfcFI43EWMeSDCcjdnXCKsJrA03TVxFoN00B
	 Ixn3Ga5WbiuUdJXPkNg6tJiSrYYQIqHkyIBVH6qFwka0FxSmOA0Y4Hz/suJh0j6Ud6
	 qVVPn/McFSLnKy2LJFvflBrBQU3156RnN6f4mdVdIyoacgalFuH+na038cTLRiJThe
	 J+YBcLFa3TJm6GieQ/wYovMs2RYuy7N5ypUBI7jmQ9e3dAUVq8HJy7p4vRNPMgiovJ
	 NLcgKBZguahww==
Date: Sun, 11 May 2025 22:59:16 +0800
Message-ID: <1a13da1faad3ab5dadd7be00f1103ab5@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.05.11
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xdYRcsxbHLg"
Content-Disposition: inline


--5xdYRcsxbHLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.05.11 release.

Release Notes:
1) There're 15 new test cases in this release, include f2fs/012 and xfs/634~647.
   Besides that, generic/211 is removed.
2) The ltp/fsstress.c is updated by commit e72c9219f977, that causes g/753
   fail on xfs (corruption).
3) Some basic functions are moved to common/exit file.

More details refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

e161fc34861a f2fs/012: test red heart lookup

New commits:

Anthony Iliopoulos (2):
      [00fb5168666c] fstests/MAINTAINERS: update ocfs2 mailing list address
      [1d47ece86061] generic/211: completely remove obsolete test and related code

Chao Yu (1):
      [e161fc34861a] f2fs/012: test red heart lookup

Christoph Hellwig (19):
      [93699c621e98] xfs: check for zoned-specific errors in _try_scratch_mkfs_xfs
      [d4d28552829e] common: notrun in mkfs_dev for too small zoned file systems
      [f74792247a9e] common: support internal RT device in _require_realtime
      [363069162ae1] common: support internal RT devices in scratch_mkfs_sized
      [eae2dd124fa1] common: generalize _filter_agno
      [42e226139f70] fstests: add a new rw_hint helper
      [9e3423e418f0] xfs: add a test for zoned block accounting after remount
      [133c38c5bd67] xfs: add a zoned growfs test
      [66f5b97a09fb] xfs: add test to check for block layer reordering
      [ac4afb483f4e] xfs: add a test to check that data growfs fails with internal rt device
      [ef9667213d57] xfs: add a test for write lifetime hints
      [9675a9d44545] xfs: add a test for writeback after close
      [30bef4920470] xfs: test zone stream separation for two direct writers
      [7afb07edeb49] xfs: test zone stream separation for two buffered writers
      [0a014baacc4c] xfs: test zoned ENOSPC behavior with multiple writers
      [57e6890bbce2] xfs: test zoned GC file defragmentation for sequential writers
      [c63fc5f066c1] xfs: test zoned GC file defragmentation for random writers
      [d6c292e41cce] xfs: test that xfs_repair does not mess up the zone used counter
      [414de1b79cd7] xfs: test that truncate does not spuriously return ENOSPC

Darrick J. Wong (2):
      [e72c9219f977] fsstress: fix attr_set naming
      [aa8e98e506f5] xfs/349: don't run on kernels that don't support scrub

Hans Holmberg (1):
      [cd5640a93381] xfs: test that we can handle spurious zone wp advancements

Nirjhar Roy (IBM) (2):
      [7446236447e5] common: Move exit related functions to a common/exit
      [3738433813f5] check: Replace exit with _fatal and _exit in check


Code Diffstat:

 .gitignore                                         |   2 +-
 MAINTAINERS                                        |   2 +-
 check                                              |  54 ++++-----
 common/config                                      |  17 ---
 common/exit                                        |  39 +++++++
 common/filestreams                                 |  11 +-
 common/preamble                                    |   3 +
 common/punch                                       |  39 +++----
 common/rc                                          |  52 ++++-----
 common/xfs                                         |  15 +++
 ltp/fsstress.c                                     |   4 +-
 src/Makefile                                       |   3 +-
 .../aio-free-ring-with-bogus-nr-pages.c            |  72 ------------
 src/rw_hint.c                                      |  48 ++++++++
 tests/f2fs/012                                     |  70 ++++++++++++
 tests/f2fs/012.out                                 |   2 +
 tests/generic/211                                  |  20 ----
 tests/generic/211.out                              |   2 -
 tests/xfs/349                                      |   2 +-
 tests/xfs/634                                      |  40 +++++++
 tests/xfs/634.out                                  |   6 +
 tests/xfs/635                                      |  78 +++++++++++++
 tests/xfs/635.out                                  |  11 ++
 tests/xfs/636                                      |  37 ++++++
 tests/xfs/636.out                                  |   5 +
 tests/xfs/637                                      |  24 ++++
 tests/xfs/637.out                                  |   3 +
 tests/xfs/638                                      |  90 +++++++++++++++
 tests/xfs/638.out                                  |   4 +
 tests/xfs/639                                      |  41 +++++++
 tests/xfs/639.out                                  |   1 +
 tests/xfs/640                                      |  65 +++++++++++
 tests/xfs/640.out                                  |   3 +
 tests/xfs/641                                      |  65 +++++++++++
 tests/xfs/641.out                                  |   3 +
 tests/xfs/642                                      |  85 ++++++++++++++
 tests/xfs/642.out                                  |   2 +
 tests/xfs/643                                      | 119 ++++++++++++++++++++
 tests/xfs/643.out                                  |   5 +
 tests/xfs/644                                      | 124 +++++++++++++++++++++
 tests/xfs/644.out                                  |   5 +
 tests/xfs/645                                      |  32 ++++++
 tests/xfs/645.out                                  |   5 +
 tests/xfs/646                                      |  37 ++++++
 tests/xfs/646.out                                  |   1 +
 tests/xfs/647                                      |  71 ++++++++++++
 tests/xfs/647.out                                  |   2 +
 47 files changed, 1206 insertions(+), 215 deletions(-)
--
Zorro Lang
zlang@kernel.org

--5xdYRcsxbHLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmgguw0ACgkQlNbPkfr2
tMzIOhAApjSgrJCJ7ZUT3jtGwSVfLNXiKwGB8bCa+VF8IqoLtIYRZKmQ68hM8xuJ
3r5nPHQ8cLBQalahm15iMKOCu0xpEFL133fBAYPeSyZNA5MwLLHHOHCtBSG4GRCN
EShuU5tkt85wCuQAP4VdC3Weh7tvUlt6OnHUbtayI62tdKsI6L1c5BNf+TQ5qJFp
8qTEvIgPshQUxk90WDLLsijP+W+XsG0JnFAcPXtylodiBhB2/dj8lFJQjtM8i4hi
/3hkGp2y3BntJUIQO44ojcXV5GuLDlOOS4LSKLqK+e+r37DiIMknXtAejcOU3rEn
Gi0mxVEjrE7JCiZ5HzkzxB5RxylO2bRenuWS1M3uTR11XhZv4Ij1s21aBwDzOHPc
tXBDL3fO8ULwBHAW5HSHuo/a9YaT3GIu1hoW9Pgx3M5jbwWaVdk/5sQIsQUuebYG
EmYzDUNK6FaDNFWYceO+cGLVUZgpTUctE3jRiSHX9veTgBE9hw9JjeQxalKa3A/G
TqZAUMkFM7Cgl5QovAbYEgZzJB+HnJRA5rPhv6khl26sHzRUGpfLdJA54tAvyi9I
MW17o8gSyLS+VWyfvvQlkeYEs01DXICzzDBtDaKDYyQ6qV6eJFjTYHZh7Z3Ov8tl
IIQrP1+Gsmk/zrqQ6V5guBRWNy8hzIsZaW1zt1OFOXgR+Ql3IWg=
=DPZy
-----END PGP SIGNATURE-----

--5xdYRcsxbHLg--
