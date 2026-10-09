Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AAC3D75A1
	for <fstests@vger.kernel.org>; Fri,  9 Oct 2026 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536159; cv=none; b=i70nTK+a1LhpwuA0Lxe848O7zMewZg5JDmqh6Ef9NSrxcaJUZCsQr3GDstHAPZaEOScrDy5iPAaM2JoUJ/e4nBBANCFa8yFlvECY6OxocbpiXLhii0Zvi/Eub61P8SjBjGqJkj0z4IThbpnuAV2bOgzW7k1b1y+eedTTHgRQH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536159; c=relaxed/simple;
	bh=OGv9e4kZdiF9RgD1EliE6XHLgPk3GmgettAYWl1fA+M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ey05OknqQN1spRgKUwuGM4c8QMs1pxWt1xNBPPX5pg7vA4Zwc1oVuhfdv0Y+puGNexCj7wBB/jxaJYabsAVJ73uEJj9l93PrCqkbwi57GgP+HxAeDRrnJ8VXBHn3zrVRmrfOYhwGhSxrBb6JLgYm03WhcBXkQe3QeOix/anpjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IiMKIK9a; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiMKIK9a"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2e6affec80so591618766b.2
        for <fstests@vger.kernel.org>; Fri, 09 Oct 2026 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791536156; x=1792140956; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XkufVygYf3das1AkCg5Yl8KsorAKzoeCOi7nexNmHV0=;
        b=IiMKIK9a3qxUnYUp+M4GD8hyhwMkS1XTI7vDG+WFBnuAIIz92LaVPghIdqkOnbCFdS
         gNZGcVikqVI8BNvkzHF8UQ2PKc9S/k6EKJCVMpVElcqLcbMHIvv9ccIA1gJAwzNUuzJm
         Q9y2tcM9nCP2lVcdlmxQCp9yV4XXo2FFBp5R4SlrBGuTqNMk7WdbJWQGP26scwxG9jb6
         Cg3dihCLFb6hV6QzWLiAfGkh1HRj9CwGSQGxaTDY90f3U0RAuWZhZ/dCWHbCLzvFn7NT
         BBSN4I7MkFHHBUjid0MXEVFsEM0JK5R1qgNnEVqpaghbUS6IwEQUDm+lqCOfPfSJi55D
         vwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791536156; x=1792140956;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkufVygYf3das1AkCg5Yl8KsorAKzoeCOi7nexNmHV0=;
        b=MP4/mXGq7yHa55N7aLtI/gPHtCSaJoHeLIWt1p8BDorkiHJrBstdHigF8/TF0sz29c
         aB57cyU2SuZ7uzdFSHWs34KAQlIoYaskfebt1zGoKaY+VIAwE7NV6mEtw8xTVj2YOeX7
         7aSqA5OCKmFNx/4CcBCNqmfDN0/zCwugqPb6RhiY08Ca68l6VNOUKragt240h8r107CJ
         g9UKudZOhUGSMZlQU5PLhv9G4DQKCpI9SZ68clw+PqQnEZYPzlgK/WrT6vJ89K14X4q0
         vuOKNInmgoB3GJS8tEeSH1RJrFyjzmBjvRKyBJtT1RtaD11YasZ//KdObyVbfn+6SfBL
         lZXg==
X-Forwarded-Encrypted: i=1; AKwUvBzEAKn3Y8+TjDa1pknrEgTdLRHE6Er4XzsHaGk0RIu4ity74eCswx725wR3LI4Hl7QgIvKfLtvz@vger.kernel.org
X-Gm-Message-State: AFq9FYKTKFGXozKZP2ThZRUhlt6Nse5hZ4N9prGGuf35QxX1BFU9I90s
	IBdGbbSVbonk9RY+bFFbUIcid6QOBPsoRwJw91tdxEsd1NJv/BJTk5ogTjPxwZTagUU6yWNeyUL
	vP3HNK9P0UJsLSiyhz9ObmC4ZhXhvUw==
X-Received: from ejcxk3.prod.google.com ([2002:a17:907:d803:b0:c2a:e413:97d5])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:961a:b0:c25:2a78:15ed with SMTP id a640c23a62f3a-c31a9a04e08mr114472166b.6.1791536155187;
 Fri, 09 Oct 2026 01:55:55 -0700 (PDT)
Date: Fri,  9 Oct 2026 08:55:43 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009085544.2450966-1-jprusakowski@google.com>
Subject: [PATCH v2] generic/622: increase sleep time for lazytime expiration
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

However, on filesystems or configurations with higher writeback
overhead -- such as F2FS with transparent compression enabled, where
compressed files cannot use inline data and writes use out-of-place
updates (OPU) with higher latency in the compression and writeback
pipeline -- the 2-second sleep window can occasionally be insufficient.
Because the inode is only eligible for expiration after 1 second, only
about 1 second remains in the 2-second sleep window for the flusher
thread to schedule, expire the inode, and mark the inode page dirty
before restore_expiration_settings resets dirtytime_expire_seconds to
24 hours and shutdown occurs. If the flusher thread is delayed, the
subsequent shutdown checkpoint ignores the unexpired I_DIRTY_TIME inode,
causing the test to intermittently fail with:

    FAIL: lazytime mtime wasn't persisted by expiration
    ondisk_time (...) != expected_time (...)

Increase the sleep duration in expire_timestamps() from 2 to 4 seconds
to give sufficient margin for the flusher thread to reliably expire the
lazytime inode and dirty the inode page before shutdown.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
Changes in v2:
- Increase sleep time to 4 seconds unconditionally with an explanatory
  comment instead of using an F2FS-specific conditional.
- Remove the non-standard Change-Id trailer.

 tests/generic/622 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/generic/622 b/tests/generic/622
index cb0f5828..16088199 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -60,8 +60,12 @@ expire_timestamps()
 	__expire_inodes
 
 	# Userspace doesn't have direct visibility into when inodes are dirty,
-	# so the best we can do is sleep for a couple seconds.
-	sleep 2
+	# so the best we can do is sleep for a few seconds.  Because
+	# dirtytime_expire_seconds is 1 second, sleeping for 4 seconds leaves
+	# enough margin after expiration for background writeback to finish even
+	# on filesystems with higher writeback overhead (e.g. F2FS with file
+	# compression).
+	sleep 4
 	restore_expiration_settings
 }
 
-- 
2.56.0.360.g66cac248cb-goog

