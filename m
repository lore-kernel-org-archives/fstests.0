Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B451C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Nov 2021 14:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262AF61056
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Nov 2021 14:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhKNOwI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Nov 2021 09:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNOvv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Nov 2021 09:51:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC97EC061746
        for <fstests@vger.kernel.org>; Sun, 14 Nov 2021 06:48:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w29so25216309wra.12
        for <fstests@vger.kernel.org>; Sun, 14 Nov 2021 06:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=j81TgxWMX2nxvpWodk9OqibN5EmjpRlya/Ug9tnPfMM=;
        b=UHHN8qIDmzZ86PbPZYS67oCdvbaKn3zCkVLqT5bWuRSB3JMTVGwVNC0m8R0LxkpKdu
         VWA6m5d1ede+O/ne0nr5+JksIdbK2yt07VllbJTCcYFqP5tuP/fuOLyZ93drG8dnL1Nt
         2STaxX7ZYjIwyA84bG/nQROxKhTlL9b/izHa9nrQ4KhG6CMocPUKnIRohpxYkv+r/rNL
         VNNQprBoZ8Gl5QtX70apw3bWsgpaJIoCHp2FbWUCHGa8nQADxMmgMERqxpJ4tzWGeEA/
         RqamJYtpoJucKm7D10yPEbgtapwkEgo70j+O0AbKvb53kk6iQ1V3+Lmgw0Elai62WxoJ
         ysig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=j81TgxWMX2nxvpWodk9OqibN5EmjpRlya/Ug9tnPfMM=;
        b=QSVjg9jwIvLgoZJA3spo/y53AiOn4WCadSwRDDA7VwhG6NBTMOLg2xq7B085cFUlng
         3eFr1rkLt+13/v+oMdfc6cEQ0Q7lqLcC33FkFZmtcyWqca1GE4MCol2b2oIZ2+hCIKQO
         IoTaGRdkNwNMgxvC/dGaF3GACEjrYoALXaajHvZP1GbPcuuMxj4M9IxgE+P0xh4RcAwn
         ilVdel+vFHHg9NO6+FDU+xWY2mfxdmG/NRCUxh3FdvZX+5809v2b00tjTssyAoXUxTEO
         Czcpd3Saob3LACvL4zwVA/AkTSyQsLbOb+E+8EE7M2AYxS2b7uGHdMUes+4PmYOBQ28E
         Glpw==
X-Gm-Message-State: AOAM533buk327L1FRYIF88MGAHnrpXPkq6olBJ9BeQeSPgDDv/hUdFMm
        3p2gThd0WkhT1smuYsrpzjX1+lK46helYg==
X-Google-Smtp-Source: ABdhPJxNGrNDW62CKdFFHf17mn65KPlUiPfreoDRGrX/00/hXxfxst98xf556gaXHnNQ89sSCiOI8w==
X-Received: by 2002:a05:6000:52:: with SMTP id k18mr36787706wrx.192.1636901330848;
        Sun, 14 Nov 2021 06:48:50 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id j134sm11545494wmj.3.2021.11.14.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 06:48:50 -0800 (PST)
Message-ID: <619121d2.1c69fb81.e4e07.8e5e@mx.google.com>
Date:   Sun, 14 Nov 2021 22:48:22 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 9f8f0e4d5ae0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yIBEmkMEs803"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--yIBEmkMEs803
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're a bunch of mmap CoW tests from Shiyang Ruan
have been added in this update, many thanks to Shiyang! Other commits are
random bug fixes & improvements. And I didn't see any new failures introduced
by this update when testing with v5.15 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

9f8f0e4d5ae0 generic: add mmap CoW test for 'mixed' case

New commits:

Carlos Maiolino (2):
      [bb0ab7b292b4] common/rc: Enable _format_swapfile to return the swap size
      [16bd4336604c] generic/643: Fix for 1k block sizes for ext2 and ext3

Eric Biggers (1):
      [1adc9f01994c] generic/574: remove invalid test of read completely past EOF

Josef Bacik (2):
      [090e349abcbb] fstests: print symbolic names for fiemap flags
      [bf3d7aba247d] fstests: check if the scratch device is an lv device for certain tests

Lukas Czerner (2):
      [d83eaf746479] common/rc: add _require_kernel_config and _has_kernel_config
      [f5944cd0383e] ext4: add test for all ext4/ext3/ext2 mount options

Luís Henriques (2):
      [08ea29c66c78] generic/528: take fs timestamps granularity into account in tolerance interval
      [e429c4aa5599] common/renameat2: use mktemp(1) to create temporary directory

Qu Wenruo (1):
      [ff0409f6b576] btrfs: make nospace_cache related test cases to work with latest v2 cache

Shiyang Ruan (5):
      [0108519ae1b0] generic: add mmap CoW test for 'regular' case
      [13596038f1dd] generic: add mmap CoW test for 'unwritten' case
      [55ae1620fdf3] generic: add mmap CoW test for 'hole' case
      [e268739e5e88] generic: add mmap CoW test for 'delalloc' case
      [9f8f0e4d5ae0] generic: add mmap CoW test for 'mixed' case

Yang Xu (1):
      [7be8db3322a8] ext4/051: correct kernel commit

Zorro Lang (1):
      [1b5ab4ec6ad7] generic/648: dmerror must be unmounted


Code Diffstat:

 README                |   2 +
 common/btrfs          |  12 +
 common/config         |   1 +
 common/punch          |  16 +-
 common/rc             |  50 +++-
 common/renameat2      |   3 +-
 tests/btrfs/102       |   2 +-
 tests/btrfs/140       |   5 +-
 tests/btrfs/141       |   5 +-
 tests/btrfs/142       |   5 +-
 tests/btrfs/143       |   5 +-
 tests/btrfs/151       |   4 +-
 tests/btrfs/157       |   7 +-
 tests/btrfs/158       |   7 +-
 tests/btrfs/170       |   2 +-
 tests/btrfs/173       |   2 +-
 tests/btrfs/174       |   2 +-
 tests/btrfs/175       |   4 +-
 tests/btrfs/176       |   2 +-
 tests/btrfs/177       |   2 +-
 tests/btrfs/199       |   4 +-
 tests/btrfs/215       |   2 +-
 tests/ext4/051        |   4 +-
 tests/ext4/053        | 633 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/053.out    |   2 +
 tests/generic/081     |   2 +-
 tests/generic/108     |   2 +-
 tests/generic/352.out |   4 +-
 tests/generic/353.out |   8 +-
 tests/generic/356     |   2 +-
 tests/generic/357     |   2 +-
 tests/generic/459     |   2 +-
 tests/generic/493     |   2 +-
 tests/generic/494     |   2 +-
 tests/generic/528     |   2 +-
 tests/generic/554     |   2 +-
 tests/generic/569     |   2 +-
 tests/generic/574     |   2 +-
 tests/generic/574.out |   2 -
 tests/generic/643     |  27 +--
 tests/generic/648     |  18 +-
 tests/generic/651     |  68 ++++++
 tests/generic/651.out |   6 +
 tests/generic/652     |  69 ++++++
 tests/generic/652.out |   6 +
 tests/generic/653     |  63 +++++
 tests/generic/653.out |   6 +
 tests/generic/654     |  73 ++++++
 tests/generic/654.out |   6 +
 tests/generic/655     | 132 +++++++++++
 tests/generic/655.out |  62 +++++
 51 files changed, 1275 insertions(+), 80 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--yIBEmkMEs803
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmGRISIACgkQJlKqKVyP
52OteRAAiLkwro7bms8+gDfFNzyVg1jlwmf8npLyRzRjwtnHudG5nOdFWPOZA/dm
vWY1NU9ZbBAOngsA8PdazVrtsjdyAR9buCxOCNeyjB0w7ty46+wnz9OysqHhsDTH
XXSO+TVcJ/eq+npOixdBUXLpqTluc2+Nhmo4OONlB1KyfqIztBWWR3pXIVMz7Cud
642si4eAmvul7Pij4YVSlsvy60o6SvtVUvnAickDUX4KGBqbr2aeUKk2SjdL/S8N
u/ZikJYnlJZJemP2E9t4znasrAo4VyQDnHkF54htQjWGUbY9fA5NaWGnfqoymcTm
zpg6pJwswoK32+45Nz2m+ZNQsh+8574YxMmmy9ViOVxGfj88e02RRQFvKZRgo6zZ
yG0/tvQgD43QmEV+rCbGlpd+afByrbJXdH9PMBFmTiQcY10braqsDlG5TSDl5ulH
8Q+U1WjsJayS85VNcRYhKKxsDZJxDoNedumYV+xDc35sKVFwe8dyTG2JVPmfIBu3
NZMnCSebpNr4IN8z83RPIJ4CWnPCoRRW5Mb8IRB768HPR5ir45YO8kqPEX1hyOCG
Rjtarb7V/URM5L/rlIT4q5VnkK/cwN5rjSr9l47M1P5/z07icOFTLmgTClCzXzeH
CAYj+jTdGSFXI3/OywEXYK9q2gd16fRMcudSHNYcjgJj6vCR2uo=
=ZyyU
-----END PGP SIGNATURE-----

--yIBEmkMEs803--
