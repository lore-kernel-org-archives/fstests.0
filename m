Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E88EC433DB
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4266E61A24
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCZPlw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhCZPlk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Mar 2021 11:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616773299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+zoNRpUumiUFVkDVlZxJlnKXvSc99ieF+FAuCJDDVqI=;
        b=QjrisTdyvY08BQPtT1oundVUA8ucF6HY7ICuB3JFdenqvHJMcmOeWB3bHNip1GH1kCYfX0
        VFRSl5WMQtgIvqi7WICbB+GBBSHJqryILTvpgZisiMbZHKk0iqF/h5wPY9oCSgsl62FUK+
        +ZO4dYWYZbWw/nactYtAkMq44zu1A5Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-in4CSp73PiWNAxeE98ukAg-1; Fri, 26 Mar 2021 11:41:37 -0400
X-MC-Unique: in4CSp73PiWNAxeE98ukAg-1
Received: by mail-ed1-f72.google.com with SMTP id bm8so4620255edb.4
        for <fstests@vger.kernel.org>; Fri, 26 Mar 2021 08:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zoNRpUumiUFVkDVlZxJlnKXvSc99ieF+FAuCJDDVqI=;
        b=YJXrCaQsxCsvDIqoGA1t5gnm5wjtn6ABKxUsoUvmkHSapTmVM/9btbYI+lVgm8JyH+
         BzlgXzbbPT1LskzKiilni325f9D06idI5oPyV304ExHx2dqYKdO+pVhfLacB+b/nnA9W
         9RvnlnA6A/JoP6r8bzwp8MpYrcpi6Wt/swQptjhQwBSatDZX9K8wOCj/k3Xo0pO9JLA5
         Hgu/12l6aopcn2fjhOeFU6N+8wh7gN3nvPWy2Alnv++Fexhwz707J9/T6pySuObp8hTK
         UgA9c/ZCldNlO5NCfaZQvcZ45vUqb2lnMkocfrOG8Fe9ZxwVV1Ys7nUfOQmDZaUq7MPq
         QUJA==
X-Gm-Message-State: AOAM5314iZbtWEHF2WQNpfYWX9oMoWybxdmc4Vl5YoSFI+XRrnsjzpMM
        QH3pWGjJ+vawR7NZ1z3I2ZkOKSdolyhf68TGrJC0N2Lr9Pi5x5mYVDZiaGo/qKAj2OG99mmRYiR
        G4tx/VXz/XQVd7c72ISuvMUSTSs6Jwv72ihf2nBE8YLMWBgqnXifSETyunmhsIvCRYjmt
X-Received: by 2002:a17:906:5797:: with SMTP id k23mr16507513ejq.515.1616773296034;
        Fri, 26 Mar 2021 08:41:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWdkOJimoX2Z2khqWCXV6exZRodv94WaeZppdl0fgVN13UuUduEINLE7Dp2an/ireB0i1gUQ==
X-Received: by 2002:a17:906:5797:: with SMTP id k23mr16507490ejq.515.1616773295858;
        Fri, 26 Mar 2021 08:41:35 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id p9sm4389791eds.66.2021.03.26.08.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:41:35 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, xzhou@redhat.com
Subject: [PATCH 0/5] Fix some tests that fail for exfat FS
Date:   Fri, 26 Mar 2021 16:41:29 +0100
Message-Id: <20210326154134.309159-1-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Mostly just do not run test that require posix permissions and ownership.




Pavel Reichl (5):
  common: Add _require_{chown,chmod}()
  g/87,88,125,126,128,193,314,317,355: Add _require_chown/chmod
  common: hide permision warning from mkswap for exfat
  generic/554: hide permision warning on exfat
  generic/003: Amend the test for exfat

 common/rc         | 26 +++++++++++++++++++++++++-
 tests/generic/003 | 29 ++++++++++++++++++++---------
 tests/generic/087 |  1 +
 tests/generic/088 |  1 +
 tests/generic/125 |  1 +
 tests/generic/126 |  1 +
 tests/generic/128 |  1 +
 tests/generic/193 |  1 +
 tests/generic/314 |  1 +
 tests/generic/317 |  1 +
 tests/generic/355 |  1 +
 tests/generic/554 | 10 +++++++++-
 12 files changed, 63 insertions(+), 11 deletions(-)

-- 
2.30.2

