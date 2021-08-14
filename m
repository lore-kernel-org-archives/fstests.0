Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740BC4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0271660F91
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhHNKtg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237877AbhHNKtf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Aug 2021 06:49:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3522C60551;
        Sat, 14 Aug 2021 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628938147;
        bh=r6Vqn8rZUxYkm+6dv/KRHZO+s19djiz1vMiIT621Dpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Konwf0Kgb48QbgnsFl6/xrtk+JOzYwJSekemfFIF4GPeE98Jx6UvphlBwdTNGLpHh
         v+Jdc0oIm7MhCyRzj8/JXeW4jLXBBlFGbLkOjw8K1gGr+k1f5a4PvG3GEqPyjbKoto
         f2sJ3CrKoGrdJt7mxU7EAX6PYeW0rEPUekTopDQnKHZArZalQl+eZafby01lLcBHiQ
         CcS0+45gjUpsM/ZwRR4UlqPb1GFJltm5KHKKw0htnBU7kI0L1G2Ej4Es60CwkS8DNp
         Z80STMUs41JXDls3N0KWJc5O6acApNNkx3knp6/2rtUKDa18gWldHfjB/TMpM3qJpU
         +8xoPyB7F89uQ==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 3/8] idmapped-mounts: introduce an explicit command line switch for testsuite
Date:   Sat, 14 Aug 2021 12:48:00 +0200
Message-Id: <20210814104805.1124023-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814104805.1124023-1-brauner@kernel.org>
References: <20210814104805.1124023-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; h=from:subject; bh=6qzmF8syTUX+ynEg7t4ERVbLZvYGILufTJZVwY2BFPI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKzw93n7ZnRzQ377Lq4ndvJ8zod3+uq2qvwj5dcsPDmPRH ZQ6pHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJ6GJk+NSfGnvvzT13rUNXj+1kS/ oiufP182np89bpzZpmY2qx7iXDf+e2aIdTKy/lyQat/Gi1UsN169GNOssaLJ/PWOvvd3H3LQYA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Introduce an explicit command line switch to runs the basic test suite.
This prepares for the introduction of additional command line switches
to run additional tests.

Cc: fstests@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
- Christoph Hellwig <hch@lst.de>:
  - Split into separate patch.

/* v4 */
unchanged
---
 src/idmapped-mounts/idmapped-mounts.c | 11 ++++++++---
 tests/generic/633                     |  3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 0e6698bd..e45248e1 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8722,6 +8722,7 @@ static void usage(void)
 	fprintf(stderr, "--help          Print help\n");
 	fprintf(stderr, "--mountpoint    Mountpoint of device\n");
 	fprintf(stderr, "--supported     Test whether idmapped mounts are supported on this filesystem\n");
+	fprintf(stderr, "--test-core     Run core idmapped mount testsuite\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -8732,7 +8733,8 @@ static const struct option longopts[] = {
 	{"mountpoint",	required_argument,	0,	'm'},
 	{"supported",	no_argument,		0,	's'},
 	{"help",	no_argument,		0,	'h'},
-	{NULL,		0,			0,	0  },
+	{"test-core",	no_argument,		0,	'c'},
+	{NULL,		0,			0,	0},
 };
 
 struct t_idmapped_mounts {
@@ -8827,7 +8829,7 @@ int main(int argc, char *argv[])
 {
 	int fret, ret;
 	int index = 0;
-	bool supported = false;
+	bool supported = false, test_core = false;
 
 	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
@@ -8843,6 +8845,9 @@ int main(int argc, char *argv[])
 		case 's':
 			supported = true;
 			break;
+		case 'c':
+			test_core = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -8912,7 +8917,7 @@ int main(int argc, char *argv[])
 
 	fret = EXIT_FAILURE;
 
-	if (!run_test(basic_suite, ARRAY_SIZE(basic_suite)))
+	if (test_core && !run_test(basic_suite, ARRAY_SIZE(basic_suite)))
 		goto out;
 
 	fret = EXIT_SUCCESS;
diff --git a/tests/generic/633 b/tests/generic/633
index 6be8a69e..67501177 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -20,7 +20,8 @@ _require_test
 
 echo "Silence is golden"
 
-$here/src/idmapped-mounts/idmapped-mounts --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
+$here/src/idmapped-mounts/idmapped-mounts --test-core --device "$TEST_DEV" \
+	--mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
 exit
-- 
2.30.2

