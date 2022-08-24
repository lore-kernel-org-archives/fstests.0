Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C327BC00140
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Aug 2022 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiHXTcO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Aug 2022 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiHXTcN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Aug 2022 15:32:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F02C70E69
        for <fstests@vger.kernel.org>; Wed, 24 Aug 2022 12:32:13 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u6so9075486qvp.5
        for <fstests@vger.kernel.org>; Wed, 24 Aug 2022 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=8KPESFWU5UIn8wId02P5On0WlsbHa3z2dVUFPCoebWQ=;
        b=jAfGaOMRelepkAyLur+R1KtR0asI2NysU2p6uKzuMA6bhNa4FYVvXR0gKzFJ1Gorxd
         vniMUtf46YAb1J63MFhEy6HMR7Jh59p68qV6sdX/UFGHRU9iccAzg164VfyuufQ0LXig
         LXx1UFpIuyB45GqHtncX8rQCSkyKiSZEnCO+KnSBH1r/dZF0qYv6q9slE0IZUPlYCa7g
         RjwHH5FxmRNU9Ojk0aiAxXQUrNPLnPU1ry0rYqHRqK+bWeJTOcJSVWLMeOXTVni7eJvh
         XicB768+J8gREak9EdsY1cDmYw2W90d949gI7XU8qlvDDFOODNwF7V47SynGYNMiZoIf
         fxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=8KPESFWU5UIn8wId02P5On0WlsbHa3z2dVUFPCoebWQ=;
        b=YIfQpS4IF/5FkIZql4osxnY25283r11h7KjUJRfwRS+Krxv0ymp2u3dUrHNG4wMWUk
         QStMNY1sVIeM4YGTibR7ShEtOJhyWh5UV7yGLN20YCYPZcsxB+rhGLdGl2XvSiT5Z7N+
         VV3gBf7mwWoNIqR6/yC7ah5xh+0jiAD7JU11G1vLq54v1xJ+ux0sRB+fwwKzOQ3FSd68
         QVQFUfDMnhwm/CM6QXtMffFvl7Pm5cM45bvvhYmi0o4pVO5w/qtlGhkK2OO+P++C0up2
         RZNswJB1oXo82Dc12Mhtq942ntOaZ6RjHK0mrXi8dlQU8ZQQlzU2bEiv/NpznZLhxHcz
         Ua9w==
X-Gm-Message-State: ACgBeo1c+rFy/3RTJ3oH2JEUW/wUiFf49La+v7rzz9X68bofMS8dL/od
        kEWzUG0c2VWCeilwbUT/7RsVJSa/Lm0djg==
X-Google-Smtp-Source: AA6agR7lk/Mz07J9qvXY4hRvMsIr/TeJFx83p11qbWK79PvSlGItE8J6BTtnZuBb6ipHVOBEAoxbdA==
X-Received: by 2002:a0c:b298:0:b0:473:8d6a:df00 with SMTP id r24-20020a0cb298000000b004738d6adf00mr648761qve.71.1661369531965;
        Wed, 24 Aug 2022 12:32:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006bb9125363fsm16367930qki.121.2022.08.24.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 12:32:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: get section config after RUN_SECTION checks
Date:   Wed, 24 Aug 2022 15:32:10 -0400
Message-Id: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

While trying to do

./check -s <some section>

I was failing because I had a section defined higher than <some section>
that had TEST_DEV=/some/nonexistent/device, since I was using the other
section to test an experimental drive.  This appears to be because we
run through all of the sections, and when getting the section config we
check to see if it's valid, and in this case the section wasn't valid.

The section I was actually trying to use was valid however.  Fix check
to see if the section we're trying to run is in our list of sections to
run first, and then if it is get the config at that point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 0b2f10ed..ad0ab3cf 100755
--- a/check
+++ b/check
@@ -678,7 +678,6 @@ function run_section()
 
 	OLD_FSTYP=$FSTYP
 	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
-	get_next_config $section
 
 	# Do we need to run only some sections ?
 	if [ ! -z "$RUN_SECTION" ]; then
@@ -708,6 +707,8 @@ function run_section()
 		fi
 	fi
 
+	get_next_config $section
+
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
 		echo "failed to create results directory $RESULT_BASE"
-- 
2.26.3

