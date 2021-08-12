Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953B8C4320A
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 16:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB726103A
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 16:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhHLQEV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhHLQEV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Aug 2021 12:04:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B6BD604AC;
        Thu, 12 Aug 2021 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628784235;
        bh=gNC/n+eskzlmrFALDhTHIbR0ofTes7QbvJCkpWOitMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkpHF8T/dHHKEbhu7Z5SnBSZ+Qn+eeAO6/d15TB69sfnyqsLTu1WIH6uKGpr54q8R
         ytj39l6s9pBtr1rOzNMxZrtGe1Gvlm4jZELfarTSnQxuplwDHHoQWq4qeO9vW6rnqx
         jzgMBwRToVMr9jo8myX+QgENWC3Ij8+Ix3lO3Mz7eN9ak1VMB9BeslSBz/T/L9xXul
         lfPW43cFRj/Y8Mt1s/RR0mlBks06BlFZ2cm5WFgyusOWnacjOH9oHkQkVHM76q8g/7
         PHJpe4pbJCA0BUemytVhyTIY4nGsGptEhB5E0jm3RVOu48pTQfxBfBoJPWyLTYUtOQ
         QMCQgemBXCQjw==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 3/8] idmapped-mounts: introduce an explicit command line switch for testsuite
Date:   Thu, 12 Aug 2021 18:01:35 +0200
Message-Id: <20210812160140.990229-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812160140.990229-1-brauner@kernel.org>
References: <20210812160140.990229-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669; h=from:subject; bh=fpVXkPsVBKZwBBfhISoaIIsnX6MmldyBiCn0RRPshaE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKut7fOCVdvuVZU16S3f2PhzquVGaHflEt/pDpo9AfejJv 9e4XHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5GsnIsPx86by0xW9dZ6o2KvIGXv 9/x6a5LVxEWjdyomj9fc6pTIwMk1IMn3HPcz18K/Tx2d3L9ua8jyncmXIpcK930ddv+dW/2QE=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Introduce an explicit command line switch to runs the basic test suite.
This prepares for the introduction of additional command line switches
to run additional tests.

Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
- Christoph Hellwig <hch@lst.de>:
  - Split into separate patch.
---
 src/idmapped-mounts/idmapped-mounts.c | 11 ++++++++---
 tests/generic/633                     |  3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index e565246e..7723a222 100644
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
 
 	while ((ret = getopt_long_only(argc, argv, "d:f:m:sh", longopts, &index)) != -1) {
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

