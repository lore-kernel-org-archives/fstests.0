Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE861C433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 05:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E43611C0
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 05:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhDZFXb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 01:23:31 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:55163 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhDZFXa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 01:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1619414568; i=@fujitsu.com;
        bh=mGOMWRX4jLjWrnGzoW+AnR/CndWo0AC9RfeK18DxpMQ=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=wwnE9YVZWuLxMSbjl4jo2ncthyMbFr2mK4ZGqGiXjVOhtdkoM4CXuLnkNxNxADHGi
         dbQGU0qpVbw5aQWLwPy1VeT4fwsVqFDm8Apxi7Yshw4QOsn5J0cCvc7LVBUP3ukAHP
         fGcIyZGIDsyz78RERwD2rZrPpA8nRSp0AEYkMZry1UweHKf+euJ3XnbEO/wNyWK4YP
         zzClPuKFkK/sMfaw74SYdYT17OZdqZGEjDryKD5OryZeDMv0cd6ArcAVXhehLIfgOI
         4h8mZOv1xirknWb6h3QRAR8ytANgmkLLaWHdYqaHasvAQjE8ED996ewreypQeHVWTx
         csUVQisI1OJSA==
Received: from [100.112.196.73] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 67/81-53303-82E46806; Mon, 26 Apr 2021 05:22:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRWlGSWpSXmKPExsViZ8MxRVfDry3
  BYMZpPovTLXvZHRg9Pm+SC2CMYs3MS8qvSGDN2N7Tw1JwQqhiweON7A2Ms/i7GLk4hAQ6mSTa
  T7xmgnB2M0r0/FnM2MXIycEmoCnxrHMBM4gtIiAr8X/GaiYQm1lAXWL5pF9gtrBAsET7kR6wG
  hYBVYmL56eB9fIKeErs2rqUHcSWEFCQmPLwPTNEXFDi5MwnLBBzJCQOvnjBDFGjKHGp4xsjhF
  0p0bl+AeMERt5ZSFpmIWlZwMi0itEiqSgzPaMkNzEzR9fQwEDX0NBI19DSQtfQ2EAvsUo3SS+
  1VLc8tbhE11AvsbxYr7gyNzknRS8vtWQTIzC8UgqONe1gPPn6g94hRkkOJiVR3gbG1gQhvqT8
  lMqMxOKM+KLSnNTiQ4wyHBxKEryXfNoShASLUtNTK9Iyc4ChDpOW4OBREuF95AqU5i0uSMwtz
  kyHSJ1i1OXYeXTeImYhlrz8vFQpcd7tvkBFAiBFGaV5cCNgcXeJUVZKmJeRgYFBiKcgtSg3sw
  RV/hWjOAejkjBvO8glPJl5JXCbXgEdwQR0BF9dK8gRJYkIKakGpoTtie9/KMQEch9QvbZ5+oy
  zPuKv6+rdwxNi509snnb126rQqZz13d/jLsbNvHz0FMfRq6dVQzteRQiLnzXOVzp0TEo++1tM
  ifTxGilnLaMNvIXhbyqYfvhsOvPubUp2UqfhuZybSlvM+Q7yzv3/RrfzaKfOK+mY924M0zOS5
  uy+o3HkgGHD3Gm8mzr3PX97/IbMlfnnBd2+7RdY5b/C/8VUzs/71PP/rXvLz7LKj+NnJ7uxZG
  pTrJahvsO3vLtyM+sTpzJE3qh9t3/t0qVbDh2ODTD5vyvJb9HryCefcwOk9z+L2VGkdirbWLR
  3pVD5s7+Ha5zfns8o0Upqm7++ImjnAjfr/ffT1/2cvVfjyXQlluKMREMt5qLiRAB1oUZlNgMA
  AA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-18.tower-291.messagelabs.com!1619414567!1832765!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1559 invoked from network); 26 Apr 2021 05:22:48 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-18.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2021 05:22:48 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13Q5Mgwr016133
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 06:22:47 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 06:22:40 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 1/3] src/*: Fix an error for the loop initialization declaration
Date:   Mon, 26 Apr 2021 14:23:05 +0800
Message-ID: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When compile them on old gcc, get the following error
mount-idmapped.c: In function 'parse_map':
mount-idmapped.c:154:2: error: 'for' loop initial declarations are only allowed in C99 mode
  for (int i = 0; i < 2; i++) {

Fix them by declaring them at the beginning instead of in loop.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
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

