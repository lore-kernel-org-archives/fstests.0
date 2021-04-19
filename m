Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC5AC433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Apr 2021 22:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D745D613BC
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Apr 2021 22:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhDSWEl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232746AbhDSWEi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Apr 2021 18:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618869847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mWostLRdcKbsh6M5eiER5puOce3bNY7mMdN0XBS9bq0=;
        b=Sxcttly/yvtDqVgjQapDkTnD0qif14hXDGMrMXjY07tTa7nirEwhwL91qSxoWtAXaxpzcm
        Jx1blee4BLlRMCnOzxAa0fWaARgZKVLcxGF2zP/RJgeEPV6bv8g2R+vXOTmnmm9aNdC3ci
        jtRqahBKi/7YcbrbZtU7wQMj/wM5OYU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-FAmaw3zKNturo1yD9YcXsA-1; Mon, 19 Apr 2021 18:04:05 -0400
X-MC-Unique: FAmaw3zKNturo1yD9YcXsA-1
Received: by mail-wm1-f72.google.com with SMTP id a71-20020a1c984a0000b029013841a43c3dso836077wme.3
        for <fstests@vger.kernel.org>; Mon, 19 Apr 2021 15:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mWostLRdcKbsh6M5eiER5puOce3bNY7mMdN0XBS9bq0=;
        b=rwZ75Wq6ysxHi9AziG0UQloOszwgMqgAPLYQgDZpLHYh5Zv2P3hCM3y4McoiBLp6AZ
         jetnhHgwyJhCqu8JMqKA8z4yhgvR1CmeLgW99Q9Yp4pdCtaydvyk6Zm/A2rxlXmeMRFV
         uopkJFzooCWAyTphep2SP3Qm6Fsx165f0KxugVBCBfBm02gg8aYAyVcPWMM+8ilLxI6Z
         o3RqeBJGdRXIfoZgesn2Gz7dnUGf7b/ySPPGBsdRB9xh4xhhPKTdoItxr/vljV46yg0n
         GBubiYBDx8utLO5Dp/qfHVAatP1KdbJKtsR1ahRA8U3rCkVaH7LFUHDAWUSupjKt+Hwp
         toCQ==
X-Gm-Message-State: AOAM532Rvp45fz0KwOeUxEIFktaceFYNbTvgE7clW7jjyuLH2RgqQ9uH
        rarKGXJvdQkydUgECqoTMBEubJsIL5UXnVJPiaxOfopctyXO9n+nEluHLcqXLljcGq32NSMouQD
        vc7Oi1bsdTmqCff7h3DzjdMbWrAuKoNzXs73qPuyxR8JQ/5tPwGsgWyLCwvVQiGyVkb+i
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr16593543wrs.67.1618869844606;
        Mon, 19 Apr 2021 15:04:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoo4F66BMzRKrjmpzqO7hJv+wzCQmiXezq20Pu4HrINzOYf5VgBhOaZeOiZTKAg9qV/5sCow==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr16593527wrs.67.1618869844412;
        Mon, 19 Apr 2021 15:04:04 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id w7sm18775566wru.87.2021.04.19.15.04.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:04:04 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v4 0/1] Fix some tests failing for exfat FS
Date:   Tue, 20 Apr 2021 00:04:02 +0200
Message-Id: <20210419220403.70727-1-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Do not run test that require posix permissions and ownership.

Changes in V2 (Thank you for comments on version 1)

* Merged patch #1 and #2 (the one introducing the helper and the other actually
 using them)
* Fixed generic/597 by introducing _require_symlink
* Fixed generic/598 by adding _require_chmod
  ** changes are part of patch #1
* Introduced _format_swapon_file()

Changes in version #3 (thanks for the comments and hints!)
* reuse _require_symlinks() instead of introducing _require_symlink()
* implement _require_chown() so it actually checks if chown() is supported.
* Don't special case filtering of MKSWAP_PROG's perm. warn for exfat only.
* Rename _format_swapon_file() to _swapon_file() and also don't special case the perm. warning filtering

Changes in version #4
New implementation of _require_chmod()


Pavel Reichl (1):
  common/rc: Add _require_{chown,chmod}()

 common/rc         | 38 ++++++++++++++++++++++++++++++++++++++
 tests/generic/087 |  1 +
 tests/generic/088 |  1 +
 tests/generic/125 |  1 +
 tests/generic/126 |  1 +
 tests/generic/128 |  1 +
 tests/generic/193 |  1 +
 tests/generic/314 |  1 +
 tests/generic/317 |  1 +
 tests/generic/355 |  1 +
 tests/generic/597 |  1 +
 tests/generic/598 |  1 +
 12 files changed, 49 insertions(+)

-- 
2.30.2

