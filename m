Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A57C12A
	for <fstests@vger.kernel.org>; Sun, 10 Dec 2023 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjxdT8V+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B8C433C7;
	Sun, 10 Dec 2023 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702215842;
	bh=PGDXSubDiOMbZleaRuX4wmFZBlVJ3sCYQIve4/H59PI=;
	h=Date:From:To:Subject:From;
	b=tjxdT8V+cUxWcwLy0NsrWaSc+l/CRUBrHH6MjOoL9zHdoILGkusdRSVm5gYsKbg6q
	 qhUrTJD4+LYwX7wN8vc+107lIw/eSShtcITyPpYLuo+Qo01fAigvNdpSl+lgxSHPhb
	 mqqbhg/0HzOTGnaGrotj8Zf/H3i/oBUQabPJQLi8FETQwSkhCknciHj9gL1DJkfaDA
	 csqx1GvJ+ONBvgwK8bC+45N0rYSRgpgI2KUrZwgQ7jZomEiGyqftmwtuCDq/TVNsom
	 CeKNjlLaVqrce82coBct4JB8GizzM29MfwHRfjzPVw6pCEQL9HqCNMYiCxvSC6baVg
	 Wv1uB6WYv7EvQ==
Date: Sun, 10 Dec 2023 21:43:59 +0800
Message-ID: <199dfd8440b7e7a447bd7e74af25bebf.Zorro Lang <zlang@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.11.19 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTXCWCDgFMBs"
Content-Disposition: inline


--QTXCWCDgFMBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.11.19 version

Thanks,
Zorro

The new head of the master branch is commit:

b9e1a88f8198 xfs: test refilling AGFL after lots of btree splits

New commits:

Anand Jain (6):
      [22bca8d9a6d9] common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
      [24c58f2d973c] common/btrfs: add helper _has_btrfs_sysfs_feature_attr
      [7139a0600084] btrfs/219: fix _cleanup() to successful release the loop-device
      [6a466743cd17] btrfs/219: cloned-device mount capability update
      [47737bd3decf] btrfs/219: add to the auto group
      [59372e8d3f96] common/btrfs: add _btrfs_get_fsid() helper

Christoph Hellwig (1):
      [88334112f9cb] xfs/146: require fallocate support

Darrick J. Wong (5):
      [848c6a882a6f] generic: test reads racing with slow reflink operations
      [59bf56a1a56e] common: make helpers for ttyprintk usage
      [b5ba77147bf6] xfs: test unlinked inode list repair on demand
      [3098851702d1] misc: privatize the FIEXCHANGE ioctl for now
      [29c3cc742717] misc: update xfs_io swapext usage

Omar Sandoval (1):
      [b9e1a88f8198] xfs: test refilling AGFL after lots of btree splits

Qu Wenruo (1):
      [483b1f90c8aa] fstests: btrfs: test snapshot creation with existing qgroup

Yang Xu (1):
      [5fdd34e76182] xfs/263: Remove mkfs.xfs data section argument


Code Diffstat:

 common/btrfs              |  26 +++-
 common/fuzzy              |   4 +-
 common/rc                 |  38 +++++-
 common/xfs                |   2 +-
 configure.ac              |   3 +-
 doc/group-names.txt       |   2 +-
 include/builddefs.in      |   3 +-
 ltp/Makefile              |   4 +-
 ltp/fsstress.c            |  10 +-
 ltp/fsx.c                 |  20 +--
 m4/package_libcdev.m4     |  19 +--
 m4/package_xfslibs.m4     |  14 ++
 src/Makefile              |   8 ++
 src/fiexchange.h          |  48 +++----
 src/global.h              |   4 +-
 src/t_reflink_read_race.c | 339 ++++++++++++++++++++++++++++++++++++++++++++++
 src/vfs/Makefile          |   4 +
 tests/btrfs/219           |  74 +++++-----
 tests/btrfs/303           |  77 +++++++++++
 tests/btrfs/303.out       |   2 +
 tests/generic/709         |   2 +-
 tests/generic/710         |   2 +-
 tests/generic/711         |   2 +-
 tests/generic/712         |   2 +-
 tests/generic/713         |   4 +-
 tests/generic/714         |   4 +-
 tests/generic/715         |   4 +-
 tests/generic/716         |   2 +-
 tests/generic/717         |   2 +-
 tests/generic/718         |   2 +-
 tests/generic/719         |   2 +-
 tests/generic/720         |   2 +-
 tests/generic/722         |   4 +-
 tests/generic/723         |   6 +-
 tests/generic/724         |   6 +-
 tests/generic/725         |   2 +-
 tests/generic/726         |   2 +-
 tests/generic/727         |   2 +-
 tests/generic/733         |  76 +++++++++++
 tests/generic/733.out     |   6 +
 tests/xfs/122.out         |   1 +
 tests/xfs/146             |   3 +-
 tests/xfs/263             |   5 +-
 tests/xfs/329             |   4 +-
 tests/xfs/434             |   2 +-
 tests/xfs/435             |   2 +-
 tests/xfs/436             |   2 +-
 tests/xfs/444             |   2 +-
 tests/xfs/516             |   2 +-
 tests/xfs/602             | 111 +++++++++++++++
 tests/xfs/602.out         |   5 +
 tests/xfs/603             | 215 +++++++++++++++++++++++++++++
 tests/xfs/603.out         |   6 +
 tests/xfs/604             |  69 ++++++++++
 tests/xfs/604.out         |   2 +
 tests/xfs/789             |   2 +-
 tests/xfs/790             |   2 +-
 tests/xfs/791             |   6 +-
 tests/xfs/792             |   2 +-
 59 files changed, 1137 insertions(+), 141 deletions(-)
--
Zorro Lang
zlang@kernel.org

--QTXCWCDgFMBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmV1wHIACgkQlNbPkfr2
tMxGLg/6A2KSDeCgSA9/dfB2P2MjoQoAJJaPSJWEPtQRLeu6kytdpFXoM3iK1dA4
fVXBAI5buK8kJsPCEkmglTg3ZCKQXSDqp1u6HnyE2EE6AJFXFnaP3kO7xj6D6UWD
SUi56xQJE/nlyw1QO1AhwFaxZvgtMmzE3eJdQ9kFyXt07PEMc3B7wBAuIPyFVMdI
7HO+Ucqf48Es7BnLrGiL3cUfeS5g12upcOvtYsiBJRA/aqYVf7WMYObAueOO/kBN
w1ZJZKb9jEWvRtOA/1zd557F1xO4tr1kjajCohKwEiPZXI5HkJoW+Q0Rfz7yLKpw
V3U7qc3PeMERSOw/U/DAseSzGnK4yyNswEz422F2P5Yd7eo8cZ0Vl6sBw8KCLY3D
k8ozFuXoLYfmY5NhYJkyN98f25rC5tjuF+pf2fo68ECx5zwxKFKAswqNKORKxPlZ
NtyQK359pJa9Xmj73p5GEXVaZsLHHOtLwysgWNuddOqQipljCOLHZpS9B0zAAdta
0Ve0JUl9+Wq8YDxW1RZdFOXjhAqH/QZgq8LipSZwuC3g+qBebOvEXFgA/fTA9+Zi
W1zwfiIe2yNPLCSE9J+/qnNr8Q/ak/1jpK2rx++PP2BweQYwbNcOY17AL6fiaON7
s9AJypquyBuHzdkvb/Qjlwz5174wwvq4j4oqLj7BjbmbGKFnwJs=
=vmLd
-----END PGP SIGNATURE-----

--QTXCWCDgFMBs--
