Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B83C433FE
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B74460F58
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 15:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhJJPa3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Oct 2021 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhJJPa3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Oct 2021 11:30:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F65C061570
        for <fstests@vger.kernel.org>; Sun, 10 Oct 2021 08:28:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r10so47252830wra.12
        for <fstests@vger.kernel.org>; Sun, 10 Oct 2021 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=ai0bFRMZ0qcSrjS+0l/BynD8L6ABY6Kxlm68DihJxaw=;
        b=cYuBi3Tu+GGzhQ20aztFcdd7FthimtGCc64bcCz6Pcty657EHVk2FKVgbXESNMFDDX
         Y5EPdfeHVPoEG31s331Pq6HZ6o8rgoCnlEkVSuntBfdp58uF3z/p0OnvmYp09CdIkyOn
         kZXqXP3i1Tp8KnX+2mfEP2uKhV5asNpGZN3T+W+j8/uAq96SqHS1l65Vgox7eUETxd0m
         qE5aH/RP8f3WYCULmn7ofrU+z68cV/LgPsEKhb2jh/b241LF6sTZLLr/3hT9JGCVqL7v
         /tbfngpYKQrL/p/Q6q2Fk6mBeCQQ5TuWOjDBddbXzG0mhRep2rQ0Z+cVX1bZeLYfTJ0c
         /gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=ai0bFRMZ0qcSrjS+0l/BynD8L6ABY6Kxlm68DihJxaw=;
        b=lLpAEHe1Bj9D4RBV9vkR4BkBQWfyJwfZbfeZe2qsf5NOuT8UsnTzG/BKyTkeeLvoTR
         /5yAN7YEm3JM7mM//8242po4gQLMYaW7Fje3TTL8fTBPylcWdhMC4/5SvrRdgJ4+pacW
         mhyIQpxkW1+KWBKJFHJhiDXqh0JzoUzYr0smy4iXbKISyWi0LaF938FYc3yw7stHIFDA
         IIG/5EMqiKGJ00yAvId7tYMg69UoEjZMnrsfH8ed9a6DnzfxZz0lb5LJ11rlKj+x2EhU
         J1rF/5Ob1usLqKyylyPonzV9jb7CbIwqfTRxvTCe635IeKTD8LPmh1Hv+3dB739uXikA
         c+Qg==
X-Gm-Message-State: AOAM532f4Xaz+YV91x30XlsJfrWe8acoYAZ0NqeDxDdWYJDidWT3I2sw
        BqazbXaQgbogjpL2obX5g29SiC8uz6Y=
X-Google-Smtp-Source: ABdhPJzB+xnlqdiyz4mGJeCx6LgjS178Y5bRtU9K/AIYOETsQEhI37WgyypsFJYAycOD+nEC0QnHuQ==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr15707591wml.109.1633879708873;
        Sun, 10 Oct 2021 08:28:28 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id s13sm5450906wrv.97.2021.10.10.08.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 08:28:27 -0700 (PDT)
Message-ID: <6163069b.1c69fb81.bc811.b886@mx.google.com>
Date:   Sun, 10 Oct 2021 23:28:23 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 47a1238bdb23
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LjLUmnkckSGK"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--LjLUmnkckSGK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a bugfix only update and should not introduce
new failures.

Thanks,
Eryu

The new head of the master branch is commit:

47a1238bdb23 common/log: fix *_dump_log routines for ext4

New commits:

Catherine Hoang (4):
      [69575301c85e] fstests: rename _scratch_inject_logprint to _scratch_remount_dump_log
      [d888261aa0e6] fstests: rename _test_inject_logprint to _test_remount_dump_log
      [e61c2b753cc4] common/log: move *_dump_log routines to common/log
      [47a1238bdb23] common/log: fix *_dump_log routines for ext4

Luis Henriques (2):
      [7a2cdfa745aa] common/rc: add _require_user_exists() to check if a user exists
      [dfae4068a824] generic/079: make sure users 'nobody' and 'daemon' exist

Yang Xu (1):
      [aca74d17ccfa] xfs/540: use _scratch_xfs_set_metadata_field api


Code Diffstat:

 common/inject     | 26 --------------------------
 common/log        | 30 ++++++++++++++++++++++++++++--
 common/rc         | 27 ++++++++++++++++++---------
 tests/generic/079 |  2 ++
 tests/xfs/312     |  2 +-
 tests/xfs/313     |  2 +-
 tests/xfs/314     |  2 +-
 tests/xfs/315     |  2 +-
 tests/xfs/316     |  2 +-
 tests/xfs/317     |  2 +-
 tests/xfs/318     |  2 +-
 tests/xfs/319     |  2 +-
 tests/xfs/320     |  2 +-
 tests/xfs/321     |  2 +-
 tests/xfs/322     |  2 +-
 tests/xfs/323     |  2 +-
 tests/xfs/324     |  2 +-
 tests/xfs/325     |  2 +-
 tests/xfs/326     |  2 +-
 tests/xfs/329     |  2 +-
 tests/xfs/540     | 10 +++++-----
 21 files changed, 69 insertions(+), 58 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--LjLUmnkckSGK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmFjBmwACgkQJlKqKVyP
52OeLw//Y8wpPKzD9jU4BmWfZAJZut8Pbq/xypiJoelxMzaB9W88gBLhSXRxOL0V
pQZL2LWDIZ7uG8OWfhweKV3d9RAtMvfTe9mQlFlO9LNqzCplnNkK+1ElFxvYurWb
kyqrtA5JCM4xlefMrADRlplr4/3Z6h3FhoO1chleOPC5zXb8yzPwMhqNeYA1KoVT
upgYV6plrcRy5xr94n5ejKh2iBUMCqxWq3Bh1lwsrz/V4IA9Zb1yWpGQ14rT9qqh
kNjXIPxrKtTmcK6UBtAC3AtzLuAY+w4NOltTG90pfLZk5DdcNrsIfQgXSbjr7faI
4AceiMFNTyHXLls2GjTKVFLBVVSE47Qe/7KZZkggvl6bEi+NM4jegjgFdKOVNChX
99FhfLaj3hT5n/bnn1LzPIilObelko0bwX5q9XAbhQ7StiDszNiAmujzlDaLotl4
O+//M0VclZPtILiGTQFu7/mjA2cO3lnvPfRtRY8tGOvLOiURubPoXE34tPVcE70G
hlOlV4UX33yoknvX4KVSSfKwk4cqOjq80GPXlO4cdWsqC4XQm6Mk6s+eEoifyqyA
9LJELBuhM4dkbSg/32lC1/g3srBHzX75lCKtxXVV7io2U+Iz8KvEyTInLqiMV6dj
DhOI4LEbAEn5Or1tUK3F3e6WAeJKLbSeXjPP0F2JYVmpzJnepPg=
=YZKP
-----END PGP SIGNATURE-----

--LjLUmnkckSGK--
