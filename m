Return-Path: <SRS0=NoLx=A4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95CFC433EC
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 04:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B773A20737
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 04:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMUFno+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgGQEks (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgGQEkp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jul 2020 00:40:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190FCC061755
        for <fstests@vger.kernel.org>; Thu, 16 Jul 2020 21:40:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w17so4909353ply.11
        for <fstests@vger.kernel.org>; Thu, 16 Jul 2020 21:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bh0VBvnfrCADCnqnt/VYbiuj15RuKAzy0nwBH+VWdFQ=;
        b=oMUFno+JCOFyJW0IF53wIcuO+pCyjdKQGT+GSKUpUwHTOeU5uggbsgb35qPomWdQ3N
         NUPx4FG7yL3wsbgJkbprXdkuv++Y+CJF+ArV/V6gzprSUvSAr3ozoTvvLBUr2CLPxGiv
         +G/lS7J1jEN8BdbwChEispsLhZL8Pogsnz7cOz/PX7GwqWBrVEBx94ikVvF1EQb+xVG9
         vVB3RjZnU4cnwpIxzEv81pRNuL2uTo+aq/Guj8w6RIncvopjsubVj9cn9mEFrGtRP39S
         G9w/W0jxbK7X9P7WeHkphh3SSxQMGTpqf77hectQvJ0zuzguEYixJjY6cLqc2py/WRPy
         q+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bh0VBvnfrCADCnqnt/VYbiuj15RuKAzy0nwBH+VWdFQ=;
        b=q4etTh1n/Z1r+IQ7t5Byxg40kw87HAFFuUVDsWH+bDNwPEmAKJHptxBIB/YZt7SPT2
         b3ZZYuHS0DqCLH/+fY0ddtQp2NvDd9SvR4nCzYKNMnjllIP1NmGfFoVOTCA7jAUAbmne
         KlYMEyYmW3bdDUTfwesD4WWdKn+DGKqE+ii8wjOzBlYowhjqJKdAt51x2O/MiGuCHpSb
         RNT+TaaFXv8HmF9icj6t5OUOZQ68qLpNn5zD+nkyDPMg4b/bEw0WZ94RrP5Y3+F/9zAe
         CVMGFdWLjfv8vUALvefq0zeMyK+S12O3e82vaqU33eOWjcDJ+sbIvGLe2e2NTn0K01wl
         njIA==
X-Gm-Message-State: AOAM531lcWFN15hVD3+eGINCXoABPfw1AzZbOSJWMMr0OhRAytYRMlWY
        KZF2ykwVOfgRCaarN9xbWyD5sR7G
X-Google-Smtp-Source: ABdhPJwhMqrdza67FKSky9sDbaUJ1l+IRRnwslHoUtqM83tm5/fj0rr/NIC55XhUhNaPixTlHAzZAw==
X-Received: by 2002:a17:90b:4910:: with SMTP id kr16mr8076324pjb.126.1594960843563;
        Thu, 16 Jul 2020 21:40:43 -0700 (PDT)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 190sm6134788pfz.41.2020.07.16.21.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 21:40:43 -0700 (PDT)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic/175, generic/176: cleanup testdir before exit
Date:   Fri, 17 Jul 2020 12:40:17 +0800
Message-Id: <20200717044017.1598-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Usually the _mkfs helper will cleanup these directories at the
beginning of testcase. However, when testing on NFS, the cleanup
could be very slow and it is confusing that: We have already
started to run generic/176 but we get stuck in _mkfs, cleaning
up files left by the previous testcase generic/175.

To be clear, cleanup testdir before exit. Also, deleting files
should be part of the stress test.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 tests/generic/175 | 1 +
 tests/generic/176 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/generic/175 b/tests/generic/175
index 79e5b3d6..bd966a28 100755
--- a/tests/generic/175
+++ b/tests/generic/175
@@ -61,6 +61,7 @@ bytes=$((blks * blksz))
 echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
 _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
 
+rm -rf $testdir
 # success, all done
 status=0
 exit
diff --git a/tests/generic/176 b/tests/generic/176
index a084578a..bc83762e 100755
--- a/tests/generic/176
+++ b/tests/generic/176
@@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
 echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
 _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
 
+rm -rf $testdir
 # success, all done
 status=0
 exit
-- 
2.20.1

