Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9F8C00140
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Aug 2022 14:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiHUO7K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiHUO7D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Aug 2022 10:59:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38B4192AB
        for <fstests@vger.kernel.org>; Sun, 21 Aug 2022 07:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8425BB80D7E
        for <fstests@vger.kernel.org>; Sun, 21 Aug 2022 14:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B31C433D6;
        Sun, 21 Aug 2022 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661093940;
        bh=N4cDSHAC1fM5unH/3v323ljI81w6KEv5paee/oXSDR0=;
        h=Date:From:To:Subject:From;
        b=MZnEjBA+5esRYJZcAcf8iVTMvcLVC2tUwr3veujRvYwj/7VGUuIMKX+3eFE8fl97f
         Va2RNAbyBbEiBUYp0KTjGvtLfQZlh6u3WIXUTajooXmy/i/Q1FxDtRNn+G6xihwtmf
         hPjm2/bI+m09pL8pNpj50wCHZ1ZsZE7JMYKd7bDTjGGUF6HC51x+8LTeCIYGOvtTrQ
         cZjiwIC36E70UJ5RYsaRXl4KZ25fTbfnT4N2TpW4XSGFSLaXPTyouPckR3S9Pz8Meq
         rbZkFf3qQhhLTrUJQqFARMS9HGECgcvtrLkTy0sqUbwEiIm9QRELD2DCnf80BPJoO1
         +c0y8Ms6bgHSw==
Date:   Sun, 21 Aug 2022 22:58:57 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.08.07 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="m6MQM1vNnsc4"
Content-Disposition: inline
Message-Id: <20220821145859.E4B31C433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--m6MQM1vNnsc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.08.07 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

16ddbd1aee29 xfs: add memory failure test for partly-reflinked&dax file

New commits:

Darrick J. Wong (4):
      [437f7742b8f1] xfs/432: fix this test when external devices are in use
      [bbfa39e7a5cf] xfs/291: convert open-coded _scratch_xfs_repair usage
      [b41bf16361fe] xfs/533: fix false negatives for this test
      [78a3ce021ba8] xfs/018: fix LARP testing for small block sizes

Nathan Huckleberry (2):
      [f57ffcf43811] fscrypt-crypt-util: add HCTR2 implementation
      [94e0bda55b36] generic: add tests for fscrypt policies with HCTR2

Shiyang Ruan (3):
      [2eaabb1d38cf] xfs: add memory failure test for dax mode
      [545d6b783773] xfs: add memory failure test for dax&reflink mode
      [16ddbd1aee29] xfs: add memory failure test for partly-reflinked&dax file

Zorro Lang (1):
      [378cf1c48143] fstests: add more dmerror related test cases into eio group


Code Diffstat:

 .gitignore                      |   1 +
 common/encrypt                  |   2 +
 src/Makefile                    |   3 +-
 src/fscrypt-crypt-util.c        | 357 +++++++++++++++++++++++++++++++++-------
 src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++
 tests/generic/484               |   2 +-
 tests/generic/628               |   2 +-
 tests/generic/629               |   2 +-
 tests/generic/693               |  31 ++++
 tests/generic/693.out           |  16 ++
 tests/xfs/018                   |  15 +-
 tests/xfs/018.out               |  43 +----
 tests/xfs/291                   |   6 +-
 tests/xfs/432                   |   3 +-
 tests/xfs/533                   |  10 +-
 tests/xfs/550                   |  50 ++++++
 tests/xfs/550.out               |   9 +
 tests/xfs/551                   |  51 ++++++
 tests/xfs/551.out               |   9 +
 tests/xfs/552                   |  54 ++++++
 tests/xfs/552.out               |   9 +
 21 files changed, 717 insertions(+), 115 deletions(-)
--
Zorro Lang
zlang@kernel.org

--m6MQM1vNnsc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmMCR/gACgkQlNbPkfr2
tMxNHg/+N3N2HyMVIwqi6rxpvDB1EET5seHu8AfoW+PjaL6Sb/DaM9KdJ0T5WZiV
w9lnvlx/hEA/4Y4ECIdMLmZ5zMryFYDuxobrETldTAhngZDW2i8/8bnYyNt/4ZPn
Q5NMdSANGwukmBvHiLNigasY1pKngmdegGVlaKlojoK/xrrD/k5WdTOkZ4ZoWfZr
CH1Mb1LtYrmr281ueYYg5XP09mD6spK69kj6OSlUcy9GAIJUSySEIQaL5qF/u7jX
wqBx0hxiq+xIOXHlDE0vn2pClRBFC7V+HZwhJoxNHQI25ILjnuw58GMkMdnsm/sP
WItFuYKzlzsanyU1b9NH060Ev0ZsdwYJcpq3kw/7V0C8St1T45SmFwOSrVqS4xGg
TBl8NUkhsSTvfoKuFv0BHHFwR2R4B7bksvwVqMj2z4FSsRg96Sg/Hig5zMIaGiJK
wJsS39nkcn6HdkNVXBrW1PZgu305JoZapaLGRYmisNCyAt1ZxcWQoDCK3ncvXDwK
VajjpmES+T7ORfQmtC0OSvRHLBn9KIegAeQ9igpxMdkwm0jHjflPXieAV2AaBPI8
f0TY6zcQJF7GuoD25Wqe0i+l7s/coGv7vq5G6A4yE4NSh9/ixIj7ZGTbLa559EMn
yXJjktLCiRBITLWtDyHcDVJ+eTP2hARjvXFv6Mrr0i1flr7P4sQ=
=W+52
-----END PGP SIGNATURE-----

--m6MQM1vNnsc4--
