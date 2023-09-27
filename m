Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8429E7F14F
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Sep 2023 13:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjI0NRE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Sep 2023 09:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjI0NRD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Sep 2023 09:17:03 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F723126
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2023 06:17:02 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fbbb2bed0so184029739f.1
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2023 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695820621; x=1696425421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTa9MnGK+3n5fqUH7OqJiQwKFw3j5esYfuDNozy5ZH0=;
        b=JbCQBbkxgqHPBhC3iK3f419+IpemoC3Be8xyEoTwh2Z2ZIiNcTJZKg++XPObHADWZz
         k+2TDAnUXcRHQflggbjtvHa4ErTPfti8Bv2mN0icogzbXhkXBL2FFA7bHO9WCkkjaW9D
         QiRlNGRK441DhkSOQbg5mIEVkH+5Y8xvj8sVVDQM2nfoHdAn9AhgKqE2p1tcRlq0eVfS
         zPszuf0QTsnfMHdsSmqcgq73ofoLS30FpzlAS57oNUmTLvZUOGFGk8kE2IuF2EQwlRY1
         lW0wrFolwWMaHA6x8xcmn6ZwxvFzSTha5Zqd46bqQtVGpaY/4FdBHsMHYyvjnKbkNMKl
         eH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820621; x=1696425421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTa9MnGK+3n5fqUH7OqJiQwKFw3j5esYfuDNozy5ZH0=;
        b=EMLdvZGl2iUyNI/f1d9/9sFQO7g7o0gT4w9/RNkdWjbdOLJzK0MP7lhQi6nm8KNMrz
         bXRoxJFoRL4+VAZGcvKRoUjdom9MXTjhxX+ciRiOOCbesxBSIybwuBIWLQsGgHuaTPpD
         80bJalUMUSJmyaQC2CcyedlXXTya8yWEDGOsHaAqGSz+iUgb0xBn0idyU1B47/F+9hYv
         226WEL7P8UKT8YqLYEF1/nM6c3yaJAlwF+neZ/ehbG7kTTkBUc/b3JnLM5rtG/axa4I6
         IY0pE7eW9+a56yre8UMOG9PkG2v2YxtsA8Coi77KMWv0hARJuM3BPBrqlBESv+eP5AaN
         FBUA==
X-Gm-Message-State: AOJu0YxylrYKIfihDcHAssaV77y3exmLGcIwQCnclQYucCk9TEyWBMpF
        zFVvewrHBxiSglTTUnJtqjLAYU5+QQQko3HKn+o=
X-Google-Smtp-Source: AGHT+IHMssRobxSgwNb1V+4E2NyQsx8qQBLCXDZM4wAyZok7UwvjGBEaibjqHn+T1bKcz7VLVGDenw==
X-Received: by 2002:a05:6e02:170d:b0:34c:b4b5:765 with SMTP id u13-20020a056e02170d00b0034cb4b50765mr6563027ill.5.1695820621172;
        Wed, 27 Sep 2023 06:17:01 -0700 (PDT)
Received: from slackware.home ([209.206.91.222])
        by smtp.gmail.com with ESMTPSA id c6-20020a02a406000000b00430091fd494sm3787986jal.34.2023.09.27.06.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:17:00 -0700 (PDT)
From:   Vyacheslav Yurkov <uvv.mail@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>,
        Vyacheslav Yurkov <uvv.mail@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>
Subject: [PATCH] fsx: Add a return type to aio_rw
Date:   Wed, 27 Sep 2023 15:16:17 +0200
Message-Id: <20230927131617.100908-1-uvv.mail@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Khem Raj <raj.khem@gmail.com>

Compilers complain about the function prototype otherwise

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Vyacheslav Yurkov <uvv.mail@gmail.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>
---
 ltp/fsx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index ccb382e7..a30e2a8d 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2592,6 +2592,7 @@ out_error:
 	return -1;
 }
 #else
+int
 aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 {
 	fprintf(stderr, "io_rw: need AIO support!\n");
-- 
2.35.1

