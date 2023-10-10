Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29595CD690E
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Oct 2023 20:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjJJU0o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjJJU0Z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Oct 2023 16:26:25 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B5ADE
        for <fstests@vger.kernel.org>; Tue, 10 Oct 2023 13:26:22 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7be88e9ccso14394287b3.2
        for <fstests@vger.kernel.org>; Tue, 10 Oct 2023 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969581; x=1697574381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEBkTHJ3Zcu/2KG+vVGPEkATD7sMt03VYNJu8yvTP9M=;
        b=SN3aOlddxcqgvMSGkQYM9YW3biqn9ZY2bGhhhSwZHovLYv3+H7VLvPrtEXVA+73MyZ
         j+N0RB1qVFxXODgeGnO9GoA79kWnrQqX//uc6CZ/MXuilIOVwRvVUIE6RDyzcKjN+WF6
         RyfB1SoUG6FkEPtVtSJ1cLdRpH5DoB54aNZkM82HZCvzEJoS9pvQH8jvs0DjhxZrcjvT
         xks8pRcEaIWfV9EomLx5+eSZYz13vaagV9MY4xgdvFpzCJV1ei5oL4+euF9BlacA2BFi
         qr4JyIWgEtlJ/zjB8ec9NjI8MzYQrkLQ9zRGNdYBa3g7qMWgFyqDPBnvjpojxDbcy2GT
         yqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969581; x=1697574381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEBkTHJ3Zcu/2KG+vVGPEkATD7sMt03VYNJu8yvTP9M=;
        b=YDsi4zNCcybQw13MjIG7zsv4lMfhGomBMkZcvwY+ufhX3fo4YCkgtifycWLaL40Gx7
         Movg/E2jh8tZMLv5McQDs8D+5SiSeHXs3I+MYIsGqsaj6stNLSGs2LJFuFQ3qlv+253i
         QlXJqOyHHRx+Zbowx2NSQDGPncIT6eaNoV7SwaUmEXFtOC5hfayc+uB07I/GWewMGhls
         ikv/pgiK10JljU2TkWiov59n7eCAmNnv4qfJDm/AQwBg3LiB28aXfJjdsiYdU/b46P5u
         W94Y4mbNhCqNLyu+IiBF6Fb7ypgbiwTIzA3wJ0FpT3Ljfo0u4BsZJREBKJAgexMbQQv0
         d8dg==
X-Gm-Message-State: AOJu0Yz55r7bAg610KstgnsQ6j38hX0//Z7lTnQ54NE4ji1IkjUDlWIP
        iDRzq0z6wVT2OUf0cuJz7oPtw7qmbjx0qJ/fU9m92Q==
X-Google-Smtp-Source: AGHT+IEDJXaz8Iqj0J5QGmoE8YAQkrqbJnp7d+TIBuszlRdRr5jTsnA0UfmfaKbLhaXI1gnZsLNkDg==
X-Received: by 2002:a81:48cc:0:b0:5a7:baac:7b34 with SMTP id v195-20020a8148cc000000b005a7baac7b34mr3793507ywa.28.1696969581386;
        Tue, 10 Oct 2023 13:26:21 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x9-20020a814a09000000b00589b653b7adsm4691241ywa.136.2023.10.10.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:26:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 03/12] common/encrypt: add btrfs to get_ciphertext_filename
Date:   Tue, 10 Oct 2023 16:25:56 -0400
Message-ID: <b568ed0fa6b5a94c38dc1a08d07f4e289bf9d75f.1696969376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969376.git.josef@toxicpanda.com>
References: <cover.1696969376.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Add the relevant call to get an encrypted filename from btrfs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 common/encrypt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index fc1c8cc7..2c1925da 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -618,6 +618,19 @@ _get_ciphertext_filename()
 	local dir_inode=$3
 
 	case $FSTYP in
+	btrfs)
+		# Extract the filename from the inode_ref object, similar to:
+		# item 24 key (259 INODE_REF 257) itemoff 14826 itemsize 26
+		# 	index 3 namelen 16 name: J\xf7\x15tD\x8eL\xae/\x98\x9f\x09\xc1\xb6\x09>
+		#
+		$BTRFS_UTIL_PROG inspect-internal dump-tree $device | \
+			grep -A 1 "key ($inode INODE_REF " | tail -n 1 | \
+			perl -ne '
+				s/.*?name: //;
+				chomp;
+				s/\\x([[:xdigit:]]{2})/chr hex $1/eg;
+				print;'
+		;;
 	ext4)
 		# Extract the filename from the debugfs output line like:
 		#
@@ -715,6 +728,9 @@ _require_get_ciphertext_filename_support()
 			_notrun "dump.f2fs (f2fs-tools) is too old; doesn't support showing unambiguous on-disk filenames"
 		fi
 		;;
+	btrfs)
+		_require_command "$BTRFS_UTIL_PROG" btrfs
+		;;
 	*)
 		_notrun "_get_ciphertext_filename() isn't implemented on $FSTYP"
 		;;
-- 
2.41.0

