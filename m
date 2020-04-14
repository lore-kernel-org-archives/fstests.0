Return-Path: <SRS0=cLE3=56=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85655C2BA19
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Apr 2020 16:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5763E2075E
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Apr 2020 16:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586881403;
	bh=X0mVgGhZ5fIp1Ig39iIPNq9eDAB8AgMq1l2XIOF86yM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GtFVyXiq9BVkmN2Hy+ucbv+B5yj37NJo5kg3RXt/4ZqjyxFaJvoekVKoS0oVe15S4
	 C7E+bfr/Bz/i7zRR3pslWl/uL8UxfZd0sfSrDRf6sHt5ETeMefBtmzCqfMKtHQo2Zh
	 TW+uwALd9vaTEVx5lFdCpQrGMvUIeAuubC7Y9XCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391407AbgDNQXH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391396AbgDNQW1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Apr 2020 12:22:27 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D1072075E;
        Tue, 14 Apr 2020 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586881346;
        bh=X0mVgGhZ5fIp1Ig39iIPNq9eDAB8AgMq1l2XIOF86yM=;
        h=From:To:Cc:Subject:Date:From;
        b=bLFmiaahzUJ3SatExvbeihSGYh8DF+jlVBOguz+GfCLt1HDYy7GbwthGsM/UpWf1k
         6fpdk19mKDxu6pdbBRn5Hp5tsmh2CFX5oT3CZHoziaQt3HE1SmZD9EciUZIh6rD2Dn
         GxCoCY7N8PQs2EOZqQSbUMUJY6wnjR7kFAq2Q0PY=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/3] btrfs: add several test to the balance group
Date:   Tue, 14 Apr 2020 17:22:21 +0100
Message-Id: <20200414162221.24357-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some tests exercise balance but are not included in the 'balance' group,
so just add them to that group.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/group | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index 657ec548..b5cd90c1 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -5,7 +5,7 @@
 #
 001 auto quick subvol snapshot
 002 auto snapshot
-003 auto replace volume
+003 auto replace volume balance
 004 auto rw metadata
 005 auto defrag
 006 auto quick volume
@@ -104,7 +104,7 @@
 099 auto quick qgroup limit
 100 auto replace volume eio
 101 auto replace volume eio
-102 auto quick metadata enospc
+102 auto quick metadata enospc balance
 103 auto quick clone compress
 104 auto qgroup
 105 auto quick send
@@ -125,9 +125,9 @@
 120 auto quick snapshot metadata log
 121 auto quick snapshot qgroup
 122 auto quick snapshot qgroup
-123 auto quick qgroup
-124 auto replace volume
-125 auto replace volume
+123 auto quick qgroup balance
+124 auto replace volume balance
+125 auto replace volume balance
 126 auto quick qgroup limit
 127 auto quick send
 128 auto quick send
@@ -156,9 +156,9 @@
 151 auto quick volume
 152 auto quick metadata qgroup send
 153 auto quick qgroup limit
-154 auto quick volume
+154 auto quick volume balance
 155 auto quick send
-156 auto quick trim
+156 auto quick trim balance
 157 auto quick raid
 158 auto quick raid scrub
 159 auto quick punch log
@@ -197,7 +197,7 @@
 192 auto replay snapshot stress
 193 auto quick qgroup enospc limit
 194 auto volume
-195 auto volume
+195 auto volume balance
 196 auto metadata log volume
 197 auto quick volume
 198 auto quick volume
-- 
2.11.0

