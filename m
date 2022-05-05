Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A3C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  5 May 2022 19:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355244AbiEETl6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 May 2022 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiEETl4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 May 2022 15:41:56 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0915D5F0
        for <fstests@vger.kernel.org>; Thu,  5 May 2022 12:38:16 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id s14-20020ab02bce000000b0035d45862725so2258233uar.22
        for <fstests@vger.kernel.org>; Thu, 05 May 2022 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uOhzFELe9XcvDyHeZG2QQDQ+Oiwi9529KFSTzUwC/rE=;
        b=Di8i3ZORhuFulS8R9aXEI2b4ziCwlM2CdfoBg5SyfXZXodGlsiUu71gYO/ofHxMZTx
         6sYePsyj3QvLb7M15kCLZRN5uW/YpKsw2QQcCo40+KXUvA5FEYCfdPJ0wsGIhhDDvLu7
         g/ajVvTl0dG0KSnrQhFn/tG6Zh0eZSaGuKvqbZHjGw7+FnXsY1lqTNwAB+ms6hbhZQAN
         jKcmgIK/VwOeBnqwET7r0uRG/2MXhwxBg+IFmJy1sQdEEliKsDPwV0mkOjKbGMvEdq8U
         6ZCWus8vL/33ZP0UcQKuxENY3xMUGO3aZmImsiiTg9aMq71O1MhPfOB1PulJKo0QgQZl
         DXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uOhzFELe9XcvDyHeZG2QQDQ+Oiwi9529KFSTzUwC/rE=;
        b=4r8VBtQ7I15qlnvuoMywIFxwR3D0rSApFJkW/9IPIUq69UCcDuWaBs7aRUAMHPdJG9
         P63auTHDAlScU13gAZRklmTbxr+rDgGGymF6H3/lvp4hvZPT4wj0GiFuvIvdqFOAPJj3
         tPKvzJOEIu5tme+8OrWadW2PCgavJ1kXsljUSj7FjCywJ5x6J0rOe4/I50ffIrpdgBNU
         0gYfiA+myEztWbIC/ZHmlOYRWWuQlsDjNu25dPAfRqQaz3pqeS1opj5dWvrplfm4GZQi
         1bCWWwqGGEm3Imu73vQ8QE0OtbleDK0r/CDz4w9xrMgTiizo67wKrEnHPkdjC8PX216o
         KiSg==
X-Gm-Message-State: AOAM533Xz0MneOCxmJf7HfwI8XpRFL4ZK1h2p8GoPv6LXDkf+EE1IkOH
        vJFESqaUdLgiEAQXN7RW4eGlmG+opQjl7mR4AX9k4ggCxTOvZAf25PC8fP9QaGoup3q9YTlfm64
        4FTUFeO3ZGhKXxe4+BxM/VjL8mVp7mw+jwoznG8R1R1sg0sBB0ni5cXX0pI4t
X-Google-Smtp-Source: ABdhPJx4WlGanrj4R4a78WVzwX3713ktjxcBqxSoaOpWaIGT8quc+g5IDVjbMImH6nTrhjpzpB3Z362j6g==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6122:dd:b0:34e:c5cc:f6e1 with SMTP id
 h29-20020a05612200dd00b0034ec5ccf6e1mr7604044vkc.12.1651779495715; Thu, 05
 May 2022 12:38:15 -0700 (PDT)
Date:   Thu,  5 May 2022 14:38:07 -0500
Message-Id: <20220505193809.579026-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [RFC PATCH v2 0/2] generic: test HCTR2 filename encryption
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
here: https://lore.kernel.org/all/20220504001823.2483834-1-nhuck@google.com/

HCTR2 is a new wide-block encryption mode that can used for filename encryption
in fscrypt.  This patchset adds a reference implementation of HCTR2 to the
fscrypt testing utility and adds tests for filename encryption with HCTR2.

More information on HCTR2 can be found here: "Length-preserving encryption with
HCTR2": https://ia.cr/2021/1441

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
 tests/generic/900        |  24 +++
 tests/generic/900.out    |   6 +
 tests/generic/901        |  26 +++
 tests/generic/901.out    |   6 +
 tests/generic/902        |  26 +++
 tests/generic/902.out    |   6 +
 8 files changed, 377 insertions(+), 57 deletions(-)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out
 create mode 100755 tests/generic/901
 create mode 100644 tests/generic/901.out
 create mode 100755 tests/generic/902
 create mode 100644 tests/generic/902.out

-- 
2.36.0.512.ge40c2bad7a-goog

