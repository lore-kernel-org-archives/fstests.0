Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAhDp2s/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D851B5
	for <fstests@vger.kernel.org>; Tue,  5 Dec 2023 23:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701846931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pxUnE/MZt29epdLoFWcoKGQrKr1H74SPW0fwA8WkrCk=;
	b=bAhDp2s/dSvi8ekL2/KxYbpLBVMkLhxAf0AuLH452fSbF00It2K6yI0jhgNpIMkjgZd16g
	UFRKGa13RxDD4ddx5tjOG7Vrq++cDpicjvOl0eqgNmNzhgvowq5hE/4mEv4KlDwUNW4NhX
	W2ju53FvW2Wmysjh4BPRDNon2NwbHxE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-p7zVn1kqNrCkuwP9dV9PYA-1; Wed, 06 Dec 2023 02:15:30 -0500
X-MC-Unique: p7zVn1kqNrCkuwP9dV9PYA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54c6bdefc9cso3177936a12.1
        for <fstests@vger.kernel.org>; Tue, 05 Dec 2023 23:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846927; x=1702451727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxUnE/MZt29epdLoFWcoKGQrKr1H74SPW0fwA8WkrCk=;
        b=juOfwaISq8crJivYlWMKq0xbY1gibrp0W0vEl2tjnJKeH+eXUwlUa3B4sVAAvR6b2k
         51MzLhhguXXjtQbh+z51EN8SI7q23xk6zDqMgo86fibtob3H3j0Bi/XCrM4HiZPPBpi4
         f23Vo2qKTzfrxI8tG+B9b2kMbaGH9fxJku8Gr6WW2jBhRE38xMavb9ViPfeDipNAiafo
         UQ7qUAWwFcS/RUho3vwNxi3XCP9EhSkQXpd57vZV0DtS6rhzuF7RCLZ40DKeT50wrUu/
         R4y1SjxQKbPMIU0PBOx5YACBJ5B/WmEFwikBTAVBdIPMAFMWFI3mg7w7RpYD8vU7Y7Po
         d6SQ==
X-Gm-Message-State: AOJu0YyiRWjW095ARI+so5GPg+rPVkdKA3xaC7HamVAGqave7OfoRm73
	NmFB93hPPbZn2CbKBH9LjGQEZvA3WVaWqxetOjvYXLE3VxDdSKWZq/6TFQH6L0dbrPPRW5RoY2X
	FPF9+R0C3UlDc+nhwKvkHNzqtVPDTSMNnGIQjta1OGl1xRBFjy9pQ9eIn5vgPA9ncjOWmUYRKIa
	+Z
X-Received: by 2002:a50:c292:0:b0:54b:67a7:efe5 with SMTP id o18-20020a50c292000000b0054b67a7efe5mr162564edf.1.1701846927325;
        Tue, 05 Dec 2023 23:15:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4ng+PgcfUBpeeI1WJEFYej0zlmTFcIUH651h2FBbfAzBwLHOFHfhSLolOEQ4SzkOadZ4MuA==
X-Received: by 2002:a50:c292:0:b0:54b:67a7:efe5 with SMTP id o18-20020a50c292000000b0054b67a7efe5mr162557edf.1.1701846927022;
        Tue, 05 Dec 2023 23:15:27 -0800 (PST)
Received: from fedora.redhat.com (gw19-pha-stl-mmo-2.avonet.cz. [131.117.213.218])
        by smtp.gmail.com with ESMTPSA id p18-20020a05640210d200b0054cf321a6casm2014078edu.8.2023.12.05.23.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:15:26 -0800 (PST)
From: Pavel Reichl <preichl@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH] xfs/598: Add missing "fixed_by" hints
Date: Wed,  6 Dec 2023 08:15:25 +0100
Message-ID: <20231206071525.168036-1-preichl@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel patches, the very same as for xfs/597, are necessary for scrub
to function as expected.

_check_xfs_filesystem: filesystem on /dev/sda3 failed scrub

xfs_scrub -v -d -n output ***
EXPERIMENTAL xfs_scrub program in use! Use at your own risk!
Phase 1: Find filesystem geometry.
/mnt/scratch: using 2 threads to scrub.
Phase 2: Check internal metadata.
Info: AG 1 superblock: Optimization is possible. (scrub.c line 212)
Info: AG 2 superblock: Optimization is possible. (scrub.c line 212)
Info: AG 3 superblock: Optimization is possible. (scrub.c line 212)
Phase 3: Scan all inodes.
Corruption: inode 131 (0/131) directory entries: Repairs are required. (scrub.c line 196)
Phase 5: Check directory tree.
Info: /mnt/scratch: Filesystem has errors, skipping connectivity checks. (phase5.c line 392)
Phase 7: Check summary counters.
203.0MiB data used;  5 inodes used.
64.2MiB data found; 5 inodes found.
5 inodes counted; 5 inodes checked.
/mnt/scratch: corruptions found: 1
/mnt/scratch: Re-run xfs_scrub without -n.
end xfs_scrub output
mount output ***

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/xfs/598 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/xfs/598 b/tests/xfs/598
index 449bd711..760cd861 100755
--- a/tests/xfs/598
+++ b/tests/xfs/598
@@ -19,6 +19,11 @@ _cleanup()
 _fixed_by_git_commit xfsprogs 10a01bcd \
 	"xfs_db: fix metadump name obfuscation for ascii-ci filesystems"
 
+_fixed_by_kernel_commit a9248538facc \
+        "xfs: stabilize the dirent name transformation function used for ascii-ci dir hash computation"
+_fixed_by_kernel_commit 9dceccc5822f \
+        "xfs: use the directory name hash function for dir scrubbing"
+
 _supported_fs xfs
 _require_test
 _require_scratch
-- 
2.43.0

