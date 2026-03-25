Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587972EB84E
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2026 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411144; cv=none; b=h13i5oTIOp/uNcF2i0IxdqPZ7XiJ+aNgQ8xgoQVSyIesdoed3ezJWuecHDOQdV0vM3iOlb7kY7LufO1A3/9kItvnd02IzZ3ZSLHdMLBt6spJ6H7Zt7nYpH6zaKhQOkKsVsIsFTsuCwNKnfQXHVyCjcwRKF1Qmfa7mH7dTQizulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411144; c=relaxed/simple;
	bh=yN6SJRaNjklwCyrCFSAcY+Y+DM90V8SD6sa8Z4Hy8NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tHycdIwQEVhmY8l1cIo4jC56zjBVq3VKVKoqIIeqwji5uKFHGQLTOEKJHqXa090YLtO+WbA7rIUFZIrJInjw0P365ikkIKBqp41NJ1G2R1M9rYq3TDHR1TPDNTrDqMh0BdcEYUTxNY6ToBTwXx5txIf7h+1EVpCz00NCRhiczYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YISuYqbR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YISuYqbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774411142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ARsYv9IJ+1MGqx/6BkWp1A1sf3QW0UYY6nsKkWFV7Pk=;
	b=YISuYqbRhLj89EAu1hnGDrsGesV9guPgN5wSj7K/8ToBqO8SKkr3ZtvRsF0sXThNrom0Gn
	cJwpPTmYFERYNdVNARQKz0NbeWlX1+MLCsCcgdEYAwTMO5O6lDw6TvmtjzstjXxBwX67Z4
	tLYkcHqw+LKHnm4iJbOi68a8dzRK5Tw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-l3U8ackxOYimq1jCEyq4-Q-1; Tue,
 24 Mar 2026 23:59:00 -0400
X-MC-Unique: l3U8ackxOYimq1jCEyq4-Q-1
X-Mimecast-MFC-AGG-ID: l3U8ackxOYimq1jCEyq4-Q_1774411140
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C5AA195608D
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2026 03:59:00 +0000 (UTC)
Received: from localhost (dell-per750-06-vm-07.rhts.eng.pek2.redhat.com [10.73.180.56])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4ABFD1955D71;
	Wed, 25 Mar 2026 03:58:58 +0000 (UTC)
From: Yongcheng Yang <yoyang@redhat.com>
To: fstests@vger.kernel.org
Cc: smayhew@redhat.com,
	zlang@redhat.com
Subject: [PATCH] generic/551: prevent OOM on NFS on systems with no swap memory
Date: Wed, 25 Mar 2026 11:58:22 +0800
Message-ID: <20260325035854.2262636-1-yoyang@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Scott Mayhew <smayhew@redhat.com>

We have frequently observed the oom-killer killing aio-dio-write-verify
when generic/551 is run on NFS filesystems on virtual machines in AWS.

Virtual machines in AWS typically don't have a swap partition, so check
for that condition when testing NFS and only use 90% of available memory
when generating the list of write operations passed to
aio-dio-write-verify.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 common/rc         | 5 +++++
 tests/generic/551 | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index 92cb6982..f2a4496f 100644
--- a/common/rc
+++ b/common/rc
@@ -1201,6 +1201,11 @@ _available_memory_bytes()
 	fi
 }
 
+_total_swap_bytes()
+{
+	free -b | awk '/^Swap/ { print $2 }'
+}
+
 _check_minimal_fs_size()
 {
 	local fssize=$1
diff --git a/tests/generic/551 b/tests/generic/551
index 267c57ec..9c5ec4b2 100755
--- a/tests/generic/551
+++ b/tests/generic/551
@@ -38,11 +38,18 @@ do_test()
 	local truncsize
 	local total_size=0
 	local avail_mem=`_available_memory_bytes`
+	local total_swap=`_total_swap_bytes`
 
 	# To avoid OOM on tmpfs, subtract the amount of available memory
 	# allocated for the tmpfs
 	[ "$FSTYP" = "tmpfs" ] && avail_mem=$((avail_mem - free_size_k * 1024))
 
+	# To avoid OOM on NFS on systems with no swap memory, only use 90%
+	# of available memory when generating the list of write operations
+	if [ "$FSTYP" = "nfs" -a $total_swap -eq 0 ]; then
+		avail_mem=$((avail_mem - avail_mem / 10))
+	fi
+
 	# the number of AIO write operation
 	num_oper=$((RANDOM % 64 + 1))
 
-- 
2.52.0

