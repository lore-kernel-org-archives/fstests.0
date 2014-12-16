Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:50544 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaLOXEz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 18:04:55 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so10737958wiv.2
        for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 15:04:54 -0800 (PST)
Received: from [192.168.0.2] (178-222-112-234.dynamic.isp.telekom.rs. [178.222.112.234])
        by mx.google.com with ESMTPSA id e7sm14677899wjx.31.2014.12.15.15.04.53
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2014 15:04:54 -0800 (PST)
Date: Tue, 16 Dec 2014 02:05:23 +0100 (CET)
From: Dushan Tcholich <dusanc@gmail.com>
Subject: [PATCH v2]generic/038: require fallocate support
Message-ID: <alpine.LNX.2.00.1412160201390.862@reiser4.gekom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add test for fallocate(2) support

Signed-off-by: Dushan Tcholich <dusanc@gmail.com>

--- xfstests.orig/tests/generic/038	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/038	2014-12-15 23:21:11.000000000 +0100
@@ -70,6 +70,7 @@
 _supported_os Linux
 _require_scratch
 _require_fstrim
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
