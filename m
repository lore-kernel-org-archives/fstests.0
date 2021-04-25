Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96ADC433ED
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 09:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD10A61350
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 09:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhDYJDh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Apr 2021 05:03:37 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:53778 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhDYJDg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Apr 2021 05:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1619341376; i=@fujitsu.com;
        bh=BUdGkV896coJdUn8UydYAP6ZNDFildR1OV1GC1cTM+g=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=eBjf3S8yaisn1A/NULJZJGTAIRfDTDdqhObkmJMjCPp/nXBy6xdUc7y3iPZ3Uqr6s
         3cWoR5sTu0c4xcDEUQsndl09ccjQFzaCiz29ymEhqy2dKOcp6n0qIg+nf2LhM4H0u6
         eiFefJfhppr3CB79bUWnGFYnfao/FNB8U9X7d0WVZqjXn5aWtqkS+CfoDRPanK1KWY
         Dnc5xvN2o2+T0DVX8x8iGBJC8u19HW7h5x+qf4JK+kfvQXpY2zeCRNdYslsrH4oRgQ
         MIysQ4kHDLmHtA6Xc3FWklaLaJXM+C7OUgGQ7CAvNH+s8J301/8yjEqPhH91HZqWvQ
         T/59QOO85vu7g==
Received: from [100.112.192.143] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 43/7D-24644-04035806; Sun, 25 Apr 2021 09:02:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRWlGSWpSXmKPExsViZ8MxRdfeoDX
  B4OxsQ4vTLXvZHRg9Pm+SC2CMYs3MS8qvSGDNaDqmVPBcuOJmZydzA+NCgS5GLg4hgU4miePn
  JrFDOLsZJXZOfw3kcHKwCWhKPOtcwAxiiwjISvyfsZoJxGYWUJdYPukXmC0sECBx8t0TRhCbR
  UBVomPjBKBeDg5eAQ+JHbvCQcISAgoSUx6+BxvDKyAocXLmExaIMRISB1+8YIaoUZS41PGNEc
  KulOhcv4BxAiPvLCQts5C0LGBkWsVokVSUmZ5RkpuYmaNraGCga2hopGtoaaprZGiql1ilm6i
  XWqpbnlpcomuol1herFdcmZuck6KXl1qyiREYWikFh6/vYLz1+oPeIUZJDiYlUd4GxtYEIb6k
  /JTKjMTijPii0pzU4kOMMhwcShK8NvpAOcGi1PTUirTMHGCYw6QlOHiURHjf6QGleYsLEnOLM
  9MhUqcYdTl2Hp23iFmIJS8/L1VKnPc6SJEASFFGaR7cCFjMXWKUlRLmZWRgYBDiKUgtys0sQZ
  V/xSjOwagkzGsJcglPZl4J3KZXQEcwAR2xu7MR5IiSRISUVAOTwv1/863rzE4v1X292E7yyv3
  1NovUT0z9Npf1/3Sd3S2auYfSXH44neBp/Xq3UX/WUVf3jsW9gj/qzHKuCa7y17CdNJ9X4ryx
  4r+b676IqL+3eH539eSdbi/ienr7L/24z/yRfZZyyEvx6gO8Pft9nd9vcGJpFm78JG7bof1gl
  9knPzcOMfXKnbKSX+zPfNrZ18exMNFthX2ozvG9grEXjNpzbywwbs6LivJ5qhi97BSr0fS8S+
  987b2zHqyIlb+/7wTvi203uE7s85lwrd7K7sv8Z2+in1UJzsjm3LppFpuoK98J8WyGbZZ9quw
  eU7YkNL08Gu2+cMYhP+vv5i5Lz05fzp7L3GDccmJpkXaYEktxRqKhFnNRcSIAqh9pwDQDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-271.messagelabs.com!1619341375!1582999!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18913 invoked from network); 25 Apr 2021 09:02:55 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-22.tower-271.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2021 09:02:55 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13P92l8I019512
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Sun, 25 Apr 2021 10:02:55 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sun, 25 Apr 2021 10:02:46 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 1/2] src/*: Fix an error for the loop initialization declaration
Date:   Sun, 25 Apr 2021 18:02:38 +0800
Message-ID: <1619344959-3672-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When compile them old gcc, get the following error
mount-idmapped.c: In function 'parse_map':
mount-idmapped.c:154:2: error: 'for' loop initial declarations are only allowed in C99 mode
  for (int i = 0; i < 2; i++) {

Fix them by declaring them at the beggining instead of in loop.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
Can we add travis-ci(like ltp, include some linux distributions) or other test tool, so we can check xfstests whether have compile error beforce
weekly announce?
 src/detached_mounts_propagation.c    | 4 ++--
 src/idmapped-mounts/mount-idmapped.c | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
index 99b66308..d4bc87f9 100644
--- a/src/detached_mounts_propagation.c
+++ b/src/detached_mounts_propagation.c
@@ -96,7 +96,7 @@ static const struct option longopts[] = {
 int main(int argc, char *argv[])
 {
 	int exit_code = EXIT_SUCCESS, index = 0;
-	int dfd, fd_tree, new_argc, ret;
+	int dfd, fd_tree, new_argc, ret, i;
 	char *base_dir;
 	char *const *new_argv;
 	char target[PATH_MAX];
@@ -147,7 +147,7 @@ int main(int argc, char *argv[])
 	 * Having a mount table with 10000 mounts is already quite excessive
 	 * and shoult account even for weird test systems.
 	 */
-	for (size_t i = 0; i < 10000; i++) {
+	for (i = 0; i < 10000; i++) {
 		fd_tree = sys_open_tree(dfd, "detached-move-mount",
 					OPEN_TREE_CLONE |
 					OPEN_TREE_CLOEXEC |
diff --git a/src/idmapped-mounts/mount-idmapped.c b/src/idmapped-mounts/mount-idmapped.c
index 5f5ba5d2..b3e9e27b 100644
--- a/src/idmapped-mounts/mount-idmapped.c
+++ b/src/idmapped-mounts/mount-idmapped.c
@@ -137,7 +137,7 @@ static int add_map_entry(__u32 id_host,
 static int parse_map(char *map)
 {
 	char types[2] = {'u', 'g'};
-	int ret;
+	int ret, i;
 	__u32 id_host, id_ns, range;
 	char which;
 
@@ -151,7 +151,7 @@ static int parse_map(char *map)
 	if (which != 'b' && which != 'u' && which != 'g')
 		return -1;
 
-	for (int i = 0; i < 2; i++) {
+	for (i = 0; i < 2; i++) {
 		idmap_type_t map_type;
 
 		if (which != types[i] && which != 'b')
@@ -230,8 +230,9 @@ static int map_ids_from_idmap(struct list *idmap, pid_t pid)
 	int fill, left;
 	char mapbuf[4096] = {};
 	bool had_entry = false;
+	idmap_type_t map_type, u_or_g;
 
-	for (idmap_type_t map_type = ID_TYPE_UID, u_or_g = 'u';
+	for (map_type = ID_TYPE_UID, u_or_g = 'u';
 	     map_type <= ID_TYPE_GID; map_type++, u_or_g = 'g') {
 		char *pos = mapbuf;
 		int ret;
-- 
2.23.0

