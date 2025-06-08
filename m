Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B417741
	for <fstests@vger.kernel.org>; Sun,  8 Jun 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749391858; cv=none; b=tPsxE4TtcBIWtoFGVN4qpmaYNKQEQ6+iycXcUi7on19yNDLjD/fQTSx9vero3h+Y1kW//W815pv9aRoP8a192B9X5SLuWi2/RH+SrMCSUcIejiXRSZuCklusqmSDS8p2kJSuxSIfFBHy7DTRe1TI9IrkLbn+bbQgOdM/oVlZMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749391858; c=relaxed/simple;
	bh=886IVPIHOwY/6Xy3tyNO+MfKGB6m1+dU7faui9KqN0g=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=EhRLo7kbZ/GbOkMkRi46DfFos8G/BYchotL+jwvwXU0bQQX6xLUAL10nrWs2EUbvqdQIfgZdiJfWzsvSwqTtHFyhiu+6WDDEiSyfsAn3WP6EVYjzx7sg+6ecTmQDjQIuM9zmVCx083Zg0m9yadbjmhYBFfDbCOiBJGeLrKquLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eotCeMNF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eotCeMNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EB4C4CEEE;
	Sun,  8 Jun 2025 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749391858;
	bh=886IVPIHOwY/6Xy3tyNO+MfKGB6m1+dU7faui9KqN0g=;
	h=Date:From:To:Subject:From;
	b=eotCeMNFT7WKR9Kz/jVXfv4z/bTNCwjMnLB6iOGxqn3Q/ECUay/PuYXuI5q6DfPiO
	 2mc9TEG/4nHGKMAknuY9jOyLM1DGV8D2WYrcSkmb4jHj4y4tOF3jlse03ITROYUIlJ
	 wz2on78NRJ+2h63CwOcG6Sb0zx2ZPCEYnWwea46U3Sl/gNYD8CMX4B/4PiWT/NU2j+
	 4zcy7BY0W/2xWO1VB4Jnlt0L/9FoAx0y+sHt+Pf+vB0AC3Sk6ldyXsEzj9F8D99aEI
	 dVVQIl3N1hOh48NlFli9L38cXPXjyXRJs3Ztn8/RcelWFzPi59q8gt878ZEaXRP6ou
	 hC/BbQs2PpnHg==
Date: Sun, 08 Jun 2025 22:10:55 +0800
Message-ID: <9d41e21f9c196d110779c5d4f15ab84f@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.06.08
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vXMhymchYxo2"
Content-Disposition: inline


--vXMhymchYxo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.06.08 release.

Release Notes:
1) There's 1 new test case in this release -- f2fs/014.
2) A workaround patch from overlay list to avoid some test failures to
   remount,ro on new libmount (enable new mount APIs by default).
3) A new common file -- common/atomicwrites for atomic write testing.
4) More bug fixes on overlay, exfat, xfs and btrfs.

More updates and fixes refer to below, thanks for all these fixes to
help xfstests to be more stable.

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--vXMhymchYxo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmhFmcMACgkQlNbPkfr2
tMxuJw//VYinMpsmo1rdFgoJqbEizJSyq78gZJTJE+62TxC1ZD8Yfw/Yh8mnANYU
5JmewMUMHE9E02qy2Q3MWevL+RrBHLlToREIDXBgWOsFPzxrr01UhZty9xznwe/X
GG0c9990K0fiehhx1ZHvGeiRsBpKe8T2iGniofus4zzDA5qWPDiHJbzyvsf+99O5
Bkk9nMb7ED74bHMLODxan/AiJ/nzZquSKKLNunUcpojk5V2mVvzqc0Yu1Fussqbf
rvCmsUMHnxjdbztnFfgBKLbjbmYhlBGx0P/wNbD5MAVOXAu0xede2NYar9B7/0HI
Byb4BPac8BtnISO/U5CyQNNKupgDDV+E3ZjkLDqPMU9QGWGvLH8YpXIaD1IuXW69
814JuP9S6HMZpgRVwbWk5bkmIm+7bJl+8RdweV8t0Fr5BzaeZHeA1j2MJRUgVmza
pJ30QP2XtTJbsHMmLMuHcHHgBctrALFr7/0ymDRpl9o9mylL4adz2ywblb0dB7Cd
/wV27mlq8G2dxqdnMQUDR35Auvw4lxQUmHQB3wo6nWlGffpJYmwFsxgfzAN2qT9h
dSJLOwJpC57Sw482HmnsHDfq5SJmAvnLu6wMLsqu6fKrt9s0WN0ptOFvKCd4+UwK
LBtEuT/xihF6x9ydUzVZNKYFlqF4n2U9JLkIuZLKC0Vzy8o2HGk=
=aL6Z
-----END PGP SIGNATURE-----

--vXMhymchYxo2--
