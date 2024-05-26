Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC53F9DF
	for <fstests@vger.kernel.org>; Sun, 26 May 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716734210; cv=none; b=VuvK/3PGxTe08Y+N9J+6GBV9kcoOFzBEUjE5zx4FQBnhSP/jozq41EWtA/Qzs1RJN7wGeHw/fLx16PdiWJKspO0C5KRgYXj5fdUaYbTNUjtybagYkG1kNbtg7KqSzrCe0dVhbTJWFYlWVhO7rjt1LXXokuqAZvXA5XyYJ3tFtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716734210; c=relaxed/simple;
	bh=DOdvX18WYBWsOQAtHta70enOpLOzOHqiPjqMT6soojY=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=aJ3w6yTucK7+H21lZn0wndNNTS9zN17Ju69mP3IWx94jPp94Ig6NqGTuKXRqxGixYhVK+TkrVhqUXXBzhcNZf/F+PI4zfa0JNbsIOifcC174OroMOljt5kbjaAVOuCLhRoll48TRXMIE559Cj9kWImykBojWwwtHMYHUXawjnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCy2HZp9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCy2HZp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE8FC2BD10;
	Sun, 26 May 2024 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716734209;
	bh=DOdvX18WYBWsOQAtHta70enOpLOzOHqiPjqMT6soojY=;
	h=Date:From:To:Subject:From;
	b=mCy2HZp9i5yxAm7K9Aok1wHiplb+DRiLc+mxL1lG9K7xSTc3eHEk2fDNNnhLegZE+
	 /sp4tCQADRD72L2uUXLL1GcP8cVd4+hXpH5TsvutVLGE56SnCR8TbTFspX5mh/KcLf
	 Jn/fqnWyx2gAcdYljG3TZ7nSUUvh0QoAAsDXsiZEyxuhoFio7btV993dudbdzNddBm
	 B81cDbA0gv+AC1gd3u4oAktKAw8aLnrVZe4LXdVNPjTlWV6i9lq8q9greV5pnoVSZm
	 Sl9k7dYgCMKbCyZMRZm67NWRJxHV/Nm872ibqsR/ZWLh+SzzxgWBLtUCmBvsfc3GCa
	 3vYFtWR7LR0JQ==
Date: Sun, 26 May 2024 22:36:44 +0800
Message-ID: <c6a0ccb099f02737ac7bc2f055976395@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.05.12 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X4skNeAgU9jo"
Content-Disposition: inline


--X4skNeAgU9jo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.05.12 version.

Thanks,
Zorro

The new head of the master branch is commit:

983797138373 generic: add gc stress test

New commits:

Christoph Hellwig (2):
      [79ed115c9151] xfs/077: remove _require_meta_uuid
      [1c19089ca830] generic/095: add to the quick group

David Disseldorp (1):
      [41474afbed5b] tests: _fail on _scratch_mkfs_sized failure

David Sterba (4):
      [3b598326c532] fstests: move shared/032 to generic directory
      [eca6509aba8d] fstests: move shared/002 to generic directory
      [f0ab9e59c7b5] fstests: move shared/298 to generic directory
      [dbdfd011c8ef] fstests: remove the rest of shared

Hans Holmberg (1):
      [983797138373] generic: add gc stress test

Zorro Lang (2):
      [8e8fb3da709e] fstests: fix _require_debugfs and call it properly
      [abc79d83a9f4] common/tracing: use /sys/kernel/tracing at first


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

--X4skNeAgU9jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmZTSMkACgkQlNbPkfr2
tMzSvA//YWaS7Fv6mGkHrwEifoJNbKeRw6wS6d5aPk0dUxF6M9idHlWac1oU9Sti
t9dPfzY3gOojuH+pn8xzPgxF6jVBenjaikNGCbe/ADwfmd3Arit2tNXxdAUPlIBw
2MdiCnMJIr2GChoC5hQYSt1uvjoaZm797k3trguLBk9efoolBSaee6Y/MPssjuqP
4EE28r5leTggePGoB1fU2wXGZMx4hsOn2o0CAmDfZNwaNi/+8GlrirDa0vor1CX3
RauPQqdPAc+3R4Ds9r0M8MrIliCFSPtyb7lPUONa3HoSfPasrRvXErwCwuaolDyh
xLsmpr5gIPI/nkLjW2WKbaoeeWzdOUHQCHR3ydv7SB1ilG3701xWHlhSQvF4a0f/
CYJBmaDdgvn61pv+iDLyr0LvMMw0Zpk1v/0cHA0VyJEuYvyn52Nt7S63nHQMHzAf
fHmgwoWTVOLiYNB02K4NDorEZCpezTWNTRLWcSp/ua8qvNokfMllANWuv4dGS+NL
m1c2nV52lfCgymlpwn6V/VKL/lXAXwLoJvwBm8IdNznZ78Y8e2zgcO8fuZ1sMtLg
Cdr697whY6hjsbF1ptekljP1cMFMco7Lrsi9gOkM1+3IhpU5TDXyCloBoIJMMfxi
aj/lixXNAKXtVAFB8/bJO0TomjK2PvpysIsvjPYE6PH+akUo4R0=
=BkAY
-----END PGP SIGNATURE-----

--X4skNeAgU9jo--
