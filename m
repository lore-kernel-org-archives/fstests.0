Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0619AC43217
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiBIWSw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:18:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiBIWSv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:18:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6624C03BFF4
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=d4z7KruYGznXYVz9GGxnpEiYpVxIrkvo22KUrQiAN/k=; b=pnmjkd3H5wre10SLX3z3uuksuX
        cHsXBTbD17tkW35f/LVsVt+xdiWByRFDIYOoIEMhbDiPSl9QJuJKBhhxeKHyjhva/BpB5aIARKxfL
        5SkeJsntAy4amC1pmSZ2x4qwFtkrdkms/MAlRBriEgWES3olPjM38lRuHgAh7fjVJ+OtHKMnSidQq
        P1sz2QI0DRrGkAZ67kkNYUSTAObAyICWenCYASBZ0Xna1axMeVojjmTrfP1LyX7bOiBue+1DU2EdH
        KxTUVA88a8fPKSw4KIc+/pQthUnqRlbr66dGYD04cAccryEsTKqnURdJ+6PSdyJQ8ezs3DS0N3ukv
        45BhNlTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvIa-001p4l-Ef; Wed, 09 Feb 2022 22:18:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/4] Defer reporting of execution times
Date:   Wed,  9 Feb 2022 14:18:47 -0800
Message-Id: <20220209221849.434616-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209221849.434616-1-mcgrof@kernel.org>
References: <20220209221849.434616-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

If loadfiles are completed rapidly, there is a large amount of data
sent to stddout and then recorded which generates IO in itself. This
patch buffers durations and runtimes for a time. In some cases, it'll
be buffered until the end of the benchmark.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 child.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/child.c b/child.c
index e4ae230..828295d 100644
--- a/child.c
+++ b/child.c
@@ -309,9 +309,19 @@ finished:
 	return 0;
 }
 
+void dump_samples(int id, unsigned int *duration, unsigned int *runtime, unsigned int nr_samples)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_samples; i++) {
+		printf("%4d completed in %u ms at time %u ms\n", id,
+		       duration[i], runtime[i]);
+	}
+}
 
 /* run a test that simulates an approximate netbench client load */
 #define MAX_PARM_LEN 1024
+#define MAX_SAMPLES 130672
 void child_run(struct child_struct *child0, const char *loadfile)
 {
 	int i;
@@ -326,7 +336,16 @@ void child_run(struct child_struct *child0, const char *loadfile)
 	int have_random = 0;
 	unsigned loop_count = 0;
 	z_off_t loop_start = 0;
-	struct timeval start;
+	struct timeval start, begin;
+	unsigned nr_samples = 0;
+
+	unsigned int *sample_duration = malloc(sizeof(unsigned int) * (MAX_SAMPLES + 1));
+	unsigned int *sample_runtime  = malloc(sizeof(unsigned int) * (MAX_SAMPLES + 1));
+
+	if (!sample_duration || !sample_runtime) {
+		printf("ENOMEM for samples\n");
+		exit(1);
+	}
 
 	gzf = gzopen(loadfile, "r");
 	if (gzf == NULL) {
@@ -345,6 +364,8 @@ void child_run(struct child_struct *child0, const char *loadfile)
 		memset(sparams[i], 0, MAX_PARM_LEN);
 	}
 
+	gettimeofday(&begin, NULL);
+
 again:
 	for (child=child0;child<child0+options.clients_per_process;child++) {
 		nb_time_reset(child);
@@ -534,16 +555,23 @@ loop_again:
 
 	if (options.show_execute_time) {
 		struct timeval end;
-		unsigned int duration;
+		unsigned int duration, runtime;
 
 		gettimeofday(&end, NULL);
 		duration = (end.tv_sec - start.tv_sec) * 1000 +
 			   (end.tv_usec - start.tv_usec) / 1000;
+		runtime = (end.tv_sec - begin.tv_sec) * 1000 +
+			   (end.tv_usec - begin.tv_usec) / 1000;
 		if (options.machine_readable)
 			printf("@E@%d@%u\n", child0->id, duration);
 		else {
-			printf("%4d completed in %u ms\n", child0->id,
-			       duration);
+			sample_duration[nr_samples] = duration;
+			sample_runtime[nr_samples] = runtime;
+			nr_samples++;
+			if (nr_samples == MAX_SAMPLES) {
+				dump_samples(child0->id, sample_duration, sample_runtime, nr_samples);
+				nr_samples = 0;
+			}
 		}
 	}
 
@@ -556,6 +584,8 @@ loop_again:
 
 done:
 	gzclose(gzf);
+	usleep(child0->id * 5000);
+	dump_samples(child0->id, sample_duration, sample_runtime, nr_samples);
 	for (child=child0;child<child0+options.clients_per_process;child++) {
 		child->cleanup = 1;
 		fflush(stdout);
-- 
2.34.1

