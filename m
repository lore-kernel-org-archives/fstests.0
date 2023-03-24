Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29635C6FD20
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Mar 2023 20:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCXUNY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCXUNX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Mar 2023 16:13:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7BBAD39
        for <fstests@vger.kernel.org>; Fri, 24 Mar 2023 13:13:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r5so2571430qtp.4
        for <fstests@vger.kernel.org>; Fri, 24 Mar 2023 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1679688801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0t6BdfAxJFYOZ0ibuSqMV71Np9uiJrY1YLfyEZlCX5g=;
        b=jEWpRaeVlMJMKHa1thRn1an4ZPed9lIqkBqKOsOD0y9PpUTBrz9ec9/BO1aPKY3r0u
         BH8aXIJnIVw+Ud7h5AA2NETVDzd7dNyNikpiktlY8kWrmnanYvAsxBQSkOOkg3Be1cPH
         XLbSSXFpA8OdEidc8m6sWYyRleq7agjSpWpcsBt8TSsDmnMtpMwYLpKcZAQuWaXrDq0C
         F2GmQg0yD3doHb7dmvxjzjgtHsWy5UPqxlMq9x1QwkpZ0SaeZQgszra0O5iYj14SEoLY
         CdbCj2Sz/F3VqgQOoJRfRjuGovJYPm+O1skcViBGsSTQIMXyLUrf4hAZPguTgV+Btbd2
         xSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679688801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0t6BdfAxJFYOZ0ibuSqMV71Np9uiJrY1YLfyEZlCX5g=;
        b=npD/HVAdm62H+XgRciDXOQKAVm9ZvtNe1dp8D91SW9W5aGf/XPvbSA5bGF8Ccj8wrB
         P1AusX7z66KWqOzTOgOjuo+eCEseo1OoNAQKPzwovSYA1/Qkcs1+PK7K+O3ouI/gUa6l
         RsQW6JblhSNsitFJiOCwTMo1rJ35WSAiJyrkquJUSfq9/wVDZrOonyOFTTBmu24aTWV+
         XGKmVsQJ383KF3lZHqaPotE0rK7x+G1fY1Ztg3l9Ezi8H1O1n/buAuRczpQfd7oVJn/0
         XO2cFu4YDHZywME989ygeiLjyzpu/xiOW995AkMhn0HT8yNZPdwi29Itm3sU4/AuPE4j
         jXLA==
X-Gm-Message-State: AO0yUKW+xwZGVBihVwkc1g7qAmjwdJftSO6mi302rchA/JkSkYbiIJ1q
        MJZZjMf4XqOZKc+Tc3QFBfUv4A==
X-Google-Smtp-Source: AK7set/q6eJyGQm3kC7hOJAylkJ5sKkOx3l4cupabF226kLTprxGnZKTIwGz+mlHcEmb0eMwu31HDw==
X-Received: by 2002:a05:622a:342:b0:3bf:b70b:7804 with SMTP id r2-20020a05622a034200b003bfb70b7804mr7336335qtw.25.1679688801282;
        Fri, 24 Mar 2023 13:13:21 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id v127-20020a379385000000b0074230493ccfsm14527444qkd.73.2023.03.24.13.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:13:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: btrfs/012 don't follow symlinks for populating $SCRATCH_MNT
Date:   Fri, 24 Mar 2023 16:13:19 -0400
Message-Id: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

/lib/modules/$(uname -r)/ can have symlinks to the source tree where the
kernel was built from, which can have all sorts of stuff, which will
make the runtime for this test exceedingly long.  We're just trying to
copy some data into our tree to test with, we don't need the entire
devel tree of whatever we're doing, so use -P to not follow symlinks
when copying.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/012 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index d9faf81c..1b6e8a6b 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -43,7 +43,7 @@ mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
 
 _require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
 
-cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
+cp -aPR /lib/modules/`uname -r`/ $SCRATCH_MNT
 _scratch_unmount
 
 # Convert it to btrfs, mount it, verify the data
@@ -67,7 +67,7 @@ umount $SCRATCH_MNT/mnt
 
 # Now put some fresh data on the btrfs fs
 mkdir -p $SCRATCH_MNT/new 
-cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
+cp -aPR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
 
 _scratch_unmount
 
-- 
2.26.3

