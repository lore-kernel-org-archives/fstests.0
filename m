Return-Path: <SRS0=MkaF=2T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3D9C2D0DA
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Dec 2019 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77F020748
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Dec 2019 18:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvMP2h5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfL2S2u (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:28:50 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35088 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfL2S2u (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Dec 2019 13:28:50 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so7212867pjc.0
        for <fstests@vger.kernel.org>; Sun, 29 Dec 2019 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=1+uICSkUryEkqfXX+1IzEy8JxcEuXl8R1wvBP75Tbjw=;
        b=RvMP2h5e41aHZJVxOLB2CD/enHndVGW8RX86Fsfga5Pbjh9q2Z0N2/tgnprS3i33Vu
         syQMn34uktDx57moWBXBm0A98tZLsRTkgy+HfB5uSi03+9eFhCWAlkBdEOnUBoRz9nhp
         W6VteaLysKEVFXWQp9K32HDDlmzVaPi/CXGhf7BrVuXMpMQMHVHqnn/r+uKIZtXOiiy2
         7XVmtv7v2csRc5SK6M2yVngtvLvGueBiSQY+00v1MUk2XsUbsNZdIOKymocmuHRgbUlg
         VWJBWDHQ7VjMXjWWaEKV8N8hhrg36MAXce6VJys9YiDWyRVVc8F+wk8k3JSrshBCFOjy
         MIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=1+uICSkUryEkqfXX+1IzEy8JxcEuXl8R1wvBP75Tbjw=;
        b=ge+OKnYToDSZqhGhboHV/HbpawlgzlHEln4VXOZb4eX4WpUkJJyCIy7bWwkweEsrIR
         cQJv5gaAJU1AGrs8s6ZPXfisFb3/xAe+KhFyVtGA0O64LvxRdGEWQEgOglCgQL5lC+Zb
         GCxWDsQiUSIDD8WgFiBOf8NjdBWeUWKzY8Y0w0nB231cXe3SoyGJeAJr9YmVUVx8cc/N
         EImCk+4X+Wr9MT2fIi7A44QxEus2N/VA5rvoyqGbP+4zBQbioQaEUo+bw50VVI6QpL8Z
         qk+EB084W4G3GcLOXuMXEcSazH2uUWBT1OT815cJb2uQs2Ldaf6n7lWngo94V3OylMKP
         fdkA==
X-Gm-Message-State: APjAAAV1sri1Hh0Bw5Yp9UbVl2Tto5lLgDkztbD+DC7k1U158dIkN0WL
        PY0aRiO2bY0jOMRhpYWSpCyzi2jA
X-Google-Smtp-Source: APXvYqz4sZvhJURAO6aPToaY9SRro3w0+ehRAXbwCcDg8JJRfNnDWbbFHXT5I+zj0AWMShtLhtXPtw==
X-Received: by 2002:a17:90a:e657:: with SMTP id ep23mr40346670pjb.105.1577644129313;
        Sun, 29 Dec 2019 10:28:49 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id w187sm30894109pfw.62.2019.12.29.10.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 10:28:48 -0800 (PST)
Message-ID: <5e08f060.1c69fb81.4707a.c444@mx.google.com>
Date:   Mon, 30 Dec 2019 02:28:43 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to a0b0287cb747
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LqJATDIYsNGG"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--LqJATDIYsNGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in btrfs tests and fixes.
Notably, fsstress is able to do btrfs subvolume tests, and you may hit new
failures when testing btrfs. Also, a regression introduced in last update in
generic/386 has been fixed, the test passes on ext4 now.

Many thanks to Filipe Manana, who helped review most of the btrfs updates!

And this is the last update in 2019, happy new year!

Thanks,
Eryu

The new head of the master branch is commit:

a0b0287cb747 btrfs/15[78]: Use proper helper to get both devid and physical offset for corruption

New commits:

Josef Bacik (4):
      [fb769938dcc5] fsstress: add the ability to create/delete subvolumes
      [fd0830929573] fsstress: add the ability to create snapshots
      [f2e567ab172c] fsstress: allow operations to use either a directory or subvol
      [805c6262d5f7] src/fssum: skip subvolumes when building a sum

Qu Wenruo (3):
      [ab76e971702d] common: Use more accurate kernel config for _require_fail_make_request
      [1a27bf14ef8b] btrfs/14[23]: Use proper help to get both devid and physical offset for corruption.
      [a0b0287cb747] btrfs/15[78]: Use proper helper to get both devid and physical offset for corruption

Theodore Ts'o (1):
      [ea726c4a55c9] generic/386: check the correct field from df output


Code Diffstat:

 common/rc              |   2 +-
 configure.ac           |   1 +
 include/builddefs.in   |   1 +
 ltp/Makefile           |   4 +
 ltp/fsstress.c         | 299 +++++++++++++++++++++++++++++++++++++++++--------
 m4/package_libbtrfs.m4 |   5 +
 src/fssum.c            |  11 ++
 tests/btrfs/142        |  52 ++++++---
 tests/btrfs/142.out    |   2 -
 tests/btrfs/143        |  50 ++++++---
 tests/btrfs/143.out    |   2 -
 tests/btrfs/157        |  49 +++++---
 tests/btrfs/157.out    |   4 -
 tests/btrfs/158        |  44 +++++---
 tests/btrfs/158.out    |   4 -
 tests/generic/386      |   6 +-
 16 files changed, 414 insertions(+), 122 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--LqJATDIYsNGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl4I7+EACgkQJlKqKVyP
52MuIw//S7Vh7JVhwHrns3R6+/G8cH0U9xOHJVxi+IVWEl5z7Vt9fjb7nenrKQq8
V7knOWc2xtIU8yoLbb0piNNNdqvjPr2twq51Jh4Jv2E8cflVkKWLmAcU1bMMfUgf
9jWaMDJrF/S9lPd0HVTTZSzkCabMz0HXWcD0gF+kBiHqSEgT8T19Kqcw3lNt3ePN
l6GKl8tj7t3Gcq2F4ProdJuAs0RnitB158opyd1gNaMstsc2pla1Ls128X9chDLh
1u83RQ7fILbtUkqukAR29f2ub00RyNTw7LMN63W2h3ew5jwWdG48aEe8yVfq/RK2
+JEwuTSXwX1aTI44oPMp8iRo5icBrXVLxKNS636Ve93sR58bYFd/IlMdUzaNDwvA
rwObZAr1qijYxQLgze1CBySKj/KtgW4/mwZ7kq7BoXa6SuGTKFbT5OQoKxVnn1q0
NuMscf8RP1dKr82NqoheL811RnAG2tzyHjXYjuaMx/2u7oiy9xLkGNAaaVH4LLd+
zlu9413DX1e0F4pjIUZ8MUdqsaXAAGZ0nGmEXzjii4hUe1GPga8K9dEGnoSlRoTD
0+JfL85WVWzHKGeaG1Qglz2CnPBZ6AvWZ2jrNDAZYRh275j56+oK2VrKKRX37OG4
s2xCII/PZ7qCb8w9zBaa60Z3TyNDOqksJADOeh0QgfnVJ2KGOdA=
=WM7r
-----END PGP SIGNATURE-----

--LqJATDIYsNGG--
