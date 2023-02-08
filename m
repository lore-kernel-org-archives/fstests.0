Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFD8C05027
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Feb 2023 07:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBHHEO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBHHDq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Feb 2023 02:03:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9745206
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 23:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E04E5B81B05
        for <fstests@vger.kernel.org>; Wed,  8 Feb 2023 07:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C11C433EF;
        Wed,  8 Feb 2023 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675839713;
        bh=rXS9wF7EW0d56LDjOUESn7kCkBxc2kf60AplNiNdd3A=;
        h=From:To:Cc:Subject:Date:From;
        b=kJ2/tpeGEnz8QifFoF5LI5hiXIjYRbn/JwQYcQS3IMqas5Xn2xm1aYi5FIimH1hps
         C5EXdpp3qSNUWMnty1/aRv6tM/h2NDw5IDPadm4irm9LAfNVyFvJVYN2XMUdleG8CS
         ZCs3UXKN8M3++V31Qod0m60e/ECrEvutBh78KR6oHvR7+ZRMAqkOtApyc2awbFK7C/
         6gbovKLGysekeABGBcnpn9k9XuOqlIglMet1jB0B2jryPSjSXc2Ph5dOq2zxk5hWLH
         U2p0XMGF4qkDeQH9ODxeJvloofjDJODrC6dPHe3D5S/PtIEvbUghk56hJfW0+vXH6S
         petm26fIi6oQg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: [xfstests-bld PATCH] run-fstests: don't assume that host system has dpkg
Date:   Tue,  7 Feb 2023 23:01:50 -0800
Message-Id: <20230208070150.229243-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

dpkg is generally only present on Debian-derived distros.

Fixes: 1efbdfd8c837 ("Use more general architecture handling")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 run-fstests/util/arch-funcs | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/run-fstests/util/arch-funcs b/run-fstests/util/arch-funcs
index 248a2a0..3933867 100644
--- a/run-fstests/util/arch-funcs
+++ b/run-fstests/util/arch-funcs
@@ -13,12 +13,16 @@
 #
 
 function set_my_arch () {
-    local t
-
     if test -n "${MY_ARCH:=}" ; then
         return
     fi
-    MY_ARCH=$(dpkg --print-architecture)
+    local arch=$(uname -m)
+    case $arch in
+	aarch64)   MY_ARCH=arm64  ;;
+	i386|i686) MY_ARCH=i386   ;;
+	x86_64)    MY_ARCH=amd64  ;;
+	*)         MY_ARCH=$arch  ;;
+    esac
 }
 
 function set_default_arch ()
-- 
2.39.1

