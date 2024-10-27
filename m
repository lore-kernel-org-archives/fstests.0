Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF515885E
	for <fstests@vger.kernel.org>; Sun, 27 Oct 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049879; cv=none; b=G71yBj5GMDIRqvCdUU9U8//6DCYPFs7kjuQ7fOshdGLZ405iu9Sqf3pJGT9P7yFEvyhmhtZASiBKpGvtKdNR2b/p148BlRnGiklZupQj5KQiBFI2BwVWDtAJIMK0wMidtXheQ58cdIXCoswOiv8eWMpCcnk9QFMIdCZj5Q0TPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049879; c=relaxed/simple;
	bh=we89wVAXmGKQX4UYugU0S9FjzWQSy2aLWaZ6dC88zGY=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=Jsh0d980sxP4AUuiOFPH47gKDUiUTCwEXvM1yUmAujhYpb0aRwWRADR0Tfy0MopimzkqAZ0ns++Mj1t3RGvyRZlY0ZcPJxZJf6iajRr1wGMFN8/P+X4+A4YNRcNFskVjZKymxhCSrj4l5HxoTq5i9PLGSDYC+ehup4jmqxjpGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn6TEUun; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn6TEUun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6BDC4CEEA;
	Sun, 27 Oct 2024 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730049879;
	bh=we89wVAXmGKQX4UYugU0S9FjzWQSy2aLWaZ6dC88zGY=;
	h=Date:From:To:Subject:From;
	b=gn6TEUunquUVRNQEPCtFF+KFsOoIBXlWNG3PIVcaI7tKX1Ad8hfly80YShRXhhAKW
	 2hiAvYUj/GcLWvLBPih3Fxs1F0NVXRjxOowa5hHZTikRTH/mRaHfoO+QJJRf0RSSA4
	 MFyiaP0xpNwHQdNhQVXybgvSYDoEhvspDKk0X6bZ9nyQ0cLmY3nCiFS2PdhT10IomQ
	 cg9PcStGO5MOOEHDRItz0/pjzLm3garPATC1eL/SGBnBcwsc6mTAh3ZoUY8J5N0+vy
	 ac5fBHHQJfRWbdLDHJfFAmHoucztN4qwUQGadVXnuHKXkN0dJ6bJAHIvBmyl++RhSD
	 CLHPJY4m1Wy0A==
Date: Mon, 28 Oct 2024 01:24:35 +0800
Message-ID: <a358e7958c8cdc17c0dea13d169a2be3@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.10.28
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yD1YZPa9mOlI"
Content-Disposition: inline


--yD1YZPa9mOlI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.10.28 release.

Release Notes:
1) There're 3 new test cases in this release, include btrfs/323, btrfs/324,
   and generic/757. All of them cover known btrfs regression issues.
2) More cases are fixed for Large Block Size testing. Welcome more testing
   and fixing for that :)

More updates and fixes on xfs and btrfs, thanks for all of these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

f056971a4d2f btrfs: test remount with "compress" clears "compress-force"

New commits ([N]ew, [U]pdate):

Boris Burkov (1):
[N]      [9eda73ff4695] btrfs: add test for cleaner thread under seed-sprout

Chao Yu (1):
[U]      [18795160b0f3] f2fs/004: add missing _fixed_by_kernel_commit line

Darrick J. Wong (2):
[U]      [1f8fedd08f06] common/xfs: _notrun tests that fail due to block size < sector size
[U]      [9c3762ceafd4] misc: amend unicode confusing name tests to check for hidden tag characters

Filipe Manana (1):
[N]      [f056971a4d2f] btrfs: test remount with "compress" clears "compress-force"

Mark Harmstone (1):
[N]      [cf97fa373d61] generic: add test for missing btrfs csums in log when doing async on subpage vol

Pankaj Raghav (3):
[U]      [bd0d0179baf1] xfs/161: adapt the test case for LBS filesystem
[U]      [b71de9073a65] generic/219: use filesystem blocksize while calculating the file size
[U]      [6d97ae8ddebf] generic: increase file size to match CoW delayed allocation for XFS 64k bs

Qu Wenruo (3):
[U]      [0d203737049d] btrfs/012: fix false alerts when SELinux is enabled
[U]      [0ee667ece05c] fstests: btrfs/330: enable the test case for both new and old APIs
[U]      [6f4a6b5789d7] fstests: btrfs/002: fix the OOM caused by too large block size


Code Diffstat:

 common/xfs            |  5 ++++
 tests/btrfs/002       | 14 ++++-----
 tests/btrfs/012       |  5 ++++
 tests/btrfs/323       | 47 ++++++++++++++++++++++++++++++
 tests/btrfs/323.out   |  4 +++
 tests/btrfs/324       | 39 +++++++++++++++++++++++++
 tests/btrfs/324.out   |  2 ++
 tests/btrfs/330       |  9 ++++--
 tests/f2fs/004        |  3 ++
 tests/generic/219     | 18 ++++++++++--
 tests/generic/305     |  2 +-
 tests/generic/305.out | 12 ++++----
 tests/generic/326     |  2 +-
 tests/generic/326.out | 12 ++++----
 tests/generic/328     |  2 +-
 tests/generic/328.out | 16 ++++++-----
 tests/generic/453     |  8 ++++++
 tests/generic/454     | 29 ++++++++++++-------
 tests/generic/757     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/757.out |  2 ++
 tests/xfs/161         |  6 +++-
 tests/xfs/504         |  3 ++
 22 files changed, 272 insertions(+), 48 deletions(-)
--
Zorro Lang
zlang@kernel.org

--yD1YZPa9mOlI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmcedzEACgkQlNbPkfr2
tMxnYw/8DXE1PAg1UeUlwwezysut3SUE165jKSPIVzYnRt+Bx+hl/spfT2jTVFh7
7LfQfksCJ5YAuFVTIUDuOeC8r+9uFbzx0DYfBOzeXKVrKhihIBLGjM0OAOHDiwpl
AUkZUYO9poGZLj06fDIGyMYJObqfRd64EKHmQuL4myK8CcathImPy8+w1u5/0Xry
ToNdg5u2pb2zqTfeyzLrHg04UsbnuEohMlDtUxZgaG+hE/rFz5rtsjMUMAmspupZ
A+0jTlyg6lc/c3DwRMibG1wieRFtvgKQN0m0lt5UwOJHZ980H3yVWmNdSq1nz5ei
ZGX/sCD1NKWvMRAhSiUH2CeAWbwvHLK1igj/KWh3ZuE67Sv1EE0PC4igIv8zZUO1
LJmCMYUH8vRFhGFPsysChp4Zfhf23/bzsWIi5BI3NrV8pESR05AVSGDH2hKJV9mx
4pz/BIjjm+6sDfUy+FdU2hHLBTehnFijoe2soGBYAtDVG6yxMnET9aqBl5gE1HjC
WHxrFpTE1wt7OEho5pKUfwDou03JH4S2WbuxTAP9El3+DIk60so/yfzInEN+omsf
GiqLIi8+belAwdzth0f1u0OQmZtkIOqPefYLIi+Vg2ojk5T6I4SOPSI6fK0JsGks
7L0O85s5R9kMa4w5kURIM76WgKtW3LEX7VxjjFpKTL20daeuSms=
=FR5x
-----END PGP SIGNATURE-----

--yD1YZPa9mOlI--
