Return-Path: <SRS0=0kg8=ZD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF9C43331
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 07:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60232075C
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 07:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAHA4kG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKHkU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:40:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44656 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfKKHkU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Nov 2019 02:40:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id f2so13382956wrs.11;
        Sun, 10 Nov 2019 23:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MoAGf49PP11xkmCo2JW1cZjvmPda4h92cn+3cutaohs=;
        b=DAHA4kG+5pFgJmDpNVdg0UL3r+mBvcxiQvSyDdR0PtUsta6XaZbCBKJSOH+5uxBWfA
         Wy6Mz+yqOihfdQqk711MaMtzxm2HYa6YNh7sux7NXk+J+yBui5Yq0VksF75uAXsDbcPv
         wYmxZrcO3YYhjGJQFWgq71m0gEBXvjH6143XdTAR/eLq0qPcW0AmHdph3c9C2A/bf4Y8
         6dfKY/f1/I6Qpl/ybFYvg+9KFyhiJolkgGirieZi5VQKCLGTo1z6ANpia7oJb5a/hpmA
         7H8PAGytYvqNl8hyXMD/u1PvOT9934K0dLKAnKQk5y5Dtc+hn/wLgaBYji7wT8r+4OO0
         M5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MoAGf49PP11xkmCo2JW1cZjvmPda4h92cn+3cutaohs=;
        b=jAbLvaWfyQXg8S/4v8+wCXF5KpWLzmzkj5zn7ovRbpg23TYSd6BahkgwHxjVfNhePi
         sKnaViZbwiFsjTK9gKZRwm/Kyy1J+iTs8ejKfLfRvDCoGbKp1txoqHcSAe8nbZ9F6G1W
         LVLQ8A/WkhU6ahXY//p/6tHJEqUAWzjSkJ6DE6WSbPh2Q6Kzt3jxat6LyOyTHoC2jUUt
         VfOPLO8b3QogO5DFMhi0frrdJr+48YYhk3Jn4CnZHP6SOtBH0zQroqm6pG2RE6Taec7o
         Wx/ls6wzy98MI42AQm0gl8U378OIXbEtSIcwFIYTob0SgNhgQLHEIJ9FfzHwRkip30Sw
         KpUA==
X-Gm-Message-State: APjAAAV4mW823LahLU44IdDcfo//kue31oNN5XoD431nDmiaVwyECCsM
        XOWEciCjaFS6ZeOxrum5s54=
X-Google-Smtp-Source: APXvYqyC4oQEaSD10Jq+fJZB91XYzHQHB/wMKJbN4v+7h72FCf4QnSmHUdMVMdTb6t2rsObMgLWu0w==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr18448337wro.28.1573458018006;
        Sun, 10 Nov 2019 23:40:18 -0800 (PST)
Received: from localhost.localdomain ([94.230.83.228])
        by smtp.gmail.com with ESMTPSA id j63sm20557270wmj.46.2019.11.10.23.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 23:40:17 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] overlay: support timestamp range check
Date:   Mon, 11 Nov 2019 09:40:10 +0200
Message-Id: <20191111074010.3738-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Overlayfs timestamp range is the same as base fs timestamp range

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

This change will cause the test to start running and failing on upstream
kernel with overlayfs over some fs (e.g. xfs/ext4).

The kernel fix is posted:
https://lore.kernel.org/linux-fsdevel/20191111073000.2957-1-amir73il@gmail.com/T/#u

Thanks,
Amir.

 common/rc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b988e912..e5535279 100644
--- a/common/rc
+++ b/common/rc
@@ -1978,13 +1978,14 @@ _require_timestamp_range()
 _filesystem_timestamp_range()
 {
 	local device=${1:-$TEST_DEV}
+	local fstyp=${2:-$FSTYP}
 	u32max=$(((1<<32)-1))
 	s32min=-$((1<<31))
 	s32max=$(((1<<31)-1))
 	s64max=$(((1<<63)-1))
 	s64min=$((1<<63))
 
-	case $FSTYP in
+	case $fstyp in
 	ext2)
 		echo "$s32min $s32max"
 		;;
@@ -2005,6 +2006,13 @@ _filesystem_timestamp_range()
 	btrfs)
 		echo "$s64min $s64max"
 		;;
+	overlay)
+		if [ ! -z $OVL_BASE_FSTYP -a $OVL_BASE_FSTYP != "overlay" ]; then
+			_filesystem_timestamp_range $OVL_BASE_TEST_DEV $OVL_BASE_FSTYP
+		else
+			echo "-1 -1"
+		fi
+		;;
 	*)
 		echo "-1 -1"
 		;;
-- 
2.17.1

