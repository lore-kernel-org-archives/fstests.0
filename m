Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26902420495
	for <fstests@vger.kernel.org>; Mon, 17 Aug 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973243; cv=none; b=BUnbUZCfbyN6Eu9hOoywW8icIGxxx98qUU83yMf3CnI79txJwKyNO6I5zwqaI0VtUzonmnN5ZrOemMfvaTBUNaelbAlBHZkPcmRRJfa1rQicj9mBvkpkeK1i3TFQrORodTNPTaPVM+wvThfdKTvJkKYVw1TP+GLFiAPHOMGKxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973243; c=relaxed/simple;
	bh=d+vh/ffF5PmsQ69lhBHHpe/UAXOKGpLPx+f5F1aSsqQ=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Obzji/i48Xt3TLEmj3Tad+0YnG0CfbJwnA11OFSiMvFMypZAkQxonVifxF8fmG1fgu+Xo/ePecA0rTGoJlZc+9NQPfKUbDVasf/wFwQjNoZhRg6tZlqPEPCWZRiUzYCo+brGf/XM4MpvCRjTMIa5vayB/3oA7mgyIY4UPps0HHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+swfzsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+swfzsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AB81F000E9
	for <fstests@vger.kernel.org>; Mon, 17 Aug 2026 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786973242;
	bh=/+b9DL6q/f/NcmzbiP9Mfy6siXnWDFnu2kocHtA6gwI=;
	h=Date:From:To:Subject;
	b=D+swfzsUqhjAG2l1ojqNK+NZCjn8uddxPeWViW8HPLiq26p6yEp2pwgXA7MJKHUHH
	 5KQmTYuDybTV/JP8L0uqx9FvZfP2o+J/3gyKiZvKB8wsE9wtChTmooVUvPBrM4uNK6
	 Jll7hHsugvKFzRDaZY4rRCaKAsVC8T5Lyyl5T+ioW/rG6wkEwMff95nOWaECiV7m1G
	 lbq96FSC+lM0Sm079AqZihiH1YL9YRUaP9NCqOuoiUG/D+nthm0aBLPygB1c/xiG/2
	 3RFRrc3Q4qRtsYTChYBFy4qmBwUs3Z0VMeyAunIxohO4OUOQ8kfoaitgtlv1RjFVIt
	 XYoP0kkGyM3vw==
Date: Mon, 17 Aug 2026 21:27:18 +0800
Message-ID: <d60c579e7c4219518470bf60967afa9a@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.08.17
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="XN40K40Xd7YZ"
Content-Disposition: inline

--XN40K40Xd7YZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.08.17 release.

Release Notes:
1. There're 7 new test cases in this release, include btrfs/353, exfat/001,
   generic/799, generic/800, generic/801, xfs/539 and xfs/671.
2. Fix idmapped mount tests where O_TMPFILE support was incorrectly probed.
3. For fix an issue, generic/347 introduces an additional requirement for
   fallocate support.
4. Allow fserror tests to run on the f2fs filesystem.
5. Add the first exfat specific test case under tests/exfat/.

More updates and fixes refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

a370dcbed435 generic/347: Fix sporadic test failures

New commits:

Anthony Iliopoulos (1):
      [be0d986ddfdf] xfs: use -w instead of --path for man program portability

Chao Yu (1):
      [7a6f7338d284] common/rc: support f2fs in _require_fanotify_ioerrors()

ChenXiaoSong (2):
      [3fec7b1d80ad] generic/002: add test to hardlink group
      [5249d98ebb3b] generic: new test to check nlink returned by fstat()

Christian Brauner (1):
      [8954caba9fc4] src/vfs: probe O_TMPFILE support on the base mount in the idmapped tests

Christoph Hellwig (1):
      [feb1bf12484d] generic/761: add to the rw group

Donald Douwsma (1):
      [65ac068039ea] xfs: test xfsdump subtree restores

Filipe Manana (1):
      [361b5e5d5bf9] btrfs: add missing commit IDs to kernel fixes of some tests

Jan Kara (1):
      [a370dcbed435] generic/347: Fix sporadic test failures

Jan Prusakowski (1):
      [bbb3a73297ab] generic/064: allow 50 extents on F2FS after fcollapse

Lin Jiapeng (1):
      [4a5ccb510273] xfs: verify CoW after exchangerange with FILE1_WRITTEN on shared extents

Lukas Herbolt (1):
      [140058abb86f] fstests: fix build errors on kernels before v5.1

Ojaswin Mujoo (1):
      [e846df8f7021] generic/645: notrun if FS doesn't have enough free inodes/blocks

Pankaj Raghav (1):
      [9b0f378ac991] generic: add unaligned boundary test cases for WRITE_ZEROES

Qu Wenruo (1):
      [b69358f4d8ad] fstests: add a dio-read-into-mmap and sync race test case

Rochan Avlur (1):
      [54422f9a4c09] exfat/001: test that rename and move preserve benign secondary entries

Shin'ichiro Kawasaki (2):
      [29d735f251c3] common/rc: add argument to _create_loop_device() to specify device size
      [83760720b81e] generic/563: limit loop device size

Sun YangKai (1):
      [92711dbe73aa] btrfs: test POSIX ACL changes for RO btrfs property

Zorro Lang (1):
      [7536b334c492] Revert "fstests: vfstest: skip rejected tmpfile creation"


Code Diffstat:

 .gitignore                     |   1 +
 common/rc                      |  13 ++-
 configure.ac                   |   1 +
 include/builddefs.in           |   1 +
 m4/package_libcdev.m4          |  14 ++++
 src/Makefile                   |  11 ++-
 src/dio-read-into-mmap.c       |  81 +++++++++++++++++++
 src/exfat_inject_vendor_ext.py | 155 ++++++++++++++++++++++++++++++++++++
 src/exfat_verify_vendor_ext.py |  62 +++++++++++++++
 src/vfs/idmapped-mounts.c      |  12 +--
 src/vfs/utils.c                |   6 +-
 tests/btrfs/349                |   2 +-
 tests/btrfs/350                |   2 +-
 tests/btrfs/351                |   4 +-
 tests/btrfs/353                |  95 ++++++++++++++++++++++
 tests/btrfs/353.out            |  39 +++++++++
 tests/exfat/001                | 171 +++++++++++++++++++++++++++++++++++++++
 tests/exfat/001.out            |   6 ++
 tests/exfat/Makefile           |  23 ++++++
 tests/generic/002              |   2 +-
 tests/generic/064              |   8 +-
 tests/generic/347              |  13 ++-
 tests/generic/563              |   4 +-
 tests/generic/645              |   8 +-
 tests/generic/761              |   2 +-
 tests/generic/799              |  59 ++++++++++++++
 tests/generic/799.out          |   2 +
 tests/generic/800              |  79 ++++++++++++++++++
 tests/generic/800.out          |   2 +
 tests/generic/801              | 177 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/801.out          |  19 +++++
 tests/xfs/293                  |   2 +-
 tests/xfs/505                  |   2 +-
 tests/xfs/514                  |   2 +-
 tests/xfs/515                  |   2 +-
 tests/xfs/539                  |  62 +++++++++++++++
 tests/xfs/539.out              |   8 ++
 tests/xfs/671                  |  65 +++++++++++++++
 tests/xfs/671.out              |   3 +
 39 files changed, 1190 insertions(+), 30 deletions(-)
--
Zorro Lang
zlang@kernel.org

--XN40K40Xd7YZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmqDC+UACgkQlNbPkfr2
tMyXwxAAuMBwkwHxCj7sfT0fYsW1SP03H8Ia1wwJf0AnUSOJ6X29k7ncnt594E0A
mrVZi3ivz02UrVHBO1BxfW1EpSTiB+yb/m9zLHnG5Tmw5iwMwUorOpLzGtYlMvuz
1rY1cX5ceefCUyjpkQd7O4MZ/k7WIFOl3PKnwyVy9wnHC70SJzMgWm00V1aHWMEh
jZncdFBRpWd/C7cqpKzeDIU/nLbUzT9AbKiiFPyP/sgPaUNPPrChRohtyyli9fzC
t+9cy2P8thPZBGj3GlTDb3pqsvTV5Gbw7HaOVVzH+tPJO64872H0ddfm4TpvMYWh
C6Z1J543b+BD5oc3eD8Y31WXoLXSlVtgWJZz6dEeNYYZMFS9boE4UOV34R/bJHMU
sePf3qVlOk0TKkWzFLoPi9fpzPpjK3+0PwLBx45WSkSDoEeY37x1WYcbsMXHo0uj
nEzyU7dKMu3L2UoKiCJCdjZJ3neh9UMskO3cFvGUZlWqQgQVqTeikTkLDF2mzNuh
aDVkyJoh8leYmfXbdoyvQl5NA8QOmPE4miZl08Rb1f2J/6vFZcG87obaBfFdwr3x
DhPaSiKH5XmKGud4Cte+/lj8d0fRH9wKvjZrSfO5xalo4RaCXfIE4TuO24Cz8UUc
fuCcssvh3YkrSewDlCBhgqp0sG1wT5j9jn8X+Erc/nOBakv8WMw=
=dNQ6
-----END PGP SIGNATURE-----

--XN40K40Xd7YZ--
