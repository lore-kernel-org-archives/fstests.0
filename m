Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62F3C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 15 May 2022 04:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiEOE4c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 May 2022 00:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiEOE4O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 May 2022 00:56:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6844112776
        for <fstests@vger.kernel.org>; Sat, 14 May 2022 21:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE8B60E86
        for <fstests@vger.kernel.org>; Sun, 15 May 2022 04:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F92BC385B8;
        Sun, 15 May 2022 04:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652590567;
        bh=XHRFU+0gfkf/gTAMIimnCULm9u7qYv91aRtYuE63N2Y=;
        h=Date:From:To:Subject:From;
        b=mkQmTQa0BeL9W3SxBjFUiL8Suci7p0FI8PoQs1RDEX3o4LxX8E2dJJFakU6Fh+Shs
         laQ8IlFIwecMx744YQS+H/2Zuq5Wzc3GmAoi1HJwMCuieFJkklhBpPkr1L41Jiln0E
         ngMTuuvdNAWQw/jTS7n4FFrm7Ogg+P+915xLbETqgrkd9BM1eD9ctggJFgZGX11idV
         ExzLGyoBxooWx9Jo4WRMW8nIy5wdCvWQHkAIj6T9xiynEh1u9sITpqXLhHDIRs8CbX
         ZhiCTCq6CScW6nYX5CC12YBrRECvoO+B5DD19FPjgnuMrQmUWcvu867we/sgjsR8z+
         zUBrC/LyR6rwg==
Date:   Sun, 15 May 2022 12:56:04 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merged v2022.05.08 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WlVRYLJpnwkt"
Content-Disposition: inline
Message-Id: <20220515045607.4F92BC385B8@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--WlVRYLJpnwkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.05.08 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

87cf32ad3fa2 idmapped-mounts: Add open with O_TMPFILE operation in setgid test

New commits:

Amir Goldstein (2):
      [6ee5ffa079b9] common: support black listing fs in _supported_fs()
      [28c52b15c6e2] common: print hints for reasons of test failures

Chandan Babu R (1):
      [9ae10c882550] xfs/533: Delete test since directory's extent count can never overflow

Dave Chinner (1):
      [441606d28681] fstests: faster group file creation

Yang Xu (3):
      [6ac390bb605b] idmapped-mounts: Reset errno to zero before run_test
      [5328ab947ff4] idmapped-mounts: Add mknodat operation in setgid test
      [87cf32ad3fa2] idmapped-mounts: Add open with O_TMPFILE operation in setgid test


Code Diffstat:

 check                                 |  10 +-
 common/preamble                       |  30 +--
 common/rc                             |  57 +++++-
 src/idmapped-mounts/idmapped-mounts.c | 369 +++++++++++++++++++++++++++++++++-
 tests/generic/500                     |   3 +-
 tests/generic/631                     |   3 +-
 tests/generic/679                     |   3 +-
 tests/overlay/009                     |   3 +
 tests/overlay/010                     |   3 +
 tests/overlay/014                     |   2 +
 tests/overlay/016                     |   4 +-
 tests/overlay/017                     |   4 +-
 tests/overlay/018                     |   4 +-
 tests/overlay/020                     |   3 +
 tests/overlay/022                     |   2 +
 tests/overlay/029                     |   2 +
 tests/overlay/038                     |   2 +
 tests/overlay/041                     |   2 +
 tests/overlay/042                     |   3 +
 tests/overlay/043                     |   4 +-
 tests/overlay/044                     |   4 +-
 tests/overlay/054                     |   3 +
 tests/overlay/055                     |   3 +
 tests/overlay/063                     |   3 +
 tests/overlay/065                     |   4 +
 tests/overlay/067                     |   3 +
 tests/overlay/070                     |   4 +-
 tests/overlay/071                     |   4 +-
 tests/overlay/072                     |   2 +
 tests/overlay/074                     |   5 +
 tests/overlay/077                     |   5 +
 tests/overlay/078                     |   1 +
 tests/xfs/533                         | 170 ----------------
 tests/xfs/533.out                     |  17 --
 tools/mkgroupfile                     |  66 ++++--
 35 files changed, 541 insertions(+), 266 deletions(-)
--
Zorro Lang
zlang@kernel.org

--WlVRYLJpnwkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKAh4QACgkQlNbPkfr2
tMz7AQ//YY/T3y1e5ZbX8YTSzTMj5XEBkrqxMj7x4kxXKb2qb5u0/mpE//bMlhee
XrWFd5tof+H/379XsPKEzp/26NF81XOfAk+JXMZbx9OUj/xdRPvSSVLwgBFgZFrM
zzIlcLF+EOLuWU5nzBZoA08FiFRU6AsLPoap2NdHCBDYVnJ/dtIYQVzxrcmm7odx
97g7boXJig9VJQgoU4EAafkatWJhZ1b6VXL77mOaxewT+3+ORHGzGw5BPLhytt4m
1KVeUxCybjRSJ8DdEgsFMC2EoBRgJsWeGShUAZ6seKgGKKiPb4GfcnId0e4n0bm/
P/Kg+KnMizimhdQtQJP8HQ/08QtgYRAyeWFw2Ws6dGV9pEkymQq4pBY17YuAUCod
hSca06t+aJhSYtNW2C53kjV2nZkpIfIoG4rrH4Q/TyGBwsvgH1sRQEgSFo0c4wHi
Fz3pngEkT1tEmNzBrPjhGm1Ygg+oXcUjo0A35z4jmerSqEpy25QcT246kgFseEyS
xRCx/oeTVttG+8XIhn45JKGTmIemZeqkmZT7YktFt2OqrN0wiWheQGpqIsagVJWU
OMHbvI/9h93IVrALm0G9eLe3S2kMCzjLPEiEv4xkIkZK7QvwAWTVUyRmM4iJtZbT
lxWhRmuhMCd8Oc2IVIOqe5oVFsz7Z9geFdUbhjDZl8Df4kB7ZY0=
=7mtl
-----END PGP SIGNATURE-----

--WlVRYLJpnwkt--
