Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C913A41D
	for <fstests@vger.kernel.org>; Thu, 27 Jun 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481198; cv=none; b=qSKD+w9HI5RTjYrb8sLsdzczdnuHWT2LbtkF/4dgK2WaHbK9x/VQMdPSNNqA7caCeAGqEZcM+giKwuFBFe2wOnvxqtpatELrMEryIKkXm9gHvnzVdRHkN4O9vS4ijcmatLKcSmAPR1rxruNjI+efJAWSjlnyiZPvd54lSMOOYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481198; c=relaxed/simple;
	bh=5DRYUNm3lYSE3qrhzqwABQZy7b8XhxasHrWHlSAta0I=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=YtYVFv2j9LPVS39nrV792W/pRlKqB7X7FPGlfUo9701BtnBp+U8uLHNNZEf6O1S2Vwv9stTxXnq3tBRjYN9xCJmn0zbWy/HC00qjX216HADfyYdhdAA0MOcSmNvhPuME48X7Y+DCaS3UEkzqlbNXso9MAxt2KQHLZ3hF0TSkEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+wJvNfL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+wJvNfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B37C2BBFC;
	Thu, 27 Jun 2024 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719481198;
	bh=5DRYUNm3lYSE3qrhzqwABQZy7b8XhxasHrWHlSAta0I=;
	h=Date:From:To:Subject:From;
	b=i+wJvNfLga6kznKdREPwJLslgJpy/9XNcyuT3NN3j60slhYv1KiS1iPV3/GwOLk6I
	 nbhEtPp3S27G8LjAKDsSLpMfzxwF9l0luuvBwntQpdfI54+x4IEmsx0lRt9puYK7r7
	 SQuuAiHOd53yQP/juhG2LP2E784CuYMRogiwTKHUpoiYNrGuXG4QHfFQ4dPiUzVlKU
	 3mPC9CwlaMY7xLVMnEFBef0AHulQSgk7X9Vmt6K5YCx+OT6JZs+i8e0I57sdUhdkQr
	 9DfdATbqzjUjyUAg0ErKxivscIje5jK2xIrtp/FlwZu5yAxtAJI0JYrVm0cAQ5dEao
	 +IGwTUrttrrQQ==
Date: Thu, 27 Jun 2024 17:39:54 +0800
Message-ID: <143933ca68516410729c2a00ae524ee5@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.06.09 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zgqy6yGCyPPd"
Content-Disposition: inline


--zgqy6yGCyPPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.06.09 version.

Thanks,
Zorro

The new head of the master branch is commit:

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

--zgqy6yGCyPPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmZ9Mz4ACgkQlNbPkfr2
tMz/AA//bl5nI+ORZD6RpSg3EhCOl+2qBQiM0czebzYhgnKnIE6DD/mzOM6J0e/I
r3f8vDISTV+QboLV+AEsoq+76kQ+iF8fupeSQYQHgwUrnGK7aSWCu3B6vOBn51aO
trVMYbZ3OI0xtv8FbQmeNHByg0pFP2LkKYAlo21Z/QHIrQYl6whvv3FjLhur3ELW
MZarmg57RJLRr+FgXgBXn/qTI2veVZeDGZnJb6qr3dXi7yOjfYKjRtxrJ260f4yq
uv2tNiwU73lQpdqfSHS1S88Ibv+nvKuBRuRjKsqM4mkxjJrRrGCu97Vs+YZgrVOt
ykNxNPZi6BJVogC+oelL80D8hB0i7pI9rmgQn5CfFL5VUA3wNWufferW/tIHaw4y
+K86+3k3lmiB/ZES15D2FmM+Q54sFxkV5TMi7M7+jlJ5YDw7CrQL/eUvExpTGdZp
HukhNhiNhfn6yEQ1I44zuDPJridRdk73vsCsFefTyhjAcYnA6rnpd1dWQeOZCaYY
qNpL6xTeGz1QmM0oqyclVIyenjijteFWypH3DieHnDCYQxDhC6Y/hG8nOEe+88YU
TbBOkv3+qcT9Z1cQYqq8a0k3XYsB37n5nMMLYj1n/DF527QIv1oBKWIfahPGd5VO
rbj979wMtVjERV/k8VJhQEOIxk5xl8kEYxN4TY7le2l4NyUkdtM=
=L7Hz
-----END PGP SIGNATURE-----

--zgqy6yGCyPPd--
