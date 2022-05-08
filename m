Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F580C433FE
	for <linux-fstests@archiver.kernel.org>; Sun,  8 May 2022 16:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiEHQFV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 May 2022 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiEHQFU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 May 2022 12:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB15654C
        for <fstests@vger.kernel.org>; Sun,  8 May 2022 09:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB7A611FB
        for <fstests@vger.kernel.org>; Sun,  8 May 2022 16:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA475C385A4;
        Sun,  8 May 2022 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652025689;
        bh=MemGliUC1KuVLumYmZ0P15dgRPmuHl9o1uQPMxhncbY=;
        h=Date:From:To:Subject:From;
        b=kjxNOblw0GHVHNDS9emBS2McO1ANVOX+h29+v0prpfrrKdISO6bYzlZPK685hIBss
         H8t5Qrt2KK0xgexu6o3bEwsDa/OJYID+fY/sWY6sXtr8Hil1Ji0SM1Ue89udO+IBPB
         5A7hf2pLeSnzlZ971c76fryY2RF4lGhQmSy5hTTUgxIZhbvF+iJ29vTU0Okvix+F4/
         ze3IY/AJApj8QBZ66/PIkbzTEx1BnjB2A/+DItGoRiZuEA0cHAPGUhS80bvaNfdEDy
         nrKZ7zr/GVAhE6l/LB+ImLH4dap2utnrCIY/mo24uWOpqc/Mb3AWNgzbEMYaeFXrQI
         IVi+wZDddSGRg==
Date:   Mon, 09 May 2022 00:01:25 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 87cf32ad3fa2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikm10M0Euhto"
Content-Disposition: inline
Message-Id: <20220508160128.DA475C385A4@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--ikm10M0Euhto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.05.08 release.

In this release, Amir's patches provide "black list" support in _supported_fs,
and two helpers _fixed_in_version() and _fixed_by_kernel_commit() to print hints
for reasons of test failures. Feel free to use these helpers on new cases, or
improve old cases.

*A Kindly Reminder*
Next week(2022.05.09 ~ 05.15) we plan to merge a big idmapped-mounts related
code refactoring, details refer to:

https://lore.kernel.org/fstests/20220507122649.dp7iopuu7rllli7k@zlang-mailbox/
https://lore.kernel.org/fstests/20220507154346.oxfwcq547p325ti3@wittgenstein/T/#mf1bdf41d4a99bb4d1b90dfee2d30ac872c6074f2

so if you're going to write patches to change src/idmapped-mounts, better to
wait one more week, to avoid terrible rebasing later.

Thanks,
Zorro

The new head of the for-next branch is commit:

87cf32ad3fa2 idmapped-mounts: Add open with O_TMPFILE operation in setgid test

New commits:

Amir Goldstein (2):
[U]      [6ee5ffa079b9] common: support black listing fs in _supported_fs()
[U]      [28c52b15c6e2] common: print hints for reasons of test failures

Chandan Babu R (1):
[D]      [9ae10c882550] xfs/533: Delete test since directory's extent count can never overflow

Dave Chinner (1):
[U]      [441606d28681] fstests: faster group file creation

Yang Xu (3):
[U]      [6ac390bb605b] idmapped-mounts: Reset errno to zero before run_test
[U]      [5328ab947ff4] idmapped-mounts: Add mknodat operation in setgid test
[U]      [87cf32ad3fa2] idmapped-mounts: Add open with O_TMPFILE operation in setgid test


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

--ikm10M0Euhto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmJ36N8ACgkQlNbPkfr2
tMyySxAAyhh8lS4qGWUjlKtXb8jZuelP9dXNdqGPkyuroh2LRwcJ9e3FduHsRYlI
Xd+z4yPRbw5JzKIiVuj3tFlcPavgVxpEgvEA44Prt9gJ02Y/wepoAw43fGDwObAk
e5TpR5X5lk4MmQneLi/h7uDLacTtQRXIYDEU/rsT+eugSrVySSlhylbvA67vvD2x
bGTJxJn1m4YY3q0GIB268bu1Ko5Igcw6EmCHB3grO+PiYYI8YaxcdPOvE2LBFYsG
1zjjcIjEuP3vSuLjIMMouH0SJDxF2QvGYmQ+aGD7JayuChtE0AghyfBtuJ6szDec
obVcH64X6InX7UVveXl1jJ5/8MN7wIsjsITUEDQMHl3Mt2+30XAiCOK4ES9f/jlT
WJ6RpbZNuZnFKjYuXFtXuJlgxGli+mYpI/H+8NnHlr23vLuuIyQEH6rl2l+dCBXB
rToCJIAqqmWqwTqI5l5TBbLguqT/QyICudQWHtTUkbYS+PS7eyDXrSsedIWQyw4M
muKGdm3Ph0U8JluMZowyKLOGdnI8USGuAa/HFKOA1RSVyhh4iSWmzQZi5i4RINIg
AhOCZ2VUg5wUoXJI9ayfbDDP3vkQ2+4u74zTiKQjIDDpqiD6Og8bgxqTmKAIiiS4
xyxPfnVj2kgSIXQuf8Ny001LNnoErpjAHqvAX/qR8FNzBwLTtEg=
=RVWx
-----END PGP SIGNATURE-----

--ikm10M0Euhto--
