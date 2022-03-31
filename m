Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26FC43219
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 11:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiCaLVQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiCaLVP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 07:21:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8BD17C428
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:19:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E6C5721A99;
        Thu, 31 Mar 2022 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648725565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHilrtiP3ew4hEh1Z/Dr9wuW39bkY41j9GgjySO2QNc=;
        b=ygoxpFYnxbA0kYJg5/czAleY/mVu6QhO9coMBbXRX1h/5abgtnsSIXoemaUMJnFNrb8QwI
        jmtFB38G8uQ+u9ZGLpk8EkHJfX2FvJkGQ/w3yVgcNg+hzHhXu8cNbFkQE6FRIwtWk5kk0U
        0zUIOO+R3TRilHDPbr562DUdCvGqA7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648725565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHilrtiP3ew4hEh1Z/Dr9wuW39bkY41j9GgjySO2QNc=;
        b=sDNND+m95Yh2d1js7jwLmCj5bRa6H8Z5pJdf4pMaKsnxJvprypM44xSVnkwW/OQrWCtzyW
        vnDM0c/58EYbYVAg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CEF9DA3B89;
        Thu, 31 Mar 2022 11:19:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8845AA0615; Thu, 31 Mar 2022 13:19:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] idmapped_mounts: Prepare for support for more features
Date:   Thu, 31 Mar 2022 13:19:19 +0200
Message-Id: <20220331111920.8377-2-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220331111920.8377-1-jack@suse.cz>
References: <20220331111920.8377-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently idmapped_mounts tests fail for kernels without CONFIG_USER_NS
because some tests are run despite missing support for idmapped mounts
and they implicitely require user namespace support. Prepare
idmapped_mounts to support more features a test may require to reliably
run.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/idmapped-mounts/idmapped-mounts.c | 102 +++++++++++++-------------
 1 file changed, 53 insertions(+), 49 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 4cf6c3bb2a25..d3b27da6c085 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -13829,60 +13829,63 @@ static const struct option longopts[] = {
 	{NULL,					0,			0,	  0},
 };
 
+/* Flags for which functionality is required by the test */
+#define T_REQUIRE_IDMAPPED_MOUNTS (1U << 0)
+
 struct t_idmapped_mounts {
 	int (*test)(void);
-	bool require_fs_allow_idmap;
+	unsigned int support_flags;
 	const char *description;
 } basic_suite[] = {
-	{ acls,								true,	"posix acls on regular mounts",									},
-	{ create_in_userns,						true,	"create operations in user namespace",								},
-	{ device_node_in_userns,					true,	"device node in user namespace",								},
-	{ expected_uid_gid_idmapped_mounts,				true,	"expected ownership on idmapped mounts",							},
-	{ fscaps,							false,	"fscaps on regular mounts",									},
-	{ fscaps_idmapped_mounts,					true,	"fscaps on idmapped mounts",									},
-	{ fscaps_idmapped_mounts_in_userns,				true,	"fscaps on idmapped mounts in user namespace",							},
-	{ fscaps_idmapped_mounts_in_userns_separate_userns,		true,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
-	{ fsids_mapped,							true,	"mapped fsids",											},
-	{ fsids_unmapped,						true,	"unmapped fsids",										},
-	{ hardlink_crossing_mounts,					false,	"cross mount hardlink",										},
-	{ hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mount hardlink",								},
-	{ hardlink_from_idmapped_mount,					true,	"hardlinks from idmapped mounts",								},
-	{ hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from idmapped mounts in user namespace",						},
+	{ acls,								T_REQUIRE_IDMAPPED_MOUNTS,	"posix acls on regular mounts",									},
+	{ create_in_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"create operations in user namespace",								},
+	{ device_node_in_userns,					T_REQUIRE_IDMAPPED_MOUNTS,	"device node in user namespace",								},
+	{ expected_uid_gid_idmapped_mounts,				T_REQUIRE_IDMAPPED_MOUNTS,	"expected ownership on idmapped mounts",							},
+	{ fscaps,							0,				"fscaps on regular mounts",									},
+	{ fscaps_idmapped_mounts,					T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts",									},
+	{ fscaps_idmapped_mounts_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts in user namespace",							},
+	{ fscaps_idmapped_mounts_in_userns_separate_userns,		T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
+	{ fsids_mapped,							T_REQUIRE_IDMAPPED_MOUNTS,	"mapped fsids",											},
+	{ fsids_unmapped,						T_REQUIRE_IDMAPPED_MOUNTS,	"unmapped fsids",										},
+	{ hardlink_crossing_mounts,					0,				"cross mount hardlink",										},
+	{ hardlink_crossing_idmapped_mounts,				T_REQUIRE_IDMAPPED_MOUNTS,	"cross idmapped mount hardlink",								},
+	{ hardlink_from_idmapped_mount,					T_REQUIRE_IDMAPPED_MOUNTS,	"hardlinks from idmapped mounts",								},
+	{ hardlink_from_idmapped_mount_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"hardlinks from idmapped mounts in user namespace",						},
 #ifdef HAVE_LIBURING_H
-	{ io_uring,							false,	"io_uring",											},
-	{ io_uring_userns,						false,	"io_uring in user namespace",									},
-	{ io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
-	{ io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
-	{ io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
-	{ io_uring_idmapped_unmapped_userns,				true,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
+	{ io_uring,							0,				"io_uring",											},
+	{ io_uring_userns,						0,				"io_uring in user namespace",									},
+	{ io_uring_idmapped,						T_REQUIRE_IDMAPPED_MOUNTS,	"io_uring from idmapped mounts",								},
+	{ io_uring_idmapped_userns,					T_REQUIRE_IDMAPPED_MOUNTS,	"io_uring from idmapped mounts in user namespace",						},
+	{ io_uring_idmapped_unmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"io_uring from idmapped mounts with unmapped ids",						},
+	{ io_uring_idmapped_unmapped_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
 #endif
-	{ protected_symlinks,						false,	"following protected symlinks on regular mounts",						},
-	{ protected_symlinks_idmapped_mounts,				true,	"following protected symlinks on idmapped mounts",						},
-	{ protected_symlinks_idmapped_mounts_in_userns,			true,	"following protected symlinks on idmapped mounts in user namespace",				},
-	{ rename_crossing_mounts,					false,	"cross mount rename",										},
-	{ rename_crossing_idmapped_mounts,				true,	"cross idmapped mount rename",									},
-	{ rename_from_idmapped_mount,					true,	"rename from idmapped mounts",									},
-	{ rename_from_idmapped_mount_in_userns,				true,	"rename from idmapped mounts in user namespace",						},
-	{ setattr_truncate,						false,	"setattr truncate",										},
-	{ setattr_truncate_idmapped,					true,	"setattr truncate on idmapped mounts",								},
-	{ setattr_truncate_idmapped_in_userns,				true,	"setattr truncate on idmapped mounts in user namespace",					},
-	{ setgid_create,						false,	"create operations in directories with setgid bit set",						},
-	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
-	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
-	{ setid_binaries,						false,	"setid binaries on regular mounts",								},
-	{ setid_binaries_idmapped_mounts,				true,	"setid binaries on idmapped mounts",								},
-	{ setid_binaries_idmapped_mounts_in_userns,			true,	"setid binaries on idmapped mounts in user namespace",						},
-	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	true,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
-	{ sticky_bit_unlink,						false,	"sticky bit unlink operations on regular mounts",						},
-	{ sticky_bit_unlink_idmapped_mounts,				true,	"sticky bit unlink operations on idmapped mounts",						},
-	{ sticky_bit_unlink_idmapped_mounts_in_userns,			true,	"sticky bit unlink operations on idmapped mounts in user namespace",				},
-	{ sticky_bit_rename,						false,	"sticky bit rename operations on regular mounts",						},
-	{ sticky_bit_rename_idmapped_mounts,				true,	"sticky bit rename operations on idmapped mounts",						},
-	{ sticky_bit_rename_idmapped_mounts_in_userns,			true,	"sticky bit rename operations on idmapped mounts in user namespace",				},
-	{ symlink_regular_mounts,					false,	"symlink from regular mounts",									},
-	{ symlink_idmapped_mounts,					true,	"symlink from idmapped mounts",									},
-	{ symlink_idmapped_mounts_in_userns,				true,	"symlink from idmapped mounts in user namespace",						},
-	{ threaded_idmapped_mount_interactions,				true,	"threaded operations on idmapped mounts",							},
+	{ protected_symlinks,						0,				"following protected symlinks on regular mounts",						},
+	{ protected_symlinks_idmapped_mounts,				T_REQUIRE_IDMAPPED_MOUNTS,	"following protected symlinks on idmapped mounts",						},
+	{ protected_symlinks_idmapped_mounts_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"following protected symlinks on idmapped mounts in user namespace",				},
+	{ rename_crossing_mounts,					0,				"cross mount rename",										},
+	{ rename_crossing_idmapped_mounts,				T_REQUIRE_IDMAPPED_MOUNTS,	"cross idmapped mount rename",									},
+	{ rename_from_idmapped_mount,					T_REQUIRE_IDMAPPED_MOUNTS,	"rename from idmapped mounts",									},
+	{ rename_from_idmapped_mount_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"rename from idmapped mounts in user namespace",						},
+	{ setattr_truncate,						0,				"setattr truncate",										},
+	{ setattr_truncate_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"setattr truncate on idmapped mounts",								},
+	{ setattr_truncate_idmapped_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"setattr truncate on idmapped mounts in user namespace",					},
+	{ setgid_create,						0,				"create operations in directories with setgid bit set",						},
+	{ setgid_create_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"create operations in directories with setgid bit set on idmapped mounts",			},
+	{ setgid_create_idmapped_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
+	{ setid_binaries,						0,				"setid binaries on regular mounts",								},
+	{ setid_binaries_idmapped_mounts,				T_REQUIRE_IDMAPPED_MOUNTS,	"setid binaries on idmapped mounts",								},
+	{ setid_binaries_idmapped_mounts_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"setid binaries on idmapped mounts in user namespace",						},
+	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	T_REQUIRE_IDMAPPED_MOUNTS,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
+	{ sticky_bit_unlink,						0,				"sticky bit unlink operations on regular mounts",						},
+	{ sticky_bit_unlink_idmapped_mounts,				T_REQUIRE_IDMAPPED_MOUNTS,	"sticky bit unlink operations on idmapped mounts",						},
+	{ sticky_bit_unlink_idmapped_mounts_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"sticky bit unlink operations on idmapped mounts in user namespace",				},
+	{ sticky_bit_rename,						0,				"sticky bit rename operations on regular mounts",						},
+	{ sticky_bit_rename_idmapped_mounts,				T_REQUIRE_IDMAPPED_MOUNTS,	"sticky bit rename operations on idmapped mounts",						},
+	{ sticky_bit_rename_idmapped_mounts_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"sticky bit rename operations on idmapped mounts in user namespace",				},
+	{ symlink_regular_mounts,					0,				"symlink from regular mounts",									},
+	{ symlink_idmapped_mounts,					T_REQUIRE_IDMAPPED_MOUNTS,	"symlink from idmapped mounts",									},
+	{ symlink_idmapped_mounts_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"symlink from idmapped mounts in user namespace",						},
+	{ threaded_idmapped_mount_interactions,				T_REQUIRE_IDMAPPED_MOUNTS,	"threaded operations on idmapped mounts",							},
 };
 
 struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
@@ -13936,7 +13939,8 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 		 * If the underlying filesystems does not support idmapped
 		 * mounts only run vfs generic tests.
 		 */
-		if (t->require_fs_allow_idmap && !t_fs_allow_idmap) {
+		if (t->support_flags & T_REQUIRE_IDMAPPED_MOUNTS &&
+		    !t_fs_allow_idmap) {
 			log_debug("Skipping test %s", t->description);
 			continue;
 		}
-- 
2.34.1

