Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28EB34AAED
	for <fstests@vger.kernel.org>; Tue,  9 Sep 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431566; cv=none; b=HoN8jJUAkb6g4+yDtZBI6IDhr1G05UmcqlTGKhVmn+7ndvZ2/4xWn17csPbPNkyBxpmzle09OYUhx85eAFxg63er/YSYvsnSDCbDlzbe/fbje42K6ACczoKv+fQX5OAB+cTXCzt37+qSOqHbmaWP6FAHJVQWyzHVt/8WVTNVpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431566; c=relaxed/simple;
	bh=O+3dGIR/1DtiE9KLcFUY0iaC5JbpkqVOUBN8aCmD/gU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:To:Cc; b=lzs+ybGGwnwGQsCWMs7fbj1wI556+C2nU6jdKMYw1nV9ET1FrL5WcnaVfKZCbYtQGbZjGETG5ZQJDdtitcDmuAOtLc9+lMJMcpfK0i0ovJZRAiC9fCKZZMSy79AQfvZVp8lSf68VeS79ZGAka2CxnOnVvW/WFunJ8HXyAcNBa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/mGLWld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/mGLWld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=z3WZwo/jaWWU1mgZkjIF7n9gEjSRZYhoi1CAELphjFM=;
	b=M/mGLWld8KH6/yD9tSkH5AWCtIHkvs0ZAb9y2R5KRt6hZHrrfMl6c+PbhBzM+CNXbj/Y/q
	1Y+7rpL1xEh0zc1ZGSltJmcqOGVTRms6k51ND7FONJfF9RdEXA16qKWGDeT2VHzl6VDGSo
	A53JN5TPIdIbx5vtGUdHqa3xtzkd/h4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-6duaMLHwMESZUr5Y_xu_HA-1; Tue, 09 Sep 2025 11:26:02 -0400
X-MC-Unique: 6duaMLHwMESZUr5Y_xu_HA-1
X-Mimecast-MFC-AGG-ID: 6duaMLHwMESZUr5Y_xu_HA_1757431561
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dd5c1b67dso31182035e9.2
        for <fstests@vger.kernel.org>; Tue, 09 Sep 2025 08:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431561; x=1758036361;
        h=cc:to:in-reply-to:content-transfer-encoding:mime-version:message-id
         :date:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3WZwo/jaWWU1mgZkjIF7n9gEjSRZYhoi1CAELphjFM=;
        b=Xnyxq0P22APIMVrnpjfwQxDZ9SRLqK+xr15s8a6WZunF5pxbws/RwI74MgxQLbTQW6
         dhyit73jR9KWKjSDUS1vOqLO4yWv04vDlII99bkBPBMTkZvexNo1ZVHVqlrDkVPbGL4N
         sOx+xrS6hVW/VkdxvCdarXFE+lBsGjkIHMomHITfrrlB3CK4P3H/7NBK/GBuiHjGc6Ww
         J7+LyTEsqFz0x1K17fpLc5hv7OXdJJyDx4yhEcAWX/iPOBUrWvYCqxfgM7srYZ0iVXge
         q7CqjeiUDA+DpkpEBM/VD0FxeRyB3M+iKpCZY76/nmZBm8/hrdDLK6D7UTjCpvkfscrL
         2CMA==
X-Gm-Message-State: AOJu0YwqiaVgLuriTeuAgZqbbMqzRWeNVN/O/euNWnvZunavugpGGMFR
	pFDFpHAHWErcSDPkRPWDUQFkQ3rcxBkHoQ19L8GO1/AKbDSh2k8h+CLTWMkr47peI9HI0mG+Hli
	wGIbI1tYTb8aLr/UmVedvOLPN/OAZQ0WiPMAstqaGVYmV5VuN+WYef+K4BPIoD0A8VO1F
X-Gm-Gg: ASbGncu0wk9Y+dCyTci9yXAuREPEDXL0FYIafzHFI9mJ348ZKi/kE5FTKr8EapeSm1J
	8CaTJkjtCT0qsnPoySSDm8WTsQXyLq+TrGY19N2mYnATRLYqCxweUFUtgbi+QWp8vhJOrrP00/Y
	whqoGNobzgf+Uqc9B7LDKkPelo0rwhe5++Nd8x079L0vLkcJkTVIukNPsx0HqNzV8iAIL0IkT8J
	Y70wiWl6j36dHvO/WLkhLexrYfAEH4Iyc2JP1lJkTghrjiL6JqUIOk0ujphRIxj2F4zQVTfYhGH
	Ucdk4cqsH3t1y/6hWAJhfaJldM/3bpFfwWUZHoM=
X-Received: by 2002:a05:600c:5304:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-45de110e75dmr90886375e9.14.1757431560973;
        Tue, 09 Sep 2025 08:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS7BPzwjcjGF4v+qJMawvK/ZJPMgzEV0RZ5/MJh+kj7pnlazKDSanzwhxINAYPZk4x6NQDbg==
X-Received: by 2002:a05:600c:5304:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-45de110e75dmr90886185e9.14.1757431560561;
        Tue, 09 Sep 2025 08:26:00 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm348550005e9.21.2025.09.09.08.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:26:00 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v3 0/3] Test file_getattr and file_setattr syscalls
Date: Tue, 09 Sep 2025 17:25:55 +0200
Message-Id: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANHwGgC/2WNywqDMBBFf0Vm3ZQ8qqZd9T+KixAnGioqkxAUy
 b83tcsuz4F77gEByWOAR3UAYfLBL3MBdanAjmYekPm+MEgua65EyzYTI5nIwh6smSaGqF2Nsm9
 QaCirldD57Sy+usKjD3Gh/TxI4mt/Lc31XysJxllj+N3enGqd4M830ozTdaEBupzzBwQlO/6vA
 AAA
X-Change-ID: 20250317-xattrat-syscall-ee8f5e2d6e18
In-Reply-To: <mqtzaalalgezpwfwmvrajiecz5y64mhs6h6pcghoq2hwkshcze@mxiscu7g7s32>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=O+3dGIR/1DtiE9KLcFUY0iaC5JbpkqVOUBN8aCmD/gU=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMg64sxvuEhd8/7rz60KmDYvm2kxqMTSYyrLbeObKv
 qKIg59SFlzvKGVhEONikBVTZFknrTU1qUgq/4hBjTzMHFYmkCEMXJwCMBFZYUaGrcYLqrepHDvi
 8mtyyoqCqybJec0+YR+FE+/sWq2zevcvKYa/ostD5LyOn5VhP7pAO92vNbzFP4Hte+5MmWPzbE6
 7vtbiAAAGI0Y4
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add a test to check basic functionallity of file_getattr() and
file_setattr() syscalls. These syscalls are used to get/set filesystem
inode attributes (think of FS_IOC_SETFSXATTR ioctl()). The difference
from ioctl() is that these syscalls use *at() semantics and can be
called on any file without opening it, including special ones.

For XFS, with the use of these syscalls, xfs_quota now can
manipulate quota on special files such as sockets. Add a test to
check that special files are counted, which wasn't true before.

To: fstests@vger.kernel.org
Cc: zlang@redhat.com
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Changes in v3:
- Fix tab vs spaces indents
- Update year in SPDX header
- Rename AC_HAVE_FILE_ATTR to AC_HAVE_FILE_GETATTR

Changes in v2:
- Improve help message for file_attr
- Refactor file_attr.c
- Drop _wants_*_commit
- Link to v1: https://lore.kernel.org/r/20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org

---
Andrey Albershteyn (3):
      file_attr: introduce program to set/get fsxattr
      generic: introduce test to test file_getattr/file_setattr syscalls
      xfs: test quota's project ID on special files

 .gitignore             |   1 +
 configure.ac           |   1 +
 include/builddefs.in   |   1 +
 m4/package_libcdev.m4  |  16 +++
 src/Makefile           |   5 +
 src/file_attr.c        | 274 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000     | 109 ++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++
 tests/xfs/2000         |  73 +++++++++++++
 tests/xfs/2000.out     |  15 +++
 10 files changed, 532 insertions(+)
---
base-commit: 3d57f543ae0c149eb460574dcfb8d688aeadbfff
change-id: 20250317-xattrat-syscall-ee8f5e2d6e18

Best regards,
--  
Andrey Albershteyn <aalbersh@kernel.org>

