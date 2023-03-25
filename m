Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19576C6FD1C
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Mar 2023 01:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCYB3E (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Mar 2023 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCYB3D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Mar 2023 21:29:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E611147
        for <fstests@vger.kernel.org>; Fri, 24 Mar 2023 18:29:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso6689442pjb.3
        for <fstests@vger.kernel.org>; Fri, 24 Mar 2023 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679707742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bee/m02cII7zXijf8QWyF/NdKpGDo4guoexebvY00Xw=;
        b=C8Q4Tdkck9gQd0BM4CXyJti7SqkCmWRXMg/tNQI4BaI4zZs4C1+eIfhrLaqpfrluQh
         7GyIx88+kJLEAm6cvi1I4OZBR+Hx0mNsP174wsRtBVBQdIfhPSFbVYZTp9gURt6BgZ/7
         E4eIhoMGi1P20S3fVOmQeXLQGx0ZEcaS7GCRywlhVWmkxAeKaA5zngHqmJQuAkwuimZO
         ltFdRyMjNtAs0kYeZaG2frw0u95xjUmBchwH8kEkSA47KwxSKdZGFzdjR0nYSSKuash7
         dy6XfausFtatBIKSyMtz4uH1+KR7K7eWzrZPfYni1eYRDYPK6FgDmiZW19Dp6kqBQbGE
         ghAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679707742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bee/m02cII7zXijf8QWyF/NdKpGDo4guoexebvY00Xw=;
        b=hq9/3utPnxxY4YudBefnwB1HEwyj09K1oit3Buq5Ff6UDeOctRmiJ/pRYbScZTmExm
         Y0B+w0m22kfrEYLPFgp5Or096aUXCWOffklD8lQd4hZ22UlZra1g8SEruG94ToU9ORdQ
         eX3pwNQKPTSbYmtx9Lj5N0DZOsiNqNi7kEtVH7kTp93cv6JXvL97CwOb819a3KRMHqdW
         z/blQQjeHZt6xF9WJrUm5t1X6hwogAZ0u6D68ChvmC8r7l+uI6X8fzPYQjC0pUyLJGmB
         QDTFacjV/+ytHMLwb6M0BkDs8dgCwdWLw1tGYq9DkWITi5+rqEtlLXTmJI8jFT6NpaNC
         3P6A==
X-Gm-Message-State: AO0yUKVp5PiOIaIX35YUCiqTKEO6z1NRlJG8m+kvfdqqs0UlKEAJ7A7w
        GV5Y94MeUy7g0VOu56ycVW+Xc1oroLwuCQ==
X-Google-Smtp-Source: AK7set8m1y4S/6/nx6sZSaFh/PsW0zLmjFh3VgCfEPvSkSXroUVPV/Md2iPzuKdzl1wwuWKqvxpQJw==
X-Received: by 2002:a05:6a20:c520:b0:d6:5fd9:6a99 with SMTP id gm32-20020a056a20c52000b000d65fd96a99mr5247482pzb.18.1679707741711;
        Fri, 24 Mar 2023 18:29:01 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:d380::bed3])
        by smtp.gmail.com with ESMTPSA id z10-20020aa791ca000000b005921c46cbadsm14771725pfa.99.2023.03.24.18.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 18:29:01 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>
Subject: [PATCH] m4: Check for FTW_ACTIONRETVAL along with nftw
Date:   Fri, 24 Mar 2023 18:28:58 -0700
Message-Id: <20230325012858.587801-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

FTW_ACTIONRETVAL is glibc specific extention which is used to implement
xfsfind but it may not be available on other C library implementations on Linux
e.g. musl. Therefore ensure that these defines are available before declaring
nftw() to be usable

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>
---
 m4/package_libcdev.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index b41c087b..7f731044 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -132,7 +132,7 @@ AC_DEFUN([AC_HAVE_NFTW],
 #include <stddef.h>
 #include <ftw.h>
     ]], [[
-         nftw("/", (int (*)(const char *, const struct stat *, int, struct FTW *))1, 0, 0);
+         nftw("/", (int (*)(const char *, const struct stat *, int, struct FTW *))1, 0, FTW_ACTIONRETVAL);
     ]])],[have_nftw=yes
        AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(have_nftw)
-- 
2.40.0

