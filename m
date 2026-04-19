Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5620E030
	for <fstests@vger.kernel.org>; Sun, 19 Apr 2026 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614711; cv=none; b=F0lixkA4gxIgHp43ShsONNdM7JZHacKaBrhCDuvKphZfLdi8YuHUIH9zyw0LdjpXzUNkB4FfieH0zafblLVymP1nnTA/rIsrs4YaVfeCwe29tFNF8yn3FQlX6VAAD0QPPc2rSVgIPUD0lLbmCUrcg/wcqx54OEE6/USrJ3Mvbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614711; c=relaxed/simple;
	bh=T6B87A5IaPzRj4RivMRFMOoYvdiU/W1eWDHccrCJ1/I=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=A/eS+xa1skZb+iKu7K8QfxqyeuDM5H2JVZ+VGC0S9P5aTKpfHyiTuMAui3dMz8l8Lm5EvOmc/WsKRCIocrJvbizLmxw7vWa4X0HYJ242nMLYKZJwOLxAZUV5ku2XtbGJMQD+cjy1VUBXevzZzc/I6PvwtBKCSTHzErgP85c+wvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvpwMDE6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvpwMDE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56084C2BCAF;
	Sun, 19 Apr 2026 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776614711;
	bh=T6B87A5IaPzRj4RivMRFMOoYvdiU/W1eWDHccrCJ1/I=;
	h=Date:From:To:Subject:From;
	b=CvpwMDE6NmMaz0VmERUmAXyLRdUcntWUGsgvhtrseu5kLK8/PNviTamlRA5mp9Tbs
	 CR+MItqCit7FoLMKQNNNB90VqyLYTqmHd8rZrQ8A2HWX9yyu6Hm/8+Degdry7qbzyb
	 VOrL0KS6QmqdE30MUhIMVcuHsmb6jZLEdRp6Cmt39BGxlmNRB1PWdu8t6ypsA78Psu
	 mvkew2TQkcgMwKYxXzNvvQITpMKRbYiip9gosGGGBdBqQ/5vVRYMLmXDVLO+PJjpFJ
	 M8pBVJVb4LQoHYnQx6KFxHhrz+iHVLL+hlg/igZmxgd3vQRqhoIYn/7wJzjhUy8bF5
	 mFpO0euJ1AbyQ==
Date: Mon, 20 Apr 2026 00:05:05 +0800
Message-ID: <85859137daa780037514cc25abf80cf8@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2026.03.20 onto master branch
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A9zNeeFsGdih"
Content-Disposition: inline


--A9zNeeFsGdih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2026.03.20 version.

Thanks,
Zorro

The new head of the master branch is commit:

57d71a884dd1 ltp: add support for FALLOC_FL_WRITE_ZEROES to fsx and fsstress

New commits:

Darrick J. Wong (17):
      [fd9292449514] xfs/62[3-8]: require XFS_SCRUB_PROG
      [29d120e41c3d] generic: test fsnotify filesystem error reporting
      [79f6b1c3e4d8] xfs: test health monitoring code
      [c90d3c12ffe1] xfs: test for metadata corruption error reporting via healthmon
      [1eef51a44b3f] xfs: test io error reporting via healthmon
      [15548b5e8482] xfs: set up common code for testing xfs_healer
      [e76e776e4310] xfs: test xfs_healer's event handling
      [a951e61b684c] xfs: test xfs_healer can fix a filesystem
      [aa3d8defe09a] xfs: test xfs_healer can report file I/O errors
      [eb1013c4f269] xfs: test xfs_healer can report file media errors
      [8e5ed6fcef96] xfs: test xfs_healer can report filesystem shutdowns
      [20dffed104b6] xfs: test xfs_healer can initiate full filesystem repairs
      [309e54e83e1f] xfs: test xfs_healer can follow mount moves
      [17fdaa0ba3f1] xfs: test xfs_healer wont repair the wrong filesystem
      [df0f4b76c572] xfs: test xfs_healer background service
      [de37793e7b07] xfs: test xfs_healer startup service
      [aa5b0dcf301d] xfs: test xfs_healer can follow private mntns mount moves

Filipe Manana (4):
      [01d24d6b0b28] generic: test a directory fsync scenaro after replacing a subdir with a file
      [aad362549a8a] btrfs: test setting the same received UUID to a lot of subvolumes
      [c6946bc36b9f] btrfs: test creating a large number of snapshots of a received subvolume
      [66c672a2e845] btrfs: test create a bunch of files with name hash collision

Johannes Thumshirn (2):
      [02e625a5875a] fstests: add _fixed_by_fs_commit helper
      [8ca8c3c238bc] fstests: use _fixed_by_fs_commit where appropriate

Pankaj Raghav (1):
      [57d71a884dd1] ltp: add support for FALLOC_FL_WRITE_ZEROES to fsx and fsstress


Code Diffstat:

 .gitignore                        |   2 +
 README                            |   2 +-
 common/config                     |  14 +++
 common/module                     |  11 ++
 common/rc                         |  40 +++++++
 common/systemd                    |  39 +++++++
 common/xfs                        |  98 ++++++++++++++++++
 configure.ac                      |   4 +
 doc/group-names.txt               |   1 +
 ltp/fsstress.c                    |  15 ++-
 ltp/fsx.c                         |  85 ++++++++++++++-
 src/Makefile                      |   6 +-
 src/fs-monitor.c                  | 153 +++++++++++++++++++++++++++
 src/global.h                      |   8 ++
 src/t_btrfs_received_uuid_ioctl.c |  50 +++++++++
 tests/btrfs/345                   |  73 +++++++++++++
 tests/btrfs/345.out               |   2 +
 tests/btrfs/346                   |  95 +++++++++++++++++
 tests/btrfs/346.out               |   3 +
 tests/btrfs/347                   |  66 ++++++++++++
 tests/btrfs/347.out               |   3 +
 tests/generic/211                 |   2 +-
 tests/generic/362                 |   3 +-
 tests/generic/363                 |  10 +-
 tests/generic/364                 |   3 +-
 tests/generic/365                 |  15 ++-
 tests/generic/366                 |   2 +-
 tests/generic/367                 |   2 +-
 tests/generic/370                 |   5 +-
 tests/generic/471                 |   2 +-
 tests/generic/562                 |   3 +-
 tests/generic/623                 |   2 +-
 tests/generic/631                 |   3 +-
 tests/generic/646                 |   2 +-
 tests/generic/649                 |   2 +-
 tests/generic/650                 |   2 +-
 tests/generic/695                 |   2 +-
 tests/generic/700                 |   2 +-
 tests/generic/701                 |   2 +-
 tests/generic/702                 |   2 +-
 tests/generic/703                 |   3 +-
 tests/generic/704                 |   2 +-
 tests/generic/706                 |   3 +-
 tests/generic/707                 |   2 +-
 tests/generic/708                 |   3 +-
 tests/generic/733                 |  10 +-
 tests/generic/736                 |   2 +-
 tests/generic/738                 |   2 +-
 tests/generic/741                 |   2 +-
 tests/generic/742                 |   3 +-
 tests/generic/748                 |   2 +-
 tests/generic/755                 |   2 +-
 tests/generic/757                 |   2 +-
 tests/generic/761                 |   2 +-
 tests/generic/763                 |   2 +-
 tests/generic/764                 |   2 +-
 tests/generic/766                 |   8 +-
 tests/generic/771                 |   2 +-
 tests/generic/779                 |   2 +-
 tests/generic/782                 |   2 +-
 tests/generic/784                 |   2 +-
 tests/generic/785                 |   2 +-
 tests/generic/789                 |   2 +-
 tests/generic/790                 |  70 +++++++++++++
 tests/generic/790.out             |  12 +++
 tests/generic/791                 | 213 ++++++++++++++++++++++++++++++++++++++
 tests/generic/791.out             |  20 ++++
 tests/xfs/623                     |   3 +-
 tests/xfs/624                     |   3 +-
 tests/xfs/625                     |   3 +-
 tests/xfs/626                     |   3 +-
 tests/xfs/627                     |   3 +-
 tests/xfs/628                     |   1 +
 tests/xfs/654                     |  60 +++++++++++
 tests/xfs/654.out                 |   5 +
 tests/xfs/655                     |  98 ++++++++++++++++++
 tests/xfs/655.out                 |   8 ++
 tests/xfs/656                     |  98 ++++++++++++++++++
 tests/xfs/656.out                 |  10 ++
 tests/xfs/657                     |  43 ++++++++
 tests/xfs/657.out                 |   2 +
 tests/xfs/658                     |  88 ++++++++++++++++
 tests/xfs/658.out                 |   2 +
 tests/xfs/659                     | 209 +++++++++++++++++++++++++++++++++++++
 tests/xfs/659.out                 |  21 ++++
 tests/xfs/660                     | 171 ++++++++++++++++++++++++++++++
 tests/xfs/660.out                 |   7 ++
 tests/xfs/661                     |  36 +++++++
 tests/xfs/661.out                 |   4 +
 tests/xfs/662                     | 107 +++++++++++++++++++
 tests/xfs/662.out                 |   3 +
 tests/xfs/663                     | 114 ++++++++++++++++++++
 tests/xfs/663.out                 |   2 +
 tests/xfs/664                     | 135 ++++++++++++++++++++++++
 tests/xfs/664.out                 |   2 +
 tests/xfs/665                     | 152 +++++++++++++++++++++++++++
 tests/xfs/665.out                 |   2 +
 tests/xfs/666                     | 123 ++++++++++++++++++++++
 tests/xfs/666.out                 |   6 ++
 tests/xfs/667                     | 128 +++++++++++++++++++++++
 tests/xfs/667.out                 |   3 +
 tests/xfs/802                     |   4 +-
 102 files changed, 2781 insertions(+), 93 deletions(-)
--
Zorro Lang
zlang@kernel.org

--A9zNeeFsGdih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmnk/PsACgkQlNbPkfr2
tMzdQBAAiUXouBVv6p42zmga3Ep9cF5izt6V1efzyIQyio1DJT+8jw9TDVMMO2ds
LxKaeZDm1BbFKUJhY1VjUQr2mDWT2tIgE/F4pIGWBvFokDJTw366K/uD+BAKhmkp
ao9XRG7ySmbCBVbWcrXry0BTpk9HUXngjy9MdE2eFS2fNehuCMuQsAV8jlCe3jgi
drALYR9zVM4lG9PWl6uyuiImIF3pfUqx+SC3BxEdAsxWL95TYosdLaxEmfSeY7Yu
gUYo+Fsot52a8zURZH441UFoVSB9Qhq5He73DdAGuJMuJsfLNldXYMthsRZFrDPw
6WlKPWSobIkCkhH/G8mZwNjyqWbVdAxAj5WT16mTTRx3wjds6SUXVhiifmPlaDH6
PY63YFOcjFe++5JhBVrj1sD5V7hqyHfmeBmQXpxv/MIv9HOjXJRHbu6i/zZrBzec
3DryW6NT0UtWz9xGDtAv8f3FKRZhCFFpL8fBJ5+CJSR4pnw9AWfbWxFLpt0wT4jr
MmYFFiGJTbKHVfdyieEfyavfsOxLyZAaYsdThvil5WdUqUk/kTTp3YUTE0HKGb/o
tX5y/N9QiUkgX0D3MQ0tCvLtaiuI3vne6A5mV0Ogtj0iqzZDqWHJLLz1Xc2RIwYD
Wa5dax95ftMHR7LQJccfbqwDLZwNoW0vCK2THgNc2792yBxG7Qw=
=V2/8
-----END PGP SIGNATURE-----

--A9zNeeFsGdih--
