Return-Path: <SRS0=TcRL=6D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C6FC38A30
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Apr 2020 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A8121473
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Apr 2020 17:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETFsDQj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDSRDp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725932AbgDSRDp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Apr 2020 13:03:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C918C061A0C
        for <fstests@vger.kernel.org>; Sun, 19 Apr 2020 10:03:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u9so3753094pfm.10
        for <fstests@vger.kernel.org>; Sun, 19 Apr 2020 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=eNW/UvQGp45zSoRKZUfHtmds9KhFMDveTsS1JvNh5pw=;
        b=ETFsDQj3RXPyMsOQd2cwYNk2X9ozLTxvHQcgl3CmnaM0KN1XVU1myVAl4IRU4vykqj
         T6Kq0FSqW/GlS7KOw6zC5Af95iaoWXTXOxxTLGFJm+8fbpk7PhIUcaCwNVXSj6ZkVqmR
         Lngi3eLKYQoUvhOB9hqNO7kopKDNdbzityRH1xfbVHBQFAuVSu5WuPMdtGw5HTWR68Yz
         b8XaeP2yz8ikOD3dWmvn9DNr/s9xiKIDByNlv/IKZD+c61dTcLeWlmEvwsEQ9cJCsxfy
         D2qr6mU+moKgcgSZ3TXZ5k/tByR8G8fxP7nZR+KChImt6mcjRaUeh5QaiBn8usDSsC4X
         NTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=eNW/UvQGp45zSoRKZUfHtmds9KhFMDveTsS1JvNh5pw=;
        b=AvTjMUH39v2RXO4u7tSzy24tHnvLYfYJ2tdTxiuocRsVIGmDsnuBN59X4Tp+b0vbvR
         oDLP3Hc1BYsw/E6VJJ0uQEQrLMiMDilJJ/fEA2Qc1FJZRkqhJw9eqWH7rTl9dLM012ZT
         CehUsFPgvA3gwXfIvLkwDCuUYP9Bh9onS3yANoCNiv8haL0BAOvNJu3KLinwbpchhyYb
         N0NaM/0CqWTYObuidE3lGB7eM59vU2755YPWRgzELRfo6qZyBKS9f8RsDmnjaiymQ5NY
         Uhvgy50ClJbigfgsf/aW9YQVnwLFd59T5jJ3B0xM/ck+JKGK3botqGQzfC1edjIhGBDF
         ghPg==
X-Gm-Message-State: AGi0PuaHNa42GQzD/496k3TUKgLOrH92uzTCv+cq40WbkqsQdCEV7B/5
        bip2RtTXN8fKa/80+G11xpNl4wqP
X-Google-Smtp-Source: APiQypLiZpfwTBpTL3pNpwMa9gyodzvcXo3azPWvJsm7f7nV4Zlc/hjfs/v/HyvPFSMva2C6NKPs/Q==
X-Received: by 2002:a63:1118:: with SMTP id g24mr12655850pgl.259.1587315823205;
        Sun, 19 Apr 2020 10:03:43 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id x4sm25033140pfa.191.2020.04.19.10.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:03:42 -0700 (PDT)
Message-ID: <5e9c846e.1c69fb81.d99a9.cc87@mx.google.com>
Date:   Mon, 20 Apr 2020 01:04:44 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 50a059ceace8
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gEnR1Uj0cUjt"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--gEnR1Uj0cUjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly contains various bugfixes, and one
new btrfs test has been added as well.

And from now on, it's encouraged to use _run_btrfs_balance_start() to start a
btrfs full balance, as it takes care of behavior change in btrfs-progs on
balance.

New test btrfs/210 currently fails with v5.7-rc1 kernel. And you may see
btrfs/014 and btrfs/205 start to fail on v5.7-rc1, but the two failures all
should be fixed in latest Linus tree (v5.7-rc1+). 

There're still some patches pending in my to-review queue, I'll review them in
next week.

Thanks,
Eryu

The new head of the master branch is commit:

50a059ceace8 generic/594: require setquota tool supports project quota

New commits:

Amir Goldstein (1):
      [200e7d53102d] overlay/06[89]: fix test run with nfs_export feature enabled by default

Eric Sandeen (5):
      [0b0426506c2f] fstests: rename _require_test_symlinks
      [2b0162607d68] fstests: use _require_symlinks on all necessary tests
      [3e4ccc86bbf9] fstests: add _require_hardlinks for all necessary tests
      [4f9638d1c0d1] fstests: test for fallocate capability in more tests
      [92a6a6cff81e] fstests: exclude exfat from tests which require metadata journaling

Filipe Manana (4):
      [c684b203d1bd] btrfs: check that cloning an inline extent does not lead to data loss
      [ab3b7f026e21] btrfs: add several tests to the balance group
      [af3d0c0ea9d8] btrfs: stop using run_check in _run_btrfs_balance_start
      [8c16b061f7a4] btrfs: make all btrfs tests that exercise balance use _run_btrfs_balance_start()

Qu Wenruo (1):
      [b04fe27eda77] btrfs: snapshot creation with qgroup inherit would mark qgroup inconsistent

Vladimir Zapolskiy (1):
      [e4d2feb35ef7] generic: assign a few tests to additional groups

Zorro Lang (1):
      [50a059ceace8] generic/594: require setquota tool supports project quota


Code Diffstat:

 common/btrfs        |  4 ++--
 common/overlay      | 14 ++++++------
 common/quota        |  9 ++++++++
 common/rc           | 16 ++++++++++++--
 tests/btrfs/003     |  4 ++--
 tests/btrfs/013     |  3 +--
 tests/btrfs/014     |  2 +-
 tests/btrfs/021     |  2 +-
 tests/btrfs/102     |  2 +-
 tests/btrfs/123     |  2 +-
 tests/btrfs/124     |  2 +-
 tests/btrfs/125     |  2 +-
 tests/btrfs/154     |  4 ++--
 tests/btrfs/156     |  4 ++--
 tests/btrfs/177     |  4 ++--
 tests/btrfs/181     |  2 +-
 tests/btrfs/182     |  2 +-
 tests/btrfs/187     |  2 +-
 tests/btrfs/190     |  3 ++-
 tests/btrfs/195     |  2 +-
 tests/btrfs/205     | 13 +++++++++++
 tests/btrfs/205.out | 32 +++++++++++++++++++++++++++
 tests/btrfs/210     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/210.out |  2 ++
 tests/btrfs/group   | 17 ++++++++-------
 tests/generic/002   |  1 +
 tests/generic/005   |  2 +-
 tests/generic/023   |  2 +-
 tests/generic/024   |  2 +-
 tests/generic/025   |  2 +-
 tests/generic/039   |  1 +
 tests/generic/040   |  1 +
 tests/generic/041   |  1 +
 tests/generic/056   |  1 +
 tests/generic/057   |  1 +
 tests/generic/062   |  1 +
 tests/generic/065   |  1 +
 tests/generic/067   |  2 +-
 tests/generic/078   |  2 +-
 tests/generic/089   |  1 +
 tests/generic/090   |  1 +
 tests/generic/104   |  1 +
 tests/generic/106   |  1 +
 tests/generic/107   |  1 +
 tests/generic/109   |  1 +
 tests/generic/236   |  2 +-
 tests/generic/286   |  1 +
 tests/generic/294   |  1 +
 tests/generic/306   |  1 +
 tests/generic/336   |  1 +
 tests/generic/343   |  1 +
 tests/generic/348   |  1 +
 tests/generic/360   |  1 +
 tests/generic/378   |  1 +
 tests/generic/397   |  1 +
 tests/generic/399   |  1 +
 tests/generic/401   |  1 +
 tests/generic/404   |  1 +
 tests/generic/423   |  1 +
 tests/generic/440   |  1 +
 tests/generic/479   |  1 +
 tests/generic/480   |  1 +
 tests/generic/498   |  1 +
 tests/generic/502   |  1 +
 tests/generic/526   |  1 +
 tests/generic/527   |  1 +
 tests/generic/556   |  1 +
 tests/generic/569   |  1 +
 tests/generic/594   |  1 +
 tests/generic/group |  8 +++----
 tests/overlay/068   |  3 +--
 tests/overlay/069   |  3 +--
 72 files changed, 222 insertions(+), 54 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--gEnR1Uj0cUjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl6cg1IACgkQJlKqKVyP
52OGOA/+LKp4fl35pJorNH2FvCzSa4LUCrB2095DA47FaPlbiyZHtje46DFxr9Wo
cRCThwBh6fTZKP2dLM/bRSsb68bWAnkeA4cB/kUwnpZSTNkYWOQCnSq2aQakgF8t
at1dIlBrTPqEvHVMe7lkp5rOgwVCbrTiBeKgWDi2M/3yUrH5wCPvAZrRyAblCipL
RqBmEfzzYGjTPy/RWwF+ht0Z5NzdTNs+ZuYq+mswOt56HMUkcBcEEgmxzPpnf+se
RW4A7HmwpqJo8cq6nGttPMq4H80cPR0MMiXPCgWNfgeAvRpJCQhQYM9oYVzorz25
xZvb25Ls8Jfuhk87MAb9v5wHiziYvMYVCT6Zn+Kmii48qWbPk1UtZnGE1uZKnHdo
23TY7seD75BTdVLBw3kMQsNCNDsjvZtoGFlnc74/f/xzxvvnX09cXlLrE3E0wD70
fUmp+OVKi8Fv78o3QeXhDA/H+yDYek349uk/exBpJG6koimAfgc+6wy17a6wyhPW
wKpr0XXVl/NFOCsnUTUvzOf2IejfclTm+frR//gwnh0tNmFcKAO8rdei4Vhewkk3
2VzuwsSZ3ABzM8ubQC2G6z/9qZ4MhEAlWQ8F6KgpYWJh7kcKL2rMa+0vR0Y5N7NE
8oAsm6bJwARQpwQIyW0HRz0i4nK4IPp2cc2me1Egp3FCCcTT2oY=
=Y258
-----END PGP SIGNATURE-----

--gEnR1Uj0cUjt--
