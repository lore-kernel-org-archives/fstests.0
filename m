Return-Path: <SRS0=gsB6=BF=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56181C433E1
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Jul 2020 15:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4802073E
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Jul 2020 15:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijy/I1UH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGZPaJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZPaJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Jul 2020 11:30:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CDCC0619D2
        for <fstests@vger.kernel.org>; Sun, 26 Jul 2020 08:30:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id l6so6816067plt.7
        for <fstests@vger.kernel.org>; Sun, 26 Jul 2020 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=mlTzlIaw0Kva2ac/C5oaYGOXNRv5ILLdFfVDm50ssUg=;
        b=Ijy/I1UH51CB1ZafGXAYo6/gmct2qpUCjpHyRwn95bFe5V1+ScbbRjHF6EN1HIzXlo
         TO/KEK5p4t9JBw6r5ii0ioKnPJpFu++3ilp+2rrbwwpz+oS0z8YbnW5MlJrVJBeBfPiE
         d2KE4O9HraiV1ED92HWlGfaknYmEzlrL2f2yf9tD5gOfUPO64aHSMQzILU9EH0TeNdxb
         Z9YyVE0H/KVnKHIVPcj+1fkKH7nzAX1TMWMlzzq+aKZq/yuqb9+Ni8PO6rT2eElpumd7
         8vRyaNe3zn/HiWJDZZWLrSET2LILoOdGw1KcPcUafLHp7GIVat8qjefeJpcc8k5tqJ2K
         ZTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=mlTzlIaw0Kva2ac/C5oaYGOXNRv5ILLdFfVDm50ssUg=;
        b=A1357yQy2gzOVTNwmBjsc4+/YR7Zw6B9s4WNmVZul8v5EnGczUm0t9NglstUZvCZ3k
         0JzBh8eglbY9+32GjsT5wcpAZHkMiugGQFHCCSK1MOl0T8TV5ZX1hq5zAOcsucf350oC
         Kfnjpsi/AX/NLYrm8qUzq5YzhYqhndHKkW9ovHTpyo33pv0pss74kiHPiPPj1a7xbDiF
         wqYBXvFg3kyUa/j6EJukyiv3Nrkz6UQV5kGGk25izVENVMpG7SXycyhPdgQYXNV/QZXp
         P/gbpkBcQ9qKyldzBARg4W5qDU8VUvLzhMjechpjCj8VInzgXuONRMFhw4Z3RwLJ641z
         y7EQ==
X-Gm-Message-State: AOAM530wCDrtBOW8+LoijySYX/2N2ek/dxm9RMunsDxnEYHVo9ZmIGIH
        ye3xXOYXt8pJWbGJXBulJUb7TszH
X-Google-Smtp-Source: ABdhPJwn8kwctLWwccsIJhI7+qrzbIM5fNE9+pguec1JEbrmaB8tbz3WMkThePLWE39rUVeOgmzuQw==
X-Received: by 2002:a17:902:8206:: with SMTP id x6mr16101749pln.328.1595777408403;
        Sun, 26 Jul 2020 08:30:08 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id t187sm11657956pgb.76.2020.07.26.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 08:30:04 -0700 (PDT)
Message-ID: <5f1da17c.1c69fb81.10c70.3d58@mx.google.com>
Date:   Sun, 26 Jul 2020 23:30:00 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 43126346627b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xmU5uxAu29Bv"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--xmU5uxAu29Bv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Thanks to Amir Goldstein, fstests is now able to run
unionmount tests for overlayfs, to do so just set UNIONMOUNT_TESTSUITE to the
path of unionmount testsuite, for more detailed information please refer to
README.overlay.

There're also new tests and bug fixes as usual. And btrfs/216 currently fails
with v5.8-rc6 kernel.

The DAX related patches from Xiao Yang are still pending in my to-review list,
as I still don't have time to learn the DAX kernel part change :)

Thanks,
Eryu

The new head of the master branch is commit:

43126346627b btrfs/162: Stop using device mount option

New commits:

Amir Goldstein (3):
      [35c7a37928fd] overlay: run unionmount testsuite test cases
      [da3796a56fd9] overlay: add unionmount tests with multi lower layers
      [41bd77b43a49] overlay: add unionmount tests with nested overlay

Anand Jain (1):
      [191f1148cf37] btrfs: test if show_devname returns sprout device

Boris Burkov (1):
      [e444aa56c917] generic: add a test for umount racing mount

Filipe Manana (1):
      [e0680243e4ff] generic/501: make the test work on machines with a non 4K page size

Marcos Paulo de Souza (1):
      [3fdb2899df7e] btrfs/210: Ignore output from "quota rescan" after "quota enable"

Nikolay Borisov (1):
      [43126346627b] btrfs/162: Stop using device mount option

Vladimir Zapolskiy (2):
      [d16882efc471] generic: associate a few tests with punch and zero test groups
      [4e723c0f8259] generic: add missing runtime checks for mknod/mkfifo


Code Diffstat:

 README.overlay        | 15 ++++++++++++
 common/config         |  2 ++
 common/overlay        | 54 +++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/162       |  5 ++--
 tests/btrfs/210       |  2 +-
 tests/btrfs/216       | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/216.out   |  2 ++
 tests/btrfs/group     |  1 +
 tests/generic/157     |  1 +
 tests/generic/158     |  1 +
 tests/generic/294     |  1 +
 tests/generic/423     |  1 +
 tests/generic/501     | 14 +++++++-----
 tests/generic/501.out |  4 ++--
 tests/generic/604     | 52 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/604.out |  2 ++
 tests/generic/group   | 11 +++++----
 tests/overlay/100     | 38 +++++++++++++++++++++++++++++++
 tests/overlay/100.out |  2 ++
 tests/overlay/101     | 39 +++++++++++++++++++++++++++++++
 tests/overlay/101.out |  2 ++
 tests/overlay/102     | 40 ++++++++++++++++++++++++++++++++
 tests/overlay/102.out |  2 ++
 tests/overlay/103     | 38 +++++++++++++++++++++++++++++++
 tests/overlay/103.out |  2 ++
 tests/overlay/104     | 39 +++++++++++++++++++++++++++++++
 tests/overlay/104.out |  2 ++
 tests/overlay/105     | 40 ++++++++++++++++++++++++++++++++
 tests/overlay/105.out |  2 ++
 tests/overlay/106     | 41 +++++++++++++++++++++++++++++++++
 tests/overlay/106.out |  2 ++
 tests/overlay/107     | 41 +++++++++++++++++++++++++++++++++
 tests/overlay/107.out |  2 ++
 tests/overlay/108     | 41 +++++++++++++++++++++++++++++++++
 tests/overlay/108.out |  2 ++
 tests/overlay/109     | 41 +++++++++++++++++++++++++++++++++
 tests/overlay/109.out |  2 ++
 tests/overlay/110     | 39 +++++++++++++++++++++++++++++++
 tests/overlay/110.out |  2 ++
 tests/overlay/111     | 40 ++++++++++++++++++++++++++++++++
 tests/overlay/111.out |  2 ++
 tests/overlay/112     | 40 ++++++++++++++++++++++++++++++++
 tests/overlay/112.out |  2 ++
 tests/overlay/113     | 41 +++++++++++++++++++++++++++++++++
 tests/overlay/113.out |  2 ++
 tests/overlay/114     | 39 +++++++++++++++++++++++++++++++
 tests/overlay/114.out |  2 ++
 tests/overlay/115     | 40 ++++++++++++++++++++++++++++++++
 tests/overlay/115.out |  2 ++
 tests/overlay/116     | 40 ++++++++++++++++++++++++++++++++
 tests/overlay/116.out |  2 ++
 tests/overlay/117     | 41 +++++++++++++++++++++++++++++++++
 tests/overlay/117.out |  2 ++
 tests/overlay/group   | 18 +++++++++++++++
 54 files changed, 986 insertions(+), 17 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--xmU5uxAu29Bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl8doPMACgkQJlKqKVyP
52P6Tw//UcTXqN2+xovmYS3qAGYorMQyGe0P70W0okjRhi2uErKHiU7BahSOuv7m
IrVZLIUzOiU4J94VxL8JG89DJm1lUnRwlopmlH1VrU8J9q5zQC94rPBBIHgZwnHm
rTK6fy2sG5KQ4+g5KtMK4R9RdRe9cqLIbG/f5BWVzy+9i3QDpma2ciBLwEYtASaE
05Opv+jOMazcE3NOh23OlBHcaMOEpngZR1EhKpSoqyFzK27ERlaI1KTJp8U/eBMe
3rRsQgLDvTF8zkTF5HQpLrgE3ksi3T7IghdAuvtsGMNVEFWtPDB1g4S22yZ1PjU9
lIJYg4RDpfqOYSOaHEZptBtEmG/+b6MHLFpl+sS99zln9DxWECC5qhcEs+57uzRe
2YsR+6qsVshWSzAnvsr/Y6qwFDUTdl9mZjuC3x/uUEeLvqsDQ5tLSBInnsrV0RI6
TQme23Hi5zrBGG0yXtzaxdkfTRjhuXnmvWhiJ7DDB15AJTP5IIummWxWVeqQFv3c
DhLWH9SaEDUdp1oUrceYuI1l827ZOPa29GpYpYLwwjVQhyavCa4+H5smrlid4V8y
HTsICdYklNZaOwVuu0uIf9z0WUEmRscVJzzH41np6lKkkbYLKSw5qll1NvWzEFJT
1e17VmsWxFv0VojIkO05BTjxuy293JXCzWbwlrtM20sZv16VvMI=
=ZIXU
-----END PGP SIGNATURE-----

--xmU5uxAu29Bv--
