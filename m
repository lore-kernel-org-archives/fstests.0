Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F742595
	for <fstests@vger.kernel.org>; Sun, 11 Aug 2024 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723380108; cv=none; b=PIqbW9VqckjT1dVGHlf5IgwI5zhHcv4Il5HoxX7t2ZVkTh9NEUGoqf0mIMBGqSfpLdi0KfhVoBSxqtCCTkQeaj/Xeh0xRJdyW633pIH/+PNBi/lukd0BW402W6vcszsBR0v7QLMRyNmxXLb4i+T7HS3OpLb/r4JKNFPYle1wEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723380108; c=relaxed/simple;
	bh=VgHw97n5b5hV3pvX9ka9k9GboG36xmgsIDJdsICXVVc=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=dUxyqDPQwFUflVQX4ptG5LgSQzIbfooUeqMqDQq/JWl6VvkDOEZOp0Xjm46HucAvhMQN6SQGIA220J1K/NClP5ks01WyqBauEEGVOvcX9/KCeqKnjRyGw0Z8RFYTS/bnqOd5fWW1QEozXZe+MWB9m4KuMYMIX37X1x6Hcf0rd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbLI0icR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbLI0icR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85502C32786;
	Sun, 11 Aug 2024 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723380108;
	bh=VgHw97n5b5hV3pvX9ka9k9GboG36xmgsIDJdsICXVVc=;
	h=Date:From:To:Subject:From;
	b=bbLI0icRrfJ0Y3/kRpd90XSE9+Qo+O8MO1/skzHshrjG1pimrYGRY16ksX3A3HGIz
	 z2D5Bi/MnCixOIMb0qHRAey+kwJ04rqE4RMI1SMG3egrpsu5k9J1TsPRLKzva1PqzN
	 my6PTje0HAOiIMzC9/6kQVXqFthHLb9n94klsTFhSaBQ9EM7DxsHR0eEVF+atpZehk
	 q0/79eYdvuAb/EAq0JC7GguG7nL81/FifUEUz/Yo+GvihJdbdMoP60P8C5+yQP89/t
	 qBmhieaGFd8Me+LiMV7rszWu7yh70uFO4GmGSrPt8ikqqgxqnI6BQdjMdF9aoCUcVs
	 nSKTnr6pU+FvQ==
Date: Sun, 11 Aug 2024 20:41:45 +0800
Message-ID: <a55134d4404bf64935411213d75e6d4c@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.07.28 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5EGqNs1Rgjz5"
Content-Disposition: inline


--5EGqNs1Rgjz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.07.28 version.

Thanks,
Zorro

The new head of the master branch is commit:

f5ada754d583 generic/754: fix _fixed_by tags

New commits:

Chao Yu (2):
      [c62c3d1cfbc7] f2fs: test for race condition in between atomic_write and gc
      [410ab2ebf3b8] f2fs: test for race condition in between atomic_write and dio

Christoph Hellwig (2):
      [7cb775459424] xfs/011: support byte-based grant heads are stored in bytes now
      [0bc89993579b] xfs: add a few more tests to the repair group

Darrick J. Wong (1):
      [f5ada754d583] generic/754: fix _fixed_by tags

David Sterba (1):
      [9b6922eb610c] btrfs/220: remove integrity checker bits

Filipe Manana (2):
      [592f6a79f56e] btrfs: test a compressed send stream scenario that triggered a read corruption
      [02a689b7aa07] btrfs: properly shutdown subvolume stress worker to avoid umount failures

Qu Wenruo (1):
      [b548b23fd4e9] fstests: btrfs/012: fix a false alert due to socket/pipe files


Code Diffstat:

 common/btrfs        |   2 +
 tests/btrfs/012     |  29 +++++++------
 tests/btrfs/012.out |   6 +++
 tests/btrfs/060     |   9 ++--
 tests/btrfs/065     |   9 ++--
 tests/btrfs/066     |   9 ++--
 tests/btrfs/067     |   9 ++--
 tests/btrfs/068     |   9 ++--
 tests/btrfs/220     |   5 ---
 tests/btrfs/312     | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out |   7 ++++
 tests/f2fs/003      |  65 +++++++++++++++++++++++++++++
 tests/f2fs/003.out  |  11 +++++
 tests/f2fs/004      |  48 ++++++++++++++++++++++
 tests/f2fs/004.out  |   3 ++
 tests/generic/754   |   7 +++-
 tests/xfs/011       |  77 ++++++++++++++++++++++++-----------
 tests/xfs/337       |   2 +-
 tests/xfs/338       |   2 +-
 tests/xfs/339       |   2 +-
 tests/xfs/340       |   2 +-
 tests/xfs/341       |   2 +-
 tests/xfs/342       |   2 +-
 23 files changed, 364 insertions(+), 68 deletions(-)
--
Zorro Lang
zlang@kernel.org

--5EGqNs1Rgjz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAma4sUsACgkQlNbPkfr2
tMzSYg//dWaJ8wsviBM4xRjxBTN8jaOLAJBULv4SMKEHXfaT+vf5vJEggKRKLAaG
DGQj/Ilz0YL30oxIeQm4ChKKGH3+izFDhh+xIFIJP1SJMDftLdsbugH4Y2mNJ965
XN6gtqHBDIjERzfounhamI2Uy/z2XLKPCUJBdJBpgKo+7cVj4WAYXf7OFO/oT/BW
n4HIrzMkIRAmv4paIkr4ETfWcotTOxIi7VN3v8ECABATPDGLhBaYkdWqy/5y1Hf9
BqdNcwDE1RDdQysJB1nH5skqHANT0SY/cCG+pdeUE5e8NpV4KuRAH5ROG7cd7ze1
F6gErUgJ4pP1N1Eu88pTcBzoKxMZLF3vxuCdphio77t8v/9zSU8dGIhF/jUYVOpy
TR/Omf/8h4hAPkxsQNDnyQdzavvz6slas0W0NKLjMqOOT0bJYJD4EVQbUO05rSrW
1k1oS2Tjdh2lT409WucPQPzqG6X9neCg1iCW8CaQON5pZrXe9au3HgWf+UYmlNuJ
zgwg5nH+wH3kwGzBVYp9wiZlqBe0fkx7d4ly0eIt6ezNNRpurHuAWVqvAjsknK0f
1oRoaCc14rSbHK0XD11UBoqEP7O/voOXkuF4DoXSCZRsnog+7xODObuBQFUMj95R
7+3oTgJ4N7B/fsxjo3YyVLsd830WVVBurTFXozrBd9Nt+sjOVh8=
=dpl0
-----END PGP SIGNATURE-----

--5EGqNs1Rgjz5--
