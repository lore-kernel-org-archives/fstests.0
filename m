Return-Path: <SRS0=1u3g=ZX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD4C432C3
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CAE20867
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 12:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLAMxA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Dec 2019 07:53:00 -0500
Received: from snd00010.auone-net.jp ([111.86.247.10]:1696 "EHLO
        dmta0006.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726340AbfLAMxA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Dec 2019 07:53:00 -0500
Received: from ppp.dion.ne.jp by dmta0006.auone-net.jp with ESMTP
          id <20191201125258765.VFOD.12766.ppp.dion.ne.jp@dmta0006.auone-net.jp>
          for <fstests@vger.kernel.org>; Sun, 1 Dec 2019 21:52:58 +0900
Date:   Sun, 1 Dec 2019 21:52:58 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/386: Fix _filter_quota_rpt
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191201125258765.VFOD.12766.ppp.dion.ne.jp@dmta0006.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It outputs nothing because of awk errors.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 tests/generic/386 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/386 b/tests/generic/386
index 462c5869..0c44c80e 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -63,7 +63,7 @@ _require_scratch
 # interested in contains our project name in the first field.  For "df"
 # it contains our project directory in the last field.
 # But if the device name is too long, the "df" output is broke into two
-# lines, the fourth field is not correct, so take $(nf-2) of "df"
+# lines, the fourth field is not correct, so take $(NF-2) of "df"
 _filter_quota_rpt() {
 	awk '
 	BEGIN {
@@ -84,12 +84,12 @@ _filter_quota_rpt() {
 		return result;
 	}
 	{
-		if ($1 =~ proj_name) {
+		if ($1 ~ proj_name) {
 			# this is the "report" output
 			bsize = byte_size($4);
-		} else if ($nf =~ proj_dir) {
+		} else if ($NF ~ proj_dir) {
 			# this is the "df" output
-			bsize = byte_size($(nf-2));
+			bsize = byte_size($(NF-2));
 		} else {
 			next;
 		}
-- 
2.24.0

