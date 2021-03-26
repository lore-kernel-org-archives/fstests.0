Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AA5C433E1
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF8B61A2D
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCZPlv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230237AbhCZPlk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Mar 2021 11:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616773300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11n3RGMjxHBqSo7kl9jXsdv4+Yf1mclEiOQFAHX4kgY=;
        b=aCujBlHXvgPL3QywdbJajzwldcFd1t52WAHPb/06cp76F+xqSZvqIk9pknT0EdT0nXDDxc
        MB0fQ0LQbCjuW4aCbkzGcF3lNq9C2bl+OPdaK/ZL/T7Y3VMgUm0W878+3+9crH1vuV3uSk
        8fEp8tqV2nZGsv6XSCslPwgCC43RmOY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-1W7na1bEPti5lrqJDPRIbg-1; Fri, 26 Mar 2021 11:41:38 -0400
X-MC-Unique: 1W7na1bEPti5lrqJDPRIbg-1
Received: by mail-ej1-f69.google.com with SMTP id e7so4251531ejx.5
        for <fstests@vger.kernel.org>; Fri, 26 Mar 2021 08:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11n3RGMjxHBqSo7kl9jXsdv4+Yf1mclEiOQFAHX4kgY=;
        b=TKYQIrYiIZrOnMcCA1n7ok6JhZRw2q0tyMj948TNRBF5hmt8Eby2rZ4IiZSCod5J/W
         xzT2/lgJp06LLoehvjqmF9zv82JW3L1X8mXKpvS9R6Qkj7h6/qqZW5A4irkrYaMjhtGO
         0urtBuVOlx/WtgtIHDZxfXmdwWTmer7CLOmK5RLU6GU+YqqDA/PPITXNO/3BTAxE7/M7
         vEcbk/zwDpocwY529xDgIa8Wig3gGrPV4Dx3hFhMKDf22ZUz4ov85Tu6xJ04vuu4k6NJ
         AKoHAmVRx0nr7BrfXl8lcSyU1lhkbR0Y/UtMzeyNSUv/2NIhBsPO75hyqMTician30HS
         gy9g==
X-Gm-Message-State: AOAM532+ABYaj5e2MQI7rb+t6uiPupvsiN270ZARR5BkLB8NmTGFLQSg
        KPpDSGbBWpbH0IEIprd3MKXn4IBhogAl6ghBwo1ngZcj+zAcn766gkjRikq9VMbqYrfSCM1SXFT
        UwOtYrEZMNvV8gToUyCKqS0+POK106D/HqAWSUuQhkimX6DdrTLVQL83Hjrk/lQ4hy2v0
X-Received: by 2002:a17:906:4e99:: with SMTP id v25mr16061898eju.532.1616773296814;
        Fri, 26 Mar 2021 08:41:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrl9FrQjepFhDFsnpprWLMbrYw4WfQJ8WjXCY/VeDLHG4qNFxmqlxDE8jNET+VF735uVlhbA==
X-Received: by 2002:a17:906:4e99:: with SMTP id v25mr16061888eju.532.1616773296671;
        Fri, 26 Mar 2021 08:41:36 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id p9sm4389791eds.66.2021.03.26.08.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:41:36 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, xzhou@redhat.com
Subject: [PATCH 1/5] common: Add _require_{chown,chmod}()
Date:   Fri, 26 Mar 2021 16:41:30 +0100
Message-Id: <20210326154134.309159-2-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326154134.309159-1-preichl@redhat.com>
References: <20210326154134.309159-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add helper function that ensures that test is only executed on file
systems that implement chown and chmod.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/common/rc b/common/rc
index 0ce3cb0d..b18d37fd 100644
--- a/common/rc
+++ b/common/rc
@@ -2129,6 +2129,24 @@ _require_user()
     [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
 }
 
+# check for a chown support
+#
+_require_chown()
+{
+	if [ "$FSTYP" = "exfat" ]; then
+		_notrun "chown is not supported on $FSTYP"
+	fi
+}
+
+# check for a chmod support
+#
+_require_chmod()
+{
+	if [ "$FSTYP" = "exfat" ]; then
+		_notrun "chmod is not supported on $FSTYP"
+	fi
+}
+
 # check for a group on the machine, fsgqa as default
 #
 _require_group()
-- 
2.30.2

