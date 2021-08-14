Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC76C432BE
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C75B60F42
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhHNKtf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237924AbhHNKtd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Aug 2021 06:49:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE54F60F46;
        Sat, 14 Aug 2021 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628938145;
        bh=mnT3CBX7dSpVXNHZ59nY0nbgEtCS3QGpDTSVjjuK9pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYzxatP/j6ZJTrVWRgiK2JgLY0sKmFkdA87cFFR3C6O/+GMSUVJhpukn6tsbbnaoH
         72RFrvUlWe7b+L1V4Q8DIDQXa3EhosLhJfqsVdqclAptujn91l7QXchcbQY803kmz5
         w1Al9rm+WCcSQxHf9osIjZ+BW43Lmzz15PDa9owt7OFj5nnkjJG5GFuSgBNBatpYys
         H8/v6DIh5jQlLvB0530PGWF1jIJe9DseAkXoWLdhBQEOWRTkC9OA4RzD9t08Hojvl1
         ayxLiW31jk6KnVhbSStqTNaQlXk/jR9yQXbkx7KQLHEzvI0OH6Z4WJ5E9eWWckbhL7
         VEGCJB3kMeiiw==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 2/8] idmapped-mounts: switch to getopt_long_only()
Date:   Sat, 14 Aug 2021 12:47:59 +0200
Message-Id: <20210814104805.1124023-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814104805.1124023-1-brauner@kernel.org>
References: <20210814104805.1124023-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2448; h=from:subject; bh=CZLYm0+Skd4jVA8AaQjm4GmmTTDXjH6GSLnDQwxIXp0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKzw//Ipz8Q0hry4RrNzyjpwq5V2VrHBRJW9P97EbJpo7j s0PYOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZit4Phf5DCJ86lzycL3k8MDvJRbu F07TYUSjtyuemjgtbhQ0L7dzP8Zg1R9vrwWKTt3dkHjE2Lv+sLLOtyDk2KUuKZscAxSfcUCwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

We're not using the shortopts anywhere anyway  and shouldn't encourage
using shortopts.  It's much more descriptive to see:

$here/src/idmapped-mounts/idmapped-mounts \
        --test-btrfs \
        --device "$TEST_DEV" \
        --mountpoint "$TEST_DIR" \
        --scratch-device "$SCRATCH_DEV" \
        --scratch-mountpoint "$SCRATCH_MNT"
        --fstype "$FSTYP"

in a test than it is to see:

$here/src/idmapped-mounts/idmapped-mounts \
        -b
        -d "$TEST_DEV" \
        -m "$TEST_DIR" \
        -s "$SCRATCH_DEV" \
        -a "$SCRATCH_MNT" \
        -f "$FSTYP"

In the second case one has to go consult the source code to make sure
that the correct option is passed. In the first case one can just see it
directly.

Cc: fstests@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
- Christoph Hellwig <hch@lst.de>:
  - Split into separate patch.

/* v4 */
- Christoph Hellwig <hch@lst.de>:
  - Pass empty string for optstring argument in getopt_long_only().
---
 src/idmapped-mounts/idmapped-mounts.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 69dcc027..0e6698bd 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8717,8 +8717,11 @@ static void usage(void)
 	fprintf(stderr, "    Run idmapped mount tests\n\n");
 
 	fprintf(stderr, "Arguments:\n");
-	fprintf(stderr, "-d --device        Device used in the tests\n");
-	fprintf(stderr, "-m --mountpoint    Mountpoint of device\n");
+	fprintf(stderr, "--device        Device used in the tests\n");
+	fprintf(stderr, "--fstype        Filesystem type used in the tests\n");
+	fprintf(stderr, "--help          Print help\n");
+	fprintf(stderr, "--mountpoint    Mountpoint of device\n");
+	fprintf(stderr, "--supported     Test whether idmapped mounts are supported on this filesystem\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -8826,7 +8829,7 @@ int main(int argc, char *argv[])
 	int index = 0;
 	bool supported = false;
 
-	while ((ret = getopt_long(argc, argv, "", longopts, &index)) != -1) {
+	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
 		case 'd':
 			t_device = optarg;
-- 
2.30.2

