Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8182100
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9saQPTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D363C433C7;
	Sun, 14 Jan 2024 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705238114;
	bh=79aafvODDldRvdusA2FJ7bluMZ3v50PFe7sqc4wal+o=;
	h=Date:From:To:Subject:From;
	b=o9saQPTCZsfJDNzSvFwojQjJZ9KFKWXC106Pr3WoP1Vk6Gq8jWo9Mnov6EF1S9nqq
	 MZQknBWc+wruuMdso8eMJz+f9KBhlwQ78Mr2V91IQ3EkfeG6v2DDW0m2AgFh6Wfnby
	 qM5230NjfgClJ1ovKbmlc8v42DoWjDF8rRJqhm5tbFgjYFHbBEk7WoOaWHaGhNHZRK
	 3RsLqe+3z4BNS2mSsOExhg6mThbrxPYNG7ruURmr+iPCrqnjURPeNQVhOEtiohg2rm
	 2rYNsE82CE/tLK+jS3f+RHwrZKfKJq1YD2/AEJehQ0SL5EsxqDRoWqp6ztxK220eOo
	 m4+gMicy/OBTA==
Date: Sun, 14 Jan 2024 21:15:11 +0800
Message-ID: <d5d28347fd1079d6cf9121feea965a19@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to v2023.12.25
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z4543YglVdZ"
Content-Disposition: inline


--2Z4543YglVdZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.12.25 version.

Thanks,
Zorro

The new head of the master branch is commit:

17324dbc7743 fstests: btrfs: use proper filter for subvolume deletion

New commits:

Alexander Patrakov (1):
      [b4396efc75ab] _require_sparse_files: rewrite as a direct test instead of a black list

Amir Goldstein (5):
      [f0f8f248dd0b] overlay: Add tests for nesting private xattrs
      [400ed0ed69d6] overlay: prepare for new lowerdir+,datadir+ tests
      [308784d1695d] overlay: test data-only lowerdirs with datadir+ mount option
      [409db1b2972b] overlay: test parsing of lowerdir+,datadir+ mount options
      [314f38ef20ed] overlay/081: fix test when running with index enabled

Darrick J. Wong (3):
      [e9b26f8c1649] generic/615: fix loop termination failures
      [b223ff181a86] generic/410: don't blow away seqres.full during test
      [abc57c0daaf6] generic/735: skip this test if we cannot finsert at pos 1M

Murphy Zhou (1):
      [4050ac7b38b0] generic: drop caches while freeze

Naohiro Aota (2):
      [475f51d9ed55] fstests: filter.btrfs: update _filter_transaction_commit()
      [17324dbc7743] fstests: btrfs: use proper filter for subvolume deletion

Yang Xu (1):
      [d6e9d32578af] generic/650: add kernel commit id


Code Diffstat:

 common/filter.btrfs   |   5 +-
 common/overlay        |  15 +++
 common/rc             |  29 +++--
 tests/btrfs/208       |   2 +-
 tests/btrfs/208.out   |   6 +-
 tests/btrfs/233       |   3 +-
 tests/btrfs/233.out   |   4 +-
 tests/btrfs/276       |   3 +-
 tests/btrfs/276.out   |   2 +-
 tests/generic/410     |   2 +-
 tests/generic/615     |   6 +-
 tests/generic/650     |   3 +
 tests/generic/735     |   1 +
 tests/generic/738     |  52 ++++++++
 tests/generic/738.out |   2 +
 tests/overlay/079     |  36 +++---
 tests/overlay/081     |  14 +--
 tests/overlay/084     | 171 ++++++++++++++++++++++++++
 tests/overlay/084.out |  61 ++++++++++
 tests/overlay/085     | 332 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/085.out |  42 +++++++
 tests/overlay/086     |  81 ++++++++++++
 tests/overlay/086.out |   2 +
 23 files changed, 830 insertions(+), 44 deletions(-)
--
Zorro Lang
zlang@kernel.org

--2Z4543YglVdZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmWj3jQACgkQlNbPkfr2
tMyK8BAAi5kmeEauLdiPjAgUM5WggNU7J1qnfdaKstMzpqM6JI2y6xDjGPlZhrOJ
PR5yNBsojFLy0lwSe4t92lydml7le1vlXbnrLR48o32QVIpxtZ9zjlNAuNhhULLv
A2qdmNzO8fPs2NuRLazSDtGx5fZRn70QAj0Zx1npPDiHC/b/KIZCfGFDXURj5dFr
oG9BRNA7lqp+uM+TQFn4pTI+FM6xO717cgKZibf8+YMw+rceS5jjwMeE8tsbuC1C
+YJvee534Zb5TJIVXELqRiQmuk3z5qLpYeY+bFrxI09VQvDiYBOxrPkwmsj+WoAU
lQEA/NXNWx5HMg+FtVj/YATeyvY2Odf4P5bq4sZgICY5jSk+JPFhvBjwXhhrAcCi
UjN28QDuM9PNlFcZyOjIJGWcghUuR5tv9D2/fRaJVIDVaNvegQyQYWsp4Oahw2yc
GdnfAWstrSSrYR62KEURdKbBPmGhPIUHdDFEVyPgKs048tlrV25hSZZPGCzsr5KF
4S3hWGBIk349bcyRuKyBnAygnrBa4WijLnFaxbtIil3xwKjPKYq+0OOt3DjH7FY1
MkP8OBiT/aCUrhDVLWaKQZzYAQc3B1IhAdhLzaR+fwag9+hCdoIM/TYNa7ebZQ8C
91p+MA0+1UA3EGIK+0BtWQn9TtS2WM9T2DTcsdH1o5iC/0xb0jo=
=++X6
-----END PGP SIGNATURE-----

--2Z4543YglVdZ--
