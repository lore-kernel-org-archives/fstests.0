Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DBAC25B08
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Aug 2022 19:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344766AbiHITFK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbiHITEI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Aug 2022 15:04:08 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB6767B
        for <fstests@vger.kernel.org>; Tue,  9 Aug 2022 11:40:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ln10-20020a0562145a8a00b004749ae27efcso6755349qvb.22
        for <fstests@vger.kernel.org>; Tue, 09 Aug 2022 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=1zWpWT+dDLKtaXv3odJUGYprUkEzrz7PQwCnoeb3LLM=;
        b=ZkXl682ZDr+pglw3RZo9b/aeGI2yf8sm2Wo+W9VKaqmM79+6+pmnQHOXapWBfEnB1Y
         CtLCVagG/pnI+HI0yyKZS8pp/aXgp5M1ifkDUOhb2kgYmcf7kJF1voChXR9NTTZZpolZ
         jnMSW7KB1od8o76CqJcu6z6VryiZZk38Ycs3m9KKEhecofD3uO0953R9m2SKttlEDQls
         CtW/yQgkPZ7UvsVdUVMNBTBTvli3mU4UVvQgWH19Oy9Bsjz4WNVtl9SScL96w/Xbq8sO
         8KOVCoOKFsRGltiVcv/5wZwobhZlwnBZ2mSxi+RwvBGEIJRne0R/csII/2s8bN/wspCW
         3foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=1zWpWT+dDLKtaXv3odJUGYprUkEzrz7PQwCnoeb3LLM=;
        b=aJjz88Qb1hRM1HdtnsIZ+JduIwEkj9JN1Zuj4cCBbg2zxkJnpCP+z9+Lq0yowdOSf5
         frhKU2zcCRQ8Kjk2w//awoa8IhfRgyJccUspzQiWu3vGMhLniizU5wJxZqfLGEr6g/Wj
         gzX2V5K7SkLB/37vzPEfP5dVj50ysEHEqg58zAsVel2o4tvcilWrN9KelvjehqzJSiSW
         NzOF3XrJ/RmpUJSICNa8H5bGkhbrtiuYMhAI0Py0js+z1egxhOrTEMNrxZJZ4MX6bnQ4
         tk/TxmyZEkJehDYq0rylYKLoX+NKgh2PpOiB5X+yieNFDPro7pU6Qtwv12PXFfmF8rNp
         MgrA==
X-Gm-Message-State: ACgBeo25XzlB5yfaaF82/CqpAmwcFQKN3X2Te5EW08cpR1rg0TRncbfM
        md0w3tZyIyAj6bekZ6UsiUw1x5gceiuVDAt9+v7hf/Z+SxhM6ZzM6+nPrYPTx6JGnaNeLiK8Om6
        ejOfJm2tJBhoNBTqQTmbKW68P1K9OkQilgETvTwUIAwyDrtdVjjUhaxNSfFkQ
X-Google-Smtp-Source: AA6agR60MQCbCSzDBNWfSbcCJA3zw056vNqhWXxNcnr1nj9VLoORUyg1RO4w6/mK4RbMyUaNCOOsbtJqhQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6214:5290:b0:479:5df:e654 with SMTP id
 kj16-20020a056214529000b0047905dfe654mr18976501qvb.97.1660070439687; Tue, 09
 Aug 2022 11:40:39 -0700 (PDT)
Date:   Tue,  9 Aug 2022 11:40:35 -0700
Message-Id: <20220809184037.636578-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v6 0/2] generic: test HCTR2 filename encryption
From:   Nathan Huckleberry <nhuck@google.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

HCTR2 is a new wide-block encryption mode that can used for filename encryption
in fscrypt.  This patchset adds a reference implementation of HCTR2 to the
fscrypt testing utility and adds tests for filename encryption with HCTR2.

More information on HCTR2 can be found here: "Length-preserving encryption with
HCTR2": https://ia.cr/2021/1441

The patchset introducing HCTR2 to the kernel can be found here:
https://lore.kernel.org/linux-crypto/20220520181501.2159644-1-nhuck@google.com/

Changes in v6:
* Remove unused variable
* Rework cover letter

Changes in v5:
* Added links to relevant references for POLYVAL and HCTR2
* Removed POLYVAL partial block handling
* Referenced HCTR2 commit in test

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
 src/fscrypt-crypt-util.c | 357 ++++++++++++++++++++++++++++++++-------
 tests/generic/900        |  31 ++++
 tests/generic/900.out    |  16 ++
 4 files changed, 349 insertions(+), 57 deletions(-)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

-- 
2.37.1.559.g78731f0fdb-goog

