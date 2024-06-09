Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940D1CD39
	for <fstests@vger.kernel.org>; Sun,  9 Jun 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717945320; cv=none; b=VEin+ycPugmCY8j14Yhqkokm9Ft7U4c3oY2Z4oMSp1VBj5EIDV7e/63Fijqg6n+7uqt02DLoeSqHWcO9e5qMW7M+bLz4MBAEC+YbwLr2fwFVJD+D1Tcu5/mdZk9/GSlw5cxFOy1hgTuEk7IVTeqeVFLxzRkwvpYYNtP+bLBtcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717945320; c=relaxed/simple;
	bh=pWrfuxVTXTX8uV3x1WwcbtQM9IEumHy2fNViLiO7k40=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=mnCxpg1ojB2/KJ3K+fqSNGvnDYBO5+5BF30v9j0i4moz8+Sk0liKoWk8ckwAxA1rFlW7+pqV5L4QVGAWV36NhYXQSoWlyGJxNc50UhaM1g+0cjdqsee0WiACdE5WF7FBqKTYUso7//DHBASD8+XMjoWr7wHFsULzJ33hD3DZG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJiRhCMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJiRhCMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C324DC2BD10;
	Sun,  9 Jun 2024 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717945320;
	bh=pWrfuxVTXTX8uV3x1WwcbtQM9IEumHy2fNViLiO7k40=;
	h=Date:From:To:Subject:From;
	b=NJiRhCMFEOMw6gKC0VpA1vSUdFLVzqKYxq3NnrHnBQCX2JxVAgpNqNIOlEszsZtqW
	 Yn6+8s8/6C4ec7/a4GrbBNcYSB77u5fF3tnB3gcaQDNYf2z/lF0qTeadBp1Zc+Si6g
	 cXCMjsHthP0m8W1vXGTBrJwBASADSKAhj2Czjaj7ZKS/Hysqo733uRBvg9Be5NgEM7
	 +8EwshSVBxLpzwaRpvaVC7rb/S9qdQ7HKWdsRkoB2/ZBkcIsrr2F3cCJzU9+kwOY6d
	 dsUId5MThJwD1uFFGUfDE8kSfMhK3EhcA+EhYxmpE25KicQ5X54LM+i7NsHmglb0NA
	 +0Yz0wYHjt00Q==
Date: Sun, 09 Jun 2024 23:01:57 +0800
Message-ID: <96c1c387ae5f64a59f4205dd3999b407@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.06.09
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SWqpbZaeGgE"
Content-Disposition: inline


--1SWqpbZaeGgE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.06.09 release.

Release Notes:
1) There's 1 new test case -- generic/748. It covers a known btrfs bug.
2) More fixes for "large block size" testing, thanks Pankaj! Welcome to try
   fstests on 64k or other large block size.
3) More updates and fixes for btrfs and fuzzy testing.

More details refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

83598d2f839d generic: test Btrfs fsync vs. size-extending prealloc write crash

New commits:

Darrick J. Wong (4):
      [ab6a3b1a0283] generic/747: redirect mkfs stderr to seqres.full
      [1a9ca7d53339] fuzzy: mask off a few more inode fields from the fuzz tests
      [d67b0d11106d] fuzzy: allow FUZZ_REWRITE_DURATION to control fsstress runtime when fuzzing
      [2da0c88e3481] fuzzy: test other dquot ids

Filipe Manana (2):
      [f50e6a3a7138] btrfs: fix raid-stripe-tree tests with non-experimental btrfs-progs build
      [887f00615ac4] btrfs/280: run defrag after creating file to get expected extent layout

Luis Henriques (SUSE) (1):
      [84de2df901bb] generic/077: ignore errors occurred while accessing the filler files

Omar Sandoval (1):
      [83598d2f839d] generic: test Btrfs fsync vs. size-extending prealloc write crash

Pankaj Raghav (3):
      [4fee7f2934ff] xfs/161: adapt the test case for 64k FS blocksize
      [edbea26d4c96] generic/436: round up bufsz to nearest filesystem blksz
      [97989c9839dd] xfs/008: use block size instead of the pagesize


Code Diffstat:

 check                  | 12 ++++++++++++
 common/filter.btrfs    |  4 ++--
 common/fuzzy           | 27 ++++++++++++++++++++++++---
 common/populate        | 14 ++++++++++++++
 src/seek_sanity_test.c |  8 ++++----
 tests/btrfs/280        | 10 +++++++++-
 tests/btrfs/304.out    |  6 ------
 tests/btrfs/305.out    |  6 ------
 tests/btrfs/306.out    |  6 ------
 tests/btrfs/307.out    |  6 ------
 tests/btrfs/308.out    |  6 ------
 tests/generic/077      |  8 ++++----
 tests/generic/747      |  2 +-
 tests/generic/748      | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/748.out  |  2 ++
 tests/xfs/008          | 20 +++++++++-----------
 tests/xfs/008.out      |  8 ++++----
 tests/xfs/161          | 16 ++++++++++++----
 tests/xfs/425          | 10 +++++++---
 tests/xfs/426          | 10 +++++++---
 tests/xfs/427          | 10 +++++++---
 tests/xfs/428          | 10 +++++++---
 tests/xfs/429          | 10 +++++++---
 tests/xfs/430          | 10 +++++++---
 tests/xfs/487          | 10 +++++++---
 tests/xfs/488          | 10 +++++++---
 tests/xfs/489          | 10 +++++++---
 tests/xfs/779          | 10 +++++++---
 tests/xfs/780          | 10 +++++++---
 tests/xfs/781          | 10 +++++++---
 30 files changed, 226 insertions(+), 100 deletions(-)
--
Zorro Lang
zlang@kernel.org

--1SWqpbZaeGgE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmZlw8AACgkQlNbPkfr2
tMyA6RAAph6HIAs8Ug8PSUHZekLsejsARaQIvT1rxLbucwZjmivndz1eJ3wTqtBd
vK5wuC4D8nAzOuN3XICedse2IYIuJY99+4DClpMBRhb/O6uY7LgCPEZ921nBYarj
vewFvz/KEB9zGx5Y1gGRwCkNPSrBIOolQZZpwsXhEXXoji+SzUEr7fwdZv99y8lb
QnElYoJNN4yNxgPMyBVX1q3kYNU50IDSRd51FGW3VGyk2Yrj69wFJ9qNvxX3ew3b
q0vXpcKiwafa0c/EyGwmgDzktZO246meGy1jkiy5+sYVh1l4xCEOzNyNj79x7O4a
gIv2TdvLQGBcNviRuJHVnhFpjXj+t09zHdjQ+50Mt8QzbQAoy+DnmVMx4nuV3hn+
7bImO/CtHxS9caj4EH9lHOrt3eGK1EZaLakqPlyfVk46qILQsRE/YpGAhzEmVuho
0hDWZINzqB2tTmGP7NrZWtuVtORszN4L4mU3tRccObzKxEZ31wGn825Qw2amsHJw
cYUJN/ERaKCIGX2ycdCCWBLVnSV0jB0mwMCW9WTivFLKKje+rff7S+wZ+lDTIXnA
Yvun5UBQ90JrsS199kIDziuTJegSwMPVbPb0fW6aJww6+hDd9WYwgDFFnpQtXTts
GB+c3iqo0Aa5HoIOGfYXKbuPtOgzfQIt8ZF5pApcr0xvC5x7VIY=
=0KSM
-----END PGP SIGNATURE-----

--1SWqpbZaeGgE--
