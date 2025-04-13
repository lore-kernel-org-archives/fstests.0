Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38D1B3935
	for <fstests@vger.kernel.org>; Sun, 13 Apr 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744550869; cv=none; b=fQZjTPLc6S/OM2Ff9z9yDmeDcMahX6Z9j6sGHHQbZ8G7c+qqmAIt23GcshgwbyLjxR5qCZFZ58xcSWL41NHH2/Y1fhJGI+IPja1fMt0M3yw0xYmuyixhmGGse2tJVpTwETo4UZt1nSYOs0VNYPntjHHtHWw3MzqSMilSeNsXApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744550869; c=relaxed/simple;
	bh=hcn4FGJp70ivM+yNksLmjemXik6DsMr+FeMAQzhyxAk=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=SHNPVCVgVq3sDNpy8eTZyjXEkYcdxhlM3buA/1yMtrcW4tzmaTRVI8pITbySfY5AMjljU+NT7LWtL81ErsVBu3iJZf6mW7it8NAZzU3rIYIly2ttYnEjIfsPt7KklWxybDSJUGM2FWWO24mvA/ppXIPW8BGqaGiabYm4ZkNv6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIh4kj7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIh4kj7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8FEC4CEDD;
	Sun, 13 Apr 2025 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744550869;
	bh=hcn4FGJp70ivM+yNksLmjemXik6DsMr+FeMAQzhyxAk=;
	h=Date:From:To:Subject:From;
	b=XIh4kj7kyDBp4RrfoH4Q/95bYJvgC6FK1ZWfU2EZDtJswMdEgDuNE/seIyH/c0fEs
	 w2lEz/dTwMNmw3pNRPZpBoA1cIifKrrD6BfwayX6W54SoxWadF9sZV0/cUarr8/Bb1
	 KXHtZVTadeJ7Zwf3d7rmCk46YzcNV8PdVfKEcUgVnJNho8CDUQ8V+YjBWB/W55O8u4
	 K6a9MTXbiUHltgeuIzP4e/jBH/HMtIcQHiODqqAsZQJMy9dUU+fkg+DVB6amGqMFqJ
	 A46brtQesjsggTfbWPHcY/Lsv1rVEzVEktAuNA3b9TDpziyfp5w0dXn1CQzBfCSufv
	 gdZETfCnl1YXw==
Date: Sun, 13 Apr 2025 21:27:46 +0800
Message-ID: <edd2224618169707c37d1c35bdcb0e05@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.04.13
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bc2qNJlz2K8Q"
Content-Disposition: inline


--Bc2qNJlz2K8Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.04.13 release.

Release Notes:
1) There 3 new test cases in this release, include generic/765, btrfs/329
   and btrfs/334.
2) x/629 ~ x/632 have been removed from auto and quick groups, please note
   that, if it affects your test plan.
3) Cleanup some codes in common/ and check.

More updates and fixes refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

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

--Bc2qNJlz2K8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmf7u7wACgkQlNbPkfr2
tMxSOxAAldV+MFcKzyL2+k5r1/kuTbYAYPQ0KeAP7npXKKPp79Xqf5IOTlPxorUR
t/eaP1MvU7d6rezc1wTTb5BesuKHpSYpkFHt+mLKq2LwF5de2D+PByii5DXeExsS
FzoDviwRxHtCMnaUAqbe1DjiAiQa5cr2jMdAWlQyaolggftBf+Uupl+bWbyx2gNZ
79fGZ5ERggGDWPWuj3hEQCjbXKI8jSbvLvNmVU/3k8UvD9qSBWGmOpmCz5Jk9fGb
xK2myX+jYuTQByH21fqo79CIqWPTfdbvPbSMPo1zSBKuPyEK8KHbgJFeV/thGbLM
aQx+QiURKsj9YJd+HnfK/v98tFPI/u0z/ZRctecGPYQpO/bvJqV0kGWB5mdAVOQN
jHByxi63bk5hJcfE2nZKyixzj3oOtkLiZ+KAEiyAPhStcjqpYeMUjQrwfjWgn6q3
mt0Qy03NhLQGnMEL8+l2y9CmyWjfwn3bNzIe/OOYFwFIbZkkWXSZznIlrTfpcJTU
TJdV7uC/AsSXILFk9x3qcLok5lqT4YJ129xdj7KeJvQLf0aI8NcA+jJRkcFZdRg+
XojHOuqglP0/3tCN9QdjzR/qlwM8OlhXulM7dlF8aqtFClAZDvkbA8UyqzpRiDpa
E5ArcGJGFapsaopHSQOIx1fiVPnmBa0fGEVnkTnmOWuojyJ/qwA=
=ZQvr
-----END PGP SIGNATURE-----

--Bc2qNJlz2K8Q--
