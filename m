Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112CEC7618E
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Apr 2023 17:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjDURvo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Apr 2023 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjDURvn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Apr 2023 13:51:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86B51BFC
        for <fstests@vger.kernel.org>; Fri, 21 Apr 2023 10:51:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a52667955dso27454425ad.1
        for <fstests@vger.kernel.org>; Fri, 21 Apr 2023 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682099502; x=1684691502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czIRl6ljANoU8G0/qdjvDBlnmoa2E+vYYk963SUDCMc=;
        b=WuuIF1ufn4zv63pAMe2lSINo19Kq1QtVi1s0643qeYkFMsJ5ljDiEV89UNyaNvOgNa
         afFgwcgrIk6I2yF2L6TyLGkKHfx0TwC/ci67p2bM0aEpWrsrhRPdjRBHuj4JyVB9sL1x
         WgRyARyJgGylhcBtYOrdeEybsZfVth33yITLvheryw0JJSfiKnjufjXI1TPcCKJ27YjA
         SUpP3YdBtcldcfnQ9bFSAvfoLGhXWjoPj1RFEJNUiHMntygu/AqHYX3piXT2kYTBkvvg
         QeYdovPs/Ehbde97TJKiZeMer2MV/qaS+BbKE7Tysy58gfjHnWqEo0tnznnZz6pzRrtl
         IR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682099502; x=1684691502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czIRl6ljANoU8G0/qdjvDBlnmoa2E+vYYk963SUDCMc=;
        b=FE1Sy+8UO2Zy2IVWqg+bWOMaSeKu/UNkZXHDOUJDWen9WorIDp1dYo3E59rguo9ef7
         WLlG9PjHj2SJTzU6IxIwd/TBs6aVtZDJ4xzkoViqvRf9wEzVuZBmEkkfHzrSvKWKmbtq
         ixtJk9WoQRvyzFxG+nHclKV9aCksg3Md7u1eHbgEi/uKXKMnI8GEczwmC3LyCjl32PJv
         iVKvYNCKZWX1waWAFuL/wZjJNwnc98liwUJvVBmeKbKlGhCKlAUWA67YLQw+MNr6xbYP
         dKd3wpKFhq4gL5XExqvYvIDsXIV/iGxk/FSO+C9v81ZurRgarOQjOd/iTUEbthu8cCf2
         Izag==
X-Gm-Message-State: AAQBX9f1xydS0pQnvn0fKvCgnQZFgF9I7Tgom31YCgGhbOfx4YXNRw45
        egZvmcW/aTV0yBDPoRX4OGDa0hT5loQ=
X-Google-Smtp-Source: AKy350bahqYkyJ4RvmBCyfTKHTcl+/M3tJfVLJPi6sWKTpXH+EYQMXVnintzZ8ARA6weT2ya2eZhhw==
X-Received: by 2002:a17:902:d54f:b0:1a2:96d6:7d8 with SMTP id z15-20020a170902d54f00b001a296d607d8mr6719567plf.28.1682099502086;
        Fri, 21 Apr 2023 10:51:42 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:fda6:981:889:c7cc])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a950300b0024796ddd19bsm4798228pjo.7.2023.04.21.10.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:51:41 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, djwong@kernel.org,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v2 2/2] check: _check_filesystems for errors even if test failed
Date:   Fri, 21 Apr 2023 10:51:32 -0700
Message-ID: <20230421175132.3596583-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230421175132.3596583-1-leah.rumancik@gmail.com>
References: <20230421175132.3596583-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Previously, we would only run _check_filesystems to ensure that a test
that appeared to pass did not have any filesystem corruption. However,
in _check_filesystems, we also repair any errors found in the filesystem.
Let's do this even if we already know the test failed so that subsequent
tests aren't affected.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 check | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check b/check
index befbf465..c18f02ca 100755
--- a/check
+++ b/check
@@ -972,6 +972,7 @@ function run_section()
 			# Even though we failed, there may be something interesting in
 			# dmesg which can help debugging.
 			_check_dmesg
+			(_adjust_oom_score 250; _check_filesystems)
 			tc_status="fail"
 		else
 			# The test apparently passed, so check for corruption
-- 
2.40.0.634.g4ca3ef3211-goog

