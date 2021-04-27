Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F56C433ED
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Apr 2021 08:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2797161107
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Apr 2021 08:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhD0JAS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhD0JAR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Apr 2021 05:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619513974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jvc/T9tXAhcTOQbQS1tuPXdK2O+FVxDrgIzUg2UmD0g=;
        b=FIjT4wmrEcTL2hqRkakH7BnNCJM/4t5qDgkc6oRLSyZX0/CppQd87DigbZQiZ4gRNeXih5
        hfpqsYM3UyuIVl+N8Ybx+SUrnEKuw6gF1iAqzwOhqt7BY6P//VCEQGmu5Ws987KmsjoirK
        5pDWQtHJJ01gz5dv6+0UmwpgNW7HjR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-WMYEwGV8PxaM1YyQPlnNcw-1; Tue, 27 Apr 2021 04:59:32 -0400
X-MC-Unique: WMYEwGV8PxaM1YyQPlnNcw-1
Received: by mail-wm1-f70.google.com with SMTP id y82-20020a1ce1550000b02901262158f1e9so2307288wmg.8
        for <fstests@vger.kernel.org>; Tue, 27 Apr 2021 01:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvc/T9tXAhcTOQbQS1tuPXdK2O+FVxDrgIzUg2UmD0g=;
        b=pHhYSQOj/a1PJ8lCwxUVVLXLDNEQBA48cKkuOUl0GQR1emTKrMB5YDMyq4XJidibnF
         j3PQPhK6f1jvYjI/LR2IBsXCP/QUG/FXGQoFgNOi2ob2UGekf2R/FDtp6HeSqMpxyXoC
         /XA69pPIhfyn6LuX8UeuYEtQgVpeU6R+5bpvF7MW7juX7kbWaM3cjk4GG7K5mqlIqCh6
         8KMK2PdTXC/cREH1I1tytixDvx1++6MBEyoYijvNAvb2mrFTr9jQtE9cPFR0gOKoW7aj
         M47jqPO32wfLoPoJQZIcre8ukPrAhuYbh1g5EOwC/xFwbPvCiJjA6FcoxN3nmctOkubd
         NaFA==
X-Gm-Message-State: AOAM531RuA1eIiD5fRehJOIQS+lECQJaHJgHwQqATsUWzPMawtveozuf
        k5GtkayHMXUlpb2+0HAWKpk7HEXABkuG4ng24zxL2jMOJSPGMKmWklogtlrndCF48Lrn2KCerL0
        uCUDZxlWf0UgBJ8KkDC/AVx3FD9YnvA9NF0kSv91in4pP4EOHHejCxMOoavNqLTdr+1Nn
X-Received: by 2002:a7b:c103:: with SMTP id w3mr2607493wmi.137.1619513970834;
        Tue, 27 Apr 2021 01:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw04c6dV67A9tVGqfNMlIy4LTmmdLpoLjI1jidZMNnyndrGmZmDw3H8tM4RwgExqISjJ0idyQ==
X-Received: by 2002:a7b:c103:: with SMTP id w3mr2607472wmi.137.1619513970617;
        Tue, 27 Apr 2021 01:59:30 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id m14sm18010453wmq.44.2021.04.27.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 01:59:30 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     shreeya.patel@collabora.com
Subject: [PATCH] generic/192: Fix instability on exFAT
Date:   Tue, 27 Apr 2021 10:59:29 +0200
Message-Id: <20210427085929.381183-1-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

exFAT's access time has 2s granularity and is rounded down.

This can cause problems, e.g.:

	if real access times are: time1=2 and time2=7, then 7 - 2 = 5;
	but exfat_atime(7) - exfat_atime(2) => 6 - 2 = 4 which is less
	than expected delay.

To fix this, even (delay - 1s) should be considered as a valid result
for exFAT.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/192 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/generic/192 b/tests/generic/192
index 900e2cb5..2bc8835f 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -52,8 +52,13 @@ time3=`_access_time $testfile | tee -a $seqres.full`
 delta1=`expr $time2 - $time1`
 delta2=`expr $time3 - $time1`
 
+min_tol=0
+if [ "$FSTYP" = "exfat" ]; then
+	min_tol=1
+fi
+
 # tolerate an atime up to 2s later than the ideal case
-_within_tolerance "delta1" $delta1 $delay  0 2 -v
+_within_tolerance "delta1" $delta1 $delay $min_tol 2 -v
 _within_tolerance "delta2" $delta2 $delta1 0 0 -v
 
 # success, all done
-- 
2.30.2

