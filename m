Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ECB34BA4B
	for <fstests@vger.kernel.org>; Sun,  5 Oct 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759680815; cv=none; b=kZJTgNBEZLxTKTLFpGpCf/BVluBiwVlJHyMBqDbRJ2ejALnA67w9oOA3yYJ1PAooTt7i5Da+E90KmV5DOrhhkOy84VOpO+7vMBvAjsflwUwgc1QbUrOgjd14xVI7U2nwKVkFxqIPJEMXfLLBUWtEtJxiByF8M8KXzXQRiPH1qjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759680815; c=relaxed/simple;
	bh=LPG5ZlgUGol6gLVE3SlAi8PR78lUdIH8rlfKRJafzFg=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=T1EqgO7omURtKEBjekcH/ISa3KTQEJ1pM2p3n5FbKpbT/0uFdC6Grh4hDrSv0j0eUhToWg+PBMAjL/C2IGURCs7aMgaM8U0ZzjyZee7TD7UEePe8eJ/18A0RR+EbDwbmFyMrOFPVZSmfGl9g8qOQ1jkLK0oPZlfRyEytYsBTfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjp1FDBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjp1FDBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3FFC4CEF4;
	Sun,  5 Oct 2025 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759680815;
	bh=LPG5ZlgUGol6gLVE3SlAi8PR78lUdIH8rlfKRJafzFg=;
	h=Date:From:To:Subject:From;
	b=hjp1FDBwzFLTkPFo4PX/f/R4aG7Cnoz87nUeRdDOuDJcM5lwstHkc+fXjlREj8IhE
	 ELyNWTf27aYfA+LNAOxlolgkBwYvJI91DZfBPOddr0Y7ksKUBjmMIOaA9/+X5Xjdon
	 bRTvKBacIQTPkqSbxAp2wZrArqywKaiTMpeDcG8y/DXLzTuFt5fILQtq+7qqFRba3F
	 3lXVvfDk2HMCQS+HJffsEC5NXvguFjTDRLPMdrgZGQSgrY5wom1AOhhppJqpjmPcUm
	 fnZH7dljCBXS3AT1VT9RmbQQqUxUN5ziRXgkl693MdGm6d3VTDYiEsU7i1hz1lHJKD
	 gSPURfhZYDoEw==
Date: Mon, 06 Oct 2025 00:13:30 +0800
Message-ID: <834a6e1ed1f377c9a014a55093a102e5@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.10.05
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BLpH6EhyaZjp"
Content-Disposition: inline


--BLpH6EhyaZjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.10.05 release.

Sorry for this late release, we have many patches are still under reviewing
and updating, I'll try to merge them in time when they're ready.

Release Notes:
1) There're 4 new test cases in this release, include generic/772,
   xfs/648, f2fs/021 and f2fs/022.
2) The g/772 and x/648 are new feature test cases, to cover new
   file_getattr/file_setattr syscalls. They might fail on on old
   kernel which doesn't support this feature, we'll add a proper
   _require_ helper to _notrun on old kernel later.
3) The f/021 and f/022 are f2fs regression tests, they might cause
   panic/hang on old kernel, so downstream testing please use them
   carefully.
4) XFS attr2 and ikeep related tests are totally removed, due to
   xfs has removed these two options totally.
5) Some btrfs test cases are fixed/updated to be better to run on large
   block size btrfs 

More updates or fixes refer to below, thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

2cba4b54e6ab xfs: test quota's project ID on special files

New commits:

Andrey Albershteyn (3):
      [ef1028cf0379] file_attr: introduce program to set/get fsxattr
      [4eb40174d77c] generic: introduce test to test file_getattr/file_setattr syscalls
      [2cba4b54e6ab] xfs: test quota's project ID on special files

Brian Foster (1):
      [986a4cc1f5a7] common/rc: destroy loop dev before fallback recreation

Carlos Maiolino (3):
      [e2932df1b5d0] xfs/513: remove attr2 and ikeep tests
      [21d6c88606ce] xfs/613: remove attr2 tests
      [c3b7b05756d6] xfs/539: Remove test for good

Chao Yu (2):
      [38ae4c5048a0] f2fs/021: test quota mount option
      [9460a05243ac] f2fs/022: do sanity check on footer of non inode dnode

Qu Wenruo (3):
      [ebfd9f1ea7c6] btrfs/012 btrfs/136: skip the test if ext* doesn't support the block size
      [f8d78645f2ab] btrfs/192 btrfs/30[456]: explicitly specify block size to avoid false alerts
      [57589265bf74] btrfs/26[67]: update the stale comments


Code Diffstat:

 .gitignore            |   1 +
 common/filter         |  15 +++
 common/rc             |   3 +
 configure.ac          |   1 +
 include/builddefs.in  |   1 +
 m4/package_libcdev.m4 |  16 +++
 src/Makefile          |   5 +
 src/file_attr.c       | 274 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/012       |   3 +
 tests/btrfs/136       |   3 +
 tests/btrfs/192       |   8 +-
 tests/btrfs/266       |   4 +-
 tests/btrfs/267       |   2 +-
 tests/btrfs/304       |   5 +-
 tests/btrfs/305       |   5 +-
 tests/btrfs/306       |   5 +-
 tests/f2fs/021        |  30 ++++++
 tests/f2fs/021.out    |   2 +
 tests/f2fs/022        |  54 ++++++++++
 tests/f2fs/022.out    |   2 +
 tests/generic/772     | 109 ++++++++++++++++++++
 tests/generic/772.out |  37 +++++++
 tests/xfs/513         |  11 --
 tests/xfs/513.out     |   7 --
 tests/xfs/539         |  72 -------------
 tests/xfs/539.out     |   2 -
 tests/xfs/613         |   6 --
 tests/xfs/613.out     |   4 -
 tests/xfs/648         |  73 ++++++++++++++
 tests/xfs/648.out     |  15 +++
 30 files changed, 655 insertions(+), 120 deletions(-)
--
Zorro Lang
zlang@kernel.org

--BLpH6EhyaZjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmjimMgACgkQlNbPkfr2
tMzYWxAAg7nvQJM0R28WBE6kyH04hjg6AnJukVSS3Q7+Y6GTS9HnFU3adXSrlTtF
zfLhV2sKcmfsK6m+ONs3+g0XXYuJWhYxofO12aY27pIpbDGWtCXf45iEjTlJnjyr
2qV57dzfPOumu+48Y90Lg1mVA+A8Sf8b69QxWif32Vi6oIIH6iAoN0QauG/mx76S
elEy0bHCxnEv7SCBpaejezVsm12jgkl6WxeAeMWj/DMF8V9Rz03Sodlh+ChsNK2P
vRYtfmDe2udRvqWEmv65tVF7EVneSOYo2/Mz4MQbjP1/dOfRZzAnoMkRf15/7ssd
1ReBzTsAVAPlC7zNwR7ffEgC7XK40XlmDD0OHy4ahlRqLVaI/AQ3vqzfqDhoCII2
2GDbgCjxTzFG6YfZu08UTK7pRMcyNmQ/f3+Ttq7eWhjJxMbXhOR3DukEM5hgls09
Hh3m7R/WLq3Qfd7UaOaxm93cffOJlXWifjxmT+erNdl5ygNLhvzNuIJwbj4vMIWw
CYtQpL3eE9sJypLhrA65OltqLNrsXwyxtllhRh7DqSK/4u93K8vjxazyg3bpXsZ7
o6pwni71PZKG2vbmlC0wMCJ+Hq3m+C/bHsv0s97t/DLDOUQbi8VrEnxI9Yp8JllL
EwIeIRMTk3H784zo7ZV+nhTqkZUsEYT3bD8QfHa4xie+jKnsJXc=
=LVlR
-----END PGP SIGNATURE-----

--BLpH6EhyaZjp--
