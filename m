Return-Path: <SRS0=f9yW=AC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93972C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E08424862
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 18:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftBmmhjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgFUSAy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 14:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgFUSAx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 14:00:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE9C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 11:00:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so1824088pgc.5
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=rhV2Qz6+XyDszPk8vz0A+X3gLNilNfq1+MDpS+7mrIc=;
        b=ftBmmhjI6HRDvuxX1xrMe2d8KKZv+jkwDaRoAgXBlQWN90CZ/FJGroY8/zoGzSbSrY
         Qd+QJHnwgMOC3u2ZG8RsJf74nJeqlyEqyzkU2ZGdpUHASpahmkxBxx6DC+BMjDtTQ9UG
         OZ7lKGLJdHoYHcaElhXGFP85N/8b+whR8pQOvya+YKmu2LyHPHqFYsgYOtsmYdE+y96x
         aglSw82KuBJ4hd+YmsUSGCJVwJaV7cpjDYq7cxZHFnWCfbNcdSwSB66YIH9ni6PJqzBp
         FQHes5XmGIuesqopNwn1DfUkcZALAb2R02W/5oTMR9TDk2Dgdrlek35b1gzaM+kuikdg
         I57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=rhV2Qz6+XyDszPk8vz0A+X3gLNilNfq1+MDpS+7mrIc=;
        b=sLQVJSgFz7fGpXo6AXT1P2/1WUauaybdF2dih6qBgX4n3R2H83Imc74NM4rEoCBPqo
         4bMe2VcrntsJWvy/94vj69G8uuUrDEmvLLG7m9Zpuj6gsV7HG8mBX7qjJdhwonYZFobt
         dVPbzt4X8Fu/K5oJb5EL4IDb2DizT0qBLwGx/8USHW5Xae9n4g/Gsbit5oiQQ/oZGRod
         wRJNY8znlly9fYcAbk0/qXfvcqWu2P+9wAUrnJoY4WOxpQycG7Z+ezlr7bKusBbKrAmv
         K18xmQD2Zg46qoAMyC9F69mISBw6XFcuJo3tEA8JSosut456HKKe9hUfO4N4NIdYROzS
         FcDg==
X-Gm-Message-State: AOAM533IA1sk0e3geeceBmeHVFv4JAHaq2x9HXrBHX8vZkehkISJnV99
        8YxFDpKiekaAJy1zN6v+1VoYHcBu
X-Google-Smtp-Source: ABdhPJwtR9DswOPjaW60snhJyEKfjJcxMraVBsn5B8PKBAldtUjVJ51jCdyIJ/KIJOa2UcENHm8vOA==
X-Received: by 2002:a63:a558:: with SMTP id r24mr10379273pgu.70.1592762452146;
        Sun, 21 Jun 2020 11:00:52 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id b14sm11363235pft.23.2020.06.21.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 11:00:50 -0700 (PDT)
Message-ID: <5eefa052.1c69fb81.fa995.4360@mx.google.com>
Date:   Mon, 22 Jun 2020 02:00:48 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to aae8fbecf42b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JprSW8tGz6nv"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--JprSW8tGz6nv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. As usual, this update mainly contains various bug fixes,
and there're also 3 new tests, which should all pass with latest v5.8-rc1
kernel.

My apology for being absent for so long, I've been very busy with other tasks
in the past a few weeks (and perhaps will be busy too in next a few weeks :( ).

There're still some patches pending in the list, as always, any reviews &
comments are welcomed!

- the unionmount patchset from Amir Goldstein, I have some concerns on wrapping
  another testsuite in fstests, but I'll look into it more carefully later
- ext4 mount option test from Lukas Czerner, I don't like doing kernel version
  check in the test, but I couldn't find a better way to detect supported mount
  option automatically, please help review & suggest better ideas
- the btrfs snapshot test after RWF_NOWAIT write from Filipe Manana, the fix is
  still pending and the test would hang, so I'll wait for the fix to land in
  kernel first
- the afs patch from David Howells and dax related patches from Xiao Yang, I
  just don't get the chance to look at them yet

Thanks,
Eryu

The new head of the master branch is commit:

aae8fbecf42b generic/270: wait for fsstress processes to be killed

New commits:

Amir Goldstein (2):
      [3f4760c2e714] open_by_handle: add option -z to query file handle size
      [497a269f48c8] overlay: regression test for two file handle bugs

Aurelien Aptel (1):
      [59877e507165] README: add note about 123456-fsgqa user creation step

Eric Biggers (1):
      [35fd4ce0b373] generic: verify ciphertext of IV_INO_LBLK_32 encryption policies

Filipe Manana (1):
      [a38e45b19d1e] generic/471: adapt test when running on btrfs to avoid failure on RWF_NOWAIT write

Gao Xiang (1):
      [57eba17be8f8] common/fuzzy: try to clear blocking flags first in _scratch_fuzz_modify

Harshad Shirwadkar (1):
      [8e1388f52196] ext4: add empty lines to mkfs_filter

Jeffle Xu (1):
      [d6367ec8d2c6] common/dmthin: modify DMTHIN_POOL_NAME

Lukas Czerner (1):
      [aae8fbecf42b] generic/270: wait for fsstress processes to be killed

Marcos Paulo de Souza (1):
      [a1c25b75b456] btrfs: test if the capability is kept on incremental send

Yong Sun (1):
      [1ce2a82c14a5] fstests: modify user name beginning with non-digit

Zorro Lang (1):
      [f6da66ec96fe] xfs/096: filter out the "Discarding..." output


Code Diffstat:

 README                   |   4 ++
 common/dmthin            |   2 +-
 common/encrypt           |  18 ++++--
 common/fuzzy             |   2 +
 common/rc                |   2 +-
 src/fscrypt-crypt-util.c | 121 +++++++++++++++++++++++++++++++++----
 src/open_by_handle.c     |  27 ++++++++-
 tests/btrfs/214          | 152 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/214.out      |   6 ++
 tests/btrfs/group        |   1 +
 tests/generic/270        |   4 +-
 tests/generic/471        |  11 ++++
 tests/generic/597        |   6 +-
 tests/generic/598        |   6 +-
 tests/generic/602        |  43 ++++++++++++++
 tests/generic/602.out    |   6 ++
 tests/generic/group      |   1 +
 tests/overlay/074        |  92 ++++++++++++++++++++++++++++
 tests/overlay/074.out    |   2 +
 tests/overlay/group      |   1 +
 tests/xfs/096            |   1 +
 21 files changed, 474 insertions(+), 34 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--JprSW8tGz6nv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl7vn90ACgkQJlKqKVyP
52NLaxAAxKqDg8Klfs2gseLyXziNKk5Sw6QL27wZkSUG8d9T6LvJCkR+hjaKn/2D
SzOuwxTxibj2HTF6AbUOLYMPkpp6V9VS7x75vniEK6cQYzllD9nfOkUA23HHc/g6
xuVCLkp48jgkMLfYCychdvuON8nToamk1ZEaA28pWvn94jeFclGpD0Vb3Mc4T7MY
If6yzYendQ1aWCHKgitO00aj4xEou3NiEcMxcwnEc7ABygmNrQLGthdYTWqrTJw8
aMZIJ68Rc8vogzweXT5lc8l26SJPCV9Iklq+qjMz6TdseDjoMQCndK9aW7QL8GCX
Vw/5G5K99XCitZHI6FVO25hifS2MWAIqwS+4NRRUND/JK5Sy/thTuC1MiRfm9Gx9
DqCBo7nz/LPsd8drrvYTvVKrtfrYqrtkU5gh6BSyMBZ+tVddQvLAUFVEY/HDafNE
fzlwkuTfl3RYhNgSCEgWv9Pn4H+BmDKpYkSxGz28HbDv64hHdEnDeG0GYX0vee54
LTQeNpF9wPEPVh+XDXdPQ50QITQWl87S6D1Aj4WYvcsIMi+T+Z6k4bUjmydRqVHa
7rRmLS9rRCVddZNdtnqq35zKdrcxInijHFhwvn95IJNDMAbN89HyOMLq4wwlfUYf
vhha9AtBhT7IRsB+4TKgnmQ18x5ha+Bh4iHREcZa1p7PJSOd/bI=
=PWUu
-----END PGP SIGNATURE-----

--JprSW8tGz6nv--
