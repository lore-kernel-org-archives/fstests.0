Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58922D7B9
	for <fstests@vger.kernel.org>; Tue,  9 Dec 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288828; cv=none; b=aEdTvz/vGfMG+D+8DAF9+0WDT2jcxGov2jzDcXOle/p0Sumsn/zOgYrU3PqmW2CnnOHWagzwVaaXSa1LzPbzoXAhiu0aluKwnw61MV6Mcx2GFlKSnr203dTbgLc2VHQ55dnx3c/jZYNo4IAmoIl/6wWX+94rv9v1SVBcrLH92pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288828; c=relaxed/simple;
	bh=anhV63hUCW/PGAFj9bhpk838fkSeoloA65DzqfCw7vc=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=cVAnqO9W4RCpj8FP9DRN0moojyT25NpqScG7JlBabi0GZ6M8uwC0GahM1hB6czPpB4Domz2t1rasplUiKO5TgXnAhTHPziO1U7sD0q5ujEKPixJpfGrJpNMuARNe31d6V1iih7O4GqM7MRwUb0kTbxoYAIy0NldSyIA96LBU7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoZjH70q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoZjH70q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DF0C4CEF5;
	Tue,  9 Dec 2025 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288828;
	bh=anhV63hUCW/PGAFj9bhpk838fkSeoloA65DzqfCw7vc=;
	h=Date:From:To:Subject:From;
	b=FoZjH70quYXJLCBGWRoSP8j+lrE3Nl07ermNhxdJGl1hr80BC5QoHXCDFNWzKS83s
	 dFS9JkIz2AeZof5vTzsuGeWL5mluDGMlB99iSDLgU19VgdR6PyG0/UHuMXfTKyJpnG
	 DLf6njWmkUx10U4RlJwhKVGx+9yqEtcrR1OhiKUM2z9NhQuUjw2ZRhDXR1GjjYQozp
	 MzV8qRskvCpGBXWjqcwEBA3N3LYOk17pnBmAkW02krFZWvZhWq68d6mJonGy41IH8U
	 0QvnwplXoNAlODuMkOb34BcW3EH79Z1UWbz9nooBlzPqnYocP68QvfzERLuPrgrlP4
	 /vIy7ufn/x5vA==
Date: Tue, 09 Dec 2025 22:00:19 +0800
Message-ID: <71512d4fb3dd3edc682839aaf83a1a66@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.11.18 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7UJHo6Y5X5Iq"
Content-Disposition: inline


--7UJHo6Y5X5Iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.11.18 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--7UJHo6Y5X5Iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmk4KwEACgkQlNbPkfr2
tMwgQw//RQiBVxIb/LYww/XfbsiVJUR+HP4eJs5TWZNHIQt1+Hir+zi8UbDsWr0L
tFYBSuWsWiZDN7gWVm46CiYsztCY862BG3NLTVYWTxHjbGiT+gtIOGPBoonT3Yh6
5GTqckXdRpddhVq2RaHQBI65hyVe9XbUYaE/r0W1+cgV5opqdvgmt52HjG7fpGi5
uIp+KkbPg4UvQjAMkLcsm2CgFW68VaAg2CKvzXhVxi4ClvQSU/t5/hsoGZ2Kk0u6
oV48OewPpMo35galQh5hgeDXGYIxRefFhYD+Yw7sK1mEPwbp6FC9GQtFq0szJ6ja
nyscNEmR8ezxAB3Jhgm5jX17EPin7agf8JNTcFbsbEYhnblH6AQ0IG9DG7WxLscT
rF8rNzY7ntgYaBh11twbmqfJoClqwr+0Zvyf4yCgKiZLv3RPiLFGm+Xv76QStvqg
IyN0+2URc/agwwlZ9929GpfiAIvePwONDOGV9tV1lP8a/+6ys9+2P59dOpMRm1gV
WlygznrzheIugkBCua5OL58vOcPV3E7YDa41mUWj+fKEgl6RSfaJnCOA/Wu/oMRD
F3pqh26xOhtF+0V+Np7XnZDhr8MvjiE+Gevn2vbHc7JiW5pWFYxMhuTx/icRQPgd
zfF9C0+WI/6O/acc6Fa2uPpldQ6chmAV09cMGfVV3V7RgnGVJzA=
=ZpR5
-----END PGP SIGNATURE-----

--7UJHo6Y5X5Iq--
