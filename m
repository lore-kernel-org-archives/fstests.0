Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2E1C4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDF86103E
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 16:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhHLQEP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhHLQEO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Aug 2021 12:04:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A9436103A;
        Thu, 12 Aug 2021 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628784229;
        bh=DK0KjNjlK+n+8/glW+V5ILKmUMk8kqNXC041Y7JdIlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9uaabNZeONxoXPL/eaRgqgNZh49PSWXD7zZr+dk8p35JQEjzKspsWcDm+QRhjf8c
         9nT38y2ES9+s1jVwZOvnnIe2YPMBAeDDxN4bQUSZRew6iRqnvNy7eTeBeCoDFiCXYg
         ti9BW7UkWGnQXt3FSaz93ahd6C3FDOe+atKy+klVh7+o+l9DQY0o0ZNvj466f6Oew/
         97Pp/2GZAEyJaWs8kGGY/3DkzMGUvBLYhcB7AV8NLTVH/CHJFfNkwiK50desJmu/Qy
         dUDLan7Xlgz66elJw9jDyLAQ0YArbaCdGpHx6PVvKw9PWjA5Jpi6cbNTMj/kWs7Y+C
         3orUHpz95AdkQ==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 2/8] idmapped-mounts: switch to getopt_long_only()
Date:   Thu, 12 Aug 2021 18:01:34 +0200
Message-Id: <20210812160140.990229-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812160140.990229-1-brauner@kernel.org>
References: <20210812160140.990229-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653; h=from:subject; bh=nRgHMrq/YOuXzb2I5/GHqf7G4cyNluPqHLUA6AH6zWs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKut43eFxUPtmJf6/Totu3wzpDRV/Ov7X3S8/ql5v5U0Wm duXt6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIVjDDP63bnAFTOE/u2nH92FmW0H 35b18yrPu58Ph7d09p57hDN6oYGWavC52qv7H7jETr/r8eLC3djI82JV/O3CGu8zp7k3NQLzMA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

We're not using the shortopts anywhere anyway so just rely on longopts.

Cc: fstests@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
- Christoph Hellwig <hch@lst.de>:
  - Split into separate patch.
---
 src/idmapped-mounts/idmapped-mounts.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 69dcc027..e565246e 100644
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
+	while ((ret = getopt_long_only(argc, argv, "d:f:m:sh", longopts, &index)) != -1) {
 		switch (ret) {
 		case 'd':
 			t_device = optarg;
-- 
2.30.2

