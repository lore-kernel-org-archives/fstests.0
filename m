Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2B4A3C
	for <fstests@vger.kernel.org>; Sun,  8 Dec 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733665871; cv=none; b=MAw7XcWqwBjPZcS+DIc22+J65zLVEqnUyMqoyHXF5DFtGmjcExKbDOlGHwDVPZP9ZTr5ckG9LfVULPtopKqqEm0gmfcR3jAn5MSZveCjp5U51hMlAs7JyJx+RGEClq22cbJ/z+RiHm40yh2On/l7GhQeo87bgCf+UvT0t7k867U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733665871; c=relaxed/simple;
	bh=44MV4DADLUka3Xf2dqJHXZgrRTw7uX7FZBBMsyYeAMY=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=GYrnWZswbnW0BVS8hWloMVBG7OPRDEeUz/x6zZF66WaUFNvGwF/jfvmzlbMEHPCMLpgZXe7T2f47OOMBJmc0c4ToIvVCSwoySNb8wdXGPkY448EgKV7ZgtAcjmvrB1O6DGk52phKFg9a09XyF2NT5aNcvtEdBfY5pkwzJq3p+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBQ0bgNG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBQ0bgNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BB6C4CED2;
	Sun,  8 Dec 2024 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733665871;
	bh=44MV4DADLUka3Xf2dqJHXZgrRTw7uX7FZBBMsyYeAMY=;
	h=Date:From:To:Subject:From;
	b=EBQ0bgNGbyGGLyJYggwZaDWAhur6BgD0xSV/RbCMcoq4Xy+wRDx36JxWdlSgTP5d7
	 zKYvg1AjjytIDBwakHHQjZikoERCXIzex8L6RNYTGVmZAfeNXMpKiyjzh92zktuXCV
	 cKBN8KybEbf8T1V9iZ66rVe44vOFJxItGQW1Ql5hFwWpGHqcmmB+IL43VddzxFUTaW
	 zX9m5BFRSzMsAdZV1QuilrDegKGSXGsvDzxKQ95pUfMF72PWeWTzs8GQkEqXkxxad6
	 SDkCr7LJzXoyHEzIK68SFnI7CswQR3qTepb8exZvDQYUcU3qGssUJvdfBfCz98q5Mm
	 BM113+RCB7IZA==
Date: Sun, 08 Dec 2024 21:51:05 +0800
Message-ID: <dd50fea5fabdd1711fe14fc213543661@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.12.01 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cSNS2zLltYjb"
Content-Disposition: inline


--cSNS2zLltYjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.12.01 version.

Thanks,
Zorro

The new head of the master branch is commit:

8467552f09e1 btrfs/327: add a test case to verify inline extent data read

New commits:

Anand Jain (1):
      [4906a5ab94ee] fstests: fix blksize_t printf format warnings across architectures

Christoph Hellwig (1):
      [c8114d98186a] xfs/229: call on the test directory

Darrick J. Wong (15):
      [92aad87ec067] generic/757: fix various bugs in this test
      [e21e278065bf] generic/757: convert to thinp
      [fa95cde52dcd] xfs/113: fix failure to corrupt the entire directory
      [27ce2a47a773] xfs/508: fix test for 64k blocksize
      [67e01fc52bbc] common/rc: capture dmesg when oom kills happen
      [93a8e88d0f6e] generic/562: handle ENOSPC while cloning gracefully
      [38257f559615] xfs/163: skip test if we can't shrink due to enospc issues
      [d9352ed5e24a] xfs/009: allow logically contiguous preallocations
      [2d6e7681acff] generic/251: use sentinel files to kill the fstrim loop
      [dbdbe1ec8591] generic/251: constrain runtime via time/load/soak factors
      [f06e93a4b1af] generic/251: don't copy the fsstress source code
      [f4ac46a85121] generic/366: fix directio requirements checking
      [d78afe6b6f0c] generic/454: actually set attr value for llamapirate subtest
      [ab1ece9ee32d] xfs/122: add tests for commitrange structures
      [0c01033c834f] generic/459: prevent collisions between test VMs backed by a shared disk pool

Filipe Manana (1):
      [09d86a113f0a] btrfs/028: kill lingering processes when test is interrupted

Nirjhar Roy (3):
      [e715441790b8] common/rc,xfs/207: Add a common helper function to check xflag bits
      [5c42ec5b9fd3] common/rc: Add a new _require_scratch_extsize helper function
      [a9c233162ef3] generic: Addition of new tests for extsize hints

Qu Wenruo (1):
      [8467552f09e1] btrfs/327: add a test case to verify inline extent data read

Zorro Lang (2):
      [98a76c6c51da] common/rc: _scratch_mkfs_sized supports extra arguments
      [d6596effc4df] xfs/157: do not drop necessary mkfs options


Code Diffstat:

 common/rc               |  59 +++++++++++-----
 src/attr_replace_test.c |   2 +-
 src/seek_sanity_test.c  |   2 +-
 tests/btrfs/028         |  14 ++++
 tests/btrfs/327         |  56 ++++++++++++++++
 tests/btrfs/327.out     |   2 +
 tests/generic/251       |  42 ++++++------
 tests/generic/366       |   2 +-
 tests/generic/367       | 174 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/367.out   |  26 ++++++++
 tests/generic/454       |   8 +--
 tests/generic/459       |  15 +++--
 tests/generic/562       |  10 ++-
 tests/generic/757       |  26 ++++++--
 tests/xfs/009           |  29 +++++++-
 tests/xfs/113           |  33 +++++++--
 tests/xfs/122.out       |   1 +
 tests/xfs/157           |   3 +-
 tests/xfs/163           |   9 ++-
 tests/xfs/207           |  15 ++---
 tests/xfs/229           |   4 +-
 tests/xfs/508           |   4 +-
 22 files changed, 456 insertions(+), 80 deletions(-)
--
Zorro Lang
zlang@kernel.org

--cSNS2zLltYjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmdVpAQACgkQlNbPkfr2
tMxa6A//b92+X9xp6fyPHxPBBMnxJt8S3B7UQDX3xMTm/jjlMex+2xiX0qJ0C2Yi
YOK3Ibzet0DpMqJ2f4u0e2tF+aR9kA5iyYFYwuS7r44Y8r1akSat6Uf3HKK1WQK0
ivALaL7S1p/Kkq/lzFCDBcm0cvIWJgCmEa4iBF9xDhtMp1xlcDE7cLjzG3QoNERr
FcYJSpKVUn1Gd9ww21wolUd7TmVVUqKFetmCtUy2+5i6ZwSP3OD12mQlv26fwwkw
TKhufDScQvfV7CKeC5ax1C07A6baTxeMkGHFiCYpGsMe5WDC9aUnCh3MFac4vF4F
jo2MLALKluxsjXjLFsrPeJTjNUt6ue6Etj7ugnUXzwnVAGNkIS9kN8UIph/64Q0m
HrZa0Cex50jlGVGUc8MvaLdk6fN2EupJCcxCHvnu7oRuwJe7C1GZ9YJy0C6CNym+
xizjb+Or3ufOuFx89ZMNtgu8l4i5bGEbWk+uKi6uk7y17bjn9/4j2mkt64B2NCj7
dYf3pXmfSpY6S02sdvq7JRhYXrJtQugyGXCxEAqgJSqv5iTtHkZqzoSPnzqOsGRN
mPMNTOc+FiG/ZQLIkHTSr87iOPJPEMzNivfA7PtW5SaAAfnw0udXK5WsnhYlnIBs
9m7afwenh1eZNijb8Az/pOlI+erJrSrThmDMp8T0sLAhCmdUZeo=
=M1Rs
-----END PGP SIGNATURE-----

--cSNS2zLltYjb--
