Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F934BA39
	for <fstests@vger.kernel.org>; Sun,  5 Oct 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679814; cv=none; b=MSiqmyKEOar3pQWj+XyQtrPqEqm3Fm86tnzB40w6UHVm/Jff01mLm7obQiuqBJJF8IxjgPQopNGMnwx8fWsFFcGZoHPgXHavBmdxmHyf4sFXb/5E7UDdAnn3RRfumBBKqaPQp7U1cRFRKTrTloUX+JT8gzgOay85xVv8BuVQ/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679814; c=relaxed/simple;
	bh=/JvR7wr5v5qo1U7AqOMlFERINhTIJPgHTA+QVv5FNb4=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=AZkDwl0nJeNBKjlCIkaeB0VSrIoihz4v3N5EbH4qN1x5/1zLqVGwBUrU0KyOLWQwLeUfjCVB3TR4bJ6bdoMce8E00ufCehVKJjTJ/6Y4pUek1FSijeyB8BEDP/xxc0mL+Ld0nUOCh3nbvjYQsVKIhq5AESJllADhwLFKs03E+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZpn+kRe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZpn+kRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B29FC4CEF4;
	Sun,  5 Oct 2025 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759679813;
	bh=/JvR7wr5v5qo1U7AqOMlFERINhTIJPgHTA+QVv5FNb4=;
	h=Date:From:To:Subject:From;
	b=kZpn+kReF7Z9dCYn/I8fLdhHeNNs5U/0lmX5Vp/n003Fu2YUqt4XLQgjuaP9EZsg/
	 KGSNHi5+PFK1P+tC0z42BPjVuGXCLblqNLL1OXwWBdm1Fl28NrIgsqwxKaSejt4Tcq
	 LeLOfLoW/jpXg8fsOjCCXtnFIeoTbIwAkYq3pevmPIW2tXhzRk9jBNj1+/hS7kGWxJ
	 XYI+Pd4m+iWtKDgKB9Pa/RqwjpUbhLIpv8Z9w+0/8BAdY+TJZRWBQobeXCHU2y7J5w
	 NnmwfkX0Hb2IRN52ETPdxzrFR5+FxyYLOzCqgVmlYug3VK7Exlxmh6SNmbRr8TKS7s
	 6nwZ6RGkNlSvw==
Date: Sun, 05 Oct 2025 23:56:48 +0800
Message-ID: <0d2ac875ecb5396e52f1c180d48122f8@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to v2025.09.07
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cXOLt00uk8fU"
Content-Disposition: inline


--cXOLt00uk8fU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.09.07 version.

Thanks,
Zorro

The new head of the master branch is commit:

911e9f168004 fstests: generic/733: avoid output difference due to bash's version

New commits:

Boris Burkov (1):
      [cf73c0adc635] btrfs/301: test nested squota teardown

Christoph Hellwig (3):
      [86a1a51cf62e] dmthin: _notrun when dm-thin setup fails
      [aff1e92c3f47] generic/081: don't hang when running on devices with protection information
      [fa19801cda23] generic/450: don't hang when running on devices with protection information

Filipe Manana (2):
      [6dca84887d87] generic/363: mention btrfs kernel fix for block size < page size scenario
      [bfa369f55a2b] fstests: add commit IDs for kernel fixes already merged upstream

Johannes Thumshirn (1):
      [9d618786c0d1] btrfs/237: skip test on devices with conventional zones

Nirjhar Roy (IBM) (4):
      [579a65fc0de0] btrfs/301: Make the test compatible with all the supported block sizes
      [d6506d38a3ee] generic/274: Make the pwrite block sizes and offsets to 64k
      [6ec632659993] btrfs/137: Make this test compatible with all supported block sizes
      [f5822b2bced6] generic/563: Increase the iosize to cover for btrfs higher node sizes

Ojaswin Mujoo (1):
      [8735e3e15fc7] generic/365: Fix false failure when mapping ends with free space

Qu Wenruo (3):
      [6ca32795a99e] fstests: btrfs: add a new test case to verify compressed read
      [8dd133d0763b] fstests: generic/228: do not rely on the bash core dump output
      [911e9f168004] fstests: generic/733: avoid output difference due to bash's version


Code Diffstat:

 common/dmthin         | 10 ++++----
 tests/btrfs/137       | 11 +++++----
 tests/btrfs/137.out   | 66 +++++++++++++++++++++++++--------------------------
 tests/btrfs/237       |  9 +++++--
 tests/btrfs/301       | 13 ++++++++--
 tests/btrfs/337       | 53 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/337.out   | 23 ++++++++++++++++++
 tests/generic/081     |  3 ++-
 tests/generic/211     |  2 +-
 tests/generic/228     | 28 ++++++----------------
 tests/generic/228.out |  2 +-
 tests/generic/274     |  8 +++----
 tests/generic/363     |  8 +++++--
 tests/generic/365     |  6 +++++
 tests/generic/459     |  6 +++--
 tests/generic/563     |  2 +-
 tests/generic/733     | 17 +++++++++++--
 tests/generic/733.out |  1 -
 tests/generic/771     |  2 +-
 19 files changed, 186 insertions(+), 84 deletions(-)
--
Zorro Lang
zlang@kernel.org

--cXOLt00uk8fU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmjilSQACgkQlNbPkfr2
tMwdAQ//clzZrVr2M8tAiAdl1aamQrHnntB1Y8QEPkraT6uxytBgnyXgxfXIv1DP
zFSxVi7bAwiVtZNn3onIkR/6qsGA6WhINKkuSyFU53w4QoCcu1SnjJV9DsWAcCJw
shcyw4Ojr9vLUPYxPL//mcOr7C5n4bynTXrS1/83gMaeqV/TIU2yoYAQK94Tx3Iy
Dbbs8nNw1DMgYi9tQgxr+i75eaxka04+Q/eEBdy/MFagWYmi6QefB3KlmCPwlznl
gKSVF1QMREQl4COjkNs4PKd7NnEYBPyIu6PQ37IAxspEiPXes1ComzqRnxsBUW7I
KFzSxcOAo462Ac87xkYc+ZC/KFPQ3VWUHJEKS0/niD4ly6rKmVteis61EE44rgeU
aVSXkex1wQ1pdqG9PBT5rdqVC2B7ymNOsGgQrz6tlKJ+1PVx1qtURz5VVBDsoF4x
nlNV4zwLGlpLsDB7OsgWMoGb2WBNLfSFtbNdzcuLhvpcQjfPp3E98ZHqJ38P/KNW
Z3HBKhOVYOguQru+YQsw50auDlAr+/hkIB1p8QfXP7DQQPvsV/NKDs6o6e6elQMe
LchCNQmNDVN5KRm+joAmN9ysnHhGrmc83pYVQLizcR1QebY5CeGYrwYiTKzutJBE
2nvZ29TPrUWwX9fo5XVSmROJ7a0VYR7UCW9bioBMmbguQyq3UFE=
=7xFJ
-----END PGP SIGNATURE-----

--cXOLt00uk8fU--
