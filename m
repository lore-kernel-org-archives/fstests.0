Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89109CA62
	for <fstests@vger.kernel.org>; Sun, 29 Oct 2023 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCz8YLc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F8CC433C8;
	Sun, 29 Oct 2023 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698588117;
	bh=q8ArvLAAcR+4IiQxv8zRQjsjKwGCPsBALX25U5jGgG0=;
	h=Date:From:To:Subject:From;
	b=CCz8YLc1BpPqdb+V9kZrjzKH7NN8PvHHHyv3j0i9V1LS/LeVTYJ/RKwExuC0FG8YH
	 XllbVmMYeBiFMoR4dEjB9AI14ZB1vd75WkJjV1JWIlHBQxQ3jGrWHNnzMQq8PcTEPx
	 GZFOzyo5u7h08GAakCbKUBlPYe6NYJVe93fWs1SLUT4/V+LZhaV+vvaMMmN90BXoj+
	 bFLk3HexpxIvImk9slhe7SdsiD+kcw0J8T32wRwv42FN/GcA58B/7wB2Q4k5GHnNJS
	 uQeKXPBtKmDE1LGPLV2Xk3Ysvgf+xSMEyVIIHfLaDzYgKCJO1ES1YKdkcg3u8M62WL
	 KKFvKQh1AwaRA==
Date: Sun, 29 Oct 2023 22:01:54 +0800
Message-ID: <8727f4170ffd5086605b5cbe6a9bfa45.Zorro Lang <zlang@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.10.29
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGSFubUe7Ms5"
Content-Disposition: inline


--vGSFubUe7Ms5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.10.29 release.

Release Notes:
1) There're 3 new test cases -- generic/601, overlay/083 and btrfs/302. They're
   all regression test cases for known fixes.
2) Fix some "unexpected failures" on g/269 and x/051, due to last fstests
   release remove lots of "2>/dev/null" from fstress running line. So if
   anyone hit more failures caused by fsstress stderr output, please check
   if it's bug or need to filter out to .full file.
3) Upstream libmount is updated to use new mount APIs, if you suddently hit some
   unexpected failures by running fstests, try the new LIBMOUNT_FORCE_MOUNT2 global
   parameter of mount command, to check if it's about new mount APIs of not.

More fixes and updates refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

119146147847 fstests: generic/353 should accomodate other pwrite behaviors

New commits ([N]ew, [U]pdate):

Amir Goldstein (1):
[N]      [30fc8ed13aa2] overlay: add test for lowerdir mount option parsing

Bill O'Donnell (1):
[U]      [119146147847] fstests: generic/353 should accomodate other pwrite behaviors

Christoph Hellwig (2):
[U]      [78469c97a208] xfs/556: call _require_dm_target later
[U]      [053719c18877] xfs: add missing _require_scratch calls

Darrick J. Wong (6):
[U]      [cdd662862926] xfs/178: don't fail when SCRATCH_DEV contains random xfs superblocks
[U]      [ba2905da44e7] generic/465: only complain about stale disk contents when racing directio
[U]      [bbeaf7d1cbf2] generic/269,xfs/051: don't drop fsstress failures to stdout
[N]      [39f88c553cb6] generic: test FALLOC_FL_UNSHARE when pagecache is not loaded
[U]      [949b7ac96e56] generic/251: don't snapshot $here during a test
[U]      [95b0db739400] generic/251: check min and max length and minlen for FSTRIM

Filipe Manana (2):
[U]      [6409d61958c5] btrfs/298: fix failure when added device supports trim
[N]      [6b4920afad0f] btrfs: test snapshotting a subvolume that was just created

Su Yue (1):
[U]      [d9323ad7a05e] generic/245: Filter mv error message


Code Diffstat:

 .../aio-dio-append-write-read-race.c               |  2 +-
 tests/btrfs/298                                    |  2 +-
 tests/btrfs/302                                    | 61 +++++++++++++++
 tests/btrfs/302.out                                |  4 +
 tests/generic/245                                  |  5 +-
 tests/generic/245.out                              |  2 +-
 tests/generic/251                                  | 67 ++++++++++++++---
 tests/generic/269                                  |  2 +-
 tests/generic/353                                  | 29 ++++----
 tests/generic/353.out                              | 15 +---
 tests/overlay/083                                  | 76 +++++++++++++++++++
 tests/overlay/083.out                              |  2 +
 tests/xfs/051                                      |  2 +-
 tests/xfs/178                                      |  9 ++-
 tests/xfs/178.out                                  |  2 -
 tests/xfs/184                                      |  1 +
 tests/xfs/192                                      |  1 +
 tests/xfs/200                                      |  1 +
 tests/xfs/204                                      |  1 +
 tests/xfs/232                                      |  1 +
 tests/xfs/556                                      |  2 +-
 tests/xfs/601                                      | 87 ++++++++++++++++++++++
 tests/xfs/601.out                                  |  4 +
 23 files changed, 332 insertions(+), 46 deletions(-)
--
Zorro Lang
zlang@kernel.org

--vGSFubUe7Ms5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmU+ZZwACgkQlNbPkfr2
tMyk1w//SV0+h0X47J5fBvHeck4a/Amf9LmXQfH8el7ZBQIFvN8ELFl4JaRub69C
TiO9YsoaDnZg+fOqDxO4JqTBduiPrhrSed+HPxx1+hGrbUIvQsG1y3p6TcDG8Eda
PJUPIj1STvqDcFZOizlfMy5PHCQkkrh51iMNw+2RM/grc+8Pe+5T7uLirMIxJX+r
QYwmxcMzZMSmEy65HvdXR+Ulj1juPHvGN0c19LaNfXNlcZMO1yyCGwvJ0VRVXVYi
NM0yZw188wZOfgZiyno3mMfpiQxTH30KNBLV2vn13fNK8hXg4nU4+lyHMJlRPil5
KPdRPJR945SDdLITgnN1QVUYoJNDUYbB0o9rZAutkDhuIRbTXzYFuLt026/0Wuej
UiW8rdEfCx1uzaqDBTeoBFnL1GI4eN13Z8a9iDhX0nSBL91VLy3P8doGI0WK2jV7
Pr5ZEJjyHIEUKvreoZyIaNjfGpQAG4A498APjPqrkN/jAsI0UDkUNIfthci1w4AG
2ynz4VkN4N9O+weGufHrNwVhyJHetCMIasR1XXar15bQVRgbbUrCZtQq6lPlGDu9
3H4z6dSb8/0AiebB7GgMimJ2zftPMQTnmUOwJT2maVsZEhSRvogr/C/PvverrbCT
hSLKnZXiQtCa8dMvEQUtGk+PKHgGmuGKkp/1zHv7JbWBvUQOv4g=
=CF66
-----END PGP SIGNATURE-----

--vGSFubUe7Ms5--
