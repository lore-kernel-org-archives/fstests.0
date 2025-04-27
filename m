Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700804409
	for <fstests@vger.kernel.org>; Sun, 27 Apr 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745765067; cv=none; b=BufsAITlPnG5pF8lN+Xu22MJdYlshuhWQpRRQ48Tf/xEGRgps5tBcYHukNiduCPjazpdlPdO14rs7aRQZRDjIOXVI73W8chKdmYYsXFas9ob8ixF7ALSFXKirewLYtE1Y3RsQbJAdgvjwfqF9HyavH4OkJMyt3vVat3z5zOc08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745765067; c=relaxed/simple;
	bh=1ysknkkkk6Ytl73hhweGaUGXuoDoxfc9IkCRhdNgI5A=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=CATz44kAEcGELHsN9arObUW0ZwkkTg8/CqIjFM9O/7VV4YeUFMYza/iMYdHeYayI6vwcF8S149NhMgkNMDug28WWRzEjhPOgrEUR1qSBzNZK/JsT0cofl/lx46hIheyzovWB3H3j0hFCMZ8LVef3Ne8b+EfpJlD8YDMaixHZp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOgXieU+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOgXieU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB45C4CEE3;
	Sun, 27 Apr 2025 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745765066;
	bh=1ysknkkkk6Ytl73hhweGaUGXuoDoxfc9IkCRhdNgI5A=;
	h=Date:From:To:Subject:From;
	b=iOgXieU+74AcrqktqmsiPcAqbrc//6D/w4XIeO4Xt2jLANjMOGSsNuoyGQ0cYZkyV
	 gVXkqFVNNH4+haeh6Ao0Q0wXoQxuHcsVwMtZy4bNQINKkPAfIPySzJ7JAK0683k72y
	 rs7fiR1kDHKKPxS6aj2PVabc8BkIjrlQh27Cs4lUft5fmRsNVco4ysFwZuy05n4FSN
	 aDijT/Wh6o3f+K6NGQqPoPqO0IIwIlQAOGYFx2iD5/JOaHf4zn1xrQPo74CTT/VQeP
	 Ox62BJ+jiUruYwVn4OR6XuCJK4ZwwCFjNDv/CWDcMZqEMTJvqtgwDUnQQX9XV9AV09
	 6qRaQPO4YVRcA==
Date: Sun, 27 Apr 2025 22:44:24 +0800
Message-ID: <c481b26dc99667f4decea86679869ec0@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 008ffc623232
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z7el3KgxiAmY"
Content-Disposition: inline


--z7el3KgxiAmY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.04.27 release.

Release Notes:
1) There's a new test case in this release -- f2fs/011.
2) Initialize a fs supported list, feel free to update it for specific fs.

More updates and fixes refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

008ffc623232 fstests: common/btrfs: add _ prefix to temp fsid helper functions

New commits:

Anand Jain (1):
      [008ffc623232] fstests: common/btrfs: add _ prefix to temp fsid helper functions

Anna Schumaker (1):
      [f3cbd32a49f5] generic/033: Don't call 'fzero' with the KEEP_SIZE flag

Chao Yu (1):
      [22cffc73853b] f2fs/011: test to check out-of-space issue

Christoph Hellwig (2):
      [b3e7ac4c5ec1] generic/231: use relative path to invoke fsx
      [1f5cccd39e76] generic/233: use relative path to invoke fsstress

Qu Wenruo (3):
      [c2537798f311] fstests: btrfs/271: specify "-m raid1" to avoid false alerts
      [b51e55e7418c] fstests: btrfs/253: fix false alert due to _set_fs_sysfs_attr changes
      [a7640a40da64] fstests: btrfs/315: fix golden output mismatch caused by newer util-linux

Zorro Lang (1):
      [d56ff7a3a253] README: add supported fs list


Code Diffstat:

 README              | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/btrfs        |  6 ++--
 tests/btrfs/253     |  3 +-
 tests/btrfs/253.out |  1 +
 tests/btrfs/271     |  2 +-
 tests/btrfs/311     |  4 +--
 tests/btrfs/313     |  6 ++--
 tests/btrfs/314     |  2 +-
 tests/btrfs/315     | 27 +++-------------
 tests/btrfs/315.out |  2 +-
 tests/f2fs/011      | 53 +++++++++++++++++++++++++++++++
 tests/f2fs/011.out  |  2 ++
 tests/generic/033   |  4 +--
 tests/generic/231   |  6 ++--
 tests/generic/233   |  5 ++-
 15 files changed, 173 insertions(+), 40 deletions(-)
--
Zorro Lang
zlang@kernel.org

--z7el3KgxiAmY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmgOQrEACgkQlNbPkfr2
tMw4/Q//SkuB4t0CF+kSHuaQIDLug+dC0kJvvP4uRTWs0AJsyR3BLYtacmnNaqdt
s9kz7v2/FGo2aIzYs0yIiCSfciBWSy6voou5SRApD4iJrJkQgpDfn5nvgxXbA3AC
eyuZ+bt4SF90BmVURS2MFBJKGLALFEexnovBcWP7FitWvifM6Y9fviH1On7IxdKx
itTsyL56ys2SshYMSpduK1iEFy+hVHHllUavTOT8g3PyLC8bBYMCVrziDAWcN2Qm
lMEM6OCXvN7jfgxhNFOFdjFGAfASwCnfBH27yp8R6euJsOcX1Ujj/3x+x+D8VPPS
1nCKyXG9JxebwzXhUsEtG9dUPTcjFm4VlxL0xJqClolNqJ2/ef9v5JuRX3qCEGZm
VabgZkynYFUpL/85vbjqpZ5/LTMcXZ2s3KXjJrQe9w2uA3FH1h6Th9eVsg1mN5dw
jjLRQMKF7h4G/hWElDiQiOPJzDz+0wlEOmAgT7sfwbLdD4vu2jHAenpUP9NH9Vkw
J2Nhabb2Guj6tufgg+MkjySB4izeYn2yeHdwMEbHxnF4zQVXK/0exQy4uTkmGAso
NXePAUn81qLvkfPZWzW6n8nIeYtkDCrhC7FHap9Q06oK0W+vBPj0kqlEY+wy3B05
azE8dOydTBCHyY64pZred2B/4zSvxkZF8279mUd2egV6r8sFmD4=
=WpKW
-----END PGP SIGNATURE-----

--z7el3KgxiAmY--
