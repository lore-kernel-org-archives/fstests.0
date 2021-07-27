Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B51C432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6305560F93
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhG0UK5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:10:57 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:42968 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhG0UK4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Jul 2021 16:10:56 -0400
Received: by mail-pj1-f41.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso856092pjo.1;
        Tue, 27 Jul 2021 13:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Glu03wx1EO+cRL+474sUvuGcwz/C/1OdSRJGdquxArU=;
        b=DfY9o1dbKJe7ZcE4nnMeU9nkIxC/EdzhWFRs6rOZbZ713qQuFwctJr+O7IPWNqN3Vp
         dvlX2ixAYHfC2xgYRN+/YMmLmUQbQwCFrlavDeQWw+0i87cUUOm0il6xoRJpJZ452Aiu
         hwFPjh7/kw4M7tlIRirgiGEAHyRReGHxRU6XhtDicF7xzS/YOo7UG6a7eVgOItMgOG9G
         F+5Pow8a59QVCvXqk1vD5S9ZXp8O0FKe/wjHsBXxNR7UnkEHuOmfUNlHAamsNazJOXXu
         KsxbYb9zmxyUMrLY12fMZMDruFXvyAXpVHgpL9l51pXmRSyOqLurkApaFdJxFns2ZU3J
         aM5g==
X-Gm-Message-State: AOAM5313HENKHhErFuDlPhioFloC83hGiZ10F0XoavDDyCmZViRpmHpa
        xVm2iev101agBwYkIsF+J6LB2XAY5yw=
X-Google-Smtp-Source: ABdhPJwHAwoc/tK2eDf9255hc8caNkNYgNs84Y0UZ+fINypfg8g46KSUM7llgRPnE2Qm6Fbj91gihQ==
X-Received: by 2002:a05:6a00:b46:b029:334:54db:af17 with SMTP id p6-20020a056a000b46b029033454dbaf17mr24790725pfo.26.1627416654449;
        Tue, 27 Jul 2021 13:10:54 -0700 (PDT)
Received: from localhost ([191.96.121.85])
        by smtp.gmail.com with ESMTPSA id l9sm3622698pjq.40.2021.07.27.13.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:10:52 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/4] common/scsi_debug: use udevadm settle instead of sleeping
Date:   Tue, 27 Jul 2021 13:10:43 -0700
Message-Id: <20210727201045.2540681-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727201045.2540681-1-mcgrof@kernel.org>
References: <20210727201045.2540681-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The variable UDEV_SETTLE_PROG is already defined and used for
lvm to either use `udevadm settle` in case it is available, and
if not, use 'sleep 1' otherwise (ancient distros or CONFIG_NET
is missing).

Use it on scsi_debug to replace the sleep calls sprinkled in
place after module removal. The correct thing to do is to
just use udevadm settle when available, and only fall back to
calling sleep when udevadm is not available or CONFIG_NET
is disabled.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/scsi_debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index d9aa0bd2..e7988469 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -36,7 +36,7 @@ _get_scsi_debug_dev()
 	echo "scsi_debug options $opts" >> $seqres.full
 	modprobe scsi_debug $opts
 	[ $? -eq 0 ] || _fail "scsi_debug modprobe failed"
-	sleep 1
+	$UDEV_SETTLE_PROG
 	device=`grep -wl scsi_debug /sys/block/sd*/device/model | awk -F / '{print $4}'`
 	echo "/dev/$device"
 }
@@ -50,7 +50,7 @@ _put_scsi_debug_dev()
 	# modprobe is only quiet when the module is not found, not when the
 	# module is in use.
 	while [ $n -ge 0 ] && ! modprobe -nr scsi_debug >/dev/null 2>&1; do
-		sleep 1
+		$UDEV_SETTLE_PROG
 		n=$((n-1))
 	done
 	rmmod scsi_debug || _fail "Could not remove scsi_debug module"
-- 
2.29.2

