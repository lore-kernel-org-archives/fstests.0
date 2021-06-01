Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0EAC4708F
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C91260FEB
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 07:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFAHdT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Jun 2021 03:33:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:46554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhFAHdT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Jun 2021 03:33:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622532697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7qpt9X9UcDEsL58LgXua3JC62aQHvZYwX0dDBIOezfo=;
        b=QyZbVdecByI4M0C/HsD+/yO1CliyHCdj5e3myBrDYV0/X5KA9l1Iu039TKdnppmzTKeDv/
        TsSfliLTWiEFil1gKMkC/zJ6/Dhm59UtBQ6O0JvnZiEDM3wAKo+R0fjDzPDqIqAGXi1xBH
        rkeldh1whVHHCL+pTAK62nmIPEzKeoo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50E8FAD2D
        for <fstests@vger.kernel.org>; Tue,  1 Jun 2021 07:31:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] fstests: add basic ftrace support
Date:   Tue,  1 Jun 2021 15:31:33 +0800
Message-Id: <20210601073133.194598-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Sometimes developers want trace dump for certain test cases.

Normally I just add "trace-cmd" calls in "check", but it would be much
better to let fstests to support ftrace dumping.

This patchset will add basic ftrace dumping support by:

- Clear all buffers before running each test
- Start tracing before running each test
- End tracing after test finished
- Copy the trace to "$seqres.trace" if needed
  The condition is either:
  * $KEEP_TRACE environment is set to "yes"
  * The test case failed

Currently we only support the main ftrace buffer, but all supporting
functions have support for ftrace instances, for later expansion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check         | 12 +++++++-
 common/ftrace | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 common/rc     |  1 +
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 common/ftrace

diff --git a/check b/check
index ba192042..0a09dcf9 100755
--- a/check
+++ b/check
@@ -801,7 +801,7 @@ function run_section()
 		fi
 
 		# really going to try and run this one
-		rm -f $seqres.out.bad
+		rm -f $seqres.out.bad $seqres.trace
 
 		# check if we really should run it
 		_expunge_test $seqnum
@@ -839,6 +839,10 @@ function run_section()
 		# to be reported for each test
 		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
 
+		# Clear previous trace and start new trace
+		_clear_trace_buffers
+		_start_trace
+
 		if [ "$DUMP_OUTPUT" = true ]; then
 			_run_seq 2>&1 | tee $tmp.out
 			# Because $? would get tee's return code
@@ -848,6 +852,11 @@ function run_section()
 			sts=$?
 		fi
 
+		_end_trace
+		if [ "$KEEP_TRACE" == "yes" ]; then
+			_copy_trace "$seqres.trace"
+		fi
+
 		if [ -f core ]; then
 			_dump_err_cont "[dumped core]"
 			mv core $RESULT_BASE/$seqnum.core
@@ -932,6 +941,7 @@ function run_section()
 
 	# make sure we record the status of the last test we ran.
 	if $err ; then
+		_copy_trace "$seqres.trace"
 		bad="$bad $seqnum"
 		n_bad=`expr $n_bad + 1`
 		tc_status="fail"
diff --git a/common/ftrace b/common/ftrace
new file mode 100644
index 00000000..36886484
--- /dev/null
+++ b/common/ftrace
@@ -0,0 +1,82 @@
+#
+# Common ftrace related functions
+#
+
+TRACE_DIR="/sys/kernel/debug/tracing"
+
+_clear_trace_buffers()
+{
+	if [ ! -d "${TRACE_DIR}" ]; then
+		return
+	fi
+
+	# Clear the main buffer
+	echo 0 > "${TRACE_DIR}/trace"
+
+	# Clear each instance buffer
+	for i in $(ls "${TRACE_DIR}/instances"); do
+		echo 0 > "${i}/trace"
+	done
+}
+
+_start_trace()
+{
+	instance=$1
+
+	if [ ! -d "${TRACE_DIR}" ]; then
+		return
+	fi
+
+	if [ -z "${instance}" ]; then
+		echo 1 > "${TRACE_DIR}/tracing_on"
+	else
+		mkdir -p "${TRACE_DIR}/instances/${instance}"
+		echo 1 > "${TRACE_DIR}/instances/${instance}/tracing_on"
+	fi
+}
+
+_end_trace()
+{
+	instance=$1
+
+	if [ ! -d "${TRACE_DIR}" ]; then
+		return
+	fi
+
+	if [ -z "${instance}" ]; then
+		echo 0 > "${TRACE_DIR}/tracing_on"
+	else
+		mkdir -p "${TRACE_DIR}/instances/${instance}"
+		echo 0 > "${TRACE_DIR}/instances/${instance}/tracing_on"
+	fi
+}
+
+_remove_empty_trace()
+{
+	file="$1"
+	if [ ! -f "$file" ]; then
+		return
+	fi
+
+	if [ -z "$(head -n 15 $file | sed '/^#/d')" ]; then
+		rm $file
+	fi
+}
+
+_copy_trace()
+{
+	dest="$1"
+	instance="$2"
+
+	if [ ! -d "${TRACE_DIR}" ]; then
+		return
+	fi
+
+	if [ -z "${instance}" ]; then
+		cp "${TRACE_DIR}/trace" "$dest"
+	elif [ -d "${TRACE_DIR}/instances/${instance}" ]; then
+		cp "${TRACE_DIR}/instances/${instance}/trace" "$dest"
+	fi
+
+	_remove_empty_trace "$dest"
+}
diff --git a/common/rc b/common/rc
index 919028ef..f9de1517 100644
--- a/common/rc
+++ b/common/rc
@@ -3,6 +3,7 @@
 # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
 
 . common/config
+. common/ftrace
 
 BC=$(which bc 2> /dev/null) || BC=
 
-- 
2.31.1

