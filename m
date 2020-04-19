Return-Path: <SRS0=TcRL=6D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18C0C38A30
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Apr 2020 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE95F21974
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Apr 2020 10:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkZecsED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDSKtq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Apr 2020 06:49:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51292 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgDSKtq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Apr 2020 06:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587293385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O7gAonBU3evhymFwQer16GSnsrGRuvcDgRvPDZH/Hc4=;
        b=BkZecsEDS0ao8x8IFHSAoXoaOCDAvrW8ARg9EvWaMYH5oue3lFmGgBR4x1jn/u23qflpMA
        WOtTveCMrPrE5YgI2JqIJG74iyq4UtVBblbJ45SyndTi8f2hbD10fCIiTqQTy8UUDYgyJr
        y89bZgval/7fIiitLRBGM2JD3iUKrM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-QLjKK4cjOEC-J27WNjDjRw-1; Sun, 19 Apr 2020 06:49:43 -0400
X-MC-Unique: QLjKK4cjOEC-J27WNjDjRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 283FD8017F5
        for <fstests@vger.kernel.org>; Sun, 19 Apr 2020 10:49:42 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EACC12974A
        for <fstests@vger.kernel.org>; Sun, 19 Apr 2020 10:49:40 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/594: require setquota tool supports project quota
Date:   Sun, 19 Apr 2020 18:49:36 +0800
Message-Id: <20200419104936.30095-1-zlang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The old setquota tool doesn't support project quota, it doesn't has
"-P, --project" option. So _notrun the test to avoid a failure.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/quota      | 9 +++++++++
 tests/generic/594 | 1 +
 2 files changed, 10 insertions(+)

diff --git a/common/quota b/common/quota
index 4e07fef1..240e0bbc 100644
--- a/common/quota
+++ b/common/quota
@@ -124,6 +124,15 @@ _scratch_enable_pquota()
 	esac
 }
=20
+_require_setquota_project()
+{
+	setquota --help 2>&1 | \
+		grep -q "\-P, \-\-project[[:space:]]*set limits for project"
+	if [ "$?" -ne 0 ];then
+		_notrun "setquota doesn't support project quota (-P)"
+	fi
+}
+
 #
 # checks for user nobody in /etc/passwd and /etc/group.
 #
diff --git a/tests/generic/594 b/tests/generic/594
index e501d54c..2665e5b4 100755
--- a/tests/generic/594
+++ b/tests/generic/594
@@ -34,6 +34,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_setquota_project
 # V4 XFS doesn't support to mount project and group quota together
 if [ "$FSTYP" =3D "xfs" ];then
 	_require_scratch_xfs_crc
--=20
2.20.1

