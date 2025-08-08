Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5001D54E9
	for <fstests@vger.kernel.org>; Fri,  8 Aug 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681539; cv=none; b=gZqWjqFa9Unax9Z+kaQfDJLgL9CBmw0Fc4vnW6P6vRrNn+B1Ptsw2yNMqITOLSLZs6sUBXVtrrvlj5BURa/JtMk1lE/ArhG9qLZb5DeYXZ2xkldGiK46PpOiiXoy4iZsdYJ0o7+8BG/sDx79BQgY/i8Vy0C3WK7nzsyl8pSt/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681539; c=relaxed/simple;
	bh=e1W/HcruV/OHIdwnbStEI9Ov39lexljtbC+tMPtG4Sc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:To:Cc; b=GdbxO31+8jENocC5VMzpx/lx1jjGerlA08g1T9HolFBG4ZwjYbkWA/b4539T3fA/xjlyPNaasMjGMug36QmEOn8WODcD/2xqMqX9btLXyA2OVfQiib+R7giUWP6oAAGeUahsf2jIg5H9mE/Kpg2J3PcrLTGhN5flo8V2BlnUfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJDq6oRq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJDq6oRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=SoUBKlNMzRCqR2PByufZ7Vaz72annPP0DWvMgm3RHPY=;
	b=FJDq6oRqLJEjUTvV1SnrRrAq/dln38RaVl4IP51va79nD4A1j3ouhCinGhi6c4aoU3f5+Q
	nGFfal/Q5tMpvla/yu5Klobywdph/eZKGUw+8d7cD8AmmcPlBaOqI+TrZ/z/86KYZADRSr
	zJmzHdtnm9Pbt2xuWnfQGtmh61CekQA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-2aRrk-blNxmD0nCotRGfzg-1; Fri, 08 Aug 2025 15:32:15 -0400
X-MC-Unique: 2aRrk-blNxmD0nCotRGfzg-1
X-Mimecast-MFC-AGG-ID: 2aRrk-blNxmD0nCotRGfzg_1754681535
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so10378525e9.0
        for <fstests@vger.kernel.org>; Fri, 08 Aug 2025 12:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681534; x=1755286334;
        h=cc:to:in-reply-to:content-transfer-encoding:mime-version:message-id
         :date:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoUBKlNMzRCqR2PByufZ7Vaz72annPP0DWvMgm3RHPY=;
        b=j64iIHyxisz8VO60NGC2fH2zR6YUvoIc3aYMInH8Cu9oqX1KqAUCEOWbvKApi043C0
         b+5L9c4C4JJOxN+9+otIc7/52KwcE+HaC61sKAr3lsltrQppBAYdkR5FSl7/ao9eEZuI
         Aaq6QH5zc3YsNGGSkYAzolp/GhqLSbK5bD1+Ik4YlRTc8ls4huIZfD4WIy6/o0oPBGAO
         OSaukAeEKjHVQO0rcvL1FjKW4YZ83TKQ/nQ3oEYD9ErTZBQXphZBLi2Bvu+4iwnyj9Ui
         TVCp3hw9r2sirNKG4bGEZFX3p9uLlROH0hn3EmbNSCwVFi7xXVIVe5w7rbY1kXtY0tMh
         nEAA==
X-Gm-Message-State: AOJu0Yw4g8VxUotBSFJ6C/xpgWRSy2aW5qdRrtdUh2cvQEsXP0cImfB4
	bM9053u537u0yTvRckN/hg97BHaLdGSwp3w7gENmBwopi2xQs4arDmJm6yy8jeiURxJxk9F7cPR
	PrEeVFp5h29mP/Zx156YmJN24pUYzkHAgvj2Yf7p+q0WDlTDic2LoQUTf8B4hEWUlxH1Opq1kY+
	BoLl8IKf+VUy+J58kwzG8w9TdPTNshRs3yzbtVgGig+Q==
X-Gm-Gg: ASbGncu1xGfq4G1J2o18TOSKmWwtRmX18JOMM/FYWLGqrdVfdhXMCSH2p68mSadEQHr
	rJkdczKtQ9obUPTo5ACb36o48Kfs+DoA61byTkWA06Mi6v6tWWJAEuA29iS6MuDnnSKuCAz3UUb
	Q3BggvPU6oMeQLgxFHHI4eVEkxisvx+uRU0kmpdbuqxWDLPe6kE+E/Lgx4d3GLnV3fzuBdMEa9y
	TjBj/TPT8xKpKpkj6y8mcc5s7JpoVkkvIls3aHbdsAeyt7MbAiDtgsOmWwaUDlhkLdo0eSqeW0L
	sBmHIi0jxwlTZz5LuYGu6g36BBqTzuLHoPbIOYvfejCPHg==
X-Received: by 2002:a05:600c:4fc5:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-459f4fafcccmr33943165e9.25.1754681534212;
        Fri, 08 Aug 2025 12:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwYL9KJsxIX5x+DDFE5d8rhvfcgsu77l9lAsc4U6sL6PMjtSZsj4iEF5Qn2AGUfJmjvp/QNQ==
X-Received: by 2002:a05:600c:4fc5:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-459f4fafcccmr33942925e9.25.1754681533755;
        Fri, 08 Aug 2025 12:32:13 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5869cccsm164906135e9.17.2025.08.08.12.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:32:13 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 0/3] Test file_getattr and file_setattr syscalls
Date: Fri, 08 Aug 2025 21:31:55 +0200
Message-Id: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKtQlmgC/x3MQQqAIBBG4avErBPSsKKrRAup3xqICkfCiO6et
 PwW7z0kCAyhvngo4GLhY8/QZUHT6vYFiudsMpWxVa1blVyMwUUlt0xu2xTQeQszN9Ad5eoM8Jz
 +4zC+7wdZaC0SYQAAAA==
X-Change-ID: 20250317-xattrat-syscall-ee8f5e2d6e18
In-Reply-To: <lgivc7qosvmmqzcq7fzhij74smpqlgnoosnbnooalulhv4spkj@fva6erttoa4d>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=e1W/HcruV/OHIdwnbStEI9Ov39lexljtbC+tMPtG4Sc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYF7O0JaJV84xn7eAVr2uHzm1M9NxQxvJhrmfal/
 O+fjvyrx852lLIwiHExyIopsqyT1pqaVCSVf8SgRh5mDisTyBAGLk4BmMhFXob/Gcqfu7w0si8e
 7br0e6dLc8HGI9+LmY47Bu0/6XRGqc53KSNDs+L5bXsDFZse/ViWNPlG2spNm8peFq459FgwV8H
 K7zk/NwANSk1K
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
Andrey Albershteyn (3):
      file_attr: introduce program to set/get fsxattr
      generic: introduce test to test file_getattr/file_setattr syscalls
      xfs: test quota's project ID on special files

 .gitignore             |   1 +
 configure.ac           |   1 +
 include/builddefs.in   |   1 +
 m4/package_libcdev.m4  |  16 +++
 src/Makefile           |   5 +
 src/file_attr.c        | 277 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000     | 113 ++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++
 tests/xfs/2000         |  77 ++++++++++++++
 tests/xfs/2000.out     |  17 +++
 10 files changed, 545 insertions(+)
---
base-commit: 2cc8c822f864e272251460e05b0cba5bada0f9ee
change-id: 20250317-xattrat-syscall-ee8f5e2d6e18

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>

