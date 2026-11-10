Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319367;
	b=Ou0bSRXaTul8Kh65PJfTmuqgXi+2kp/cKZ+kQsXunKT5/Sx3ptSB0SheEQFfp5CSdMbE
	 FFlkbB0thr/HVxNCpqbW0KvtXRb5TZQL6iUP4y76Bqm00hAu+Cvc9JqITqujvOAIoifSE
	 Q/uUYV/XUIsz0BtCCKwgEK804WRc+SAkRhSGgZxjh1bA8RGo727brBfRHZcqO679w0v39
	 cMVKWZxzm6MQfw9lQfvfiYBseoYQ9rCuMT1CgUuREneHA+ZMW+kNSKeN79+UWr53DIbgA
	 6TZyXFWHnqgQd43lA42sVenSdIg4at20+7/uwGyR6SmcqlR+syMsWsuvhpQpZ1FzOVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319367;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Subject:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=Kx0Lr/xT3FJlKEUL/xGgAlwMbaejUEdbNmYER5dhbC0=;
	b=Io+5mLZ8TfpRuQylT4ef1+8Dl05EW+whYMLBv9tQdwgXG3352sufcUYttSHREvcA6wy0
	 /SQkZDjzhTlcNB4HePZaez3IYFHJhJkVh+2Q4GOZLZlopLZsQi6KXGU/17GeJt2rlDGo8
	 p/OZQvinQRNIV34XSPHifmgeN6/Q4AgR0q9h15lh2NyK/UtpYGLE1D4hySVMnkrl8RmYh
	 kL06SiMgm6fFW/IWsU7+0f5fReTapkr2KvLfbrK6E+NOX0Ov2iEyrE+NbNvvMuDuzElMr
	 Auq0ExHNYAVAV9av/tC6nIxcLxlryEBK3trWnjzid20GvlXWrVMNavZFIYDM0wVlLzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+q8Bwhx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6E606A325
	for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+q8Bwhx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EFE1F008A1
	for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319367;
	bh=Kx0Lr/xT3FJlKEUL/xGgAlwMbaejUEdbNmYER5dhbC0=;
	h=Date:From:To:Subject;
	b=D+q8Bwhxy2iQjDwnqgQMvdX3k5H5suNodTz1q0WumOImMRveDCInNvyrDpUgP6rfw
	 N+d/i/Stre/2mKQZvW3YZdi/TW9NASBqqyaessQt2tYHlBxsbvHhZiMMs8+XXK47Va
	 w4HSXP2KsCDiiWTRD3JPouZojTQasXAtoFa61oCUFrYkoCv7DxIze6+8F7J/Mqad3f
	 zSr8KIe3mYPPdHulFjhGkmAsaOknm+y/t3S6rhYFNRzXVzQp5ihXdtk49tkZtuwvG1
	 RZH8zw6TsDV2ynmkrVDxjXVhLM4KU6GDPB8VbfV6vQaA2dJV+FjxDTCDXz+Heheu+G
	 ECMOsJSH0OrZw==
Date: Tue, 10 Nov 2026 22:02:43 +0800
Message-ID: <d71459bb4537c332a0aed9379556c57d@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2026.11.10
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
  protocol="application/pgp-signature"; boundary="O3k74w17g0NM"
Content-Disposition: inline

--O3k74w17g0NM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2026.11.10 release.

Release Notes:
1) There're 5 new cases in this release, include btrfs/361, btrfs/363
   btrfs/364, generic/810 and generic/811. Most of them are known regression
   tests.
2) Refactor the common sysfs related helpers, including renaming
   some common helpers, replacing btrfs specific helpers, adding
   helpers for /sys/fs/$FSTYP/features/ etc.
3) Fix several bugs found during xfs and btrfs testing, also resolve some
   compile issues.

More details please refer to below, thanks for all these contributions!

Thanks,
Zorro

The new head of the for-next branch is commit:

71641219a506 generic: check that RWF_DONTCACHE I/O drops its folios

New commits:

Andrey Albershteyn (2):
      [7e636452ed4f] check: set seqres before calling init_rc which could write there
      [88a7dde2f616] xfs/619: fix mistyped seqres.full variable

Christian Brauner (1):
      [2c441bfacee8] src/vfs: skip whiteout-device fixtures on overlayfs

Darrick J. Wong (1):
      [afc1dbc731b9] generic/805: mask unmount failures on cleanup

Filipe Manana (2):
      [9629b4c11da4] btrfs: test fiemap does not merge compressed extents
      [591dc4f87a1e] btrfs: test compression attribute on filesystems mounted with nodatacow

Jeff Layton (1):
      [e1b8c0ff172c] tools/get_maintainer.pl: accept and ignore --nogit-chief-penguins

Johannes Thumshirn (1):
      [f0c21237aee6] btrfs: test that fsynced data on a RAID stripe tree survives a power failure

Lukas Herbolt (2):
      [2c690bd2955c] lib/random.c fix undefined behavior on signed integer overflow.
      [b4afae2800be] xfstests: Unify the build targets under LINUX_TARGET

Qu Wenruo (1):
      [f6983d7fdbed] fstests: generic: add a test case to check fsverity reads

Tal Zussman (3):
      [d64bdb8a716e] common/rc: probe pread options with a real read
      [77d36b1aae2a] common/rc: pass -V 1 when probing pwrite and pread -U
      [71641219a506] generic: check that RWF_DONTCACHE I/O drops its folios

Zorro Lang (6):
      [5a210444809f] fstests: rename _*_fs_sysfs_attr helpers to _*_fs_sysfs_dev_attr
      [36877358472e] fstests: consolidate _require_fs_sysfs and _require_fs_sysfs_dev_attr
      [edb33f6e3d1d] common: move btrfs-only sysfs policy helpers out of common/sysfs
      [18e17a0c7e8f] common/rc: add helpers for /sys/fs/$FSTYP/features/
      [24be66f776ab] common/rc: use common helper in _require_fanotify_ioerrors for f2fs
      [4c9f6e56ad64] fstests: replace btrfs specific helpers with common sysfs helpers


Code Diffstat:

 check                     |   8 ++-
 common/btrfs              | 176 ++++++++++++++++++++++++++++++++++++----------
 common/rc                 | 123 +++++++++++++++++++++++++-------
 common/sysfs              | 145 --------------------------------------
 common/xfs                |  24 ++++---
 lib/random.c              |  34 ++-------
 src/Makefile              |  55 ++++++++-------
 src/vfs/idmapped-mounts.c | 154 +++++++++++++++++++++-------------------
 src/vfs/utils.c           |  25 +++++++
 src/vfs/utils.h           |   1 +
 tests/btrfs/010           |   3 +-
 tests/btrfs/055           |   2 +-
 tests/btrfs/056           |   2 +-
 tests/btrfs/112           |   2 +-
 tests/btrfs/131           |   2 +-
 tests/btrfs/165           |   2 +-
 tests/btrfs/188           |   2 +-
 tests/btrfs/192           |   2 +-
 tests/btrfs/201           |   2 +-
 tests/btrfs/205           |   2 +-
 tests/btrfs/209           |   2 +-
 tests/btrfs/211           |   2 +-
 tests/btrfs/219           |   3 +-
 tests/btrfs/231           |   2 +-
 tests/btrfs/253           |  29 ++++----
 tests/btrfs/285           |   3 +-
 tests/btrfs/296           |   8 +--
 tests/btrfs/304           |   4 +-
 tests/btrfs/305           |   4 +-
 tests/btrfs/306           |   4 +-
 tests/btrfs/307           |   4 +-
 tests/btrfs/308           |   4 +-
 tests/btrfs/311           |   2 +-
 tests/btrfs/313           |   2 +-
 tests/btrfs/314           |   2 +-
 tests/btrfs/315           |   2 +-
 tests/btrfs/329           |   5 +-
 tests/btrfs/334           |   5 +-
 tests/btrfs/342           |   2 +-
 tests/btrfs/352           |   2 +-
 tests/btrfs/361           |  50 +++++++++++++
 tests/btrfs/361.out       |   8 +++
 tests/btrfs/363           |  66 +++++++++++++++++
 tests/btrfs/363.out       |  15 ++++
 tests/btrfs/364           |  44 ++++++++++++
 tests/btrfs/364.out       |   5 ++
 tests/f2fs/025            |   2 +-
 tests/generic/098         |   2 +-
 tests/generic/101         |   2 +-
 tests/generic/805         |   2 +-
 tests/generic/810         |  72 +++++++++++++++++++
 tests/generic/810.out     |   2 +
 tests/generic/811         |  77 ++++++++++++++++++++
 tests/generic/811.out     |  11 +++
 tests/xfs/006             |   4 +-
 tests/xfs/177             |   4 +-
 tests/xfs/264             |  14 ++--
 tests/xfs/619             |   2 +-
 tests/xfs/668             |   6 +-
 tests/xfs/669             |   6 +-
 tests/xfs/670             |   2 +-
 tools/get_maintainer.pl   |   2 +
 62 files changed, 822 insertions(+), 433 deletions(-)
--
Zorro Lang
zlang@kernel.org

--O3k74w17g0NM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: inline; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmrzI9kACgkQlNbPkfr2
tMzv7xAAjCOdGdYNEzF1GVwQYyvuWmkCuxbH9JZuuafu41q2jCSH7kP+2/+WuCtn
g0d88aTzRCqwyScqfpmYAsJpbIQps48+gUiSrg5C46q48idhFDe9rh6rp+BEq+T3
439rKjyqGGOQaJv/tLk8vZ2y/XtreQRlq1L7Eavguaxj3w+n+2NADqr9mwDa05AT
1nufyYo79Cuj/0TrV7NDI3bZTTlEaPTIhOzudRfBBrEqV7lex1/9SOExOZIIQgh7
w27x/L38flnNivhVyiiEM7dvSCCrfb3G60i9UGJm0dwkOGOgxZQVuxmMlIxZY7Hp
JHQ+HeY5iJ0wrZ4S/Zb0JAdQZ3V1YWJrVDx2ry/6FS7M9LaeoSM0J36LgBtp4I63
3eWbqs9qp61bGvNxSCpL8rpDl0QnyrufeDQByKlKa4EDzKB0z6ufGnkonBi0XSdf
YSEqKj4c1inNROSrc0sCucNdkgM74YYjhlh7iG7hUCQIoxxQw7fqSRk1iU2pGC4p
gjyeCmDkNR0OMciq/G5/Xr5roPoivUNHKYHnyCzOfIGRWTB459XjPvRrWtLHdi0l
VrDi9lr2N+yRieAkP+nYkLt1o4CseyblaYbYl1tLPFj6QroFRHQN4PV+fQSiJdaq
A8KRQrSu6bhuJTwuijxuPN3kxWmt+B4fXlLxk4VspKJI59SCCNc=
=I53N
-----END PGP SIGNATURE-----

--O3k74w17g0NM--
