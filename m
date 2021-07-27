Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50445C432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DCC60F9B
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhG0UKx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:10:53 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:34406 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhG0UKw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Jul 2021 16:10:52 -0400
Received: by mail-pl1-f175.google.com with SMTP id d1so10244944pll.1;
        Tue, 27 Jul 2021 13:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0wE//9HEqgwixzn3DN6w89is3z00f/t9Uc1uapEcFM=;
        b=DDghwk55mmd8mk+ce75D55/9nDA/U8F3AhBHDhVbBZDkLTl4N0l8VoAzNfsBLkdyR3
         amFuFA9YC/vUIXG25x6CxzgvPXFacHsseCekBVLwQ7H3iQgy5EkN3ouPipFUxvRlkX3n
         CdNW+1dZzuQR7EzI4ib/i7jWnW5a0q1ts8a0hlfUdN6l5HbjRV4TC7UFJfU7BhYKWjdg
         /0+bpvUrmqxThNI8ebBMNWHfhTjcAgnXUUGFDGxEaQ8d4PdVySymak1Jl1AcD+I7bK+z
         XJAiefTEK2piDMrsYHr5aobmenj4ojtfNcp0W9A1ixj3b7Mn1CO931zMm4SQxBc8wbdj
         JBDA==
X-Gm-Message-State: AOAM530j4Y/ZTDmDkHQnr57K924vXJWv6ZKODYJgijWan6HRMYUiiVbk
        EOS1xIvERHnwMuXvjE2wejybooojti0=
X-Google-Smtp-Source: ABdhPJwtH/th0vT1ycklEZcYiTe97opY4s3/d0QLljvKYDRB//7itYCusI6O5h+4brJekhccvDJdug==
X-Received: by 2002:a17:90a:bd18:: with SMTP id y24mr5955132pjr.83.1627416650857;
        Tue, 27 Jul 2021 13:10:50 -0700 (PDT)
Received: from localhost ([191.96.121.85])
        by smtp.gmail.com with ESMTPSA id y4sm3752116pjg.9.2021.07.27.13.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:10:49 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/4] common/config: disable udevadm settle if CONFIG_NET is disabled
Date:   Tue, 27 Jul 2021 13:10:42 -0700
Message-Id: <20210727201045.2540681-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727201045.2540681-1-mcgrof@kernel.org>
References: <20210727201045.2540681-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If CONFIG_NET is disabled kobject_uevent_net_broadcast() will be a no-op
and so no uevent are sent and so 'udevadm settle' won't really do
anything for you.

We check for /proc/net to see if CONFIG_NET was enabled.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/config | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index adc16b59..005fd50a 100644
--- a/common/config
+++ b/common/config
@@ -240,7 +240,14 @@ else
 	UDEV_SETTLE_PROG="$UDEV_SETTLE_PROG settle"
 fi
 # neither command is available, use sleep 1
-if [ "$UDEV_SETTLE_PROG" == "" ]; then
+#
+# Udev events are sent via netlink to userspace through
+# kobject_uevent_net_broadcast(), and udev in userspace is in charge of
+# handling the events. The command `udevadm settle` just checks if
+# /run/udev/queue is 0, however, a kernel without CONFIG_NET will have
+# kobject_uevent_net_broadcast() be a no-op, and so /run/udev/queue may not
+# exist or always be 0. We check for /proc/net to see CONFIG_NET was enabled.
+if [[ "$UDEV_SETTLE_PROG" == "" || ! -d /proc/net ]]; then
 	UDEV_SETTLE_PROG="sleep 1"
 fi
 export UDEV_SETTLE_PROG
-- 
2.29.2

