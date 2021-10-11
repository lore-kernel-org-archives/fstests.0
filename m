Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B0C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B88361056
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 13:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhJKN6y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 09:58:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46114 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbhJKN5I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 09:57:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DA4B22023;
        Mon, 11 Oct 2021 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633960507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cdaihtqPpybIwx81AHyViScitJ8sjiNkjWydF9AYG5I=;
        b=dvUqvh4XazbPbDpLXoyVbgObBktzBFg1tjaDEpnI8V89rB5mWkJUOMgx8fK4bdTPH9D4r/
        YlU/3DU0JcujWnLZKaHVuDMXvtWrGn0tiyLaXwGjf2Z+aRi00IhsEVT4KIW7BJSYx4jQCt
        vkPWOoUreZ2Hdkfm5fmIUOK2dQQ0MMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633960507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cdaihtqPpybIwx81AHyViScitJ8sjiNkjWydF9AYG5I=;
        b=yAeYmfUnaRoKF135rgDNX6G8lQzK7WdS5GZ9J5ua4GQSeF67qOAyoFykTLDPHL7fT1G+Df
        iuT9zYGBj0EZ4zAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15B1A13C5E;
        Mon, 11 Oct 2021 13:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3/zsATtCZGEOJQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 11 Oct 2021 13:55:07 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 1264b27b;
        Mon, 11 Oct 2021 13:55:06 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Zorro Lang <zlang@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] generic/095: don't use 1k blocksize for DIO operations
Date:   Mon, 11 Oct 2021 14:55:04 +0100
Message-Id: <20211011135504.23328-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test fails when using zram because it's using bs=1k for DIO in fio
jobs.  Fix the test by using _min_dio_alignment instead to get the correct
blocksize.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
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
