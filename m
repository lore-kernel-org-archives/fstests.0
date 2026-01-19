Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100731AF31
	for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840396; cv=none; b=BifoRozt/lVDucC7MDW79+yAXMh4e6l6SmLJSKEQODm4xsKnYev20ql8zixGsCp3KO7QnPx+1AT9IUa/g++ogbFBJ49PgBn9SUSwBdHvXgKSOUkw1prwvaxQExTvejR1TrXYg5pMdTNeNEu4tV14/2SNzIoBx6Cv6zpXhxZI41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840396; c=relaxed/simple;
	bh=Xowcft0xkXz2W3N0nUhU7g4atdzwl1x5G7ysxX9HdPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3gEayr+0QtSqQHM8Nl4zuDsNhANn0Fe/H/Jwqr0jC8Do9Ks0vuwZa66pAM9HbsWiar0V6mIl5Rv+J2p9NG+dJLuekwqFB5Em91OLgFU6OkyfGOb/X5wNa69WDJvdG8G5dv6xXg4byt1FQwho+Gw+4jwtfcCBsQUZVxovRahs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4cbXzy0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQtyYZXY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4cbXzy0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQtyYZXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768840393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L4aL0yBezLwure4s/o1FNp4K3UMiRrxxgbdH76Eri30=;
	b=R4cbXzy0fqZCqAAf7p2keUtD4JtMdvfdQCZAYfel2Z1+VtNAVRtIGGWOlZc/SMOewBMJLR
	uPPgfGcPYwEypbpKMQcfZzBvzHAHuaP2eCD4uREpKi9iHceZk4VDbcq6Rxh0g1e8JATq+t
	seSN9AyFyuvuIs98+Dp6VEPbU0FO42Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-awVaf8uqN3iUWjG_RBXY1A-1; Mon, 19 Jan 2026 11:33:12 -0500
X-MC-Unique: awVaf8uqN3iUWjG_RBXY1A-1
X-Mimecast-MFC-AGG-ID: awVaf8uqN3iUWjG_RBXY1A_1768840391
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325b182e3cso2767254f8f.2
        for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768840391; x=1769445191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4aL0yBezLwure4s/o1FNp4K3UMiRrxxgbdH76Eri30=;
        b=SQtyYZXYrV9fdv4om7pMxNw9TjKjKcTq2cHsOqvcgtYClypO286zPG4T3JSdW/t3KB
         hMXxlZs4Z/3EknO8KiO7i99AYagd2ox7BFwiiCLqDA8tiF8MHZziWBAG62byhQF+NXrP
         qsQ7l0XEqkcGUjwj5v8ntZsJDAOcaojQQvAdmfgSOs8mzEQQDychfaBxwTk8P9llOwCw
         mSH5dw8DI/iUnMH4G+8arSDoBZAcIGr478VKl7wN239X8fC7mbCIewE7+tm7D6gqt/H5
         6m2kksOQfdTGLr+vJiz9jLfUU3thJiLCdpxPhXNk+UJgk3NaHQxjhMn718wYBXxkW306
         p95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840391; x=1769445191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4aL0yBezLwure4s/o1FNp4K3UMiRrxxgbdH76Eri30=;
        b=vLgJEYkOuFLCdoRJZxxlxhSNWoQowZd6Aye4J/KK3cTQvgRSKoW082z4VaTWrI/7/Z
         JDdSFTVWiieSAWoZbJnLvKfGyXBfhS2xp9ffa3Zb5OeEf+xNATTHcjc+qgxdl58EcQBY
         ZOEiNFpaZaSqloltRXu4INubNAcnIFclFUqK4d2o8Dxc6mjuj+VuzcpHAlJRU6g3tUl0
         g9E8uJ7TQs7WUJ5ktnFmof5h1SwdqQWGS0dsnUEeWHHQf+9DIvHxI7/vuYzgUiVlRuLF
         cTjk2nP/PzXAxfPwuF1NsEePvVSSmx7X9eBj39C9UsZumuHuKUIXnw06LVnlRinbEtMt
         xXaw==
X-Forwarded-Encrypted: i=1; AJvYcCX0b8ig/BJM5Tq3WJmBDQ8tdm4syYgJt4+8rd05bBe323go5FXQ8QMaf7W0hF5hE6gZxVTS8ITc@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxgZuMsLjXJa6/0oJwjTmiVxapZ2VV4lV6EdXDJBTO6I0dQXD
	Gb/i8MnDVwM2y/PUMUnXO+dpWieB5Tn8YhfptZhp4vka2atcmm9hMD8E7xIhnmCwdwoK2YIAJAK
	hNqg0iB2iAyuDrfdFJhE8ln3cn1VVtcOKIlmpWlbJoOZ5wd8F9TTm+LePJw==
X-Gm-Gg: AZuq6aLx3gdUbg6tl2VqgJAdwLNpZmpnz9OSolrZpcTDkr+ss3Y22SE+CaRWNPu3Sre
	CKelu4OeXNSnHye2uRDOhLMzLdf+v9GV855ZM2+PhoJtmkKfR2gCB3Ib+PNvCB3GE/xoU6pg1XJ
	nPwYoeSXVbcsqFb2sprM5HpZ8zaQRpZyyZ1GlwIWI99ZbBb/f9r2TCTqRFVX2rHodS9o051fTTT
	hKFPTvG3zgZ7Eq21xYglcngccPHXqCSMF512lSPMezE9H4wX+tNbLw36FS9ztajMpqZXOhrNKHn
	sNNLBsARvz16eMd2/wWFJRQQfAHqKjoP1BobNMVoge3e6iBNNXEgb4zZHbv+hMJxes1GdgehsYo
	eD1BU2VhT2iNA4A==
X-Received: by 2002:a05:6000:2389:b0:431:3ba:1188 with SMTP id ffacd0b85a97d-43569972ef3mr14458645f8f.3.1768840390720;
        Mon, 19 Jan 2026 08:33:10 -0800 (PST)
X-Received: by 2002:a05:6000:2389:b0:431:3ba:1188 with SMTP id ffacd0b85a97d-43569972ef3mr14458602f8f.3.1768840390290;
        Mon, 19 Jan 2026 08:33:10 -0800 (PST)
Received: from thinky.redhat.com ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569998240sm23524318f8f.43.2026.01.19.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:33:09 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	djwong@kernel.org
Subject: [PATCH v2 0/2] Add traces and file attributes for fs-verity
Date: Mon, 19 Jan 2026 17:32:08 +0100
Message-ID: <20260119163222.2937003-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This two small patches grew from fs-verity XFS patchset. I think they're
self-contained improvements which could go without XFS implementation.

v2:
- Update kernel version in the docs to v7.0
- Move trace point before merkle tree block hash check
- Update commit message in patch 2
- Add VERITY to FS_COMMON_FL and FS_XFLAG_COMMON constants
- Fix block index argument in the tree block hash trace point

Andrey Albershteyn (2):
  fs: add FS_XFLAG_VERITY for fs-verity files
  fsverity: add tracepoints

 Documentation/filesystems/fsverity.rst |  16 +++
 MAINTAINERS                            |   1 +
 fs/file_attr.c                         |   4 +
 fs/verity/enable.c                     |   4 +
 fs/verity/fsverity_private.h           |   2 +
 fs/verity/init.c                       |   1 +
 fs/verity/verify.c                     |   9 ++
 include/linux/fileattr.h               |   6 +-
 include/trace/events/fsverity.h        | 143 +++++++++++++++++++++++++
 include/uapi/linux/fs.h                |   1 +
 10 files changed, 184 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/fsverity.h

-- 
2.52.0

