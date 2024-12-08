Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379E1E489
	for <fstests@vger.kernel.org>; Sun,  8 Dec 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733669554; cv=none; b=cbaFvFlRalriY4Yq3ePQbOQN3yFCPzDCuKNBcxO+hilX+ZM/NJ82w9MbS8bNeeceMF8Gbl6LvpFLTVNArAOAf5IJ48boTa9Vb4YR97BfP2iCXgqlSN/VrHbD0HJX4qHJhQc5K+GHGXsMW/dMnbgb18DtfFg9dkscI+81ou2Pxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733669554; c=relaxed/simple;
	bh=eLvA4kx5C+fnCFLmhBnu8FCgkz4rs0lfhGyLfJxjrOc=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=H2/QXuZIab0wvV+sRgJ9LVV2Ptb6nNxVIDVncrDufx/sjxjZV6m/BjuJZKqqHf85VNl8+p/Wvx96S6qZBP65ENbjFe9O9h/EzaLk3hJxSQFH7LleQqXhGf/6ppUPGEhHq+RVFN2sK2zmxQF+EuMgA/Ut1dqUeQ77F+0yLZ1esYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu1WLAca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu1WLAca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04398C4CED2;
	Sun,  8 Dec 2024 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733669553;
	bh=eLvA4kx5C+fnCFLmhBnu8FCgkz4rs0lfhGyLfJxjrOc=;
	h=Date:From:To:Cc:Subject:From;
	b=Hu1WLAcaapnY+KD1z2fln53yMqHnL00J1adNTkyCbQ7O0pJOgzf3VQX3RYkpmFJBU
	 Nfevwva2e2ysXBerliextbQyWFFnEfQZ+NXNf3aLoVDJgTxZ+Ak887biwFu3FjQDY8
	 O5UFz6KOqoCpecuqR3o3DDOrbAriQGmylNRP3VnN/YowM4vf0+hstcR3m3XHY8w5ku
	 /0pGXiZgW3HWjdsmLahrq9+46zWyP6vtum4EVWfBg044B18NU8YSJEKUz9dvMAy8+H
	 PLeDTnQJMzVz8XV4xHSlPJghL9THwzfJwN5gAvTWd7y2mPh+JwDQKcThdD4M4FMVtV
	 TPpEvfuiDnYww==
Date: Sun, 08 Dec 2024 22:52:30 +0800
Message-ID: <a33b53e5909124346404f167d605280f@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: for-next branch updated to v2024.12.08
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x6gFaOGFqDdG"
Content-Disposition: inline


--x6gFaOGFqDdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2024.12.08 release.

Release Note:
This release provdes a big new feature from Dave Chinner, many thanks for
Dave! He helps fstests to run parallelly. More details refer to:

https://lore.kernel.org/fstests/20241208061520.nfdwfajwyyw2xfdi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m26960c0a93aad6cc83eb31b9a7da244ded8efcd1

I've tried to test this release a whole week, also thanks for Darrick who
helped to test it too. I've fixed some issues we found this week, to avoid
bringing in regression. I can't make sure it won't break anything, this
release is a big change. So please try this new release if you like, and
feel free to report bugs to fstests@ if it breaks your regular test.

Thanks for the contrition from Dave again!

Thanks,
Zorro

The new head of the for-next branch is commit:

fa0e9712283f fstests: check-parallel

New commits:

Dave Chinner (41):
      [9f775a4d85e0] xfstests: add a multithreaded mode to bstat
      [800681ebd77c] xfs/448: get rid of assert-on-failure
      [8973af00ec21] fstests: cleanup fsstress process management
      [828f70eb9be5] fuzzy: don't use killall
      [603030dee015] fstests: per-test dmflakey instances
      [88c0291d297c] fstests: per-test dmerror instances
      [f94ee3b005ec] fstests: per-test dmhuge instances
      [acb933c5adeb] fstests: per-test dmthin instances
      [aaa132777476] fstests: per-test dmdust instances
      [03433e8c0dea] fstests: per-test dmdelay instances
      [9d8d91a05a41] fstests: fix DM device creation/removal vs udev races
      [f8d5367e01a7] fstests: use syncfs rather than sync
      [4c6bc4565105] fstests: clean up mount and unmount operations
      [ce79de11337e] fstests: clean up loop device instantiation
      [aaf40fb7b136] fstests: xfs/227 is really slow
      [91bc186b2479] fstests: mark tests that are unreliable when run in parallel
      [5f7a66b6dc4c] fstests: use udevadm wait in preference to settle
      [92d6f7878743] xfs/442: rescale load so it's not exponential
      [732e70d57edc] xfs/176: fix broken setup code
      [8e4fb00d1dc4] xfs/177: remove unused slab object count location checks
      [4b6d1a480e7d] fstests: remove uses of killall where possible
      [b5646b8e526a] generic/127: reduce runtime
      [b45f902e004c] quota: system project quota files need to be shared
      [aa251132be4e] dmesg: reduce noise from other tests
      [522e213053f8] fstests: stop using /tmp directly
      [000813899afb] fstests: scale some tests for high CPU count sanity
      [f53e2256b902] generic/310: cleanup killing background processes
      [dbd03a8afb97] filter: handle mount errors from CONFIG_BLK_DEV_WRITE_MOUNTED=y
      [c94bc7f99121] filters: add a filter that accepts EIO instead of other errors
      [c1bde1c24044] generic/085: general cleanup for reliability and debugging
      [32e14cb90b88] fstests: don't use directory stacks
      [bf7310a3c30e] fstests: clean up a couple of dm-flakey tests
      [e2986ec53470] fstests: clean up termination of various tests
      [b53217a88c05] vfstests: some tests require the testdir to be shared
      [91c4de6dc06b] xfs/629: single extent files should be within tolerance
      [71c184c7f3dd] xfs/076: fix broken mkfs filtering
      [c5ea106604d5] fstests: capture some failures to seqres.full
      [1a49022fab9b] fstests: always use fail-at-unmount semantics for XFS
      [b95d488dfe4b] generic/062: don't leave debug files in $here on failure
      [93c0cac2298c] fstests: quota grace periods unreliable under load
      [fa0e9712283f] fstests: check-parallel


Code Diffstat:

 check                                         |  12 +-
 check-parallel                                | 205 ++++++++++++
 common/btrfs                                  |   4 +-
 common/config                                 |  34 +-
 common/dmdelay                                |  24 +-
 common/dmdust                                 |  14 +-
 common/dmerror                                |  74 +++--
 common/dmflakey                               |  60 ++--
 common/dmhugedisk                             |  21 +-
 common/dmlogwrites                            |   4 +-
 common/dmthin                                 |  12 +-
 common/encrypt                                |   2 +-
 common/filter                                 |  17 +-
 common/fuzzy                                  |  37 ++-
 common/log                                    |   2 +-
 common/metadump                               |  28 +-
 common/overlay                                |  10 +-
 common/populate                               |   8 +-
 common/preamble                               |   1 +
 common/quota                                  |  37 +--
 common/rc                                     | 166 ++++++++--
 common/repair                                 |   2 +-
 common/report                                 |   2 +-
 common/verity                                 |   2 +-
 common/xfs                                    |   2 +-
 doc/group-names.txt                           |   1 +
 doc/requirement-checking.txt                  |   6 +-
 ltp/fsstress.c                                |  26 +-
 src/aio-dio-regress/aio-last-ref-held-by-io.c |   5 +-
 src/bstat.c                                   | 443 ++++++++++++++++++++------
 src/dmerror                                   |   6 +-
 tests/btrfs/004                               |  11 +-
 tests/btrfs/007                               |   3 +-
 tests/btrfs/012                               |   4 +-
 tests/btrfs/028                               |  13 +-
 tests/btrfs/049                               |   4 +-
 tests/btrfs/057                               |   4 +-
 tests/btrfs/060                               |  14 +-
 tests/btrfs/061                               |  13 +-
 tests/btrfs/062                               |  13 +-
 tests/btrfs/063                               |  13 +-
 tests/btrfs/064                               |  13 +-
 tests/btrfs/065                               |  14 +-
 tests/btrfs/066                               |  14 +-
 tests/btrfs/067                               |  14 +-
 tests/btrfs/068                               |  14 +-
 tests/btrfs/069                               |  13 +-
 tests/btrfs/070                               |  13 +-
 tests/btrfs/071                               |  13 +-
 tests/btrfs/072                               |  14 +-
 tests/btrfs/073                               |  13 +-
 tests/btrfs/074                               |  13 +-
 tests/btrfs/078                               |  12 +-
 tests/btrfs/100                               |   4 +-
 tests/btrfs/101                               |   4 +-
 tests/btrfs/136                               |   6 +-
 tests/btrfs/160                               |   3 +-
 tests/btrfs/192                               |  12 +-
 tests/btrfs/195                               |   2 +-
 tests/btrfs/212                               |  16 +-
 tests/btrfs/232                               |   4 +-
 tests/btrfs/252                               |   5 +-
 tests/btrfs/261                               |   2 +-
 tests/btrfs/284                               |   4 +-
 tests/btrfs/286                               |   2 +-
 tests/btrfs/291                               |   5 +-
 tests/btrfs/320                               |   6 +-
 tests/btrfs/332                               |   4 +-
 tests/ext4/004                                |   4 +-
 tests/ext4/057                                |  14 +-
 tests/ext4/058                                |   3 +-
 tests/ext4/307                                |   4 +-
 tests/generic/013                             |  22 +-
 tests/generic/015                             |   2 +-
 tests/generic/019                             |  13 +-
 tests/generic/029                             |   2 +-
 tests/generic/030                             |   2 +-
 tests/generic/032                             |   2 +-
 tests/generic/034                             |   2 +-
 tests/generic/039                             |   2 +-
 tests/generic/040                             |   2 +-
 tests/generic/041                             |   2 +-
 tests/generic/042                             |   4 +-
 tests/generic/048                             |   2 +-
 tests/generic/049                             |   4 +-
 tests/generic/050                             |   3 +-
 tests/generic/051                             |  24 +-
 tests/generic/054                             |   2 +-
 tests/generic/055                             |   6 +-
 tests/generic/057                             |   2 +-
 tests/generic/059                             |   2 +-
 tests/generic/062                             |   2 +-
 tests/generic/065                             |   2 +-
 tests/generic/066                             |   5 +-
 tests/generic/067                             |  17 +-
 tests/generic/068                             |   7 +-
 tests/generic/070                             |  12 +-
 tests/generic/073                             |   2 +-
 tests/generic/076                             |  10 +-
 tests/generic/076.out                         |   1 -
 tests/generic/081                             |   8 +-
 tests/generic/083                             |  13 +-
 tests/generic/083.out                         |   1 -
 tests/generic/084                             |  12 +-
 tests/generic/085                             |  21 +-
 tests/generic/090                             |   4 +-
 tests/generic/092                             |   2 +-
 tests/generic/098                             |   4 +-
 tests/generic/099                             |   8 +-
 tests/generic/101                             |   2 +-
 tests/generic/104                             |   2 +-
 tests/generic/106                             |   2 +-
 tests/generic/107                             |   2 +-
 tests/generic/108                             |   9 +-
 tests/generic/109                             |   5 +-
 tests/generic/117                             |   4 +-
 tests/generic/127                             |  67 ++--
 tests/generic/127.out                         |   6 -
 tests/generic/135                             |  26 +-
 tests/generic/150                             |   2 +-
 tests/generic/151                             |   2 +-
 tests/generic/152                             |   2 +-
 tests/generic/157                             |   3 +-
 tests/generic/158                             |   3 +-
 tests/generic/159                             |   2 +-
 tests/generic/160                             |   2 +-
 tests/generic/162                             |   4 +-
 tests/generic/163                             |   4 +-
 tests/generic/164                             |   4 +-
 tests/generic/165                             |   4 +-
 tests/generic/166                             |   6 +-
 tests/generic/167                             |   4 +-
 tests/generic/168                             |   7 +-
 tests/generic/170                             |   7 +-
 tests/generic/171                             |   6 +-
 tests/generic/172                             |   6 +-
 tests/generic/173                             |   6 +-
 tests/generic/174                             |   6 +-
 tests/generic/204                             |   8 -
 tests/generic/232                             |   5 +-
 tests/generic/232.out                         |   1 -
 tests/generic/247                             |   2 +-
 tests/generic/250                             |   2 +-
 tests/generic/252                             |   5 +-
 tests/generic/265                             |   2 +-
 tests/generic/266                             |   2 +-
 tests/generic/267                             |   2 +-
 tests/generic/268                             |   2 +-
 tests/generic/269                             |   8 +-
 tests/generic/270                             |  10 +-
 tests/generic/271                             |   2 +-
 tests/generic/272                             |   2 +-
 tests/generic/273                             |   2 +-
 tests/generic/274                             |   6 +-
 tests/generic/275                             |   6 +-
 tests/generic/276                             |   2 +-
 tests/generic/278                             |   2 +-
 tests/generic/279                             |   2 +-
 tests/generic/281                             |   2 +-
 tests/generic/282                             |   2 +-
 tests/generic/283                             |   2 +-
 tests/generic/306                             |   2 +-
 tests/generic/310                             |  24 +-
 tests/generic/315                             |   2 +-
 tests/generic/317                             |   2 +-
 tests/generic/318                             |   2 +-
 tests/generic/321                             |   4 +-
 tests/generic/323                             |   7 +-
 tests/generic/325                             |   2 +-
 tests/generic/328                             |   4 +-
 tests/generic/329                             |   5 +-
 tests/generic/330                             |   2 +-
 tests/generic/331                             |   7 +-
 tests/generic/332                             |   4 +-
 tests/generic/333                             |   6 +-
 tests/generic/334                             |   6 +-
 tests/generic/335                             |   2 +-
 tests/generic/336                             |   9 +-
 tests/generic/341                             |   2 +-
 tests/generic/342                             |   2 +-
 tests/generic/343                             |   2 +-
 tests/generic/347                             |   2 +-
 tests/generic/348                             |   2 +-
 tests/generic/353                             |   2 +-
 tests/generic/361                             |   8 +-
 tests/generic/373                             |   4 +-
 tests/generic/374                             |   4 +-
 tests/generic/376                             |   2 +-
 tests/generic/382                             |   2 +-
 tests/generic/387                             |   2 +-
 tests/generic/388                             |  24 +-
 tests/generic/390                             |  11 +-
 tests/generic/391                             |   2 +-
 tests/generic/395                             |   2 +-
 tests/generic/409                             |  11 +-
 tests/generic/410                             |  11 +-
 tests/generic/411                             |  11 +-
 tests/generic/416                             |   2 +-
 tests/generic/422                             |   4 +-
 tests/generic/425                             |   2 +-
 tests/generic/441                             |   2 +-
 tests/generic/459                             |   8 +-
 tests/generic/461                             |  17 +-
 tests/generic/464                             |  10 +-
 tests/generic/474                             |   4 +-
 tests/generic/475                             |  17 +-
 tests/generic/476                             |  15 +-
 tests/generic/479                             |   2 +-
 tests/generic/480                             |   2 +-
 tests/generic/482                             |  12 +-
 tests/generic/483                             |   2 +-
 tests/generic/484                             |   3 +-
 tests/generic/489                             |   2 +-
 tests/generic/502                             |   2 +-
 tests/generic/505                             |   2 +-
 tests/generic/506                             |   2 +-
 tests/generic/507                             |   2 +-
 tests/generic/508                             |   2 +-
 tests/generic/510                             |   2 +-
 tests/generic/520                             |   2 +-
 tests/generic/526                             |   2 +-
 tests/generic/527                             |   2 +-
 tests/generic/530                             |   2 +-
 tests/generic/531                             |   8 +-
 tests/generic/535                             |   2 +-
 tests/generic/546                             |   2 +-
 tests/generic/547                             |   5 +-
 tests/generic/556                             |   2 +-
 tests/generic/560                             |   7 +-
 tests/generic/561                             |  31 +-
 tests/generic/563                             |  26 +-
 tests/generic/564                             |  12 +-
 tests/generic/579                             |   8 +-
 tests/generic/585                             |   4 +-
 tests/generic/589                             |  11 +-
 tests/generic/590                             |   9 +-
 tests/generic/599                             |   2 +-
 tests/generic/601                             |   7 +-
 tests/generic/603                             |  14 +-
 tests/generic/604                             |   2 +-
 tests/generic/610                             |   2 +-
 tests/generic/620                             |   1 +
 tests/generic/628                             |   4 +-
 tests/generic/629                             |   4 +-
 tests/generic/631                             |   2 +-
 tests/generic/632                             |   2 +
 tests/generic/640                             |   2 +-
 tests/generic/642                             |  10 +-
 tests/generic/648                             |  25 +-
 tests/generic/650                             |  19 +-
 tests/generic/670                             |   2 +-
 tests/generic/671                             |   2 +-
 tests/generic/672                             |   2 +-
 tests/generic/673                             |   2 +-
 tests/generic/674                             |   2 +-
 tests/generic/675                             |   2 +-
 tests/generic/677                             |   2 +-
 tests/generic/683                             |   2 +-
 tests/generic/684                             |   2 +-
 tests/generic/685                             |   2 +-
 tests/generic/686                             |   2 +-
 tests/generic/687                             |   2 +-
 tests/generic/688                             |   2 +-
 tests/generic/690                             |   2 +-
 tests/generic/691                             |   6 +-
 tests/generic/694                             |   2 +-
 tests/generic/695                             |   2 +-
 tests/generic/698                             |   4 +-
 tests/generic/699                             |   8 +-
 tests/generic/703                             |   2 +-
 tests/generic/704                             |   2 +-
 tests/generic/707                             |   7 +-
 tests/generic/716                             |   2 +-
 tests/generic/717                             |   2 +-
 tests/generic/718                             |   2 +-
 tests/generic/719                             |   2 +-
 tests/generic/721                             |   2 +-
 tests/generic/722                             |  15 +-
 tests/generic/725                             |   2 +-
 tests/generic/726                             |   2 +-
 tests/generic/727                             |   2 +-
 tests/generic/730                             |   2 +-
 tests/generic/731                             |   2 +-
 tests/generic/732                             |   4 +-
 tests/generic/735                             |   2 +-
 tests/generic/738                             |   2 +-
 tests/generic/741                             |   2 +-
 tests/generic/743                             |   4 +-
 tests/generic/744                             |  10 +-
 tests/generic/745                             |   4 +-
 tests/generic/746                             |  18 +-
 tests/generic/747                             |   4 +-
 tests/generic/749                             |   4 +-
 tests/generic/750                             |  10 +-
 tests/generic/751                             |   1 -
 tests/generic/753                             |  17 +-
 tests/overlay/019                             |  48 ++-
 tests/overlay/021                             |   8 +-
 tests/overlay/058                             |  12 +-
 tests/xfs/006                                 |   7 +-
 tests/xfs/011                                 |  11 +-
 tests/xfs/013                                 |  22 +-
 tests/xfs/014                                 |  11 +-
 tests/xfs/016                                 |   4 +-
 tests/xfs/017                                 |  13 +-
 tests/xfs/017.out                             |   1 -
 tests/xfs/032                                 |   2 +-
 tests/xfs/049                                 |  41 ++-
 tests/xfs/050                                 |   5 +
 tests/xfs/051                                 |  10 +-
 tests/xfs/052                                 |   2 +-
 tests/xfs/057                                 |   9 +-
 tests/xfs/070                                 |   9 +-
 tests/xfs/073                                 |  36 ++-
 tests/xfs/074                                 |  23 +-
 tests/xfs/076                                 |   8 +-
 tests/xfs/077                                 |   2 +-
 tests/xfs/078                                 |  20 +-
 tests/xfs/079                                 |  17 +-
 tests/xfs/104                                 |  14 +-
 tests/xfs/110                                 |   2 +-
 tests/xfs/118                                 |   4 +-
 tests/xfs/119                                 |   2 +-
 tests/xfs/128                                 |   2 +-
 tests/xfs/133                                 |   2 +-
 tests/xfs/134                                 |   2 +-
 tests/xfs/137                                 |   2 +-
 tests/xfs/141                                 |  13 +-
 tests/xfs/148                                 |  29 +-
 tests/xfs/149                                 |   8 +-
 tests/xfs/154                                 |   1 +
 tests/xfs/158                                 |   4 +-
 tests/xfs/161                                 |   2 +-
 tests/xfs/167                                 |  17 +-
 tests/xfs/168                                 |   8 +-
 tests/xfs/176                                 |  10 +-
 tests/xfs/177                                 |  15 +-
 tests/xfs/186                                 |   4 +-
 tests/xfs/195                                 |   2 +-
 tests/xfs/201                                 |   4 +-
 tests/xfs/212                                 |   2 +-
 tests/xfs/216                                 |  23 +-
 tests/xfs/217                                 |  24 +-
 tests/xfs/227                                 |  59 ++--
 tests/xfs/231                                 |   4 +-
 tests/xfs/232                                 |  10 +-
 tests/xfs/234                                 |   2 +-
 tests/xfs/236                                 |   2 +-
 tests/xfs/237                                 |  13 +-
 tests/xfs/239                                 |   2 +-
 tests/xfs/240                                 |   7 +-
 tests/xfs/241                                 |   2 +-
 tests/xfs/243                                 |  11 +-
 tests/xfs/246                                 |   2 +-
 tests/xfs/250                                 |  19 +-
 tests/xfs/259                                 |  13 +-
 tests/xfs/264                                 |   4 +-
 tests/xfs/265                                 |   2 +-
 tests/xfs/270                                 |   2 +-
 tests/xfs/272                                 |   2 +-
 tests/xfs/274                                 |   2 +-
 tests/xfs/276                                 |   2 +-
 tests/xfs/289                                 |   4 +-
 tests/xfs/291                                 |   4 +-
 tests/xfs/297                                 |  12 +-
 tests/xfs/300                                 |   8 +-
 tests/xfs/305                                 |   8 +-
 tests/xfs/309                                 |   2 +-
 tests/xfs/312                                 |   2 +-
 tests/xfs/313                                 |   2 +-
 tests/xfs/314                                 |   2 +-
 tests/xfs/315                                 |   4 +-
 tests/xfs/316                                 |   2 +-
 tests/xfs/317                                 |   2 +-
 tests/xfs/318                                 |   4 +-
 tests/xfs/319                                 |   2 +-
 tests/xfs/320                                 |   2 +-
 tests/xfs/321                                 |   2 +-
 tests/xfs/322                                 |   2 +-
 tests/xfs/323                                 |   2 +-
 tests/xfs/324                                 |   2 +-
 tests/xfs/325                                 |   4 +-
 tests/xfs/326                                 |   4 +-
 tests/xfs/327                                 |   2 +-
 tests/xfs/420                                 |   2 +-
 tests/xfs/421                                 |   2 +-
 tests/xfs/423                                 |   2 +-
 tests/xfs/438                                 |   2 +-
 tests/xfs/440                                 |   8 +-
 tests/xfs/442                                 |  15 +-
 tests/xfs/448                                 |   6 -
 tests/xfs/495                                 |   2 +-
 tests/xfs/501                                 |   2 +-
 tests/xfs/502                                 |   2 +-
 tests/xfs/507                                 |   2 +-
 tests/xfs/511                                 |   2 +-
 tests/xfs/513                                 |  48 ++-
 tests/xfs/519                                 |   2 +-
 tests/xfs/520                                 |   2 +-
 tests/xfs/521                                 |   8 +-
 tests/xfs/527                                 |   5 +-
 tests/xfs/528                                 |  10 +-
 tests/xfs/530                                 |  11 +-
 tests/xfs/538                                 |   4 +-
 tests/xfs/541                                 |   2 +-
 tests/xfs/544                                 |   2 +-
 tests/xfs/553                                 |   4 +-
 tests/xfs/558                                 |   7 +-
 tests/xfs/601                                 |   2 +-
 tests/xfs/606                                 |  14 +-
 tests/xfs/607                                 |   6 +-
 tests/xfs/609                                 |  20 +-
 tests/xfs/610                                 |  20 +-
 tests/xfs/613                                 |  44 +--
 tests/xfs/613.out                             |   1 -
 tests/xfs/617                                 |   2 +-
 tests/xfs/629                                 |   6 +-
 tests/xfs/630                                 |   2 +-
 tests/xfs/631                                 |   9 +-
 tests/xfs/790                                 |   2 +-
 tests/xfs/791                                 |   2 +-
 tests/xfs/792                                 |   2 +-
 tests/xfs/802                                 |   7 +-
 423 files changed, 2180 insertions(+), 1725 deletions(-)
--
Zorro Lang
zlang@kernel.org

--x6gFaOGFqDdG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmdVsjoACgkQlNbPkfr2
tMyNjRAAmMdyuh5B5iUY6/4UU/SFN6mahl1sIHVFJrbumHMlSXyiU9V/zgScYq8L
bckNr6MXOV1Jx50Z9YVpttQuPqb4VtZiF+rDi7b1g6oTprFF9y/wr5oeaRXxEbfX
u6OONBl0hNZMx2Ot/qRlw7B5zZqVfNmBTHdLi4p1hP61MLL7aGoKTRUykZNv8Zma
WKOoYbYw78puKL4qG2lqnskeo3t+4hGbZIktX1FLuwmtHzHW5QVQbkiBjFGTJ3F8
U5AjiXA/1BYy60DQKqLgu9PyruC7a03Ht7GQnoYI/k6LiR5+dSEdDCXk3IiTTRgI
btjjSLXlX8eo2nqDI0vOGFo39O1KXDkKW45c4+/YVuWDcvCOsdJoAjkt1iyjFYwu
YQH7ZkYbs1GtAdSX8QgpyRtSWioL4b5mJAI9w5KLck8i8K5jFzyC51hS2k1ZJZMG
REx3d16/XQ7WOuJzhFYxvy8psQ8d6sobHLWiSQFh/Cg9ENrnPKPWZUWmViqX0gAF
Hy/AIvyjG8wyexsazGaXBMEbAEU/rC3gkP/hux6nVncLxaMejPo9Of57x7jU83mV
Hf/bzXtF2PMyvITTyPB6oc9MpHBiqH5+jGg4saPcpUuaXBB97GTgV6P3zDNw6hHy
ZfGMsk5z18HajTAUF/BvLyx1PzhvOA39cn+mNO8bQrrNpxzMq34=
=Ldef
-----END PGP SIGNATURE-----

--x6gFaOGFqDdG--
