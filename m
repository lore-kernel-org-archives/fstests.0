Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78CCC6FA8E
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 07:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiITHfb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiITHf2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 03:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E734363E
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 00:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663659321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ROG6zDzBdZQ9xVvixAr5ZnYEnnC9aC970wNETqK2Dk=;
        b=IXCxQ2zPbdq+2xzp08h4KCU6/m+mcJ71LQtJqm/CGKGdqPejWwoLdfj3P7LejNt9LQFB8g
        SqspZmPEZMLvsvvmt6CrfF8PSJRZ39zXz+p8avvfMCmjF/3yzsiXyVqdeDtNAJ4EU3s5cW
        MmsQiE2nY9fteFweAryaQBxooEu/NEk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-Lw0II4tsOkWq-hY9_rRbBA-1; Tue, 20 Sep 2022 03:35:20 -0400
X-MC-Unique: Lw0II4tsOkWq-hY9_rRbBA-1
Received: by mail-ed1-f72.google.com with SMTP id z16-20020a05640235d000b0045485e4a5e0so230711edc.1
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 00:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+ROG6zDzBdZQ9xVvixAr5ZnYEnnC9aC970wNETqK2Dk=;
        b=qkMX1hWmE2cmwI7u4vul+XL5bvcDkUJp30ntMGwnl8yfTlcP91Uq1MUx6wT5j5AgTW
         BSz184bLSruxhmVCWcrzpSfdWJEMZUsHVKAALp02TeSuRRtdtGnJ1AI+Er0NahZoYwYw
         KioH+nfhzQql/L3deHZa8Hr9kVTQe+Aej+F/I/flFEBv+9cfuoyw945CAJIDeI3hDpcK
         f2gclLMox09bUM3KM7ULpC0TSLObJYIUvA4E9eTEuYSA04sFB1HLP4Kiu/aSz/6yZUln
         nIyaSt3W7NatqSMBBY3z3U5QF9TfMMAhhymEoj9DjfoBoOW+8smHKGcY9YyjU5z1N1sG
         6MsQ==
X-Gm-Message-State: ACrzQf01Rkg9HSvOesrSyBelPh44pyml5QRzvOxTnTGCF5GzaBf+S9WS
        GLYK+wW/dwjYZfX6RBKVZD6HlEXpGTQ1BZoJGNXK/XywNYz98yApOcWsoMcp1SxAAa+O5NTxVBA
        l+lkBvU/AqmqNDes6HAw19OYILx6WVnTqfW0ickY3kKXx9SN/WwF8JKz7MX+Mpy3+edMj
X-Received: by 2002:a17:907:7b87:b0:781:83bd:cae5 with SMTP id ne7-20020a1709077b8700b0078183bdcae5mr4041451ejc.456.1663659318729;
        Tue, 20 Sep 2022 00:35:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4S2pEyheJXGSDe9RwymicgtZj8XqA6m3G7G1nKZWtsCJ8Dqb9dK6la9y+wecQ6HEyaUfWT8A==
X-Received: by 2002:a17:907:7b87:b0:781:83bd:cae5 with SMTP id ne7-20020a1709077b8700b0078183bdcae5mr4041433ejc.456.1663659318469;
        Tue, 20 Sep 2022 00:35:18 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id y8-20020a50e608000000b0043d1eff72b3sm733479edm.74.2022.09.20.00.35.16
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 00:35:17 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 1/2] common: new helper to alloacate fixed size files
Date:   Tue, 20 Sep 2022 09:35:13 +0200
Message-Id: <20220920073514.285136-2-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920073514.285136-1-preichl@redhat.com>
References: <20220920073514.285136-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Helper that creates files of specified size using falloc if supported,
otherwise pwrite is used.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc         | 13 +++++++++++++
 tests/generic/694 |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a25cbcd0..77866582 100644
--- a/common/rc
+++ b/common/rc
@@ -4925,6 +4925,19 @@ hexdump()
 	_fail "Use _hexdump(), please!"
 }
 
+# Helper to write a file containing specified number of bytes using
+# falloc if supported, otherwise use pwrite
+_create_sizedfile()
+{
+	length=$1
+	file=$2
+
+	$XFS_IO_PROG -F -fc "falloc 0 $length" $file 2>&1 | grep -q "Operation not supported"
+	if [ $? -eq 0 ]; then
+		$XFS_IO_PROG -F -fc "pwrite -W 0 $length" $file >/dev/null
+	fi
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/694 b/tests/generic/694
index dfd988df..64c3dd9a 100755
--- a/tests/generic/694
+++ b/tests/generic/694
@@ -30,7 +30,7 @@ junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/junk
 mkdir -p $junk_dir
 
-$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
+_create_sizedfile 4G $junk_file
 
 iblocks=`stat -c '%b' $junk_file`
 
-- 
2.37.3

