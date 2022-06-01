Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9ADC433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 06:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbiFAGho (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349922AbiFAGhn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 02:37:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2B64DF43
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 23:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A126CCE091C
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FFBC3411D
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654065459;
        bh=ZRxqf9MbgJ/uu26QR2ewrq8aG8GLNaFm1RufNitv0Js=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oTYNFORRwo+/94n1wGDX1ADJYn8PR0jiLuh3kvbbC1gCEaQaq7+nHcyxMueN0P686
         hKaIrgUuSxCmZGthsafc4V/cxAoxtVctY94n5roLPzSC8cT9QZ91oTjCCtrBM+P4cu
         3pp50o2mDkyZ+qUUyAz6r72HATPp1B2H6QeOT+AGkOhH7q6mVBpFJ1azPmriOvRnBU
         VRgRmePF3n02CGj1rVG2OuhIwbP1OLxejXDtPDrRn4YiH1DngrWTmyhyTIYItRhQsD
         5noSB7JeS8ZW46qpMCpM+2o0JUt1U8nRvHkI9eJsWJIJX74PTipXZGKcmTBLaqz3ND
         EjeJEIHYUeLbQ==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 5/5] gitignore: ignore missed binary files in src
Date:   Wed,  1 Jun 2022 14:37:30 +0800
Message-Id: <20220601063730.1726879-6-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220601063730.1726879-1-zlang@kernel.org>
References: <20220601063730.1726879-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add  src/dmiperf and src/t_locks_execve into .gitignore file

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 88c79412..24bde45c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@ tags
 /src/dirhash_collide
 /src/dirperf
 /src/dirstress
+/src/dmiperf
 /src/e4compact
 /src/ext4_resize
 /src/fault
@@ -146,6 +147,7 @@ tags
 /src/t_getcwd
 /src/t_holes
 /src/t_immutable
+/src/t_locks_execve
 /src/t_mmap_collision
 /src/t_mmap_cow_race
 /src/t_mmap_dio
-- 
2.31.1

