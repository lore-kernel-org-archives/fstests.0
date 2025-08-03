Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291C23AD
	for <fstests@vger.kernel.org>; Sun,  3 Aug 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754239932; cv=none; b=QED0AOn0tO00v2VkTtsFXX3Zr1BmdZxBgjmmriXW4sU0wu1F0UuMGkFCIaUr2zWoKvzEFUaryuq2bJfq6eT5MNQRM725qJBVujxzBO7e0rtkXdKVOw8tMXanXg6d82e8u7NgihJdbwb80VCg7BuqUN/dASAKmF/rNW99txs3ehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754239932; c=relaxed/simple;
	bh=LhFy1kDRau1MECaJrd7P3H6S9Omh+fN3eS/a2yakcf4=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=k3y/stkzp+At6ojcKaOu3nzKYtOEyrPWV8XqcSF0CJ9BcYqMUzwodvWPcv5XbkxsHojL60BHyThpPZjRPTOVjco2fdotAKv4ihy8ZdAePKECTzyByhDEZSAPV0OqIZZwt5MdSER7P/yi+4K5W/Xwxay/a26yUUltz0xYZVQJsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huekI6dF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huekI6dF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AFEC4CEEB;
	Sun,  3 Aug 2025 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754239932;
	bh=LhFy1kDRau1MECaJrd7P3H6S9Omh+fN3eS/a2yakcf4=;
	h=Date:From:To:Subject:From;
	b=huekI6dF9pMwDC78nYEO4/q2F/vnhPvMaAjlkW00wtsxAX8zNAomrRece4L/Uuyj2
	 gc9O1UjevqmK4NFtUsECEl9FZUYM4CJWCBQB3SgoOWm8nOrNvmX2qxkGYTb7enEfVX
	 SfXEinXt5hn4kT4mcGuMVm1XtJfFKFE9nn4Gy3nh8nWVd0n2FPTjgUm6xf/Ss1xdeU
	 uyFRkQbCu+flQtF1YThDM3h2/sdqTh0USdkLVmFyRQrKmRJyGXB0piLpYAtEd/7Kzt
	 YeX8IY3iqhOPGfVFUEXXzHHQG2Vxcv2728vC7TkR1AgUnd8LohYticx5CBIfLY9skm
	 WRhLjB8XCH32g==
Date: Mon, 04 Aug 2025 00:52:08 +0800
Message-ID: <8bcc82c0fc3c5a853620b2b21fc941db@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.07.13 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qv05EtTJEf1D"
Content-Disposition: inline


--Qv05EtTJEf1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.07.13 version.

Thanks,
Zorro

The new head of the master branch is commit:

2e00b85742d6 generic/365: Add fix hint for ext4

New commits:

Anand Jain (2):
      [eb0191edd4a5] fstests: remove duplicate initialization in the testcase
      [b964de2119d5] fstests: check: fix unset seqres in run_section()

Catherine Hoang (1):
      [8d87273e43f1] common/atomicwrites: add helper for multi block atomic writes

Darrick J. Wong (4):
      [fa8694c823d8] generic: various atomic write tests with hardware and scsi_debug
      [7ca990e22e0d] xfs: more multi-block atomic writes tests
      [a9dc5ac46476] xfs/273: fix test for internal zoned filesystems
      [eb0d2b299ded] xfs/259: drop the 512-byte fsblock logic from this test

Filipe Manana (1):
      [5408cc794fe6] generic: test overwriting file with mmap on a full filesystem

Leah Rumancik (1):
      [a7b5d6b38296] common/rc: add repair fsck flag -f for ext4

Ojaswin Mujoo (1):
      [2e00b85742d6] generic/365: Add fix hint for ext4

Qu Wenruo (3):
      [de07c1558ce0] common/rc: add btrfs support for _small_fs_size_mb()
      [9615d021e95e] generic/050: add a workaround for btrfs
      [43128a0c543b] btrfs/282: use timed writes to make sure scrub has enough run time

Zorro Lang (2):
      [d06bd62c4c42] common/rc: remove useless _pgrep funcion
      [a673bfe9fb06] common/rc: _add_dmesg_filter returns when RESULT_DIR is null


Code Diffstat:

 check                 |   2 +-
 common/atomicwrites   |  31 ++++++++++++
 common/rc             |  36 ++++++++------
 tests/btrfs/253       |   3 --
 tests/btrfs/282       |  60 +++++++++++++++++++----
 tests/btrfs/282.out   |   3 +-
 tests/ext4/053        |  10 ----
 tests/generic/050     |  12 +++++
 tests/generic/211     |  63 ++++++++++++++++++++++++
 tests/generic/211.out |   6 +++
 tests/generic/365     |   3 ++
 tests/generic/767     |  93 ++++++++++++++++++++++++++++++++++++
 tests/generic/767.out |  10 ++++
 tests/generic/768     |  68 ++++++++++++++++++++++++++
 tests/generic/768.out |   9 ++++
 tests/generic/769     |  88 ++++++++++++++++++++++++++++++++++
 tests/generic/769.out |  16 +++++++
 tests/generic/770     | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/770.out |  21 ++++++++
 tests/xfs/259         |  24 ++++------
 tests/xfs/259.out     |   7 ---
 tests/xfs/273         |   5 ++
 tests/xfs/838         |  69 +++++++++++++++++++++++++++
 tests/xfs/838.out     |   9 ++++
 tests/xfs/839         |  72 ++++++++++++++++++++++++++++
 tests/xfs/839.out     |   3 ++
 tests/xfs/840         |  64 +++++++++++++++++++++++++
 tests/xfs/840.out     |  15 ++++++
 28 files changed, 870 insertions(+), 61 deletions(-)
--
Zorro Lang
zlang@kernel.org

--Qv05EtTJEf1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmiPk1AACgkQlNbPkfr2
tMxq1A/9GFJvDRq3hlJORRxBsusgjCObUzFTqnezrT3BJnh53z5i2hr6CqMIuw2C
vs7p04ewt+/dZ/b+Zvf0lAPdDJMoyWoNr60Er2MlDMG9sslot0VkH/nr+5DY3E/e
tsOymCGFhblzVxdPEdcdeOztGm40cIPoBhV3PV5qRWvJmb/+DHKo/0xVMZbPBi++
QOe1Q9GD81LEUO/Fd0qTEJdCO8y+ArkopcGBnpjiLoNOiM5BVsG9INRIDBOHeeD8
cBykniT+o4+lAcpp9zuQKFmOA/cazwBApY6Mecv58O235RVPmemhbMMdajil45m9
2VnssmPmIJV51sasdk53m9PKt/DEvhuGlwJrke93Kejr8t/KG8VKhC7D9QBpy766
PlSDtINCEmOEhfXiR3Cri5yOWOfBbqj9aB/owihmEOov/gqhuFErLOQ1smO9sSe0
CJODiUSS5GVwu5T3Ff6YUq/2Sf5k+0IJ71RlEdjlrdnV+LGBW1pWsJaeaJvAsyjP
BpGmU/hHNEKveZTBeDQwaASSjmAO/geKX2MgE/OwUT7mCs4ETZaNbqfa/sJR4+0f
BCJRpGAoROGUgpBT8WybybKQu5Sy18dlAVKblkPfRTKj08ntG0hxjaklrYByCPv4
eC0D8+eERFLPkIIEBuoi/yPWa9+Tifn0ea/ymh3WWBdmr38vRgk=
=1POc
-----END PGP SIGNATURE-----

--Qv05EtTJEf1D--
