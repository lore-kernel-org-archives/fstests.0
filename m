Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D327C432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B6F60F9D
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jul 2021 20:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhG0ULD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:11:03 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:39569 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhG0ULB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Jul 2021 16:11:01 -0400
Received: by mail-pl1-f177.google.com with SMTP id e5so15548963pld.6;
        Tue, 27 Jul 2021 13:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1/cftuNWA0p2OVfbGsieFA7kuPnfaxa2Mc0nXC0ogw=;
        b=RFYfg0Xb3AqlW+b55FEITH3+wBF3zMtQYcwwHdiTWr4fqpA/xlxoswnPJoixh6aglw
         6MR5DWOp2GC539wiMkTGiAPK6RknXTEQFtub9OC2weouFjT2MeqUYGxTUguKcW/D/hTE
         VohSwetyAM5iCPgokcu7+9Fm88ACEdCTpfV5kR9o6a/lVk+UyKLny2ccjjnIiwNMh3Dx
         ypv93TiSabxIWUAmyC+fViOmp/0kn4PMxcwmOahR0QEh2iYeBlIB9TV7zd+4hfRb9uo3
         N7K5LJBI4EhdQ06zklcprOGHKNUw4wThZLBrerGoRcFwrtpQzrmsiseRDr7pU1RsyC56
         HALA==
X-Gm-Message-State: AOAM531Ur/Elo/tKVjJiL/2N2eEaNEDsZ0DClypBDGuKenEM2iNhJKrK
        gy2z1SxC95FoTsl6JU2QivSxWoc8wAo=
X-Google-Smtp-Source: ABdhPJyLRnJk03C0VRwp6A9qgLwQ0loJxVKLSyBCZWHEgR/s7uQkNQ/NC5f+bq1PhP1MgHIr5CPYUQ==
X-Received: by 2002:a63:3d0e:: with SMTP id k14mr25256222pga.351.1627416659219;
        Tue, 27 Jul 2021 13:10:59 -0700 (PDT)
Received: from localhost ([191.96.121.85])
        by smtp.gmail.com with ESMTPSA id c11sm5077097pfp.0.2021.07.27.13.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:10:58 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/4] common/scsi_debug: use the patient module remover
Date:   Tue, 27 Jul 2021 13:10:45 -0700
Message-Id: <20210727201045.2540681-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727201045.2540681-1-mcgrof@kernel.org>
References: <20210727201045.2540681-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If you try to run tests such as generic/108 in a loop
you'll eventually see a failure, but the failure can
be a false positive and the test was just unable to remove
the scsi_debug module.

We need to give some time for the refcnt to become 0. For
instance for the test generic/108 the refcnt lingers between
2 and 1. It should be 0 when we're done but a bit of time
seems to be required. The chance of us trying to run rmmod
when the refcnt is 2 or 1 is low, about 1/30 times if you
run the test in a loop on linux-next today.

Likewise, even when its 0 we just need a tiny breather before
we can remove the module (sleep 10 suffices) but this is
only required on older kernels. Otherwise removing the module
will just fail.

Some of these races are documented on the korg#212337, and
Doug Gilbert has posted at least one patch attempt to try
to help with this [1]. The patch does not resolve all the
issues though, it helps though.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
[1] https://lkml.kernel.org/r/20210508230745.27923-1-dgilbert@interlog.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/scsi_debug | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index e7988469..3c9cd820 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -4,11 +4,13 @@
 #
 # Functions useful for tests on unique block devices
 
+. common/module
+
 _require_scsi_debug()
 {
 	# make sure we have the module and it's not already used
 	modinfo scsi_debug 2>&1 > /dev/null || _notrun "scsi_debug module not found"
-	lsmod | grep -wq scsi_debug && (rmmod scsi_debug || _notrun "scsi_debug module in use")
+	lsmod | grep -wq scsi_debug && (_patient_rmmod scsi_debug || _notrun "scsi_debug module in use")
 	# make sure it has the features we need
 	# logical/physical sectors plus unmap support all went in together
 	modinfo scsi_debug | grep -wq sector_size || _notrun "scsi_debug too old"
@@ -53,5 +55,5 @@ _put_scsi_debug_dev()
 		$UDEV_SETTLE_PROG
 		n=$((n-1))
 	done
-	rmmod scsi_debug || _fail "Could not remove scsi_debug module"
+	_patient_rmmod scsi_debug || _fail "Could not remove scsi_debug module"
 }
-- 
2.29.2

