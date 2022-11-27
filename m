Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54886C4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Nov 2022 13:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK0N0t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Nov 2022 08:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiK0N0s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Nov 2022 08:26:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4459FD19
        for <fstests@vger.kernel.org>; Sun, 27 Nov 2022 05:26:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36A48B80AF9
        for <fstests@vger.kernel.org>; Sun, 27 Nov 2022 13:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3B8C433D6;
        Sun, 27 Nov 2022 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669555602;
        bh=mT0GgnVhS+eK+Qdx0WG+4NbCm67hbYvSYQzAC2F+qJY=;
        h=Date:From:To:Subject:From;
        b=qsCwaIwKW9PMK3iYqXi2CczOfWhkeCc/lHO/rR6lHc2iI/5AHDfslbBNLtmnwKsX4
         8qt/kQoIb/YzEgqdXa/Uy4LCf9LJQARI0JWVwZxkz4DJRBrE5Qp7CV0akNnsaZThXe
         k5cDfkNDzokFaYOZ64XbMbTOK6gyTzbCzBVjBDTPVXu+qsdZh+BDKU7Rgjby4uKE7N
         92Gi5o4ZsD0zUhDVDC3Jo+C3Vyp95rNHFKp5zlnsPcSuEllAbqUn441fOPlv2Qjozg
         L4C49Kx3gNq0iHN6AuWWD8I/Q9ERp9slq9r0OZn4hHbDlH7eBLUGX0+5ExSIJ8vViY
         6r6y5vu9wAynw==
Date:   Sun, 27 Nov 2022 21:26:39 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 1e8502082ca9
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yoIMGx0ICOqj"
Content-Disposition: inline
Message-Id: <20221127132642.5A3B8C433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--yoIMGx0ICOqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.11.27 release.

Release note:
1) There're 3 new cases this week -- generic/703, generic/704 and generic/705.
2) Fix some failures on latest btrfs-progs
3) g/470 can work with dax now.
4) Update many case's groups to match the xfs_io command they use.

Thanks for all your contribution! More details as below.

Thanks,
Zorro

The new head of the for-next branch is commit:

1e8502082ca9 generic/614: Run test only for filesystems supporting delalloc

New commits ([N]ew, [U]pdate):

Filipe Manana (4):
[N]      [be20e5f491e0] generic: check direct IO writes with io_uring and O_DSYNC are durable
[U]      [7e0d5f6a4436] btrfs/003: fix failure on new btrfs-progs versions
[U]      [0d044155ff76] btrfs/053: fix test failure when running with btrfs-progs v6.0+
[U]      [d6deed033681] btrfs: fix failure of tests that use defrag on btrfs-progs v6.0+

Jan Kara (1):
[U]      [1e8502082ca9] generic/614: Run test only for filesystems supporting delalloc

Luís Henriques (1):
[U]      [4c02b231b514] ceph/005: skip test if using "test_dummy_encryption"

Qu Wenruo (1):
[U]      [4b480aae3ed1] fstests: filter.btrfs: handle detailed missing device report better

Xiao Yang (2):
[U]      [da2e198c3fa5] common/dmlogwrites: Extend _log_writes_init() to accept the specified length
[U]      [98729caa07c9] generic/470: Replace thin volume with blkdiscard -z

Zorro Lang (3):
[N]      [b4feba30c81c] generic: check logical-sector sized O_DIRECT
[N]      [eae34184a70d] generic: shutdown might leave NULL files with nonzero di_size
[U]      [acd67f0b2c5f] fstests: update group name according to xfs_io command requirement


Code Diffstat:

 common/dmlogwrites    |  18 ++++++++-
 common/filter.btrfs   |  13 ++++++-
 tests/btrfs/003       |   5 ++-
 tests/btrfs/013       |   2 +-
 tests/btrfs/016       |   2 +-
 tests/btrfs/021       |   4 +-
 tests/btrfs/025       |   2 +-
 tests/btrfs/034       |   2 +-
 tests/btrfs/037       |   2 +-
 tests/btrfs/046       |   2 +-
 tests/btrfs/053       |   4 +-
 tests/btrfs/079       |   2 +-
 tests/btrfs/095       |   2 +-
 tests/btrfs/112       |   2 +-
 tests/btrfs/153       |   2 +-
 tests/btrfs/169       |   2 +-
 tests/btrfs/170       |   2 +-
 tests/btrfs/180       |   2 +-
 tests/btrfs/193       |   2 +-
 tests/btrfs/205       |   2 +-
 tests/btrfs/206       |   2 +-
 tests/btrfs/256       |   4 +-
 tests/btrfs/290       |   2 +-
 tests/ceph/005        |   1 +
 tests/ext4/009        |   2 +-
 tests/ext4/015        |   2 +-
 tests/ext4/034        |   2 +-
 tests/ext4/054        |   2 +-
 tests/ext4/307        |   2 +-
 tests/f2fs/001        |   2 +-
 tests/generic/032     |   2 +-
 tests/generic/038     |   2 +-
 tests/generic/042     |   2 +-
 tests/generic/103     |   2 +-
 tests/generic/137     |   2 +-
 tests/generic/144     |   2 +-
 tests/generic/145     |   2 +-
 tests/generic/156     |   2 +-
 tests/generic/186     |   2 +-
 tests/generic/187     |   2 +-
 tests/generic/188     |   2 +-
 tests/generic/189     |   2 +-
 tests/generic/190     |   2 +-
 tests/generic/191     |   2 +-
 tests/generic/194     |   2 +-
 tests/generic/195     |   2 +-
 tests/generic/196     |   2 +-
 tests/generic/197     |   2 +-
 tests/generic/199     |   2 +-
 tests/generic/200     |   2 +-
 tests/generic/201     |   2 +-
 tests/generic/216     |   2 +-
 tests/generic/217     |   2 +-
 tests/generic/218     |   2 +-
 tests/generic/220     |   2 +-
 tests/generic/222     |   2 +-
 tests/generic/223     |   2 +-
 tests/generic/227     |   2 +-
 tests/generic/229     |   2 +-
 tests/generic/238     |   2 +-
 tests/generic/264     |   2 +-
 tests/generic/284     |   2 +-
 tests/generic/286     |   2 +-
 tests/generic/287     |   2 +-
 tests/generic/289     |   2 +-
 tests/generic/290     |   2 +-
 tests/generic/291     |   2 +-
 tests/generic/292     |   2 +-
 tests/generic/293     |   2 +-
 tests/generic/295     |   2 +-
 tests/generic/299     |   2 +-
 tests/generic/311     |   2 +-
 tests/generic/324     |   2 +-
 tests/generic/351     |   2 +-
 tests/generic/372     |   2 +-
 tests/generic/391     |   2 +-
 tests/generic/404     |   2 +-
 tests/generic/413     |   2 +-
 tests/generic/414     |   2 +-
 tests/generic/422     |   2 +-
 tests/generic/468     |   2 +-
 tests/generic/469     |   2 +-
 tests/generic/470     |  34 ++++++++---------
 tests/generic/483     |   2 +-
 tests/generic/485     |   2 +-
 tests/generic/499     |   2 +-
 tests/generic/503     |   2 +-
 tests/generic/511     |   2 +-
 tests/generic/515     |   2 +-
 tests/generic/540     |   2 +-
 tests/generic/541     |   2 +-
 tests/generic/542     |   2 +-
 tests/generic/543     |   2 +-
 tests/generic/546     |   2 +-
 tests/generic/605     |   2 +-
 tests/generic/610     |   2 +-
 tests/generic/614     |   1 +
 tests/generic/619     |   2 +-
 tests/generic/627     |   2 +-
 tests/generic/641     |   2 +-
 tests/generic/649     |   2 +-
 tests/generic/652     |   2 +-
 tests/generic/653     |   2 +-
 tests/generic/654     |   2 +-
 tests/generic/655     |   2 +-
 tests/generic/658     |   2 +-
 tests/generic/659     |   2 +-
 tests/generic/660     |   2 +-
 tests/generic/661     |   2 +-
 tests/generic/662     |   2 +-
 tests/generic/663     |   2 +-
 tests/generic/664     |   2 +-
 tests/generic/665     |   2 +-
 tests/generic/666     |   2 +-
 tests/generic/667     |   2 +-
 tests/generic/668     |   2 +-
 tests/generic/669     |   2 +-
 tests/generic/674     |   2 +-
 tests/generic/683     |   2 +-
 tests/generic/684     |   2 +-
 tests/generic/685     |   2 +-
 tests/generic/686     |   2 +-
 tests/generic/687     |   2 +-
 tests/generic/703     | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/703.out |   2 +
 tests/generic/704     |  52 +++++++++++++++++++++++++
 tests/generic/704.out |   6 +++
 tests/generic/705     |  45 ++++++++++++++++++++++
 tests/generic/705.out |   5 +++
 tests/overlay/060     |   2 +-
 tests/xfs/014         |   2 +-
 tests/xfs/042         |   2 +-
 tests/xfs/076         |   2 +-
 tests/xfs/084         |   2 +-
 tests/xfs/114         |   2 +-
 tests/xfs/118         |   2 +-
 tests/xfs/128         |   2 +-
 tests/xfs/166         |   2 +-
 tests/xfs/167         |   2 +-
 tests/xfs/176         |   2 +-
 tests/xfs/184         |   2 +-
 tests/xfs/185         |   2 +-
 tests/xfs/187         |   2 +-
 tests/xfs/192         |   2 +-
 tests/xfs/200         |   2 +-
 tests/xfs/204         |   2 +-
 tests/xfs/215         |   2 +-
 tests/xfs/218         |   2 +-
 tests/xfs/219         |   2 +-
 tests/xfs/221         |   2 +-
 tests/xfs/223         |   2 +-
 tests/xfs/224         |   2 +-
 tests/xfs/225         |   2 +-
 tests/xfs/226         |   2 +-
 tests/xfs/228         |   2 +-
 tests/xfs/230         |   2 +-
 tests/xfs/231         |   2 +-
 tests/xfs/232         |   2 +-
 tests/xfs/243         |   2 +-
 tests/xfs/245         |   2 +-
 tests/xfs/248         |   2 +-
 tests/xfs/249         |   2 +-
 tests/xfs/251         |   2 +-
 tests/xfs/254         |   2 +-
 tests/xfs/255         |   2 +-
 tests/xfs/256         |   2 +-
 tests/xfs/257         |   2 +-
 tests/xfs/258         |   2 +-
 tests/xfs/280         |   2 +-
 tests/xfs/294         |   2 +-
 tests/xfs/310         |   2 +-
 tests/xfs/312         |   2 +-
 tests/xfs/313         |   2 +-
 tests/xfs/316         |   2 +-
 tests/xfs/324         |   2 +-
 tests/xfs/326         |   2 +-
 tests/xfs/328         |   2 +-
 tests/xfs/330         |   2 +-
 tests/xfs/331         |   2 +-
 tests/xfs/332         |   2 +-
 tests/xfs/335         |   2 +-
 tests/xfs/336         |   2 +-
 tests/xfs/337         |   2 +-
 tests/xfs/341         |   2 +-
 tests/xfs/342         |   2 +-
 tests/xfs/343         |   2 +-
 tests/xfs/344         |   2 +-
 tests/xfs/345         |   2 +-
 tests/xfs/346         |   2 +-
 tests/xfs/347         |   2 +-
 tests/xfs/423         |   2 +-
 tests/xfs/443         |   2 +-
 tests/xfs/444         |   2 +-
 tests/xfs/445         |   2 +-
 tests/xfs/450         |   2 +-
 tests/xfs/513         |   2 +-
 tests/xfs/528         |   2 +-
 tests/xfs/529         |   2 +-
 tests/xfs/534         |   2 +-
 tests/xfs/535         |   2 +-
 tests/xfs/537         |   2 +-
 tests/xfs/545         |   2 +-
 tests/xfs/554         |   2 +-
 203 files changed, 457 insertions(+), 216 deletions(-)
--
Zorro Lang
zlang@kernel.org

--yoIMGx0ICOqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmODZWYACgkQlNbPkfr2
tMxsRA/+NY+73D6IQfrh9eL7iqyjX48q/ZQJQS188nkX2Bv7kNLZEjTvlutHlPOK
w3V6y3oT7FqlOMUtgzxHuvNgm5myK6AFwJiJJUIynnWGBtdEcONkT/50YwDPG17r
lMeCFCnWKIFJQJrfnxQw7vu7QHjVujxLKEOTFxq2VLCvnBwy0NIELwQtSu/M+pEh
RAl1BJ2lyeogwfiCM7vZDKdi4F4tjhPj3tJtFQPTNooIA/iUtqxOHGJn/EbbuohW
S04wjm2sLKIYLAe8usE9IiU3bJGtLN1tvmZciFMqsd08LJ5DRZ2525YTnIoVXq0F
42lmoUwP0uO/FT66xxMJA+g+wNHqyUJJUghQS334wDgi6NHhJpFXgZibH/4jBefo
2l824tBqtmnaLXNt4NdtMCd245vzXBNC3oYlYBYwjOFd2ByeXIGi6eOtmXpBM3C0
Xt2oAaOpP9+acCp5IiFh2Obn8NxTyhdNEI+C8QLnZZ03jd1lb++DkJ6B92nzgidN
kVtIcS4Ih5e4is8tXv5GKK97tKzPXbcF2TMeFYGKED688rlKVGI3cTADESJrKHKO
Y1beRYyo5X+eggptw/Po47Zj63v7iKJbdEd8Txw/RoLO0Amhi2ID+P0CHQiS4FDy
GczX/azxca53KxIjEI+lHlxd7tJ7DXVT1RJLCu2rzrrqJtsTm18=
=HXyO
-----END PGP SIGNATURE-----

--yoIMGx0ICOqj--
