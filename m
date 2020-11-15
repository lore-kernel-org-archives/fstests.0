Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A4C55ABD
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Nov 2020 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F87C24197
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Nov 2020 09:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9EwZ2aA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgKOJNi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Nov 2020 04:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgKOJNZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Nov 2020 04:13:25 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27D9C0613D2
        for <fstests@vger.kernel.org>; Sun, 15 Nov 2020 01:13:19 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b3so6616919pls.11
        for <fstests@vger.kernel.org>; Sun, 15 Nov 2020 01:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=FTb5kVWtRG65s5z4clAASrY9HrU05i6Dn5TyfZO4c/A=;
        b=Q9EwZ2aAPqZXlLf0ULyv/k37wxU7M5NQ2DhoCqxGaUTLbxkDLo/64D+9JMAmvr04F5
         phdUjmVI0GI+CvXrI7DryOE50E0vc+wZ518DpRun5B42RCIPIbpetD8ES8frMDV/D6qx
         9rNb6Mqe28sijnOjLr/z5ZpboeycYSPXxxk+b6X/vnAIDXbIAkoXb6iaVJ9iQhmrnhga
         wi3f56huCEMOS+YWaHNfE8V/VC709Hjipuc5nIsELSISI8CA3KZOIaC6kDefXkyHuVAd
         hoQfQNcQTMbJmmrIFZzoOKG1KgYmwavnZXwzVLiu/es/fCOOEEyzDibPsL/BEijc1a3c
         P8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=FTb5kVWtRG65s5z4clAASrY9HrU05i6Dn5TyfZO4c/A=;
        b=BwT6swKEfXWGoZWDb7jUbr9xRNnx354lgIGgPC6/whdImr32FXGr2PDX9xUzLlEZCo
         Pjd3nHIcQUW0lbV9BkOsu0QnyjzUbnhtcLygw0JciakRabUzPbD8pg3rLngLgJNixyVI
         /AeKFIcEErvcGvp6C584O08P2LgLJ2eXG9YONzi5gv8KxNxko9r4mM19eZix/Abw9J9M
         /EQr7N60NtAhsHk87GBmurCEydfMWNE9UlY+S0wlV7mWNWgTkODO3wX6+HZ/Xny04QCd
         mL6ksj46Z4Ng4jQkxIzTuPkMVV42rhS2PATVDTndEqw8cv9UlfwE+sGOHFwssUNGy/t6
         EMqA==
X-Gm-Message-State: AOAM5329Z/d7CdsmXK4dYitTedvThuv2b29Qqy5fHL8m39p9l7beCBjB
        YeXkvA3cReMqusfdpJN9v8BA59O7HuY=
X-Google-Smtp-Source: ABdhPJyGEU4NDgT6l17PAOWkOKGXXi8g16ZNZ7k8mBR6lWDyQCCR3YrpyPfuAbAcTBNMopTvOjI3/A==
X-Received: by 2002:a17:902:c411:b029:d7:dd6e:60b4 with SMTP id k17-20020a170902c411b02900d7dd6e60b4mr9198078plk.66.1605431599119;
        Sun, 15 Nov 2020 01:13:19 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id r15sm14818794pjp.51.2020.11.15.01.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 01:13:18 -0800 (PST)
Message-ID: <5fb0f12e.1c69fb81.8794b.fb70@mx.google.com>
Date:   Sun, 15 Nov 2020 17:13:14 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to ac23422a8c7d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="prVt338SYQpw"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--prVt338SYQpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Thanks to Zorro Lang, there're two new tests that
execrise io_uring based fsx tests, one of them just triggered one io_uring bug
in kernel (and fixed in latest kernel). Also, there's a new test that makes
sure st_blocks is never zero while writing into a file, which currently fails
on btrfs.

Other commits are random fixes, and fsstress and fsx get rid of some build
warnings.

Thanks,
Eryu

The new head of the master branch is commit:

ac23422a8c7d generic: fsx IO_URING direct-IO soak tests

New commits:

Darrick J. Wong (3):
      [4f8a21fa8d32] fsx: fix strncpy usage error
      [808f39a416c9] fsstress: stop using attr_set
      [0743230c3602] fsstress: remove attr_remove

Eric Biggers (1):
      [609bb3562241] fscrypt-crypt-util: fix maximum IV size

Filipe Manana (1):
      [7a327ad2f4da] generic: test for non-zero used blocks while writing into a file

Xiao Yang (1):
      [bd3353b0d4d9] generic/426: Remove unused opt variable in create_test_files()

Zorro Lang (3):
      [6f87118198dd] src/feature: add IO_URING feature checking
      [c3eb99947700] generic: fsx IO_URING soak tests
      [ac23422a8c7d] generic: fsx IO_URING direct-IO soak tests


Code Diffstat:

 common/rc                | 16 +++++++++
 ltp/fsstress.c           | 29 ++++++++++-------
 ltp/fsx.c                |  5 ++-
 src/Makefile             |  4 +++
 src/feature.c            | 41 +++++++++++++++++++++--
 src/fscrypt-crypt-util.c |  7 ++--
 tests/generic/426        |  1 -
 tests/generic/615        | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/615.out    |  3 ++
 tests/generic/616        | 58 +++++++++++++++++++++++++++++++++
 tests/generic/616.out    |  2 ++
 tests/generic/617        | 64 ++++++++++++++++++++++++++++++++++++
 tests/generic/617.out    |  2 ++
 tests/generic/group      |  3 ++
 14 files changed, 298 insertions(+), 21 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--prVt338SYQpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl+w7GgACgkQJlKqKVyP
52OjfQ//cEjKOUgSLMloZLqlTH9ujUiSob/pGs7wC2PuljDGgmwwWOClMEAJQnhl
VHSV8373NoSMB9d+cVUFbLMlI4mHFfmztuz78Gnyk3CCZMR2zmxxXZkR1Hd6Y/xX
zSr/WTpIsFDYuHI3rLxajcutWnaYhPEfZi2nvYAfB0IBbyRGhpTkz9mI52hBFvs0
fx4dlgFXtbmLZQ4u4oMsO9UfVTz5M7MGpHyBN43GpZ+pkkhbhWCxQsg7qb96MFXx
yTyGddmMYeOLR1pkmV9hXU2fvovBkx2+fPCRF9KEM2suRAdAXzhaW+mA+Sdv14l1
Im1SNmjzgJ9H9FghlQbFMkXrE5HjfcUpgGLjnUQFBzGlGLaD6vL7tepSJnxu8ano
18uJ25mwebQsuUlt/nb67LhvZAxHbM8IgLnrmbLAnscKc79WULgFpWUc4ko3+jOj
PaqSM8r2Qegd3krjzBp/vf1d0Wqpb2lTjey+0p578ZVXfXttUEPNZHw8tMK1BWUr
kCD+zZKDK93EbDokdEJHbh41gysvR4ajsJz/AcUNEWm7+xHJQm31o8CMYF7QbNoH
mcgGeCArGCOHsVvRT50ONHCeW3BdvTDGQ0Dh/JtddytDyTY2ae+AfAI42ojOs0RE
itLiTWlTbTPFYOrX3meYyAuLqDRouBSG63grQeO0RAa+T1hN0eU=
=w2Rl
-----END PGP SIGNATURE-----

--prVt338SYQpw--
