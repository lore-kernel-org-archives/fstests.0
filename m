Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E647ECAAD3
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Sep 2022 13:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIDN0n (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Sep 2022 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDN0n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Sep 2022 09:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA4937F86
        for <fstests@vger.kernel.org>; Sun,  4 Sep 2022 06:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7BE960F7C
        for <fstests@vger.kernel.org>; Sun,  4 Sep 2022 13:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DB5C433C1;
        Sun,  4 Sep 2022 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662298001;
        bh=PRDlZBbogr2KLyul7OH6H+E25ACdNQVf/gWkoEcC+to=;
        h=Date:From:To:Subject:From;
        b=e3YsLMccEolBy6cXRfnlivKVcJ70uSqAroBervR93MwOCdX6KmTNTi426TEeZmhN0
         t9u+BAMRmDAyvBTyErAjdHQtRrmx2Hxm7OZvVeYj+Vfx2rlOmaHU3JTfX/XsM5w5ay
         IjBjtPubU1VsqCJ/iXAHTal1whrB+NM+X60OFnYHC8gESmlASzQr5S84YWraWUOvGj
         zXkzm/pEwQAxHieONtO7QW64AUpDnaE4lz2yEeAmFTtJA+8ud5Lihj0Q/Wc5a5fZQu
         5XUM0wKD3xNm42N1aPIG3SRT1Dp1EvVcvmztmqy2mtveye7kujDwG86PW6ErpMjuPo
         SavnFVAPdQbcg==
Date:   Sun, 04 Sep 2022 21:26:38 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.08.21 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9MNOUSOLbBrx"
Content-Disposition: inline
Message-Id: <20220904132640.E4DB5C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--9MNOUSOLbBrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.08.21 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

bf1ef26900ee src/t_ofd_locks.c: Reset errno to zero

New commits:

Boris Burkov (1):
      [192f5297b54f] fstests: add btrfs fs-verity send/recv test

Darrick J. Wong (7):
      [04307f499d13] xfs/{015,042,076}: fix mkfs failures with nrext64=1
      [67afd5c74246] common/rc: move ext4-specific helpers into a separate common/ext4 file
      [e88c0d38eeda] common/rc: move XFS-specific parts of _scratch_options into common/xfs
      [92caf7ebe14d] common/ext4: provide custom ext4 scratch fs options
      [acf0424671ff] dmerror: support external log and realtime devices
      [49272aacac85] common: refactor fail_make_request boilerplate
      [6049ccca12ab] fail_make_request: teach helpers about external devices

Pavel Reichl (1):
      [87d9aea81007] generic: test i_blocks for large files

Wang Yugui (1):
      [c9734480a1dd] fstests: add missing _require_scratch

Yang Xu (1):
      [bf1ef26900ee] src/t_ofd_locks.c: Reset errno to zero


Code Diffstat:

 common/config            |   4 +
 common/dmerror           | 163 +++++++++++++++++++++++++++++++++++++--
 common/ext4              | 193 +++++++++++++++++++++++++++++++++++++++++++++++
 common/fail_make_request |  63 ++++++++++++++++
 common/rc                | 193 ++++-------------------------------------------
 common/xfs               |  23 ++++++
 src/t_ofd_locks.c        |   2 +
 tests/btrfs/088          |  14 ++--
 tests/btrfs/150          |  13 ++--
 tests/btrfs/202          |   1 +
 tests/btrfs/215          |   1 +
 tests/btrfs/268          |   1 +
 tests/btrfs/269          |   1 +
 tests/btrfs/270          |   1 +
 tests/btrfs/277          | 115 ++++++++++++++++++++++++++++
 tests/btrfs/277.out      |  59 +++++++++++++++
 tests/generic/019        |  40 ++--------
 tests/generic/441        |   2 +-
 tests/generic/487        |   2 +-
 tests/generic/694        |  47 ++++++++++++
 tests/generic/694.out    |   2 +
 tests/xfs/015            |   4 +-
 tests/xfs/042            |  14 ++--
 tests/xfs/042.out        |   4 +-
 tests/xfs/076            |   2 +-
 25 files changed, 711 insertions(+), 253 deletions(-)
--
Zorro Lang
zlang@kernel.org

--9MNOUSOLbBrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmMUp14ACgkQlNbPkfr2
tMyVDxAAsBnSSaWpXxls6R9m+HPxQRsjKuZApOi1dqsheshvBfdWfwSGI0uoFMz+
oQ96wX9hgNXXGbXRIw2OdnDfuwOLTRnKX7s0Mrc/+tZjuZQcvaxeyb9oVjs+9eYk
SiqEJ9OzY7pbiH28qP4NEPGsWZbIdrroRnU9K+9LUc6ZpfGgfptWCE2rUts0yWDc
z2ZSfFWBNWPKRoHjPMXV5pJ7VWbRcUpaAKd1Ova6RjRR9eXmS2iLw5EDXgmj1HDX
q6iCytCXhNeZOdrI94DbnnhUrBYi0RJbkLXVLq8WWrGKtNoWs40mLG8cA/tducJv
1C48L7DKoITyoq2x5mj/oQOES0aTWFUJyj++DnPkoTm1gwdHWKZsyZtk3IprOtOz
0BHbalzD9grecSI7v+KJktOi2LGDECEcMfJdDXUqO0lpCbTp+N9C996PTaK4phES
jQTUhjTDpd9dlItAGb5CHDs6PPeII6jE7JTqjX8eyYf9NGf04jNTXRcl1YpUUNlj
b9WKDJV2oQMNAsxbXCLckmtvOYcDyt8ZD7wvE+PHAif7VpG8W0ZJHiGU4fqUTWvL
A/i3TGUr/ij7MuXX8NFsubl8lQaS9U1Z/5fnIV20s6p5Mu9xjudhUSeru6++omEL
tlJX+6doAWDlUga1HplRak4Cr1DlccxKpZ44h9TykBibGBT5h38=
=AeuE
-----END PGP SIGNATURE-----

--9MNOUSOLbBrx--
