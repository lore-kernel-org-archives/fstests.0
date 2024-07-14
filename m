Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20F481AB
	for <fstests@vger.kernel.org>; Sun, 14 Jul 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964642; cv=none; b=kzOqa3DHFTr/gHdeX9GOtZxftoBPROvePGg0WZzfl82MPx8yvCa9j8EXwTo/ZwR7rS+wdg9or+7LU2c+f7/oFAYqIYLAr3NjYPaBWnGn16QCs5tnV8LMa+ijfinQNFwlaaJAbzLoGJ3qTC0tQEtTXNS4n2g7eYIatKFP3aomqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964642; c=relaxed/simple;
	bh=0n+rmrJc17WzVtC77NdII2po7YagtfcAG5cJjysRIqo=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=AXwW5psuR5Zo256JVfmclixcSDMPZ7QBP4anEpXTP8jNAsTMuVlSHKF4vFB5HeX+CLjqtuiIKXTlNzhNodIuzSt1lnMlCt8LHFMpNCpuzuVjulWxqQvMTq/gWa9NsXRr2Yn0QevEsCabNohaUW7GD5XEhU5sgHSO+bdCKnxwb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HteY13XK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HteY13XK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48812C116B1;
	Sun, 14 Jul 2024 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720964641;
	bh=0n+rmrJc17WzVtC77NdII2po7YagtfcAG5cJjysRIqo=;
	h=Date:From:To:Subject:From;
	b=HteY13XKyMCd1OH70khmY3JMq1KX4WtkVB1L62iVbfjpC70HfNM/wPEDX5k18wy6m
	 ft1QmFcnUBX04RwHJXmy/TeoV9XteaIYB1a+YvXqkmEe5hVTWDz0z18wEEU2vc7mWV
	 Qah6X83gfuRC4xgkd7zac3xiYGzgM64lGNjRUtcGW/3B3Ect9mkxpR6IR2Pt/u+7ia
	 NmrGpMOguw9ygz9pcjIB6GJBZXjUdSX4nDtJ/VzTQHD4dFYpAOLqLIenI8Gx+CGHvb
	 JbmqWKFksGZ+k+xX2VGfmgNzeA5SBvkQf55IFlnkaoDpcay6qB8ZjVsJtG4Yx7HYM0
	 m+erxqZMVtHqg==
Date: Sun, 14 Jul 2024 21:43:58 +0800
Message-ID: <e46082b73512ef6fd3fd4c5dbfd9a33a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.06.27 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q3LbyD7VJCmJ"
Content-Disposition: inline


--Q3LbyD7VJCmJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.06.27 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--Q3LbyD7VJCmJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmaT1aIACgkQlNbPkfr2
tMw9xRAAtq9CLG9Y765OAcqUUYHwB9ddw5PNIUpIKq36bX+b/b03YvNL/+xZFpT8
27y32y8FUuCuwgelV6NWlI/O0WjEuag1GSWyV1OFHRXfaVLadJ68HXzMR0OXL52R
A2JGtUHDF0j0LBe2p1Kf/BuZoJpo1VQXqrRPXvigbGUk6P6o4PwiS4Zkt+LC47Fy
jU44UoX2FtC03uoFTtY0Ah5tKZbbtAIB3/+akRAmD6wVxzU+lvPfPGeUNjsGAlJz
x8tWJzfOeJcnNKFjcmW2hW7+nCXj0jOToYDhL5jRP+q7EtjyZpQ34UKkcwtysO0I
68x8i5ZZiIiS6GnYQ2MH3GQpkvaLEbYzMSHW/+K+qEMMnIRDyFfcVAvikuyFprfi
g6SbpMtdeNfOuBgY/Gw9DnNktElXSv/rndK7il9SvOjCUckaiBLhp7l/BobuSwZZ
HjxWYmCSYCh/f4P57rckQIgrcXWlQyGURMWd4ip7EWy5iJRLZaDTb37oli+C1Tt/
q8ATp5AZmOTjn9gd4kuxBdlgJK/CEKe0qQHU+UFbnO2wcazfg0Ntu+MJN2SLHSsX
4roKoopH08VcTU3OlfkggA1+1iwp3+PV0OLhpSahYUkiqJEhkIECyfmCqNX5afoq
O0fO+2CBJ3+jySuiUvDe8+EmK0rbHz2VdgF7nYhD4S2vYxLpRgo=
=uAmj
-----END PGP SIGNATURE-----

--Q3LbyD7VJCmJ--
