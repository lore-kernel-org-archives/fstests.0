Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53FC2C4
	for <fstests@vger.kernel.org>; Sun,  3 Mar 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470093; cv=none; b=EIpGsNxPLoviRMDvOHfbT13892wLP+GiR/ITKRMhvnYhABqotL8dGH2ewvEnFxVH2LBGPYPnVScdGPDu62VW/foawDPtkXpdGrDEOt0YSk3erKEeDg45P2EChL1ukZKCWOqTyXgCnyg31HywLUUxwh9oLPQd5wcPq/x97xsWL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470093; c=relaxed/simple;
	bh=wS6jp+xNk7aq8E+ZiUtcV27pA5jbV/gkTwob3/bAZYs=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=WwQjhV+QCfq3QJ3SQKnFLRntVkduUk6gzF8j6tJfVxXgB1xDWbpAR1wNqEbAvv8wcDfDcFUHGEdPMNWtB1NBLENmAXphg7YfYovaNxhFg15Ddmabm7nv5+dCwp0r6W3TRgfyy8bsl2EA0PBLzSX+NoIFpIrbJkowKUJds9aO2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7JqONx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7JqONx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C165DC433C7;
	Sun,  3 Mar 2024 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709470093;
	bh=wS6jp+xNk7aq8E+ZiUtcV27pA5jbV/gkTwob3/bAZYs=;
	h=Date:From:To:Subject:From;
	b=K7JqONx+RIjsyL6nWbw7ooQ2IBxxEnMXdjY3/YcIJeN2sKfjwsrfNd1Id6LCvD5V6
	 rCaCM47JA67Wy++0v/mx7GzxUBKb153ItR1/WkyL7tVbR1T5NURPiJZDyEfN4tqcD5
	 SAR3CpFlifD0xxSVwchk+Cj05LNiDZuU3MNECE0P2/Mpec0NzB8GtZ/MVrj6S97CP2
	 HF7wOE5tl5mGkgmY3emnIkzsxaO5m/NRxLGZe4aS6/mkFN2s3pQMbK4ZPn0HDNTL6b
	 TeAUFGxOYJXIBxxJ/8DGPtrnm8OYyA1l4NCrGQX+Fov10sHTMrPn5fuzI/C6fptYuP
	 UWnMC05FqU/KQ==
Date: Sun, 03 Mar 2024 20:48:10 +0800
Message-ID: <0cb72053ac86fa0cbf68addbfe7f14d4@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.03.03
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls7fEUR7l19B"
Content-Disposition: inline


--Ls7fEUR7l19B

Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.03.03 release.

Release Note:
This's a release for btrfs testing mainly. There're 8 btrfs new test cases,
(include btrfs/303 and btrfs/311 ~ 317), and some new helpers, new test
groups, bug fixes and so on. Thanks for the reviewers and Anand Jain helped
much.

There're also some bug fixes and updates for common/*, Makefile and some
generic cases. More details refer to below. Thanks for all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

9b6df9a01ac8 btrfs/016: fix a false alert due to xattrs mismatch

New commits ([N]ew, [U]pdate):

Anand Jain (10):
[U]      [c5c8a2223881] common/rc: assign SCRATCH_DEV_POOL to an array
[U]      [b89613e85fe2] btrfs: introduce tempfsid test group
[U]      [257d00e13dca] btrfs: create a helper function, check_fsid(), to verify the tempfsid
[N]      [e6c1d2ab76a9] btrfs: verify that subvolume mounts are unaffected by tempfsid
[N]      [408376708514] btrfs: check if cloned device mounts with tempfsid
[U]      [5673516f9824] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
[U]      [3ec2d4378c6c] btrfs: introduce helper for creating cloned devices with mkfs
[N]      [0a50ae6c2006] btrfs: verify tempfsid clones using mkfs
[N]      [4af68c15504d] btrfs: validate send-receive operation with tempfsid.
[N]      [a6c984e10159] btrfs: test tempfsid with device add, seed, and balance

Anthony Iliopoulos (2):
[U]      [cc23dcb3ebe6] generic/68[12]: use the dir blocksize for xfs filesystems
[U]      [28928ea7af86] generic/682: update and fix-up golden output

Filipe Manana (6):
[N]      [faabc4852ad9] btrfs: test incremental send on sparse file with trailing hole
[U]      [15c084fe1137] btrfs: require no nodatacow for tests that exercise compression
[U]      [45d779c9d241] btrfs/173: make the test work when mounting with nodatacow
[U]      [d9d267ada5a0] btrfs/299: skip test if we were mounted with nodatacow
[U]      [07e9d3d39c3c] btrfs: require no nodatacow for tests that exercise read repair
[U]      [3f740470e96b] generic/736: fix a buffer overflow in readdir-while-renames.c

Johannes Thumshirn (3):
[U]      [43f4d620203e] filter.brtfs: add filter for conversion
[U]      [fe6326040eb3] filter.btrfs: add filter for btrfs device add
[N]      [8c9102789fec] btrfs: check conversion of zoned fileystems

Luis Chamberlain (1):
[U]      [cb1f76a28453] common/config: fix CANON_DEVS=yes when file does not exist

Martin Jansa (1):
[U]      [a8fbb364834f] tests/*/Makefile: make sure group.list DIRT exists before install

Qu Wenruo (4):
[N]      [00989655e212] btrfs: validate inconsitent qgroup won't leak reserved data space
[U]      [779ae21a305d] btrfs: btrfs/224 do not assign snapshot to a subvolume qgroup
[U]      [662db2673538] btrfs: detect regular qgroup for older kernels correctly
[U]      [9b6df9a01ac8] btrfs/016: fix a false alert due to xattrs mismatch


Code Diffstat:

 common/btrfs                | 76 ++++++++++++++++++++++++++++++++++++-
 common/config               |  2 +-
 common/filter.btrfs         | 15 ++++++++
 common/rc                   | 29 ++++++++++++--
 doc/group-names.txt         |  1 +
 src/readdir-while-renames.c | 10 ++++-
 tests/btrfs/016             | 53 +++++++++++---------------
 tests/btrfs/024             |  1 +
 tests/btrfs/048             |  1 +
 tests/btrfs/059             |  1 +
 tests/btrfs/138             |  1 +
 tests/btrfs/140             |  3 +-
 tests/btrfs/141             |  2 +
 tests/btrfs/157             |  2 +
 tests/btrfs/158             |  2 +
 tests/btrfs/173             |  5 +++
 tests/btrfs/215             |  2 +
 tests/btrfs/224             |  6 +--
 tests/btrfs/234             |  1 +
 tests/btrfs/265             |  2 +
 tests/btrfs/266             |  2 +
 tests/btrfs/267             |  2 +
 tests/btrfs/268             |  2 +
 tests/btrfs/269             |  2 +
 tests/btrfs/281             |  1 +
 tests/btrfs/289             |  2 +
 tests/btrfs/299             |  3 ++
 tests/btrfs/303             | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/303.out         | 24 ++++++++++++
 tests/btrfs/311             | 87 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out         | 24 ++++++++++++
 tests/btrfs/312             | 78 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out         | 19 ++++++++++
 tests/btrfs/313             | 52 +++++++++++++++++++++++++
 tests/btrfs/313.out         | 16 ++++++++
 tests/btrfs/314             | 78 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out         | 23 ++++++++++++
 tests/btrfs/315             | 91 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out         | 10 +++++
 tests/btrfs/316             | 59 +++++++++++++++++++++++++++++
 tests/btrfs/316.out         |  2 +
 tests/btrfs/317             | 67 +++++++++++++++++++++++++++++++++
 tests/btrfs/317.out         |  9 +++++
 tests/btrfs/Makefile        |  2 +-
 tests/ceph/Makefile         |  2 +-
 tests/cifs/Makefile         |  2 +-
 tests/ext4/Makefile         |  2 +-
 tests/f2fs/Makefile         |  2 +-
 tests/generic/681           |  2 +-
 tests/generic/682           | 10 ++++-
 tests/generic/682.out       |  2 +-
 tests/generic/Makefile      |  2 +-
 tests/nfs/Makefile          |  2 +-
 tests/ocfs2/Makefile        |  2 +-
 tests/overlay/Makefile      |  2 +-
 tests/perf/Makefile         |  2 +-
 tests/selftest/Makefile     |  2 +-
 tests/shared/Makefile       |  2 +-
 tests/tmpfs/Makefile        |  2 +-
 tests/udf/Makefile          |  2 +-
 tests/xfs/Makefile          |  2 +-
 61 files changed, 942 insertions(+), 62 deletions(-)
--
Zorro Lang
zlang@kernel.org

--Ls7fEUR7l19B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmXkcTwACgkQlNbPkfr2
tMyemxAAsOj7HlXyriXRTFzlEmTw0wcYvjYV5zF5AUVdw1vvvGf3JrNbLy9r6M3r
wHgmcDh2iqnBiO65e+v3aUYksRBxmcw32Yt+if3AAvW0mLgpG+ynthWXL2oZ4pEA
wZ8yK1BJmRSfCjrNrKTqQW8qWcK1DysMvz8n5idnOdyoVP2E3a8XKx4xwWkYeCwn
MONVnLyLodWfHi7LqeRYuLZ59viwavWROpc4ot6jHGvTUpkC7EjdgiCLWGD7VisI
rBxXY0tclFFD54Q5r5TPAO5kDWx41X4IibL0Iwr+E4BPqOPrRfWFRa0pMoLQkbYG
ayZVreVN3Ap1Xxin+Q3JKsBd/7I2UE3qJkKh3BJ4R5LjZXJbpZkOZ+rAsTefJWHm
FikIq7g3PVXVwPjYTJWt4vjPhLsJihdeI/jcWjmaZVa6PWujtwfu314zTxgwBMWx
UtwFAI3meHPye9gfRHPbRYLrHyDDbrg6EQshAsxk0ugPyJ++B4f0OWf0uz8kwfQA
wYSphpVPS8xbqHa/unVwvP+BR+O2h/B0js/du71H8eVGz/yK787MIjkDqixqFxHD
ZQTBwdifX6/67FkpWsPn/ydr7ECw2Qai+NAzIKymNdQ5I/yO1MKr374FzFaKNdT3
0JHSxWeV0U6aMTzI9Z3oYVwsSqpUvLwB6YrDGSyP5fDj1gvHFww=
=VEra
-----END PGP SIGNATURE-----

--Ls7fEUR7l19B--
