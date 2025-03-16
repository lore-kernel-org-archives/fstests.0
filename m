Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4C18CC1C
	for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742144256; cv=none; b=oKh72Jyh1/hbEQadLMk0q2TMQ0defMBM0RzeolVeNRBLDI2PYlU+uFzaQfW6JN+/i0q4pCLD/V0R0bw731Z3QpYR6HbCXuRURfxH+cg1ZhrQ6sX8RXo/1mDKIgX4Yz92WZJwhRKpMcPiLBaWWFMOU7GTfK0A/nydE1h9GUBTsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742144256; c=relaxed/simple;
	bh=ZCyDX9Fb2FZiTccMktv0SseT57YMgW1cPPCR5ob5yGw=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=JfH31esTMAtvmnDzOYEsXRlcJeNQ7Wbu3aIfdaek1xnJLGDKcLpze9dwE5YyXrCN2cNjt1tfu2xE7InNNuN/EgExSd1y+D8VfVjKBeQ3ur5xZq/AS3846p6cTJGxRvGbmlX2jpG/5oXdb0b/hmcCTQew5mkTzCTDze/yo5F0z/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9TAKkQX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9TAKkQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1555C4CEDD;
	Sun, 16 Mar 2025 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742144256;
	bh=ZCyDX9Fb2FZiTccMktv0SseT57YMgW1cPPCR5ob5yGw=;
	h=Date:From:To:Subject:From;
	b=R9TAKkQXruTOG06C1GSbtwgwjrN2+5ytLSS0ya6EMXdmH1gmxQpxWkap8GD7tBMOj
	 dqOWSHDZPpvnr4veWAgHrt0+Qyh89OsbRiorZ2+JtfQ63wp0NMuzHctnb/fs9Vm7uc
	 k/bMjC2sCQ/GXBY+TN8ByDWNidMyWdy4pbXl2/TXZeW2tA6fmLT0ad2kpJfstn70ps
	 7bAi7JI7Sb5TmFsqPCUXHoEwVgqD/GvRTWaSbgCvxfBGZvXO8YOb4BzTPdiKbccVM5
	 itCSFmfbgC8FOxkd/aPDNQZ4JL0FH+uFMPIiq5egcBMI0cGqSbj6u6wy7fXzQhCoXj
	 8aKEIoVjUAOig==
Date: Mon, 17 Mar 2025 00:57:33 +0800
Message-ID: <1737e1802b4ce9e5a838c17ccc9a2e73@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.03.17
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KSc28LPTWrBn"
Content-Disposition: inline


--KSc28LPTWrBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.03.17 release.

Release Notes:
1) There's not new test case in this release.
2) Some old and useless scripts are removed.

More fixes and updates refer to below, thanks for all these contributions!

The v2025.03.09 has been released a week. I'm planning to merge that version
(or later) to master branch. If xfs, btrfs, ext4 and any other filesystem
list has any regression or critical issue or concern on that version, please
feel free to report to fstests@. Otherwise, I'll consider that version is good
to be merged to master branch in next release time.

Thanks,
Zorro

The new head of the for-next branch is commit:

d71157da4ef4 common/rc: explicitly test for engine availability in _require_fio

New commits:

Anthony Iliopoulos (1):
      [f5661920e161] generic: add missed _require_idmapped_mounts check

Dave Chinner (5):
      [317f7f5cc739] fstests: remove setup script
      [41c1a67c96c6] fstests: remove old soak script
      [c4e4825c9611] fstests: remove crash script
      [6c13328aecf1] fstests: remove tools/auto-qa
      [90a2be3c9e44] fstests: remove old tools from tools directory

Eric Sandeen (8):
      [63347f3f5207] common/rc: use getent when available
      [83c1795dc48e] fstests: enable sparse checking with make C=[12]
      [6555679edfa1] treewide: check for #ifdef __linux__ not linux
      [c9c56ff4de40] lib: Fix non-ANSI function declarations
      [ff3c15c034a9] lib: fix empty arg function prototypes
      [6f8f12aa482a] lib: replace aiocb_t with struct aiocb
      [cc8a4bed1fee] lib: make a few symbols static
      [d71157da4ef4] common/rc: explicitly test for engine availability in _require_fio

Luis Henriques (1):
      [9594473fffb7] src/locktest: add missing struct cast with syscall getsockname()


Code Diffstat:

 Makefile               |  14 ++
 common/rc              |  19 +-
 crash/README           | 151 -------------
 crash/rc.sysinit       |  46 ----
 crash/xfscrash         | 506 -------------------------------------------
 include/buildrules     |  19 ++
 include/random_range.h |   2 +-
 include/tlibio.h       |   6 +-
 include/write_log.h    |   4 +-
 lib/dataascii.c        |  59 +++--
 lib/databin.c          |  28 ++-
 lib/datapid.c          |  32 +--
 lib/file_lock.c        |  12 +-
 lib/forker.c           |  19 +-
 lib/pattern.c          |  14 +-
 lib/random_range.c     |  65 ++----
 lib/str_to_bytes.c     |  11 +-
 lib/string_to_tokens.c |   1 -
 lib/tlibio.c           |  76 +++----
 lib/write_log.c        |  34 +--
 ltp/doio.c             |   8 +-
 ltp/iogen.c            |   6 +-
 setup                  |  81 -------
 soak                   | 121 -----------
 src/locktest.c         |   2 +-
 tests/ext4/301         |   1 -
 tests/ext4/302         |   1 -
 tests/ext4/303         |   1 -
 tests/ext4/304         |   1 -
 tests/generic/633      |   2 +-
 tests/generic/696      |   2 +-
 tests/generic/697      |   2 +-
 tools/ag-wipe          | 171 ---------------
 tools/auto-qa          | 568 -------------------------------------------------
 tools/db-walk          | 178 ----------------
 tools/fs-walk          |  85 --------
 tools/interop          | 101 ---------
 37 files changed, 204 insertions(+), 2245 deletions(-)
--
Zorro Lang
zlang@kernel.org

--KSc28LPTWrBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmfXAtYACgkQlNbPkfr2
tMygMw/+KGEypT9vYykzKNpCvlY+DrQO2KvlEU2LOAnl/pyrBJUAPX2obEO/fxZv
l0venALTpNagErIc4/n0DZtZ+8QDZlqAkyVxkpy6cjeaLGh42EQEascusM5KUBlq
j1bJNIevuUQhnZTfL67UbkMR0XU2+G/GFbvOBw4p6c9Ubpy2v8IMmh8G99+NpPwz
PkQjsWfRuMPaFr+NYFI2TXNgYgFt0LVPa+2UxBI7cTM945Z6VTBwQr6Rjaqg+Uzr
uuq94Id4RkP7QuIvCizdEWcsiUkwy1RjQafC0niJ9L4x8DumbYe3unKFMRWOYEUN
dDmGWa00saLc9sJ2fDLKR95GY+BpyTwK+1nNWIkxiwugVz/9nsyMvzrANMwP5m43
M9BY+Cv6Bvae4+8arKOa0xb1xu7UdVUYBwfIaZQwI4TfGZLXbDt02RX/MLls815P
Yt5D/RB7R4ciyVu2KW7I5xsDtN+t6iV3wYYg00NIosCfm2x/vLSLr8tXrsao9Xxx
sYNhPXr+PO9tHeuLMdUN04IQLs2jLaMW5zyVRqZm3IBoGR4zX6eErGvb9Z/Elg8d
VtgCCHjLlkVyPCt9007yFUiqTF6ajEGH3ZtnBTn4/HbHwwHtxOPL8iPCQ3vNXIp4
ji1+A/xETl6PKqfYxlBUBvJNA2+m4BDhoIgsfHMF0AOrmuBngz0=
=b8pl
-----END PGP SIGNATURE-----

--KSc28LPTWrBn--
