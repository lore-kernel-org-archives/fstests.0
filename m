Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA093C7EE24
	for <linux-fstests@archiver.kernel.org>; Tue, 16 May 2023 08:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjEPIUN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 May 2023 04:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjEPIUB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2023 04:20:01 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B24EC7
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 01:19:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7577ef2fa31so172305785a.0
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684225192; x=1686817192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cO6T1Wv8usBM7/YcqTe9DBdckDGolxnLnC7tDKodmGY=;
        b=XgY9UTQWbFA4/gfUa48fE9kVyHEUDHQR3iFG7NcDi5AinUn+JpQjcZRQoHFIqxuiNG
         7XXd7e/3nm4fmovrh6hcWWECwzIU8tOhnTa9pJkk5IMAM1HiyIkfkaRGmIwba/pbIAjV
         mTq71AX5z2QWsOknLjpKadM7d62plrR4Jonh4Q801kL3yf8v/OYHvpMxVIF0eFxqlk1a
         35FtmnprB0j6Hc1Nq6QjsOKeb8zUUlycsV/IRq8ye/DHjYX8rfB6zRqmIWF75hTw70Dt
         p9bjPOn8dljahIz6/jUduXSv5nRGTS/XErkUOloF9pOHGArdYhpH8aaURWI8Yc4aCR2H
         cEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225192; x=1686817192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cO6T1Wv8usBM7/YcqTe9DBdckDGolxnLnC7tDKodmGY=;
        b=Ot6ZGlsQrRRZjYuewJKmhk9jH44JSLJ9ZKt12fCR+wuW9NaaOHod0HszastLSyJgPP
         fdFqLIHcFqBKkJLlhHw6nfxO0fOolRgOGyP4lKG6CgQJBsALofpOXkIkBm9jSX5Nv8yI
         YyxJkyAhS0pgj1c1TSyZE+Y8ReCnVxRRUGR51BUpYGBh3eZsMA7cz3PmZ73aM7ZswZhI
         M9WwIuqiAfgiskJIUO6yqrfP8PX4zet5VhYzw5O3SPfQgxqLrx14NsjnrwClc9AIBS4h
         dvSEEmE/I2VR8rkWQwPCBOcdqhk4fX0vXeEpEoXrAKWi+mVKdwLeDm9V0taDw3V4nNOY
         YS5w==
X-Gm-Message-State: AC+VfDyCaC0MEuevahQuMwqaKxDFCfcfrZac3uKb4hX2NCPnr2PquACq
        C6wajajpAbwPFXyYxoszRklOlNJZiws=
X-Google-Smtp-Source: ACHHUZ7FF01/sFDEDFsCX5Y12IQy7RK1zbfGc/4geV3SG/5o1Eo2ZQIyQF7OuDY3kokGa98B/UQhig==
X-Received: by 2002:a05:6214:20e1:b0:5ef:5be2:f6d0 with SMTP id 1-20020a05621420e100b005ef5be2f6d0mr69467169qvk.6.1684225192479;
        Tue, 16 May 2023 01:19:52 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
        by smtp.gmail.com with ESMTPSA id f8-20020a0cf3c8000000b0061b67ae2ff9sm5479626qvm.121.2023.05.16.01.19.52
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:19:52 -0700 (PDT)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/{filter,quota}, xfs/1{06,52}: fix grep pattern
Date:   Tue, 16 May 2023 16:19:35 +0800
Message-Id: <20230516081935.2208793-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Newer(3.9) grep is complaining about these unnecessary
backslashes before # and -, and breaking the golden output.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 common/filter | 2 +-
 common/quota  | 2 +-
 tests/xfs/106 | 4 ++--
 tests/xfs/152 | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/filter b/common/filter
index 3e3fea7e..f10ba78a 100644
--- a/common/filter
+++ b/common/filter
@@ -293,7 +293,7 @@ _filter_project_quota()
 	# until the GETNEXTQUOTA ioctl came into use.  Filter it out.
 	# But if you specify a name for ID 0, that means you want to
 	# deal with it by yourself, this function won't filter it out.
-	_filter_quota | grep -v "^\#0 \|^(null) "
+	_filter_quota | grep -v "^#0 \|^(null) "
 }
 
 # Account for different "ln" failure messages
diff --git a/common/quota b/common/quota
index 96b8d044..0a526e07 100644
--- a/common/quota
+++ b/common/quota
@@ -191,7 +191,7 @@ _scratch_enable_pquota()
 _require_setquota_project()
 {
 	setquota --help 2>&1 | \
-		grep -q "\-P, \-\-project[[:space:]]*set limits for project"
+		grep -q "\-P, \--project[[:space:]]*set limits for project"
 	if [ "$?" -ne 0 ];then
 		_notrun "setquota doesn't support project quota (-P)"
 	fi
diff --git a/tests/xfs/106 b/tests/xfs/106
index fc2281af..388873bd 100755
--- a/tests/xfs/106
+++ b/tests/xfs/106
@@ -59,13 +59,13 @@ clean_files()
 
 filter_quot()
 {
-	_filter_quota | grep -v "root \|\#0 " \
+	_filter_quota | grep -v "root \|#0 " \
 		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
 }
 
 filter_report()
 {
-	_filter_quota | grep -v "^root \|^\#0 " \
+	_filter_quota | grep -v "^root \|^#0 " \
 		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
 }
 
diff --git a/tests/xfs/152 b/tests/xfs/152
index dd33801d..325a05c1 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -98,13 +98,13 @@ clean_files()
 
 filter_quot()
 {
-	_filter_quota | grep -v "root \|\#0 " \
+	_filter_quota | grep -v "root \|#0 " \
 		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
 }
 
 filter_report()
 {
-	_filter_quota | grep -v "^root \|^\#0 " \
+	_filter_quota | grep -v "^root \|^#0 " \
 		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
 }
 
-- 
2.31.1

