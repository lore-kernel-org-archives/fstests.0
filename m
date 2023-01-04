Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64748C4332F
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Jan 2023 04:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjADE3E (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Jan 2023 23:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjADE3D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Jan 2023 23:29:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB742FB
        for <fstests@vger.kernel.org>; Tue,  3 Jan 2023 20:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672806493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XxlRowQkgi4rg3cs7qGxpNLyzIUu01YB5lQScgGQgYI=;
        b=awXXbrsLMiDZrwPNiy84iE/24us8VKsmaVgnl8MNfMyh7xMVeppx5zrd9zxEw+ltp+DQNK
        DBA6TfBZes3/NXYJ7oktgPwG7k5uneiKuEwe6D4WyL1pK1oaTS8E6dLaQiR0+vtTwqsUs9
        ncmBQb5sHH7KJo6tL2c+jPmHXlFnoE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-pWPkHVFqMP6CQEFpKnOnXA-1; Tue, 03 Jan 2023 23:28:12 -0500
X-MC-Unique: pWPkHVFqMP6CQEFpKnOnXA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F094185A78B
        for <fstests@vger.kernel.org>; Wed,  4 Jan 2023 04:28:12 +0000 (UTC)
Received: from kvm100.rhts.eng.pek2.redhat.com (hp-dl388g8-01.rhts.eng.pek2.redhat.com [10.73.4.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC73849BB6A;
        Wed,  4 Jan 2023 04:28:10 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     lczerner@redhat.com, Boyang Xue <bxue@redhat.com>
Subject: [PATCH v1] src/stat_test.c: add STATX_DIOALIGN support
Date:   Wed,  4 Jan 2023 12:28:01 +0800
Message-Id: <20230104042801.217898-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
Hi,

The latest kernel has support for exposing direct I/O alignment
information via statx() by

825cf206ed51 statx: add direct I/O alignment information

I'm trying to enhance xfstests/src/stat_test.c to support this
functionality, and the final goal is enhancing generic/423 to test it.

I think I have made all the necessary change here, but it always prints
stx_dio_mem_align and stx_dio_offset_align as 0 (should be 512)

[root@localhost repo_xfstests-dev]# src/stat_test -v
../testfile stx_dio_offset_align=222
 - call statx ../testfile
 - call stat ../testfile
 - compare statx and stat
 - begin time 0.000000000
 -      btime 1672804449.041990601
 -      atime 1672804449.041990601
 -      mtime 1672804449.127990601
 -      ctime 1672804449.127990601
 - check stx_dio_offset_align=222
[!] stx_dio_offset_align differs, 0 != 222
Failed

 src/stat_test.c | 10 ++++++++++
 src/statx.h     | 10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

The kernel version in test is kernel-6.2.0-0.rc1.

Could you suggest how to fix it please?

Thanks,
Boyang

diff --git a/src/stat_test.c b/src/stat_test.c
index 95cfdc4f..cd38a54a 100644
--- a/src/stat_test.c
+++ b/src/stat_test.c
@@ -42,6 +42,8 @@ enum fields {
 	stx_ctime_tv_sec,
 	stx_dev_major,
 	stx_dev_minor,
+	stx_dio_mem_align,
+	stx_dio_offset_align,
 	stx_gid,
 	stx_ino,
 	stx_mask,
@@ -77,6 +79,8 @@ static const struct field field_list[nr__fields] = {
 	[stx_ctime_tv_sec]	= { "stx_ctime.tv_sec",		STATX_CTIME },
 	[stx_dev_major]		= { "stx_dev_major",		0 },
 	[stx_dev_minor]		= { "stx_dev_minor",		0 },
+	[stx_dio_mem_align]	= { "stx_dio_mem_align",	STATX_DIOALIGN },
+	[stx_dio_offset_align]	= { "stx_dio_offset_align",	STATX_DIOALIGN },
 	[stx_gid]		= { "stx_gid",			STATX_GID },
 	[stx_ino]		= { "stx_ino",			STATX_INO },
 	[stx_mask]		= { "stx_mask",			0 },
@@ -460,6 +464,8 @@ static void cmp_ref(const struct statx *stx, unsigned int mask)
 	cmp("%llu", stx_rdev_minor);
 	cmp("%llu", stx_dev_major);
 	cmp("%llu", stx_dev_minor);
+	cmp("%llu", stx_dio_mem_align);
+	cmp("%llu", stx_dio_offset_align);
 }
 
 /*
@@ -506,6 +512,8 @@ static void check_field(const struct statx *stx, char *arg)
 	case stx_rdev_minor:	uval = stx->stx_rdev_minor;	break;
 	case stx_dev_major:	uval = stx->stx_dev_major;	break;
 	case stx_dev_minor:	uval = stx->stx_dev_minor;	break;
+	case stx_dio_mem_align:	uval = stx->stx_dio_mem_align;	break;
+	case stx_dio_offset_align: uval = stx->stx_dio_offset_align; break;
 
 	case stx_atime_tv_sec:	sval = stx->stx_atime.tv_sec;	break;
 	case stx_atime_tv_nsec:	sval = stx->stx_atime.tv_nsec;	break;
@@ -569,6 +577,8 @@ static void check_field(const struct statx *stx, char *arg)
 		      "%s differs, %llu != %llu\n", key, uval, ucheck);
 		break;
 
+	case stx_dio_mem_align:
+	case stx_dio_offset_align:
 	case stx_atime_tv_sec:
 	case stx_atime_tv_nsec:
 	case stx_btime_tv_sec:
diff --git a/src/statx.h b/src/statx.h
index 3f239d79..116d1f43 100644
--- a/src/statx.h
+++ b/src/statx.h
@@ -114,7 +114,11 @@ struct statx {
 	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
 	__u32	stx_dev_minor;
 	/* 0x90 */
-	__u64	__spare2[14];	/* Spare space for future expansion */
+	__u64	stx_mnt_id;
+	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	/* 0xa0 */
+	__u64	__spare3[12];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -139,7 +143,9 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+#define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_ALL		0x00003fffU	/* All currently supported flags */
 
 /*
  * Attributes to be found in stx_attributes
-- 
2.27.0

