Return-Path: <SRS0=b8ZK=3W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16651C3524A
	for <linux-fstests@archiver.kernel.org>; Sun,  2 Feb 2020 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFF920643
	for <linux-fstests@archiver.kernel.org>; Sun,  2 Feb 2020 13:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJZNxlGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgBBNaJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 2 Feb 2020 08:30:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45070 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgBBNaJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Feb 2020 08:30:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so6070304pfg.12
        for <fstests@vger.kernel.org>; Sun, 02 Feb 2020 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=07K/DEanPkoyc9yuDLq8Ug9VEOR7xpjr5dIgJEHQ8CA=;
        b=HJZNxlGXRVX0ddFQLRpcuLp7S07ZfRFFXDfb7CzGxvA9Aoe4n90YJ88t0DgYbnYN+k
         5RAoP9ROntKJbS3eRF6RMOd5PnPOA/HDOBwSH9cagMA9QwbgGlkEFUdVnhXlR89MasUO
         B69jWUAlZBeolaEN44Ioe3PU6adG5rUFGrK8X/j/I5GR4ABWl+EnGTfu4XZY8jJQulIH
         CJJMg9xgMd37zji6Nv22drzzNkD6ivs/afJFyR1i4EolZSdbUQXGBIwWct3wm5BkvjZc
         DGDOGgAYmeM/AV//mwLUFX7mW+bcpKpTPe6oTb+bV/IV5AECpsBAmzbGXzcqhUvUIzix
         BPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=07K/DEanPkoyc9yuDLq8Ug9VEOR7xpjr5dIgJEHQ8CA=;
        b=We93F9shSVGcIcqbNjCvskJ4Kx2qlImr/x8QtbF0LJN0Dm2QPZ7Htw5iSqpB9gBULL
         8TKKrvqfwfIKP5LKwLqgB+gngSVB1aH9kz9dtUzFuSci3Hhe69ZqiXCpbSKGlLkg2yzl
         mL6OD9zPamhBsuYSlOT5fxWRJyX6kRYTsW1fZkNwLfij7y8WLPA+yb7meEn6iv2fDLEO
         VSYVBi7Yny4naW2YK4U05/e5Dn4sNcEkDwsr7YaGRJYBUkVbfwx8aDwEUw28pU5cutc5
         5bv/QiRtlf7c2WRd2dxX2gw8CzNWdsEHDJRUK3o84lKOzDKTiNzWL3lqiKXbdcwhyMPh
         gMDw==
X-Gm-Message-State: APjAAAXb1lH7gcM7A38m1xUd1wTrbGfyohBmdohbP+V55AeQCR7rF2Iz
        WyPWeoUnhY8zOUlSQBWEQdDdNjuH
X-Google-Smtp-Source: APXvYqxh0XqGOPBVYyyYhNWRRPEZ0qzyEsXH0tMrk3zEzoU4kuocT9z9Y7e5QvGLot+/a6Qr7ESZDw==
X-Received: by 2002:a63:1f5b:: with SMTP id q27mr6565050pgm.434.1580650208229;
        Sun, 02 Feb 2020 05:30:08 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id hg11sm16988196pjb.14.2020.02.02.05.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 05:30:07 -0800 (PST)
Message-ID: <5e36cedf.1c69fb81.eb779.dabd@mx.google.com>
Date:   Sun, 02 Feb 2020 21:30:01 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 61c6d0c30574
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="odNBw9FULBo3"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--odNBw9FULBo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the new overlay tests from
Amir Goldstein and a new xfs test, along with other various fixes. The new
overlay tests should not fail on v5.5 kernel, but the new xfs/512 test
currently fails on latest kernel.

The review process was slowed down due to Chinese New Year holiday and Wuhan
coronavirus, so there're still some pending patches to review. But if you have
patches that have been pending for more than 1 month, please resend, they
probably fall out of my radar.

Thanks,
Eryu

The new head of the master branch is commit:

61c6d0c30574 btrfs/130: remove the dangerous group

New commits:

Amir Goldstein (5):
      [88a966b1b9cc] overlay: create the overlay/nested test group
      [7d50029d5863] overlay: test file handles with nested overlay over samefs lower
      [c499faebbf8b] overlay: test file handles with nested overlay over non-samefs lower
      [0482218a3dc3] overlay: test constant ino with nested overlay over samefs lower
      [e288b4bade12] overlay: test constant ino with nested overlay over non-samefs lower

Christoph Hellwig (1):
      [3fde92b2a36b] xfs: add a new test for removing ACLs through the attr interface

Darrick J. Wong (6):
      [fe815742e286] xfs/122: add disk dquot structure to the list
      [6478e3343829] xfs/507: skip if we can't create a large sparse file for testing
      [e002de2e5b54] xfs/279: skip test if we can't allocate scsi_debug device
      [cfa9327172d4] common/rc: fix _get_max_lfs_filesize on 32-bit platforms
      [7d05ebe51ba4] generic/108: skip test if we can't initialize scsi_debug
      [699ebfad5db5] xfs/020: call _notrun if we can't create a 60t sparse image

Deepa Dinamani (1):
      [4bfaca4ef87e] generic/402: Make timestamp range check conditional

Filipe Manana (1):
      [61c6d0c30574] btrfs/130: remove the dangerous group

Josef Bacik (2):
      [27e2a2bd2f44] ltp/fsx: do size check after closeopen operation
      [fb72f6f547d7] ltp/fsx: drop caches if we're doing closeopen

Xiao Yang (1):
      [af37fc423f8e] generic: Add check for required keep_size/punch_hole/zero_range/collapse_range

Yang Xu (1):
      [b536de2a0424] generic/520: Remove sync in clean_dir


Code Diffstat:

 common/rc             |  11 +-
 ltp/fsx.c             |  10 +-
 tests/btrfs/group     |   2 +-
 tests/generic/108     |   4 +-
 tests/generic/402     |  13 ++-
 tests/generic/456     |   3 +
 tests/generic/469     |   3 +
 tests/generic/499     |   1 +
 tests/generic/511     |   1 +
 tests/generic/520     |   1 -
 tests/overlay/068     | 304 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/068.out |  50 ++++++++
 tests/overlay/069     | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/069.out |  50 ++++++++
 tests/overlay/070     | 223 +++++++++++++++++++++++++++++++++++
 tests/overlay/070.out |   2 +
 tests/overlay/071     | 237 ++++++++++++++++++++++++++++++++++++++
 tests/overlay/071.out |   2 +
 tests/overlay/group   |   8 +-
 tests/xfs/020         |   2 +
 tests/xfs/122.out     |   1 +
 tests/xfs/279         |   3 +
 tests/xfs/507         |   1 +
 tests/xfs/512         |  59 ++++++++++
 tests/xfs/512.out     |   7 ++
 tests/xfs/group       |   1 +
 26 files changed, 1298 insertions(+), 14 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--odNBw9FULBo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl42zm0ACgkQJlKqKVyP
52NyEA//d6qqacn2bJ2nbGxUWvtZuT5k8JPrklv4O6IFivMj/yWS7VYYGAY7DaUu
EcpiGMc5UktvPfNIecVkVMey3em2hc4k43TbLaLJ1yVVALL8gJ07Jal31RNoSGLO
WGXKztWbmvizWZYgKB0fEKcpCuxilpD9YwyqY5DfXliV8L3K4rB4B203MmKuWdDt
Gxmm6YhuZQhuPj0KQyiMNDJkxxlga6wqRBafUslIiNgS6yMoFsMqS0OIUdeq493O
iPjpypQuIxttC3tw6kqxQ67AH98TOAJbFOksC/6iGH03knHWfLKCxqki+zpm5ozY
u3Tze1wVOXiLnoCjRJin+qW1ZjdGtSnsVDqOyxTT46PANys3WbHa+IKwV/4L+xvs
v6Vy8Jz3NBLcEVpvZDsyX5vCGzI5lZEv+WJ5i+kTWbXO2gVurxXzj2LXRpvqDutL
Vhq4ktBS3Mx79r6+u8N33wO+NjpDfWonn2TtLQ/GWcJDiMsPX1e7An2nqfIb9m8i
tgPi3P6kRuAjQbPXU+UFUK5baNYYuNo/v4TvrQdQ52OgeUo8uiH5D7znPOapB2RD
A+bCEcu7vlzXxP05dFIHiOkoPJQqurUIVnOxoywiJcGkeAasdpkGBpHMdJOk6xbE
QkjiZQWpAPqe8s9Pvp+FUtUiwzZ/6PB+jtzayXoqODruDziTEvs=
=jyXI
-----END PGP SIGNATURE-----

--odNBw9FULBo3--
