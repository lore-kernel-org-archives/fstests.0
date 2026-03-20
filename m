Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC9395266
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2026 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003193; cv=none; b=XctCCwVosh7RlJ5BtSk64ioMG/vlFEKLXKvrXfqc/j4a5DAj5PgPyGtNt/+TPMpS3Ikd0jhdQb8jggZZsMWEbLc8hqtBDgoAliBg0EmibSpks+z1DtEVcbj4zlUaQIQaLJqXdQ/lbSLkXvLJRfLrWvz5G3Kn+TZnHqFyC0mBx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003193; c=relaxed/simple;
	bh=xk1CaoJCicdDglxfHtZejQc4/6dcMgommUqxjPLPZPE=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=OLGmv8gY2P7/G4xnVfs1WlcacvBpFkyclM7yw1ykPuMl1eEx/sQb2qdQShNV6gviHGrETGx5C/JLi84xaSR+n2/4ASJc4YzJeGAATwyuFgEoRAPiiedERIzTig2SDhlfpIruhM/jtwua2NDRJ8Ov20MutmAmJCt0q6EX/GAU9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er1Egddp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er1Egddp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FED9C2BCAF;
	Fri, 20 Mar 2026 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774003192;
	bh=xk1CaoJCicdDglxfHtZejQc4/6dcMgommUqxjPLPZPE=;
	h=Date:From:To:Subject:From;
	b=Er1EgddpOeQF6aOHruLp3S8yH0JvDs40nU6pCvaUU1afycqdEnvEfM0JBmo/KftbJ
	 RYLcSxv4mcxphY6XY4n0lE8M0KkcjwM+20G+FT8FaYbJJcrtKR4ymAKAFxxAGUisGG
	 Wxo4r12+2bNquV9/it84k1ehbtEVrUuPz9IhFWhIDoJcPsIBX3ZMTQlthm5jnXCNql
	 dZ32xfOehllNHlFDR4VCUsNhGgFwj3yUEZVo+YXTVwvr8uORjfsXg5LUXTna5ckeq2
	 cZ6R+GWst08mELFGgKjLfG3gbrI+f2n9DI+cXBjQ5R0r86K74O5YijJsEQXFXGEtt+
	 0EnpHxmvH/Tcg==
Date: Fri, 20 Mar 2026 18:39:49 +0800
Message-ID: <a77af9b9231bed1fd75f2ea3ce7ed910@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.03.20
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pK9oDi0abQkS"
Content-Disposition: inline


--pK9oDi0abQkS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.03.20 release.

Release Notes:
1) There're 19 new cases in this release, include btrfs/345~347 and g/790 to
   cover btrfs known issues, g/791 and xfs/654~667 to cover fsnotify and
   xfs new feature.
2) As Linux 7.0-rc has merged the XFS health monitor feature, so this fstests
   release sync many related test cases. Thanks Darrick.
3) Support FALLOC_FL_WRITE_ZEROES operation in fsx.c and fsstress.c

More details refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

57d71a884dd1 ltp: add support for FALLOC_FL_WRITE_ZEROES to fsx and fsstress

New commits ([N]ew case, [U]pdate):

Darrick J. Wong (17):
[U]      [fd9292449514] xfs/62[3-8]: require XFS_SCRUB_PROG
[N]      [29d120e41c3d] generic: test fsnotify filesystem error reporting
[N]      [79f6b1c3e4d8] xfs: test health monitoring code
[N]      [c90d3c12ffe1] xfs: test for metadata corruption error reporting via healthmon
[N]      [1eef51a44b3f] xfs: test io error reporting via healthmon
[U]      [15548b5e8482] xfs: set up common code for testing xfs_healer
[N]      [e76e776e4310] xfs: test xfs_healer's event handling
[N]      [a951e61b684c] xfs: test xfs_healer can fix a filesystem
[N]      [aa3d8defe09a] xfs: test xfs_healer can report file I/O errors
[N]      [eb1013c4f269] xfs: test xfs_healer can report file media errors
[N]      [8e5ed6fcef96] xfs: test xfs_healer can report filesystem shutdowns
[N]      [20dffed104b6] xfs: test xfs_healer can initiate full filesystem repairs
[N]      [309e54e83e1f] xfs: test xfs_healer can follow mount moves
[N]      [17fdaa0ba3f1] xfs: test xfs_healer wont repair the wrong filesystem
[N]      [df0f4b76c572] xfs: test xfs_healer background service
[N]      [de37793e7b07] xfs: test xfs_healer startup service
[N]      [aa5b0dcf301d] xfs: test xfs_healer can follow private mntns mount moves

Filipe Manana (4):
[N]      [01d24d6b0b28] generic: test a directory fsync scenaro after replacing a subdir with a file
[N]      [aad362549a8a] btrfs: test setting the same received UUID to a lot of subvolumes
[N]      [c6946bc36b9f] btrfs: test creating a large number of snapshots of a received subvolume
[N]      [66c672a2e845] btrfs: test create a bunch of files with name hash collision

Johannes Thumshirn (2):
[U]      [02e625a5875a] fstests: add _fixed_by_fs_commit helper
[U]      [8ca8c3c238bc] fstests: use _fixed_by_fs_commit where appropriate

Pankaj Raghav (1):
[U]      [57d71a884dd1] ltp: add support for FALLOC_FL_WRITE_ZEROES to fsx and fsstress


Code Diffstat:

 .gitignore                        |   2 +
 README                            |   2 +-
 common/config                     |  14 +++
 common/module                     |  11 ++
 common/rc                         |  40 +++++++
 common/systemd                    |  39 +++++++
 common/xfs                        |  98 ++++++++++++++++++
 configure.ac                      |   4 +
 doc/group-names.txt               |   1 +
 ltp/fsstress.c                    |  15 ++-
 ltp/fsx.c                         |  85 ++++++++++++++-
 src/Makefile                      |   6 +-
 src/fs-monitor.c                  | 153 +++++++++++++++++++++++++++
 src/global.h                      |   8 ++
 src/t_btrfs_received_uuid_ioctl.c |  50 +++++++++
 tests/btrfs/345                   |  73 +++++++++++++
 tests/btrfs/345.out               |   2 +
 tests/btrfs/346                   |  95 +++++++++++++++++
 tests/btrfs/346.out               |   3 +
 tests/btrfs/347                   |  66 ++++++++++++
 tests/btrfs/347.out               |   3 +
 tests/generic/211                 |   2 +-
 tests/generic/362                 |   3 +-
 tests/generic/363                 |  10 +-
 tests/generic/364                 |   3 +-
 tests/generic/365                 |  15 ++-
 tests/generic/366                 |   2 +-
 tests/generic/367                 |   2 +-
 tests/generic/370                 |   5 +-
 tests/generic/471                 |   2 +-
 tests/generic/562                 |   3 +-
 tests/generic/623                 |   2 +-
 tests/generic/631                 |   3 +-
 tests/generic/646                 |   2 +-
 tests/generic/649                 |   2 +-
 tests/generic/650                 |   2 +-
 tests/generic/695                 |   2 +-
 tests/generic/700                 |   2 +-
 tests/generic/701                 |   2 +-
 tests/generic/702                 |   2 +-
 tests/generic/703                 |   3 +-
 tests/generic/704                 |   2 +-
 tests/generic/706                 |   3 +-
 tests/generic/707                 |   2 +-
 tests/generic/708                 |   3 +-
 tests/generic/733                 |  10 +-
 tests/generic/736                 |   2 +-
 tests/generic/738                 |   2 +-
 tests/generic/741                 |   2 +-
 tests/generic/742                 |   3 +-
 tests/generic/748                 |   2 +-
 tests/generic/755                 |   2 +-
 tests/generic/757                 |   2 +-
 tests/generic/761                 |   2 +-
 tests/generic/763                 |   2 +-
 tests/generic/764                 |   2 +-
 tests/generic/766                 |   8 +-
 tests/generic/771                 |   2 +-
 tests/generic/779                 |   2 +-
 tests/generic/782                 |   2 +-
 tests/generic/784                 |   2 +-
 tests/generic/785                 |   2 +-
 tests/generic/789                 |   2 +-
 tests/generic/790                 |  70 +++++++++++++
 tests/generic/790.out             |  12 +++
 tests/generic/791                 | 213 ++++++++++++++++++++++++++++++++++++++
 tests/generic/791.out             |  20 ++++
 tests/xfs/623                     |   3 +-
 tests/xfs/624                     |   3 +-
 tests/xfs/625                     |   3 +-
 tests/xfs/626                     |   3 +-
 tests/xfs/627                     |   3 +-
 tests/xfs/628                     |   1 +
 tests/xfs/654                     |  60 +++++++++++
 tests/xfs/654.out                 |   5 +
 tests/xfs/655                     |  98 ++++++++++++++++++
 tests/xfs/655.out                 |   8 ++
 tests/xfs/656                     |  98 ++++++++++++++++++
 tests/xfs/656.out                 |  10 ++
 tests/xfs/657                     |  43 ++++++++
 tests/xfs/657.out                 |   2 +
 tests/xfs/658                     |  88 ++++++++++++++++
 tests/xfs/658.out                 |   2 +
 tests/xfs/659                     | 209 +++++++++++++++++++++++++++++++++++++
 tests/xfs/659.out                 |  21 ++++
 tests/xfs/660                     | 171 ++++++++++++++++++++++++++++++
 tests/xfs/660.out                 |   7 ++
 tests/xfs/661                     |  36 +++++++
 tests/xfs/661.out                 |   4 +
 tests/xfs/662                     | 107 +++++++++++++++++++
 tests/xfs/662.out                 |   3 +
 tests/xfs/663                     | 114 ++++++++++++++++++++
 tests/xfs/663.out                 |   2 +
 tests/xfs/664                     | 135 ++++++++++++++++++++++++
 tests/xfs/664.out                 |   2 +
 tests/xfs/665                     | 152 +++++++++++++++++++++++++++
 tests/xfs/665.out                 |   2 +
 tests/xfs/666                     | 123 ++++++++++++++++++++++
 tests/xfs/666.out                 |   6 ++
 tests/xfs/667                     | 128 +++++++++++++++++++++++
 tests/xfs/667.out                 |   3 +
 tests/xfs/802                     |   4 +-
 102 files changed, 2781 insertions(+), 93 deletions(-)
--
Zorro Lang
zlang@kernel.org

--pK9oDi0abQkS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmm9I9kACgkQlNbPkfr2
tMyzehAAvL7+FOCVC6tNRfv6R8g5iYqN+osI46ISNpoZPWHlFF6QEWaXTbz/Cl4l
4IiQWG0nJlQuL4GR9NATAs24ml5CJ9rg61/gIs3OI9WVE9XwI2inU8hXMyRLYwMC
AddwdMggJV1GXk5b+LOYo9FLXWJ4rNhfWuSprsz0T9ecX37wnuBUUXvfI/uONyDE
ZI8D6vxfz7aoi1dsNWGDEomoEVEx80WN6XGpE4mR6DCTL6Ae6fmQTk+kFvKnFmDd
/yuLFXFHL5Qa3eqQqb1A0srxOPvEEyu61h1QzQZpouSB9ql6hqKELc+jqDDIvpK9
tAD4UMoUIjsnaNIiq9Nt7Jv9O1ziVWGq1CLuZs+utfTJW1mWT7m7qL5Dia9FSuDT
24qVxxFmoSZ8WnfprgnQ1wlwQ5SR0z2O2/6dW71YzIfexHXWGl3qlreNM7dkaG4k
uXzWTdlX+X3CGVRAbHjD1acbKhEfolBRyj3DQLeAYgcWaziXont4WH3HyZbnaVWG
Xf6ggs5DlxyKxC2sU7Iib6bdALyEtUd7HKgYKVvlvceV/LJ2ZmC7wBKpg+FtJDXL
WVnmCzmVYV9M6mRgUK9m0cVhrBEo7G2lqq6M8+gJxfQyN7hiWLtmvt09NCLYE7de
V7iMElEZm46RByW3hp4xA5cQGxTL42XOt1b5aYK9Ms9f1GMRbOE=
=lY0a
-----END PGP SIGNATURE-----

--pK9oDi0abQkS--
