Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DA33CEB7
	for <fstests@vger.kernel.org>; Mon,  5 Jan 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627542; cv=none; b=iPsxIlJrftC3H652pw3MLb/ROiE1PK7efIUI7QKeybad1ajPLmXfEOKwP6rOlzPMVoJ8Z6L+qYnPfAHctJFelJRyx6WupxcGC5MC1M3oth+Njpz6fVafjfylVDILxLbDtk5nEu9ZPOZRjDPAZjiy59NPUmaIgT9zEE5tdXvhklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627542; c=relaxed/simple;
	bh=XBfxEUE0AAHR3FSDMnCeke2b0Hv+AOYdyJP6TVqKqSs=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=o+AoTvybOJyYfdwl8ih8LGUllnNny7mKucFHJz6G35JxNhAHAeZaXNngZCJvDM1kvmAYsJiOXl/l1U5uK2Cne+81tvorpAAcrX/oclgpBIhaBWuaCTEhBs+yJOO0+pv6Lce4ErhMhwQEbJF9p4ONfZbvdSZZ0vuv+KfPsH9kyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zich1sEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zich1sEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044C3C116D0;
	Mon,  5 Jan 2026 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627540;
	bh=XBfxEUE0AAHR3FSDMnCeke2b0Hv+AOYdyJP6TVqKqSs=;
	h=Date:From:To:Subject:From;
	b=Zich1sExBf61uNyRcEOdPTiRwkd6ntjP7nH0RigBSNNAUkm+Dgsesq92WBFa5GKXN
	 8wP2OTtD+m5RI5GeWDxU5lFOPpZzzxBOlZ4kWmLU6qAQhKH5NS/XyVKKfucy1DW4uM
	 hb6MUIpWa0sWwmgtnfeUxkUSZRCaykm18GVWUHDW+YHNbB/fYGIhC9RJjwdRTK5fJy
	 TRjXE+xyoHeJI38v+hoabehm+UBBPkJcrv2Fx/wcnRPGXdY7DtA974lBY+nJIjumJC
	 E+jSD9zVx1R5ZtafYrobEtlGP0eFV9wkjfoJx4DuuPTGZ402WG3HUa/75HINBQeipp
	 l6v/svf81/pAA==
Date: Mon, 05 Jan 2026 23:38:55 +0800
Message-ID: <8f7a1c16b772bd3a57450f92ffc0689f@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.01.05
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ap43mpC8zeuc"
Content-Disposition: inline


--Ap43mpC8zeuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.01.05 release.

Release Notes:
1) There're 4 new test cases in this release, include btrfs/340, xfs/651
   xfs/652 and xfs/653. Those 3 xfs cases are for zone aligned RT
   subvolumes testing.
2) Fix some SCRATCH_{,LOG,RT}DEV issues.
3) Add HFS/HFS+ to supporting list.

More updates and details refer to below, thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

63a29724a85f xfstests: add HFS/HFS+ and NILFS2 into supported FS table

New commits:

Anand Jain (1):
      [1a1521a039d4] fstests: fix flaky device name in _cleanup_flakey

Anthony Iliopoulos (1):
      [ad2b96dd66ef] xfs/490: fix failure due to deprecated ikeep mount option

Carlos Maiolino (1):
      [ffd562ecf44a] punch-alternating: prevent punching all extents

Chao Yu (1):
      [71131073bc76] common/quota: fix to wait for all inodes been evicted in _check_quota_usage()

Christoph Hellwig (17):
      [f4ec120ffd25] xfs: add a test that zoned file systems with rump RTG can't be mounted
      [960384aa2c46] xfs: test that RT growfs not aligned to zone size fails
      [7e972aff4801] xfs: test that mkfs creates zone-aligned RT devices
      [eb2ad950ea90] dmflakey: override SCRATCH_DEV in _init_flakey
      [5dbc7499a3b2] ext4/006: call e2fsck directly
      [a63b4556fc74] common: add a _check_dev_fs helper
      [cd74736e1794] ext4/032: use _check_dev_fs
      [901f00980f0e] generic/590: split XFS RT specific bits out
      [255cb1f0dd6e] xfs/157: don't override SCRATCH_{,LOG,RT}DEV
      [4460f5d01c7e] xfs/185: don't use SCRATCH_{,RT}DEV helpers
      [30ee67e320de] xfs/424: don't use SCRATCH_DEV helpers
      [0d89f8063ece] xfs/521: require a real SCRATCH_RTDEV
      [e157f480a308] xfs/521: call _require_scratch_size
      [70824203cb68] xfs/528: require a real SCRATCH_RTDEV
      [90f6065005e7] xfs/530: require a real SCRATCH_RTDEV
      [cfb2146bc959] xfs/650: require a real SCRATCH_RTDEV
      [fb14379b8dbc] MAINTAINERS: update entry for Anand Jain

Darrick J. Wong (3):
      [36836607c9e7] check: put temporary files in TMPDIR, not /tmp
      [d49e33421375] common/rc: fix _xfs_is_realtime_file for internal rt devices
      [fdc576ef62e2] xfs/649: fix various problems

Qu Wenruo (4):
      [1da7f10cd89d] fstests: btrfs: add a new test case to verify quick qgroup inherit
      [657410a19ab5] fstests: generic/746: update the parser to handle block group tree
      [80259c855ad7] fstests: btrfs/301: use correct blocksize to fill the fs
      [4c7968b86932] fstests: btrfs/226: skip the test for bs > ps cases

Su Yue (1):
      [f02d4965d48f] generic: use _qmount_option and _qmount

Viacheslav Dubeyko (2):
      [e45c90fedb0b] generic/020: limit xattr value by 3802 bytes
      [63a29724a85f] xfstests: add HFS/HFS+ and NILFS2 into supported FS table


Code Diffstat:

 MAINTAINERS               |   2 +-
 README                    |   4 ++
 check                     |   2 +-
 common/dmflakey           |  47 ++++++++-------
 common/dmthin             |   6 +-
 common/preamble           |   2 +-
 common/quota              |   9 ++-
 common/rc                 |  21 +++++--
 common/xfs                |   6 +-
 src/Makefile              |   2 +-
 src/parse-extent-tree.awk | 144 ----------------------------------------------
 src/parse-free-space.py   | 122 +++++++++++++++++++++++++++++++++++++++
 src/punch-alternating.c   |   5 ++
 tests/btrfs/056           |   6 +-
 tests/btrfs/085           |  14 ++---
 tests/btrfs/095           |   4 +-
 tests/btrfs/098           |   4 +-
 tests/btrfs/118           |   4 +-
 tests/btrfs/119           |   4 +-
 tests/btrfs/120           |   4 +-
 tests/btrfs/159           |   4 +-
 tests/btrfs/166           |   4 +-
 tests/btrfs/176           |   4 +-
 tests/btrfs/201           |   8 +--
 tests/btrfs/209           |   4 +-
 tests/btrfs/211           |  14 ++---
 tests/btrfs/226           |   4 ++
 tests/btrfs/231           |   4 +-
 tests/btrfs/233           |  20 +++----
 tests/btrfs/236           |   8 +--
 tests/btrfs/239           |   4 +-
 tests/btrfs/240           |   4 +-
 tests/btrfs/243           |   4 +-
 tests/btrfs/301           |   4 ++
 tests/btrfs/340           |  45 +++++++++++++++
 tests/btrfs/340.out       |   2 +
 tests/ext4/006            |   2 +-
 tests/ext4/032            |   2 +-
 tests/generic/002         |  16 +++---
 tests/generic/020         |   5 ++
 tests/generic/034         |   4 +-
 tests/generic/039         |   2 +-
 tests/generic/040         |   2 +-
 tests/generic/041         |   2 +-
 tests/generic/056         |   2 +-
 tests/generic/057         |   2 +-
 tests/generic/059         |   2 +-
 tests/generic/065         |   2 +-
 tests/generic/066         |   4 +-
 tests/generic/073         |   2 +-
 tests/generic/090         |   2 +-
 tests/generic/101         |   2 +-
 tests/generic/104         |   4 +-
 tests/generic/106         |   4 +-
 tests/generic/107         |   4 +-
 tests/generic/177         |   4 +-
 tests/generic/231         |   6 +-
 tests/generic/232         |   6 +-
 tests/generic/233         |   6 +-
 tests/generic/270         |   6 +-
 tests/generic/311         |  12 ++--
 tests/generic/321         |  20 +++----
 tests/generic/322         |  14 ++---
 tests/generic/325         |   4 +-
 tests/generic/335         |   4 +-
 tests/generic/336         |   4 +-
 tests/generic/341         |   4 +-
 tests/generic/342         |   4 +-
 tests/generic/343         |   4 +-
 tests/generic/348         |   4 +-
 tests/generic/376         |   4 +-
 tests/generic/456         |   4 +-
 tests/generic/479         |   4 +-
 tests/generic/480         |   4 +-
 tests/generic/481         |   4 +-
 tests/generic/483         |   4 +-
 tests/generic/489         |   4 +-
 tests/generic/498         |   4 +-
 tests/generic/501         |   4 +-
 tests/generic/502         |   4 +-
 tests/generic/509         |   4 +-
 tests/generic/510         |   4 +-
 tests/generic/512         |   4 +-
 tests/generic/520         |  12 ++--
 tests/generic/526         |   4 +-
 tests/generic/527         |   4 +-
 tests/generic/534         |   4 +-
 tests/generic/535         |   4 +-
 tests/generic/546         |   2 +-
 tests/generic/547         |   4 +-
 tests/generic/552         |   4 +-
 tests/generic/557         |   4 +-
 tests/generic/588         |   4 +-
 tests/generic/590         |  68 ++--------------------
 tests/generic/640         |   4 +-
 tests/generic/648         |   2 +-
 tests/generic/677         |   4 +-
 tests/generic/690         |   4 +-
 tests/generic/695         |   4 +-
 tests/generic/703         |   4 +-
 tests/generic/741         |  16 +++---
 tests/generic/741.out     |   2 -
 tests/generic/745         |   2 +-
 tests/generic/746         |  24 ++++++--
 tests/generic/764         |   4 +-
 tests/generic/771         |   2 +-
 tests/generic/779         |   4 +-
 tests/generic/782         |   4 +-
 tests/generic/784         |   4 +-
 tests/generic/785         |   4 +-
 tests/xfs/051             |   4 +-
 tests/xfs/157             | 104 ++++++++++++++++++++++++---------
 tests/xfs/185             |  15 +----
 tests/xfs/424             |  41 ++++++-------
 tests/xfs/438             |  11 ++--
 tests/xfs/490             |  12 +---
 tests/xfs/521             |  34 +++--------
 tests/xfs/521.out         |   1 -
 tests/xfs/528             |  34 ++---------
 tests/xfs/528.out         |   2 -
 tests/xfs/530             |  42 +++++---------
 tests/xfs/530.out         |   1 -
 tests/xfs/542             |   4 +-
 tests/xfs/601             |   2 +-
 tests/xfs/605             |  10 ++--
 tests/xfs/649             |   7 ++-
 tests/xfs/650             |  66 +++++++++++++++++++++
 tests/xfs/650.out         |   2 +
 tests/xfs/651             |  34 +++++++++++
 tests/xfs/651.out         |   2 +
 tests/xfs/652             |  58 +++++++++++++++++++
 tests/xfs/652.out         |   4 ++
 tests/xfs/653             |  66 +++++++++++++++++++++
 tests/xfs/653.out         |   3 +
 134 files changed, 876 insertions(+), 653 deletions(-)
--
Zorro Lang
zlang@kernel.org

--Ap43mpC8zeuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmlb2rQACgkQlNbPkfr2
tMwk4Q//Wn+qQr0umW6oJ0CfGnUQ4RopQoYfowaMyK7741fAz/yizocoqLZNT2oY
0DOCjt7ds7kNzBn8Ir/qMc3Rjxdas0npbdlusiqGcKNcLANOZLOe9zUXVnojLFrk
A0tMhG+O5g/aM6oaWJ2hO0cyo7UHout8iwnaRSNlz1eKfLT+E7Wh1NaME/Wgyigo
/1QzS/jkAVtyuiY2QcQYTc4juuZ1kcA51z49dHGzyzpk7iiq+cRtTcIdTzohq4/Q
MfzYfJ6bZUhUKVupkx0edKBr3xYog8sg3FcUqgF6AJ99tqmky60JgQQNx2y2z9zl
f76NnOQvmn9iBMejRM+VZ26TwU6VjTc7R88+kPsN2U955ZAdbdTl76GIlMLQ0+wd
B9QZYej2zjz0Mms9fkAiO8WefRST5EBYy/XDKgw0TmdpvRZpVpS0NaBuxNBh9Rfb
6QYQsmL+n86iBI5CMnJA4TFgloThPaOsbDYuILFtWqbo4JPtZ2d/IGWTjKAXPD6P
Gl7btnaCHzR37rb8XWgTbRbwKl+f4t1xFnQmi4PnK6FFncRmCHsAMc9DFbExWoMx
f+oSRS77czputGetdiSIWanzRZvPYFT1EDlPW7OsN1m6XDqthx1EwKY9HzQYzy/5
lLKNOrnRaWCEhutXOlpRLr4lBIMeIHOoMEIGreRSDrga1oxIJ1A=
=5kRo
-----END PGP SIGNATURE-----

--Ap43mpC8zeuc--
