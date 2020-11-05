Return-Path: <SRS0=6DS6=EL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D2BC4741F
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Nov 2020 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D6822203
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Nov 2020 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604588748;
	bh=MP6njW8ShHxE65vdMUWFoD+Fot1oyxca+fP/B662WwA=;
	h=From:To:Subject:Date:List-ID:From;
	b=hl8W4WsDfDaoWN9ORHw7IT4suFLpiLj8z44jTcrGhb/YVQ4KGo2/dczmH4sMUADgq
	 pQyBCxC6jJ6d8xMgPIPgFB/3j7qGbsOBUyJTghbxW30TmF9WvjCDgwX/g5FwL5JEjw
	 FpTVk1xs4hNeEogYKdXrONvv8ar24fvMHdzqVblY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgKEPFr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 Nov 2020 10:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730501AbgKEPFq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Nov 2020 10:05:46 -0500
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9D221D81
        for <fstests@vger.kernel.org>; Thu,  5 Nov 2020 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604588745;
        bh=MP6njW8ShHxE65vdMUWFoD+Fot1oyxca+fP/B662WwA=;
        h=From:To:Subject:Date:From;
        b=NXbrUJSkMaxE8I1bS0EJgNNyUo+5hRHcjuRIZEyKiWyp5HlrWJQJOfJDGTMXCqfHn
         VzeFi7s6iVtnLz4boDwdiR1BqTCwN1P32AHMWHIcG9SAs92akluKUZxefp0Y1fWUcM
         lOqUB3FeUVwGwcaMelEGr/pyKUqK8sQhbnZ/9+WE=
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] src/append_reader.c: print more info when it reads bad data
Date:   Thu,  5 Nov 2020 10:05:43 -0500
Message-Id: <20201105150543.403712-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When append_reader gets bad data, print the actual and expected values.
This was helpful to me when hunting a failure in generic/069 on ceph
recently.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 src/append_reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/append_reader.c b/src/append_reader.c
index 6b9e4f68e572..4660268f2f52 100644
--- a/src/append_reader.c
+++ b/src/append_reader.c
@@ -34,7 +34,7 @@ int main(int argc, char **argv)
 		}
 
 		if (d != i) {
-			fprintf(stderr, "bad data, offset = %u", i * 4);
+			fprintf(stderr, "bad data, offset = %u, got %d wanted %d\n", i * 4, d, i);
 			exit(1);
 		}
 	}
-- 
2.28.0

