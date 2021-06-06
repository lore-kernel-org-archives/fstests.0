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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0A9C47096
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Jun 2021 14:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F736127C
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Jun 2021 14:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhFFPBZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Jun 2021 11:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhFFPBX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Jun 2021 11:01:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52AFC061766
        for <fstests@vger.kernel.org>; Sun,  6 Jun 2021 07:59:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f17so8314986wmf.2
        for <fstests@vger.kernel.org>; Sun, 06 Jun 2021 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=ZltecoAVic+HuO1C4fEhb/2DurY5VCOIxQ389IOazBo=;
        b=ZU9yYXAk9mvHBhbsiztQ7xXISERv/2P9lgnjJ8u9cDu4xUQ/YXSsjU7/jMT93bzckJ
         ASJ1LuCqzCOWQHmzLOBILHRyBY1nQDcPZ0Y98i8V5c163JnWTzM/hriiuPx47J6plxIZ
         98AI8QmqU2zfRrBQie3D67rxr70n2lZPrcH9JvFoBtlFDaMPJ/LxWDPzB6PlQmEGJ4Pg
         qLnSWmeAzBk6BeWNkoIFYDoJGWaC6gTW6BgiZQ3hFPriYzvt77WDuBL8rAk6bjoTk84h
         n4sXERLLvp3Fc1qNwZezBfz7X27qkwcz06HWl2s/9TSJ58x/eZnjtAlhu3TI9TBOP4C3
         jdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=ZltecoAVic+HuO1C4fEhb/2DurY5VCOIxQ389IOazBo=;
        b=DiNfeGIP1noUwiqXC0hUJSh8GzLTdjsC4R5HDvGvW6DCGIwdi3KziRi/7tCeSK5mQ9
         okEtfIc65np2uxDMc+lmmu0Xv2fL1hfvJNREujlPEcspDWix0oWxbII06716DuaL/RnL
         DK4g7PO30e7jp4P/b5VEsfPbua/MwNfdyy2lRrSAGijkBBgbqAwuKV99b54/AWWMfIM3
         r/bgX1oLI38cVYNczsg1btDEnnHjFWVDKY1n6okOQoL9J1NbdXmxKlNE51AeiNe2hA6c
         SGtRcHNbZXGXPt4CCEnPPOEApaapD7b42XH8Yy8qsnW3twzIPfK6R1lCnYbzsMU5hoKI
         KWyw==
X-Gm-Message-State: AOAM532Vqx+bJLdwlHVr1tEgZxomV7fJhFLry/czbSpHA9eUtnjIyNSb
        JUVHn/LpJRV57BTDAjZGlAV19SLYcws=
X-Google-Smtp-Source: ABdhPJx4FryG/Xze++1OUL0CPr+Hik8qBNPBcvjmeTo6CGYMDtFhOCUDM0RHvJxeJPJgSfHjOjQQAg==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr12611694wmj.63.1622991555912;
        Sun, 06 Jun 2021 07:59:15 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id g186sm4902711wme.6.2021.06.06.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 07:59:14 -0700 (PDT)
Message-ID: <60bce2c2.1c69fb81.10ad4.3333@mx.google.com>
Date:   Sun, 06 Jun 2021 22:59:11 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to dd562778ca93
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ljhm1k5mZfao"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--ljhm1k5mZfao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a minor update that contains only three fixes.
The auto-generated group fils patchset is still in RFC state, and please leave
your comments if there's any.

Patches are often got missed, please re-send your patches if they're not
reviewed && not picked-up.

Thanks,
Eryu

The new head of the master branch is commit:

dd562778ca93 common/config: remove default 4k blocksize from XFS_MKFS_OPTIONS

New commits:

Amir Goldstein (1):
      [91104670c94f] overlay/075: fix wrong invocation of t_immutable

Anand Jain (1):
      [ffc8893a6687] btrfs/029: fix the test compatible with older cp(1)

Zorro Lang (1):
      [dd562778ca93] common/config: remove default 4k blocksize from XFS_MKFS_OPTIONS


Code Diffstat:

 common/config       |  1 -
 tests/btrfs/029     |  6 ++++--
 tests/btrfs/029.out |  2 --
 tests/overlay/075   | 12 ++++++++----
 4 files changed, 12 insertions(+), 9 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--ljhm1k5mZfao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmC84g8ACgkQJlKqKVyP
52PLVBAAta7Htwk3xB4K8Lw5eGbdZ11mgfgyqOFfpEiyjiajW02l9MUPSmLuAlbw
ZlZrbMTfLK8HzX8WWLaZ/HZtsQFG1XP41EiKnfpc2pOAqSV+kNBaRzUcAnvN15ph
cPuqsFKtHjOA8weSvyYovaO5SauM17xj+pruk6xcrc2cu/gmaLd4QXBR/QELZYmy
SzS38RGSiKB72o3eknfHNu8wAtuge8W49iM5JN0A0bAWJJXzMB4yUkV5ZP6N2HK9
tjjBgmdPQa6Tsay5FV6uSZpiEhoeYBLUyARajZpf8S4j9JBl0qJ85KDqWlRUFdjW
VDq6Cm1KTgbY9k14EDC/cwLsndZJihmdx8hyR0vuxnVfZv6zWjvF8Ls+Ku6dcogd
f+dnnLwsdv2R+zCNkVExuzbrswUuUZKXOEotQ6LWH5Sj8Srs3iJZTi+Cuv1NTt76
JbFXuNZxh93WKc8/buHN0gdQoxUva4h/MzSslxyJ56PndLhYymj/8UnG/L8N+yPu
hiwst6swzXY/Xnh0re4g7CSKUdlu6lF+JjJ/tnSBASkGJYb/8VeCbvSb9sBBDQnt
wDaWT2sndmiUOlZnlW58ldR7p83fjvI5aS0+qmUkusJvs4hjyF2u1priM++fLNvz
4GPEeLObr3j3DgKxn0gIls2IRIZYYEmgCtz+6LpHAMLyl16phrs=
=8lSu
-----END PGP SIGNATURE-----

--ljhm1k5mZfao--
