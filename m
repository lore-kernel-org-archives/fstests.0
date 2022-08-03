Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DC2C19F2D
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 22:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiHCWll (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiHCWlk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 18:41:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA6A17053
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 15:41:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3282fe8f48fso29717227b3.17
        for <fstests@vger.kernel.org>; Wed, 03 Aug 2022 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=S0/vw0Nl67oHNQJ7Nte4HHrn/ydSAQzvDvRWkCxsVwg=;
        b=fizuI03MKx7Hqdzk03+NQOEGQuKC7s8Z+MB/3OmUIIImCRdZmY2Vfp0uxufA73M5jC
         j8abPbZstQoWhsS2yih16vdwhjSQdfcfvKnDafSHlrtmXzc+lJviMfFYowqM2Y/fTy/J
         zVrnJ8D/NUgzDlU5JqQop84Slq74yS6snL+GrLwbG8fHUih8dEQx+bcNJjf2VVhZWPGk
         m5JyI1sYUP2LLj4e55/XhQ6lzb5JzDvI/AS+qTZNAF4pOKOGvmh+VmVtq3bD4WYntkJc
         1tG3iAvSOBthFIVvBM2EiSAtuU0owJHoRG5gT04zlERB7sbLGNZyq2aBLRNG+XIw1lWv
         FmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=S0/vw0Nl67oHNQJ7Nte4HHrn/ydSAQzvDvRWkCxsVwg=;
        b=GwUfKAswRXJr2wZzM07snlxYvfBPYNpZHA7d5rlIeMIH65fmCzN5tHnKVNJbkaP9Up
         4O4TFblhfBw/0ZY4pdEWWJ5bzH+JYgLiDLbUbJ+19uC5y6wSbJKbhSfRAC/AqcyydyTZ
         40AttS3q/Sy5encfh5sXWMBb11+ImQGYmuPrPWzTbYRIrFmQjgDXKOBNTceT7NRAEbzb
         RoHBHN5DGpPL6yH0BPOYswEuztoc0pL45sDzp5k7/GYwHAXFJTx70PuN/RUKN6P0c00d
         lCyKzySh485mYk42hPl62lqnaI7Ab+hMXBHYe4XU51DcB4C1K66xfRHsYQmADFWuRLMS
         oiDQ==
X-Gm-Message-State: ACgBeo3pDgFkP/we7P1fQz9jqfmKMndLwyTaNx8IlMYzKHAADfBc5JI8
        ceCe8z0JBL/+kKE3m9vOlNiJS3cmFsZqcmYfNY1uXiyrhijPOALDqGYWbyjnP9XkiyOIcmn7e0S
        7lmHyWSwPe5oK+mHzRjbuRrprrToM4dt2hiwroPsMq62ZzA8Qa1PfullHZaGY
X-Google-Smtp-Source: AA6agR4DFWEUuN06cJE7eMjWK5wXU7KQugMPBPvdHcXkoW0A97qz2kX0sUYnV1JGfRpli9LrzOpYKrIADA==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a81:b613:0:b0:31f:4324:7bf9 with SMTP id
 u19-20020a81b613000000b0031f43247bf9mr25393496ywh.408.1659566498546; Wed, 03
 Aug 2022 15:41:38 -0700 (PDT)
Date:   Wed,  3 Aug 2022 15:41:19 -0700
Message-Id: <20220803224121.420705-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v5 0/2] generic: test HCTR2 filename encryption
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
 src/fscrypt-crypt-util.c | 358 ++++++++++++++++++++++++++++++++-------
 tests/generic/900        |  31 ++++
 tests/generic/900.out    |  16 ++
 4 files changed, 350 insertions(+), 57 deletions(-)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

-- 
2.37.1.455.g008518b4e5-goog

