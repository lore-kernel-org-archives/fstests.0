Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB61E9B37
	for <fstests@vger.kernel.org>; Tue,  4 Nov 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271754; cv=none; b=B/rE8JhrkEAM00FiFmNx/mPXMMiesaXEMHjNFVmedJfVc3s9cIEpOygZ24o2L4AG8+Gan7m2Mm1t8LhIKMQ+yvEt6yJuub5KPbrUm2j5wPtFz0CixtGeZJMgdfCKjq/HLQhBuDT0Qhpo9jdGBTC/QFyQApCPYU/MQh8FsAZIDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271754; c=relaxed/simple;
	bh=NhKtTy/wvD0ZIn6jJEB6Koyx8uTO8f4JV/069n74H+M=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=dCVc3jmes8CV7tQF4/JEUiq0p8xQ515t/IiB9vFQuV0MdWSyAunPwqqYdeiOzYQ2wcB89e2NYPpEY8e8c1t3+/ghDCr6YoXewqvA2VAxCQqiv7738JZDC7Ukvnb1u46VBI6JXP4OtBcg+WBPuzLQ8hmW/diFQho7aJRW3QPYFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJzZhetp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJzZhetp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9587AC4CEF7;
	Tue,  4 Nov 2025 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762271754;
	bh=NhKtTy/wvD0ZIn6jJEB6Koyx8uTO8f4JV/069n74H+M=;
	h=Date:From:To:Subject:From;
	b=IJzZhetpQdt63zRmD+UjRKs278/T8Dd2aKo7Mrh1b3Ni/qkQqIM3rQeCTaiFYKtoQ
	 HNT42KfDbP9uyQmN9SbgrIcVWhOH471Bi+mmJV/elaiPDI+in/RWwP2jcJ8QKJ0pWW
	 PsR5RxwktYZnKxi+gu/fpSURLeTmXvxDrw/zKn/33h0BOmRbmV74qCIJzkK+kDhgax
	 XsA6JfEdsxS4Kvkk7YqlpFzhYSv6pVjkCnGwcD6RLUIHY7OHVkCZb+cu2xU51zjcce
	 F4RqO+3Z6UH3KkW5YXh2xavk03mSu4xkpnPG4XWNFCFv4TF+6R1vX7oUuqufcFC4i5
	 zu9O5V+12j2HQ==
Date: Tue, 04 Nov 2025 23:55:51 +0800
Message-ID: <838a10f1370d0468e11ea1f290c85e61@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.11.04
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BvlXMWQffmvU"
Content-Disposition: inline


--BvlXMWQffmvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.11.04 release.

Release Notes:
1) There're 4 new test cases in this release, include ceph/006, g/779, g/781
   and g/782.
2) New helpers to create and destroy zoned loop device, g/781 is the first
   test case to use these helpers.
3) Support core dumps from crashed programs by systemd-coredump.

There're many fixes for ext4, xfs, btrfs, f2fs testing and so on. More details
please refer to below. Thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

5b75444bc912 ceph: test snapshot data integrity after punch hole operations

New commits:

Andrey Albershteyn (2):
      [43761bafd7b5] generic/772: require filesystem to support file_[g|s]etattr
      [e4bcfeb065b0] generic/772: split this test into two tests for regular and special files

Chao Yu (2):
      [930ef1140392] f2fs: add commit id to _fixed_by_kernel_commit for f2fs/02[1-2]
      [fea0ae7e9d7a] f2fs/022: fix to run testcase correctly

Darrick J. Wong (12):
      [462c5419fcdd] generic/427: try to ensure there's some free space before we do the aio test
      [39809c7a56b2] common/rc: fix _require_xfs_io_shutdown
      [e9f38cc0a97a] generic/742: avoid infinite loop if no fiemap results
      [ae421bd93cf4] generic/{482,757}: skip test if there are no FUA writes
      [706b5f0f78a4] generic/772: actually check for file_getattr special file support
      [10b3cbd86d0d] common/filter: fix _filter_file_attributes to handle src/file_attr.c file flags
      [9cff03b40a9f] common/attr: fix _require_noattr2
      [ae2728de5cb9] common: fix _require_xfs_io_command pwrite -A for various blocksizes
      [be294eb15eee] check: line up stdout columns
      [4d5b1462c0d4] fsx: don't print messages when atomic writes are explicitly disabled
      [6e853e735338] fsstress: don't abort when stat(".") returns EIO
      [9886baabdec3] check: collect core dumps from systemd-coredump

Filipe Manana (2):
      [6930df3fd6e8] generic: test fsync of directory after renaming new symlink
      [3db9a5c44737] generic: test a scenario of dir fsync after adding a link to a subdir

Joanne Chang (1):
      [8d3cb85a8b9d] f2fs/011: use random data to avoid file compression

Johannes Thumshirn (3):
      [41f4ef18a442] common/zoned: add _require_zloop
      [e7d008d1fed2] common/zoned: add helpers for creation and teardown of zloop devices
      [c055aae8d958] generic: basic smoke for filesystems on zoned block devices

Ojaswin Mujoo (1):
      [1035b332a57f] ext4/048: Fix hangup due to no free inodes

Yong Sun (1):
      [55cf5e5ba4f6] generic/270: replace pidwait to wait

Zorro Lang (1):
      [606ec307b361] common/atomicwrites: fix _require_scratch_write_atomic when awu_max_fs is empty

ethanwu (1):
      [5b75444bc912] ceph: test snapshot data integrity after punch hole operations


Code Diffstat:

 README                | 20 +++++++++++
 check                 | 10 +++++-
 common/atomicwrites   |  9 +++--
 common/attr           |  4 +++
 common/ceph           | 77 ++++++++++++++++++++++++++++++++++++++++
 common/filter         | 33 +++++++++++++-----
 common/rc             | 97 ++++++++++++++++++++++++++++++++++++++++++++++++---
 common/zoned          | 61 ++++++++++++++++++++++++++++++++
 ltp/fsstress.c        | 29 +++++++++++++--
 ltp/fsx.c             |  1 -
 src/fiemap-fault.c    | 14 +++++++-
 tests/ceph/006        | 63 +++++++++++++++++++++++++++++++++
 tests/ceph/006.out    |  2 ++
 tests/ext4/048        |  7 +++-
 tests/f2fs/011        |  2 +-
 tests/f2fs/021        |  2 +-
 tests/f2fs/022        | 10 +++---
 tests/f2fs/022.out    |  2 +-
 tests/generic/270     |  2 +-
 tests/generic/427     |  3 ++
 tests/generic/482     |  2 +-
 tests/generic/757     |  2 +-
 tests/generic/772     | 54 ++++++----------------------
 tests/generic/772.out | 14 --------
 tests/generic/779     | 60 +++++++++++++++++++++++++++++++
 tests/generic/779.out |  2 ++
 tests/generic/780     | 86 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/780.out | 20 +++++++++++
 tests/generic/781     | 44 +++++++++++++++++++++++
 tests/generic/781.out |  2 ++
 tests/generic/782     | 73 ++++++++++++++++++++++++++++++++++++++
 tests/generic/782.out | 10 ++++++
 tests/xfs/648         |  3 +-
 33 files changed, 727 insertions(+), 93 deletions(-)
--
Zorro Lang
zlang@kernel.org

--BvlXMWQffmvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmkKIeQACgkQlNbPkfr2
tMyGDA/+I1nchNA6d6Tfvyi4IRp/w3vpokfuMBlrkOee6fhxh0fpl2PTtzen2eY6
/CXXWvwvV+hda19EqnwiSiQ9uFXIoyqUK9QSJwFLKJe7FZdIhjxwJ8Gp7nI1+iWw
EFhSTvqqYwowkBEyHLQfSzcI8gqw/tIj0ww9cJo3LQwoIx5gwNJzTg4rKv7+OLDU
cIVx/iBgCZbMYxT+hhTdwYRKyXTRZQiAxiQ0t4DgfjViwrcDIOiGRwQfGsTK2/ZU
8DcgMU/x+vtkRatV8kjqdR0VPafjVr37WgSvGLB/I8HOm9BFfLa2EKTcdBz3pX/N
A1FShnPkEdPwxfH++bh/lQ9X6HCCBDZm0BI4uX1+ZQQdK1MlQ/tMAdGq7jG46xfS
wws50/tC3AkVz5DSU0I7uZfCbsy4D8Mm0dHsvDWO6MbrB88m1OAcp/pvsbbLgfim
zEm3ltQ3LZJTD/FlKJH8Z42G/u8ocn6bnIRwKkux5WKmkZ3JFn2+vkO0YMOyjvyW
or7nVxw8UqadJRKoXrDffiTSKR2a4QX5aV7bhb6M+ptj6rQgBp/lWQQWXYlNp7/b
+cqAMqnvLRXM+pLMRPilWhSMJfB7LVkl4yGmHcKxo7E/Ggs9KaZ+Chhx0/ddrpYQ
WSI2Wx9djxSLRmjdbAo04FMJWaoe+r3ilNloPIEjUNVTA9fAO2g=
=odn6
-----END PGP SIGNATURE-----

--BvlXMWQffmvU--
