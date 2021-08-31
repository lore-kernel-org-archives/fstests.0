Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A55C4320A
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 03:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D269D6101C
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 03:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhHaDFa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Aug 2021 23:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235848AbhHaDF0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Aug 2021 23:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630379071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YOhpUst5i4lmv9QrTjeZKIIWMqyv1QWHL4pnHL3xWxQ=;
        b=YUTZjpmwGP6PTwurnkr0DsQ0QUl8oK7/OKKZt1fEuSfSGECb4MSRkzupP/Y8rYfDCJS6+E
        INQ/szEMpOjrjmFb8E7OogyzKz+KLbnwCLiCTqROMBt4TGdsw1rl2HwnipB/Vw2cqVBWUt
        bTVIdpxlQXoSce9vfEsrjFV3YfONHZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-Iie9B8cWNv2xPW_SUzhU9g-1; Mon, 30 Aug 2021 23:04:29 -0400
X-MC-Unique: Iie9B8cWNv2xPW_SUzhU9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D627801AA6;
        Tue, 31 Aug 2021 03:04:28 +0000 (UTC)
Received: from localhost (unknown [10.66.61.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B5B35DA2D;
        Tue, 31 Aug 2021 03:04:27 +0000 (UTC)
Date:   Tue, 31 Aug 2021 11:04:26 +0800
From:   Murphy Zhou <xzhou@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] common/rc: fix MKSWAP_PROG quoting
Message-ID: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After commit
  0e4dd8b9 common/rc: fix ignoring of errors on
we are getting this error message when running swapfiles tests:
  +./common/rc: line 2553: MKSWAP_PROG: command not found

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 46b6b220..0597de13 100644
--- a/common/rc
+++ b/common/rc
@@ -2550,7 +2550,7 @@ _format_swapfile() {
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
 	# Ignore permission complaints on filesystems that don't support perms
-	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
+	($MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
 }
 
 _swapon_file() {
-- 
2.20.1

