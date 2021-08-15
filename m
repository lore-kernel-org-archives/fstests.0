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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53169C4338F
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Aug 2021 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E00E60FD8
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Aug 2021 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhHOQcA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Aug 2021 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhHOQcA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Aug 2021 12:32:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0177C061764
        for <fstests@vger.kernel.org>; Sun, 15 Aug 2021 09:31:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso13237111wmg.4
        for <fstests@vger.kernel.org>; Sun, 15 Aug 2021 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=r8PX4Osd1Bylr4DCb4mbMBI7+wBcNNp/FAIX99ch9rA=;
        b=jOpTyhgHaOwS7KCzOAXsmGSVwRgKEWiyIwWPNrJx18K56qWopOiYi67L3My8avpRVZ
         F1Wqzcy+ylVg+nIkDCiPvgbKibM1Z2pQ388sr78kAEmr7X1vYxYULeAJCp36l+h6MX7w
         ZcIHH/GuP9oTKl1qYL6cTntPEJ2nFCDUmfC+A77akIX+EXO4b56PDqMICBVz7zcYI39s
         5pIr9iQVi26oMcGz1emyjm8ULzpD7fYWSRik50CzONYyo0OiOW6Owp0oYOpN22oI0FVP
         7aOKDeBiPEfvJrx7HzXMz2TbDh5Rt9iAix+66ERY5UaeyGodzR2kvsQQBJqoI0Nt+msU
         4iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=r8PX4Osd1Bylr4DCb4mbMBI7+wBcNNp/FAIX99ch9rA=;
        b=LXnfBYKGnx81mw1seKWyzGpYVB2oSnl3/5SO4kfg3TWC460+0tjzcwzT87ZF4yepUx
         2ZGbBeN/wZzfQehdEAsmNKvUPSvIPbf8AQWdz2nyz6mubEQyP5vj0fpg3pgx+88PNUDF
         rOL4QJ6JbAT9aZ+SgnC1DipQtvJ1kbsNORmUnj13YY4u3LbRXVkIjQU58v31v9RCt759
         Na7lwH3NY6PvXzTJCrflTu/9xtinoG/mGM3CoCSr6XqXBdIVE20grnW9LegWHUOrnm7D
         2QD0e3Sf6SG9Z5job8wjUpyitDoT8R8hqayt0gbMA/fY/rMXwGhENcTHHJDsuqBYxkSQ
         9byw==
X-Gm-Message-State: AOAM533vgttKSOlskn0WXBDHrRlwG7H6staTvXxCMPVb2/qzmzO2hzKS
        4fY9mSkxqHZcIh8tnRVQwUo8ffiCa5g=
X-Google-Smtp-Source: ABdhPJwpCNivk4nxcUXmM8rpiTQJLMTBKfsMFrDyF4whLc8qEBGSa/CHg6K73xG+bwId/azspgC3JA==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr6979667wmi.54.1629045088129;
        Sun, 15 Aug 2021 09:31:28 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id c6sm4163258wme.45.2021.08.15.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 09:31:27 -0700 (PDT)
Message-ID: <6119415f.1c69fb81.e068.670f@mx.google.com>
Date:   Mon, 16 Aug 2021 00:31:24 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to ae8c30c34c51
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zCuQUy3n4o3l"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--zCuQUy3n4o3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're many btrfs related fixes included in this
update, they're mainly for btrfs zoned device support from Naohiro Aota, and
some compatability fixes from Anand Jain and Boris Burkov.

There're also two new tests and they should all pass on latest v5.14-rc4
kernel.

Thanks,
Eryu

The new head of the master branch is commit:

ae8c30c34c51 xfs: test regression in shrink when the new EOFS splits a sparse inode cluster

New commits:

Anand Jain (4):
      [705b0e60bcb7] common/rc: debug add _scratch_mount_options to the _scratch_mount
      [1f940e6e67f5] btrfs/220: discard=sync support older kernel
      [52e6b70d4681] btrfs/220: nologreplay support older kernel
      [389302e73e11] btrfs/220: clear_cache fix for older kernel

Boris Burkov (1):
      [ca71bde9fd8b] btrfs/220: fix clear_cache and inode_cache option tests

Darrick J. Wong (2):
      [96d4e404f188] generic: test xattr operations only
      [ae8c30c34c51] xfs: test regression in shrink when the new EOFS splits a sparse inode cluster

Luis Chamberlain (1):
      [d26e07ebb6a2] fstests: use udevadm settle after pvremove

Marcos Paulo de Souza (1):
      [5f883ecb049c] btrfs/177: Handle the different fi resize output formats

Naohiro Aota (5):
      [72699dc08b1d] common/rc: introduce minimal fs size check
      [40360a4264d4] common/rc: fix blocksize detection for btrfs
      [fc5dc62bdd5d] btrfs/057: use _scratch_mkfs_sized to set filesystem size
      [9ca8d2ac5e02] btrfs: add minimal file system size check
      [6b96c8995ea2] shared/032: add check for zoned block device


Code Diffstat:

 README                |   4 ++
 common/rc             |  19 ++++-
 tests/btrfs/057       |   2 +-
 tests/btrfs/141       |   1 +
 tests/btrfs/142       |   1 +
 tests/btrfs/143       |   1 +
 tests/btrfs/150       |   1 +
 tests/btrfs/151       |   1 +
 tests/btrfs/156       |   1 +
 tests/btrfs/157       |   1 +
 tests/btrfs/158       |   1 +
 tests/btrfs/175       |   1 +
 tests/btrfs/177       |  31 +++++++-
 tests/btrfs/177.out   |   4 +-
 tests/btrfs/220       |  65 +++++++++++++----
 tests/generic/081     |   5 +-
 tests/generic/108     |   1 +
 tests/generic/459     |   1 +
 tests/generic/642     |  57 +++++++++++++++
 tests/generic/642.out |   2 +
 tests/shared/032      |   2 +
 tests/xfs/176         | 190 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/176.out     |   2 +
 23 files changed, 372 insertions(+), 22 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--zCuQUy3n4o3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmEZQRMACgkQJlKqKVyP
52OxYRAAwWOoznERGMPUosj2CJFY1f+LWgRFzP0X0nraWDvJUh5cpUpw2eVu56wG
Vzs/KcGlolemEfCBa7BRFxVLyrkYRlOONHvo0UKQ7jck+z3uKsJzphAkzoC3s0Y5
brdy+sMwDSNRtOfbd+Cwwkgz+0LGXTY/eaUFdgHcwQqUswjR6VpRFXYEsewYK26W
19FcpMWhRSL3qome3vTaYNQ0QwqqpQBudZN2ps7aZhkhcqZhpezzF1fhCd6qTY87
VNQoM0G+3Ue3hmnGSZlEC2FsoawmTKKyfzZNzTmWNsXjHsrooelDH+enIGtnLVRd
FXkfAm3qBe9l2kEIAsyrlu+l/k8CvqMhNEQK/gT1zZEd0HYWbWmBej8n6ah3S7cJ
6747xjLaqYhbkTAvIoTG3CRUKIw83qBS40RVFJs11I7HmVwpvJ7XGZilyfaA4tgE
nqv87VdY9t4MPOuEAchW0AKUt7mvazSyd5QUvUslQ+2B2OwjjcCHQ+Ql4iFKi1mi
PiIwpEk4JvcQF43L6Zeby/rp3R2RyJHdVJIHbKAU5gjT8ejQvSdJ9bxdMSh8ZBTy
tpPkmk9ki/tZGvyANAxMZ2B9iZyuC5d5x1OFydxT645jyN3nkAKRbL0yZNyT9lkY
XkuZ7RJ6zYUa85CgbT9xMxdBlWrEfV6hDOvXElFyQgCctyH7t0E=
=kc+f
-----END PGP SIGNATURE-----

--zCuQUy3n4o3l--
