Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8C23741
	for <fstests@vger.kernel.org>; Sun, 25 May 2025 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748176645; cv=none; b=Nt8Ur5BOjnVeQe5iFGU2B5NOm0ovS392/hhORAKQHm62pjGMnAAqcOMEP08oW1U5F7sRKkhoJQPmvfM1uY8ZxRGG1dkbJZ8BM020ydFx7HH6ESt5/qXOa50Njq7m6H1Ef0uCp1lV5UFLL3Pz3OBtqDc6wpppEjxqbUwNDE49clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748176645; c=relaxed/simple;
	bh=6Ygxh1VvFVpZHQYEMSiE0ZG735t3SeWY2ZxImbPLyyE=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=pRdnRVJRvUrFG1yjRJUvl6kVW2x9nwik/ifNM4h8G5iGMZ3M+3G9P8xUek/S9AlBMAULkIPg1hfq/iwbEeUU0pHSOZKxPo/3cA7l9NAjShB4RkrZuUf+U8SYZDqAD+25x8QvhFD1C8Fti3YijWo7/Vs9CDSh8D7MuJxmZAWE7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBeg8vaL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBeg8vaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EBCC4CEEA;
	Sun, 25 May 2025 12:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748176644;
	bh=6Ygxh1VvFVpZHQYEMSiE0ZG735t3SeWY2ZxImbPLyyE=;
	h=Date:From:To:Subject:From;
	b=uBeg8vaLRqLFMC5+o9X3MalaM2l4dyi+cKIF+3h/jmDI8PgZsBk1vbo8Lhj/3iwcI
	 ahhqiEqD+Do1MQhgH4HZKpNDddpurPkfoD9o4JDhVimhd/UF9xcrR9lcBeNCZPbli8
	 /CF1T3lsiJ9UTykbx7rsFMgZMmMayFQTDhxVEX7264TYemEu4Cfl5ByXNNUKvak3Rv
	 7p0vuROKJcfKl/LXR5MIMFRtB13KRcKuebLhkUZdQN+Qcga4MtuK7oVHx2AaePo3a0
	 hV2KBV0y3vcfEs93QrJ9Ud8QClINlHR5yGXePXh+u9WxOXnk7dKfiMcVUKFsGEZcnJ
	 5q1yqzUvjgSKw==
Date: Sun, 25 May 2025 20:37:21 +0800
Message-ID: <e47d71caecb53f97ec8fa381ef17ef87@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.05.11 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CCbtFLPWxc2H"
Content-Disposition: inline


--CCbtFLPWxc2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.05.11 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--CCbtFLPWxc2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmgzDrEACgkQlNbPkfr2
tMxlXQ/+JwzzusrDkuPfNyJQcEC0baUi5BG0dLOCFjKs0tDQHii9Ov7trzNgYBgl
bLlXT3u0jDar642oBpUfjSY/jWUkzIz+1/DLGWf9V2T4Azl7IgV02yFlA1awhO8C
3FX51zTlepB8ULh2FWebD/4d9SxXuLHGdpY6ejpF4NiQd/xydeE2ihy9lX/cqEQr
ZS03LW6JxLsnSRz4vnIrkQnZKI/lDKyod1FGq/iH4ohVO49qE6ylCpd7Dp2X1RRB
F/JMTgI0RiyIbdhsuTyleYGvj/g55C0jze43//OUTp700o8Ln/bQ/mtaLjo0lTaf
Yd5kbeTlMNJYmwUNZoycRQ6vTi55wSEiQpsBEK0kFc3LL+WB7mblgL8zcrqvj5x8
FEC6EPv94dAAZtQKnufZK8PS0hV5lwkxkov92BDTSmqbmtWIVV5VhCwL0tRBgHdc
289Bbv1I+TjEoy6Cah9pO+O2Gr4lOBU+ZqrfuKfuml/5xupxgokuVXmyVWRd5fO6
5hUzw6KrMzZ3Gvoq+2G9vIjSzOIe9gPgRcu2GgX5WflwoQPyMKiTq4KTHcdOVZxP
QWBOtZCy9sBG/Bjm6FrD+uRLUYlkNUI2sQ5g9yDFA5YwLRrCO86Qn3yvmh/mDFWn
m2Pt0FXwFJ56YncogtKnGOR72k5ax7iAmBRT6OB8LPCHSBnQh8I=
=FmOP
-----END PGP SIGNATURE-----

--CCbtFLPWxc2H--
