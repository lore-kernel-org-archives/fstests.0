Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F50BC07E9C
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 22:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D660C61CCA
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 22:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGGWfN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 18:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhGGWfN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 18:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625697152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRRZFLpYSWk02o0JYmc3xjsCE3cj48oddyx03lqdIe8=;
        b=eywhzX+Dl72LSXcTl8V0hY0X39P2LtfIGhSr7eeiOcTDjN0t+KKZFqPchAVBIaPwJfTldg
        DXV2JcKiI7bdWqrgnHDASKmCmjTj0cyC0uEGGBEmgWqvQvaYb0s8fhBVIJXAJ4N3Q1ikQ5
        B24CqYahHosWdzfGF58zzENIvfDiPZI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-kq8YcUf3PHuwpRWpRpuK9Q-1; Wed, 07 Jul 2021 18:32:31 -0400
X-MC-Unique: kq8YcUf3PHuwpRWpRpuK9Q-1
Received: by mail-ed1-f69.google.com with SMTP id e3-20020a0564020883b029039ef9536577so665420edy.5
        for <fstests@vger.kernel.org>; Wed, 07 Jul 2021 15:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRRZFLpYSWk02o0JYmc3xjsCE3cj48oddyx03lqdIe8=;
        b=PxYt1ULBlsX2yyNlKkIKRAdSWnpnyNdRV88RRKRBq+2UfU7mcvwF7F11EgoF5CvaJg
         Tlk2RbKfPlxv01RPCP50l5qDxe+ajouAgUoHs0DewGP3W+kRMvKclhC4U1uHcd/1wfat
         ZL0uvxauBmrwTnpPcDNNOID2rJEIUMCX4QjvDQmIP/g3ORJYjdRDhj9eLPo3ahem6cf6
         nAUvXw1NGEgFJNkrwL8afCrIuulIolVNzppQ5c6DEUV4bP9nRAFNiVpG/C7AkKdh2xKe
         S5ZdMJ6bj9p8fp5Fm8qCUGuNv7MCTRV/6uIyuMm5qNqbTd9ryHOXoRFO7UaBR20XG35f
         HhTw==
X-Gm-Message-State: AOAM531ysiCixwN87qDNvNuj0W8ELlXqjioE7G+U4pjZlW0SE+vZKJNO
        LkOFZhv7U1J38lBOH6fIm7E1vy+hCg9siNqsgqO4ppSf3kHiQdEVF0J7ffJf7NGo15G39nPgAWG
        p0VXgdirLauIuxjxwgai3sJ4Ei3nC3m2DPXVStkKq5k+nsQRjN7+VrQCY8w83p8FfEJ0H
X-Received: by 2002:a17:907:d24:: with SMTP id gn36mr26568915ejc.269.1625697149759;
        Wed, 07 Jul 2021 15:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfiaYcLtC0f/MqQ9rl0EqTkXKNoTV1Zb89PQ5OHL/1KcnUmqtnmpQr02cGY653vh0OuDbp9A==
X-Received: by 2002:a17:907:d24:: with SMTP id gn36mr26568903ejc.269.1625697149604;
        Wed, 07 Jul 2021 15:32:29 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id ze15sm54158ejb.79.2021.07.07.15.32.28
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 15:32:29 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 1/1] generic/{453,454}: Don't run for FSs restricting names
Date:   Thu,  8 Jul 2021 00:32:27 +0200
Message-Id: <20210707223227.32053-2-preichl@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707223227.32053-1-preichl@redhat.com>
References: <20210707223227.32053-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Running generic/{453,454} tests is probably only useful for filesystems
that allow unrestricted byte streams for names.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc         | 13 +++++++++++++
 tests/generic/453 |  1 +
 tests/generic/454 |  1 +
 3 files changed, 15 insertions(+)

diff --git a/common/rc b/common/rc
index d4ad421e..8ebe93c4 100644
--- a/common/rc
+++ b/common/rc
@@ -4599,6 +4599,19 @@ _require_od_endian_flag()
 		_notrun "od does not support endian flag"
 }
 
+# Skip this test unless the filesystem treats names (directory entries,
+# fs labels, and extended attribute names) as raw byte sequences.
+_require_names_are_bytes() {
+        case "$FSTYP" in
+        ext2|ext3|ext4|xfs|btrfs)
+		# do nothing
+	        ;;
+	*)
+                _notrun "$FSTYP does not allow unrestricted byte streams for names"
+		;;
+        esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/453 b/tests/generic/453
index 55ddcc01..a0fb802e 100755
--- a/tests/generic/453
+++ b/tests/generic/453
@@ -15,6 +15,7 @@ _begin_fstest auto quick dir
 # Import common functions.
 
 _require_scratch
+_require_names_are_bytes
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/454 b/tests/generic/454
index 3aefa9f0..133e2e9d 100755
--- a/tests/generic/454
+++ b/tests/generic/454
@@ -17,6 +17,7 @@ _begin_fstest auto quick attr
 
 _require_scratch
 _require_attrs
+_require_names_are_bytes
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
-- 
2.31.1

