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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996CDC433ED
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A357610A8
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 15:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhDKP1Q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Apr 2021 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhDKP1P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Apr 2021 11:27:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0CC061574
        for <fstests@vger.kernel.org>; Sun, 11 Apr 2021 08:26:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k128so5367058wmk.4
        for <fstests@vger.kernel.org>; Sun, 11 Apr 2021 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=y3d0fKF3uN7hRla63n1sFdrArWw33MQK+OrpufYdYXY=;
        b=Wr+7/NPq8LXf1BOkiEqtY3IdF7D6aiRc+H5la71rqfiAOxffZAc06vVDZ2eE7gTHCw
         +2vFDoIWciQFEjBAlPZENXxe4vSWGjoQWwsa2qI4YBnPQ/IzJHiywO8GIpOXOAk7nCRH
         /vgWQNIXQQAJur5Ksiw+g7vL+azvvbhsxQSTJjV7sldKZyj5GH+j9IhesYjDmHEQJHvK
         byBLTEUyjTpc2WH/cuF/tJATZpfuR3HaEqyWKETJAdF9aFif0aeu2Zu+fMZ/Du3jeTn2
         +qM31kY7E7ygmTPzKqnlsnjdgYsnDq0R9rY+TVcwAeXpZz3jXHS0cSq1GTYWlOlUgjqX
         x/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=y3d0fKF3uN7hRla63n1sFdrArWw33MQK+OrpufYdYXY=;
        b=cYaIEjrMau439iHijBhKfyxAMDHDkh3OLCf0dTSZCwR9rffly1xVU5VUxizVbGxaqg
         4W0WR3qMBSygKNO52WJLUCQD/QfIdA0+aoXrVLhhGGweYO7uDWeTpn5fMgfcoi0X2Cbs
         Sf1xhxk9tBiREakt0GXslvCiprSO3ZDPxQ4CuzP1qdYRlJVBESf91x1Ya2eoKpZ6fDni
         glqZtlcFlaq5jzu/sgNpCTEKClrlGk1P6WbAxgsuaAD5dyWnr1MPlHznCDpBtC6ZBrwt
         4UQPE7TsGhr25n+dOMn+fUFawrogEYFaMnsAlNIzUQ5kyqNBjJeJfxutnJrkhrHmdE90
         hsbw==
X-Gm-Message-State: AOAM532lt25lcApTJIdPyqkQfVoebiodY1LjPDt06wgSXVEItSoGGul/
        TvSr5ib+hP9EOip8nUABDkvb5ojFi9aheg==
X-Google-Smtp-Source: ABdhPJxIWYfONWd2nxN0vjFVmeBwV4E4HlYQW8AUe+C9P1Pj1eCm1hFmWX6OaSTRdMKXlC1e9IUfQA==
X-Received: by 2002:a1c:c2c2:: with SMTP id s185mr2130297wmf.33.1618154817571;
        Sun, 11 Apr 2021 08:26:57 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id b5sm12867307wri.57.2021.04.11.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 08:26:56 -0700 (PDT)
Message-ID: <60731540.1c69fb81.ad640.17d8@mx.google.com>
Date:   Sun, 11 Apr 2021 23:26:48 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to e3b376a1680e
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gqPdY6uLzSMi"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--gqPdY6uLzSMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Though this is a bugfix only update, there're plenty
tests get fixed, and most of them are xfs specific tests. Many thanks to those
who contribute fixes and/or help review patches!

Thanks,
Eryu

The new head of the master branch is commit:

e3b376a1680e common/xfs: work around a hang-on-stdin bug in xfs_admin 5.11

New commits:

Brian Foster (1):
      [bfc810719b1d] xfs/502: scale file count based on AG count to avoid thrashing

Chandan Babu R (3):
      [f3172bbedcf3] xfs/529: Execute chown on an existing directory entry
      [172b311e6f43] fstests: Fix tests to execute in multi-block directory config
      [febeb7ec8bfc] xfs/53[238]: Disable realtime inherit flag

Chao Yu (1):
      [3188255e0759] generic/629: add missing copy_range command check

Darrick J. Wong (3):
      [96450234b2e9] xfs/23[12]: abstractify the XFS cow prealloc trimming interval
      [3750c2698d93] common/xfs: support realtime devices with _scratch_xfs_admin
      [e3b376a1680e] common/xfs: work around a hang-on-stdin bug in xfs_admin 5.11

Xiao Yang (2):
      [72ba8811b0a2] generic/608: Remove drop cache and umount & mount cycle
      [70b22758a887] generic/608: Add new regression test

Zorro Lang (1):
      [d228f2147085] generic/233,270: unlimit the max locked memory size for io_uring


Code Diffstat:

 common/xfs        | 37 +++++++++++++++++++++++++++++-
 tests/generic/233 |  6 +++++
 tests/generic/270 |  6 +++++
 tests/generic/608 | 68 +++++++++++++++++++++++++++++++++++++------------------
 tests/generic/629 |  1 +
 tests/xfs/231     | 13 ++++++-----
 tests/xfs/232     | 13 ++++++-----
 tests/xfs/502     | 13 ++++++++---
 tests/xfs/529     | 26 +++++++++++++++++----
 tests/xfs/529.out |  6 ++++-
 tests/xfs/531     | 11 ++++++---
 tests/xfs/531.out |  9 +++++++-
 tests/xfs/532     | 21 +++++++++++------
 tests/xfs/532.out |  6 ++---
 tests/xfs/533     |  4 ++++
 tests/xfs/534     |  9 +++++---
 tests/xfs/534.out |  5 +++-
 tests/xfs/535     | 11 +++++++++
 tests/xfs/535.out |  2 ++
 tests/xfs/538     |  4 ++++
 20 files changed, 210 insertions(+), 61 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--gqPdY6uLzSMi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmBzFM4ACgkQJlKqKVyP
52MhoA//Zh/Qyr49RhkCiivdyCBqm0DPTwXsmzCTVFCtmeE+YwrQSW8N6obgpvN7
I7zThSTRMmKuKrLe8P11egoJncgCUh/WalPgeHkm2VDDq7kNSOYuqOlScjn6F4Zd
PpMscM3WhXpv6/+BeUiQS6lmYWotLOpIcM1kThzBHPXoKiQqF/0qcW+hQ02s+0Kl
AIj5wPrSiejFu+zGnSvAo/hMQ4ihbhyMH5/FHkfNiuvQqFq+yX/yWbzi9jjLM/P9
Bn6apaBtBYV9PZmd0UtgPmoFpdjE0GYnMWE1IGNYaRSBpAw9GS9tutCxCGGpt22x
wf/xB3MzmD9/dW8r3NFdt4fCPNymkVNWfRqvBSzLpgvsYKzp2LBHo2n0HHNt2r+M
bwV4sOtJlhaJlDd9N0fpBs23a45UGyn5g6w0Q6MXwBS0gNzClbPcR/gb2tOtLktJ
No+6EOQgJYJxzsCaue4WVTPKJXkLHjgSignIszFtj0G6Bp9WA/tQ3s6nUdV8FXMN
Q6iFA2sswbktp01YXTG3FFlZeoYLH+iVBgfBa2rSHHQbS6SsDTdf+jbOAAhrbRgr
5sNCdv1wrRIAbfMw/UuI2D3uTnLWlFP6+lr7AnG7yFP1N63YpS4yALjYXlF77dDT
jpPcbTM9vagoaPHN9Fbit3J1j2mpVylxeKKuKnhGMgu8+Ani1gI=
=2n9m
-----END PGP SIGNATURE-----

--gqPdY6uLzSMi--
