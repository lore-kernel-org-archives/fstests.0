Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683310E5
	for <fstests@vger.kernel.org>; Sun,  9 Mar 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741528172; cv=none; b=piwVgupyMzBzL9fr+XO6TzCb1uBNp8TadoclP840Rjh0iX3YDKQsibTjpdcQJhnyUCemIgVzzpsKRQxOTEhsph+BmaLUNa+RaMD4Sl+3Vzii7VU16YZ4a8SfiIZ3l18R/+qkuledNH5Q2jU+h8L6hDRVJGTThWeq2IhKILvFxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741528172; c=relaxed/simple;
	bh=6a0WPkPR8cdCVA9ZAbPN6V8ZiIwKMfNIWIDyPlj/wYA=;
	h=Date:Message-ID:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ps1UqDDdOldWpdI5cNj2TfEeCxvhcoQoqVyCWeCpnq+dCIDw/FbE8E/h93MbKzm1K42V0jbRctIIeUcCYiXxaGBvaU4tE0MZJnfJYPpxChUPvHDk1X1SQIfJ3gR6/YQkPFfrkop6bMQHgbVbZqjmka6hYA1kfuY+Bhvx/RemLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqN3nSqs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqN3nSqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A9EC4CEE3;
	Sun,  9 Mar 2025 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741528171;
	bh=6a0WPkPR8cdCVA9ZAbPN6V8ZiIwKMfNIWIDyPlj/wYA=;
	h=Date:From:To:Subject:From;
	b=MqN3nSqs4eHtEB7sD0H+KxYkN2mBgH+wzUn3B4BAX74AaLP9GwxVQ7qxcvPh8Srfs
	 1Ncde6r6SIHHsbnathPy3VWUf7iF+mPXoi87y9f7+C5o7EjNdoeLxwMRY6Ge6oPiLa
	 ylfiTEyXqEpwWt5mrvTRkxYwJXBogz/j0eMAuWTTUaYvBoCQ+I/oqphFFMNbY+j2Zo
	 7HdMwr6TsRat0B3r2AZJTZYmWEwnmzaV+6Q+gz3yQVuQpedK3zB7sZSREbOb1Ejxkw
	 EkDVIpFV+SaxE8tdzdY1z4XLNmW+QlKq41DU9WrSHgiqDVgGyym0ESC8EG2Zh6jHwK
	 DU80VmWLIVj4A==
Date: Sun, 09 Mar 2025 21:49:27 +0800
Message-ID: <e02d6e578b19ea6934bc6890390cc774@kernel.org>>
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2025.03.09
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oqZrnvIIMMDF"
Content-Disposition: inline


--oqZrnvIIMMDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2025.03.09 release.

This release has 2 main targets:
a. Sync to xfstests 6.14 testing
b. Bypass "privatens" ways, to avoid the regression last release.

So we have:
1) There're 32 new test cases in this release, include generic/762, generic/763
   and xfs/807 ~ 836. Only g/762, g/763 and x/817, x/818, x/819, x/820, x/821
   are in "auto" group, others are not.
2) Use "-std=gnu11" for GCC.
3) Don't use "privatens" way by default, to avoid a regression on btrfs.

More details refer to below. Thanks for all these contributions.

Thanks,
Zorro

The new head of the for-next branch is commit:

ce7f796ad416 check: remove the deprecation of sessionid

New commits:

Daniel Vacek (1):
      [203b0dca6e46] btrfs/314: fix the failure when SELinux is enabled

Darrick J. Wong (73):
      [04b1fc9de885] dio-writeback-race: fix missing mode in O_CREAT
      [23b67c61d213] dio_writeback_race: align the directio buffer to base page size
      [a93452279a95] misc: drop the dangerous label from xfs_scrub fsstress tests
      [2221604addfb] misc: rename the dangerous_repair group to fuzzers_repair
      [16bf8e439c30] misc: rename the dangerous_online_repair group to fuzzers_online_repair
      [a363eb0ed084] misc: rename the dangerous_bothrepair group to fuzzers_bothrepair
      [6e24526772a3] misc: rename the dangerous_norepair group to fuzzers_norepair
      [cb23e89d4751] misc: fix misclassification of xfs_repair fuzz tests
      [cbb9908b0766] misc: fix misclassification of xfs_scrub + xfs_repair fuzz tests
      [d2ad1fc0d7cb] misc: fix misclassification of verifier fuzz tests
      [8f0cf26f6a48] misc: add xfs_scrub + xfs_repair fuzz tests to the scrub and repair groups
      [c7f1a0545cc3] misc: remove the dangerous_scrub group
      [a940ba28a8a8] xfs/28[56],xfs/56[56]: add to the auto group
      [dbc6211f4804] xfs/349: reclassify this test as not dangerous
      [6eaff1c92742] various: fix finding metadata inode numbers when metadir is enabled
      [8fb574734546] xfs/{030,033,178}: forcibly disable metadata directory trees
      [b44a5142a1bd] common/repair: patch up repair sb inode value complaints
      [6e5f009236ad] xfs/206: update for metadata directory support
      [342db989bd45] xfs/{050,144,153,299,330}: update quota reports to handle metadir trees
      [194542e7ec7a] xfs/509: adjust inumbers accounting for metadata directories
      [5b3d24ad23f8] xfs: create fuzz tests for metadata directories
      [fc7d2d7ec794] xfs/163: bigger fs for metadir
      [c11f2c913080] xfs/122: disable this test for any codebase that knows about metadir
      [390999c98a12] common/populate: label newly created xfs filesystems
      [7135e4a298c1] scrub: race metapath online fsck with fsstress
      [5cbab6da44b1] xfs: test metapath repairs
      [3771456c2368] xfs/019: reduce _fail calls in test
      [90589a818e45] xfs/019: test reserved file support
      [6d39dc34e61e] xfs: test filesystem creation with xfs_protofile
      [7ec4ddb833a2] fstests: test mkfs.xfs protofiles with xattr support
      [b414487e555d] common/populate: refactor caching of metadumps to a helper
      [7f3cca812383] common/{fuzzy,populate}: use _scratch_xfs_mdrestore
      [c9e06ef77724] fuzzy: stress data and rt sections of xfs filesystems equally
      [22987b04c972] fuzzy: run fsx on data and rt sections of xfs filesystems equally
      [63c4b435e0ad] common/ext4: reformat external logs during mdrestore operations
      [ca2a19bff3b8] common/populate: use metadump v2 format by default for fs metadata snapshots
      [2de9a36140e6] punch-alternating: detect xfs realtime files with large allocation units
      [2d4f6426f639] xfs/206: update mkfs filtering for rt groups feature
      [a2e303885292] common: pass the realtime device to xfs_db when possible
      [601dea0201f4] xfs/185: update for rtgroups
      [3d03c6464c51] xfs/449: update test to know about xfs_db -R
      [bfc51793acba] xfs/271,xfs/556: fix tests to deal with rtgroups output in bmap/fsmap commands
      [fbe029eba5d6] common/xfs: capture realtime devices during metadump/mdrestore
      [89030ca633d0] common/fuzzy: adapt the scrub stress tests to support rtgroups
      [d5b9798f0576] xfs: fix fuzz tests of rtgroups bitmap and summary files
      [7e363bf2ca72] xfs: update tests for quota files in the metadir
      [1c272e5bd65b] xfs: test persistent quota flags
      [20ffc06a7c8a] xfs: fix quota detection in fuzz tests
      [f6606bb2344e] xfs: fix tests for persistent qflags
      [c67dc4e10b41] common: enable testing of realtime quota when supported
      [e8f38cebc303] xfs: fix quota tests to adapt to realtime quota
      [669c68b3895b] xfs: regression testing of quota on the realtime device
      [4b315c2285a3] common: test statfs reporting with project quota
      [d5fc76d7d835] xfs: fix tests that try to access the realtime rmap inode
      [64f53383c9bd] xfs/336: port to common/metadump
      [2d4a61d3e666] fuzz: for fuzzing the rtrmapbt, find the path to the rt rmap btree file
      [0c5229a2f76e] xfs: race fsstress with realtime rmap btree scrub and repair
      [748ed768efa4] xfs: fix various problems with fsmap detecting the data device
      [1c288a2329c6] xfs/341: update test for rtgroup-based rmap
      [cfe6a6d6ffaa] xfs/3{43,32}: adapt tests for rt extent size greater than 1
      [260efb67e86b] xfs/291: use _scratch_mkfs_sized instead of opencoding the logic
      [46efcb34db7d] xfs/104: use _scratch_mkfs_sized
      [6e493373294b] xfs/443: use file allocation unit, not dbsize
      [da61d5383e0f] populate: adjust rtrmap calculations for rtgroups
      [583b7a469e20] populate: check that we created a realtime rmap btree of the given height
      [cbe504822773] fuzzy: create missing fuzz tests for rt rmap btrees
      [8e84c0af1829] common/populate: create realtime refcount btree
      [3357566491db] xfs: create fuzz tests for the realtime refcount btree
      [4d2e4a1c43f2] xfs/27[24]: adapt for checking files on the realtime volume
      [0210de91b198] xfs: race fsstress with realtime refcount btree scrub and repair
      [33557e3683ff] xfs: remove xfs/131 now that we allow reflink on realtime volumes
      [406be9a1bc25] generic/331,xfs/240: support files that skip delayed allocation
      [3bccc0e2312e] common/xfs: fix _xfs_get_file_block_size when rtinherit is set and no rt section

Eric Sandeen (1):
      [4acec85f99bc] generic: test zero-byte writes to file

Filipe Manana (4):
      [91fa1a34db06] fstests: add commit IDs for kernel patches that are already in Linus' tree
      [8d273a3f2964] btrfs/254: fix test failure due to already unmounted scratch device
      [166502d36f3a] btrfs/080: fix sporadic failures starting with kernel 6.13
      [3a3e621cbbef] generic/363: add annotation for btrfs kernel commit

Naohiro Aota (1):
      [6fe33ea3a324] tools/run_privatens: check if it is mount point for --make-private

Qu Wenruo (1):
      [7a2f6aa489cb] fstests: btrfs/226: fill in missing comments changes

Zorro Lang (3):
      [77aab5c2bfc9] fstests: use '-std=gnu11' to fix build errors with gcc-15
      [336784e3d854] check: disable HAVE_PRIVATENS by default
      [ce7f796ad416] check: remove the deprecation of sessionid


Code Diffstat:

 check                                  |  22 +-
 common/config                          |   1 +
 common/ext4                            |  17 +-
 common/filter                          |   7 +-
 common/fuzzy                           | 138 ++++++++++---
 common/metadump                        |  22 +-
 common/populate                        | 167 +++++++++++----
 common/quota                           |  46 +++--
 common/rc                              |   1 +
 common/repair                          |   4 +
 common/xfs                             | 359 ++++++++++++++++++++++++++++++++-
 doc/group-names.txt                    |  13 +-
 include/builddefs.in                   |   2 +-
 src/dio-writeback-race.c               |   4 +-
 src/punch-alternating.c                |  28 ++-
 tests/btrfs/080                        |  42 ++--
 tests/btrfs/226                        |   6 +-
 tests/btrfs/254                        |   2 +-
 tests/btrfs/314                        |   2 +-
 tests/btrfs/323                        |   2 +-
 tests/btrfs/326                        |   2 +-
 tests/btrfs/330                        |   2 +-
 tests/generic/219                      |   1 +
 tests/generic/230                      |   1 +
 tests/generic/305                      |   1 +
 tests/generic/326                      |   1 +
 tests/generic/327                      |   1 +
 tests/generic/328                      |   1 +
 tests/generic/331                      |  13 +-
 tests/generic/331.out                  |   2 +-
 tests/generic/363                      |   3 +
 tests/generic/562                      |   2 +-
 tests/generic/563                      |   8 +-
 tests/generic/566                      |   4 +-
 tests/generic/587                      |   1 +
 tests/generic/603                      |   1 +
 tests/generic/691                      |   2 +
 tests/generic/710                      |   4 +-
 tests/generic/762                      | 114 +++++++++++
 tests/generic/762.out                  |  13 ++
 tests/generic/763                      |  29 +++
 tests/generic/763.out                  |   3 +
 tests/xfs/007                          |  18 +-
 tests/xfs/019                          |  14 +-
 tests/xfs/019.out                      |   5 +
 tests/xfs/030                          |   1 +
 tests/xfs/033                          |   1 +
 tests/xfs/050                          |   7 +
 tests/xfs/096                          |   5 +
 tests/xfs/096.out                      |   2 +-
 tests/xfs/104                          |   6 +-
 tests/xfs/106                          |   3 +-
 tests/xfs/108                          |   2 +
 tests/xfs/114                          |   4 +
 tests/xfs/116                          |  13 +-
 tests/xfs/116.cfg                      |   1 +
 tests/xfs/{116.out => 116.out.default} |   0
 tests/xfs/116.out.metadir              |   3 +
 tests/xfs/122                          |   6 +
 tests/xfs/122.out                      |   1 -
 tests/xfs/131                          |  46 -----
 tests/xfs/131.out                      |   5 -
 tests/xfs/146                          |   2 +-
 tests/xfs/152                          |   3 +-
 tests/xfs/153                          |   7 +
 tests/xfs/161                          |   1 +
 tests/xfs/163                          |   2 +-
 tests/xfs/178                          |   1 +
 tests/xfs/185                          |  65 ++++--
 tests/xfs/187                          |   3 +-
 tests/xfs/206                          |   2 +
 tests/xfs/213                          |   1 +
 tests/xfs/214                          |   1 +
 tests/xfs/220                          |   2 +
 tests/xfs/240                          |  12 +-
 tests/xfs/240.out                      |   2 +-
 tests/xfs/263                          |   1 +
 tests/xfs/263.out                      |   2 +-
 tests/xfs/271                          |   4 +-
 tests/xfs/272                          |  40 ++--
 tests/xfs/273                          |   2 +-
 tests/xfs/274                          |  62 ++++--
 tests/xfs/276                          |   2 +-
 tests/xfs/277                          |   2 +-
 tests/xfs/285                          |   2 +-
 tests/xfs/286                          |   2 +-
 tests/xfs/291                          |   2 +-
 tests/xfs/299                          |   3 +
 tests/xfs/330                          |   7 +-
 tests/xfs/332                          |   6 +-
 tests/xfs/332.out                      |   2 -
 tests/xfs/333                          |  43 ----
 tests/xfs/333.out                      |   6 -
 tests/xfs/336                          |  34 +---
 tests/xfs/336.out                      |   4 +-
 tests/xfs/337                          |   2 +-
 tests/xfs/338                          |  30 ++-
 tests/xfs/339                          |   5 +-
 tests/xfs/340                          |  25 ++-
 tests/xfs/341                          |  16 +-
 tests/xfs/341.out                      |   1 -
 tests/xfs/342                          |   4 +-
 tests/xfs/343                          |   2 +
 tests/xfs/349                          |   3 +-
 tests/xfs/350                          |   2 +-
 tests/xfs/351                          |   2 +-
 tests/xfs/352                          |   2 +-
 tests/xfs/353                          |   2 +-
 tests/xfs/354                          |   2 +-
 tests/xfs/355                          |   2 +-
 tests/xfs/356                          |   2 +-
 tests/xfs/357                          |   2 +-
 tests/xfs/358                          |   2 +-
 tests/xfs/359                          |   2 +-
 tests/xfs/360                          |   2 +-
 tests/xfs/361                          |   2 +-
 tests/xfs/362                          |   2 +-
 tests/xfs/363                          |   2 +-
 tests/xfs/364                          |   2 +-
 tests/xfs/365                          |   2 +-
 tests/xfs/366                          |   2 +-
 tests/xfs/367                          |   2 +-
 tests/xfs/368                          |   2 +-
 tests/xfs/369                          |   2 +-
 tests/xfs/370                          |   2 +-
 tests/xfs/371                          |   2 +-
 tests/xfs/372                          |   2 +-
 tests/xfs/373                          |   2 +-
 tests/xfs/374                          |   2 +-
 tests/xfs/375                          |   2 +-
 tests/xfs/376                          |   2 +-
 tests/xfs/377                          |   2 +-
 tests/xfs/378                          |   2 +-
 tests/xfs/379                          |   2 +-
 tests/xfs/380                          |   2 +-
 tests/xfs/381                          |   2 +-
 tests/xfs/382                          |   2 +-
 tests/xfs/383                          |   2 +-
 tests/xfs/384                          |   2 +-
 tests/xfs/385                          |   2 +-
 tests/xfs/386                          |   2 +-
 tests/xfs/387                          |   2 +-
 tests/xfs/388                          |   2 +-
 tests/xfs/389                          |   2 +-
 tests/xfs/390                          |   2 +-
 tests/xfs/391                          |   2 +-
 tests/xfs/392                          |   2 +-
 tests/xfs/393                          |   2 +-
 tests/xfs/394                          |   2 +-
 tests/xfs/395                          |   2 +-
 tests/xfs/396                          |   2 +-
 tests/xfs/397                          |   2 +-
 tests/xfs/398                          |   2 +-
 tests/xfs/399                          |   2 +-
 tests/xfs/400                          |   2 +-
 tests/xfs/401                          |   2 +-
 tests/xfs/402                          |   2 +-
 tests/xfs/403                          |   2 +-
 tests/xfs/404                          |   2 +-
 tests/xfs/405                          |   2 +-
 tests/xfs/406                          |   8 +-
 tests/xfs/407                          |   8 +-
 tests/xfs/408                          |   9 +-
 tests/xfs/409                          |   9 +-
 tests/xfs/410                          |   2 +-
 tests/xfs/411                          |   2 +-
 tests/xfs/412                          |   2 +-
 tests/xfs/413                          |   2 +-
 tests/xfs/414                          |   2 +-
 tests/xfs/415                          |   2 +-
 tests/xfs/416                          |   2 +-
 tests/xfs/417                          |   2 +-
 tests/xfs/418                          |   2 +-
 tests/xfs/422                          |   2 +-
 tests/xfs/423                          |   2 +-
 tests/xfs/425                          |   7 +-
 tests/xfs/426                          |   7 +-
 tests/xfs/427                          |   7 +-
 tests/xfs/428                          |   7 +-
 tests/xfs/429                          |   7 +-
 tests/xfs/430                          |   7 +-
 tests/xfs/434                          |   1 +
 tests/xfs/435                          |   1 +
 tests/xfs/440                          |   3 +
 tests/xfs/441                          |   1 +
 tests/xfs/442                          |   1 +
 tests/xfs/443                          |   9 +-
 tests/xfs/449                          |   6 +-
 tests/xfs/453                          |   2 +-
 tests/xfs/454                          |   2 +-
 tests/xfs/455                          |   2 +-
 tests/xfs/456                          |   2 +-
 tests/xfs/457                          |   2 +-
 tests/xfs/458                          |   2 +-
 tests/xfs/459                          |   2 +-
 tests/xfs/460                          |   2 +-
 tests/xfs/461                          |   2 +-
 tests/xfs/462                          |   2 +-
 tests/xfs/463                          |   2 +-
 tests/xfs/464                          |   2 +-
 tests/xfs/465                          |   2 +-
 tests/xfs/466                          |   2 +-
 tests/xfs/467                          |   2 +-
 tests/xfs/468                          |   2 +-
 tests/xfs/469                          |   2 +-
 tests/xfs/470                          |   2 +-
 tests/xfs/471                          |   2 +-
 tests/xfs/472                          |   2 +-
 tests/xfs/473                          |   2 +-
 tests/xfs/474                          |   2 +-
 tests/xfs/475                          |   2 +-
 tests/xfs/476                          |   2 +-
 tests/xfs/477                          |   2 +-
 tests/xfs/478                          |   2 +-
 tests/xfs/479                          |   2 +-
 tests/xfs/480                          |   2 +-
 tests/xfs/481                          |   8 +-
 tests/xfs/482                          |   9 +-
 tests/xfs/483                          |   2 +-
 tests/xfs/484                          |   2 +-
 tests/xfs/485                          |   2 +-
 tests/xfs/486                          |   2 +-
 tests/xfs/487                          |   7 +-
 tests/xfs/488                          |   7 +-
 tests/xfs/489                          |   7 +-
 tests/xfs/496                          |   2 +-
 tests/xfs/497                          |   2 +-
 tests/xfs/498                          |   2 +-
 tests/xfs/508                          |   2 +
 tests/xfs/509                          |  23 ++-
 tests/xfs/511                          |  10 +-
 tests/xfs/529                          |   5 +-
 tests/xfs/530                          |   6 +-
 tests/xfs/556                          |  16 +-
 tests/xfs/561                          |   2 +-
 tests/xfs/562                          |   2 +-
 tests/xfs/563                          |   2 +-
 tests/xfs/564                          |   2 +-
 tests/xfs/565                          |   2 +-
 tests/xfs/566                          |   2 +-
 tests/xfs/570                          |   2 +-
 tests/xfs/571                          |   2 +-
 tests/xfs/572                          |   2 +-
 tests/xfs/573                          |   2 +-
 tests/xfs/574                          |   2 +-
 tests/xfs/575                          |   2 +-
 tests/xfs/576                          |   2 +-
 tests/xfs/577                          |   2 +-
 tests/xfs/578                          |   2 +-
 tests/xfs/579                          |   2 +-
 tests/xfs/580                          |   2 +-
 tests/xfs/581                          |  11 +-
 tests/xfs/582                          |  16 +-
 tests/xfs/583                          |   2 +-
 tests/xfs/584                          |   2 +-
 tests/xfs/585                          |   2 +-
 tests/xfs/586                          |   2 +-
 tests/xfs/587                          |   2 +-
 tests/xfs/588                          |   2 +-
 tests/xfs/589                          |   2 +-
 tests/xfs/590                          |   2 +-
 tests/xfs/591                          |   2 +-
 tests/xfs/592                          |   2 +-
 tests/xfs/593                          |   2 +-
 tests/xfs/594                          |   2 +-
 tests/xfs/595                          |   2 +-
 tests/xfs/621                          |   2 +-
 tests/xfs/622                          |   2 +-
 tests/xfs/628                          |   2 +-
 tests/xfs/708                          |   2 +-
 tests/xfs/709                          |   2 +-
 tests/xfs/710                          |   2 +-
 tests/xfs/711                          |   2 +-
 tests/xfs/712                          |   2 +-
 tests/xfs/713                          |   2 +-
 tests/xfs/714                          |   2 +-
 tests/xfs/715                          |   2 +-
 tests/xfs/717                          |   2 +-
 tests/xfs/718                          |   2 +-
 tests/xfs/719                          |   2 +-
 tests/xfs/720                          |   7 +-
 tests/xfs/721                          |   2 +-
 tests/xfs/722                          |   2 +-
 tests/xfs/723                          |   2 +-
 tests/xfs/724                          |   2 +-
 tests/xfs/725                          |   2 +-
 tests/xfs/726                          |   2 +-
 tests/xfs/727                          |   2 +-
 tests/xfs/728                          |   2 +-
 tests/xfs/729                          |   2 +-
 tests/xfs/730                          |   2 +-
 tests/xfs/731                          |   2 +-
 tests/xfs/733                          |   2 +-
 tests/xfs/734                          |   2 +-
 tests/xfs/735                          |   2 +-
 tests/xfs/736                          |   2 +-
 tests/xfs/737                          |   2 +-
 tests/xfs/738                          |   2 +-
 tests/xfs/739                          |  11 +-
 tests/xfs/740                          |  11 +-
 tests/xfs/741                          |  11 +-
 tests/xfs/742                          |  11 +-
 tests/xfs/743                          |  11 +-
 tests/xfs/744                          |  11 +-
 tests/xfs/745                          |  11 +-
 tests/xfs/746                          |  11 +-
 tests/xfs/747                          |   2 +-
 tests/xfs/748                          |   2 +-
 tests/xfs/749                          |   2 +-
 tests/xfs/750                          |   2 +-
 tests/xfs/751                          |   2 +-
 tests/xfs/752                          |   2 +-
 tests/xfs/753                          |   2 +-
 tests/xfs/754                          |   2 +-
 tests/xfs/755                          |   2 +-
 tests/xfs/756                          |   2 +-
 tests/xfs/757                          |   2 +-
 tests/xfs/758                          |   2 +-
 tests/xfs/759                          |   2 +-
 tests/xfs/760                          |   2 +-
 tests/xfs/761                          |   2 +-
 tests/xfs/762                          |   2 +-
 tests/xfs/763                          |   2 +-
 tests/xfs/764                          |   2 +-
 tests/xfs/765                          |   2 +-
 tests/xfs/766                          |   2 +-
 tests/xfs/767                          |   2 +-
 tests/xfs/768                          |   2 +-
 tests/xfs/769                          |   2 +-
 tests/xfs/770                          |   2 +-
 tests/xfs/771                          |   2 +-
 tests/xfs/772                          |   2 +-
 tests/xfs/773                          |   2 +-
 tests/xfs/774                          |   2 +-
 tests/xfs/775                          |   2 +-
 tests/xfs/776                          |   2 +-
 tests/xfs/777                          |   2 +-
 tests/xfs/778                          |   2 +-
 tests/xfs/779                          |   7 +-
 tests/xfs/780                          |   7 +-
 tests/xfs/781                          |   7 +-
 tests/xfs/782                          |   2 +-
 tests/xfs/783                          |   2 +-
 tests/xfs/784                          |   2 +-
 tests/xfs/785                          |   2 +-
 tests/xfs/786                          |   2 +-
 tests/xfs/787                          |   2 +-
 tests/xfs/788                          |   2 +-
 tests/xfs/793                          |  16 +-
 tests/xfs/794                          |   2 +-
 tests/xfs/795                          |   2 +-
 tests/xfs/796                          |   2 +-
 tests/xfs/797                          |   2 +-
 tests/xfs/799                          |   2 +-
 tests/xfs/800                          |   2 +-
 tests/xfs/801                          |   2 +-
 tests/xfs/807                          |  34 ++++
 tests/xfs/807.out                      |   4 +
 tests/xfs/808                          |  34 ++++
 tests/xfs/808.out                      |   4 +
 tests/xfs/809                          |  34 ++++
 tests/xfs/809.out                      |   4 +
 tests/xfs/810                          |  35 ++++
 tests/xfs/810.out                      |   4 +
 tests/xfs/811                          |  34 ++++
 tests/xfs/811.out                      |   4 +
 tests/xfs/812                          |  34 ++++
 tests/xfs/812.out                      |   4 +
 tests/xfs/813                          |  34 ++++
 tests/xfs/813.out                      |   4 +
 tests/xfs/814                          |  35 ++++
 tests/xfs/814.out                      |   4 +
 tests/xfs/815                          |  66 ++++++
 tests/xfs/815.out                      |   2 +
 tests/xfs/816                          |  67 ++++++
 tests/xfs/816.out                      |   2 +
 tests/xfs/817                          | 119 +++++++++++
 tests/xfs/817.out                      |  19 ++
 tests/xfs/818                          | 115 +++++++++++
 tests/xfs/818.out                      |   4 +
 tests/xfs/819                          | 146 ++++++++++++++
 tests/xfs/819.out                      | 102 ++++++++++
 tests/xfs/820                          | 128 ++++++++++++
 tests/xfs/820.out                      | 147 ++++++++++++++
 tests/xfs/821                          | 174 ++++++++++++++++
 tests/xfs/821.out                      |  47 +++++
 tests/xfs/822                          |  39 ++++
 tests/xfs/822.out                      |   2 +
 tests/xfs/823                          |  45 +++++
 tests/xfs/823.out                      |   2 +
 tests/xfs/824                          |  39 ++++
 tests/xfs/824.out                      |   2 +
 tests/xfs/825                          |  38 ++++
 tests/xfs/825.out                      |   4 +
 tests/xfs/826                          |  37 ++++
 tests/xfs/826.out                      |   4 +
 tests/xfs/827                          |  38 ++++
 tests/xfs/827.out                      |   4 +
 tests/xfs/828                          |  38 ++++
 tests/xfs/828.out                      |   4 +
 tests/xfs/829                          |  38 ++++
 tests/xfs/829.out                      |   4 +
 tests/xfs/830                          |  39 ++++
 tests/xfs/830.out                      |   4 +
 tests/xfs/831                          |  38 ++++
 tests/xfs/831.out                      |   4 +
 tests/xfs/832                          |  37 ++++
 tests/xfs/832.out                      |   4 +
 tests/xfs/833                          |  37 ++++
 tests/xfs/833.out                      |   4 +
 tests/xfs/834                          |  38 ++++
 tests/xfs/834.out                      |   4 +
 tests/xfs/835                          |  40 ++++
 tests/xfs/835.out                      |   2 +
 tests/xfs/836                          |  40 ++++
 tests/xfs/836.out                      |   2 +
 tools/run_privatens                    |   8 +-
 417 files changed, 3757 insertions(+), 756 deletions(-)
--
Zorro Lang
zlang@kernel.org

--oqZrnvIIMMDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmfNnEAACgkQlNbPkfr2
tMwV+Q/7B6wCVgv1/OpMJQ1GonEsWZEWF2hK3hWdTFEgtdCs17x9JYgYkjzfA1kR
PSNEtX081Zp0o5I9dEP69zi//Vv+B5uZ8wozrvcWQBY+8ceCgtRxT/Zjrg46cvVo
EQMoywMlAXxBH9UiLncgILlR37jTuEGrjlsXH26BlW15BNN3IVDh3WSRKbYhu2iT
XpZDZLQwPufn9n0pGLjHLVfPuUmBXSaYuj2oY7nojrsufULkQNSsTefE5YFvcLQ5
us2JiZySzWAKbQUMmagBcNqRel5o1vlkLfON69C5s5MDDIVUKalGcQKLxtfAEAzN
KLsxAvqTCw0QasXSI6+TCo73JD/Q7YYYlmElw9v9kUS8DirPn/YpCoZNnHy7QIBd
80Sp2l8C/T7neRvG8q9+sC73YiuqICLoVnZ/Xq85lkraMjHYHu/I3t4Hw5DK/GJO
WpKgKdq1+aH9RcyNG+3E5JprDq/vHSJuSNpTjQEJOAxtY2YDHHU+i936zbKy9zwO
Zu3WNip+6ln+JRWx7ow5G3+/tY8dLOKDnajaXgLnlv318ARMxY2ZjUWn3VkUn12b
cJwXWLJQudgNq/NnCBx6GjcyMYIBEMigBrHoNBItGbZiAJH5RwFU2+507+0sfFnO
nmCu1Wru0+egjRZZiS6ppXV8BxWmRQit2nMeT0ndEvojycitlUY=
=uYI8
-----END PGP SIGNATURE-----

--oqZrnvIIMMDF--
