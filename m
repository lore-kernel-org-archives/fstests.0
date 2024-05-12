Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E04C630
	for <fstests@vger.kernel.org>; Sun, 12 May 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715520339; cv=none; b=DcrIsEKdTxdmKfC4o4fk5W0QaA68nDqXt2wwicFx1qy4t4qJWLfYtWwBBkim+eduIXDFaMdeK/zczAEvuqWWg/Gu5Opf+OyiMW24RDg0IZCK6BmO4JOm/PDXy+M6qNYZzek5LBq1uIv1MGOCQ2nokkMC+uXtN5yqmEPm+1GukRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715520339; c=relaxed/simple;
	bh=dJHGsMGN7fmVnAYEOyNQrHAwBPntv+umpoxMSbxv1jI=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Fql2/+pUgB5XX825bk5XZFs2CUlJAG3Qzdvapa4SzvokoDERrgLXxIDH2m/nyE31NCrnkpMrRruxhYsfTNmLC6xzPiPHpeD0sdHHuc8WUAPO5b/BOveJsftChOswy+AvMjnaMCLJLO9+Z3BjIepynx5PTxtr8agiXLZXnxh3gCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4XbsdZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4XbsdZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF215C116B1;
	Sun, 12 May 2024 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715520339;
	bh=dJHGsMGN7fmVnAYEOyNQrHAwBPntv+umpoxMSbxv1jI=;
	h=Date:From:To:Subject:From;
	b=H4XbsdZyA4CdiqqqH2zhY49asQPVkFl3zAuPPVa0S6Y01RfEpvMXdfN6ahVPKno98
	 OYg13GA1kVjbVM9Mf6JRhsvvXV1ZD6l52bZEmrTmT94jibSd1QxyR3hwSX8NAF54Sw
	 XDFW7wTGDQnNjmo8cGBLNY8qTz6RPoPAuFOY7KlSzgHt+wQAZ/JaS/Bmlcr+R0j2kQ
	 EjI+8v+6eYWgB2mwGRk1JiRT0KfGEbR986NGBJCTcyUXjavAwvG1fIPwKlkgRK3SL2
	 u1JqvJbjwxUbxBxpco1ueOZBWF2H9qIV515/gckePrZi0e+A23Qmflf/EXPooHQ7EZ
	 bBxeHyU8mSDgQ==
Date: Sun, 12 May 2024 21:25:36 +0800
Message-ID: <c2269f1adba6e5d31f8601fdc3ea1b15@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.05.12
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RoeJnaX9Ihad"
Content-Disposition: inline


--RoeJnaX9Ihad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.05.12 release.

Release Notes:
1) There're 1 new test case -- generic/747. But please note, it fails on btrfs,
   as a case issue (maybe).
2) All cases in tests/shared/ have been moved to generic directory. There's not
   shared directory anymore. But there're still more jobs on it, those cases
   from shared/ need more _require_xxxx helpers, not hardcode fs white/black list.
3) The _scratch_mkfs_sized will exit directly if mkfs fails. Please use the
   _try_scratch_mkfs_sized, if don't want to _fail. More mkfs helpers might be
   changed like that in the future.

More updates refer to below. Thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

983797138373 generic: add gc stress test

New commits ([N]ew, [U]pdate, [M]ove, [R]emove):

Christoph Hellwig (2):
[U]      [79ed115c9151] xfs/077: remove _require_meta_uuid
[U]      [1c19089ca830] generic/095: add to the quick group

David Disseldorp (1):
[U]      [41474afbed5b] tests: _fail on _scratch_mkfs_sized failure

David Sterba (4):
[M]      [3b598326c532] fstests: move shared/032 to generic directory
[M]      [eca6509aba8d] fstests: move shared/002 to generic directory
[M]      [f0ab9e59c7b5] fstests: move shared/298 to generic directory
[R]      [dbdfd011c8ef] fstests: remove the rest of shared

Hans Holmberg (1):
[N]      [983797138373] generic: add gc stress test

Zorro Lang (2):
[U]      [8e8fb3da709e] fstests: fix _require_debugfs and call it properly
[U]      [abc79d83a9f4] common/tracing: use /sys/kernel/tracing at first


Code Diffstat:

 check                                     |   2 +-
 common/rc                                 |  19 ++++-
 common/tracing                            |  13 +++-
 common/xfs                                |  15 ----
 tests/btrfs/004                           |   3 +-
 tests/btrfs/007                           |   6 +-
 tests/btrfs/150                           |   1 +
 tests/ceph/001                            |   2 +-
 tests/ext4/021                            |   2 +-
 tests/ext4/059                            |   2 +-
 tests/generic/015                         |   3 +-
 tests/generic/077                         |   2 +-
 tests/generic/083                         |   3 +-
 tests/generic/095                         |   2 +-
 tests/generic/171                         |   2 +-
 tests/generic/172                         |   2 +-
 tests/generic/173                         |   2 +-
 tests/generic/174                         |   2 +-
 tests/generic/466                         |   2 +-
 tests/generic/735                         |   2 +-
 tests/{shared/032 => generic/740}         |   2 +-
 tests/generic/740.out                     |   2 +
 tests/{shared/002 => generic/745}         |   2 +-
 tests/{shared/002.out => generic/745.out} |   2 +-
 tests/{shared/298 => generic/746}         |   2 +-
 tests/{shared/298.out => generic/746.out} |   2 +-
 tests/generic/747                         | 121 ++++++++++++++++++++++++++++++
 tests/generic/747.out                     |   6 ++
 tests/shared/032.out                      |   2 -
 tests/shared/Makefile                     |  24 ------
 tests/xfs/015                             |   2 +-
 tests/xfs/057                             |   3 +-
 tests/xfs/077                             |   1 -
 tests/xfs/499                             |   7 +-
 34 files changed, 181 insertions(+), 84 deletions(-)
--
Zorro Lang
zlang@kernel.org

--RoeJnaX9Ihad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmZAwtgACgkQlNbPkfr2
tMw72g/8CzRLqCTS+rgEOH7yQ7NH/kXQaHRu9y5saSVo7oxZPMRI5L23nZFdmyXI
mcMjlhFx78xxPBVIXEOYkakzoVdmzFM7sfwtlQlRaLMQKO1CiUYk0OOqFBZokSnz
N//uNKdLjRClR0tNyCC/s6Ch9/Yze0GYR+0T67524d4+CQaig/1dZCMjAgKTmw5/
Uzgl0KvrhIt62yGUl5lJk6FLmJjm8jLo2xypRZNj/LlOjtHq5Pw/K3IkHEjFnRkv
zk0v7LTnU8K6AXWF4XzZpTocuPRzb5BL5a4Jvhdrlm/sL8N+vOV3SszCsgXDTpzt
VkbsZ51TSlhdk4tElfzFS7CmJThbGh1471SrDDpjylr3ZjOULJr2e0Bm4+0WGrR5
80bspJTvF6qIh+Em3L/zoGbZpGzLC+M8Z+qt+YTgEI4M9FBvQ5fDitdf8LRiNkBN
5lNEZ7jMUkOs/AXm9gdTnHJj2IlN6Uxm1GhWOmT6hsWdRm3lUA6hYW8oGlxIlawU
MVykEmj1X3BsPV6H9RaxICPxzaNLpaVjdgMoWooxArxZYb2wlts/DJsRP2P+oMLo
tnZl1iBY0BeIR8KyN/bLtHaoOqZcT3JEhv1rlph+OapV4Q3esE1T9Y9DxPqJ/zi9
LyhSdZAW6klKvtQmRuiJrjvuXjOUq2Akwk2t0HAinWLrzveBt74=
=aA5S
-----END PGP SIGNATURE-----

--RoeJnaX9Ihad--
