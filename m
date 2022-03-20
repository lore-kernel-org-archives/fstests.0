Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D1FC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Mar 2022 17:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiCTRIW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Mar 2022 13:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiCTRIW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Mar 2022 13:08:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C1654BF7
        for <fstests@vger.kernel.org>; Sun, 20 Mar 2022 10:06:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so17955806wrp.3
        for <fstests@vger.kernel.org>; Sun, 20 Mar 2022 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=hBegM9WqGOaySGWAOBDlbbnXCQv1WXgf7tBFNWC8QDw=;
        b=onEePhsQ9hZ3EVzqBqi2MOfD3hLH0+EWwWnY1xGhbj8qogRh3mRocjE4TKgJ3OPZXs
         q2rDsa7ev/+cWObMPrLGurp2NILVZ/If4NwSiVUbL+xZpU523WDrTZ6aCBmqKBudnoeW
         /WGzd+f0SL1S4fbFnijZ4DFWzU8oSGD7CJ6ho+VM8/m3wS0J+LJ90eoN5R4AsO5/WY5k
         NzLhWjzrMI+Edft0rO1hz6acIlpEw3uGJGMJ+AEkRtoSrkOVcODanxXdfjoM6ohHNEU3
         ykfwx1WRvKQQIgJ6nUmt0Rv9I73LPSh1Fi0m1ie6qN+6m3nuIevV6DKbxcGtJUTVRXYI
         ZXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=hBegM9WqGOaySGWAOBDlbbnXCQv1WXgf7tBFNWC8QDw=;
        b=jIWJkPyQHT0GfIa7NoqnGYdnf39d7fOLa1/S5KXdHc5B+xwmihhAgw57UtwqsIcQNZ
         RKiL5cF/qR4oJ34blcmw/38cOCN/9xgxWmKto/39M9iYuNdRxfzkvk94BTNSBxbP67vx
         lOEVeQ975yI5TTeqFeBuZO+HWhyE/27PmZZsdjg4ApCw1+btJ1R0TXOoHXpj5+CQAURo
         +U1y7ucn1x13YtZYJ2gMAXC54gaTOWUSDTCFifu8/uIrVC3uvNE7aJ0srh9BRqMYixDU
         f93NN6Ct35ZUjCruCtOuSr2yMAZVGlqX//G0EY++R0cAvr7XU/ig29FZ92fh37x9Dkna
         gP/g==
X-Gm-Message-State: AOAM5326h0gLdX++yOJqEPCwb8nIlbPO2Zj9zPosmXXiRjtKhzZ46a40
        huMDNPbj1xteHriQkaPzAoV9LX6XJBQ=
X-Google-Smtp-Source: ABdhPJxthhIj6kid1pveObX79Zk5PbRJf7EY3QfZGFXtgYNL0T5T0KyVNVKyiOlD8/7PwpktIzd2Vw==
X-Received: by 2002:adf:db82:0:b0:1ed:bf4b:e327 with SMTP id u2-20020adfdb82000000b001edbf4be327mr15013207wri.527.1647796016158;
        Sun, 20 Mar 2022 10:06:56 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b001f1fa284a32sm11111138wro.115.2022.03.20.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 10:06:55 -0700 (PDT)
Message-ID: <62375f2f.1c69fb81.50213.a0e8@mx.google.com>
Date:   Mon, 21 Mar 2022 01:06:51 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 1ae79d2ecdac
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TnyoyDNgSFXz"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--TnyoyDNgSFXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're 3 new tests added in this update along with 2
minor fixes, and only btrfs/263 fails on latest v5.17-rc7 kernel. One notable
change is that btrfs/261 has been made generic as generic/677, so it's not new.

And it's been a while (maybe a month) since last update, as I had urgent
errands to run in my family, and I had no network access nor computer by hand.
I only picked up some already reviewed patches in this update, and there're
more patches to be reviewed in next a few weeks.

Thanks,
Eryu

The new head of the master branch is commit:

1ae79d2ecdac btrfs: test that autdodefrag does not rewrite single extents

New commits:

Filipe Manana (1):
      [cda30840132b] generic: move test case btrfs/261 into the generic group

Jan Kara (1):
      [6d376c570228] generic: Add test for seekdir

Nitesh Shetty (1):
      [e076938451ce] generic/108: use sysfs values for logical,physical block size in scsi_debug

Qu Wenruo (1):
      [1ae79d2ecdac] btrfs: test that autdodefrag does not rewrite single extents

Shin'ichiro Kawasaki (1):
      [7fad8609aedb] common/rc: avoid mixed mode for zoned btrfs

Sidong Yang (1):
      [0d2a65f3239b] btrfs: add test for enable/disable quota and create/destroy qgroup repeatedly


Code Diffstat:

 .gitignore                               |   1 +
 common/rc                                |   8 +-
 src/Makefile                             |   2 +-
 src/t_readdir_3.c                        | 238 +++++++++++++++++++++++++++++++
 tests/btrfs/262                          |  38 +++++
 tests/btrfs/262.out                      |   2 +
 tests/btrfs/263                          |  92 ++++++++++++
 tests/btrfs/263.out                      |   2 +
 tests/generic/108                        |   5 +-
 tests/generic/676                        |  41 ++++++
 tests/generic/676.out                    |   2 +
 tests/{btrfs/261 => generic/677}         |  35 +++--
 tests/{btrfs/261.out => generic/677.out} |   2 +-
 13 files changed, 447 insertions(+), 21 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--TnyoyDNgSFXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmI3XwQACgkQJlKqKVyP
52ONEw//ZVHf0/NR0pv0DmbYWrc8NQePHsRE3Z0tj9zz7UZtAhAW57BxhJfIhtce
fy8nFzB/4hgcu7z8O624CfVRA0VldCr3CbUlGKmsphYXHTVdLHAkRnutfWAa/2za
W/sIbioj23OjQKaAVQ/fkTUSovWqHDLU7P2nZQG0Yvcov7xrzHRyANLKhy6iGixU
B6rxS4dXo9waO7N7rzuoG1AkRx3fGwUIYVUeudHEnofrRt0Ujyhy+9W+iKoVscRw
5fL93NT9gE73TUSBbZ2q3+SxeoxnAWrO2G2MS0VL386IQDxsINdGTkKl9jftr/2a
ucZklafuD3q7qcvCtbsOd5GXXETNIJMyEL8AZlzgFajriA47yLQ1F2wdd4ZrBVEp
3TXRhm7v4ekvnpUciSyT0Og//rVNdiUtiZDq50iXlBpK/xwLk01kMCejXSgH0HWa
PwVLOC/eLtj99zTXR7hmFkf1VQi21g9eX9mNm6OEvUcsf3MPASm6P3ShOS0pWzZ6
TJS2eV2eb3sWcOAmyyEbIAGawsOUNEseaM+mwSGU3D48XHHeeT6PicaHGSWfXr9J
+0i8M1w00RdgfQdqpmmsHF4jk88FZXj91/b2phi+BFMZbWy/EPp/84Yg89LcvcWS
jF1ZkmFJmPsAySwFSJOpz1UwY5A+quafpOCktC6npUZKALdNzz0=
=pAAj
-----END PGP SIGNATURE-----

--TnyoyDNgSFXz--
