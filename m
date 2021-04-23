Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F89C433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 10:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0103961184
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 10:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhDWKIM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhDWKIM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Apr 2021 06:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619172455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lJ9XKjxt1CsU0GNoIfIyywORJZ5QV/K07WCMG+YUfcw=;
        b=DOTOJ6Mg5F6ssOoY60XyKsCLoVIb1AQnwBRwRha3MgxVeJYGiYywC7DYqFpT/Y7uG61nMC
        0PQV80wgA88+jDGiq/tkgEdvvBbO6j1Nosu1ZxmMLQnE5LSKffemyk5uc2HDFGl6mJDojN
        PPKyquSR025rofBCUuz6WZ37FDLK4nE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-5yw4NyNEPrODEwlIGwfjOw-1; Fri, 23 Apr 2021 06:07:34 -0400
X-MC-Unique: 5yw4NyNEPrODEwlIGwfjOw-1
Received: by mail-wm1-f70.google.com with SMTP id c2-20020a1cb3020000b029013850c82dbcso554116wmf.5
        for <fstests@vger.kernel.org>; Fri, 23 Apr 2021 03:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJ9XKjxt1CsU0GNoIfIyywORJZ5QV/K07WCMG+YUfcw=;
        b=grdh54OrRt8lwk+O4kbbIKQxVFUdY3IOHyLrgjuSjg3PucYSo+UOfJngIw7Hc5QmKe
         4+EudF3dECknAllewVi4klgkZx3dZZzZ33PVCH48aGfLIKfL4q2yWi9fX1mYyhJmavIy
         7vHwZB0dRqvGA4rn9TQRUqdV0I77EHB4qPHkVzyCCACAIAafVSovkX/Z9iDy+V6HTePO
         sLd9YffK96YWSTg/75YsEfw48dm6YeyQ8IDaXEeUYrFDvuDALQf/lLQY3JR/dj1s+9FJ
         1VRK+/E5Kw85hhrxsHrqBJA+fnepy19mAgIJqEmuNIwKkswTQ7spd1HkrzF6jHwhM7QU
         BqFA==
X-Gm-Message-State: AOAM5335aFItoeExYCaXJrnCdHzsiRzg3AGCcSYeRIZNGuMo0p0Ae8pp
        uOnlFsnr1dMjTECn3KZ3eZbNcyouApyb3odIk5eYLWcnnBg3zeWfV2zzlhkcSNAnKyG8mrmhh1u
        Z/ud2Zn5oatLFjts5g27KTjYFqGSgAy6XA/mfxTD9ZRQgm86cwaVGdOipd0V+UZVoxCMB
X-Received: by 2002:adf:a1db:: with SMTP id v27mr3708463wrv.181.1619172452859;
        Fri, 23 Apr 2021 03:07:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjlv2xuLj8bnWFRgij2rEOVew8Qt/6Vgm5uBGWzBMMrPpuCANEzwi8XB8P0fCSxuHyJ0apvg==
X-Received: by 2002:adf:a1db:: with SMTP id v27mr3708441wrv.181.1619172452654;
        Fri, 23 Apr 2021 03:07:32 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id z14sm9887003wrt.54.2021.04.23.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:07:32 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     bfoster@redhat.com, shreeya.patel@collabora.com
Subject: [PATCH v2 0/1] generic/495: split the test
Date:   Fri, 23 Apr 2021 12:07:30 +0200
Message-Id: <20210423100731.14111-1-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Changes since version #1:

* Don't remove the swap file before the test is run in test #634 
* Added tag: Reviewed-by: Brian Foster <bfoster@redhat.com>



Pavel Reichl (1):
  generic/495: split the test

 tests/generic/495     | 14 ++-----------
 tests/generic/495.out |  3 ---
 tests/generic/634     | 49 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/634.out |  2 ++
 tests/generic/group   |  1 +
 5 files changed, 54 insertions(+), 15 deletions(-)
 create mode 100755 tests/generic/634
 create mode 100644 tests/generic/634.out

-- 
2.30.2

