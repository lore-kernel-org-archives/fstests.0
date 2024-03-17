Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF261BDC4
	for <fstests@vger.kernel.org>; Sun, 17 Mar 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710684138; cv=none; b=NObbq9tk5kFDx5RW19dbNW4U8gELLpn98MvXro+0dT2XLyB7OrCyog61Nwn76TfgjnDUtKy5keNq4iB6pjXRbySpStGg5oiGUwNfalTPEKCzFrQ1l8LssiBdZDMKcot2l1yxtyOtaTD6Y5hA1m66jESv8056Kfa32qoy5g7fe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710684138; c=relaxed/simple;
	bh=DCB1idMndcZYOLUS+YtirsfcYXXHApueHlRHqaFT3Vw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=cnkDFouxFPXCKDNoevvaIVcWMqIY5ApGcZ9LTXMVie4Hlh8wKPZLRJV/K0Lx5h/69As0TqGKW1k1YSTKDbU0wSy4ACQGlsXawvhW9jgv+MyiW0Ofn5DOb9soayk+Q96l0QxAjBZtNVzdtMRSiET3NNaAwGGJWllZJoW8GxLpZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p52EKmC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p52EKmC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F4EC433C7;
	Sun, 17 Mar 2024 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710684138;
	bh=DCB1idMndcZYOLUS+YtirsfcYXXHApueHlRHqaFT3Vw=;
	h=Date:From:To:Subject:From;
	b=p52EKmC1XuiDDKysjYSGhnYUHlz6KZQapXZHqPOcbWP+lfANo7ScPbyTAwNDrIoou
	 OI6OSWWhcFJqWIU05OyAU8UdWoWjHdu1gJAth/6bPFFJ8zPSPma3gBzkhmTz5SgSh0
	 aGQR4//Lx47u8IMm3JsZFyPWrMlBme4wCQ9olpvU7XyqfQlV3BKo2ogFA65UtabLX6
	 9ASYA1Sa2xEYGV8G4Q7vF2tM6wvTHT1tQOzPBqlFHYpN5kk1Ytk+3U0H17K5pbUbjn
	 yailU7WpD/dqO734Bm7s/FbWqDlLfTb3iR2Db7Cpzt1Cogvt5eNFX8lWpdK1JfVKjC
	 3x6VqzpCKRrxA==
Date: Sun, 17 Mar 2024 22:02:13 +0800
Message-ID: <fb2f60b1aeb1b031f6eda8868b73887a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.03.17
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="znGUu1YkAN61"
Content-Disposition: inline


--znGUu1YkAN61
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.03.17 release.

Release Notes:
1) There're 32 commits in this release, but most of them are fixes and updates.
   Then One new test cases -- xfs/607. Another new case btrfs/320 is splited from
   old btrfs/022.
2) As upstream dm-error supports zoned devices now, so fstests allow dm-error
   tests on zoned devices too. But it might cause some failures on old kernel,
   if you test with zoned devices.
3) Some of cases are improved for 64k blocksize testing, feel free to give it
   a try.

There're also lots of fixes or improvements, more details refer to below. Thanks
for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

ec5b77f70e60 fstests: add missing commit IDs to some tests

New commits ([N]ew, [U]pdate):

Anand Jain (1):
[U]      [2b0216017bc2] common/rc: specify required device size

Christoph Hellwig (4):
[U]      [5e1e51df9f29] shared/298: call fs commands on the loop device
[U]      [926ae266c86a] shared/298: run xfs_db against the loop device instead of the image file
[U]      [cfb92ce9070c] common: dm-error now supports zoned devices
[U]      [7bb78927c0f5] generic/392: stop checking st_blocks

Darrick J. Wong (10):
[U]      [d46a46c7d5d0] generic/604: try to make race occur reliably
[U]      [ed6967784854] xfs/155: fail the test if xfs_repair hangs for too long
[U]      [0943fadcf0e9] generic/192: fix spurious timeout
[U]      [a3ce52894e0e] generic/491: increase test timeout
[U]      [27f314276da9] xfs/599: reduce the amount of attrs created here
[U]      [480bf0025bff] xfs/122: update test to pick up rtword/suminfo ondisk unions
[U]      [b41b9ca96f69] xfs/43[4-6]: make module reloading optional
[N]      [70fc4244b7dc] xfs: test for premature ENOSPC with large cow delalloc extents
[U]      [7a97d9c0fa1b] misc: fix test that fail formatting with 64k blocksize
[U]      [c9d50e4d1c2a] generic/574: don't fail the test on intentional coredump

Disha Goel (1):
[U]      [7a338a6af80d] xfstest: add detection for ext4.h presence in configure.ac

Filipe Manana (2):
[U]      [07fa85f11232] btrfs: fix grep warning at _require_btrfs_mkfs_uuid_option()
[U]      [ec5b77f70e60] fstests: add missing commit IDs to some tests

Josef Bacik (8):
[U]      [18ecbf559bc5] btrfs/011: increase the runtime for replace cancel
[U]      [51f280cfa124] btrfs/012: adjust how we populate the fs to convert
[U]      [46bc2d68fa74] btrfs/131: don't run with subpage blocksizes
[U]      [e990496ffc09] btrfs/213: make the test more reliable
[U]      [94937700f4ee] btrfs/271: adjust failure condition
[U]      [f682432926a0] btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
[U]      [3552178f39be] btrfs/291: remove image file after teardown
[N]      [512dba4fdbfc] btrfs: test normal qgroup operations in a compress friendly way

Li Zhijian (1):
[U]      [d76c4886ba83] xfs: Fix no executable permission

Qu Wenruo (1):
[U]      [8000febb32af] fstests: btrfs/121: allow snapshot with invalid qgroup to return error

Su Yue (1):
[U]      [b3ff58fa319a] btrfs/172,206: call _log_writes_cleanup in _cleanup

Zorro Lang (3):
[U]      [46b783fe67fc] fsstress: check io_uring_queue_init errno properly
[U]      [7bad5527e2bc] fsstress: bypass io_uring testing if io_uring_queue_init returns EPERM
[U]      [790a9e7c3c94] common/rc: notrun if io_uring is disabled by sysctl


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

--znGUu1YkAN61
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmX2968ACgkQlNbPkfr2
tMwDLhAArBdi2QPcraNixtze9x1RBHkoAdByWI9ItFVREkLSksXO0C20NbflURDR
tT/B4iSqNkTEjFsySOHrGasKslBsUpLbVNhBXWS2aYA3MRcW5AkI0rDHI8QVb6tp
QXljgdBgIPw7NE8OnbvKhqdeAP66M0Y8+1EZCWlnv1zzmAL6WYpk/EgY24NuWBc5
/nIq/9xn/520GK167aExGP80m4O8jMKM799B++4C5S+MAzaKJj4W0j7xU7ZMZuK/
h0bksNDEVEdZOODVxTxJ5GXoCY31JkZ7z3V52/CDwKGNBGCQ1AqJGFxTDa3EjWEq
eCIKYNaccxxNC72kgpOf+yNvEhasnYHZWYuyc6NumWN9BHqFEkN1QpGtPIgwGZV7
aeOhiUKA/sFfbGo6atr8ToioysMMioqPHdwSbfGUBnN1UBQBYdy6naP1BrRtwLKH
C9XMdA3aTqLU0O/VhQx/9lKUuO5Th7fwef1mgl8zg/8MtKdedvSCcv1/kkpy/DkL
gp50pjU/zQBHlNUkMeK9TA42MEXOS91r1kPns4kpu448p142q5LXFKuvVPq/kmQk
vcwOsCJ+WUEz7ml0kH9kdmm9XB2cze9OpAVcw7jumdSodgCYJwWSpGLOeCxrFam9
SeWUJJq8FYP6nvj+YuU3fVcWjvO34hZYPN9c8SBsAnGL2WU5ENk=
=GLeI
-----END PGP SIGNATURE-----

--znGUu1YkAN61--
