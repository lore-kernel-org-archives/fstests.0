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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687DCC4361B
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Dec 2020 14:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C712313E
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Dec 2020 14:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgLFO2C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Dec 2020 09:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLFO2B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Dec 2020 09:28:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B9C0613D0
        for <fstests@vger.kernel.org>; Sun,  6 Dec 2020 06:27:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v1so5847742pjr.2
        for <fstests@vger.kernel.org>; Sun, 06 Dec 2020 06:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=eNH8H7ozf2wlKE0bTT/i8Uo+i389bPZjdmqTquE9whw=;
        b=pdcuaw74Z8lQipF16vGAgzjmesIqP+SQaj05+XoOBt15GIrbevfAhzoY68PfTMPH8F
         ZQQcOkRzvnUmTFGjCjXIp46O1cyJi2Shrfq0QbApSP24JtOhCjXAon4UsaE05fkFI88u
         ejBZndfo8QIjyi3SNgdhOOLHU3mtRdoXO711+oYXwuop60chtCm3msROX9ew2Aznavsy
         WUctv8Ni3iQJlkRB/p5O4Jv18zpYji1xoq+aIEujUHzK4Z8YOSStS2mDhptrgdMtXJ62
         BAVuyXAuRadfHesGNqvKWeFVu5ja+XcJ9LhjKf61HGGKnX90jrMhmIzzr3EwoBZao3lP
         Hpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=eNH8H7ozf2wlKE0bTT/i8Uo+i389bPZjdmqTquE9whw=;
        b=SZKkJKuqZA1rhl0pmDFjH+1LC/EG0t4b0z4QSi1Tunc8HiopiBUsc4ful7CY5+lUca
         47pWBdfHLdVmzmJ+2XCfOl0/PWSsjw3EWSdB+Xn518o6rCjxmaTm+oCV8eYz9Plaq3o/
         VxBA7GIcKAVS+bD3xUYvIhiGQS8dUB6HQL0NTgdBM/6uDKLRrJd0knCl+F6wN7Ehs+N/
         ibF6rBjgyMadO/5HwuKXLj/ZxY0p105rRRnKRhKSZiM9cYR8foniYTqdD7SAS6qy1ynB
         MWlNAhlSt/oo57BrzLiRoFisQ5i0q8+tieiLDMxyGY4GAYRKOs2PFFb7EFlwyecaen1w
         vtAQ==
X-Gm-Message-State: AOAM530aziZdUitbU+94gBOJ/T7P5ULRz8JaNyKLh1dKvoGjC0YwVVZe
        2MXS5cm6JQEpDc0g9tx+wuT009SfLkc=
X-Google-Smtp-Source: ABdhPJwycrSRZ5MFakdG0ekCS+B0Ld1ARvsxmY7oyIDKQtVfw7k4r46GaEDOHmYnzaIgCFMWD3dBfQ==
X-Received: by 2002:a17:902:6803:b029:da:1469:8945 with SMTP id h3-20020a1709026803b02900da14698945mr12007756plk.15.1607264834735;
        Sun, 06 Dec 2020 06:27:14 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id k9sm1705685pjj.8.2020.12.06.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 06:27:13 -0800 (PST)
Message-ID: <5fccea41.1c69fb81.8fbc7.3c2e@mx.google.com>
Date:   Sun, 06 Dec 2020 22:26:53 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 4767884aff19
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gAv2phjDcTDy"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--gAv2phjDcTDy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update includes 2 new generic tests and 1 new ceph
test, and they all should pass with latest kernel. Also, _check_s_dax() will
report failure explicitly if the kernel has a confliction in STATX_ATTR_DAX
definition and STATX_ATTR_MOUNT_ROOT. Please see details in commit ee4281bfe37c
("common/rc: Fix _check_s_dax()").

Thanks,
Eryu

The new head of the master branch is commit:

4767884aff19 check: source common/rc again if TEST_DEV was recreated

New commits:

Eryu Guan (1):
      [4767884aff19] check: source common/rc again if TEST_DEV was recreated

Gao Xiang (1):
      [f20d3a285118] generic: test XFS forkoff miscalcution on 32-bit platform

Ira Weiny (1):
      [ee4281bfe37c] common/rc: Fix _check_s_dax()

Luis Henriques (1):
      [445cbd798b88] ceph: add a new test for cross quota realms renames

Pratik Rajesh Sampat (1):
      [8b4f7e207cb2] generic: ENOSPC regression test in a multi-threaded scenario


Code Diffstat:

 .gitignore            |   1 +
 check                 |   4 +
 common/ceph           |   7 ++
 common/rc             |  21 ++++-
 src/Makefile          |   2 +-
 src/t_enospc.c        | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/004        | 119 +++++++++++++++++++++++++++++
 tests/ceph/004.out    |   2 +
 tests/ceph/group      |   1 +
 tests/generic/618     |  75 ++++++++++++++++++
 tests/generic/618.out |   4 +
 tests/generic/619     | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/619.out |   2 +
 tests/generic/group   |   2 +
 14 files changed, 637 insertions(+), 3 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--gAv2phjDcTDy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl/M6dQACgkQJlKqKVyP
52MQ9A//Zs+QZ5B3QSmBur8bgIivoR19eXguqTcrwLxtUft4SmP2gxoRMqLlXg+G
CRbeL0c74MCqo/qACHTKfzeOGltbUSk4ce944svzPvEHGOvKSisp7OCbvZ7kMiEe
NJ0eMlryH7ys1r5y5pwaxnJIxy+cfJt8MK1yT3WxeLN2yeezJ+IuRZ5/laG1YR2W
Kw8Gx/ywmnmx9agNHPczzESwovnqDgWHuBZAKaNpli6h2wJRT9rLY/jMWHtTtfJ6
DPiMGEHhTV85wx76K1h4N1G+GG8cxC5CCnQESposQjXc+LJ9cXI5ZDWD9MxJ9FDI
b0ZKOWSfkB4/Ro/I/yge4//NK/DULFbZUboayx6zCTH26ydl4NlCfjEOh/ZpmX0E
1BPqI9j4HG+2sTAi276fmnAvvjHHOZ+1oKRO93b8efBx2KkS1W/adfNmtiuYiVBb
Eizh4NYFCvHRGe6NHpBfzH/EeI8He/P4wkFrCf7L1Pjydr9jk7eGWFtJ8g4pOUI5
AT+muJCCSwJkaKgepYsggIffciOb1NEHEGHWcLKuTMwZlgWxSRbpwNtRHTXOkFBm
x3zTwNcfGxnRekam9/olqqJyEjdjLXdckccoEfrRa5mBHF1dl7xjypedaw/ETzVS
l7jxm67xB44iF36Q9FeHeWZ/ZimT89UNpfR68B5BrumDk0yGZxA=
=Audz
-----END PGP SIGNATURE-----

--gAv2phjDcTDy--
