Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E911CE7A95
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Sep 2023 15:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjIYPWe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjIYPWd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Sep 2023 11:22:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4FFF
        for <fstests@vger.kernel.org>; Mon, 25 Sep 2023 08:22:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12750C433C7;
        Mon, 25 Sep 2023 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695655346;
        bh=UYsguSMkXDd0r1igae8/sr8MEMI3IoFd82yN1Xzm+rI=;
        h=From:Date:Subject:To:Cc:From;
        b=U+oxCi80PoqpHZa8agbg6zPRe9g90rsnGZre+IWYVK17K3yWomT5QU860H+jQas62
         cz1pVT6mUAaH8ZICGfYDp/J3Us6xPyejk+yNmtWF0iySrmhtkKTd0E90mjLEfaCEiw
         4nN4kJWCTDZSazx8G/VAjee+r/ynTXfW638sjjMuFggv3ENGCnT/tgA20aQag1IQfS
         QtqhAVlci5U9TBP925zY5ahsGNbqsaF9SF3HA9S86Yo9axdoC2YMYUR5Bxkb1dmR69
         4Md7jxzJVM+MWHYINajle4+FZUWD2Ks7G16jE/oKp/mXG2aADoTj4rnWv7T8rHx3eZ
         0KGCO/sD8xZ2A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 25 Sep 2023 17:22:21 +0200
Subject: [PATCH] common: check user and group existence via id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230925-fstests-check-user-v1-1-09b97257bcdb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKylEWUC/x3MQQrCMBBG4auUWTtQY4vWq4iLJP4xg5DKTJRC6
 d0bXX6L91YyqMDo2q2k+IrJXBqOh45i9uUJlkczud6d+smNnKzCqnHMiC/+tJzH4XIGpgCHRC1
 8K5Is/+nt3hy8gYP6EvNvlWblgqXStu1U6bF8fwAAAA==
To:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UYsguSMkXDd0r1igae8/sr8MEMI3IoFd82yN1Xzm+rI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQKLt3olqXW+TjKdbqGZjZ75KqYH09t/si3lC9Y3bRvfv63
 m5xWHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5XMbwV/xVcfVJg3MMNhoXmCabPC
 rmuy2ra7iv7HkA57xWD+MzOQx/RWX8ND0z7523Tw7a8e7/9Rv3UpIuqD628j1XoOp/9flxXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Newer machines support the creation of users that don't appear in
/etc/passwd but are only available via nss or userdbd. Use the id binary
which is portable and reliable.

With this change I can run xfstests on systems where the users are
created via systemd-userdbd drop-ins. See the documentation in [1] and [2].

Link: [1]: https://man7.org/linux/man-pages/man8/nss-systemd.8.html
Link: [2]: https://man7.org/linux/man-pages/man5/nsswitch.conf.5.html
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 common/rc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 76a7e774..44c90f50 100644
--- a/common/rc
+++ b/common/rc
@@ -2450,7 +2450,8 @@ _yp_active()
 _cat_passwd()
 {
 	[ $(_yp_active) -eq 0 ] && ypcat passwd
-	cat /etc/passwd
+	id -u "$1"
+	[ "$?" == "0" ] && echo "$user:"
 }
 
 # cat the group file
@@ -2458,7 +2459,8 @@ _cat_passwd()
 _cat_group()
 {
 	[ $(_yp_active) -eq 0 ] && ypcat group
-	cat /etc/group
+	id -g "$1"
+	[ "$?" == "0" ] && echo "$group:"
 }
 
 # check if a user exists in the system

---
base-commit: 2fddeb5c79ff16bf37e1f1d809bd94b360c27801
change-id: 20230925-fstests-check-user-5487ee9be2ef

