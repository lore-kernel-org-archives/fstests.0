Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037D2595
	for <fstests@vger.kernel.org>; Thu, 27 Jun 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496939; cv=none; b=K8W9QkxW3ZLRba5dNZ1XPWwuejK4VNZtrQfesfuvTmGKrnmyawvfxmJWrJflAJMQxDXL28B6SSHVWMzXzFz+aEQxPiqJMyd7btBN3kajq7vujlCOo6BBE7Bk8AkLo1NyqIV39obE0KdlXtugcXDBzQ2Nf999hmbLXsbVblH8zVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496939; c=relaxed/simple;
	bh=6h7khayZLRCAcw3yabaifhJggPFpf3lQwavTJsm6Pik=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Cil6obdJ/SbE93DAftPXCyptQRCe2DgEx1eGn0GL7bYw/8Y8EiADuM+a7NbOwAQnS3jcdaN7TF5wqJ3sLTYN3PsWOxJE85XzdxGaOlziBFk4gfo8QXHLeVh2gNTHQY5JT1K53LrR540E+5LSeEGAzfjGRqGUPSmXUR1Lnum6aBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjZQ9fAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjZQ9fAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9070FC2BBFC;
	Thu, 27 Jun 2024 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719496939;
	bh=6h7khayZLRCAcw3yabaifhJggPFpf3lQwavTJsm6Pik=;
	h=Date:From:To:Subject:From;
	b=RjZQ9fAoNwrpobiSwsAqPcykAuJUDsV4K4z6sZy/olfmK2i61+0uVILStei7Nae14
	 t4rz8dWz+YZQ0SA1tiz5B+jH7AS2j0BzepiiTNpB3psEk3KGAt1YqK+auViwxMHEL6
	 dS1/NKbqIUz9tXoZZf2CkFhLVhZTTi5LSecSTpYtE9RRGUky5x6jXuBlV87+BZ7Ph8
	 GTvEi8vZNtL5rlPVJx7o/lkTQhUoHU2lfF3bSAmoMNOEuDMake8bDPAPUUmAJDs9TH
	 UvKNGGVFkqJ9qURXooCq/+60rmSwKO9fYBVAyr7iwl4pH2GxwD6CGjNzU/Xo+URgND
	 Uw4gj0tBMkPmQ==
Date: Thu, 27 Jun 2024 22:02:15 +0800
Message-ID: <04d25172526417f6d7f398b423c94406@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.06.27
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9yHMKeiE12Vl"
Content-Disposition: inline


--9yHMKeiE12Vl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.06.27 release.

Release Notes:
This release contains lots of new test cases, include:
   - g/753, x/618, x/619 and x/620 are for xfs parent pointer feature test.
   - x/614 for xfs "concurrency" mkfs test.
   - g/752, x/615, x/616, x/617 are for exchangerange test.
   - x/621, x/622, x/623, x/624, x/625, x/626, x/627, x628 are for xfs dirtree
     corruption and online repair test.
   - g/754 is for a known xfs regression test.
   - g/749, g/750, g/751 are for LBS (Large Block Size) test.

Besides that, there're more bug fixes and updates refer to below, thanks
for all of these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

98611b1acce4 generic: test creating and removing symlink xattrs

New commits:

Allison Henderson (4):
      [74a53fa09d08] common: add helpers for parent pointer tests
      [dd4f7838ed6e] xfs: add parent pointer test
      [fc10d1eff51f] xfs: add multi link parent pointer test
      [5ef34fa33bbd] xfs: add parent pointer inject test

Christoph Hellwig (1):
      [9cca19c674a9] xfs/073: avoid large recursive diff

Darrick J. Wong (23):
      [d4e72b9e6e26] xfs: test scaling of the mkfs concurrency options
      [eb5cfb9bf04b] misc: split swapext and exchangerange
      [5cb01028c5d1] misc: change xfs_io -c swapext to exchangerange
      [2a539c72f7be] generic/709,710: rework these for exchangerange vs. quota testing
      [6776f47285b6] generic/711,xfs/537: actually fork these tests for exchange-range
      [fd6fb29d5728] generic/717: remove obsolete check
      [7d8534eb0437] ltp/{fsstress,fsx}: make the exchangerange naming consistent
      [0cfc17fe8d93] misc: flip HAVE_XFS_IOC_EXCHANGE_RANGE logic
      [b7c517b40aca] src/fiexchange.h: update XFS_IOC_EXCHANGE_RANGE definitions
      [e64ad1abb65e] xfs/122: fix for exchrange conversion
      [b94a18010007] xfs/206: screen out exchange-range from golden output
      [dd994f4c4827] exchangerange: make sure that we don't swap unwritten extents unless they're part of a rt extent
      [037594c3d866] generic: test recovery of extended attribute updates
      [84a7286768a3] xfs/206: filter out the parent= status from mkfs
      [2c3a1636ddf3] xfs/122: update for parent pointers
      [0c02207d61af] populate: create hardlinks for parent pointers
      [92a3b5ebc812] xfs/021: adapt golden output files for parent pointers
      [d9facbf8267b] xfs/{018,191,288}: disable parent pointers for these tests
      [82b5fc7c780b] xfs/306: fix formatting failures with parent pointers
      [60d7c25ed522] common/fuzzy: stress directory tree modifications with the dirtree tester
      [4de8fd7860a2] scrub: test correction of directory tree corruptions
      [bb8ff3588cd3] xfs/122: update for vectored scrub
      [98611b1acce4] generic: test creating and removing symlink xattrs

Dave Chinner (1):
      [3bf963a6c609] xfs/348: partially revert dbcc549317 ("xfs/348: golden output is not correct")

Eric Biggers (1):
      [8f5ce6b34fc6] generic/574: test corruption at more offsets

Filipe Manana (1):
      [c378a48b6bc4] generic/74[3,8]: add git commit ID for the fixes

Luis Chamberlain (5):
      [f32d4090203c] common: move mread() to generic helper _mread()
      [e4a6b119e522] fstests: add mmap page boundary tests
      [de4ae1ab2e94] fstests: add fsstress + compaction test
      [bc7387246018] _require_debugfs(): simplify and fix for debian
      [872977cfdeb4] fstests: add stress truncation + writeback test

Theodore Ts'o (3):
      [0d4d97d9dca2] ext4/059: disable block_validity checks when mounting a corrupted file system
      [0ae5d5d77ab1] ext4/045: use the large_dir feature to fix test failures with a 1k block size
      [3a789af2b1e8] generic/455: skip the test if the file system doesn't support journaling


Code Diffstat:

 common/parent                          |  209 +++++++
 common/populate                        |   42 ++
 common/rc                              |   65 ++-
 common/xfs                             |   30 +-
 configure.ac                           |    2 +-
 doc/group-names.txt                    |    1 +
 include/builddefs.in                   |    2 +-
 ltp/Makefile                           |    4 +-
 ltp/fsstress.c                         |   34 +-
 ltp/fsx.c                              |   43 +-
 m4/package_xfslibs.m4                  |   15 +-
 src/Makefile                           |    4 +-
 src/fiexchange.h                       |   86 +--
 src/global.h                           |   12 +-
 src/popdir.pl                          |   11 +
 src/vfs/Makefile                       |    4 +-
 src/xfsfind.c                          |    1 -
 tests/ext4/045                         |    3 +-
 tests/ext4/059                         |    5 +
 tests/generic/455                      |    3 +
 tests/generic/574                      |   51 +-
 tests/generic/709                      |   12 +-
 tests/generic/710                      |   14 +-
 tests/generic/710.out                  |    2 +-
 tests/generic/711                      |    4 +-
 tests/generic/712                      |   10 +-
 tests/generic/713                      |   42 +-
 tests/generic/713.out                  |   38 +-
 tests/generic/714                      |   40 +-
 tests/generic/714.out                  |   34 +-
 tests/generic/715                      |   26 +-
 tests/generic/715.out                  |   14 +-
 tests/generic/716                      |    4 +-
 tests/generic/717                      |   39 +-
 tests/generic/717.out                  |   32 +-
 tests/generic/718                      |   12 +-
 tests/generic/718.out                  |    2 +-
 tests/generic/719                      |    4 +-
 tests/generic/720                      |   10 +-
 tests/generic/721                      |    2 +-
 tests/generic/722                      |    8 +-
 tests/generic/723                      |   12 +-
 tests/generic/724                      |   10 +-
 tests/generic/725                      |    4 +-
 tests/generic/726                      |    4 +-
 tests/generic/727                      |    4 +-
 tests/generic/743                      |    2 +-
 tests/generic/748                      |    2 +-
 tests/generic/749                      |  256 ++++++++
 tests/generic/749.out                  |    2 +
 tests/generic/750                      |   63 ++
 tests/generic/750.out                  |    2 +
 tests/generic/751                      |  170 ++++++
 tests/generic/751.out                  |    2 +
 tests/generic/752                      |   45 ++
 tests/generic/752.out                  |    2 +
 tests/generic/753                      |   93 +++
 tests/generic/753.out                  |    2 +
 tests/generic/754                      |   58 ++
 tests/generic/754.out                  |    2 +
 tests/xfs/018                          |    4 +
 tests/xfs/021                          |   15 +-
 tests/xfs/021.cfg                      |    1 +
 tests/xfs/{021.out => 021.out.default} |    0
 tests/xfs/021.out.parent               |   64 ++
 tests/xfs/073                          |    3 +-
 tests/xfs/122.out                      |   12 +-
 tests/xfs/191                          |    3 +
 tests/xfs/206                          |    2 +
 tests/xfs/288                          |    4 +
 tests/xfs/300                          |    2 +-
 tests/xfs/306                          |    9 +-
 tests/xfs/348.out                      |    2 +-
 tests/xfs/443                          |    4 +-
 tests/xfs/614                          |   55 ++
 tests/xfs/614.cfg                      |    4 +
 tests/xfs/614.out.lba1024              |  177 ++++++
 tests/xfs/614.out.lba2048              |  177 ++++++
 tests/xfs/614.out.lba4096              |  177 ++++++
 tests/xfs/614.out.lba512               |  177 ++++++
 tests/xfs/615                          |   89 +++
 tests/xfs/615.out                      |   13 +
 tests/xfs/616                          |   73 +++
 tests/xfs/616.out                      |    2 +
 tests/xfs/617                          |  232 ++++++++
 tests/xfs/617.out                      |    2 +
 tests/xfs/618                          |  116 ++++
 tests/xfs/618.out                      |   69 +++
 tests/xfs/619                          |   69 +++
 tests/xfs/619.out                      | 1002 ++++++++++++++++++++++++++++++++
 tests/xfs/620                          |   85 +++
 tests/xfs/620.out                      |   14 +
 tests/xfs/621                          |   38 ++
 tests/xfs/621.out                      |    2 +
 tests/xfs/622                          |   38 ++
 tests/xfs/622.out                      |    2 +
 tests/xfs/623                          |  122 ++++
 tests/xfs/623.out                      |   19 +
 tests/xfs/624                          |  133 +++++
 tests/xfs/624.out                      |   25 +
 tests/xfs/625                          |  121 ++++
 tests/xfs/625.out                      |   21 +
 tests/xfs/626                          |  157 +++++
 tests/xfs/626.out                      |   32 +
 tests/xfs/627                          |  146 +++++
 tests/xfs/627.out                      |   30 +
 tests/xfs/628                          |   78 +++
 tests/xfs/628.out                      |    2 +
 tests/xfs/789                          |    4 +-
 tests/xfs/790                          |   10 +-
 tests/xfs/790.out                      |    2 +-
 tests/xfs/791                          |   10 +-
 tests/xfs/791.out                      |    2 +-
 tests/xfs/792                          |    4 +-
 tests/xfs/795                          |    2 +-
 115 files changed, 4974 insertions(+), 395 deletions(-)
--
Zorro Lang
zlang@kernel.org

--9yHMKeiE12Vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmZ9cL0ACgkQlNbPkfr2
tMyBsxAAmEnymyz2u6guZ6GMi1VJeuZJS8aPzH23PUAZvrbVUSreMKSrV2/jo6ww
1AUC4fgGLKa1sc5yXTZI8SuTm1a71u0NdM2XRpEHB0hHqZwMjnHxSxLFsvDncZ2d
f8nchJxZRtNxKFuRYs1jHIsB+lyKld9kzhG72pTA2WzwMIAACmMgRCAkMa7tkz0l
PTYNGffWzoWcDGG0mXnXuaFcGlH9N61P902okjhe4VAQUhRqFm1ifZFqHGdnz0wh
rw4MhkHar37Pgi3js1DpsXaXyNP68lNG9amkVsksDt7u9jsMkeYZfPCiUTZo96ev
c/hmA7qA0ho44WoCr3H5qp4o8tb3YxYwJO0+7pMXQvC86VNGOM1xCcTHN5+VwNlb
WFU68du5tqiHMoHCYp6Dl7I1VsIesEzJr4+gmGmpfxRSRHqFC/Db6Vf7ruJCwDOd
15+FmG20egg9iCSvIzZMfWkSJeb0WZSFJ7vW5J7MAsHU+n4TOtim2HEHUH2pvVj1
tMCiZQwVwlodn5ci9dAOaSgL6Z9f17n1TixPxURtRq7o5d/Pl5TjRvhwErPpsCFK
s3CH40TigOpOFoMzWQnf8Z9ixzX5uGOLfRpifbNiZF8droUqVZXzbDqQjfiOWqqZ
NG5nQYCuH8Lsr1yU8/fqalfqMb1lc2cf75b2niNCI4aXoE+7n00=
=+tzX
-----END PGP SIGNATURE-----

--9yHMKeiE12Vl--
