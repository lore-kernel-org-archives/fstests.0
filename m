Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5CAC432BE
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 01:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778BD61100
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 01:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhHTBEm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 21:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbhHTBEm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 21:04:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A541EC061575;
        Thu, 19 Aug 2021 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jfuZ0agw6tfaetmpJhcso9rNG1zRM1rCDVJw+2Tl6i4=; b=ID0Q3K59aHRPTVWloosA1MZgmM
        VA+ASO/+NohXPk4qTIZzEhODZtAeH32Bfn3A63seUFJ/p4+ejNN7jF7oSigHju5qyDqq6Uy5oBhmX
        bQcz3PDLJRokO3UKdiVfXXgNb+a8ar1jL/P6j/IAKib1F2pkCL4LVIfPPowCIjsn7bK0GZEz5HBJL
        q9E3xzfrqLgdGsaxaE/OjV3kFPFIyx/pdRkB9oJDo7gkorLV0nSGYYyI2rI7NY/dtoD83qdx32dLt
        LdFwfz+LN9Ohxgsj91Np+ZXE6PmwIu+zOTBbDvJ130NVjs7qRXEw+sGEii0q2mF6OeDiyBuD1BgMu
        YhPg3GzA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGsx1-009pcJ-Lb; Fri, 20 Aug 2021 01:04:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 2/2] common/scsi_debug: use the patient module remover
Date:   Thu, 19 Aug 2021 18:04:02 -0700
Message-Id: <20210820010402.2343320-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820010402.2343320-1-mcgrof@kernel.org>
References: <20210820010402.2343320-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
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

This let's us remove the cheesy try loop. We keep the
udevadm settle call as it can help salvage buggy tests
which forgot to call it.

We also special-case where MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
is set to "forever" and the initial module check finds its
in use, for that case we just try removing the module once
since fstests would not be the one leaving modues lingering
around, and waiting forever could mean you won't discover
the issue for a while.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
[1] https://lkml.kernel.org/r/20210508230745.27923-1-dgilbert@interlog.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/scsi_debug | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index e7988469..1e0ca255 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -4,11 +4,32 @@
 #
 # Functions useful for tests on unique block devices
 
+. common/module
+
 _require_scsi_debug()
 {
-	# make sure we have the module and it's not already used
+	local mod_present=0
+
+	# make sure we have the module
 	modinfo scsi_debug 2>&1 > /dev/null || _notrun "scsi_debug module not found"
-	lsmod | grep -wq scsi_debug && (rmmod scsi_debug || _notrun "scsi_debug module in use")
+
+	lsmod | grep -wq scsi_debug
+	if [[ $? -eq 0 ]]; then
+		mod_present=1
+	fi
+
+	if [[ $mod_present -eq 1 ]]; then
+		# We try to remove the module only once if MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
+		# is set to forever because fstests does not leave modules
+		# lingering around. If you do have a module lingering around
+		# and its being used, it wasn't us who started it, so you
+		# likely would not want to wait forever for it really.
+		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" == "forever" ]]; then
+			rmmod scsi_debug || _notrun "scsi_debug module in use and MODPROBE_PATIENT_RM_TIMEOUT_SECONDS set to forever, removing once failed"
+		else
+			_patient_rmmod scsi_debug || _notrun "scsi_debug module in use"
+		fi
+	fi
 	# make sure it has the features we need
 	# logical/physical sectors plus unmap support all went in together
 	modinfo scsi_debug | grep -wq sector_size || _notrun "scsi_debug too old"
@@ -44,14 +65,6 @@ _get_scsi_debug_dev()
 _put_scsi_debug_dev()
 {
 	lsmod | grep -wq scsi_debug || return
-
-	n=2
-	# use redirection not -q option of modprobe here, because -q of old
-	# modprobe is only quiet when the module is not found, not when the
-	# module is in use.
-	while [ $n -ge 0 ] && ! modprobe -nr scsi_debug >/dev/null 2>&1; do
-		$UDEV_SETTLE_PROG
-		n=$((n-1))
-	done
-	rmmod scsi_debug || _fail "Could not remove scsi_debug module"
+	$UDEV_SETTLE_PROG
+	_patient_rmmod scsi_debug || _fail "Could not remove scsi_debug module"
 }
-- 
2.30.2

