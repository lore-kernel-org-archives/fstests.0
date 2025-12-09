Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058D2EB868
	for <fstests@vger.kernel.org>; Tue,  9 Dec 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765290680; cv=none; b=Fos9eJtufk8iyPLAIice1a+nV9qveXq5n0UNrTRM5XuMsiGMx61YLU22nxNDyMPXFbHbvneQVuwmyKux/9IwiDrS2xEVYnBydW/ulveHtvpqshIXezrwL9tOD8YZT+J2BuiKKC7teoPpmItEKDvZIczWGQ31ob9r/YbT+/dgLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765290680; c=relaxed/simple;
	bh=exjVE+sHo+W6H2JbMdzVNKsuJT0/TjPr9SK+tWCGYkE=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=XUoroKQ+0N3qRksj6XW/7TGtwg7RfFvDaYayTMnwPrHf024l3kMILu10zGeausdnneg4fEnHGcbiXW/26L/ECjqHkbFZXKyjDwRp8v7g4SwRAjdTEklUFLtbCQuAvQqC5r8n0RVew3ZzC6dIfeIdiV5PNCtAvB0Hv2F1P9pfkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsNyY6Sm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsNyY6Sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B3C4CEF5;
	Tue,  9 Dec 2025 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765290679;
	bh=exjVE+sHo+W6H2JbMdzVNKsuJT0/TjPr9SK+tWCGYkE=;
	h=Date:From:To:Subject:From;
	b=ZsNyY6SmUBRGPJAtSmo1d4PIDSq6RfC7eF/exQfIa3clSQOdq/zw3kaTqRXEtRCav
	 ermBK3kNnL8b70FStiqZ0llMiUOT03ZR9c005PcixAwosb8FizjINKoRubtbLHklj4
	 QoMWqhNsrFlNLa0vrS5tEoM/PpkUkLdMLTlxrzyPwnsYMAw/ToAX7Xlfk/IB7DotEQ
	 PqjqBak4oKY3Fly6S8mCz2UGOSKzfbbukkMMYt1+mQu0rzZ3V0spFKXL7SShdwuy5/
	 wQiBJKtQ+qi650ZTHnrfjs4rdM9XvrjbJC98MUvlVvFv2yujIZe6JhlHohtbb3ncoG
	 sXx2cp9trlOHQ==
Date: Tue, 09 Dec 2025 22:31:16 +0800
Message-ID: <c0629a4e66a1d5d80de5ff7c4739cec9@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.12.09
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a69pAnKkNx2b"
Content-Disposition: inline


--a69pAnKkNx2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.12.09 release.

Release Notes:
1) There're 5 new test cases in this release, include generic/784, generic/785,
   generic/786, generic/787 and xfs/649.
2) The g/784, g/785 and x/649 are regression test cases to uncover known btrfs
   or xfs bugs.
3) New "delegation" feature test coverage -- generic/786, generic/787.
4) New fsstress.c usage about option -f.

More updates and details refer to below, thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

df16c93a89d3 generic: add tests for file delegations

New commits:

Christoph Hellwig (2):
      [37a5ef84413e] generic/484: force I/O to the data device for XFS
      [74c8afa4f132] xfs/049: create the nested XFS file systems on the loop device

Darrick J. Wong (1):
      [1b37d45c4373] fsstress: allow multiple suboptions to -f

Donald Douwsma (1):
      [5760b2105985] xfs: test case for handling io errors when reading extended attributes

Filipe Manana (2):
      [7e5537c5ec3f] generic: test a scenario of power failure after renames and fsyncs
      [3970e305333e] generic: test journaling after renaming fsynced file and fsync parent dir

Jeff Layton (3):
      [bf6ed3418e0f] common/rc: clean up after the _require_test_fcntl_setlease() test
      [4e77fcc28c03] generic: add tests for directory delegations
      [df16c93a89d3] generic: add tests for file delegations

Sidong Yang (1):
      [d569940311fd] btrfs/339: test receive dump stream for different user


Code Diffstat:

 common/locktest       |  19 +-
 common/rc             |  11 +
 common/scsi_debug     |   8 +-
 ltp/fsstress.c        |  43 ++--
 src/locktest.c        | 621 +++++++++++++++++++++++++++++++++++++++++++++++++-
 tests/btrfs/339       |  32 +++
 tests/btrfs/339.out   |   2 +
 tests/generic/484     |   3 +
 tests/generic/784     |  76 ++++++
 tests/generic/784.out |  19 ++
 tests/generic/785     |  73 ++++++
 tests/generic/785.out |   4 +
 tests/generic/786     |  19 ++
 tests/generic/786.out |   2 +
 tests/generic/787     |  20 ++
 tests/generic/787.out |   2 +
 tests/xfs/049         |   5 +-
 tests/xfs/649         | 139 +++++++++++
 tests/xfs/649.out     |   2 +
 19 files changed, 1068 insertions(+), 32 deletions(-)
--
Zorro Lang
zlang@kernel.org

--a69pAnKkNx2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmk4Mo4ACgkQlNbPkfr2
tMy1xg//YAMOGLBbJ28bOHjIAErs4HL3UThoK9rUvVY4sT+L2adaFFMdWASsNc1P
hrC5SRi+TWTAtNPb/3uLt68E6Bnt1B8PN8odf22lc6KoZuygKfCZXX/vb7/vPUA2
TQsW6mKQS7eqb5HSkqMxzczNb70totnU6fOB/zXwXK1XDYQpV0E8sS1xEasUzKXo
SjAhj5anyx0TEwSj0+m5HVGdrYQwQVMsPiGmzxMsQnSlk7DNJihDq3cOximtODQj
DE3c2401apQfs3Gtyc23cglldcRFO8lH6/1sqSiQjyqEEcLeGttEJ3R7+pj/v4U5
9v6SWejSf07Rx8vaAaTykt2ejMj306unnp7DudVKRwZICmrbwHXtoYHaKOxk3cy3
0PYUtSQx8pCr964hoSU5rsso9JxQnAnrGjzHtv3Ocl/D1fZIDGmHtLluJwlF49lu
4wGouN7xI+ZuVC8ueU65j2JRYr3qw6N4+GwBs7NgBxBm0zMIdkD521Y7jZXRhBLR
Ko9kY0ApOFrfvFP4uBEPFAA9OugLdy7aTg76rBrz/DwgsuOt6riP9GsS++b9UWdM
FnBNlGAzXFfyLmQ49Mow03BSf6l0EpYL3ArOiQ3oaV5rqWKirkS4TnglRUERFSYs
mYdRP6K3BQkC5/ULJQE/5BCzL7osMuAV6xXjdRz0EzpN78gnQWY=
=7Dar
-----END PGP SIGNATURE-----

--a69pAnKkNx2b--
