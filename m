Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283E24A07
	for <fstests@vger.kernel.org>; Sun,  4 Feb 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058131; cv=none; b=OVPvsWyOBsdOC6j9aVcfT2E5ebIKXCUJnnsYukzKsgP7eyyxrINdS35Cpdo81wg0Rov126l8uR7aJmiIkCQpeq8Gxr4QwNQGAzMHEULFSa5GYdtEbL2M7+dlozXk94Au3NlIE4+Dh7ia6x2C1bcMVHtdeBz+Ppg0Dy8x8V0LnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058131; c=relaxed/simple;
	bh=MAWSwByPlIMZFia8BsOiSxRXRHPIlyrL48663CCfDOg=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=WasEzJVIh+FXRYxyNKSUdVJTO4D6WhpTxRyyrE1V6o+vQvaePkvxBZ9iQrwQ+91xTYhmBqEg+/qgJf2dCjzcaHT2evhHB8v0LFigYSiImr2MUbWtYH5QzydDdgB23DNnfHIXjDVFFvnExBFj2MRAMD9QvvQVORlhTS4IVd8HGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUZ5tnon; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUZ5tnon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38625C433F1;
	Sun,  4 Feb 2024 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707058130;
	bh=MAWSwByPlIMZFia8BsOiSxRXRHPIlyrL48663CCfDOg=;
	h=Date:From:To:Subject:From;
	b=cUZ5tnonRn4Hgp01tC+4jPAd8NVTmm+FDV3gnK8zENDBo4/x6cQ9e8yNsSINx3Cr0
	 S6eJ+21Vkuo00ibknszos37qfSPcf5PYTtNFK1eeseftGNGJj6BNMh3d/ZK2qhQ7zo
	 PbdQNYTBC7fGsceuJCmsfoqGFjLNAbWUIaxxSoGZ5UYen+OQhTIfQdVTM4jmz24xLJ
	 O8R6oD2jjbZFCRQLh/D00+7Uuro+nAM2J3U81Ts/vJepJe2BRqgiytW8OYp2AHIHRc
	 1TBSLPRN3CYF1xQzubxc1mE22EVAJ2EZOUwNHHtwTvKnLYEGQ1q4W8PmSy0PBCEBui
	 ry1A8eMShRNXg==
Date: Sun, 04 Feb 2024 22:48:47 +0800
Message-ID: <e981f7abb8361cbd6391b290022446b1@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.02.04
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kSIlDR7S1j0Y"
Content-Disposition: inline


--kSIlDR7S1j0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.02.04 release.

Release Notes:
1) There's 4 new test cases in this release -- btrfs/310, generic/740, xfs/601,
   and xfs/606.
2) btrfs/303 is removed.
3) Supports XFS metadump V1 and V2 testing, refer to common/xfs_metadump_tests
   new file (might be renamed to common/metadump if more other fs need).
4) Some fixes and updates for UBIFS, BCACHEFS and NFS testing, welcome more
   updates for more filesystems.
5) Some updates/fixes for source building, if anyone find building issues in
   this release, please report to us.

More details refer to below, thanks for all your contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

9b63adb69add t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2

New commits ([N]ew, [U]pdate, [D]elete):

Alexander Aring (1):
[N]      [56625c897fd9] generic: add fcntl lock corner cases tests

Anthony Iliopoulos (2):
[U]      [42f3cb7e56e3] src/af_unix: drop unused offsetof macro definition
[U]      [79d98d94e58c] build: remove unused m4 macros

Boris Burkov (1):
[D]      [a6e196af46cc] btrfs: Remove btrfs/303

Darrick J. Wong (10):
[U]      [e7eadc3ee835] generic/256: constrain runtime with TIME_FACTOR
[U]      [8c8be04c1065] common/xfs: simplify maximum metadump format detection
[U]      [42f797643529] common/populate: always metadump full metadata blocks
[U]      [56ccc8cc69d1] xfs/336: fix omitted -a and -o in metadump call
[N]      [85c1e0f518ff] common: refactor metadump v1 and v2 tests
[U]      [1bdc3a5f1c9a] xfs/{129,234,253,605}: disable metadump v1 testing with external devices
[U]      [329671426287] xfs/503: test metadump obfuscation, not progressbars
[N]      [c31a500edc04] xfs/503: split copy and metadump into two tests
[U]      [7e2bf5955c2d] common/xfs: only pass -l in _xfs_mdrestore for v2 metadumps
[U]      [6f4223b6865f] xfs/122: fix for xfs_attr_shortform removal in 6.8

Jeff Layton (2):
[U]      [ab217141c2fb] common/rc: NFSv2/3 do not support negative timestamps
[U]      [6c7f9b29e71d] src/t_mtab.c: increase the lock timeout to 120s

Li Zhijian (1):
[U]      [0160ab05979d] gitignore: Add missing /src/t_reflink_read_race

Pavel Reichl (1):
[U]      [f681ebf32b24] xfs/598: Add missing "fixed_by" hints

Qu Wenruo (1):
[N]      [dfdd248c648a] btrfs: verify the read behavior of compressed inline extent

Richard Weinberger (2):
[U]      [98dcd8c239d8] generic/020: Compute correct max_attrs for UBIFS
[U]      [1cf74a17a74e] generic/597,598: Require groups

Ritesh Harjani (IBM) (1):
[U]      [4cc6188cd89f] xfs/604: Make test as _notrun for higher blocksizes filesystem

Su Yue (2):
[U]      [eca4b512935a] fstests: introduce MKFS_BCACHEFS_PROG for bcachefs
[U]      [cbde2e1269dc] common/rc: improve block_size support for bcachefs

Yang Xu (1):
[U]      [9b63adb69add] t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2

Zorro Lang (1):
[N]      [fb013bd945b8] xfs: test xfs_growfs with too-small size expansion


Code Diffstat:

 .gitignore                         |   1 +
 acinclude.m4                       |   5 -
 common/config                      |   4 +-
 common/populate                    |   2 +-
 common/rc                          |  63 ++++++--
 common/ubifs                       |   9 ++
 common/xfs                         |  51 +++++-
 common/xfs_metadump_tests          | 138 ++++++++++++++++
 configure.ac                       |   2 +-
 m4/manual_format.m4                |  17 --
 m4/package_libcdev.m4              |  95 -----------
 m4/package_ncurses.m4              |  27 ----
 m4/package_pthread.m4              |  19 ---
 m4/package_types.m4                |  50 ------
 m4/package_xfslibs.m4              |  28 ----
 m4/visibility_hidden.m4            |  22 ---
 src/Makefile                       |   2 +-
 src/af_unix.c                      |   2 -
 src/fcntl_lock_corner_tests.c      | 322 +++++++++++++++++++++++++++++++++++++
 src/t_mtab.c                       |   2 +-
 src/t_snapshot_deleted_subvolume.c |  10 +-
 tests/btrfs/303                    |  77 ---------
 tests/btrfs/303.out                |   2 -
 tests/btrfs/310                    |  83 ++++++++++
 tests/btrfs/310.out                |   2 +
 tests/generic/020                  |   6 +
 tests/generic/256                  |   7 +
 tests/generic/597                  |   2 +
 tests/generic/598                  |   2 +
 tests/generic/740                  |  27 ++++
 tests/generic/740.out              |   2 +
 tests/xfs/122.out                  |   2 +
 tests/xfs/129                      |  91 +----------
 tests/xfs/234                      |  92 +----------
 tests/xfs/253                      |  90 +----------
 tests/xfs/284                      |   4 +-
 tests/xfs/291                      |  32 ++--
 tests/xfs/336                      |   2 +-
 tests/xfs/432                      |  31 +---
 tests/xfs/503                      |  82 ++--------
 tests/xfs/503.out                  |   6 +-
 tests/xfs/598                      |   5 +
 tests/xfs/601                      |  54 +++++++
 tests/xfs/601.out                  |   4 +
 tests/xfs/604                      |   4 +-
 tests/xfs/605                      |  92 +----------
 tests/xfs/606                      |  56 +++++++
 tests/xfs/606.out                  |   2 +
 48 files changed, 887 insertions(+), 843 deletions(-)
--
Zorro Lang
zlang@kernel.org

--kSIlDR7S1j0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmW/o60ACgkQlNbPkfr2
tMxk3Q/9GFmfufOL7+0oA4zqbhDcqSWnO2OblJfAwlUOREjwpbHmuNuVyN9YQ7D6
haLoizIb8cjVhyzDCvpUed81kP+rA0Dv8jUTuobrXbqu6iZgm8XQn+Em5VKbTl+V
wgxU5IlEZRjEq8wo0uddW7w7ISwWnnu3ZtynbT9pwyKqXf3K0QI45h3Bu+wqXmPb
06oTn089srgfrniiXcbq84O4K4coW3ISN+6VzUya8T1HWPNAeujbQPq6dDHMCuSp
mRhcuZEJKZrcMovZuu2R3Y+6lwU/Rc6XHGgL2PaYfyDTQ8QYnI9BZJLL17VN7IyS
uVZawPH9Z2SkB1t636WF5AvPQlqkix1rk2Kpb2C1L2ZU0dzYZ8h1nKOt0tXcalNb
9qX7wJ5UBqos93Het1zrEJShnMkxMJ2LGs3z8W3x8ddDqA20g48vG2+VHOQzKN9c
A52GRwGUpIrW0QBqsDgec/TNUCioJW9OdJUJZ1rM83PpY4zXCH1xmYxTeodhabCa
FKNTfNTpr5eyZvMfkpLFFsQ7lC4fT/pYqz4aRrf/0K+p1IDacVoRsndesZplAAgk
t9GNGp8SpMITOSQlBVlj1o/1W61ovpkJhybeJXSSX2Gdhx7/D/XAqaFoUcXB3Qs/
Jl1CJ157UBC2n5P1E7x/LFavmI6REtM1HsKt6k4ZdRYJx1WAeeo=
=Zbjy
-----END PGP SIGNATURE-----

--kSIlDR7S1j0Y--
