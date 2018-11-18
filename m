Received: from mail-pg1-f194.google.com ([209.85.215.194]:46216 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeKSApV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Nov 2018 19:45:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so12630373pgp.13
        for <fstests@vger.kernel.org>; Sun, 18 Nov 2018 06:24:54 -0800 (PST)
Message-ID: <5bf17635.1c69fb81.9b4aa.85c9@mx.google.com>
Date: Sun, 18 Nov 2018 22:24:46 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 7022f85ca72f
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2L7AGc3rH9R3"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--2L7AGc3rH9R3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update touches many files, which is due to
Christoph Hellwig's "require falloc" patches, but the actual changes are simple
and straightforward. There're also two new tests (for btrfs and overlayfs,
respectively) and some minor bug fixes.

New test btrfs/178 currently fails with v4.20-rc2 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

7022f85ca72f xfs: xfs_fsr requires working preallocation support

New commits:

Christoph Hellwig (3):
      [31735e301efc] generic: don't assume preallocation is supported when reflinks are supported
      [09e94f84d929] xfs: don't assume preallocation is always supported on XFS
      [7022f85ca72f] xfs: xfs_fsr requires working preallocation support

Filipe Manana (1):
      [ad91ed8a66cf] btrfs: test send after radical changes in a complex directory hierarchy

Miklos Szeredi (1):
      [98a4eb33deb5] overlay: create directory over deleted whiteout

Xiao Yang (1):
      [4096b78d665e] xfs/205: Fix that b2 variable is treated as octal vaule

xiaoli feng (1):
      [86aad197875e] ext4/034: filter out the specified vaule of $SCRATCH_MNT


Code Diffstat:

 common/defrag         |   2 +
 tests/btrfs/178       | 190 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/178.out   |   6 ++
 tests/btrfs/group     |   1 +
 tests/ext4/034        |   2 +-
 tests/ext4/034.out    |   2 +-
 tests/generic/176     |   1 +
 tests/generic/372     |   1 +
 tests/generic/414     |   1 +
 tests/generic/415     |   1 +
 tests/generic/447     |   1 +
 tests/generic/515     |   1 +
 tests/overlay/063     |  64 +++++++++++++++++
 tests/overlay/063.out |   2 +
 tests/overlay/group   |   1 +
 tests/xfs/009         |   1 +
 tests/xfs/072         |   3 +-
 tests/xfs/084         |   1 +
 tests/xfs/104         |   1 +
 tests/xfs/128         |   1 +
 tests/xfs/164         |   1 +
 tests/xfs/165         |   1 +
 tests/xfs/166         |   2 +
 tests/xfs/167         |   1 +
 tests/xfs/205         |   4 +-
 tests/xfs/231         |   1 +
 tests/xfs/232         |   1 +
 tests/xfs/242         |   1 +
 tests/xfs/250         |   1 +
 tests/xfs/280         |   1 +
 tests/xfs/294         |   2 +
 tests/xfs/312         |   1 +
 tests/xfs/313         |   1 +
 tests/xfs/316         |   1 +
 tests/xfs/324         |   1 +
 tests/xfs/326         |   1 +
 tests/xfs/328         |   1 +
 tests/xfs/330         |   1 +
 tests/xfs/444         |   1 +
 tests/xfs/445         |   1 +
 40 files changed, 303 insertions(+), 5 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--2L7AGc3rH9R3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJb8XXHAAoJECZSqilcj+djewIQAIT2HpOvOlBw+JkCwR/s4F+a
d79ZJ9cMYQdOZ5wl/2Gl0L/OIhLxVEmZu0GY7Nod7WyO27ovvO1Ht0rwLc9OrBld
EMNYJanZ60ZMYfzei//BwsQPt3HQo/Uzy90NxLR55wfJpqYcQ5aJVxuwY4gzpBwI
EIyPg7PSpDujR5HCKq3ze+9HI2jkOZHDROif4qp1rTyIoxEv9sqBS/aII2AEKyeb
wPZ6N1TQg/uguZx6LGRvGPFmWGcfrVnqCJB7gxutH3O1yiow/spjoCyaX8Nq6cIB
HmOfZURlLtNZuXcbooqZ4kEddpyGiBwx7ZvbGLVtDUuh2bE06pNhDonBD9ktxlfH
4/OHTgqBjNFo+yeVY4rVYHAnpJCrj7qMxTxNPN8XI/AQE2qQi2JmS5vvh0uEmevH
qz5efunVfx7sO1DxN9do1lsiJ7ZMaL+q+42GGo/uU7jxwD7x/wzUp+gTCtonuaK/
cFH2ckUpb65VhTvhI4UlA1u+VRw921kSsSvuzLkTi98uvHbcEQ8YaS9L4mqRfPhf
IpfHYTfeevp1vYUEPVy7AfgBMZ4zE7jH3UqIhreaX/narbtp1fsgDi8u1K9QG8MC
f2GDCmIMygzyYXxLOHneYB18U3kP0jvZXpdGx7oRp3htLkGXbs22G0RXZNwTpJMi
6mXuQhCITgtirMdNdCR/
=/mNG
-----END PGP SIGNATURE-----

--2L7AGc3rH9R3--
