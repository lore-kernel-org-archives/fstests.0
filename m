Return-Path: <SRS0=OTwx=EC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0C5C4363A
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Oct 2020 04:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6342158C
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Oct 2020 04:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnBvtEQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505398AbgJ0E1C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Oct 2020 00:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409065AbgJ0E1B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Oct 2020 00:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603772820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sc6o9Sulc1Dn4EsCF6JEdOYGAwXtTNdgwV8gmo2EvoQ=;
        b=hnBvtEQu2k9IRfMaiq8VX6csR/AB89DEnXlBeNOFJpr4EYmlNid0yvyWWUlEOo49Rzh1Es
        Q+zW7eCzMF12Tiln/p/X8TrlIqhgxD6Cw2KbOH0XdvQ6EL1TfB6lTICLiVzGL2yxkDedN6
        op6ss/ccddSqKFVP45O3iVX/DlTBhAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-OsPK7jfYNMibPvFfnBbHMA-1; Tue, 27 Oct 2020 00:26:57 -0400
X-MC-Unique: OsPK7jfYNMibPvFfnBbHMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3F80809DC9
        for <fstests@vger.kernel.org>; Tue, 27 Oct 2020 04:26:56 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0B785D9E4
        for <fstests@vger.kernel.org>; Tue, 27 Oct 2020 04:26:55 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/repair: filter unknown block state properly
Date:   Tue, 27 Oct 2020 12:26:52 +0800
Message-Id: <20201027042652.840821-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfsprogs 32e11be9 ("xfs_repair: complain about extents in unknown
state") changed the xfs_repair output format as below:

  - _("unknown block state, ag %d, block %d\n"),
  -         i, j);
  + _("unknown block state, ag %d, blocks %u-%u\n"),
  +         i, j, j + blen - 1);

It replaces "block" with "blocks". That cause xfs/030 fails. So use
proper regex to filter the 'old' and 'new' output format both.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/repair | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/repair b/common/repair
index 6668dd51..c8d16314 100644
--- a/common/repair
+++ b/common/repair
@@ -88,7 +88,7 @@ s/(stripe unit) \(.*\) (and width) \(.*\)/\1 (SU) \2 (SW)/;
 s/(superblock) (\d+)/\1 AGNO/;
 s/(AG \#)(\d+)/\1AGNO/;
 s/(reset bad sb for ag) (\d+)/\1 AGNO/;
-s/(unknown block state, ag )(\d+)(, block )(\d+)/\1AGNO\3AGBNO/;
+s/(unknown block state, ag )(\d+)(, blocks? )(\d+)/\1AGNO\3AGBNO/;
 /^Note - quota info will be regenerated on next quota mount.$/ && next;
 	print;'
 }
@@ -98,7 +98,7 @@ s/(unknown block state, ag )(\d+)(, block )(\d+)/\1AGNO\3AGBNO/;
 # tree and fails to reconcile the metadata reverse mappings against the
 # metadata).
 _filter_repair_lostblocks() {
-	_filter_repair | sed -e '/unknown block state, ag AGNO, block AGBNO/d'
+	_filter_repair | sed -e '/unknown block state, ag AGNO, blocks* AGBNO/d'
 }
 
 _filter_dd()
-- 
2.25.4

