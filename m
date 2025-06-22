Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4719C558
	for <fstests@vger.kernel.org>; Sun, 22 Jun 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750603363; cv=none; b=uNbsEH8y02Ub6z1vZpFLQHBrGTJx8epQoX/lO0P1uMl34EREqpp1tqqK+VI31p6Od+0MY+ZdFnHysBppeCuwYe0K5Ok56EIhOP5NJU3hR9m250LVhqCHUTKF8qQIIkGXJ6TGKLNDzfw8E0Wo1qcdfIJelr5sU1UrAP33eKOElCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750603363; c=relaxed/simple;
	bh=SHkkGaOAbGUHUXMuHwa4i2xSbiJSJA8tHJ5La1id6ws=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=oa6H1dKJ8wvS1G85fZQla/njtrj8J/DsNKTnlqkcU99sJppwGsGbkQFJ5aQ1rTD+L+xQqGud6OP+cZfpF6IO/8qHiQ30G5Vl7JrfBFH4IY/iwdA+MqVammNjDXJ7f1iZKMC1VWFlU0Sjfk9vxUFPedVMSLKgMLbZZsrcmxCLdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc/+PrLc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc/+PrLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D64C4CEE3;
	Sun, 22 Jun 2025 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750603362;
	bh=SHkkGaOAbGUHUXMuHwa4i2xSbiJSJA8tHJ5La1id6ws=;
	h=Date:From:To:Subject:From;
	b=Tc/+PrLcIi5OUxJvIlvfME/pg7EbaG3JiXfO6ZQ4tP4FRaLVBFVJNTpRzQpuqzzWe
	 KfXI/xMQRTAgRGjlFeW/owECS8NIyPJmGZOc/wgM8rXaA5P7RBaBrASaDBZth+MXe3
	 TEyYSRJ3MdIAZRthpNsA8HNDiFNH7Pjji+NiHcLmZPSl9wosek5ox8CqMaTMreEEdt
	 MwAfzik0nOVEZyjsCFt1uGgClPmELrNkiCJs03Mhx9pPaiUUoK3CwSUjGoY0vz1Pe5
	 //+McXu9tTY3pyJLXPgZMSlmy3ds16ezQiTyylM+fHQ/HAVZl3o4c/wJjFymbzdUDm
	 XcbxWss7enA7A==
Date: Sun, 22 Jun 2025 22:42:39 +0800
Message-ID: <5b255fb1b0f77a4ebcc4bd4804b611d2@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.06.08 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DgUHhGtJVNWI"
Content-Disposition: inline


--DgUHhGtJVNWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.06.08 version.

Thanks,
Zorro

The new head of the master branch is commit:

b3da4865e80d fstests: generic/741: make cleanup to handle test failure properly

New commits:

Amir Goldstein (5):
      [e6fc42f16c77] overlay: workaround libmount failure to remount,ro
      [d235c7eef1d8] overlay: fix regression in _repair_overlay_scratch_fs
      [3b385bf1e90f] generic/604: do not run with overlayfs
      [3d339199525f] generic: remove incorrect _require_idmapped_mounts checks
      [3563fda0140f] generic/699: fix failure with MOUNT_OPTIONS

Chunhai Guo (1):
      [09ab269c0419] f2fs/014: test for missing 'trimmed' flag issue

Darrick J. Wong (5):
      [b9666a70cb85] generic/765: fix a few issues
      [01b46074f237] generic/765: adjust various things
      [909ee4c8a75b] generic/765: move common atomic write code to a library file
      [fce21ab7afff] common/atomicwrites: adjust a few more things
      [4f2e4be4a632] common/atomicwrites: fix _require_scratch_write_atomic

Filipe Manana (3):
      [d866af976999] fstests: add kernel commit IDs to some tests
      [5ca2b3450351] generic/094: fix test ignoring failures
      [2f635d075e10] fsstress: print syncfs() return value in verbose mode

Jan Prusakowski (1):
      [389d34f0ab02] f2fs/004: avoid race condition in test

Qu Wenruo (1):
      [b3da4865e80d] fstests: generic/741: make cleanup to handle test failure properly

Yuezhang Mo (6):
      [4b12c46aa728] generic/696: add _require_chmod
      [2d9dac4ef763] generic/656: add _require_chown
      [2f14ca462c65] generic/754: add _require_symlinks
      [bb77b42ba80f] generic/755: add _require_hardlinks
      [68c9ac2ad74b] generic/730: add _require_scratch_shutdown
      [a75c1aae9f93] generic/645: add _require_chown


Code Diffstat:

 common/atomicwrites | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/overlay      |   7 +++-
 common/rc           |  51 +----------------------
 doc/group-names.txt |   1 +
 ltp/fsstress.c      |   5 ++-
 tests/f2fs/004      |   3 ++
 tests/f2fs/011      |   2 +-
 tests/f2fs/014      |  40 ++++++++++++++++++
 tests/f2fs/014.out  |   2 +
 tests/generic/094   |  20 +++++----
 tests/generic/330   |   2 +-
 tests/generic/370   |   2 +-
 tests/generic/604   |  11 ++---
 tests/generic/633   |   1 -
 tests/generic/645   |   1 +
 tests/generic/656   |   1 +
 tests/generic/696   |   2 +-
 tests/generic/697   |   1 -
 tests/generic/699   |  17 ++++----
 tests/generic/730   |   1 +
 tests/generic/741   |   4 ++
 tests/generic/754   |   1 +
 tests/generic/755   |   1 +
 tests/generic/761   |   3 +-
 tests/generic/764   |   2 +-
 tests/generic/765   |  84 ++++++++++++++-----------------------
 tests/overlay/035   |   2 +-
 27 files changed, 248 insertions(+), 136 deletions(-)
--
Zorro Lang
zlang@kernel.org

--DgUHhGtJVNWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmhYFkQACgkQlNbPkfr2
tMwplBAAy/GPX6Wp+0Z5d2Y74pyjsoP/nSC9kJpAiv+uOknU5mlPihw5Tisd2xGV
/oBLbrN3L5w2Ksr0E21SRQVUjjVsKM3eP4YG5hLgS8wgcWtqGCJNHiCC80HdzuQk
2h+lVh6nKpJqVR/uS6kAHvEnjlhdsOnBvy/mD+9reOt6HR6dZfz/VUJ/MURTauVz
5ZWMJaPXLmOzh0z/w19wlUHa5km5cNeqECDIKyYXthIhasWk8LMbP+im5Ra4d4ww
2fB4786O+fWZbYEm6r1NUo96tOIkLZbX/x2+lR/Rcc+QFAKUunSR3x+qrP2iGMp4
/0obIHD0PZbJhWpOLmL+SaPRAZUggEgRCBOxR/3rUdhrdLjwK2mAOWm6ovOz1zwo
RXtbWyaPZdkY6N8SyaD4HqmVpKWF08AK0XXstbNqfo2OTIiQPk3cDKB+ApPSZVja
IEFYQWTSfd9buP6z37TN4J+JaFnkiKGRKB2zk8HtXlOVPYWisXeN+9cOkRSGUdI6
AivpmLZOhkh/3SlOLtYIvr7iAB2KP6jaMWUIJ/ftndpeCmJ42fSHQyKtKjb+gsR7
FbfT0cfLfmDd9AqLremJcAPgKFcLMIQ3NHMqz+6b0D8IIUYUk7Qul3UZM49flYUn
Xx/yB83dUpOyZgYPFWBxesuPaDAy6HdI5wN81o/ybSciD7ineRk=
=G2zQ
-----END PGP SIGNATURE-----

--DgUHhGtJVNWI--
