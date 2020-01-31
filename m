Return-Path: <SRS0=v13d=3U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD8C2D0DB
	for <linux-fstests@archiver.kernel.org>; Fri, 31 Jan 2020 21:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22102214D8
	for <linux-fstests@archiver.kernel.org>; Fri, 31 Jan 2020 21:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAaVWu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:22:50 -0500
Received: from trent.utfs.org ([94.185.90.103]:45012 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgAaVWu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 31 Jan 2020 16:22:50 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 242A55F9CA
        for <fstests@vger.kernel.org>; Fri, 31 Jan 2020 22:22:49 +0100 (CET)
Date:   Fri, 31 Jan 2020 13:22:49 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     fstests@vger.kernel.org
Subject: README: fsgqa needs a home directory too
Message-ID: <alpine.DEB.2.22.395.2001311318390.2831@trent.utfs.org>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

generic/128 whould fail with:

     QA output created by 128
    +su: warning: cannot change directory to /home/fsgqa: No such file or directory

Adjust README to create a home directory too. And (totally unrelated), 
fix the 404 for the udf_test tool.

Signed-off-by: Christian Kujau <lists@nerdbynature.de>

--- README.orig	2020-01-12 08:43:34.000000000 -0800
+++ README	2020-01-31 13:18:12.494026480 -0800
@@ -19,7 +19,7 @@
 	(Note that for RHEL and CentOS, you may need the EPEL repo.)
 - run make
 - run make install
-- create fsgqa test user ("sudo useradd fsgqa")
+- create fsgqa test user ("sudo useradd -m fsgqa")
 - create fsgqa group ("sudo groupadd fsgqa")
 - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
 
@@ -33,7 +33,7 @@
     - install administrative tools specific to the filesystem you wish to test
     - If you wish to run the udf components of the suite install
       mkudffs. Also download and build the Philips UDF Verification Software
-      from http://www.extra.research.philips.com/udf/, then copy the udf_test
+      from https://www.lscdweb.com/registered/udf_verifier.html, then copy the udf_test
       binary to xfstests/src/. If you wish to disable UDF verification test
       set the environment variable DISABLE_UDF_TEST to 1.
 

-- 
BOFH excuse #220:

Someone thought The Big Red Button was a light switch.
