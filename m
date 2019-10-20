Return-Path: <SRS0=GzCB=YN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1F7CA9EAD
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Oct 2019 14:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BF921928
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Oct 2019 14:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWLb3l62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfJTOJz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Oct 2019 10:09:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfJTOJz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Oct 2019 10:09:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so6691556pfl.0
        for <fstests@vger.kernel.org>; Sun, 20 Oct 2019 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=6yMGKQi+hfGYb+RFAR7xrpYr7CRvRJRzF3OHa1CB4zI=;
        b=RWLb3l62e2O1xGhdkb9pPyCqw/UYBHEjbOUPUi1djd/S5g7odyAjEnYWuQLC+ilZ7H
         RPhLnCnA2i2lYcI9DpOnvTlHcEOin6e4PxBVlFjCTVTmET/D7xNtAYkgKE+80gkS6JcI
         vFgzxieOCITilv0r5lfw/2Q/qqOEr/CZd93GP/VGFu4nUSfTuroDkTnImxjdfmUcC77G
         HP2vxlscjar/mQuMoXp/2oC6zCdP4om8P93++u+AUEedx68IGoWuEQb0bOZQ8hy5jBia
         bRcOE1w4t0wKqSilT6my3bI1R/8TvLebwE12PhIO6sR3rfUX88LpuC6JzQfbkkdUohAi
         DHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=6yMGKQi+hfGYb+RFAR7xrpYr7CRvRJRzF3OHa1CB4zI=;
        b=R+qht1a1Ut3B2Q52GAy8Ab9t1yBFxYHGzh4vYWIss4BLori+bjIJOUeyDL4l20Tad3
         gC51KdC41LKr1vdeQO8yDIijYHoZWDrQ4j/RiEDo3efGaqGU/8SFppR5y+kj1VsFuyLU
         v//rKQjzllY8FCIOc04YoFnM2xtHz3jeWayQFW8jWNWgLFHLgnMfg+BbV+aVBmXlquLA
         sRQbW/g6J9KQYo06/GKCrOiffoxZh9cVKsNAmXlYQj8hS4SwB3/9/zCl8RDKbnx6DjkF
         HJfWpfgmg4CN295bCMhduJI01BJbtqPpuzcE9DbbuMVGNDbMZdL3XbDY5Y0enGxFeNn+
         8Vyg==
X-Gm-Message-State: APjAAAW/fofOc+hCPVsHlR8zZHzcptQWdCctCVgrRG4YTFqvF58iYTi/
        fEDkra3FaBYuvFYkZpXh+6mSDYZF
X-Google-Smtp-Source: APXvYqxN711Y7CHDkYUkKFLYQcU3TrbUpY+553rIMiyONETAJogcvyDdyKjl7Yriw/mpMaZjG6js5w==
X-Received: by 2002:a17:90a:ba83:: with SMTP id t3mr22363083pjr.139.1571580594143;
        Sun, 20 Oct 2019 07:09:54 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id b69sm14343739pfb.132.2019.10.20.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 07:09:53 -0700 (PDT)
Message-ID: <5dac6ab1.1c69fb81.3b811.4843@mx.google.com>
Date:   Sun, 20 Oct 2019 22:09:46 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 61dc10865eb5
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="slBqDWaYDrVZ"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--slBqDWaYDrVZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Thanks to QI Fuli, fstests is now gaining virtiofs
support. Also, some false failures on NFS has been fixed.

Thanks,
Eryu

The new head of the master branch is commit:

61dc10865eb5 generic/448: define BASE_TEST_FILE before _cleanup

New commits:

Anna Schumaker (2):
      [71bbff2a933e] generic/035: Create new outfile for NFS
      [61dc10865eb5] generic/448: define BASE_TEST_FILE before _cleanup

QI Fuli (1):
      [d28bf722e007] fstests: Add virtio-fs shared file system support


Code Diffstat:

 .gitignore                                 |  1 +
 check                                      |  2 ++
 common/config                              |  4 ++--
 common/rc                                  | 20 ++++++++++++++++----
 tests/generic/035                          |  4 ++++
 tests/generic/035.cfg                      |  1 +
 tests/generic/{035.out => 035.out.default} |  0
 tests/generic/035.out.nfs                  |  5 +++++
 tests/generic/448                          |  7 ++++---
 9 files changed, 35 insertions(+), 9 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--slBqDWaYDrVZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl2saicACgkQJlKqKVyP
52OQlhAAgxbruCyH9JCVr9Yg2DC0b9FDswEOl2OBgNQLsxNyrgHFukC8qQLW7arc
7fzx9mKNh73HgzyjsRMj6IPLDmCALrYUWu5q6X69UdpM11FUj1X4Ai/IBtlbqYkY
EeZfrrhUq2JMeqAHpufTNgy2PoYI0TkhUfau5jNslCDCKbsLlsVZxWVxybEmfXlI
tCWfjnO+OtKt92uynt6GuO9cSmP7D9xK0xPprL4Z7nWkP49IDBzfKps8dHsA4qjE
+gFzIqspLE/ENfst8c5fZ+H2m0eWynEC87RL+d2zK+5RZicECky6GmL7199/q4A/
5Psez4p3K7zzDIq3qcPBGo2t1js0XiAnfdkHM/Xzw780OLra9r1cu/8jK/toALTn
pTExIYw7+XRo8aMv/CNVjK/6UR3i6doTPwEFJCOv1bt6qmzhKtw03+Y2Wcn13XR3
Os2ja568i23B3l8rtMzHGGdsVLZsbPqRQB+a8pw4CD0XsfS3Q3wCun9jORFS2t9C
Su7RkwRPFfyAEqIf/Iq/QmNBVpSqdv83Dqb9LEKhqJsjDMVqtlfP5mSvPKdfosS1
S3qVOXNOVwOLRNOi279XY0NLe6V3MHw/pg45tPwpKldSiPN6Ez8wSp/gWgEiv66F
GBvi7wdVHsQ0B+geX6cD+BROKe3NwZlY5oC62Fj3K2AlK2eyZXI=
=Wj1d
-----END PGP SIGNATURE-----

--slBqDWaYDrVZ--
