Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E6438000
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077748; cv=none; b=rrT0kmdNodbU3Y2u1518hoxujgPjd2hkzg6sCNpo0q9F6XR9X1v4YWHMLamIJXkxk484nLRRltWSKfTtJHIui4L3tPD23B3V2I060s5p//0lpsM+Dkr5/9Ib9f5fX5/RVulWGtBAuXQBMH/K7H7ZNLjPBvl2bWYvu138vBkId3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077748; c=relaxed/simple;
	bh=CI1Cq40uROQ9p2tssY9wQC9yepP/afUYAchrbRjms3E=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=iojLZssAxU9CsUnfGklPGVGvJudnA4zy0DL+eGX+w4bPJaS+DNWRLvZjY3qMU3YdraavdfMKNH7IL6tVHwxzyxF2z/7QKEy6pa3mjd6saMYiIsHtHEYlULv5YtIYywmpRHE8h1E03ioac86K7gXVbYMD5F+S8pF8zvfKqqXCXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lODgLBK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lODgLBK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434C01F000FF
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 11:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077747;
	bh=oxz1DRsekrZkrcivEj/wfmsazmBahWeHU5oz8w0+lXE=;
	h=Date:From:To:Subject;
	b=lODgLBK+C8KwUNz/EmYJXB/SILHISabZ63iFAmWmDjC0BKqnjmIP4vxfiRCHDf9xS
	 gavKcCSh6ZBVLdFZMy9N6H3jp5avcfVPMHqvzFsUeuxm2rV+qW5PuE4oAGOq+BGY1c
	 kPE2k3u0GKd5Xb1KpprmpyFdpcR4g/q1WlYn92C8+xcOLYofZ2IX/AnWHXOiiNWdxF
	 GebeLjiHBVcyNDD7uTbWXuVPZU2XJQarYUC41STN2gONBxvXEX/46JnQpnU/BIfcFe
	 K6RzGI7p+tQE1Dgg6pIvghewWjXX7rXziQ1RT1M4rD82jGals56OsiQM/PCmn+rsjH
	 q7n/BOY1pdzRg==
Date: Tue, 22 Sep 2026 19:49:02 +0800
Message-ID: <113fe2750efeb08bb47c93fb34900d21@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.09.02 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="KnuXu1qmRak5"
Content-Disposition: inline

--KnuXu1qmRak5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.09.02 version.

Thanks,
Zorro

The new head of the master branch is commit:

3e1ee800e52a check: add deprecated options warning

New commits:

Avinesh Kumar (1):
      [3084fca70da9] generic/798: chain xfs_io commands into a single invocation

Christoph Hellwig (3):
      [ec1de92a465e] generic/730: don't override $SCRATCH_DEV
      [63ff3b39b21c] xfs/649: don't override $SCRATCH_DEV
      [440d41ec2eac] xfs/073: destroy loop device when mount fails

Darrick J. Wong (4):
      [328d1f426d9b] generic: test reflux with exchange-range
      [a27e980f7d88] generic/800: TEST_DIR, not TEST_MNT
      [1b0edd611283] xfs/030: skip this test if metadir gets enabled anyway
      [329a50b47d25] xfs/837: set rtinherit on the root directory programmatically

Eric Sandeen (5):
      [dc4787e81310] generic: remove chmod of $seqres.full file
      [f94089087b34] Add _require_chmod as needed
      [3ad176c78926] Add _require_chown as needed
      [b9d514422d99] Add _require_hardlinks as needed
      [9ed087ccc9f2] Add _require_mknod as needed

Johannes Thumshirn (4):
      [c2d757a9d1bf] common/btrfs: fix awk field separator in _check_temp_fsid
      [45cc03678313] btrfs/199: skip on zoned devices
      [bcd1ff37a5cb] btrfs/284: skip on zoned devices
      [139aeb3493df] generic/781: fix copyright

Manognya Singuru (1):
      [623b555aa32a] common/xfs: filter mkfs.xfs stripe geometry warning

Zorro Lang (4):
      [984845aec939] check: refactor argument parsing with getopt
      [d0f510629f94] check: update usage and README to reflect new argument parsing
      [a5eccab3a040] check: consolidate argument handling into function
      [3e1ee800e52a] check: add deprecated options warning


Code Diffstat:

 README                |  10 +-
 README.overlay        |  18 +--
 check                 | 440 +++++++++++++++++++++++++++++++++-----------------
 common/btrfs          |   2 +-
 common/config         |   8 +-
 common/rc             |   2 +-
 common/xfs            |   3 +-
 tests/btrfs/199       |   1 +
 tests/btrfs/284       |   1 +
 tests/generic/066     |   1 +
 tests/generic/084     |   1 +
 tests/generic/093     |   2 +
 tests/generic/099     |   2 +
 tests/generic/105     |   1 +
 tests/generic/184     |   1 +
 tests/generic/193     |   1 +
 tests/generic/219     |   1 +
 tests/generic/230     |   2 +
 tests/generic/235     |   1 +
 tests/generic/237     |   1 +
 tests/generic/244     |   1 +
 tests/generic/256     |   1 +
 tests/generic/305     |   1 +
 tests/generic/314     |   1 +
 tests/generic/317     |   1 +
 tests/generic/318     |   1 +
 tests/generic/326     |   1 +
 tests/generic/327     |   1 +
 tests/generic/328     |   1 +
 tests/generic/355     |   1 +
 tests/generic/370     |   1 +
 tests/generic/375     |   2 +
 tests/generic/378     |   1 +
 tests/generic/379     |   4 +-
 tests/generic/380     |   1 +
 tests/generic/384     |   3 -
 tests/generic/398     |   2 +
 tests/generic/400     |   1 +
 tests/generic/423     |   1 +
 tests/generic/440     |   1 +
 tests/generic/444     |   2 +
 tests/generic/449     |   1 +
 tests/generic/462     |   2 +
 tests/generic/479     |   1 +
 tests/generic/495     |   1 +
 tests/generic/505     |   1 +
 tests/generic/514     |   1 +
 tests/generic/520     |   1 +
 tests/generic/535     |   1 +
 tests/generic/556     |   1 +
 tests/generic/566     |   1 +
 tests/generic/572     |   3 +
 tests/generic/573     |   1 +
 tests/generic/581     |   1 +
 tests/generic/587     |   1 +
 tests/generic/597     |   3 +
 tests/generic/598     |   2 +
 tests/generic/603     |   2 +
 tests/generic/622     |   1 +
 tests/generic/636     |   1 +
 tests/generic/641     |   1 +
 tests/generic/673     |   1 +
 tests/generic/674     |   1 +
 tests/generic/675     |   1 +
 tests/generic/681     |   2 +
 tests/generic/682     |   3 +
 tests/generic/683     |   1 +
 tests/generic/684     |   1 +
 tests/generic/685     |   1 +
 tests/generic/686     |   1 +
 tests/generic/687     |   1 +
 tests/generic/688     |   1 +
 tests/generic/698     |   1 +
 tests/generic/699     |   1 +
 tests/generic/709     |   1 +
 tests/generic/710     |   1 +
 tests/generic/721     |   1 +
 tests/generic/726     |   1 +
 tests/generic/727     |   1 +
 tests/generic/730     |  11 +-
 tests/generic/781     |   2 +-
 tests/generic/782     |   1 +
 tests/generic/789     |   1 +
 tests/generic/790     |   1 +
 tests/generic/792     |   1 +
 tests/generic/798     |  19 ++-
 tests/generic/800     |   6 +-
 tests/generic/802     |  65 ++++++++
 tests/generic/802.out |  16 ++
 tests/xfs/030         |   1 +
 tests/xfs/073         |   1 +
 tests/xfs/649         |  17 +-
 tests/xfs/837         |   6 +-
 93 files changed, 524 insertions(+), 200 deletions(-)
--
Zorro Lang
zlang@kernel.org

--KnuXu1qmRak5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmqyaxoACgkQlNbPkfr2
tMz/zRAAqQf92MadEQ//pF563enytgse9x2lGMNs8fvztdR+F5DWa5vxP/Fk/qwS
mmvuMT9UQOg7TN3zUgc36fxnenBu8jxo2QAa4+4VcI1CzE+Uv4gRvpO2dMNcY266
I+WXAIiG6vHuXl2tKemgHzgV1fhyI9ZptwqMcIBgrAGFCQvQdjok66Td8V8kV78Y
bme0fi+0d+LHwUtlykbnkNk7Q75YExH1x2WjkGPsT+cIAMReU6ypKc8xXgXRKCxk
UMsRol4FebIcSMagwUj5R/dbA+hfy+ML/HAFNHf6l+ZGA9oqpqZmsV2Tue2dqnpi
rZofuesi0jd7c/pV1etFNet9FtwAqtDM4snlVhUCvIskvLiswKUjFvTOY76H3LS/
d0rVJOtbbCkAA0YVGUv63cRB6lg1fpvXMCJONA+cVy/6mgNCCXZCaqM9CWlESV8L
7aq7YKC7iQZANLhgim2DU+Vvc5E7vVfIKzKp/HbTYjPo5o6JLF34/QbBft0FHvMw
lfWoKuDnfLnowRO6fNl7DQRAhBMvyBUhhvBQzoljK6dudMbTQPOJpyP+lgfeXRen
rsmHEd/Nomf+l8FY9SFTd/GygnoBuGii1vTMHct+geDK0i8POl16i05KjMDDeSRa
U5Xm+PnbhkoKuY8oLnYsjUAcKIj2tZApJI5biVyiBUoPvhcf0y8=
=Z5WE
-----END PGP SIGNATURE-----

--KnuXu1qmRak5--
