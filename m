Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363B290F
	for <fstests@vger.kernel.org>; Sun, 17 Aug 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755442675; cv=none; b=HXCeK2U4zLNJ2wk913Izy2S84BffB+FlvNDQ9Ej2/bp7eTaRtm0g62NHIk5NnAXPGsfLCmvDllyfK+HPX6sdYnnFmPXdomcVYHnrDO2350cXdBPUTjQr8JoMwQ7+i3WpAbFCtwYDwd6lslOlpIg3yDgcTrQ6xJu/JubF+94kxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755442675; c=relaxed/simple;
	bh=WYmtNLM0emUtzxPPrInSj4lhGhxECA03hlEyCCb1B5g=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=NMX8qcMqNFe89LoFaYTqP6GOU6EHpnn9x84l5J62VEHLgu4b8Vt/aLdEhyJMHHCs0xdjtFmcaBTKnAv8uQcRSEl9wWGZKjrVVnjHXxFzqRvjJ25HoGEX9lZ+L8K2sFesJyKTygjVUfZQE4x54P+hVQdkhiEf41hhJ4n/M6LepIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V01+Yv0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V01+Yv0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806FBC4CEEB;
	Sun, 17 Aug 2025 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755442675;
	bh=WYmtNLM0emUtzxPPrInSj4lhGhxECA03hlEyCCb1B5g=;
	h=Date:From:To:Subject:From;
	b=V01+Yv0spblO6HwqKD94flAu7BO6GFH5MQH5i9yuR+oz+2YdJf9o0ib+wt/6SKtpt
	 Iyz/THI7S+ruNEelcmYs0MEX8ciV+0wytdvwVB1Z0EGCMuNclv0U6+SJYQNl7Xvex+
	 NURmoFtPpusIIJ/xbThy3mVmqHdYn1WHjHxT9Ao0+ev4rEzAMCRNA746jip2ZqCeBM
	 8LIx3cLKCNtuokf8xbv0Xqo8YW5drofEKml+fncGDlTZ5sTViIgg1ko+UmDYTNsdV9
	 RO+86x87wYH7R5POKHY2+TBMkDs+8o83i5TVrzF6KHub0IIzmAPSs0+hqaSZvmHL1q
	 bsJCyBAFDJDng==
Date: Sun, 17 Aug 2025 22:57:49 +0800
Message-ID: <30a3730afc7a68f705e755eb81688550@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.08.04 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iZFF5tYcHvgp"
Content-Disposition: inline


--iZFF5tYcHvgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.08.04 version.

Thanks,
Zorro

The new head of the master branch is commit:

3d57f543ae0c xfs/838: actually force usage of the realtime device

New commits:

Anthony Iliopoulos (1):
      [9f6c59e0d485] xfs/189: fix remount barrier test failure

Boris Burkov (1):
      [5dae2b3ca547] btrfs/301: enhance nested simple quotas test

Darrick J. Wong (6):
      [aa14b84a8d1a] xfs/259: try to force loop device block size
      [dca21d3724df] xfs/432: fix metadump loop device blocksize problems
      [86950a4e23c1] generic/767: require fallocate support
      [ca57558daefe] generic/767: only test the hardware atomic write unit
      [8b81cf5ce725] generic/767: allow on any atomic writes filesystem
      [3d57f543ae0c] xfs/838: actually force usage of the realtime device

Filipe Manana (2):
      [57e68bd5c6bb] generic/211: verify if the filesystem being tested supports in place writes
      [d8b702f89e01] generic: test fsync of file with 0 links and extents

Theodore Ts'o (1):
      [c8434d36096d] ext4/028: require that the scratch file system has the extent feature enabled


Code Diffstat:

 .gitignore            |   1 +
 common/atomicwrites   |   6 +++
 common/ext4           |  23 ++++++++---
 common/metadump       |  12 ++++--
 common/rc             | 108 ++++++++++++++++++++++++++++++++++++++++++++++++--
 src/Makefile          |   2 +-
 src/unlink-fsync.c    |  45 +++++++++++++++++++++
 tests/btrfs/301       |  10 ++++-
 tests/ext4/028        |   1 +
 tests/generic/211     |   9 +----
 tests/generic/563     |   2 +-
 tests/generic/767     |  19 +++++++--
 tests/generic/771     |  60 ++++++++++++++++++++++++++++
 tests/generic/771.out |   4 ++
 tests/xfs/078         |   4 +-
 tests/xfs/189         |   2 +-
 tests/xfs/259         |   2 +-
 tests/xfs/613         |   3 +-
 tests/xfs/838         |   1 +
 19 files changed, 282 insertions(+), 32 deletions(-)
--
Zorro Lang
zlang@kernel.org

--iZFF5tYcHvgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmih7dAACgkQlNbPkfr2
tMwEoBAAvyzRxxZIJsMNp0an3IHRJ59JMt4HASN8qiCO81trqvAA1bbquEy6ATC4
Ck1N70TxQnKoybHnut3zD0xbfNvmyHgNT34o2I+rqTRsV6vvQw8NN5Z69rTCSjb3
zQqPhSxiqOOrOTaM4NnEbDXbpPG0/z3H213u05ND1BeNxJcKCyKssfxP/JZQ+iyK
QoQfgu80D1kLnXoAQXGb4U+o2xA0ETTGwrTQnWupGLiPeKmgT88hpcXic6zGuAnR
OCvEB+ac87K0TGpT9Edi1Ci5/YmxW4ptGoc+MkUtGtqwj0A9ASjc29/2xUk3/MNp
+WdvsRaJkfOQ9XFkzVspZ0t0DyR6YUmbb0FP67SZVNul6hm7B+0RVyfjXUd1wfNn
laeR00CZRHAsQCEn0hOasMCWLoBtozb4MbvYsunl19nB5nniZnFKHKM39am4hh1A
kqbKLSE0wyR0DMv0qp0/eGWue3CP3Vqo2E4GS7C6yfBUmQiXyxczf9Sbfb/qpBZP
PXkBaMuGOPD0IwFlqF5iKUFXi9V+MvhMNpf92kB9HKfe5FPa86y46FZfRIrz7Vqa
hwc07ZNVE6WzfyPVg0mujwGM+a4Z3o94zjaynaE+J9Pk5Q0j3X8XCMzOYVSBz4C8
ZKv58vEGMYFcABfEcJs1l4PMlN6SjgRE+800KJeTjhUol6CAuaE=
=h4mJ
-----END PGP SIGNATURE-----

--iZFF5tYcHvgp--
