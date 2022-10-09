Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D0C433FE
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Oct 2022 12:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJIM2C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Oct 2022 08:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIM2C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Oct 2022 08:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16992C67D
        for <fstests@vger.kernel.org>; Sun,  9 Oct 2022 05:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E26860AE9
        for <fstests@vger.kernel.org>; Sun,  9 Oct 2022 12:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A22C433C1;
        Sun,  9 Oct 2022 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665318479;
        bh=PAQh5f7N+b8I9gZNnxpL3F5JZ/WR+2Xd2Z0CeTlU7Y8=;
        h=Date:From:To:Subject:From;
        b=edQVK4gxtu14js0dRZUT8b6wl+SYqY2gAo5UnygRNIonfMTIqYs4NKlAIKxFjTLB4
         w+7DD7QCmVpSWLmioO3DSvDuqnQ13YFPXvTyNW4bO8Vj0QTbkDGx4BYBi4BWQM8YyE
         l3+9zqChiGkxqBlZv1QIoQ7TSFQ+WlHlXrh/XvQ/XgO6BCulQ9qkC/7M3XUGwoEQok
         zS6z43QaM8eW1nkYV22yATSSiaYHwYLO3tUOqtj6gNOxpIQZ2RGu8sEXvI2r1h8PGj
         GAcjS1DskpcDKYkeyF09i7OcuaJiIsexqh1CtlgB9Ce+GQ8xTBzxf2J1LU77IS5mek
         CR0vvwG86+SVA==
Date:   Sun, 09 Oct 2022 20:27:56 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.09.25 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BBt3xq8yq1OT"
Content-Disposition: inline
Message-Id: <20221009122759.73A22C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--BBt3xq8yq1OT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.09.25 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

e5555e75ba19 btrfs: test xattr changes for RO btrfs property

New commits:

Christian Brauner (3):
      [7c7a73c43be8] idmapped-mounts: account for EOVERFLOW
      [c343488d82d4] generic: basic group ownership changing test
      [b7adca6f6676] generic: overlay group ownership changing test

Filipe Manana (1):
      [a945da31e759] btrfs: test that we can not delete a subvolume with an active swap file

Goldwyn Rodrigues (1):
      [e5555e75ba19] btrfs: test xattr changes for RO btrfs property

Murphy Zhou (2):
      [1cbaf24e0cc8] egrep, fgrep: deprecated
      [9a5559da1af7] common/quota: fix grep pattern

Pavel Reichl (3):
      [e635c29e187d] ext4/044: Add missing check for return value
      [9fd20429c9ce] common: new helper to alloacate fixed size files
      [ce77f0422ae8] generic: test i_blocks for truncated large files

Qu Wenruo (1):
      [42cc53859ca1] btrfs/253: update the data chunk size to the correct one

Zorro Lang (1):
      [033a68a98684] generic: new test to verify selinux label of whiteout inode


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

--BBt3xq8yq1OT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmNCvhsACgkQlNbPkfr2
tMzbfg/6A0TJWoNG9sy2TA4rA9t0+ZjmKLByxBqUsCjnx0BPptuKZy0958k5FPID
9SFeg1FdxcYsSPm8HWl9DdCnlriQUAIR6t+R3vZgNrzuWuqI81kJA//Cu2ml4lif
rJuqjXD4WbFzOeyheOxCw5aJKv2LJwlXx7dNmILLrnNtcdE8/oMOeeX60sOF3Lou
DTyQIFb9X8xwU/ctqTbW5cUzgnpDqrTeAddYS0yTMuEJCQq2XHDrSmHvtPrM/O6Q
91Ew5Mwh84dywfGDjjsthbICUgWHLtUw53JWedlfT0qZnIMTkrIBf69OGsVptlHs
vCmWtWg8pbYwiCEaFka6I07RdPpbN08lO9Wr463rl6Vqukel1Y9vdZqdQxRZjizu
npqDvsEfDnh9BnFAhICttQi1/qm8J8oUS/jz+F3czFoF0COdvdGH+39NQoEZ0ZEy
uMXz/xQUhXy6Lr1ejvrtEM/mymWhmNurDPek1jNgQu6HLPQtPM1orChnp3XoRRmB
FZlHSbE/oHcKeOQgHogu+dGpkbnhKNs2PFI2iuMEtfj6shONTEgklW3y9uJqzeLY
kBRauGkyTkDVkV3vA0LyiUK4qG6gnQ2PgI0TdJxihstXnkHGXrBeeKmXkusWseoV
IA3ox9OWZmuCSpQfo6W9Mcbrpz2CiholWdzZjQR65ftPDmfGE9c=
=clr+
-----END PGP SIGNATURE-----

--BBt3xq8yq1OT--
