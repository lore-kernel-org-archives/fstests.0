Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09A0C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 13 Nov 2021 21:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7731261177
	for <linux-fstests@archiver.kernel.org>; Sat, 13 Nov 2021 21:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhKMVDC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 13 Nov 2021 16:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKMVDB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 13 Nov 2021 16:03:01 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C6C061766
        for <fstests@vger.kernel.org>; Sat, 13 Nov 2021 13:00:09 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 132so12614749qkj.11
        for <fstests@vger.kernel.org>; Sat, 13 Nov 2021 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=HT7BRzMemMH185YVe9ACRk8ZDqWaBviOHiP+oLtPIvQ=;
        b=oOnYRKuNy+RZESoZyNSdsivnJAfqkNNgJSA00yR/n1gyFdkGeJoh8UxT1co4w58tyu
         UQAwvyRDnBoNry3OdFr9VciH0LTFW9+H/tVt0oRjxSEvbCOZxrVauZ94wiCQxlRUjtM+
         zv3Nbp2ZQuDySW5NFRYxoD6ZZgqUYXXSoiTs3J0CbNP3aCmHmJcP+a0StsJmNwxyI32V
         U7dGHljoPbC3WvVbDwIQyBEi4weYY5/8zJcT99ClWxTdy9rGFs+OjPa0gsrKgZqEJYdV
         03MY7O8B5sm76ZRVd3TaiUB1ujT36ohITETUmd48OmkV9W6QcxDKAV2sBjf5ZQdcR7Uh
         +Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=HT7BRzMemMH185YVe9ACRk8ZDqWaBviOHiP+oLtPIvQ=;
        b=sud0RQChi8FSoqbm74adV2EtSeLlBiy6bvkBvUedAB8VGLBtME/mJ730S902wa+PZb
         J6zXIOlh7BjH/3r3ktIyjEFSKDkcNQ3ziaqk7KaIAN51billQxVegFalbAiePj9m5lnX
         1l5S+ZVsnbYeR4u0yCTpNkyiY046b/+USU2Dfv9vhVB4KXLjrOWZL8AqSV2u/ZPO0fGQ
         l8r6Xt5xbnU0Lh2PM3+IMQxzvbLhrT4XGnlM3rPj5lt38R0LHW6jPy+oN7Jq1X384f5S
         64BiVj19s5jVEJ6n7f28xexs3z7BQQSJENE3vRFYZUGKg+ikiZpOwz8enb6yQEPdZQHz
         9Ukg==
X-Gm-Message-State: AOAM530zJmdMfnqZEdYP2gOCP9+PKLYIAHcEd/RbPK27n9vWaGeDhb2D
        m8iY1DeJVPjEcHpRI5HGtndOT9fuyA==
X-Google-Smtp-Source: ABdhPJx3l8tDG3peIl8YjeaxccFp8gWDvOkUj2He988opAAc+uuv1gf2QmAiZhNNnlmS7jml1737/A==
X-Received: by 2002:a05:620a:652:: with SMTP id a18mr15763310qka.146.1636837207517;
        Sat, 13 Nov 2021 13:00:07 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id v21sm3250533qta.0.2021.11.13.13.00.06
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 13:00:06 -0800 (PST)
Date:   Sat, 13 Nov 2021 16:00:03 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/544: Fix inode number ordering code
Message-ID: <YZAnUyyKgaddwOQH@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The code that creates files and moves them to low/high inode number
files writes different file contents before doing the move - leading to
non-reproducible results.

Fix this by writing the file contents after moving them to high/low
inode number files.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 tests/generic/544 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/generic/544 b/tests/generic/544
index 4a9f48526d..4dbaea4de0 100755
--- a/tests/generic/544
+++ b/tests/generic/544
@@ -44,8 +44,9 @@ inum() {
 # Create two test files, make $low_file the file with the lower inode
 # number, and make $high_file the file with the higher inode number.
 create_files() {
-	_pwrite_byte 0x60 0 $filesize $testdir/file1 >> $seqres.full
-	_pwrite_byte 0x61 0 $filesize $testdir/file2 >> $seqres.full
+	touch $testdir/file1
+	touch $testdir/file2
+
 	if [ "$(inum $testdir/file1)" -lt "$(inum $testdir/file2)" ]; then
 		mv $testdir/file1 $low_file
 		mv $testdir/file2 $high_file
@@ -53,6 +54,9 @@ create_files() {
 		mv $testdir/file2 $low_file
 		mv $testdir/file1 $high_file
 	fi
+
+	_pwrite_byte 0x60 0 $filesize $low_file >> $seqres.full
+	_pwrite_byte 0x61 0 $filesize $high_file >> $seqres.full
 }
 
 # Check md5sum of both files, but keep results sorted by inode order
-- 
2.33.1

