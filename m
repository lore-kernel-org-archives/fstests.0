Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F5C4707A
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B2861205
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhEWPUN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 May 2021 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhEWPUN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 May 2021 11:20:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F342C061574
        for <fstests@vger.kernel.org>; Sun, 23 May 2021 08:18:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b7so13006914wmh.5
        for <fstests@vger.kernel.org>; Sun, 23 May 2021 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=Oro5kRSL1gRTFvhl7RstC2AFMOkFZzT1iukvmt+5wdk=;
        b=KQirVetKyXOtPJrhKVgw+H1Vt5g/HXyrawyvAebj+8xbA4fTbmbzdde0o2Ovviffm0
         R6DJwry8RUJytsrIpOcEqTbmFYfZl8bKkTrKE4zTR6WqeZqUAA39zvrwMFteEdCbLHhG
         OrsHUSMktAjm2/47LrlBb7M0ozcxy0U3WqQgUHosDQzvT2Vz9sI18eOnY2N4bZSDXVtb
         DKahSXEAEDI0jUSO+q80Id1bEgWJo79akb0DQFm9eAXraBbymro/nnZLtyX3feLo5tpD
         iIyix/zhdKNL5eAD5VchTW3FnXwokbxfkHLUEO+e3GWOtWZadtnoPiOcsvvHhS2fPhCj
         L8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=Oro5kRSL1gRTFvhl7RstC2AFMOkFZzT1iukvmt+5wdk=;
        b=MDpMfeSVYn6F6rA7JbGe4fVF0i12XI7qPXw60Nx6t2Y31SBs0xaEt5StLfIA+qCmzP
         YBCqlU09tAzt1R43ZmB7L4px8g+D3OnhwHVMWtfxwyNovRtTBNHTf04tYiqaGRWaR5Jx
         SkLYq+IqdgXsM6DxkGH4GNM/mpnf3/blsPhVm0gX9J170vHhrSel1jZQkHerWYwlRf7c
         QRlCrddyHMAmjrKWaRMQLr73ApsDBQZo2X2STuAwgagCJk5G3GWu7p8QZaVLfr8dkjti
         aVy6WxGUDWruuHQwQJ2qmEu8VhNRB11gIlsJfr67BW3du/eliZObrgWXPV7R7v6wFy7A
         RQUg==
X-Gm-Message-State: AOAM5335jpnozJXb5mawnv33hVfoyDS43RNCji4/h6H8iPCOqEmF3EOC
        kpSjDJAiLUbDsv/9mQJy5zOdUzpm2hw=
X-Google-Smtp-Source: ABdhPJz6H9HuFh/WQsZxi1L6y7trjBPE4abwq+lo7mZItA59J0aMMmA08QLd/GLZ55b4c8FwWLVGSA==
X-Received: by 2002:a1c:4043:: with SMTP id n64mr16513514wma.9.1621783124332;
        Sun, 23 May 2021 08:18:44 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id s7sm5267429wmh.35.2021.05.23.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 08:18:43 -0700 (PDT)
Message-ID: <60aa7253.1c69fb81.ea774.41a5@mx.google.com>
Date:   Sun, 23 May 2021 23:18:39 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to f360daadb200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VYMp3NNZKSnC"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--VYMp3NNZKSnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The remaining fixes for xfs from Darrick J. Wong has
been merged, along with other various fixes. And there're two new tests as well,
and they both should pass with latest v5.12-rc2 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

f360daadb200 idmapped-mounts: split out run_test() function

New commits:

Christian Brauner (3):
      [7fe01df0d655] idmapped-mounts: remove unused set_cloexec() helper
      [e9d1379646d9] idmapped-mounts: add missing newline to print_r()
      [f360daadb200] idmapped-mounts: split out run_test() function

Darrick J. Wong (6):
      [8d54e5028850] common/xfs: refactor commands to select a particular xfs backing device
      [ea15099b714c] xfs: force file creation to the data device for certain layout tests
      [b77d5dab8379] xfs/117: fix fragility in this fuzz test
      [0049872c9acc] fsx/fsstress: round blocksize properly
      [993887b25cef] xfs/178: fix mkfs success test
      [74128e70c4b6] aio-dio-append-write-fallocate-race: fix directio buffer alignment bugs

Jinhui Huang (1):
      [ae5184464dde] xfs: Add the appropriate _require helper

Leah Rumancik (1):
      [466ddbfd1151] ext4: add test for ext4_dir_entry2 wipe

Qu Wenruo (1):
      [c8c475f155b6] btrfs/215: avoid false alert for subpage case

Sidong Yang (1):
      [82901113bc72] btrfs/012: check free size of scratch device before copying files

Zorro Lang (1):
      [8a9bc451112b] generic: mmap and copy file data with page overlapping


Code Diffstat:

 .gitignore                                         |   1 +
 common/populate                                    |   2 +-
 common/xfs                                         |  25 +++
 ltp/fsstress.c                                     |  24 +--
 ltp/fsx.c                                          |  22 +--
 src/Makefile                                       |   3 +-
 .../aio-dio-append-write-fallocate-race.c          |   2 +-
 src/global.h                                       |  13 ++
 src/idmapped-mounts/idmapped-mounts.c              |  77 +++++----
 src/t_mmap_writev_overlap.c                        | 134 +++++++++++++++
 tests/btrfs/012                                    |   2 +
 tests/btrfs/215                                    |  25 ++-
 tests/ext4/048                                     | 191 +++++++++++++++++++++
 tests/ext4/048.out                                 |   5 +
 tests/ext4/group                                   |   1 +
 tests/generic/223                                  |   3 +-
 tests/generic/449                                  |   2 +-
 tests/generic/638                                  |  57 ++++++
 tests/generic/638.out                              |   2 +
 tests/generic/group                                |   1 +
 tests/xfs/004                                      |   2 +-
 tests/xfs/088                                      |   1 +
 tests/xfs/089                                      |   1 +
 tests/xfs/091                                      |   1 +
 tests/xfs/117                                      |  47 +++--
 tests/xfs/120                                      |   1 +
 tests/xfs/130                                      |   1 +
 tests/xfs/139                                      |   2 +
 tests/xfs/146                                      |   2 +-
 tests/xfs/147                                      |   2 +-
 tests/xfs/162                                      |   2 +
 tests/xfs/178                                      |   4 +-
 tests/xfs/207                                      |   1 +
 tests/xfs/229                                      |   1 +
 tests/xfs/235                                      |   1 +
 tests/xfs/272                                      |   2 +-
 tests/xfs/318                                      |   2 +-
 tests/xfs/431                                      |   4 +-
 tests/xfs/495                                      |   4 +-
 tests/xfs/521                                      |   2 +-
 tests/xfs/528                                      |   2 +-
 tests/xfs/532                                      |   2 +-
 tests/xfs/533                                      |   2 +-
 tests/xfs/538                                      |   2 +-
 44 files changed, 581 insertions(+), 102 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--VYMp3NNZKSnC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmCqciAACgkQJlKqKVyP
52MMkQ//dumXCb2icXbdwpxglq4EG6rBPFdbw+cLJ/WgTsxJzJhkkbTPizn68L9e
ezNmkT1yap+tX8hzp1NA3S/gJ+HaGEz7zs5B2r34gT8Dljeke+ytE/dQfl5RkVcb
+D3NcA/Vy4TkQ7oFwGlS0DZrL2OqngFVxbcEo4WlzQaSJ3EIcmseYQlDETJF8FYH
+tjNVqjU5E//4AEjZrMLyW4MSy27VvlLwGgDXCf96DDaARR5NqL/peJq7HonNNZZ
iQ4zkVrREr6IYv9UmFnpMtG+bSAuIW55VJ2KdEIVydEVzysFVCpc4DUWAnUzKxBo
PYjXH6b7OWqXJb+oMUbcKU5Jn3CpqJd99hbqlNNRb6rbJNYA8d9uAhYQ6AX68ne7
Ls93/XPmMLbD5vTm7n6d3A3riPQx/YOeQCPIKN9ZAdBsfxk6wYS6/0nQZYCxgIc1
y3F/51yuD6F8jj8ZQSTCM6H1ckEEHJfQIDJPQX7hXXmx6JoAsRrLkBv1FauclxEI
DD2cuhbZ7v1BwClgkqUBNzDTJpEQnp0ZWI4nDjqtgGWk58Hd+MUKGtPaYe/OPj3w
3slMo+9RPjrgnMb8RWvJeFRtFsLfaQ8JBqIHIeTm3t46bVCkLURRGw4TvpaiSSey
Te9p5wQoBM8jH0ttJd+AUr/ba7LMQx66GqcenkoNlNKE3hc3ASg=
=uN+u
-----END PGP SIGNATURE-----

--VYMp3NNZKSnC--
