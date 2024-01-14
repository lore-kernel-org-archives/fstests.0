Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE903D7A
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCndQJa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEDDC433F1;
	Sun, 14 Jan 2024 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705239775;
	bh=IwKqgm0ZsLEqljvgusND3NamEDqaeIvs/2LfgzeuX7c=;
	h=Date:From:To:Subject:From;
	b=GCndQJa2FWTp+cxiTdlN+7btEIQ0TgwvHt8Fa/G5PxmYOrSqt7YOdR3yjXhJgzsi+
	 QzLumOhxpWP6nPtO/6NMm2JYpFNHgFo4HdrMcbecB/XGyRNGwmaa80uCX0SC4RF95s
	 nUVKTLy426RVYGLc+QABLwgVWlf3fIsumCsVEC5PFCWcVZMOk+y8AxP7RNHAgvBYp/
	 62Ygeepcg/Ng2gNC6XDUs5GAq2/0Z+HsrSpobB7tvWIKyzVrJOJ1CMgdH+rK4CwOeG
	 3LY8HJZJOF7KB+YLml7bJ0bL3M1agvXVlDT2lU1Cl+ZuEzfJm5NJ+BcN/RBaHiEa/a
	 D/ztUGTSUnvVw==
Date: Sun, 14 Jan 2024 21:42:53 +0800
Message-ID: <6d4fa459cad96ef3be69c9526b3236f1@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.01.14
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zlgpLuIowyiD"
Content-Disposition: inline


--zlgpLuIowyiD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.01.14 release.

Release Notes:
1) This's the first release of 2024, contains 30 patches. Besides some fixes
and updates, there're 8 new test cases -- btrfs/304~309, xfs/605, generic/739.
Thanks Anand helped to test and co-maintain btrfs part.
2) XFS supports metadump v2, so add testing for this part.
3) Fscrypt part's update, new test for custom crypto data unit size.
4) NFS decides to skip g/465 and g/732.

More updates and fixes refer to below, thanks for these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

c46ca4d1f6c0 generic: add test for custom crypto data unit size

New commits ([N]ew, [U]pdate):

Amir Goldstein (1):
[U]      [a5c3a12796cf] overlay: create helper _overlay_scratch_mount_opts()

Anand Jain (1):
[U]      [08dbb837f1a8] common: add _filter_trailing_whitespace

Andreas Gruenbacher (1):
[U]      [3b2312704846] generic/390: Fix test number in comment

Chandan Babu R (5):
[U]      [e443cadcea48] common/xfs: Do not append -a and -o options to metadump
[U]      [b0d63321c777] common/xfs: Add function to detect support for metadump v2
[U]      [5011eb3e04e8] _scratch_xfs_mdrestore: Pass scratch log device when applicable
[U]      [15356e83bed7] xfs: Add support for testing metadump v2
[N]      [045050256e1a] xfs: Check correctness of metadump/mdrestore's ability to work with dirty log

Christoph Hellwig (4):
[U]      [4d04485207fe] xfs: check that the mountpoint is actually mounted in _supports_xfs_scrub
[U]      [e0864962b2d6] xfs: add a _require_scratch_xfs_scrub helper
[U]      [35c3794f9d92] xfs/262: call _require_scratch_xfs_scrub
[U]      [ab0c766d2017] xfs/506: call _require_scratch_xfs_scrub

Chung-Chiang Cheng (1):
[U]      [66c7b4a49404] README: add a missing necessary package

Eric Biggers (4):
[U]      [72dad8092e62] fscrypt-crypt-util: rename block to data unit
[U]      [8716ac9a3eea] common/rc: fix _require_xfs_io_command with digits in argument
[U]      [077698f5211d] common/encrypt: support custom data unit size
[N]      [c46ca4d1f6c0] generic: add test for custom crypto data unit size

Filipe Manana (1):
[U]      [b35af508fb98] btrfs/303: add git commit ID to _fixed_by_kernel_commit

Jeff Layton (2):
[U]      [8729dc6d13cb] generic/465: don't run it on NFS
[U]      [4fd042e0465c] generic/732: don't run it on NFS

Johannes Thumshirn (9):
[U]      [103e0a619bdc] fstests: doc: add new raid-stripe-tree group
[U]      [81af9975ac4d] common: add _require_btrfs_no_nodatacow helper
[U]      [91cb623078b3] common: add _require_btrfs_free_space_tree
[U]      [807b93a1cec7] common: add filter for btrfs raid-stripe dump
[N]      [9d812702919c] btrfs: add fstest for stripe-tree metadata with 4k write
[N]      [ba96d1853ac0] btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
[N]      [102b2efcf91e] btrfs: add fstest for writing to a file at an offset with RST
[N]      [477f3f136125] btrfs: add fstests to write 128k to a RST filesystem
[N]      [26990e6db2a6] btrfs: add fstest for overwriting a file partially with RST

Omar Sandoval (1):
[N]      [3a0381a4595e] btrfs: test snapshotting a deleted subvolume


Code Diffstat:

 .gitignore                         |   1 +
 README                             |   3 +-
 common/btrfs                       |  17 ++++
 common/encrypt                     |  42 ++++++---
 common/filter                      |   5 ++
 common/filter.btrfs                |  15 ++++
 common/overlay                     |   8 +-
 common/populate                    |   2 +-
 common/rc                          |   2 +-
 common/xfs                         |  42 +++++++--
 doc/group-names.txt                |   1 +
 src/Makefile                       |   2 +-
 src/fscrypt-crypt-util.c           |  93 +++++++++----------
 src/t_snapshot_deleted_subvolume.c | 102 +++++++++++++++++++++
 tests/btrfs/303                    |   2 +-
 tests/btrfs/304                    |  58 ++++++++++++
 tests/btrfs/304.out                |  58 ++++++++++++
 tests/btrfs/305                    |  63 +++++++++++++
 tests/btrfs/305.out                |  82 +++++++++++++++++
 tests/btrfs/306                    |  61 +++++++++++++
 tests/btrfs/306.out                |  75 ++++++++++++++++
 tests/btrfs/307                    |  58 ++++++++++++
 tests/btrfs/307.out                |  65 ++++++++++++++
 tests/btrfs/308                    |  62 +++++++++++++
 tests/btrfs/308.out                | 106 ++++++++++++++++++++++
 tests/btrfs/309                    |  27 ++++++
 tests/btrfs/309.out                |   2 +
 tests/f2fs/002                     |   6 +-
 tests/generic/390                  |   2 +-
 tests/generic/465                  |   2 +-
 tests/generic/732                  |   4 +-
 tests/generic/739                  |  31 +++++++
 tests/generic/739.out              |  11 +++
 tests/overlay/011                  |   2 +-
 tests/overlay/035                  |   3 +-
 tests/overlay/052                  |   4 +-
 tests/overlay/053                  |   4 +-
 tests/overlay/062                  |   2 +-
 tests/overlay/079                  |   4 +-
 tests/overlay/085                  |   4 +-
 tests/xfs/129                      |  97 +++++++++++++++++---
 tests/xfs/129.out                  |   4 +-
 tests/xfs/234                      |  97 +++++++++++++++++---
 tests/xfs/234.out                  |   4 +-
 tests/xfs/253                      | 118 ++++++++++++++++++++----
 tests/xfs/262                      |   3 +
 tests/xfs/291                      |  25 +++++-
 tests/xfs/336                      |   2 +-
 tests/xfs/432                      |  29 ++++--
 tests/xfs/432.out                  |   3 +-
 tests/xfs/503                      |  96 ++++++++++++--------
 tests/xfs/503.out                  |  12 +--
 tests/xfs/506                      |   3 +
 tests/xfs/556                      |   2 +-
 tests/xfs/605                      | 178 +++++++++++++++++++++++++++++++++++++
 tests/xfs/605.out                  |  14 +++
 tests/xfs/716                      |   2 +-
 57 files changed, 1628 insertions(+), 194 deletions(-)
--
Zorro Lang
zlang@kernel.org

--zlgpLuIowyiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmWj5FsACgkQlNbPkfr2
tMyJjA/+N/S5vTz5vUjvxLQzWAvRaD19rEbLaWLqo4S3ljCIEKgTrABoEhAlDu+f
lLBNNQ6GY8pe58YSRurXSK2mGdqClKb0QTlxSG7QoMRNqMisSOSQ6RRBtOvnCOHm
xC2SqbtA/DQePHFyJijONTgQjHeCPVsKUL6KQ8y38Ju24MxEsUKwOjPfKniear19
5iLxX01mZwOvSgXecXByOh+NhT2nEaJhrh6kZAznPoBsrPjAz+XuS/x2ceaoOJb8
UW61QuJB2PRMQjvQN9e6VZM2OrWVIevEYVJKrNe8VHvzkRN+/InI/Q8I7EAwX7Mu
8sJofrAuF4TrE801b6TyVaEF6X2aQKi/G39PHK5hA1p1GDFTWLc2rhjTk9PO2zTr
Zc4Vg+qhLDXuh0ngrJswBR2bTj1QMqbcC0XDgTwMjLiSl9zhNczFPYPE0Is1s9Ka
g5JqnEnyavAtGe9fzl92HNiuGfY7/TEuTAOcAJ5qFRvJcRppOQwn5DyGiZHAfSE/
siBWfIj+vIjfn6eq23jXghF0qgnlliJoqkV6kTws6pEoPTzu193OHOf+xkh0y0wc
JoZ2oIfi6OSrGwrkjgaARznpZQvZRxbRxY14ujBzF3sbZa0ALUvrpJQaxfyXoqvP
CLejAiKzjXbYxAhvKWnMOB4vTFJu05Ien1rYJpet7XlwXwCaGbo=
=73Xm
-----END PGP SIGNATURE-----

--zlgpLuIowyiD--
