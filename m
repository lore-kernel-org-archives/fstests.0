Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FB7C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiBIWSv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:18:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiBIWSv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:18:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7006C1DC5D1
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=exJ/KGoqZkK8mhMXqxR7kAJ/ddgoBl0DHSmx/sevlYg=; b=Xe06hZP4GFMBK+IJRgXnjJHJil
        CUvmtytR+5igahuJRtf+2BK37z7+M9On5oVtgAjOlp7cpRyLDH0D6r+9Xzk3nCWyQz20HmoiZINmP
        4/JYCbQX0CX4+804AbcXOEMz3Z7V0itePuZGuOMor0LRj0c+JZj0K7Br40SgKpla8pHdY9KXfpRFy
        E+M2aks5KPjKjSz1q1F44UGbFnxRYmlkONfn2XZ9zuOCR05sUepj9GeKteXvc7KgXWjZt/AYlxhKZ
        4k6wA9boqhmYhAmfuL3KLQsmbE456OMLw9TcstBmc9/r9IdHa0PpfZ7p64OBZp6aaAOFMwjLWx5Cw
        hePLQihQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvIY-001p4h-Mh; Wed, 09 Feb 2022 22:18:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/4] Allow reporting of workload execution times
Date:   Wed,  9 Feb 2022 14:18:46 -0800
Message-Id: <20220209221849.434616-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209221849.434616-1-mcgrof@kernel.org>
References: <20220209221849.434616-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Jan Kara <jack@suse.cz>

Add option --show-execution-time which reports time it took to each
client to execute the given workload. This allows for better statistics
to be done with dbench results.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 child.c  | 18 ++++++++++++++++++
 dbench.c |  3 +++
 dbench.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/child.c b/child.c
index aea8106..e4ae230 100644
--- a/child.c
+++ b/child.c
@@ -326,6 +326,7 @@ void child_run(struct child_struct *child0, const char *loadfile)
 	int have_random = 0;
 	unsigned loop_count = 0;
 	z_off_t loop_start = 0;
+	struct timeval start;
 
 	gzf = gzopen(loadfile, "r");
 	if (gzf == NULL) {
@@ -349,6 +350,8 @@ again:
 		nb_time_reset(child);
 	}
 
+	gettimeofday(&start, NULL);
+
 	while (gzgets(gzf, line, sizeof(line)-1)) {
 		unsigned repeat_count = 1;
 
@@ -529,6 +532,21 @@ loop_again:
 		}
 	}
 
+	if (options.show_execute_time) {
+		struct timeval end;
+		unsigned int duration;
+
+		gettimeofday(&end, NULL);
+		duration = (end.tv_sec - start.tv_sec) * 1000 +
+			   (end.tv_usec - start.tv_usec) / 1000;
+		if (options.machine_readable)
+			printf("@E@%d@%u\n", child0->id, duration);
+		else {
+			printf("%4d completed in %u ms\n", child0->id,
+			       duration);
+		}
+	}
+
 	if (options.run_once) {
 		goto done;
 	}
diff --git a/dbench.c b/dbench.c
index 1369a38..178a175 100644
--- a/dbench.c
+++ b/dbench.c
@@ -50,6 +50,7 @@ struct options options = {
 	.trunc_io            = 0,
 	.iscsi_initiatorname = "iqn.2011-09.org.samba.dbench:client",
 	.machine_readable    = 0,
+	.show_execute_time   = 0,
 };
 
 static struct timeval tv_start;
@@ -433,6 +434,8 @@ static void process_opts(int argc, const char **argv)
 		  "How many seconds of warmup to run", NULL },
 		{ "machine-readable", 0, POPT_ARG_NONE, &options.machine_readable, 0,
 		  "Print data in more machine-readable friendly format", NULL},
+		{ "show-execute-time", 0, POPT_ARG_NONE, &options.show_execute_time, 0,
+		  "Print time to execute passed workload", NULL},
 #ifdef HAVE_LIBSMBCLIENT
 		{ "smb-share",  0, POPT_ARG_STRING, &options.smb_share, 0, 
 		  "//SERVER/SHARE to use", NULL },
diff --git a/dbench.h b/dbench.h
index 14a5a70..465cf3b 100644
--- a/dbench.h
+++ b/dbench.h
@@ -159,6 +159,7 @@ struct options {
 	const char *iscsi_device;
 	const char *iscsi_initiatorname;
 	int machine_readable;
+	int show_execute_time;
 	const char *smb_share;
 	const char *smb_user;
 };
-- 
2.34.1

