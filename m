Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBAB27B4E8
	for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307786; cv=none; b=izOpq+HMPysyaHVsir7DMjsXt4bzliqLo2zFTeBkSk01OMu6VynyQ6e0l5zWax8xAXfTbiF/bAge+xEBYm/2BMK5l66jcAx+puoB3H3vmVk485TOC1rZUHELzafhruEQu4ZCMaY7h8t49HGTsK2pnDK8+ma1dAnBA8KHjlIngYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307786; c=relaxed/simple;
	bh=PPr77puRvCeAT40UGuOX5WZ1/o6gVvC8AT6qc5GzuQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:To:Cc; b=rT09Wm02B5QGtA3i92bnrgubNmHtxn0AQC/DyhCgzLw8js/TKIL2pZtgSlKzWaJFuZZHlCLUt7b8SFrF3EAEkL/LwCGBggeUY4IEerkQSwE2pQA9ZiX8abUamW3a9xzO3NYdoumkMwFm/E3gTy5NDUmxythZmyow8TlY5CZQWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jj5L85CE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jj5L85CE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=GoGNdT1TeINSx3pJcevvIE4J9/n+UyYLAaBs2NvW64U=;
	b=Jj5L85CE7uaIW8T6XpT8KRJ09FaPleCozlqPeyU/DraNsBApcPtcjGM4zb0mxMzYXVZns5
	P1Z2s6f9ewYrBJ0mfKsPCPcQFjTa2+jJOJ+r9NmxSWazqEsqBpnrhfg8UBeZ+mVC5i00dX
	+U08jD94UCp7sdqn4Tv+ucasZJ6/rpA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9CvzlcUdNByugenAF6huHA-1; Wed, 27 Aug 2025 11:16:21 -0400
X-MC-Unique: 9CvzlcUdNByugenAF6huHA-1
X-Mimecast-MFC-AGG-ID: 9CvzlcUdNByugenAF6huHA_1756307779
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so49917615e9.3
        for <fstests@vger.kernel.org>; Wed, 27 Aug 2025 08:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307779; x=1756912579;
        h=cc:to:in-reply-to:content-transfer-encoding:mime-version:message-id
         :date:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoGNdT1TeINSx3pJcevvIE4J9/n+UyYLAaBs2NvW64U=;
        b=AM1l7r4Abfp3Iw+gS815OKaGteRzo6jIz9T7DF3hBKMh6HTSUxM15AnDDGxG4OEAjG
         pvObfJNOuaK3L+6cAP1WNXSTwcGMT986c+MenvKspWP9qIRYpoIPQIDAT/RcG01KCZjf
         oVzv4+ZElK1iSX2ube+e8WVQp/nZDBRGIfNDJsYkhsQOuw2U4TkBKmU/kaQgmQo8TZBI
         xzq6CyudNMUaz2kPFnuaEBDqB/QuXlEmAu3MX5FhcIps+Owo0YLPZGz+rCbrMlCRV177
         ULq2Vk2Jt9MfoZZqyw7rcQrP2GCB/FoKjmAHfp6spo665Mje0tCFS2IItzNNsPZYnFdI
         GTtQ==
X-Gm-Message-State: AOJu0Yyf+5tyCu8qflVugQzE3Bj7MoJ4aHXPWLiWUX11DGUYfUTmBrVC
	I/T+QyAjphso09/xdZrXZQ/W0j17ulXkhzzzWaoMx9ZSAIL0nt1dkQnghXxpc7zf1Mduferng4/
	U7xdMmuxeTaEDQAsSbCVpmt9D+z7ZeTkZS23WgpHgu8HcZONDUywm/N7LDg==
X-Gm-Gg: ASbGncuyyG/VitLZdFEoE67pSwXrKCd7rt9A7fUbeIgGVz7nfRXgLNBcRG9Aay800E3
	ZEN7Kq6OPkpZU/VWoE/HwO7NXFldwyn+2S0tOcB7fYvvdnKiJ02largJCDtD1A2acXRQbhUAEz5
	JlhLsgKRN+g3qiBhvXMJOD/1bWYZqFXDfjlYF4AolaVw4RvkzgoKODQIldpgeQ0kqCZBZNpTsLD
	7fe7ZvJYCQdpRBNLNVJk7Gm/P/dZ8zXhMdgi2Nj5hik6U0AGsGhJNCisfLlxgimQnJfX3rpCcmy
	08y+qhqyr0lSHZxd5g==
X-Received: by 2002:a05:600c:1f83:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45b517ad803mr174420985e9.10.1756307779459;
        Wed, 27 Aug 2025 08:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSshh7UA0Q1tQ+3feB1Bg+Sb2OMUJ7cAMX5l3HHqsQhNcKfVCBQkB/C/cHAyfVwt7bELFVww==
X-Received: by 2002:a05:600c:1f83:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45b517ad803mr174420705e9.10.1756307778992;
        Wed, 27 Aug 2025 08:16:18 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm35019145e9.1.2025.08.27.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:16:18 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v2 0/3] Test file_getattr and file_setattr syscalls
Date: Wed, 27 Aug 2025 17:16:14 +0200
Message-Id: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD4hr2gC/2WNwQ6DIBAFf8XsuTSAVWlP/Y/GA8FFSYmahRCN4
 d9L7bHHmeTNOyAgOQzwqA4gTC64ZS4gLxWYSc8jMjcUBsllw2vRsU3HSDqysAejvWeIyjYohxa
 FgrJaCa3bzuKrLzy5EBfaz4MkvvbXUlz9tZJgnLWa383N1p0V/PlGmtFfFxqhzzl/AAsF82evA
 AAA
X-Change-ID: 20250317-xattrat-syscall-ee8f5e2d6e18
In-Reply-To: <dvht4j3ipg74c2inz33n6azo65sebhhag5odh7535hfssamxfa@6wr2m4niilye>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=PPr77puRvCeAT40UGuOX5WZ1/o6gVvC8AT6qc5GzuQg=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtYrOp7b0lEhvrvvh/Ljp3xCofUxbawCiksZlq6t6
 F7dKTvl08GOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE9nZyfC/oP2OrKljSqlD
 8+duHbN0q8zLWV7s6+Xr0q6q7cuya1vEyPB2RfflhKaFmt1265S3mz++HfBg4T7veRJH1sp85Qy
 1ns8KAJ2MRdE=
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
 src/file_attr.c        | 268 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000     | 109 ++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++
 tests/xfs/2000         |  73 ++++++++++++++
 tests/xfs/2000.out     |  15 +++
 10 files changed, 526 insertions(+)
---
base-commit: 3d57f543ae0c149eb460574dcfb8d688aeadbfff
change-id: 20250317-xattrat-syscall-ee8f5e2d6e18

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>

