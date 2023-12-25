Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090652F89
	for <fstests@vger.kernel.org>; Mon, 25 Dec 2023 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEcOmRGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4B6C433C7;
	Mon, 25 Dec 2023 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703526563;
	bh=tPHkmwuQgjV5VJnu/YqXZWKck31jbBmfHlURrStf9uQ=;
	h=Date:From:To:Subject:From;
	b=FEcOmRGD88lxGvzFSSc6OZs2SPQLm1arx8uWrargN3RPAsV+xDc7cMyk+KasbwL4N
	 bP5+/jTEo6wNdjYxU4nwRJh7Gx3cJg+OdT3sAwzzkcLFVOdadFKPd+1yIPa9537lzj
	 OUYnPTNkwZOd3fcGDjs/dctUr7e9Ss4Cq4egvA6WMFsjij7Nf3R/xFg3JXDKWqYX69
	 hPRETpl7iULl5FbziOW4dkmg9wBZX7crAPFHjWcuOS8M2IxJ+kloV9v3ZdrGmg91C7
	 MAkwbvby2Yo4RW/hyGb5y08swVfgnraBp9Wl0UV3KrfRuyNMbfFUKs/78XFfFSVMqh
	 UCIfhAY5C/20Q==
Date: Tue, 26 Dec 2023 01:49:20 +0800
Message-ID: <bf8277c4f1b863c677adabe48c036f26@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.12.25
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rGPsB6NHrsTO"
Content-Disposition: inline


--rGPsB6NHrsTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.12.25 release.

Release Notes:
1) There're 4 new test cases this week, include generic/738, overlay/084,
   overlay/085 and overlay/086. The generic/738 might cause hang on old
   kernel, please take care to use it. Those 3 overlay cases are for new
   feature testing.
2) The common helper _require_sparse_file is rewrited. Please tell us
   if you find anything wrong.

More updates and fixes refer to below. Thanks for all your contribution this
year, this's the last release of fstests in 2023. Merry Christmas and Happy New
Year for all of you!

Thanks,
Zorro

The new head of the for-next branch is commit:

17324dbc7743 fstests: btrfs: use proper filter for subvolume deletion

New commits ([N]ew, [U]pdate):

Alexander Patrakov (1):
[U]      [b4396efc75ab] _require_sparse_files: rewrite as a direct test instead of a black list

Amir Goldstein (5):
[N]      [f0f8f248dd0b] overlay: Add tests for nesting private xattrs
[U]      [400ed0ed69d6] overlay: prepare for new lowerdir+,datadir+ tests
[N]      [308784d1695d] overlay: test data-only lowerdirs with datadir+ mount option
[N]      [409db1b2972b] overlay: test parsing of lowerdir+,datadir+ mount options
[N]      [314f38ef20ed] overlay/081: fix test when running with index enabled

Darrick J. Wong (3):
[U]      [e9b26f8c1649] generic/615: fix loop termination failures
[U]      [b223ff181a86] generic/410: don't blow away seqres.full during test
[U]      [abc57c0daaf6] generic/735: skip this test if we cannot finsert at pos 1M

Murphy Zhou (1):
[N]      [4050ac7b38b0] generic: drop caches while freeze

Naohiro Aota (2):
[U]      [475f51d9ed55] fstests: filter.btrfs: update _filter_transaction_commit()
[U]      [17324dbc7743] fstests: btrfs: use proper filter for subvolume deletion

Yang Xu (1):
[U]      [d6e9d32578af] generic/650: add kernel commit id


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

--rGPsB6NHrsTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmWJwH4ACgkQlNbPkfr2
tMxIHRAAh8jaZw3N9XfttgQh+26Q7thNv/0Jki/dvUJf4U5ZE3VFUkLXJgN0281t
SAdgYRYdaeBouix+iQ7OGSji13fgmO1VdyQW23RAmgwPxxprDBLhXSsVwc3BQAEq
ons5x/64tocWBHFzo4OeWIQXZ7fNvYYn30jGeJzENZV2tCtu6wSY978yJ8aNH2MN
tLHH1msMxoh5lSDtVsSEloKPTVLFIBZRAMs2BRfDxrn6uLyppOKZz4+QzubNVHQi
LGduokYQc5Ym+50LpthfpZ10LXUKYSBS5vjuEQLRj6W0DoC6MaDw4icPagdUHMjJ
AmGwIEgFFJ5Qf5375bznP7j1gcxdt2mtk1zgc+oFmLVD+ynCiz5m/OQIM3GrmThu
HC1hxRCUFBFtlmZ4QX/AzTtyJ0geK7fi7+QRrs6HZ+4gkKzCWmcbSgLuDXjNDioc
gT9abAfoCFJad9IpPbzFc8qjWVAJkD34UZqEiHlflGAfYAzQn3pq63y6u9Z6gNVq
GIathQbKMvcN4I0QlaShxCtPQ/MhgrRP54Dkq7chQqPFJdJ5s7vhzsAyiE6aIINS
ptGVyvVyG0yTQDn8suDYuQZTbqsxlFuJ5Nj6Rk6F8GFMc7w+8myo4jW5uvf3uai3
H4vl3N2UmePLsMMMKDWxWr11Isdz87XQQwLBzq9T/V8Kb2R3BWI=
=QYxx
-----END PGP SIGNATURE-----

--rGPsB6NHrsTO--
