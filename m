Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB46C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 18:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiETSXl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 14:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiETSXj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 14:23:39 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCECE190D09
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 11:23:37 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id x5-20020ab06405000000b003687fa76136so4117720uao.12
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=REzweU6MDoliJ684hJ+fWCW4vt0xxEMycl1/3SQia/4=;
        b=frU484IWcx9dxxdR3mlAxHDXq804nYmLKIAlfasxFJre10iHkJNkzn+VNeR3rDfMYi
         otSbRHgBoGneAFlnoWoQO7Hhgbsiv3I6985POhw8HHVUzkUrgRU83T9/tdCb95d4V3MY
         TtZxW0c4w2Kn7XiWZqhVy8rzJKf7B1kKjZcqaKC+pEJkuMVgdulNEomRHzRsWhN1D9ur
         4CCqTpPzFpHlc08KlIvFSUIIjU+5jVaX5v85U9QUOw2rZHdsJzPmcph9vS/HfV1B+kZd
         iULw5+9QNVuDRd6uwGF11bZun2s9NNaDmlOU2dM//JMICF0lR0c1AOJy6LFoCwVKzLvb
         fS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=REzweU6MDoliJ684hJ+fWCW4vt0xxEMycl1/3SQia/4=;
        b=H7hRk2zOoY2ajyEJcDwObAqPFbDaDx1T94P0msk6DyyfB1fDepsCBwh89S0DjF/Yj1
         mJoqVabk+03DyewDw3sXF3fXgRlFDCKfNotj1UYyfkniedmhQ3n3kBYGeaGnX7NOH3B+
         8car/f9yE1hXhg+XUGq/EEp1px1KBovmvlyw54pDowqscqsxOFC9HlDDhDLw64Vipj8c
         cX8uRfJF/IYpxSdu0Qa9itlA1ANT+S3oHvanvT0GAxnjHDXaAHTvitGV7pgtMbzLReyg
         lIoRuSxgLlDT37cMM9vrDO5Vy9U50TDQ09ipXGSpy5/kwx2mdfXQ15HNSJ3f4Dds0H82
         Bssw==
X-Gm-Message-State: AOAM533YZZSo4+um0kgiJOFOl/yCTymvOyqO+zEUFfBogndA37UJnvZL
        GEjQ2q9011U/aOnNrJtRuXV93GUWr4tHcYPQxGb3KubiW8Fd6lz/zBfNtUKOwHHtIy6cTn1SbLf
        foFWirArQhu07qi4gZdeNFkJPHpWzkI0tRJkRwXBX8IbptEsxc2XHZMYp+09/
X-Google-Smtp-Source: ABdhPJz5ZGdbHHjBEuV/0hlYosc+tsF/zZrAij8an3DQx6uXs5nVRDqtDPGMplW/fkmQ2Mq5s5zeG0wCRA==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a1f:9b85:0:b0:32d:4d56:cf64 with SMTP id
 d127-20020a1f9b85000000b0032d4d56cf64mr4641588vke.31.1653071016857; Fri, 20
 May 2022 11:23:36 -0700 (PDT)
Date:   Fri, 20 May 2022 13:23:13 -0500
Message-Id: <20220520182315.615327-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v3 0/2] generic: test HCTR2 filename encryption
From:   Nathan Huckleberry <nhuck@google.com>
To:     fstests@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset is not intended to be accepted yet.  It is reliant on HCTR2
support in the kernel which has not yet been accepted.  See the HCTR2 patchset
here: https://lore.kernel.org/all/20220520181501.2159644-1-nhuck@google.com/

HCTR2 is a new wide-block encryption mode that can used for filename encryption
in fscrypt.  This patchset adds a reference implementation of HCTR2 to the
fscrypt testing utility and adds tests for filename encryption with HCTR2.

More information on HCTR2 can be found here: "Length-preserving encryption with
HCTR2": https://ia.cr/2021/1441

Changes in v3:
* Consolidate tests into one file

Changes in v2:
* Use POLYVAL multiplication directly instead of using GHASH trick
* Split reference implementation and tests into two patches
* Remove v1 policy tests
* Various small style fixes

Nathan Huckleberry (2):
  fscrypt-crypt-util: add HCTR2 reference implementation
  generic: add tests for fscrypt policies with HCTR2

 common/encrypt           |   2 +
 src/fscrypt-crypt-util.c | 338 ++++++++++++++++++++++++++++++++-------
 tests/generic/900        |  28 ++++
 tests/generic/900.out    |  16 ++
 4 files changed, 327 insertions(+), 57 deletions(-)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

-- 
2.36.1.124.g0e6072fb45-goog

