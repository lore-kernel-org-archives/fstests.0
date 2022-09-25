Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EACC04A95
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Sep 2022 12:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiIYMZg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Sep 2022 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIYMZf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Sep 2022 08:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3471E70E
        for <fstests@vger.kernel.org>; Sun, 25 Sep 2022 05:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2526961507
        for <fstests@vger.kernel.org>; Sun, 25 Sep 2022 12:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F331C433C1;
        Sun, 25 Sep 2022 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664108733;
        bh=wjF+IejKUNBYJ4rk9VyzsdDK/vVsMS12RiHy1JOFgOg=;
        h=Date:From:To:Subject:From;
        b=qtyDgapYcr+23AL3/HveLjOBSnUJcUDrccou7p/skyR4DkzliVbspb27vKFkuE3eM
         O6bVMyCQV5dt08atcAHA8/Jg0rYe7urdSt+ySYThSp5JyWRFw5hArXOIte2YKkojXn
         j6Uz3y1qiIlpjy+DVJ0qdNoBtMC66Sa8XuERr3e4sGhB2kB2lHmrelkIcfFDIrpD73
         9C2PC1bZQLwckm1aY6joSc5vM+lFAMsVvecmA+bw4/uLu5l1LaG/pbJgAL+AJFNb70
         9JGxN/X93+tmEImXfmqrM8gdaLDqZV9xTLnZEfIc1i/R+9ckfkK2dgpVdBZFb2ST39
         lYRdYU0L4tD0w==
Date:   Sun, 25 Sep 2022 20:25:30 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to e5555e75ba19
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="85f3JyvCcUpH"
Content-Disposition: inline
Message-Id: <20220925122533.2F331C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--85f3JyvCcUpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.09.25 release.

Release notes:
1) There're 6 new cases in this release, include g/698, g/699, g/700, g/701,
   btrfs/274 and btrfs/275. They're all for known and fixed linux issues,
   so might fail on old downstream kernel, but generally won't break downstream
   testing by kernel hang/panic.

2) egrep and fgrep is deprecated, latest grep package start to print a warning
   about that. Thanks xzhou@ changes all egrep/fgrep to grep -E/-F in fstests.
   From now on, please don't use egrep and fgrep in fstests, if you have patches
   are using them, please replace with grep -E/-F.

Thanks all your contribution! More details as below.

Thanks,
Zorro

The new head of the for-next branch is commit:

e5555e75ba19 btrfs: test xattr changes for RO btrfs property

New commits:

Christian Brauner (3):
[U]      [7c7a73c43be8] idmapped-mounts: account for EOVERFLOW
[N]      [c343488d82d4] generic: basic group ownership changing test
[N]      [b7adca6f6676] generic: overlay group ownership changing test

Filipe Manana (1):
[N]      [a945da31e759] btrfs: test that we can not delete a subvolume with an active swap file

Goldwyn Rodrigues (1):
[N]      [e5555e75ba19] btrfs: test xattr changes for RO btrfs property

Murphy Zhou (2):
[U]      [1cbaf24e0cc8] egrep, fgrep: deprecated
[U]      [9a5559da1af7] common/quota: fix grep pattern

Pavel Reichl (3):
[U]      [e635c29e187d] ext4/044: Add missing check for return value
[U]      [9fd20429c9ce] common: new helper to alloacate fixed size files
[N]      [ce77f0422ae8] generic: test i_blocks for truncated large files

Qu Wenruo (1):
[U]      [42cc53859ca1] btrfs/253: update the data chunk size to the correct one

Zorro Lang (1):
[N]      [033a68a98684] generic: new test to verify selinux label of whiteout inode


Code Diffstat:

 check                     |   2 +-
 common/btrfs              |   4 +-
 common/dmlogwrites        |   2 +-
 common/dump               |   4 +-
 common/encrypt            |   4 +-
 common/filter             |   2 +-
 common/fuzzy              |   6 +-
 common/populate           |   2 +-
 common/quota              |  10 +--
 common/rc                 |  59 ++++++++++++-----
 common/repair             |   2 +-
 common/xfs                |  12 ++--
 src/vfs/idmapped-mounts.c |   4 +-
 tests/btrfs/011           |   2 +-
 tests/btrfs/100           |   2 +-
 tests/btrfs/101           |   2 +-
 tests/btrfs/187           |   2 +-
 tests/btrfs/252           |   2 +-
 tests/btrfs/253           |  18 ++++-
 tests/btrfs/274           |  58 +++++++++++++++++
 tests/btrfs/274.out       |   6 ++
 tests/btrfs/275           |  88 +++++++++++++++++++++++++
 tests/btrfs/275.out       |  39 +++++++++++
 tests/ext4/006            |   2 +-
 tests/ext4/044            |   8 +--
 tests/ext4/044.out        |   4 +-
 tests/generic/164         |   2 +-
 tests/generic/165         |   2 +-
 tests/generic/454         |   2 +-
 tests/generic/670         |   2 +-
 tests/generic/694         |   8 ++-
 tests/generic/698         | 117 +++++++++++++++++++++++++++++++++
 tests/generic/698.out     |  19 ++++++
 tests/generic/699         | 163 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/699.out     |  27 ++++++++
 tests/generic/700         |  64 ++++++++++++++++++
 tests/generic/700.out     |   2 +
 tests/generic/701         |  51 +++++++++++++++
 tests/generic/701.out     |   2 +
 tests/xfs/008             |   2 +-
 tests/xfs/012             |   2 +-
 tests/xfs/033             |   2 +-
 tests/xfs/064             |   4 +-
 tests/xfs/065             |   2 +-
 tests/xfs/083             |   2 +-
 tests/xfs/122             |   4 +-
 tests/xfs/138             |   2 +-
 tests/xfs/185             |   2 +-
 tests/xfs/186             |   4 +-
 tests/xfs/293             |   2 +-
 tests/xfs/330             |   2 +-
 tests/xfs/422             |   2 +-
 tests/xfs/499             |   2 +-
 tests/xfs/505             |   2 +-
 tests/xfs/514             |   2 +-
 tests/xfs/515             |   2 +-
 tests/xfs/517             |   2 +-
 tests/xfs/520             |   2 +-
 tests/xfs/530             |   2 +-
 tests/xfs/539             |   2 +-
 60 files changed, 767 insertions(+), 88 deletions(-)
--
Zorro Lang
zlang@kernel.org

--85f3JyvCcUpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmMwSF4ACgkQlNbPkfr2
tMzflA/+JooT4X5A+0CUQ3EDd1rc55peTTvxg8zhi2PebQOVVUfmJSlBajSyK20N
oPSBg6mG3O9m2FXclRdXinzScCatlRDRNUHLQsobXSdmbf7EBtrlRVekDUp2a/V9
p1QwfZKJQWcZUJrpfX5HJ8PPHd5x+iPs2TjLPGlzGLPirMKYlVKy5mUGA89E40jR
INTGHUByZqxtUkHB2J6rWGNth9s43PFK4rnOC58h0Ytc1C/cwhWhJyArcHx7u+io
CIiTzoaFpfowGf6OjCLsp/vRLwW7hfKAGOKYOirpUZqGyV8HbZD9kihGOmWS25H7
HdkchN5FE8yXpmEzYIrnNFBfWFVJji063h2q0HLAukfTYl411ge6DnxGNP8rG776
c3sGyppCO01W2hObOg5JfD4khuTGIAOU5M4Am8Rri5qldUDDOAITxlPdakSTbL3V
TSVbDffh5Kmzy7DDg7kCJ5VYNWkeZXJxg5AALrf42zhGze1MvtXRUY0bcIVLcn/w
gj4Nr42zu4yaR0mqY4MF/O5BB/+QdE7+qFETtIjFzWLJovPpB4pO4IB/QyWLUtov
rVCvJdO3HiK+6Nu+rovcgRptGrRQ+pV9itBWW1/fLdow2yl9ujl0FCuyzYcsbl5v
/M/qdnu9LOBAjlkhode8mO20Y9eUJa4Cx6SpzUPsRPoNn0uFBuQ=
=jys8
-----END PGP SIGNATURE-----

--85f3JyvCcUpH--
