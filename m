Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B338C432BE
	for <linux-fstests@archiver.kernel.org>; Sat, 31 Jul 2021 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E7061052
	for <linux-fstests@archiver.kernel.org>; Sat, 31 Jul 2021 16:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhGaQ65 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 31 Jul 2021 12:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhGaQ65 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 31 Jul 2021 12:58:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 126F360EFD;
        Sat, 31 Jul 2021 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627750731;
        bh=11hbWxGYflk2PPCgEEi/9TZro13z1gNUk2VPcQdvFKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvG3HyjTPWOv6AjCa+VjZqaISCo2SgcmRl9DqUkg4LpoPxCfThTBjz/N9c+22i04i
         Eobt9cx7L0kYgXLfUI5InCS2Hc1Dv0RY3jBU/Mc8ueBivpDVjRa0AlyFU0k4JtdXJB
         rnuedkrxMQgme2qf8sIoMPAqpcs75EfAwoeZx3zJKPjfO33Wfl02z3d9Mku4C5pN4P
         bIdLDgBHiHB8Bv+ZYvjs9cPQjO8PM3KlsZ5Tp4AqhucPvAL1CVx9fxqyTM3ySPFq+l
         ECMeSZFWLbALn5umeUe8HA0QieE52u1jfr/kvid2DB9ud8G8JzC7SvjKsxuIkLt6N1
         T/RXAXFcMw8mA==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/6] idmapped-mounts: prepare for additional tests
Date:   Sat, 31 Jul 2021 18:58:29 +0200
Message-Id: <20210731165834.479633-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210731165834.479633-1-brauner@kernel.org>
References: <20210731165834.479633-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3938; h=from:subject; bh=95q/08UlIxfdzt2b6kHD1rGy5hkfzY++CK3mdLJmXDY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSyNkpcOLRwsX3b1mm2rF8Oy1ipWR+wYimyO5l20VmBh2nO xCctHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJP83I8OjTVQ0lvV1dCmLfVv1gy9 BQ5L5mdqpLY8mloH+vPhWIxTMy/Nl1pMjhX45K0vu64LYNFndDwmrFf3NlPL4QkCXAJ7ybGwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

- Use sequential option numbering for option parsing since we're only
  using longopts anyway and to easier correlate test parsing in the
  switch with the options specified in longopts.
- Introduce an explicit command line switch to runs the basic test
  suite. This prepares for the introduction of additional command line
  switches to run tests.
- Update help output.
- Use die() when logging test failure.

Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
new patch
---
 src/idmapped-mounts/idmapped-mounts.c | 44 +++++++++++++++------------
 tests/generic/633                     |  3 +-
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 2c212131..c8635362 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8717,19 +8717,24 @@ static void usage(void)
 	fprintf(stderr, "    Run idmapped mount tests\n\n");
 
 	fprintf(stderr, "Arguments:\n");
-	fprintf(stderr, "-d --device        Device used in the tests\n");
-	fprintf(stderr, "-m --mountpoint    Mountpoint of device\n");
+	fprintf(stderr, "--device        Device used in the tests\n");
+	fprintf(stderr, "--fstype        Filesystem type used in the tests\n");
+	fprintf(stderr, "--help          Print help\n");
+	fprintf(stderr, "--mountpoint    Mountpoint of device\n");
+	fprintf(stderr, "--supported     Test whether idmapped mounts are supported on this filesystem\n");
+	fprintf(stderr, "--test-core     Run core idmapped mount testsuite\n");
 
 	_exit(EXIT_SUCCESS);
 }
 
 static const struct option longopts[] = {
-	{"device",	required_argument,	0,	'd'},
-	{"fstype",	required_argument,	0,	'f'},
-	{"mountpoint",	required_argument,	0,	'm'},
-	{"supported",	no_argument,		0,	's'},
-	{"help",	no_argument,		0,	'h'},
-	{NULL,		0,			0,	0  },
+	{"device",	required_argument,	0,	1},
+	{"fstype",	required_argument,	0,	2},
+	{"mountpoint",	required_argument,	0,	3},
+	{"supported",	no_argument,		0,	4},
+	{"help",	no_argument,		0,	5},
+	{"test-core",	no_argument,		0,	6},
+	{NULL,		0,			0,	0},
 };
 
 struct t_idmapped_mounts {
@@ -8804,10 +8809,8 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 
 		if (pid == 0) {
 			ret = t->test();
-			if (ret) {
-				fprintf(stderr, "failure: %s\n", t->description);
-				exit(EXIT_FAILURE);
-			}
+			if (ret)
+				die("failure: %s", t->description);
 
 			exit(EXIT_SUCCESS);
 		}
@@ -8826,23 +8829,26 @@ int main(int argc, char *argv[])
 {
 	int fret, ret;
 	int index = 0;
-	bool supported = false;
+	bool supported = false, test_core = false;
 
 	while ((ret = getopt_long(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
-		case 'd':
+		case 1:
 			t_device = optarg;
 			break;
-		case 'f':
+		case 2:
 			t_fstype = optarg;
 			break;
-		case 'm':
+		case 3:
 			t_mountpoint = optarg;
 			break;
-		case 's':
+		case 4:
 			supported = true;
 			break;
-		case 'h':
+		case 6:
+			test_core = true;
+			break;
+		case 5:
 			/* fallthrough */
 		default:
 			usage();
@@ -8911,7 +8917,7 @@ int main(int argc, char *argv[])
 
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

