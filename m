Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7411A8F8A
	for <fstests@vger.kernel.org>; Sun, 27 Apr 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745764803; cv=none; b=oGlgaAZzR4h4RbVa0NacmxoAPkEELm8PBKhhBRveuIyUl+V67xQ9v+Bfe17rtlNxVuiqSFs7z0QOzTVovRzYbZEKlFj0FVSp+U5AAAW7+X52mD1Zza4RJSjwAcofjdFRkN5GEr5fxF7nISSQJXmkIO2+JXOaOTeM9hxa60Mpfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745764803; c=relaxed/simple;
	bh=GzXx4vOouSqQGShistPwhU8/Hqp+bTC0iAhV1DBuAAg=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Cq/qrNnvVKneiM80+SFX42S5qukhY0SN4ICNw/UkqwFkvh5RUUe1FbR21KjkdaZtEDGOyWPwY1u9PxruRhs00/9ctGp9rwm6IhRBTMndaVmkzpQR6hSEeg7HKxn3tw8kmTvefY4s1GMsOwZw8Avaxdr8D7CqFPmzimF6pZAtvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7XfPhXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7XfPhXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4382EC4CEE3;
	Sun, 27 Apr 2025 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745764802;
	bh=GzXx4vOouSqQGShistPwhU8/Hqp+bTC0iAhV1DBuAAg=;
	h=Date:From:To:Subject:From;
	b=V7XfPhXuhffUHZr2a1cd1Z86d+VYYOoFRWbbFZrPPi0DQpl8vYOtug6cljA1S0i2X
	 K2GoqCqowX+BsHjLnvz8N9FI+tZvxHZqRN2S5y1XMM0M49MNlIQftiRLTe8fuJ9Qm+
	 9572dLl8CJbjUK7xWkdLD2bYf6WSfNDN1DVDnGv6e4GqPTlhI6EV4KDxXROrFiPDbz
	 XmFjY8+R21V+HtxTRKpe8WJKnZq0/3V/RXzbvd1yvuK/STlCz0xWzrRXEOlKjOa1Is
	 z+VpFMQrHbIUqYxLUpAbdAH46/zn1xsYpUGY6Pn88x/nv7PbCIlFh5nGwjl31kR3ac
	 R6Q1WOBsltlqg==
Date: Sun, 27 Apr 2025 22:39:59 +0800
Message-ID: <65ad391455ff30f78a10f41fca908217@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2025.04.13 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vFwFZRhUGmiJ"
Content-Disposition: inline


--vFwFZRhUGmiJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2025.04.13 version.

Thanks,
Zorro

The new head of the master branch is commit:

2cc8c822f864 fstests: btrfs: testcase for sysfs chunk_size attribute validation

New commits:

Anand Jain (5):
      [0a9011ae6a36] fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
      [afdb10ee1853] fstests: filter: helper for sysfs error filtering
      [03adc99ef11c] fstests: common/sysfs: add new file sysfs and helpers
      [f5cb79fb0f10] fstests: btrfs: testcase for sysfs policy syntax verification
      [2cc8c822f864] fstests: btrfs: testcase for sysfs chunk_size attribute validation

Catherine Hoang (1):
      [d90ee3b64963] generic: add a test for atomic writes

Christoph Hellwig (1):
      [ad048ff62f50] xfs: remove the post-EOF prealloc tests from the auto and quick groups

Darrick J. Wong (4):
      [7ff687d85747] common/rc: fix dumping of corrupt ext* filesystems
      [68e9620be4a6] xfs/801: provide missing sysfs-dump function
      [bc7f79bd13d8] xfs/792: skip test if rextsize isn't congruent with operation length
      [8d1447890a8c] generic/275: fix on 32k fsblock filesystems

Nirjhar Roy (IBM) (7):
      [83e1f4c43817] xfs/539: Ignore remount failures on v5 xfs
      [a758e467c24a] generic/749: Remove redundant sourcing of common/rc
      [fb15457efd0f] generic/367: Remove redundant sourcing of common/config
      [491eddb2699f] check: Remove redundant _test_mount in check
      [69bdf04c98c3] check,common{rc,preamble}: Decouple init_rc() call from sourcing common/rc
      [1c2f3da49c5d] common/config: Introduce _exit wrapper around exit command
      [f14f2a885954] common: exit --> _exit

Swarna Prabhu (1):
      [3be9add6d1d3] generic/750 : add missing _fixed_by_git_commit line to the test


Code Diffstat:

 check                 |  10 ++-
 common/btrfs          |   6 +-
 common/ceph           |   2 +-
 common/config         |  16 +++--
 common/dump           |  11 ++-
 common/ext4           |   2 +-
 common/filter         |   9 +++
 common/populate       |   2 +-
 common/preamble       |   3 +-
 common/punch          |  13 ++--
 common/rc             | 163 +++++++++++++++++++++++++++----------------
 common/repair         |   4 +-
 common/sysfs          | 145 ++++++++++++++++++++++++++++++++++++++
 common/xfs            |   8 +--
 tests/btrfs/329       |  21 ++++++
 tests/btrfs/329.out   |  19 +++++
 tests/btrfs/334       |  21 ++++++
 tests/btrfs/334.out   |  14 ++++
 tests/generic/275     |   3 +
 tests/generic/367     |   1 -
 tests/generic/749     |   1 -
 tests/generic/750     |   6 +-
 tests/generic/765     | 188 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/765.out |   2 +
 tests/xfs/539         |   2 +-
 tests/xfs/629         |   2 +-
 tests/xfs/630         |   2 +-
 tests/xfs/631         |   2 +-
 tests/xfs/632         |   2 +-
 tests/xfs/792         |   1 +
 tests/xfs/801         |  12 ++++
 31 files changed, 590 insertions(+), 103 deletions(-)
--
Zorro Lang
zlang@kernel.org

--vFwFZRhUGmiJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmgOQZwACgkQlNbPkfr2
tMwSaBAAp6YnxEXjP926ndimEbxibk69MYxujFGG3o3hBwva6pZLuUHvOt4/Zini
ytQ+IKnvFinTNSUpxldtuchr/rdkEumgiBch5Tipaz6RqtqSQ5eFTPyFoIZ9wdCN
aDguE5YIGQouTLegOOssBqwyHKGSFsJruUygPrXLX0H1ud9E7pdZAf7GDbvpl4X8
aedd9wr+PCDzjPngIkpBt2ULIJpLzIPOjz4zA/IQTUmc0DjOZfMzP9cobyLj96rn
eDZKlMPmRzqt3g0X5H7+dZv/nc9o15pB/h/t7mmFtxmgNqZzNwuGLK5nZhW9lQ9B
C1T7sAQsGONJ/VF5wzTlRuzOvN4vysJ6QJAVVIyUni845yNqIDKnPeqTTUlke4Jw
GA1bMD6WyivFRwb19jKxEmyULt0HJY7FaldAJW0h4wAJ0Ow1KLF8h0AZNJargZG7
7xdEZLnXcPl1NdKmriDPB8YWL58SWUWAwV7UwwmOBFJLec5QLVFdFvW5xZluePB+
IAlYSEUUZCoEeDpfUdJq7qlRancpdZHKgXtft7bFP7rHezh6hWwCNYSoAqXuQSJ3
fgz/enO2EMiM3Od/HF9IWGgpYWZ22aURnnfY4Cf2udlDFNr6e1Jkb2000xEVAKh4
LwNAv2Pf16fUcBowmoNbMXE6v+42ayeLdsLdQklprV0eIYYz738=
=1FB8
-----END PGP SIGNATURE-----

--vFwFZRhUGmiJ--
