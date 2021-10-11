Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89550C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 15:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C02D61054
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 15:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhJKPNU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 11:13:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhJKPNT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 11:13:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23673220CA;
        Mon, 11 Oct 2021 15:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633965079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VrBBO5RMEHl4a8KQO+BtAAKjQs24VC0lMeDEYhp9w+8=;
        b=hZ2XWUVprN6y40wS8I32+zCuMjUA1ChKE+MqVe7yTtq1hZ7RE01QA5WbGERVhichLV5DwT
        HUvcYhToZbyo2WMvNZ96r+vXtk+yNwRgIOoBEVajnlXNdAedpEPRu7hq+xFsMb7GdGlfi+
        tF9UPWtpU1FYefL7j9Ciff38EAcNyCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633965079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VrBBO5RMEHl4a8KQO+BtAAKjQs24VC0lMeDEYhp9w+8=;
        b=WgwDEr43QjH5+kUdEwhNE7ecsdoNL7aIyOAXPJEJSCdQvlLXQ0pyNtKp+N1iU1v+xg+0zb
        /7nX4p7niOuP4sBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A88F013C72;
        Mon, 11 Oct 2021 15:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6v8JJhZUZGFuSQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 11 Oct 2021 15:11:18 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id d4d33edf;
        Mon, 11 Oct 2021 15:11:17 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Zorro Lang <zlang@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] generic/095: align DIO read/writes with the supported sector size for the device
Date:   Mon, 11 Oct 2021 16:11:16 +0100
Message-Id: <20211011151116.27901-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test creates fio DIO jobs with bs=1k, which will fail when using block
devices that have logical sector size bigger than 1k (such as zram, advanced
format HDD's with 4k sectors, DASD's on mainframes with 2k sectors, etc).

Fix the test by using _min_dio_alignment instead to get the correct size.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
Changes since v1:
- Updated commit subject and description as suggested by Ted (thanks for
  the review!)

 tests/generic/095 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/generic/095 b/tests/generic/095
index c4693917b3e1..80448200bb86 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -23,6 +23,7 @@ iodepth_batch=$((8 * LOAD_FACTOR))
 numjobs=$((5 * LOAD_FACTOR))
 fio_config=$tmp.fio
 fio_out=$tmp.fio.out
+blksz=$(_min_dio_alignment $SCRATCH_DEV)
 cat >$fio_config <<EOF
 [global]
 bs=8k
@@ -34,7 +35,7 @@ directory=$SCRATCH_MNT
 numjobs=$numjobs
 [job1]
 ioengine=sync
-bs=1k
+bs=$blksz
 direct=1
 rw=randread
 filename=file1:file2
@@ -44,7 +45,7 @@ rw=randwrite
 direct=1
 filename=file1:file2
 [job3]
-bs=1k
+bs=$blksz
 ioengine=posixaio
 rw=randwrite
 direct=1
