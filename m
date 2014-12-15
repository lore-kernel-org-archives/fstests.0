Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:62726 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaLOU0I (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 15:26:08 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so10334258wiv.8
        for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 12:26:05 -0800 (PST)
Received: from [192.168.0.2] (178-222-112-234.dynamic.isp.telekom.rs. [178.222.112.234])
        by mx.google.com with ESMTPSA id ex8sm14286931wjd.41.2014.12.15.12.26.04
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2014 12:26:04 -0800 (PST)
Date: Mon, 15 Dec 2014 23:26:35 +0100 (CET)
From: Dushan Tcholich <dusanc@gmail.com>
Subject: [PATCH] generic/038: require fallocate support and test for trim
 support
Message-ID: <alpine.LNX.2.00.1412152322070.21847@reiser4.gekom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add tests for allocate support and test if TRIM really works on tested 
partition.

Signed-off-by: Dushan Tcholich <dusanc@gmail.com>

--- xfstests.orig/tests/generic/038	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/038	2014-12-15 23:21:11.000000000 +0100
@@ -70,6 +70,10 @@
 _supported_os Linux
 _require_scratch
 _require_fstrim
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "truncate"
+
+_test_batched_discard $SCRATCH_MNT || _notrun "FITRIM not supported on $SCRATCH_DEV"
 
 rm -f $seqres.full
 
