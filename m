Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84FCC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Sep 2021 10:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD286121F
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Sep 2021 10:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhILKvg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Sep 2021 06:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhILKvg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Sep 2021 06:51:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CAEC061574
        for <fstests@vger.kernel.org>; Sun, 12 Sep 2021 03:50:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y132so4473503wmc.1
        for <fstests@vger.kernel.org>; Sun, 12 Sep 2021 03:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=L/VanWyaXoUwICW8VnGeOQNXJoWQ5BMN6HDrs86hUXc=;
        b=bIZEXHzahfYuMImLlC2YDMhNA3v6UiPQIX+1IR2rrb+5qoq5IKlsmxslKLm9qZ7RIv
         t7xbN1DtJBFR0wBQGFb7JdHHu7omW6Ija18CHjoDs4eshddI3YEO9bbGq1IdhkM2mcEj
         IpdTRBnR0ELzIZ5zjQ1ZILkbsQMh6TXbOZYS5JN78JDhFD1W28gtpUg2iWPAAZqiAjcr
         0QYTy6XHcrkfRFXc2QrKRUYsIZuvhmYc3noaeW6iJ/RSpe4HJKi1uJR9xhCv3iViFWEx
         u2v2ZJacyQOMyByquCjLAc07qHmPXbBpppa+AO8VfJWp1Ix53DBUP1DSV2ixYEc3PJ4C
         rKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=L/VanWyaXoUwICW8VnGeOQNXJoWQ5BMN6HDrs86hUXc=;
        b=p68I4iJ6WCQ0aHNxQHdUdPf0RoMG3cJIlU2dzUTVn8ZIMNpDmy593qhEd431EGUeRI
         5EXExyl4Qu5XvyAqCa8qH4oHJMHbzR0OaTyU6YPH8Q3ITx1ovzC/fq9zJUU2IViLqiD1
         bbY0/2ejXAIYtdk3P6dN2xPfCC/2WnpUqHE8pBjWKB9jyXnKiutpn7r4wv72HeYTxKo0
         E29MNyyhpx3z0XjpbG/R9OtRo5V0fh1ZKgP/AQo8mkthMwN0yCT0pUrVo/zIt8CCgpne
         vLfIYN6HB3Hg2wxLduOJp7kDW5QxNLygPHXxCA8Mp5Js7EqOUOB4vXNHrublzNtRl+Rm
         bIag==
X-Gm-Message-State: AOAM530PAPwSlFzi3ogUSaV64B1l/GKY2PR5AySMRE7HyE4TpeCU7pGv
        x4HKV+0QTPlvQPjT2iMFCyqNsS9o9ZQ=
X-Google-Smtp-Source: ABdhPJyn7yktXpvtnYBySgbXyYOC720MShdBLPZqS25jH8G3V0ZKUbXHEdp2iWrxMClNwKRM9m3Qmg==
X-Received: by 2002:a1c:3184:: with SMTP id x126mr6087877wmx.123.1631443820256;
        Sun, 12 Sep 2021 03:50:20 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id j7sm5190110wrr.27.2021.09.12.03.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 03:50:19 -0700 (PDT)
Message-ID: <613ddb6b.1c69fb81.ecce1.5fa2@mx.google.com>
Date:   Sun, 12 Sep 2021 18:50:15 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 410a2e3186a1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZitFB35Wb7IQ"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--ZitFB35Wb7IQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly takes the rest of the new xfs tests
& fixes from Darrick, also picks up some random bug fixes. The three new tests
should all pass with latest v5.14+ kernel.

There's no pending to-review patches in my work queue now, but patches often
got missed, please resend patches if it's not reviewed nor merged in this
update.

Thanks,
Eryu

The new head of the master branch is commit:

410a2e3186a1 xfs: regresion test for fsmap problems with realtime

New commits:

Amir Goldstein (1):
      [bc26f13f6dfe] overlay: fix documented kernel commit ids

Ari Sundholm (1):
      [285c8e8a2d30] generic/361: require sparse file support and fix mounting the volume.

Darrick J. Wong (4):
      [fff8ae273534] generic: regression test for a FALLOC_FL_UNSHARE bug in XFS
      [d9f1b96b33e0] xfs: test DONTCACHE behavior with the inode cache
      [189eb6048564] xfs/108: sync filesystem before querying quota
      [410a2e3186a1] xfs: regresion test for fsmap problems with realtime

Shin'ichiro Kawasaki (2):
      [070bdc3cc487] generic/{628,629}: fix order of _require_scratch* and _require_dm_target
      [b2fdc58725be] btrfs/146: require scratch dev and pool before _require_dm_target


Code Diffstat:

 tests/btrfs/146       |   5 +-
 tests/generic/361     |   3 +-
 tests/generic/628     |   2 +-
 tests/generic/629     |   2 +-
 tests/generic/649     |  77 +++++++++++++++++++
 tests/generic/649.out |   2 +
 tests/overlay/077     |   5 +-
 tests/overlay/078     |   4 +-
 tests/xfs/108         |   2 +
 tests/xfs/177         | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/177.out     |  18 +++++
 tests/xfs/185         | 185 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/185.out     |   2 +
 13 files changed, 504 insertions(+), 10 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--ZitFB35Wb7IQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmE920AACgkQJlKqKVyP
52OJwBAAyZ0aQXnE1mtgTl1F9w3BAKFSRcrO7eTgdX9ngOl7ImbeUwTTjX3WeOKr
PoXdTeQ7lQZLImsLlwaO+/Dw7Hctza6KnHlWeSslVWlLP5PqVg1mz+IAdP0moyXO
VgB+pE0Wi3XNCfSVYslI3NJAM9aOuHP3uicx8XXIsm3f3BjDB0kJ2u9/BVmitq2p
XPBkf0SSHo0NJ6FuDurt6zjYhmxxZBygTeClitw9rM24uSd1ou5QCjGS/v7xNoAj
y+ix7g3AJ892smkw7cIFFvl7QwtifkzsMHmVwfzkiVb2mdNQXTo0QBGl6YefMixy
JHFLm43ZUl6h7iNxck2mSVhnx8YmfDFCh+wT81Gfw+nIgU8GK32JmREnLPiva2Sr
puZ3yb7dv36ZuacDew+Ixkyhu9rzIr6WikbcUJuszLPjqR1NdsTsoyZAeCwg2lmG
ToryzXF/cbXlrrY5akBYvwNr8a7CLAtVmiIRirtVUvjKUmpwmMqAirUjVJp4IBKf
7DCWDdpMqIZcpLXQueJHqkAnkwTw7/+6FmDQZWTxmqQgdMfViXD94X0ZmI2cjRrh
PSbQTDnws7DVNNqWE5YWIhsXe3tVqg9iLAAyRKm89+fRMVVwbiYLnVACISkCCGFU
QDDK9uXhu2KJ1dN34lNYBrvAmX2UVDT5JkkFqVhwljx05gC3ae0=
=gPg0
-----END PGP SIGNATURE-----

--ZitFB35Wb7IQ--
