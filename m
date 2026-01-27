Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE332ABE1
	for <fstests@vger.kernel.org>; Tue, 27 Jan 2026 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496308; cv=none; b=pFGQyHRuHL/G/DOpVDje867khe7Xoni4QymwdjnQOfImnllDMfKBefqAUZc7KVbJevEc+wXR11QtPPeFnWpnucruUlNHh4lWdD0hnUGb+YICc3UmkueW4sHhDSpwIScHvJw5Qs6SK6fAFfL4/D3boxuwawb+mP8pJrnqLVqX0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496308; c=relaxed/simple;
	bh=tcOrpRCyNbVVAVKC1hS+oaVWen3nlYLkeo8Yw3L91V0=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ZwYz8p+6g7hxRuShtM0ijhXcwsPnYw6v4rzK3K6TzMhR0XjyMLSoWZ+CPzpTtllst8G+zSMLV2D51NhAdPHi7csaJK5dG7SpdX/JH8OeUa0BkCZJYxQC5oMoBKNxJ/Jw+D6kzJLgleMy6opDIUKghnv7bncoTHm2PT85/c4q9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzc39zWc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzc39zWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2415C116C6;
	Tue, 27 Jan 2026 06:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769496308;
	bh=tcOrpRCyNbVVAVKC1hS+oaVWen3nlYLkeo8Yw3L91V0=;
	h=Date:From:To:Subject:From;
	b=Wzc39zWc+SEu7Gn3D9yenwiIHETJXrg+rS/nB24/v61cOVCf/yNmFe38ep9Vc7+13
	 iqW7EzYtpg7jO+nsqtyA2rjZuJ+gE4DlyN4Vy0WM2FdNj+y6ReWX6/qHF5VFOgncBa
	 pX+vwguZcg/NjG6QefZ7pLEDZ4RTuhvuFLHcz0nrkVtwng48uWK/echMk17Bz0pojY
	 Y8b44OcA5NtgXgACgUsGsTRTRNTM+GHsFjjlxCvbchiKzt+2XrlRqb6LMjKUg6S+62
	 8Lxez/T1KKQohut4tWggJ0Kp5R9uPrIxLtn9xjIz8gEEifai83RHRFVIs362lHc1zk
	 0o6hE6nbVyNOA==
Date: Tue, 27 Jan 2026 14:45:04 +0800
Message-ID: <f38b858b930a5d8c8ea0706bcb3f2a04@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.01.05 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JPLhuWykZd4u"
Content-Disposition: inline


--JPLhuWykZd4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.01.05 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--JPLhuWykZd4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAml4Xs8ACgkQlNbPkfr2
tMyVvw/1Gui2driINIEUS1Kyzpq1kguzQBYA0/nxVp8KHxCwPUoQUV1WpZ6yJ83f
Rvrt/lhkt8VIbIekWMblkx8tFclkEfpTyQvVZX/j1IzhICZ8Xz+qm/UhsmI2m2kn
0ieougpJ5buSWn9Uv9JCP9tvITkGGrD178sXXMmZpre0gduEEzyp1cMYTVi9XIC1
e0uI09DjITie+tffTkGmuPx8HW7wvxVUFGbWFxsLYioOcFDXxm2QraI0/2gVtE4o
P2GSAJZfDYUGXHakCDtGjT9AiRWUSMSJi8BE9bKDQodDtnsA+hMd05i+xot94XbB
seupZdVI2olhO+qsfX+suLYAN6ke3PokVuDAeHDsNZTYIBv9XC4R++PZregCLwKD
n16Xrm4K4FsiuCM8opjzkpANUsJT+H3rEqm9TSzjSo4+vsH+n1ACOzLIlnFJQq7J
vOSjJPtBq/N6iQIURHqEnPXR+Ve/fYWGZG8Vw2P3Q06i9q6nwJFUC9cMS4uxQfC3
iCQyYIswSoRIPMR66gLRafUurKYK/0RAWGoC87pp7n83LIRRmV9wueOHm0Q7bluR
SlkIiErlmwX5h+jf621NaUhTHC+k+qK60A4zs2I3NumXWbMTkYwCNPoA8tn+VvRP
uAGznoUlpOTnTYtVXuj93R8SKcy66PAmy15dwJuU3F5erb1HRg==
=5Gb8
-----END PGP SIGNATURE-----

--JPLhuWykZd4u--
