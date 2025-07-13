Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC71A0BE0
	for <fstests@vger.kernel.org>; Sun, 13 Jul 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752419122; cv=none; b=C9/0Xd7KeuYgQ2KX3heikb50/L0WCB8L7Xv6LCg0H6PXir6kvX9+RqqIhrqSbF5TKvBf+f5mnL3AXefUMpP10fsS6Sfb4Rrs1CEYJcl3RfhkXotBDgJS2ercMHSc9RYmqbixT7AZNgRqhHj6/OjGrT5mNhM1+LsC1/fnLj9Ezhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752419122; c=relaxed/simple;
	bh=kfRFs1y61STJpGoIsfDWPoCXtlrdMbyVHnu5G1ESIE0=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ItmiX1o6UQWvw4Lmp44lBdlLX+KAnLbPYCdiIJfXJiOF95l79DTKgkjl/vCi7BYbAxUY1vr6wsJ7D11IEWnes1SWa0AvUEaOSnX38UIXWHmk+78Dl5zsDZMBfPlGQtNwyM4/KzONtfsyfY/JJEa2zqoNWa0o4HNJyOB9RhSU86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC56Ff+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC56Ff+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9C0C4CEE3;
	Sun, 13 Jul 2025 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752419122;
	bh=kfRFs1y61STJpGoIsfDWPoCXtlrdMbyVHnu5G1ESIE0=;
	h=Date:From:To:Subject:From;
	b=mC56Ff+gKat5SP9YJPTie9h3Xbs5Gq99cpt3Gk5U4MJLKEvV+Xm3ZEu0jVgh9AelV
	 JP4RkbZByRp2TnXMnFkSQorNQ/yu4bvms+sLnlML3+qWFNG6IYQUfbl6WQ9d1z5Tr/
	 4AqfCTxMT/lWUQLLgH3kFb2lfvkbbY8OnNp5Ii2fzlu8UvpkCiZNlVVS0Oy3fytZAq
	 Btd9gb58wf8ojdt9V18Jj8T4NGH3N9o8lfSqVrW9a/YOV/0RHTL+wl4b7/DPSmcB0e
	 1PaQx8DFJGQph1fuyLZyayYegBYMnzmEIq3LTXNsst9WmFZW0kdP46N47/JsT368E9
	 zO2QtWuegf/QQ==
Date: Sun, 13 Jul 2025 23:05:19 +0800
Message-ID: <a72162253072554dcf966b3de715d509@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.07.13
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ov0apRXI7xvg"
Content-Disposition: inline


--ov0apRXI7xvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.07.13 release.

Release Notes:
1) There're 8 new test cases in this release, include generic/211,
  generic/767 ~ generic/770 and xfs/838 ~ xfs/840. g/211 is a
  regression test for btrfs known issue, others are atomic writes
  test cases.
2) Some testing bug fixes and code clean up.

More details refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

2e00b85742d6 generic/365: Add fix hint for ext4

New commits ([N]ew, [U]pdate):

Anand Jain (2):
[U]      [eb0191edd4a5] fstests: remove duplicate initialization in the testcase
[U]      [b964de2119d5] fstests: check: fix unset seqres in run_section()

Catherine Hoang (1):
[U]      [8d87273e43f1] common/atomicwrites: add helper for multi block atomic writes

Darrick J. Wong (4):
[N]      [fa8694c823d8] generic: various atomic write tests with hardware and scsi_debug
[N]      [7ca990e22e0d] xfs: more multi-block atomic writes tests
[U]      [a9dc5ac46476] xfs/273: fix test for internal zoned filesystems
[U]      [eb0d2b299ded] xfs/259: drop the 512-byte fsblock logic from this test

Filipe Manana (1):
[N]      [5408cc794fe6] generic: test overwriting file with mmap on a full filesystem

Leah Rumancik (1):
[U]      [a7b5d6b38296] common/rc: add repair fsck flag -f for ext4

Ojaswin Mujoo (1):
[U]      [2e00b85742d6] generic/365: Add fix hint for ext4

Qu Wenruo (3):
[U]      [de07c1558ce0] common/rc: add btrfs support for _small_fs_size_mb()
[U]      [9615d021e95e] generic/050: add a workaround for btrfs
[U]      [43128a0c543b] btrfs/282: use timed writes to make sure scrub has enough run time

Zorro Lang (2):
[U]      [d06bd62c4c42] common/rc: remove useless _pgrep funcion
[U]      [a673bfe9fb06] common/rc: _add_dmesg_filter returns when RESULT_DIR is null


Code Diffstat:

 check                 |   2 +-
 common/atomicwrites   |  31 ++++++++++++
 common/rc             |  36 ++++++++------
 tests/btrfs/253       |   3 --
 tests/btrfs/282       |  60 +++++++++++++++++++----
 tests/btrfs/282.out   |   3 +-
 tests/ext4/053        |  10 ----
 tests/generic/050     |  12 +++++
 tests/generic/211     |  63 ++++++++++++++++++++++++
 tests/generic/211.out |   6 +++
 tests/generic/365     |   3 ++
 tests/generic/767     |  93 ++++++++++++++++++++++++++++++++++++
 tests/generic/767.out |  10 ++++
 tests/generic/768     |  68 ++++++++++++++++++++++++++
 tests/generic/768.out |   9 ++++
 tests/generic/769     |  88 ++++++++++++++++++++++++++++++++++
 tests/generic/769.out |  16 +++++++
 tests/generic/770     | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/770.out |  21 ++++++++
 tests/xfs/259         |  24 ++++------
 tests/xfs/259.out     |   7 ---
 tests/xfs/273         |   5 ++
 tests/xfs/838         |  69 +++++++++++++++++++++++++++
 tests/xfs/838.out     |   9 ++++
 tests/xfs/839         |  72 ++++++++++++++++++++++++++++
 tests/xfs/839.out     |   3 ++
 tests/xfs/840         |  64 +++++++++++++++++++++++++
 tests/xfs/840.out     |  15 ++++++
 28 files changed, 870 insertions(+), 61 deletions(-)
--
Zorro Lang
zlang@kernel.org

--ov0apRXI7xvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmhzywIACgkQlNbPkfr2
tMxCgw/+Pkm6zruO78+FLvU+SL61I5voWhA3RuaVCdNzUYDS7TaGCh3lMYPhwjwe
/EBb/Kt+vZ6sp//BKTtKiITIkSDjrH/+yO4iFNegvQd9FnjScD1VlsHV4qCq/O1U
I85tNAiOOMhhSIXaru9axoXMXFi4t5s3Zu2eFDj5XDyGCcWKFGA5Pohs9vbPh19c
SXsTPCa4wJFIp8oIMhaOZZn+O41F0gylfzN7ItAKDsZLNCDC+gDVyV4ZHwIMmu1X
6+PSLmHjVeTwjqmAkYHO0HTkrHuBp96E+MJ7EeR6o11cNZmMpGi1lmRqPLmsn/3R
cINnXZLhLXVbrrm8Zp77mgO1CLf0Z/cxl8W2zPu8y8/Umi/b9thmFM3msLVhjUVD
UmJwRzmyetZ5q3JQvKdI/WdvYYJNNlX+P0isBffzUPvd+Gnm4NF4nDhTV3ZtXvhS
W8hPAnDBT1EY2CcSexYVazeR7ew3YxqlgPAkY9OdwL4CNpCwKYLAtlQc6OWaXPKN
61jWj0YSetsfkx4Aw/PHZgzWn1anp5nR3YuQh2lCmPtChMUcoBUWTgzeKRLn8FdL
Xg/EtTOSOyq0KDl23tH1cgrhNVZtn2XF4tcikOrcFL1NpnGAf8KI4roKvkrJBTNq
W2h+WPaAj6qi+n3qDgwNepZFD4Aq7pNzYM0/+IbUo4JZUl/RIyo=
=otue
-----END PGP SIGNATURE-----

--ov0apRXI7xvg--
