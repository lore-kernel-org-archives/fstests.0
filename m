Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AEC4734E2
	for <fstests@vger.kernel.org>; Thu,  8 Oct 2026 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452017; cv=none; b=aHImHPZbgOCn7RbN0fNcNDbURTj/v1Z+CyQoCV2JHVK5KZX8oqPVhI2IkFpZtkS3oaPDmPLYiS78N/WQGq88i/+UTBuwi82pu9X5E7izPfxGm8z9lEm5rcmttSZuI5e9Mx2Q3etEmPi845CDPT/Nwe/Z2WeFqudoMr4A1v1sDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452017; c=relaxed/simple;
	bh=ycqB6+ohQpajRI13ZgHIpFKADBtGvyCS08X4yWELvNg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uak+aF/B8whsw5/Vl4rtxQuuDrOKqCoH+TWAO2W1ZzxFd7QcZtdYKB/vnJ/pk4sZutdE6qXxTs4XH1yjdqlFJvkN1WpjctUfjb1zXhljR5kd8EGPLeYw9/qeaENus3PTW+chCiCIlQtE/zbv5NGU+ab/WofYTK6yB5+6oMIiQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkzwvbaS; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkzwvbaS"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c25edb54d22so183732866b.1
        for <fstests@vger.kernel.org>; Thu, 08 Oct 2026 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791452010; x=1792056810; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7wb7Vc4+qw5NtWsgABpAo/ja//V46/BzB1YtSmuwSc=;
        b=qkzwvbaSaYDrE9tSOOxjfZaUZWOwdlSMhZsXbFhaVdK8zD75EsOT18H2oL77MMbFh5
         s2+lzwohz8Afj2eFXf5k+lA9LWrPplQmNTT9ESluVbav0GECDEM0znZcnnCM3QieICgH
         YW2et3RYtNAapbtVBwAy5SD/FqeyIRu1iOFxouo4Go1nlJqo4XP+9734nD7mj1ZTQY7T
         AYEblphbeDxtp9xPg9Zqe4tsm5pqX2Ozq9w1m1+i5dT4XPhkkGstH399wtNw+kTR/7Ou
         u6tS2S+Z0CU0SVSfhOEIpOeW6fwLP/2OM+8v5kl6JL6ZmeVTQmIqwczZMVLZp4XAtb7L
         ghZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452010; x=1792056810;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7wb7Vc4+qw5NtWsgABpAo/ja//V46/BzB1YtSmuwSc=;
        b=Anj1J0O60xePeXwiOfWFN4XGWftoEclalTL6/sdAxqKmP51wU657Y309w0TCWC3GBy
         +B1uonPQH6qB9fuWXXbkOez7xi8mVx6XF2h472it5aFUgC0ddtTityA0YEDFw/bv5Mcb
         Qn7kK1bMeOf3XzsMEkImGYqhcekxl4j9j1oWv+t4cEZfAKhGfj6iPZop7Odn6yvLpKlx
         FGGPKqBPJDJvOHSTL4bOM8yKuksp9HZssFrZn6r+5Fq6258qWyXCyRGzqaBamZTXmJJY
         N3UASFq7vFDm8q2UWsqUn7psZ5WJ9IdoUTNGnYZP8MqALfFaRJj4gcVg6Loyz3QH+tMH
         a67g==
X-Forwarded-Encrypted: i=1; AKwUvBzFHjvIe18tFj14xEvULE4OSGVQPeSqDfpTf+dtv37a9Qk2uOF9CBFKQBn0fzi6yyNVqcS0yjS7@vger.kernel.org
X-Gm-Message-State: AFq9FYJzZb4sn9JEvu/W//xq049vSP04qCAzAa726Z3zXMzoU7x8/Vr/
	Yf7+Bd2M6kEul+1IkmVvC2uDG9s9hvnq51wAVclI1wNO6MJDbhpXq/VFPavZs/AQDMLF/WqVtlU
	UqtXHcou84Y7EZAHVE28AfE0inqnv9g==
X-Received: from edew21-n2.prod.google.com ([2002:a05:6402:a215:20b0:6aa:e5de:ffcb])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:518b:b0:6aa:734a:a093 with SMTP id 4fb4d7f45d1cf-6aff4575abfmr4787816a12.42.1791452008928;
 Thu, 08 Oct 2026 02:33:28 -0700 (PDT)
Date: Thu,  8 Oct 2026 09:33:17 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008093317.2792726-1-jprusakowski@google.com>
Subject: [PATCH] generic/622: increase sleep time for lazytime expiration on
 compressed f2fs
From: Jan Prusakowski <jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

In generic/622, expire_timestamps() tests whether lazytime timestamp
updates are persisted after dirtytime expiration. It configures
dirtytime_expire_seconds to 1 second and enables continuous writeback
of dirty inodes, followed by sleeping for 2 seconds to allow the
asynchronous VFS flusher thread to expire the I_DIRTY_TIME inode,
invoke the filesystem's write_inode callback, and flush the dirty
metadata before the test executes _scratch_shutdown -f.

However, on F2FS with transparent compression enabled, compressed files
cannot use inline data and writes use out-of-place updates (OPU) with
higher latency in the compression and writeback pipeline. Because the
inode is only eligible for expiration after 1 second, only about 1 second
remains in the 2-second sleep window for the flusher thread to schedule,
expire the inode, and mark the inode page dirty before
restore_expiration_settings resets dirtytime_expire_seconds to 24 hours
and shutdown occurs. If the flusher thread is delayed, the subsequent
shutdown checkpoint ignores the unexpired I_DIRTY_TIME inode, causing
the test to intermittently fail with:

    FAIL: lazytime mtime wasn't persisted by expiration
    ondisk_time (...) != expected_time (...)

Increase the sleep duration in expire_timestamps() from 2 to 4 seconds
when running on F2FS in compress mode to give sufficient margin for the
flusher thread to reliably expire the lazytime inode and dirty the inode
page before shutdown.

Change-Id: I208bf14c189b54cc209059b0fd2de9e403a073f2
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/622 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/generic/622 b/tests/generic/622
index e8ead300..5879e85e 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -60,8 +60,14 @@ expire_timestamps()
 	__expire_inodes
 
 	# Userspace doesn't have direct visibility into when inodes are dirty,
-	# so the best we can do is sleep for a couple seconds.
-	sleep 2
+	# so the best we can do is sleep for a couple seconds.  On F2FS with
+	# compression enabled, out-of-place updates and compression writeback
+	# add extra latency, so sleep a bit longer.
+	if [[ "$FSTYP" == "f2fs" && "$MOUNT_OPTIONS" == *compress* ]]; then
+		sleep 4
+	else
+		sleep 2
+	fi
 	restore_expiration_settings
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

