Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46125309DD2
	for <fstests@vger.kernel.org>; Mon, 17 Nov 2025 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401278; cv=none; b=u8El9814EYwsvEkggXy4q1ERhStg5CYZQYAsoCnlTX/A936CYebWkLQ7y81VtLqrs1afw8I7SMhye7VnDvQcBWIxDi3l10Qu97m3Ymg6pQMLf0raUr5sQjKqzBEfDuCYYHlqwOVcjMRUjEhFpcFZKoag0sBtkoVuJpkQdj/zKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401278; c=relaxed/simple;
	bh=La/DAYtGpO56fwvMoExwRrHYklrmFbVeEgSa4VCfuzI=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ZMWdKsBZ4/DHaNtnimhCuKhxvq1/fxyA3I4nYjnFKZ0tZZb+dxTIYmsoCDEtRHt1T8dW8ntt4GmdMGgKPFOQ9yrSE0tySGqgjOKllQhuXhJKpGNfYvWJl1b0p/OpMhsfTsDoMkWNXSdFTc27RK9tklIP58yTTFDV9f9wF1lQn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2imF2sr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2imF2sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3085EC2BC9E;
	Mon, 17 Nov 2025 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763401277;
	bh=La/DAYtGpO56fwvMoExwRrHYklrmFbVeEgSa4VCfuzI=;
	h=Date:From:To:Subject:From;
	b=B2imF2srG5sZaRVcmbQcdn8TRXKDliT8BRAdwke9YZUPBv7yjuUhvmF+nybQ2rLEo
	 UQf3SVJJjT2lNx/hzm8hDyyyemzp5dV0kJPwi8iX6gmqcScHFkxG5TdxlgRl0V68jh
	 9ohjyYA+5+kjUCM2rJ4drAxg7F+Plj2PdLjRHmOSk1G/4SXE2Jh6Ltd3xYpAk36O8N
	 R1YDXl1toMu7b+SD611lnuNHosym0tULUSgHI4+sYoo4qvWlKH8IT3Z+tNXIHSIpYZ
	 3LkHUI/b2Y1+cI7n1gTpD1SnDmQGEiSLKwEi9sO0kDk+CW7nfacNMXjWOiN0QoClzp
	 C7fOx9IR/71FQ==
Date: Tue, 18 Nov 2025 01:41:11 +0800
Message-ID: <4e2d8c3d65126e53660492f39b8024c7@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.11.18
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QUNuElGde2V0"
Content-Disposition: inline


--QUNuElGde2V0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.11.18 release.

Release Notes:
1) There're 3 new test cases in this release, include btrfs/338, f2fs/023
   and generic/783. b/338 and f/023 are regression tests to uncover known
   btrfs and f2fs issues, g/783 tests overlay casefold feature.
2) Fix some test issues on xfs, f2fs, btrfs and so on.

More details refer to below, thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

a668057f00dd overlay: add tests for casefolded layers

New commits:

Amir Goldstein (1):
      [a668057f00dd] overlay: add tests for casefolded layers

Chao Yu (1):
      [c34a6b562840] f2fs: test sanity check condition w/ error injection

Darrick J. Wong (7):
      [927e55a2ae5d] common: leave any breadcrumbs when _link_out_file_named can't find the output file
      [252d25fb9efd] generic/778: fix severe performance problems
      [09728c352684] generic/778: fix background loop control with sentinel files
      [545c94d8c386] generic/019: skip test when there is no journal
      [99f79500aa9e] xfs/837: fix test to work with pre-metadir quota mount options
      [c5e62a6b8503] generic/774: reduce file size
      [a11b37ec4265] generic/774: turn off lfsr

Filipe Manana (2):
      [7b709ce99762] fstests: add kernel commit IDs to some tests that miss it
      [faf816b98513] btrfs: test incremental send after deleting directories with many hardlinks

Joanne Chang (3):
      [288a86433f0a] f2fs/015: clear MKFS_OPTIONS and MOUNT_OPTIONS
      [21be8aa17349] f2fs/016: add test cases for test_dummy_encryption mount option
      [1ffbdcaae45a] f2fs/{019,020}: clear MOUNT_OPTIONS alongside MKFS_OPTIONS

Theodore Ts'o (1):
      [28e2a205c8d1] generic/773: fix expected output "QA output created by 1226"


Code Diffstat:

 common/rc                              |   1 +
 tests/btrfs/301                        |   4 +-
 tests/btrfs/337                        |   2 +-
 tests/btrfs/338                        |  93 +++++++++++++
 tests/btrfs/338.out                    |   3 +
 tests/f2fs/015                         |   3 +
 tests/f2fs/015.out                     |   8 +-
 tests/f2fs/016                         |   6 +
 tests/f2fs/016.out                     |   6 +
 tests/f2fs/018                         |   2 +-
 tests/f2fs/019                         |   1 +
 tests/f2fs/020                         |   1 +
 tests/f2fs/023                         |  49 +++++++
 tests/f2fs/023.out                     |   2 +
 tests/generic/019                      |   1 +
 tests/generic/773                      |   2 +-
 tests/generic/773.out                  |   2 +-
 tests/generic/774                      |   6 +-
 tests/generic/778                      |  97 +++++++++----
 tests/generic/779                      |   2 +-
 tests/generic/782                      |   2 +-
 tests/generic/783                      | 242 +++++++++++++++++++++++++++++++++
 tests/generic/783.out                  |  13 ++
 tests/xfs/837                          |  28 ++--
 tests/xfs/837.cfg                      |   1 +
 tests/xfs/{837.out => 837.out.default} |   0
 tests/xfs/837.out.oldquota             |   6 +
 27 files changed, 532 insertions(+), 51 deletions(-)
--
Zorro Lang
zlang@kernel.org

--QUNuElGde2V0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmkbXf8ACgkQlNbPkfr2
tMyxuQ/9FvYk4djeXbZ4YEHM5pgME5EZmBi8vVzZLgn/ICfnWZQEj3N1Sl9141XE
UvBwsuHJOxR0TpzrSf+ylU2vuuedCE2HmF5Tn3V3L8OVYqAz9iD/G6wB7iVLlXPa
G5xbH4+K+GjyxvC+AaIrGxOydeMfo5m+bMUqvg+slK1o9L0AADPnp0//x/UtynnP
z9hJuTYzAOQgtmjStVBNivE0vlugg6U73aOdRn1aNAfyHepJgDdZrNEXcUn5EExO
FtQOfNgJ5Bp2rxrkbWVhqQCK8Z3DDd+y3cb96A7pcIbzHX6pJh3apRtqmtglhjXt
8k8V0iNkQK0wbljY3a56wfz0wpZi24RRBLaRIJEjwKgm8GM2zwitOPxo/ZPZo851
W1lWELRjWQdulvdKpLjBzLStIl3Nj4r1gfCkvFoG0uaqmUN8s0happIgxHJ5bxRx
GIXWJjUK6Zj1RSXEy2CbvVnfs6qvr8oSKIVl8p3MJYzgXFdFE22DZ96XtR2JAb2n
nHRBqr3fs+Zb9lXKakr5nDlm6rgo+O3VrOGOmnC/0MfHHkPU2My+ZFtkr00tKqo2
GTtsoflCIKJdALcoeuZQOnWBadQThLG0duala35eH18BhRitA0Jh07gq8eFyEt8+
HIz7t5xQsaayj705KiX9j6ZkMajVmB2VCzyDWDbolXTduoUs764=
=XHi6
-----END PGP SIGNATURE-----

--QUNuElGde2V0--
