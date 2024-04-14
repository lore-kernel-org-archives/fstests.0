Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7A446AF
	for <fstests@vger.kernel.org>; Sun, 14 Apr 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103207; cv=none; b=biHs3V6uBdROm5jOP9ZiJiJoUNUSOTG9ENPvOu7qWXX/NOLOXw1tWFDz9FPBwaPOSVG63NAx+uURwfzy+yQ/E8CSVnOytL0fWgeorqwXWde2k5Vbx/7yDa35OTCnYa9vEf41AtBftb2A6H25yGq3wXSmGBPxExKwx3nqnvw6Wmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103207; c=relaxed/simple;
	bh=4M9EZPfQmdctmH0cBE+RLdL9j7lTvVyKyJjPrpS8uMc=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=uYKhrX3hLBehSXAGJ2RpLEed/YGvvX1f/0blIXUusZXZ9OlrZDID9/L++emOpj9QB0Q+oQmZhepuRx8j28iUzVOvEdc+0rJBCpx/54o3glmjZ1zqJmr0+HgS0sraAfv0h2WTdFf/F8B+nj4vRVVicDLtzl5dWHisoYrSXkLGbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuNR89sn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuNR89sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A324C072AA;
	Sun, 14 Apr 2024 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103207;
	bh=4M9EZPfQmdctmH0cBE+RLdL9j7lTvVyKyJjPrpS8uMc=;
	h=Date:From:To:Subject:From;
	b=SuNR89snib5pLPJY3/O2+5+H8U8yNf84P6t3XKBDG16/v0TEpDk9KZ/IxGUg8GON/
	 2uoBnIUc9Xk+0PPnLYgDNVAc3zxjrqGUEU7yHlAZuPbuLJ68zHduuYu8W2hIxDD3ip
	 6Y4oWtvUvw2WGWCYaSa/4o2iPCmPWfNjmhL/cWV8QufGr4VXbu7jik3rt0HXpkpsEO
	 zPSlw/qAADnHcl3VyMU9LZ9c73v/J5wStOw53NFbRQRcF1COYUHJvghSwrwEk2T+Fh
	 PfYcu5+F5LyfuAW6j3oQBwOBvPqQickIvOkJ+WAoFPqOnHXWZ/6UfU5srDXENM0Wcs
	 PXzpvLLmGuNxQ==
Date: Sun, 14 Apr 2024 22:00:04 +0800
Message-ID: <fe2d04554a76e1174b5b49eb7e0e7c7f@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.03.31 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xdms3zfDjIL0"
Content-Disposition: inline


--Xdms3zfDjIL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.03.31 version.

Thanks,
Zorro

The new head of the master branch is commit:

e72e052d56c3 generic: test MADV_POPULATE_READ with IO errors

New commits:

Anand Jain (2):
      [199d0a992536] common/btrfs: introduce _require_btrfs_send_version
      [7337c582d46a] generic: test mount fails on physical device with configured dm volume

Boris Burkov (3):
      [8e7f64fc6b5d] btrfs/320: skip -O squota runs
      [cb30473e15c9] btrfs/277: specify protocol version 3 for verity send
      [76bb0038ff8e] btrfs/316: use rescan wrapper

Darrick J. Wong (3):
      [1512b876e602] xfs/270: fix rocompat regex
      [b994c9c17398] xfs/176: fix stupid failure
      [e72e052d56c3] generic: test MADV_POPULATE_READ with IO errors

David Sterba (1):
      [ac004a25238c] common/rc: use proper temporary file path in _repair_test_fs()

Disha Goel (1):
      [a7958a7c6820] generic/735: improve test by incorporating extra hints

Josef Bacik (4):
      [534975459799] btrfs/131,btrfs/172,btrfs/206: add check for block-group-tree feature in btrfs
      [af82dc0ed203] btrfs/330: add test to validate ro/rw subvol mounting
      [805eeea406a7] fstests: btrfs/195: skip raid setups not in the profile configs
      [34cdaf0831ee] generic: add a regression test for fiemap into an mmap range

Luis Henriques (SUSE) (2):
      [3717a1ec4cf1] common/fuzzy: make _scratch_fuzz_modify work for non-xfs filesystems
      [ec7853cd6936] ext4/006: take into account updates to _scratch_fuzz_modify()

Pankaj Raghav (1):
      [8d61144d281c] xfs/558: scale blk IO size based on the filesystem blksz

Taylor Jackson (2):
      [c4d6d42f2109] vfs/idmapped_mounts.c: Incorrect array index for nested user ns
      [9e760cfa976b] vfs/idmapped_mounts.c: Change mount_setattr expected output

Zorro Lang (1):
      [f8fbdbe23309] common/rc: fix unknown _xfs_repair_test_fs function name


Code Diffstat:

 .gitignore                |  1 +
 common/btrfs              | 20 ++++++++++---
 common/fuzzy              | 16 +++++-----
 common/rc                 |  8 ++---
 src/Makefile              |  2 +-
 src/fiemap-fault.c        | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 src/vfs/idmapped-mounts.c |  9 ++----
 tests/btrfs/131           |  2 ++
 tests/btrfs/172           |  3 ++
 tests/btrfs/195           |  8 +++++
 tests/btrfs/206           |  3 ++
 tests/btrfs/277           |  3 +-
 tests/btrfs/281           |  2 +-
 tests/btrfs/284           |  2 +-
 tests/btrfs/316           |  3 +-
 tests/btrfs/320           |  6 ++--
 tests/btrfs/330           | 53 +++++++++++++++++++++++++++++++++
 tests/btrfs/330.out       |  6 ++++
 tests/ext4/006            |  2 +-
 tests/generic/735         | 13 +++++----
 tests/generic/741         | 60 ++++++++++++++++++++++++++++++++++++++
 tests/generic/741.out     |  3 ++
 tests/generic/742         | 50 ++++++++++++++++++++++++++++++++
 tests/generic/742.out     |  2 ++
 tests/generic/743         | 65 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/743.out     |  4 +++
 tests/xfs/176             |  2 +-
 tests/xfs/270             |  3 +-
 tests/xfs/558             |  7 ++++-
 29 files changed, 394 insertions(+), 38 deletions(-)
--
Zorro Lang
zlang@kernel.org

--Xdms3zfDjIL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmYb4TUACgkQlNbPkfr2
tMz/WhAAx2GWE+RMYq1Fqa8GAuFmrVmlN+QPaHGAp73lya8nEVDpjgtgr2R8QoiT
osLqux4HB9MvCw1lS76vHEQ8SuuvPiE1TifyP3xIZfqnzN3pWzgWVN/AeHPqd0jl
OrweTknXVkdvZfj/4fkPmSskOgZM9aHOwBBJ+ZiC/NzNFLV8Qy1z7aMusl61DQcH
u9EruYpPNojHkjI0OISxCnIrkW265YZ6SYXaDJX0Mc+/9xDPfO9sD51KW7ptg5iN
pm1ZRQdSei7AvboXcQ/Lt0pcc0yxGYT6CzushA/LFvASXLSMWJZbi9LQj5Zhjn5+
8Kaj1b85Q9gWUivOPDTkaMjFzYuH4Dwl77YRkQqcqjQkN2jWJgWOKCdVlO4AUJKC
Aa675b07cUagA6UZHjUal4PqsjDMybpfX1ewDXj1uMWDyvAbHOWiy3v0LbekcuYL
2j5knhm7YkHv0TIZghk2CqAn6b98GrbPvx7dBlZ3eLQ4fDPlfBYj8ZTqI/MpnREP
9uBKuN8ZqaQwXtJqmtATzaTXWqYeJZfC7Jg1p/Q/TUHPbF5yV8EhNeFTeS7ftPvh
GYI6QyP7c9saCwg3tKNYrXllmh7B+EKorP2bafq6GtIvaIn6tnYWJkTVRvjFVuI+
3vG759BAkiNOsbCc3OG0s/V2oAxuWw+t5yaK1CQgG+++4zB2cC0=
=AKIV
-----END PGP SIGNATURE-----

--Xdms3zfDjIL0--
