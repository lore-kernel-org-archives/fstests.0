Return-Path: <SRS0=ptrv=YY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6DFCA9EC7
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Oct 2019 01:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0FD20873
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Oct 2019 01:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhBDHBYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfJaBZ7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:25:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46017 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJaBZ6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Oct 2019 21:25:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so2780963pgj.12
        for <fstests@vger.kernel.org>; Wed, 30 Oct 2019 18:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jhY9f71fHY3IYfuVf7XhLGvkarmluW3yJkIdl2AfDAM=;
        b=RhBDHBYc4AgLF8I+DAHW1cMIsfm7W92RteHo4YWdtZqD9E7ym6P2FdsywAR0o2dRF4
         KdTmwd2cUt1JNKfO/mwFzLevvhPRyEWtNY8MgUHkCWpKveBLKcONbts4SdHTCEaWnibR
         qW4p26wzpMqlOz2IWl8tu+ZB9iJVwB9MRRZZWq3MJXZJiwr7QK43uObO8NJ1rgr6EAr3
         RAHMUpWxKpr5DSKaZnN90Eq+ZLpPpqDXfuzacSzO9p13n7j2ncuCwv9dG0jdDwpR8Ulg
         A4WQZLPFgyZ0vMJZr5dP8FhvjL2QuR03jqUp+ZwmvIvV6QfdkfzfJAAP5BE981Tc6Oyf
         VsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jhY9f71fHY3IYfuVf7XhLGvkarmluW3yJkIdl2AfDAM=;
        b=GE3qXZGpAZjTp0aJ4yF9SxSmq6CWjFk6hzJFSHTO+ge+ZI1qbVCYJUEnrVNdvV0nzJ
         mUc5CIwbHQaj7xBrWFOVyc+TJgDY8s+H1Vh1s8OzlFCcSp0a7faQi2eipf1mLALw3C/7
         pSM2gXnWPUq4eehyB6WVuxQkSarq/3rjc6j/LfHCmbyUuhtqJ3zn8IP4RcKoQ3RHGgAE
         CWjJiNCOpa1mGQIRjD85o+o8sgioBgAHCalXBrr1SDFjV1yg4Gk0QV5U971WU6euvYTa
         hntrV3uvmC9Sej6JPHhFfEblL7kByzw9CkRkRZ4e60lrKkjBjDjku2jL3vMZx903+wlt
         3WyA==
X-Gm-Message-State: APjAAAVhdF3Do/IuIbB661eDK6XxVbpK1MIzK/WnyKxGrqNGLgdyaTA7
        RF1YThVgsJfC47ynatPoXkNwI+Os6Tg=
X-Google-Smtp-Source: APXvYqzPMeLSrbCP/QQK3ufe1k2jcqenNA7jDg7v4ji1+Wvyc/DlK0sOa93BjtcytNC+ESyxrzl+ng==
X-Received: by 2002:a63:934d:: with SMTP id w13mr2791683pgm.185.1572485157961;
        Wed, 30 Oct 2019 18:25:57 -0700 (PDT)
Received: from lbh-vm.xmfducmkfhgejfckffvf135llh.hx.internal.cloudapp.net ([52.175.53.118])
        by smtp.gmail.com with ESMTPSA id w189sm1196903pfw.101.2019.10.30.18.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 18:25:57 -0700 (PDT)
From:   Baihua Lu <lubaihua0331@gmail.com>
To:     fstests@vger.kernel.org
Cc:     balu@microsoft.com, Baihua Lu <lubaihua0331@gmail.com>
Subject: [PATCH] common/rc: fix _require_xfs_io_command utimes check
Date:   Thu, 31 Oct 2019 01:25:53 +0000
Message-Id: <20191031012553.72731-1-lubaihua0331@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There is an error on checking utimes command. Put quotation mark after four "0".

Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a2a28f32..657d05d3 100644
--- a/common/rc
+++ b/common/rc
@@ -2186,7 +2186,7 @@ _require_xfs_io_command()
 			_notrun "xfs_io $command support is missing"
 		;;
 	"utimes" )
-		testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
+		testio=`$XFS_IO_PROG -f -c "utimes 0 0 0 0" $testfile 2>&1`
 		;;
 	"syncfs")
 		touch $testfile
-- 
2.17.1

