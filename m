Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFFAC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Jul 2022 14:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiGXOGB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Jul 2022 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiGXOF4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Jul 2022 10:05:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A1C64EF
        for <fstests@vger.kernel.org>; Sun, 24 Jul 2022 07:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FDFFCE0FD8
        for <fstests@vger.kernel.org>; Sun, 24 Jul 2022 14:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A70C3411E;
        Sun, 24 Jul 2022 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658671538;
        bh=ZQUmioRAHV1JFS/J3QXMSxHj4PC0xpr16tHOsN7plRQ=;
        h=Date:From:To:Subject:From;
        b=OCLuXwOjilhWF/Suv8MwAEOiqlDhTKkKzIYP/nUDnDAetfiF7eKgZ6LEbzn1ZDPQG
         avuqK3fylptwTrmVctrJH1VIcXfJCw2QkY4TtU9xhFh956sjVAPin/VNi+F3o7kaRt
         QI1g81bVroRAMFtT1CUfr5NfUnT8EEMUG5Z+UcL0UTZbgl7N7KEo421wDjL2OZdueD
         a38Tq3UaKUdkM/Kqn69kQqmDkruiXZrOP3TN3uremEc9EZ7L2S8J6LR4EJaBK0CuGl
         oDMjoMAqVE268cQvqSVEdKJqiuO2AWF+U4ujjzw7PbYHpaWYJRtrJk95j3tWLs3FgZ
         Q1DeTO5Y0DAJQ==
Date:   Sun, 24 Jul 2022 22:05:32 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.07.10 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IaDUGin5HILt"
Content-Disposition: inline
Message-Id: <20220724140538.18A70C3411E@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--IaDUGin5HILt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.07.10 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

47ed06630971 xfs/144: fix test mkfs.xfs sizing of internal logs that overflow the AG

New commits:

Christoph Hellwig (1):
      [d3eb6a2b1599] btrfs: test raid1 write error handling

Darrick J. Wong (4):
      [6ecd4b5b7cd9] xfs/288: skip repair -n when checking empty root leaf block behavior
      [c9ef32ad6e38] xfs: make sure that we handle empty xattr leaf blocks ok
      [daba59ddecf3] xfs/547: fix problems with realtime
      [47ed06630971] xfs/144: fix test mkfs.xfs sizing of internal logs that overflow the AG

David Disseldorp (5):
      [de1fda54e5f0] report: use array for REPORT_ENV_LIST
      [e47930fb73bc] report: pass through most details as function parameters
      [5c31ba9b7299] check: make a few variables local
      [6bae394bcd50] check: append bad / notrun arrays in helper function
      [2fe10922349c] check: add -L <n> parameter to rerun failed tests


Code Diffstat:

 check               | 137 ++++++++++----
 common/report       |  90 +++++----
 tests/btrfs/271     |  78 ++++++++
 tests/btrfs/271.out | 521 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/144       |  14 +-
 tests/xfs/191       | 117 ++++++++++++
 tests/xfs/191.out   |   7 +
 tests/xfs/288       |  32 ++--
 tests/xfs/547       |  14 +-
 9 files changed, 899 insertions(+), 111 deletions(-)
--
Zorro Lang
zlang@kernel.org

--IaDUGin5HILt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLdUXIACgkQlNbPkfr2
tMyk9g//eTILLRac254lszSR9PkqsEaA8IxYzWgu/Ju1yb3t9HbS58zBzn2gKlnU
Hi4a7fM+1ENDNsQZrI93oCiKdRMcZPuv6jDgZDIdNpk9XfF4mksWagsJiA2sNr5g
zmo6qi/XGuCF+HsmL0oF4OVH2jt7AF44GzZQQG7Fr/a5PSSa84noCu7cRWkF8g0s
vQEIIV3S39vl0aqjy/NF167wlH+lgrpK7SrsFN2oNuoio2dppAydnSjGR3iVWxFD
sHQ51Qz1IOk19aeC0jO6LCDlGm/BvioGcMjISPGhzYLzfukOYx6jnjtSU1YYCPdc
ZZV1KzW2WuAyuFj81qC9NQhs74oNr9cIUHp/d9heyCvGfGZWjWG6SHag35GDqzVc
Oi77pEyyPKIhkTJfoLEUFZA7wXs8CVEKzB9AZLyO4rCgRTa3JaEVFMvblRexAy2t
ArHiHydQDFOus4ZKasERLnIDvjuWvPyav95QxReVLSOFm5jRRvEmH6k02wVVsBZK
lVLgKX51DGk2FnY8XxuaG6bYUmhllw1NoWJ5Miiva4KdACG1a0CYFu6cub/ZQzd7
t/2eRu7/IFSZznoZF/Pe/UsZw9lvKjan7+vgJji8pmdKDRf0kTArfWo537oTOu0x
Bl3EfcmfIY3kWcJFeEPKMevt9oCwx/awI1xz8PquE9XyR3ECSBY=
=ZHNx
-----END PGP SIGNATURE-----

--IaDUGin5HILt--
