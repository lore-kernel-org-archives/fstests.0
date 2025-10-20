Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8221DE4C2
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971955; cv=none; b=he1j0tY2sLi32sS7o7FjDtD1a46yLCERamSOBnVfDivbChvVDLQQZHT+g3gCHhAOC/Z64EcG+GnuWbyf3YVuyGgLlAuVGcfZPoFRxTcZ9/48KHfN6yK9NhSrrS/FYByGaxeQok/y/jqM/byujWz6yKjp6IXqCghGIuNpIzvdh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971955; c=relaxed/simple;
	bh=9/psNvqFJ5vfXXFOEWK11UFhYuSs3JVm5vKTt1BMkZ4=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=rDj8JkGM5EnmmlTnfrRLiv9sx+i1wm881LXUOOr4WZhjxOBkRiIswbxeH3mVAvVk6WNzSpRmDqSU7zBDAo/IEAG7AdCT6SOjklO7jbmJ8B5Bnt81cy916pcQMyOjXuqpxcvIKu2Zuypq8bx0GTsc0TiYolNLs18yDb5f2zrSWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+QJvETJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+QJvETJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A10BC4CEF9;
	Mon, 20 Oct 2025 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760971955;
	bh=9/psNvqFJ5vfXXFOEWK11UFhYuSs3JVm5vKTt1BMkZ4=;
	h=Date:From:To:Subject:From;
	b=T+QJvETJISy8RE/tMq8jjj95ciySyqeeXuAWc3U6FESxOXBpwd6afVL3M9gd+u+2M
	 y2+FyC3/5qgWwonS9BbjWQKb18idFgJpj1wZUt8XK6xHcYmmZQC3HZKmzkviorIZLc
	 VyX70HkLn90amtYJu8Tb6zL3gWWLtS1GWHoVDIk6FCwiKgtFjNssSHyjq9qTOGaXR2
	 KJPuTUXNfa9uHClWsIQwqUOq9t0DwFWnAg8qCka1+W2Ol4Yx7I+u68WZaxgdtjAr1A
	 htr0FF6csx53ZmWktZBZ9d5AZoUZd251R291YkDHt8ytgNenLYv76iQ5Rb8L0pgjAC
	 wP2xal8HCyAtg==
Date: Mon, 20 Oct 2025 22:52:31 +0800
Message-ID: <172d4caf92c0f0a015d83bfe47f9f2cb@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.10.20
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NxS5q044bsUc"
Content-Disposition: inline


--NxS5q044bsUc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.10.20 release.

Release Notes:
1) There're 8 new test cases in this release, includes generic/773~776,
   generic/778 and ext4/061~063. They're all atomic write related tests.
2) A big update for atomic write testing, besides above new test cases
   and new common helpers, the fsx.c is updated too. But please note that
   new fsx.c does atomic write test (if your system supports it) by default,
   currently there're some failures on xfs, e.g. g/091, g/263, g/760 and g/617
   all fail on xfs. XFS list thinks it's kernel bug for now.
3) f2fs related helpers are moved common/f2fs

More updates include btrfs and encrypt please refer to below, thanks for
all these contributions!


Thanks,
Zorro

The new head of the for-next branch is commit:

c4980080ba76 ext4: Atomic write test for extent split across leaf nodes

New commits:

Chao Yu (3):
      [2323b5895033] common/config: source common/f2fs in _source_specific_fs()
      [220641d07dfc] common/rc: move _check_f2fs_filesystem() to common/f2fs
      [f38becbd9056] common/f2fs: introduce _require_inject_f2fs_command()

Jan Prusakowski (2):
      [3636f4c34799] common/encrypt: Explicitly set the test file to uncompressed
      [cd0431fa4fc5] f2fs/009: Add delay after killing socket tool

Nirjhar Roy (IBM) (3):
      [6a81db9f1809] generic/562: Make test compatible with block sizes till 64k
      [b0e58387ca45] btrfs/200: Make the test compatible with all supported block sizes
      [b2e5d361b2e5] btrfs/290: Make the test compatible with all supported block sizes

Ojaswin Mujoo (11):
      [9d7e60fead50] ext4/060: Skip for dax devices on non-4k page sizes
      [c6cffd0ae6d4] common/rc: Add _min() and _max() helpers
      [a346de1bb28b] common/rc: Add fio atomic write helpers
      [1ba22a572c92] common/rc: Add a helper to run fsx on a given file
      [e2bc78e9d340] ltp/fsx.c: Add atomic writes support to fsx
      [1499d4ff2365] generic: Add atomic write test using fio crc check verifier
      [9117fb93b41c] generic: Add atomic write test using fio verify on file mixed mappings
      [d2d43c22229f] generic: Add atomic write multi-fsblock O_[D]SYNC tests
      [df9d27baa9e9] generic: Stress fsx with atomic writes enabled
      [ca954527ff9d] generic: Add sudden shutdown tests for multi block atomic writes
      [c4980080ba76] ext4: Atomic write test for extent split across leaf nodes

Ritesh Harjani (IBM) (2):
      [3a530a3f9e8b] ext4: Test atomic write and ioend codepaths with bigalloc
      [4bbc4694a052] ext4: Test atomic writes allocation and write codepaths with bigalloc


Code Diffstat:

 common/config         |   1 +
 common/encrypt        |   7 +
 common/f2fs           |  71 ++++++++++
 common/rc             | 132 +++++++++++-------
 ltp/fsx.c             | 117 +++++++++++++++-
 tests/btrfs/200       |   8 +-
 tests/btrfs/200.out   |   8 +-
 tests/btrfs/290       |  16 +--
 tests/ext4/060        |   4 +
 tests/ext4/061        | 155 +++++++++++++++++++++
 tests/ext4/061.out    |   2 +
 tests/ext4/062        | 203 ++++++++++++++++++++++++++++
 tests/ext4/062.out    |   2 +
 tests/ext4/063        | 129 ++++++++++++++++++
 tests/ext4/063.out    |   2 +
 tests/f2fs/002        |   1 -
 tests/f2fs/009        |   4 +-
 tests/f2fs/012        |   2 +-
 tests/f2fs/019        |   2 +-
 tests/f2fs/020        |   2 +-
 tests/f2fs/022        |   2 +-
 tests/generic/562     |   2 +-
 tests/generic/773     | 108 +++++++++++++++
 tests/generic/773.out |   2 +
 tests/generic/774     | 132 ++++++++++++++++++
 tests/generic/774.out |   2 +
 tests/generic/775     | 138 +++++++++++++++++++
 tests/generic/775.out |   2 +
 tests/generic/776     |  68 ++++++++++
 tests/generic/776.out |   2 +
 tests/generic/778     | 368 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/778.out |   2 +
 32 files changed, 1621 insertions(+), 75 deletions(-)
--
Zorro Lang
zlang@kernel.org

--NxS5q044bsUc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmj2TGcACgkQlNbPkfr2
tMwzmA//TFrV/YoPuHGdZxRVDbc37y+E3/u+SIo0kkd5Pj+kek4C4+OAHcHBKMTD
yneIdiyrV8iLYbLNmrzu0SqBivHaVJFdZ4wCW8NSe7o1PVEiMT+Gw9supFdYuuGF
3LAflFhvRVed0zOBOAFO6pvqhY7oFN7gRidw3cERdYbvLp48Gqp6xB/ZaqwcR7G0
aS1HAcRpT1fvMCH4pfbYtUpNKIjgzKzm79LaMvAX6Q0Vv0XOAzhlXgH4jWeiJt7e
SPt8OMZpqzoKmmTIVTkQBY3eaVD7BrkQPIZ0TmyDww17V6mDkr+Ib+dKizwEcjmK
/D70TOu26IQpOYtu5WpiSwM0z6P61vQgxSi08vPK1W6SUNfRzBv+QlbolrVWCyMf
1c9Wp8jsKWODaC8RdBDgwE4fjMCGU8k3GcEwFBhLMKTVbpKBnCngxSCDGgFkfJsl
JndvWyUIFvFphoyCggOZrinMxe6uKLGO5HVpefMs36JwLMAgIPAStMg1UDcYoyD4
dvJqxKDKgj+yUkp5oxngorHdmZEtjMduCNapw54tT8uy7X7kmbP113Vmn8PY8xhl
LkfVtOKVLztGeoBDKNK+10LPkHUHPCToNb/5PS8Fi5K6PmfARrp2izjEtTvdK8uB
YTS5VDTQa7B+8h+9Uzvi/ckWSkQHn+b17gd9XZXRXWWFCAXzzog=
=Z5Xo
-----END PGP SIGNATURE-----

--NxS5q044bsUc--
