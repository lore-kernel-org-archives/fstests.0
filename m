Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC86C433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Nov 2021 15:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBAF60F58
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Nov 2021 15:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhKBPbO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233684AbhKBPbN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Nov 2021 11:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635866918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBj8e0bM4t5jzjI5MjwhBPSaYeww5szB2LUvOQn8dio=;
        b=g4BHUD4zrH02q8g6w+FD4/YT14yZv30cQ+u0ZEK8JKBUZlFsa4SRk7DktZMcQFen0EoTQR
        Az0yZqJYB0lVQu94YA38XKSwAsUsn+yxCPueKoFSktjzFmab78Z2sV2kdXZIZ8frpLKrDt
        BVPGkxc4Tx+6LviNs0WuMg/GWRNsuic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-SJBRo8FpPl-2_ZnOnzaeig-1; Tue, 02 Nov 2021 11:28:37 -0400
X-MC-Unique: SJBRo8FpPl-2_ZnOnzaeig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 322A21923762
        for <fstests@vger.kernel.org>; Tue,  2 Nov 2021 15:28:36 +0000 (UTC)
Received: from andromeda.lan (unknown [10.40.193.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC3A7092D
        for <fstests@vger.kernel.org>; Tue,  2 Nov 2021 15:28:35 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/2] common/rc: Enable _format_swapfile to return the swap size
Date:   Tue,  2 Nov 2021 16:28:27 +0100
Message-Id: <20211102152828.26895-2-cmaiolino@redhat.com>
In-Reply-To: <20211102152828.26895-1-cmaiolino@redhat.com>
References: <20211102152828.26895-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Once the kernel is free to not map the full swap file during a swapon call,
it can be useful to know the exact size of the swap area created during
_format_swapfile().

To achieve this, it is required to change _require_scratch_swapfile(), to drop
the _format_swapfile() return value, otherwise, it will also have a return value
that will end up in tests outputs causing tests to fail.

Tests using _format_swapfile() that do not require the swap file size do not
need to be modified, as the return value will be simply ignored.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 common/rc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 7f693d39..fb1f32e0 100644
--- a/common/rc
+++ b/common/rc
@@ -2587,6 +2587,7 @@ _require_odirect()
 _format_swapfile() {
 	local fname="$1"
 	local sz="$2"
+	local swap_log=""
 
 	rm -f "$fname"
 	touch "$fname"
@@ -2595,8 +2596,11 @@ _format_swapfile() {
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
 	# Ignore permission complaints on filesystems that don't support perms
-	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | \
-		grep -v "insecure permission"
+	swap_log=$($MKSWAP_PROG "$fname" 2>&1 | grep -v "insecure permission")
+	echo $swap_log >> $seqres.full
+
+	# return created swap size
+	echo $swap_log | grep -oP '(?<=size = )\w+'
 }
 
 _swapon_file() {
@@ -2628,7 +2632,7 @@ _require_scratch_swapfile()
 	_scratch_mount
 
 	# Minimum size for mkswap is 10 pages
-	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
 
 	# ext* has supported all variants of swap files since their
 	# introduction, so swapon should not fail.
-- 
2.31.1

