Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71A1E89D
	for <fstests@vger.kernel.org>; Sun, 31 Mar 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893120; cv=none; b=pvpNp8bjVoipsV+bSzCF7i0Uf6glZIPpXmBI5WawQfoST//jL5Cnv567Pr+9Tnn4CnXLynWU7LaoO2kdRYW+4zShSWi+RndYaANt5PWd+tTyptWu5ly2mDWfHRllFHIuFnM6rPUe5mp9jFLMQ6yWeweLSqPbKY3hDDBSBCTxUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893120; c=relaxed/simple;
	bh=PGdeU61kqXw5zaI5SpycqR7KixwuIQ9xFS0NEAVe2DE=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=SDbgCJf7xePVqqIMcH2RV6va7FZ79XwQKc/rg8/vZ0dJfrEANH+cAW45F86wCLWRT2W2TqAEvm5s9lzrXTJwbRlyTOfSANj33iKfNO9JfnnTA7l6yRBUI9wvUxfLzP8jVrtlKewjAQnTASw7zKI+QIaioBIhOWM2ZEK807BHNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkApYTOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkApYTOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C4C433C7;
	Sun, 31 Mar 2024 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711893120;
	bh=PGdeU61kqXw5zaI5SpycqR7KixwuIQ9xFS0NEAVe2DE=;
	h=Date:From:To:Subject:From;
	b=BkApYTOrpjgUxNKC7mE5xnbwmPg5VfqmHAXN5+/1URNBCOYKnUJg5Zq/CDpK1/hGN
	 GPP7sE2sKvqd2PFTeU4JBa/5kPt2cNYUB1SfKrKt87hctpsL0F+oUP2DR/RikDUYNo
	 GLviQPwNV9iYFP8zl/FLgEDivzTAKo11RX7qHnnfxzlvFT3Unjwdx7L+jJOVmw6+7E
	 jPi780mSKKWa/TJBwA78/UHhWUjrRFNYILdgHi0gePlTvkNYobwI9YobMTNc/pSuf5
	 Jaei/nIZp+M8f6idwxZee7JGSf/N6WvvC4TfVHDSSFkF8FXgkI4SR1cupfqZDNYrdQ
	 eF7AgDAys3BCw==
Date: Sun, 31 Mar 2024 21:51:57 +0800
Message-ID: <29ac998e5771396c93e9aa50f31f165a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.03.17 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6jLNyx4Q5kNg"
Content-Disposition: inline


--6jLNyx4Q5kNg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.03.17 version.

Thanks,
Zorro

The new head of the master branch is commit:

ec5b77f70e60 fstests: add missing commit IDs to some tests

New commits:

Anand Jain (1):
      [2b0216017bc2] common/rc: specify required device size

Christoph Hellwig (4):
      [5e1e51df9f29] shared/298: call fs commands on the loop device
      [926ae266c86a] shared/298: run xfs_db against the loop device instead of the image file
      [cfb92ce9070c] common: dm-error now supports zoned devices
      [7bb78927c0f5] generic/392: stop checking st_blocks

Darrick J. Wong (10):
      [d46a46c7d5d0] generic/604: try to make race occur reliably
      [ed6967784854] xfs/155: fail the test if xfs_repair hangs for too long
      [0943fadcf0e9] generic/192: fix spurious timeout
      [a3ce52894e0e] generic/491: increase test timeout
      [27f314276da9] xfs/599: reduce the amount of attrs created here
      [480bf0025bff] xfs/122: update test to pick up rtword/suminfo ondisk unions
      [b41b9ca96f69] xfs/43[4-6]: make module reloading optional
      [70fc4244b7dc] xfs: test for premature ENOSPC with large cow delalloc extents
      [7a97d9c0fa1b] misc: fix test that fail formatting with 64k blocksize
      [c9d50e4d1c2a] generic/574: don't fail the test on intentional coredump

Disha Goel (1):
      [7a338a6af80d] xfstest: add detection for ext4.h presence in configure.ac

Filipe Manana (2):
      [07fa85f11232] btrfs: fix grep warning at _require_btrfs_mkfs_uuid_option()
      [ec5b77f70e60] fstests: add missing commit IDs to some tests

Josef Bacik (8):
      [18ecbf559bc5] btrfs/011: increase the runtime for replace cancel
      [51f280cfa124] btrfs/012: adjust how we populate the fs to convert
      [46bc2d68fa74] btrfs/131: don't run with subpage blocksizes
      [e990496ffc09] btrfs/213: make the test more reliable
      [94937700f4ee] btrfs/271: adjust failure condition
      [f682432926a0] btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
      [3552178f39be] btrfs/291: remove image file after teardown
      [512dba4fdbfc] btrfs: test normal qgroup operations in a compress friendly way

Li Zhijian (1):
      [d76c4886ba83] xfs: Fix no executable permission

Qu Wenruo (1):
      [8000febb32af] fstests: btrfs/121: allow snapshot with invalid qgroup to return error

Su Yue (1):
      [b3ff58fa319a] btrfs/172,206: call _log_writes_cleanup in _cleanup

Zorro Lang (3):
      [46b783fe67fc] fsstress: check io_uring_queue_init errno properly
      [7bad5527e2bc] fsstress: bypass io_uring testing if io_uring_queue_init returns EPERM
      [790a9e7c3c94] common/rc: notrun if io_uring is disabled by sysctl


Code Diffstat:

 README              |   6 +++
 check               |   6 ---
 common/btrfs        |   2 +-
 common/module       |  33 +++++++++++++---
 common/rc           |  66 +++++++++++++++++++++++++++++---
 configure.ac        |   1 +
 ltp/fsstress.c      |  32 ++++++++++++----
 src/ext4_resize.c   |   5 ++-
 src/feature.c       |  19 ++++++----
 tests/btrfs/011     |   9 ++++-
 tests/btrfs/012     |  14 ++++---
 tests/btrfs/022     |  86 ++---------------------------------------
 tests/btrfs/121     |  10 ++++-
 tests/btrfs/131     |   4 ++
 tests/btrfs/172     |   7 ++++
 tests/btrfs/206     |   7 ++++
 tests/btrfs/213     |  20 +++++-----
 tests/btrfs/249     |   2 +-
 tests/btrfs/271     |  11 +++---
 tests/btrfs/287     |   4 +-
 tests/btrfs/287.out |   2 +-
 tests/btrfs/291     |   2 +-
 tests/btrfs/293     |   6 +--
 tests/btrfs/293.out |   4 +-
 tests/btrfs/303     |   2 +-
 tests/btrfs/309     |   2 +-
 tests/btrfs/316     |   2 +-
 tests/btrfs/317     |   4 +-
 tests/btrfs/320     | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/320.out |   2 +
 tests/generic/042   |   9 +----
 tests/generic/081   |   7 +++-
 tests/generic/108   |   6 ++-
 tests/generic/192   |  16 ++++++--
 tests/generic/392   |  16 ++------
 tests/generic/455   |   3 +-
 tests/generic/457   |   3 +-
 tests/generic/482   |   3 +-
 tests/generic/491   |   2 +-
 tests/generic/574   |   3 +-
 tests/generic/604   |   8 ++--
 tests/generic/704   |   3 +-
 tests/generic/707   |   4 +-
 tests/generic/730   |   3 +-
 tests/generic/731   |   3 +-
 tests/shared/298    |  22 ++++++-----
 tests/xfs/122       |   2 +-
 tests/xfs/122.out   |   2 +
 tests/xfs/155       |   5 +++
 tests/xfs/279       |   7 ++--
 tests/xfs/434       |   3 +-
 tests/xfs/435       |   3 +-
 tests/xfs/436       |   3 +-
 tests/xfs/557       |   0
 tests/xfs/567       |   0
 tests/xfs/568       |   0
 tests/xfs/599       |   9 ++---
 tests/xfs/607       |  86 +++++++++++++++++++++++++++++++++++++++++
 tests/xfs/607.out   |   8 ++++
 59 files changed, 495 insertions(+), 221 deletions(-)
--
Zorro Lang
zlang@kernel.org

--6jLNyx4Q5kNg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmYJakgACgkQlNbPkfr2
tMzGYQ/9F2MoBtjOZ5xt80DWD5m3V9Taqno1oK/g34H3IAoc2lvvHaDK2XMM4VXD
jZWpiBJLcdZm5B8VWf9PiHleTtGfwXW124mjcBYxx/BnTORyJdCDO/jjR4z7OA1o
MZGnJ7T9gMyPltXTzTfMdINgLuNHyO5ikE+Ms9VeFczMjlt0N488YQ9jTY1sOisO
Y0pAQH7Tek/mhklHs+oD2uiRP4ViNZ2IIaACqkr5dGDL1ATU22axubtaSHDRmIkE
Fvjtx61/53//O5yxbR8n9KFehsqkcKwut0ZTjSDGlc6JiFzwzI6J629Ek9oRQjgi
KIpxtaeWQ87s992cMEZMgthaGJu9bZh9Gt6BoH0CpVLbDjMpd2Hb6GGrTSkOiOr8
f7vWV7t33mOfnRAZVFuKz42IXmR786OtgJioZCGotoA7N2VG2eecpHYAlu31/zLl
BSP+UOcQFSJSmNiQEuIrxmD4/fpbzMLkBZpHyhDxB9BWzNRLl1oW/FpaCAJmHgOa
Olp7B+2/dSFmQbwV/vJPNBr9urD3KI7LdDLR77TvC0KFlVoVwA+8OArC+DWNVg/f
nmfHzZiCBReqc2nJnej9mFt00QPtcepN/cl5f3Fh4bQaEONlHzaGm704jiknGAQx
udbMXd6HqrdFonBawTX4drL/Xw3hgbPqXqR7LU07ApmanVVhw+c=
=0Myn
-----END PGP SIGNATURE-----

--6jLNyx4Q5kNg--
