Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E15C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8DA60F9B
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhG0UK7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:10:59 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:51140 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhG0UK7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Jul 2021 16:10:59 -0400
Received: by mail-pj1-f45.google.com with SMTP id l19so1669519pjz.0;
        Tue, 27 Jul 2021 13:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cH8YESp6vV/FGgxzvuxVqtRKwWVyEJM+QYlLp40SNAQ=;
        b=Q1yKgk9R1XSIjyncuaiD/PII9d/XrY0CeqS5pB0ZC8ai74BdepIG75NNda/0BNTI5C
         LqjbT1Zs6kzCdF6DnYzkp5OsLGSAUa6fyLbh85SJkUXcMTs61B8BwfwgeILSq1tztVHN
         TrrrPSradvFUmPqYUkCaeQw64MtB/PrIh/XtbISCp2DlXrkPcCypfxi5aaIQsihhSeY0
         ptKxRNi3nVdA01qGWQ0fQ8q8lcaHyr5+OK9DatduMM7ZK1XVMfLnHXOPo1+66I/20kUJ
         Bg01MPF64a9k3VV5jkufvjzM+M4tIk6xjWy2SbhACm3w1Ah6hRl7iXBaKWo/xXa8DalA
         XPng==
X-Gm-Message-State: AOAM533Q5It6B1OQ233P74Y+kwo/lMkZRX6kFF1VLDivhYPWXBCTUmz8
        jYtTIyBmMah3EfkgXkz/TWECosge3cw=
X-Google-Smtp-Source: ABdhPJxNbBgkjCMRhfmz3kEC+j71ZYDpUZoIuhXDEXmktwWN8ywIspXtzKwDPnB32pAucKXMLmsgdQ==
X-Received: by 2002:a17:902:f68d:b029:12c:4619:c63a with SMTP id l13-20020a170902f68db029012c4619c63amr3810522plg.66.1627416656886;
        Tue, 27 Jul 2021 13:10:56 -0700 (PDT)
Received: from localhost ([191.96.121.85])
        by smtp.gmail.com with ESMTPSA id y7sm4257548pfi.204.2021.07.27.13.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:10:55 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/4] common/module: add a patient module rmmod
Date:   Tue, 27 Jul 2021 13:10:44 -0700
Message-Id: <20210727201045.2540681-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727201045.2540681-1-mcgrof@kernel.org>
References: <20210727201045.2540681-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When we call rmmod it will fail if the refcnt is greater than 0.
This is expected, however, if using test modules such as scsi_debug,
userspace tests may expect that once userspace is done issuing out
whatever it needs to that immediately after it can remove the module.

This is not true, things can linger for a while when a test driver's
reference count is greater than 0, and so userspace has to wait before
it can reliably try rmmod.

Furthermore... experience on older kernels shows it may be a while
before we can actually remove the module even *after*
/sys/module/$module/refcnt is 0. This is only currently observed
on older kernels.

Provide a check for the refcnt before we try to remove the module.
And add a grace period to allow things quiesce before we really
try removing the module so that we don't get false positives.

An example of this is when using the scsi_debug module. Using
udevadm settle does ensure the devices are properly ready to
use after modprobe, however once you start using the module,
say testing xfs with generic/108, you will see refcnt linger
between 1 and 2, and once the test completes this eventually
goes down to 0. The refcnt can be > 0 after userspace thinks
it is done with a test, and so will fail to remove it. Likewise,
on older kernels even with a refcnt of 0 the module may sometimes
fail to be removed.

Yes, the sleep 10 is rather large, however if you want to prevent
false positives it is needed. Doug's patch recent test patch [0]
helps with these older kernel kernels not having to require such
large delays, however we have no way of telling currently if such
scsi_debug quiesce patch is applied.

[0] https://lore.kernel.org/linux-scsi/20210508230745.27923-1-dgilbert@interlog.com/

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/module | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/common/module b/common/module
index 39e4e793..064bc45e 100644
--- a/common/module
+++ b/common/module
@@ -81,3 +81,51 @@ _get_fs_module_param()
 {
 	cat /sys/module/${FSTYP}/parameters/${1} 2>/dev/null
 }
+
+# checks the refcount and returns 0 if we can safely remove the module. rmmod
+# does this check for us, but we can use this to also iterate checking for this
+# refcount before we even try to remove the module. This is useful when using
+# debug test modules which take a while to quiesce.
+_patient_rmmod_check_refcnt()
+{
+	local module=$1
+	local refcnt=0
+
+	if [[ -f /sys/module/$module/refcnt ]]; then
+		refcnt=$(cat /sys/module/$module/refcnt 2>/dev/null)
+		if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
+			return 0
+		fi
+		return 1
+	fi
+	return 0
+}
+
+# patiently tries to wait to remove a module by ensuring first
+# the refcnt is 0. We wait for 10 seconds at most.
+_patient_rmmod()
+{
+	local module=$1
+	local max_tries=10
+
+	while [[ $max_tries != 0 ]]; do
+		_patient_rmmod_check_refcnt $module
+		if [[ $? -eq 0 ]]; then
+			break
+		fi
+		sleep 1
+		let max_tries=$max_tries-1
+	done
+
+	# give some grace time for when the refcnt is 0 as otherwise the
+	# removal can fail on older kernels. Refer to:
+	# https://bugzilla.kernel.org/show_bug.cgi?id=212337
+	sleep 10
+
+	if [[ -d /sys/module/$module ]]; then
+		modprobe -r $module
+		return $?
+	fi
+
+	return 0
+}
-- 
2.29.2

