Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AFAC433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 07:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350262AbiFAHSh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbiFAHSd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 03:18:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A853BFA6
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 00:18:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30c1d90587dso8481387b3.14
        for <fstests@vger.kernel.org>; Wed, 01 Jun 2022 00:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=njWOh6xIF8JInl46Oy3mwRCy83f2wUQMvRE0/nlRIWw=;
        b=ASBtyGuRi0uJdgg3X/I9/B4iNISBpM0ojz6F3WXYjiqvgmOuuqXxIIdTS+T5u4eFe0
         W9dcJRfjoltRIdiBqTWHYfs+T34BsmVXTq4/O2bzTw1oei99/OzO9/5S9jtzyadC1c5f
         1qt0OOGYjdbG8nESIBLSdZ5AfsrBLc4v34ItcpuFpPhmwZvwzY0EOhOyv9OBlliX1shs
         LZpzD4el2ds86FaHITNAvs+cZH9gGZiWeCx4BQlkdOF4R/+NfdUrFyIWR2WMEOw/liKg
         NBX6Xk7cs7bY/tMPzW+tI8LICzgIORtZgYGdIN7ivYs0BLdrs73NzCU8KrlHkxo4cS9u
         L1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=njWOh6xIF8JInl46Oy3mwRCy83f2wUQMvRE0/nlRIWw=;
        b=F5Vcci6+havkufRv0hRA+MjTJuYoDJMpTMF0qtI2fdjZTrRkhhpaj4rlfBK3CaU/W1
         0n8Vb5PvwKP3/OUyS9MxFmi45Mteipkw32pyIrYftoJykAABEIudDym7qUpZZkSYQsAe
         dddshiMa4d2C7yF0d/dLomwe8UR845W1SrGnLOU//585TjaLVvgGE2PS6TnMLLAmzpxP
         mTpbIpbvF6qQ9v++pVaRUvJvqIUF9Bs0a1rKtfoGKkVeLTtjwDQULaoGtXEiAWF0tTvl
         t9o7YWlAYIcaU+2j1670xvYRozTMn6IoaEdfKbOPHejLaG/WrUYos5sfbCBPnr41JlYS
         CP/g==
X-Gm-Message-State: AOAM533ZwG9Svzu8y0ZQBD/1eCg6gzA6/0TXM3029rXLZLGVjlsn92ob
        LnhjC2nxBe019fwXO/NhVvTChTtGoF5z23scePymRtD5wRJjxtDEW0dfNH0PK+3S42elA4bNzGd
        MUXHU9JVRV9xfOhQGwtN/ZnlcFkbymV/dntAteIyiem+dmZkAg9lTJUlw3k5A
X-Google-Smtp-Source: ABdhPJxDWkMZPTrv0lRCxwnetBUmWZi+WfdvM5H5mWyEUZd7TwYJbx1iHI/GxahicakNXnVXEH56UT5jQw==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a5b:a05:0:b0:652:493a:b35 with SMTP id
 k5-20020a5b0a05000000b00652493a0b35mr40038803ybq.286.1654067909397; Wed, 01
 Jun 2022 00:18:29 -0700 (PDT)
Date:   Wed,  1 Jun 2022 00:18:09 -0700
Message-Id: <20220601071811.1353635-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [RFC PATCH v4 0/2] generic: test HCTR2 filename encryption
From:   Nathan Huckleberry <nhuck@google.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org
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

Changes in v4:
* Add helper functions for HCTR2 hashing
* Fix accumulator alignment bug
* Small style fixes

Changes in v3:
* Consolidate tests into one file

Changes in v2:
* Use POLYVAL multiplication directly instead of using GHASH trick
* Split reference implementation and tests into two patches
* Remove v1 policy tests
* Various small style fixes

Nathan Huckleberry (2):
  fscrypt-crypt-util: add HCTR2 implementation
  generic: add tests for fscrypt policies with HCTR2

 common/encrypt           |   2 +
 src/fscrypt-crypt-util.c | 341 ++++++++++++++++++++++++++++++++-------
 tests/generic/900        |  28 ++++
 tests/generic/900.out    |  16 ++
 4 files changed, 330 insertions(+), 57 deletions(-)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

-- 
2.36.1.255.ge46751e96f-goog

