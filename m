Return-Path: <SRS0=JK2a=7N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7E5C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 31 May 2020 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B862074A
	for <linux-fstests@archiver.kernel.org>; Sun, 31 May 2020 16:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj1fHVk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgEaQqi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 May 2020 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaQqh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 May 2020 12:46:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E70C061A0E
        for <fstests@vger.kernel.org>; Sun, 31 May 2020 09:46:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y17so1474999plb.8
        for <fstests@vger.kernel.org>; Sun, 31 May 2020 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=E/IAXmZVNaLpriqhD+emitFHUWLv4uwCzRZC961vsrA=;
        b=aj1fHVk0ScmqbrahQaFEC7LjyvTkI/sWCG7skY1ED8voFC6rbZ5leDkv/8A+YXaidr
         NTxSXBqpyJdf0hKKChFst/ozZbr2xkjckLcqEygVee4I5AP/obKH51T0jzufW4zmAl++
         RT0Ok/fJB8EfsJDftEYcB9t1rrhDZNOrsoXw4gPW6jvKpMCTH/NcgfLSwfkgZzmDG1ZN
         +qt7aNU+Pcp0F5o7P2afVmkmQVGRMvzCHysiBT7PZwkX7oyh+LL5fxWxPlVtrHMB2fjt
         Uep7KmQTqWPypmUPqNuvdJbniuO2GEkIZd4Kh7gRW9Ollpc8d2Knqp21sZiSUA0aWSio
         Bm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=E/IAXmZVNaLpriqhD+emitFHUWLv4uwCzRZC961vsrA=;
        b=qWkOGzvVfJmDNGoix8g48Vd3VOGuxWYTl79ELpYOYZjt2o3PUoYcuNbPbQUdwqSxdD
         t7aemAFrzC/S+jWUJJfZMj4IRLrV8NeO5OHCeXFlyz8o3Yc6HNaZV7uAzWQ5Vs0gozCY
         IjZBkm0He3eRNUT0fbKCfRRGrGUIJhypcqMdeRgR/2JV7L2ypeeUUSCW4JYXvR3HqsaM
         raihJ+w5je54vVXBASmmrpYlOcM6A+vl/toXbdvhfenoBifW1Ky28xtXCkbR+KXxxERh
         UG1NvtMCFaPXX6DqfIwRoFMs5qKCPT70Z+ezTf4VOs94LA4wW6lV/UX09KFtFM/5NufX
         K8GQ==
X-Gm-Message-State: AOAM531TdNZj36FhZySQgLZm1MjJDkz8QJp0NFHHHGNxX6NC/ClGWb9o
        xVkBNDFRqqsXTdIYkVsoZqmg9BhK
X-Google-Smtp-Source: ABdhPJyLwL+dQ4/u2TooBwDiYaQK9qUt1a3qp3uytahxGPgtsrKTg1A27BgIC4RMc/LViuhU9vV9hA==
X-Received: by 2002:a17:90a:7ace:: with SMTP id b14mr16934367pjl.116.1590943596946;
        Sun, 31 May 2020 09:46:36 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id o18sm4464557pfu.138.2020.05.31.09.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 09:46:35 -0700 (PDT)
Message-ID: <5ed3df6b.1c69fb81.22c85.6b1c@mx.google.com>
Date:   Mon, 01 Jun 2020 00:46:29 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to d1d55692f64a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WpabIMeUl8G8"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--WpabIMeUl8G8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're three new tests and one minor bug fix. And the
tests in generic are reaching 600 milestone!

generic/600 currently fails on XFS, and generic/601 currently _notrun becuase
xfs_quota lacks support to do individual grace extension.

Thanks,
Eryu

The new head of the master branch is commit:

d1d55692f64a fstests: individual user grace period extension via xfs_quota

New commits:

Chengguang Xu (1):
      [155efc41eab3] fstests: test data integrity for rdonly remount

Eric Sandeen (2):
      [5eca07298f5a] fstests: individual user grace period extension via setquota
      [d1d55692f64a] fstests: individual user grace period extension via xfs_quota

Yang Xu (1):
      [62de524d104c] generic/484: add _require_xfs_io_command "syncfs"


Code Diffstat:

 tests/generic/484     |  1 +
 tests/generic/599     | 54 ++++++++++++++++++++++++++++++++++
 tests/generic/599.out |  2 ++
 tests/generic/600     | 69 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/600.out |  2 ++
 tests/generic/601     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/601.out |  2 ++
 tests/generic/group   |  3 ++
 8 files changed, 213 insertions(+)
--
Eryu Guan
guaneryu@gmail.com

--WpabIMeUl8G8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl7T3v4ACgkQJlKqKVyP
52NCzA//TK63o/YVuI8+o1WxhFBV5/r/HRpA8zHY6h+HfblhLnCC80z00AciurgA
/gWzJndqX/9uB9W/BKxrKsjtv7KbMOYj80GoR4opc2iSHK2ALdVXUSjfLXaKQJjg
mP5/vfOnEi9gcp4CloX4OiTS3WYMoXadYUey4s6EB9ffWGs/Y02DUeHP1r8s9AFT
YO1VQ6eOZzpZb8ZZZFFKviDsHAUvPQuFD4ti8DRMnMQPFNX6FtzAHzfUF6nhPBXU
UAbRtJ2trFBICaUylMo8XZ2ndB09fp4xHWvuP1vzGbe1EPy3x0+VHl/oVcfKvyu7
NNQa7fRYorC1clydXXeqlD4750S8aELg6MQ0hFTo0KGfp7mq8AEv9uHho74l9fSb
x84Mo8Wwu0s221cvtFsm0+g2GP4QXwqkhGbLtH9f+Lb0xUfU1HfuUL3EzqUMUyYx
7j+E+NqeMFXbcNFfVWeZ4+O1xvPE4dPV1KaZUJjd31F1D8Ds3FqdM0tHdcDgf3WZ
1F4oYqP+h91pcbtFGxqYT3o3a26SHH58ovXOXh4CqByhhO+sPYNwFLc9R7hNOrsy
GSowTy91Teauotg5VevdHs0YpLm7nsrangjvHDt8D10z6qsDz0/qL+QBA48bFxRJ
kwuyW/ma3e5UP0hF2N2XhXBmU8ETetg1PRgJ0Luphi6GqnQgv+A=
=KcnN
-----END PGP SIGNATURE-----

--WpabIMeUl8G8--
