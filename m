Return-Path: <SRS0=beki=35=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEACC35250
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Feb 2020 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E60D20715
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Feb 2020 16:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjIPlWg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgBIQD7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Feb 2020 11:03:59 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:36888 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgBIQD7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Feb 2020 11:03:59 -0500
Received: by mail-pj1-f43.google.com with SMTP id m13so3097872pjb.2
        for <fstests@vger.kernel.org>; Sun, 09 Feb 2020 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=THRGL4klm2DalVWBeaTKivP38KxQ5hGV5H6/KuuFWmI=;
        b=pjIPlWg3PhMTEsl04lK81TEUMZPOqQ4OafUscNDxz5iy6qvzJEp536fdAIgH7A3NcF
         6ugLMP6bGvC+D2v2cJaD8fGjiyFLxkbnl+9zDA8dRxbBrpDYsFsEOdn+KBL1Aww39jZO
         gmJCCWfE0DXJ0gtVcmSr1RBgSiLBz0fwFIQrzQfy8/Df8PFntxdx+EBgMi6bccAEJsLa
         VR+9hbiSGHulabmiLU9gPH0SFYsxriPAH2yWn2iNyCfnWtegy1/nhCV5og4PqrpN9Rm8
         U0EdKw4RFWudY4amd2cI200pf1ToFAbG/jpXzVmPc+D0Q1IzL2K581tlPFPZrMpYbJhU
         9uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=THRGL4klm2DalVWBeaTKivP38KxQ5hGV5H6/KuuFWmI=;
        b=ISZvziUbVk0W6kavBp0KUnJ6ew1a6jP9gLol2lpCVIZ7QXgK0F5F/efATjRcPQoLt/
         eHCS+HtlcQ6JybuAsndbQdw0apPPahxWAaqTjt4giLQXUwCcKZpStA16rtUjpHhhI+OI
         MZMl3QF4ZvwYBKA//Q83F8tpCDeLg+jU/HTsRew0jU4ltKUF4i0RbnekTuJaH+LY4DFV
         kYg3tLp9weufI7TWrfSn/fK4A1tIphHQgwyFWv8NlneUeeJopEKda990d3edsDpP6hSR
         GCq24eRIoOrX+irrVuhxWhK1EcsFrsSNklP75ttxrlXWTqRIOkXUz2tg6rWSLDtroTZU
         s87g==
X-Gm-Message-State: APjAAAUbE12LXlsrjHZmKu6XIcqidTphvsKs/WeySIbBl0ZqcptfEdM1
        GwwOw9gxeiYF9V/VoCAKLFikulyY
X-Google-Smtp-Source: APXvYqxMnEvoqDBkjZjSVLHa2mm23Q6NbMwRdqmQIIFBf5a+gbWj/WgMCoJiH5n5h362Rxucj1xuZg==
X-Received: by 2002:a17:902:9890:: with SMTP id s16mr7983969plp.77.1581264238802;
        Sun, 09 Feb 2020 08:03:58 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 133sm9537348pfy.14.2020.02.09.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:03:58 -0800 (PST)
Message-ID: <5e402d6e.1c69fb81.a5f7a.9694@mx.google.com>
Date:   Mon, 10 Feb 2020 00:03:53 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 2806589445b8
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pSJeQKFoP6c6"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--pSJeQKFoP6c6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the patches that have been
reviewed by someone, which accelerates the review & merge process a lot, many
thanks to the contributors as well as the reviewers!

Though there're two new btrfs tests and one new test case in generic/527, but
there should be no new failures if you're testing with latest Linus tree.

Thanks,
Eryu

The new head of the master branch is commit:

2806589445b8 btrfs/022: Add debug output

New commits:

Darrick J. Wong (4):
      [1d22275b06aa] xfs/449: filter out "Discarding..." from output
      [13a86fa73d52] xfs/020: fix truncation test
      [1f3f20c52f0a] xfs/117: fix inode corruption loop
      [05730e20c354] fsx: support 64-bit operation counts

Eric Biggers (1):
      [1c5c2aa7f6da] generic/581: try to avoid flakiness in keys quota test

Filipe Manana (2):
      [c0679253bc14] generic/527: add additional test including a file with a hardlink
      [8a861b8faf1f] btrfs: add test for incremental send for file with shared extents

Josef Bacik (1):
      [2d4500367c5e] btrfs: add a test for the btrfs file extent gap issue

Qu Wenruo (3):
      [f41020d7f026] btrfs: Use word mathcing for _btrfs_get_subvolid()
      [9e2be2b1330b] btrfs/022: Match qgroup id more correctly
      [2806589445b8] btrfs/022: Add debug output


Code Diffstat:

 common/btrfs          |   2 +-
 ltp/fsx.c             |  54 ++++++++++++++-------------
 tests/btrfs/022       |  19 +++++++---
 tests/btrfs/172       |  76 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/172.out   |   3 ++
 tests/btrfs/203       | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out   |  25 +++++++++++++
 tests/btrfs/group     |   2 +
 tests/generic/527     |  26 +++++++++++++
 tests/generic/527.out |   4 ++
 tests/generic/581     |  29 +++++++++++----
 tests/xfs/020         |   4 +-
 tests/xfs/117         |   2 +-
 tests/xfs/449         |   2 +-
 14 files changed, 304 insertions(+), 44 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--pSJeQKFoP6c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl5ALOwACgkQJlKqKVyP
52P9dRAAsIaOSLgVvvWj6g/M9KmzF/pffu/BHGG1S+y+dYOjPEm9mOxaXF0r3c3E
pzZeL8GMtF0N0CZwdxWX8AdUxx1Vn0Iwujv8YqtZq+4LUxk7qS3I0+69qcXu5BUH
c3mDB6PLLmsJAqJGC4JShn63AUvgacDIJjhwdK+mIqhSxvt6cuN8iXPBU90Z7qb7
G8PlWmclQOZSPGSrcqMkzbQRfxQ6vuTFZj6QfCQDsUYj6Glofsrivnw9jTDkY4jm
sBZbxH86X5ZymBvA8rt3uUIP72TVlC52k6hSaluvrH+V23JDjU0T5G/yhCGqXL9N
Eu7mvZ18ewibKi+ydSjTsj9IAhkVVuT73D2JMNf4K5YWwUWiJhVcwIhrBocpltNf
maAWqNSx8GVSry0iEMmA2evWdvG6Q0WvYICWN05vemuNGB/vRz/RGvb3y4JPq+IQ
NYf6ZxKj+Wzhgpr2gDLhsFQKiooxDvyPVhELhKQKZXttfPhk4RSzfjm1AMkhK5fL
XcVYvFStcCyX0zZNRYNwxiGiuQpdlWKdItyJEfK/puUC+1AOPsCwD0F01VYwTJU6
Z86MI/3FJIGvkDv6l+6Kl78no19TDYRZOCk/4J8GimzMsE7Zj9vuGo4WmxQ2SfzM
+uKGm/2vgzaA0vR0PTvEF0o0q+YHN7QyEeSsTABR15MjKC85c2s=
=iksU
-----END PGP SIGNATURE-----

--pSJeQKFoP6c6--
