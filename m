Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8C18EB0
	for <fstests@vger.kernel.org>; Sun, 12 May 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715519566; cv=none; b=m1MeBwCLt8utFw/+s4tOn2pvEoXUCx5vvn5uXMmyYDmWYCDpju5jVOpdoIcRprH2DIM5KDtY0q1rbu9eOEw6EZ7dIf/qwNd90P3oIIplZ9OteDHR1GBbOmA7eZWBVX8PTeOGb56eikonTpusmltsKA4fllOALE/LF6g/1+RinLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715519566; c=relaxed/simple;
	bh=LzABtApEk2d1Es/WdrIppwxvL/4gVMQITOUPF+rPq+k=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=bK70Ig/t0Zc5sSJxpISzMME7xV8ucFxifXausm36DRZcSbk5BgiLoUg+qrrnpJgkn9m3EX6RPdKH3qTFU6qc9WvkgzaiElhSTZo5wA2VHZQiQ5W6bAkHyXqtXaZEJ7w8NqGb1dzc3ptZx+gzWpxlroPCdGmJQetS7liScAoCiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT4ZCjVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT4ZCjVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838F0C116B1;
	Sun, 12 May 2024 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715519565;
	bh=LzABtApEk2d1Es/WdrIppwxvL/4gVMQITOUPF+rPq+k=;
	h=Date:From:To:Subject:From;
	b=dT4ZCjVz3J2gLGNRmVtEXVNn2Cv21/ihia8O4a1Mu+j1WVqn6Y9q8cuiJwYv9socu
	 4Mqm1KBEYsdLAUbz2p6iOZ7BFRArOu6PopkpjUQu5xEMvRrpo2vUwivk81u16uOWiL
	 X+AtgGhU+QU8M/of0aPh7j+WF/BcwWa47ZVxHhetGAIjMXj+KPUHfrzrgp/qcfKqxV
	 TegeJ+4CD/VqLAw17DxrbDxgNSLuxtMFs7eD0J9IR/cF0LS/bFavnkFSZ6cz6Mntkf
	 /kGljckXsk6UX2sZ6sgX3sVulerNrQrH+WESAKwmOmgryuBoVut+SR4uWqZQBm2oxQ
	 8bsj7cWNuNRTA==
Date: Sun, 12 May 2024 21:12:42 +0800
Message-ID: <dc0c9d4409f3abcfee92cba22aa77a59@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2024.04.28 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6xiIY8abvVvU"
Content-Disposition: inline


--6xiIY8abvVvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2024.04.28 version.

Thanks,
Zorro

The new head of the master branch is commit:

b26d68da08e4 common/config: export TEST_DEV for mkfs.xfs

New commits:

Amir Goldstein (1):
      [3e453f6fa96c] generic/732: don't run it on overlayfs

Anand Jain (5):
      [faa4f3c67d98] btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
      [e6ab6f9c046e] common/btrfs: refactor _require_btrfs_corrupt_block to check option
      [e7439c8517d7] btrfs/290: fix btrfs_corrupt_block options
      [a96621b15308] common/verity: fix btrfs-corrupt-block -v option
      [10e0b5ddebd1] generic: move btrfs clone device testcase to the generic group

Boris Burkov (1):
      [bc9debb83c98] btrfs: new test for devt change between mounts

Chao Yu (1):
      [cba631840ac9] common/quota: update keywords of quota feature in _require_prjquota() for f2fs

Christoph Hellwig (5):
      [71e748f834f3] xfs/045: don't force v4 file systems
      [a190f243a09d] xfs/263: split out the v4 test
      [45bfee3c2f6d] xfs/512: split out v4 specific tests
      [de346dc82313] xfs/{158,160}: split out v4 tests
      [b9785de77fcb] xfs: don't run tests that require v4 file systems when not supported

David Disseldorp (1):
      [b26d68da08e4] common/config: export TEST_DEV for mkfs.xfs

David Sterba (1):
      [75d51c44fd66] btrfs: remove useless comments

Josef Bacik (3):
      [465775bac1c1] fstests: change btrfs/197 and btrfs/198 golden output
      [fc408e773e1d] fstests: change how we test for supported raid configs
      [0160ffd76693] fstests: update tests to skip unsupported raid profile types

Qu Wenruo (2):
      [64e7009c2c68] fstests: btrfs: rename _run_btrfs_util_prog to _btrfs
      [888b166484de] fstests: btrfs: use _btrfs for 'subvolume snapshot' command

Taylor Jackson (1):
      [6455e684efd1] generic/645: Add hint for expected failure with old kernel

Yong Sun (1):
      [4706a3a1eebd] fstests: solve no-return-in-nonvoid-function issue


Code Diffstat:

 common/btrfs            |  57 +++++++++++---
 common/config           |   4 +
 common/quota            |   2 +-
 common/rc               |  14 ++++
 common/verity           |   5 +-
 common/xfs              |  10 +++
 src/dio-buf-fault.c     |   2 +-
 src/fake-dump-rootino.c |   1 +
 tests/btrfs/001         |   4 +-
 tests/btrfs/001.out     |   1 -
 tests/btrfs/002         |   2 -
 tests/btrfs/003         |   1 -
 tests/btrfs/004         |   4 +-
 tests/btrfs/005         |   2 -
 tests/btrfs/006         |   4 -
 tests/btrfs/007         |   8 +-
 tests/btrfs/008         |   2 -
 tests/btrfs/009         |   2 -
 tests/btrfs/011         |  12 ++-
 tests/btrfs/012         |   4 -
 tests/btrfs/013         |   2 -
 tests/btrfs/014         |   2 -
 tests/btrfs/015         |   2 -
 tests/btrfs/016         |   2 -
 tests/btrfs/017         |   9 +--
 tests/btrfs/018         |   2 -
 tests/btrfs/019         |   2 -
 tests/btrfs/020         |   2 -
 tests/btrfs/021         |   2 -
 tests/btrfs/022         |   7 +-
 tests/btrfs/023         |   2 -
 tests/btrfs/024         |   2 -
 tests/btrfs/025         |  22 +++---
 tests/btrfs/026         |   2 -
 tests/btrfs/027         |   3 -
 tests/btrfs/028         |   4 +-
 tests/btrfs/029         |   2 -
 tests/btrfs/030         |  14 ++--
 tests/btrfs/031         |   2 -
 tests/btrfs/032         |   2 -
 tests/btrfs/033         |   2 -
 tests/btrfs/034         |  14 ++--
 tests/btrfs/035         |   2 -
 tests/btrfs/036         |   2 -
 tests/btrfs/037         |   2 -
 tests/btrfs/038         |  22 +++---
 tests/btrfs/039         |  14 ++--
 tests/btrfs/040         |  14 ++--
 tests/btrfs/041         |   4 +-
 tests/btrfs/042         |  11 ++-
 tests/btrfs/043         |  14 ++--
 tests/btrfs/044         |  14 ++--
 tests/btrfs/045         |  14 ++--
 tests/btrfs/046         |  16 ++--
 tests/btrfs/047         |   3 -
 tests/btrfs/048         |  18 ++---
 tests/btrfs/049         |   2 -
 tests/btrfs/050         |   8 +-
 tests/btrfs/051         |   8 +-
 tests/btrfs/052         |   4 +-
 tests/btrfs/053         |  14 ++--
 tests/btrfs/054         |  20 +++--
 tests/btrfs/055         |   2 -
 tests/btrfs/056         |   2 -
 tests/btrfs/057         |   8 +-
 tests/btrfs/058         |   6 +-
 tests/btrfs/059         |   2 -
 tests/btrfs/060         |   2 -
 tests/btrfs/061         |   2 -
 tests/btrfs/062         |   2 -
 tests/btrfs/063         |   2 -
 tests/btrfs/064         |   2 -
 tests/btrfs/065         |   2 -
 tests/btrfs/066         |   2 -
 tests/btrfs/067         |   2 -
 tests/btrfs/068         |   2 -
 tests/btrfs/069         |   2 -
 tests/btrfs/070         |   2 -
 tests/btrfs/071         |   2 -
 tests/btrfs/072         |   2 -
 tests/btrfs/073         |   2 -
 tests/btrfs/074         |   2 -
 tests/btrfs/075         |   2 -
 tests/btrfs/076         |   2 -
 tests/btrfs/077         |  14 ++--
 tests/btrfs/078         |   2 -
 tests/btrfs/079         |   2 -
 tests/btrfs/080         |   4 +-
 tests/btrfs/081         |   2 -
 tests/btrfs/082         |   2 -
 tests/btrfs/083         |  14 ++--
 tests/btrfs/084         |  14 ++--
 tests/btrfs/085         |   6 +-
 tests/btrfs/086         |   2 -
 tests/btrfs/087         |  14 ++--
 tests/btrfs/088         |   2 -
 tests/btrfs/089         |   4 -
 tests/btrfs/090         |   6 +-
 tests/btrfs/091         |  11 +--
 tests/btrfs/092         |  14 ++--
 tests/btrfs/093         |   2 -
 tests/btrfs/094         |  14 ++--
 tests/btrfs/095         |   2 -
 tests/btrfs/096         |   2 -
 tests/btrfs/097         |  14 ++--
 tests/btrfs/098         |   2 -
 tests/btrfs/099         |   7 +-
 tests/btrfs/100         |   7 +-
 tests/btrfs/101         |   7 +-
 tests/btrfs/102         |   2 -
 tests/btrfs/103         |   2 -
 tests/btrfs/104         |  12 ++-
 tests/btrfs/105         |  16 ++--
 tests/btrfs/106         |   2 -
 tests/btrfs/107         |   3 -
 tests/btrfs/108         |   8 +-
 tests/btrfs/109         |   8 +-
 tests/btrfs/110         |  18 ++---
 tests/btrfs/111         |  22 +++---
 tests/btrfs/112         |   2 -
 tests/btrfs/113         |   2 -
 tests/btrfs/114         |   2 -
 tests/btrfs/115         |   2 -
 tests/btrfs/116         |   2 -
 tests/btrfs/117         |  20 +++--
 tests/btrfs/118         |  10 +--
 tests/btrfs/119         |   8 +-
 tests/btrfs/120         |   6 +-
 tests/btrfs/121         |   4 +-
 tests/btrfs/122         |  12 ++-
 tests/btrfs/123         |   6 +-
 tests/btrfs/124         |  13 ++--
 tests/btrfs/125         |  29 ++++---
 tests/btrfs/126         |   8 +-
 tests/btrfs/127         |  14 ++--
 tests/btrfs/128         |  14 ++--
 tests/btrfs/129         |  14 ++--
 tests/btrfs/130         |   6 +-
 tests/btrfs/131         |   3 -
 tests/btrfs/132         |   4 -
 tests/btrfs/133         |   2 -
 tests/btrfs/134         |   2 -
 tests/btrfs/135         |   2 -
 tests/btrfs/136         |   4 -
 tests/btrfs/137         |   2 -
 tests/btrfs/138         |   3 -
 tests/btrfs/139         |   7 +-
 tests/btrfs/140         |   4 -
 tests/btrfs/141         |   4 -
 tests/btrfs/142         |   4 -
 tests/btrfs/143         |   4 -
 tests/btrfs/144         |   2 -
 tests/btrfs/145         |   2 -
 tests/btrfs/146         |   2 -
 tests/btrfs/147         |   2 -
 tests/btrfs/148         |   5 +-
 tests/btrfs/149         |   2 -
 tests/btrfs/150         |   4 -
 tests/btrfs/151         |   4 -
 tests/btrfs/152         |  16 ++--
 tests/btrfs/152.out     |   2 -
 tests/btrfs/153         |   8 +-
 tests/btrfs/154         |   3 -
 tests/btrfs/155         |   2 -
 tests/btrfs/156         |   4 -
 tests/btrfs/157         |   6 +-
 tests/btrfs/158         |   6 +-
 tests/btrfs/159         |   2 -
 tests/btrfs/160         |   2 -
 tests/btrfs/161         |   8 +-
 tests/btrfs/162         |  10 +--
 tests/btrfs/163         |  16 ++--
 tests/btrfs/164         |  15 ++--
 tests/btrfs/165         |   2 -
 tests/btrfs/166         |   4 +-
 tests/btrfs/167         |   6 +-
 tests/btrfs/168         |   8 +-
 tests/btrfs/168.out     |   2 -
 tests/btrfs/169         |   8 +-
 tests/btrfs/169.out     |   2 -
 tests/btrfs/170         |   5 +-
 tests/btrfs/170.out     |   1 -
 tests/btrfs/171         |   2 -
 tests/btrfs/172         |   4 -
 tests/btrfs/176         |   4 -
 tests/btrfs/177         |   1 -
 tests/btrfs/178         |   2 -
 tests/btrfs/179         |   4 -
 tests/btrfs/180         |   4 -
 tests/btrfs/181         |   4 -
 tests/btrfs/182         |   4 -
 tests/btrfs/183         |   2 -
 tests/btrfs/184         |   2 -
 tests/btrfs/185         |   2 -
 tests/btrfs/186         |   2 -
 tests/btrfs/187         |   8 +-
 tests/btrfs/187.out     |   2 -
 tests/btrfs/188         |   8 +-
 tests/btrfs/188.out     |   2 -
 tests/btrfs/189         |   8 +-
 tests/btrfs/189.out     |   2 -
 tests/btrfs/190         |   4 -
 tests/btrfs/191         |   8 +-
 tests/btrfs/191.out     |   2 -
 tests/btrfs/192         |   4 -
 tests/btrfs/193         |   4 -
 tests/btrfs/194         |   4 -
 tests/btrfs/195         |   4 -
 tests/btrfs/196         |   4 -
 tests/btrfs/197         |  30 ++++----
 tests/btrfs/197.out     |  25 +-----
 tests/btrfs/198         |  29 ++++---
 tests/btrfs/198.out     |  25 +-----
 tests/btrfs/199         |   4 -
 tests/btrfs/200         |   8 +-
 tests/btrfs/200.out     |   2 -
 tests/btrfs/201         |   2 -
 tests/btrfs/202         |   3 +-
 tests/btrfs/202.out     |   1 -
 tests/btrfs/203         |   8 +-
 tests/btrfs/203.out     |   2 -
 tests/btrfs/204         |   4 -
 tests/btrfs/205         |   2 -
 tests/btrfs/206         |   2 -
 tests/btrfs/207         |   1 -
 tests/btrfs/208         |   2 -
 tests/btrfs/209         |   2 -
 tests/btrfs/210         |   4 -
 tests/btrfs/211         |   2 -
 tests/btrfs/212         |   4 -
 tests/btrfs/213         |   2 -
 tests/btrfs/214         |   3 -
 tests/btrfs/215         |   3 -
 tests/btrfs/216         |   2 -
 tests/btrfs/217         |   4 -
 tests/btrfs/218         |   6 +-
 tests/btrfs/219         |   3 -
 tests/btrfs/220         |   2 -
 tests/btrfs/221         |   2 -
 tests/btrfs/222         |   2 -
 tests/btrfs/223         |   2 -
 tests/btrfs/224         |   4 -
 tests/btrfs/225         |   4 -
 tests/btrfs/226         |   5 +-
 tests/btrfs/226.out     |   1 -
 tests/btrfs/227         |   2 -
 tests/btrfs/228         |   4 -
 tests/btrfs/229         |   2 -
 tests/btrfs/230         |   3 -
 tests/btrfs/231         |   2 -
 tests/btrfs/232         |   3 -
 tests/btrfs/233         |   2 -
 tests/btrfs/234         |   2 -
 tests/btrfs/235         |   2 -
 tests/btrfs/236         |   2 -
 tests/btrfs/237         |   3 -
 tests/btrfs/238         |   4 -
 tests/btrfs/239         |   2 -
 tests/btrfs/240         |   2 -
 tests/btrfs/241         |   2 -
 tests/btrfs/242         |   2 -
 tests/btrfs/243         |   2 -
 tests/btrfs/244         |   6 --
 tests/btrfs/245         |   3 -
 tests/btrfs/246         |   2 -
 tests/btrfs/247         |   4 -
 tests/btrfs/248         |   6 --
 tests/btrfs/249         |   6 --
 tests/btrfs/250         |   3 -
 tests/btrfs/251         |   4 -
 tests/btrfs/252         |   2 -
 tests/btrfs/254         |   2 -
 tests/btrfs/255         |   1 -
 tests/btrfs/256         |   3 -
 tests/btrfs/257         |   4 -
 tests/btrfs/258         |   3 -
 tests/btrfs/259         |   4 -
 tests/btrfs/260         |   4 -
 tests/btrfs/262         |   3 -
 tests/btrfs/263         |   4 -
 tests/btrfs/264         |   3 -
 tests/btrfs/265         |   3 -
 tests/btrfs/266         |   3 -
 tests/btrfs/267         |   3 -
 tests/btrfs/272         |  15 ++--
 tests/btrfs/273         |   9 +--
 tests/btrfs/275         |   2 -
 tests/btrfs/276         |   2 +-
 tests/btrfs/276.out     |   1 -
 tests/btrfs/277         |   4 -
 tests/btrfs/278         |  15 ++--
 tests/btrfs/280         |   2 +-
 tests/btrfs/280.out     |   1 -
 tests/btrfs/281         |   3 +-
 tests/btrfs/281.out     |   1 -
 tests/btrfs/282         |   1 -
 tests/btrfs/283         |   3 +-
 tests/btrfs/283.out     |   1 -
 tests/btrfs/284         |   1 -
 tests/btrfs/286         |   4 -
 tests/btrfs/287         |   6 +-
 tests/btrfs/287.out     |   2 -
 tests/btrfs/288         |   4 -
 tests/btrfs/289         |   3 -
 tests/btrfs/290         |  27 ++++---
 tests/btrfs/291         |   2 -
 tests/btrfs/292         |   4 -
 tests/btrfs/293         |   4 +-
 tests/btrfs/293.out     |   2 -
 tests/btrfs/294         |   4 -
 tests/btrfs/296         |   1 -
 tests/btrfs/297         |  10 +++
 tests/btrfs/299         |   2 -
 tests/btrfs/300         |   2 +-
 tests/btrfs/300.out     |   1 -
 tests/btrfs/301         |   4 -
 tests/btrfs/302         |   3 +-
 tests/btrfs/302.out     |   1 -
 tests/btrfs/310         |   6 --
 tests/btrfs/311         |   1 -
 tests/btrfs/312         |  78 -------------------
 tests/btrfs/312.out     |  19 -----
 tests/btrfs/314         |   3 +-
 tests/btrfs/314.out     |   2 -
 tests/btrfs/318         | 107 ++++++++++++++++++++++++++
 tests/btrfs/318.out     |   2 +
 tests/btrfs/320         |  17 ++---
 tests/generic/645       |   2 +
 tests/generic/732       |   2 +-
 tests/generic/744       |  81 ++++++++++++++++++++
 tests/generic/744.out   |   4 +
 tests/xfs/002           |   1 +
 tests/xfs/045           |   4 +-
 tests/xfs/095           |   1 +
 tests/xfs/096           |  74 ++++++++++++++++++
 tests/xfs/096.out       |  84 ++++++++++++++++++++
 tests/xfs/132           |   1 +
 tests/xfs/148           |   6 ++
 tests/xfs/158           |   5 --
 tests/xfs/158.out       |   3 -
 tests/xfs/160           |   5 --
 tests/xfs/160.out       |   3 -
 tests/xfs/194           |  10 +++
 tests/xfs/199           |   1 +
 tests/xfs/263           |   5 --
 tests/xfs/263.out       |  85 ---------------------
 tests/xfs/300           |   1 +
 tests/xfs/513           |  13 ----
 tests/xfs/513.out       |   9 ---
 tests/xfs/526           |   3 +
 tests/xfs/612           |  33 ++++++++
 tests/xfs/612.out       |   7 ++
 tests/xfs/613           | 199 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/613.out       |  15 ++++
 354 files changed, 1149 insertions(+), 1462 deletions(-)
--
Zorro Lang
zlang@kernel.org

--6xiIY8abvVvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmZAwCIACgkQlNbPkfr2
tMyy9g/+KjS2b977IVt2fDmcmGlwOoSm8KChco0wXGkNCdeTI6utnO6es0R5DGak
94jnkJLLMeDemzgoj1gZXdoSrTbvVm2fTgUwSk7E8OhGfZ6/ufuHgxTTDHZwQSl8
EMfFK1B+QyYZNvv5uD0eEPAk2wD/iN/L9forxxxxiwegR2F6R04cw882ugC6ElMF
/lah2Se64DMM5ec3j2UPLE8xDdVc5F3dlbPUjJfCwuh5qjbxT0f6zKLbiVAGvOA4
xv+BTKk8nKiqdjBDo/otwIKikvezaJnwm+yPeK0CETYX2MKMONH+r8PpRV7uIzG0
Bd38Tf+7mHdtMYhwE4A/Qv56f6+nwHbU4Wk+xZe8VRym33Art0KhDYhQzciyBiH/
w2+SfksNNxxmSQCucDknAL8KRl9lfHhQzCcAn5fLXDosY9wPQPu3uwUxh5l2uP1T
Ic9sxavQolCfV6H1BxGRZcj+IyEZ2ZI7pf7aMPtaOC1VBbU7KAL1fpj9RGl7lDL5
rFPi5X39w42p0K6W8n5+3hkckPYzwynKqXlOlS3TEDNvOAYqDbGyw86rTAyqpZWD
L0h5R0gnXN7z/8/V1EKt+Znj82fS2mctDnBWkLYtPxXPWRXJPuuL1NUb3x9mX2+u
gWC6biYD1vEGQEmD/8+aMG/VwjYoc3Bwo61pV69nAx/XedQBtIo=
=9zjV
-----END PGP SIGNATURE-----

--6xiIY8abvVvU--
