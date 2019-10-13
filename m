Return-Path: <SRS0=0vMW=YG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDCDC4360C
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Oct 2019 13:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2346C206B7
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Oct 2019 13:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+cQlEa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfJMNGE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Oct 2019 09:06:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42375 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfJMNGE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Oct 2019 09:06:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so8825091pff.9
        for <fstests@vger.kernel.org>; Sun, 13 Oct 2019 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=geLMbLwO+aKMqiBNSI89NueFmtNAEbmYIipquz1t3Ew=;
        b=B+cQlEa/H1Jw69eTeGfhqs9Jm+ZlSVvEO3w7OrRAxX7vIucCu5XkKZItNu+Ojatvln
         vYrLgulTJvib8N5Enx0SVoGQuTmCKjeRRu8H0Use45tFB0k86WBnbpopXRfQQC28FsU9
         rIAjsK3XpicQJkZxm+w9vYx0/Tf5crdx786NQ9EzRRvskkl1pTWZDtQCEGXYO5yViSOs
         PuqwbPkFewQIERfZfpbXnSkstymCYJrkpAMGWYEyQorXdqxhZa5koPYeB1FFbjL7EI+r
         tlsbEFpKI1O8hypgqpY0TfXvh+CE631vMZr1a1gmH4aQzDJRnNA1FRN/8an5WfBVS4kj
         51iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=geLMbLwO+aKMqiBNSI89NueFmtNAEbmYIipquz1t3Ew=;
        b=aujArgvBKbuD0Lq6e73Zuf5stRUCF/KvzoEM3lN/fZmkc/xlIvQwCqSSmo6xcidl43
         b6eYNvQXy8auVz++yg4YC+i3u+HJJR8soRXlXV7uPLAuYiq45/1H6Q2AZTrtEX4wLPtC
         YOJQkfhxQWPIVfVFNkeYCcK22AjfwbYYYok8P5MtOLJXUXEPtED+IIAdDN9yPnMvgDLc
         SfpC55hhWh2U+hC9/G8WpNBv+MPeHfZ6mDUswLq0ETnSaf1ztukgW2oOalvXwruz5KcA
         zNko1mZv0hCrR92HUrpe98aS4DN1ctZ4GCfgOIPihv3ZYAGvvq9/l/Zf9fci9zcC+sc5
         ODOA==
X-Gm-Message-State: APjAAAW/PrIpJR1wENOQzirZTy838TraKzRX5y+rC/eR2js6Wo4S0lR0
        crLm1AenOkt1XX8pmFiaId5hd+Wl
X-Google-Smtp-Source: APXvYqyJpGfR2Jy41kVIjIW7Q+7huaMtWZhnnWA3p+rns9K8oC0oNnnXJNgo4hzgpx529golMAaHZw==
X-Received: by 2002:a62:e807:: with SMTP id c7mr27210894pfi.18.1570971963500;
        Sun, 13 Oct 2019 06:06:03 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id v43sm19987491pjb.1.2019.10.13.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 06:06:02 -0700 (PDT)
Message-ID: <5da3213a.1c69fb81.a290c.4dca@mx.google.com>
Date:   Sun, 13 Oct 2019 21:05:56 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 22b06b010cc6
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qSF4pCqhOSwt"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--qSF4pCqhOSwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is probably the biggest update I've ever made.
Notably, I pulled in the leasetest patchset from Ira Weiny, the fs-verity
patchset from Eric Biggers. The locktest changes only affect generic/131 and
the new generic/571 leasetest case, and the fs-verity tests will only run if
you have fs-verity support, other than that the two patchsets should not have
other side effect.

Some other new tests and random fixes are also merged, but I don't expect to
see any new failures. If you hit bugs please drop bug report and/or fixes to
the list.

Many thanks to Jeff Layton, Filipe Manana and Christoph Hellwig for reviewing
patches!

Thanks,
Eryu

The new head of the master branch is commit:

22b06b010cc6 generic: check reflink multiple mmap write

New commits:

Darrick J. Wong (5):
      [5b2232dde59d] xfs/196: check for delalloc blocks after pwrite
      [d48645e8a120] xfs/{088, 089, 091}: redirect stderr when writing to corrupt fs
      [7c1c3fa59331] xfs/263: use _scratch_mkfs_xfs instead of open-coded mkfs call
      [96b5068aa2b9] populate: punch files after writing to fragment free space properly
      [22b06b010cc6] generic: check reflink multiple mmap write

Eric Biggers (8):
      [12629d54e2fa] common/filter: add _filter_xfs_io_fiemap()
      [0467d90019dd] common/verity: add common functions for testing fs-verity
      [16f52cac08a6] generic: test general behavior of verity files
      [59c53985cbe6] generic: test access controls on the fs-verity ioctls
      [98abd9a8d47b] generic: test corrupting verity files
      [cb20d83e824c] generic: test that fs-verity is using the correct measurement values
      [5f8fccd0a087] generic: test using fs-verity and fscrypt simultaneously
      [78fa1fb8163d] generic: test the fs-verity built-in signature verification support

Ira Weiny (16):
      [0beb74fb70e6] src/locktest: Remove unnecessary sleep
      [6cb474bc17e7] src/locktest: Remove OPEN macro
      [4d5f16cf639b] src/locktest: Change command macro names
      [a5f4ca19e656] src/locktest: Add get_cmd_str
      [214cc10503cd] src/locktest.c: Clean up client command passing
      [8deddd16f4d3] src/locktest.c: Fix return code if last test fails
      [f10a6b4a4e26] generic/131: Clean up pid variables
      [450873c962a1] generic/131: Save stderr for debugging
      [170771f3c838] src/locktest: Clean up error output
      [4d0f2152e5ba] src/locktest: Audit all debug output
      [a4940119d16a] src/locktest: Add run() function
      [82ae25c4dfaa] src/locktest: Add simple lease testing
      [6d3cbc48a581] src/locktest: Add lease testing for basic signal reception
      [a7bfbe8b2e19] src/locktest: Add truncate lease tests
      [f91931a1a68e] common/locktest: Add common locktest functions
      [ac92390251f3] generic: Add lease testing

Josef Bacik (1):
      [17c22e556f8f] btrfs: add a test for multi-subvolume fsyncing

Murphy Zhou (1):
      [95a2510bb1f2] generic/001: remove unnecessary backslash

kaixuxia (1):
      [fe64c0e70d9a] src/renameat2: remove duplicated renameat2 system call number for i386


Code Diffstat:

 .gitignore                  |   1 +
 common/config               |   2 +
 common/filter               |  24 ++
 common/locktest             |  95 +++++
 common/populate             |  54 ++-
 common/verity               | 215 ++++++++++
 src/Makefile                |   2 +-
 src/locktest.c              | 999 +++++++++++++++++++++++++++++---------------
 src/mmap-write-concurrent.c | 155 +++++++
 src/renameat2.c             |   4 -
 tests/btrfs/196             | 110 +++++
 tests/btrfs/196.out         |   2 +
 tests/btrfs/group           |   1 +
 tests/generic/001           |   2 +-
 tests/generic/131           |  54 +--
 tests/generic/571           |  32 ++
 tests/generic/571.out       |   2 +
 tests/generic/572           | 199 +++++++++
 tests/generic/572.out       |  74 ++++
 tests/generic/573           |  73 ++++
 tests/generic/573.out       |  14 +
 tests/generic/574           | 154 +++++++
 tests/generic/574.out       |  91 ++++
 tests/generic/575           | 112 +++++
 tests/generic/575.out       |   5 +
 tests/generic/576           |  80 ++++
 tests/generic/576.out       |  12 +
 tests/generic/577           | 150 +++++++
 tests/generic/577.out       |  42 ++
 tests/generic/578           | 105 +++++
 tests/generic/578.out       |  31 ++
 tests/generic/group         |   8 +
 tests/xfs/088               |   2 +-
 tests/xfs/089               |   2 +-
 tests/xfs/091               |   2 +-
 tests/xfs/196               |   2 +
 tests/xfs/263               |   4 +-
 37 files changed, 2493 insertions(+), 423 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--qSF4pCqhOSwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl2jIM8ACgkQJlKqKVyP
52NK7Q//Y4e8C4wXJN0Yz53Lnb1WmeXxly18rYafr69HTwhkBESkY/oM118XqvvD
i8S3c9yvyaOijqRg+OfmUDxnZdL10Xoa4Thv8ZPsHk1PBDN5xe6iqbSBhiE+YkCJ
QfVHUyYFdaxGi2iseZoRRPOStsE7MXPLl2KgaddijIbGHP0PCJpc/lr3uBVvt2UM
J35J+Oe8qn1RlaHNNYV3agChA3wE3Rbr3xGexxIgGbG3a4d8yd/d3OH5BD+LVb+w
yfQvwl3+OZXxRIWnvbZWod/+B6+gucES/+96z1AtuW9xP7fqkCABb6WtaqhYwp7H
Hq2JUdh7AfFlPTRNlygy23fpjONyoDpXyAh/cvxdPRvXcQ16hMY6rM7w+e39RHwB
CES8Xc/04k0PXn1Xeo9SQo8BcYOKj2Gh29IfzSebs0PFzAs0JV3DbrkogzQcmN2x
yUf3KziROeRkulnpPXb00VMAamxrSJOBUBAsXH1oPcKZwZsI9jOKCNSLOn0ZmFcR
YltCRbFqrwHmZyAXu5Z8E2caSn7KtdLq9bZ12ZBnEbj87B8+8uIfmzJ61o3eZlaL
ileiPl8173G8fZKKoudJ0HSiZHQZ5ocU42HtX7YGK4g+KwZNiyCJBghjw4rWuQRv
Rb0UrjP45sJsWPbqEr+mc5MGI0OmYncAI2Tu8eK1fyDC8yJP6dI=
=QU4J
-----END PGP SIGNATURE-----

--qSF4pCqhOSwt--
