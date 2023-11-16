Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G32QNoy2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867D1A8
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700124259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hd0018aZ4vpoXpzDt5JFV+Ui4bsPaSR8Ci/P/DgIWOU=;
	b=G32QNoy2omxprV+pZXnSHBL1/aUYLM9aJ8az1v5QIpGVA4JwIVe0IURkoWn3yYCmCb88of
	EfQeZThgoAQMtEZx/El4Vk2Fu4Ny71X7bTLP5thLkhiXn7Rja+u07lxBJi9N4kaZNWbaJ8
	uKRkmuFZ0DyiwFl6SldlTa8fDPp0k8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Y_zPuH2MN-GbkKEoMjrwwA-1; Thu, 16 Nov 2023 03:44:18 -0500
X-MC-Unique: Y_zPuH2MN-GbkKEoMjrwwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D40101A550
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 08:44:17 +0000 (UTC)
Received: from xifeng.usersys.redhat.com (unknown [10.66.60.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD4140C6EBB;
	Thu, 16 Nov 2023 08:44:15 +0000 (UTC)
From: XiaoLi Feng <xifeng@redhat.com>
To: fstests@vger.kernel.org,
	bfoster@redhat.com
Cc: Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v1] generic/042: change the test file size from 25m to 26m.
Date: Thu, 16 Nov 2023 16:44:14 +0800
Message-Id: <20231116084414.21258-1-xifeng@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Xiaoli Feng <xifeng@redhat.com>

When mkfs with "-d su=2m,sw=1" that DAX 2 MiB hugepage faults
request, it need the multiples of 2 file size. So Change to 26M.

Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
---

Hello Brian,

I'd like to change the test file size to 26M. Are there any special requirement
for 25M file size?

Thanks.

 tests/generic/042 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/042 b/tests/generic/042
index 5116183f..c583f0ae 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -27,7 +27,7 @@ _crashtest()
 	img=$SCRATCH_MNT/$seq.img
 	mnt=$SCRATCH_MNT/$seq.mnt
 	file=$mnt/file
-	size=25M
+	size=26M
 
 	# f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
 	# f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change
-- 
2.39.1

