Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC1202C5C
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378186; cv=none; b=sK9EAmsItKuXF3yLKyBDXVOMAr7gmVXcBU4SrVEmIAoaTVIyl1bpQe/dAa2C0hYK/6+IAG7eU9h2xLfSf+jj9nfnJioUM0BBA77HWkiVBh/IUd2w1Czlbc+ojlR6950V0LxRb0GVleEGh/VGyGXa9TlcEzxiTJ5q4t6MwOqipuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378186; c=relaxed/simple;
	bh=I0er/MqE5O+wigM+Y1vZZeLPauEIwgEJZ1xzUyKtVMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DShAi1uL74GBabuqCHLe4WHDtkGe5ROAOa8Te/rvwpSTC6X81fvj086RlKh5QlAhs5hWgVQw1JpZ9N+ntRI2OxNk3bsusis9WJmc+1V1Q89T/qjNZLezYWSmdK9+TxyFuWXY16znIc3Em804ifxCCuQQLJcFjs48cUO+QBYhYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3SnFiWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3SnFiWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742378182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BEz71pKtkuxVLSrhvrBikIn7Gb/ARkNGdlQGhYTwQ58=;
	b=Y3SnFiWJ2xWa7rYg9Yvti2aShSr/WRMNjhQJ6ID0VTg7GNQg8mZyV9OnUrcBqS0k/m18DL
	ptHsAijeFzQUSBVBJGcHOCGyke7EjX4t35C8dmFaGdQDmCDLufK0V5dA24dDmtnqShxMI+
	lgHhMLqGFR7u9dbFL4Padbv72xyWpbM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-iEEIUKoaOkSmwzWfDxKaqA-1; Wed, 19 Mar 2025 05:56:21 -0400
X-MC-Unique: iEEIUKoaOkSmwzWfDxKaqA-1
X-Mimecast-MFC-AGG-ID: iEEIUKoaOkSmwzWfDxKaqA_1742378180
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e6b2b8339fso6249603a12.3
        for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 02:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742378180; x=1742982980;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEz71pKtkuxVLSrhvrBikIn7Gb/ARkNGdlQGhYTwQ58=;
        b=xEu/h4QHB9FO9zryXkQ+oHq8SX0fEe/XjIH64d8Y3o/4WtEV1VzHvcCQ1JAeLvFnXA
         K5E50H9rfd2R8c4L/vvvVHb0NXkmwCZPUcR5l3XcOSwpQU46Kbxi6UdvqE4cPYp2OH9w
         8qGk+40vFdcJzVg7GMESpzvTvcdHAJjdGPSxLxMZ4CcypNJlbvmp7Ssm2tXVdtSllqll
         F9+e9A9V/CQWYD2i39ai66MORFK+gwJo9/D0oiI14iKECDqOI8aOedzHRMKI4WoMWZPx
         UrjsiwAveQAsXO2dEBR3G1ntNjm4nCvFHKooHXErGUjP3SgNqyCFnD00D2cqNiC38BKW
         k4wQ==
X-Gm-Message-State: AOJu0YxDU6qmao4seOSQITYeE/WbHsAm5JFdidShn9L6SLoQDQeXHSR8
	u5Fo1tvACkrvFsmX5QT56fE48DyW7JXSmkbpZqOYYYq522R8KqrxBt2sgIkwXVSgNajAu6tvJai
	kCc02o0Np9gQNp7P92Y797eKLmAxvMaXAMd7IyGOUofNM9pupzYE/jcGFPXgd3A==
X-Gm-Gg: ASbGnctuGIUmRTww79rzmfZ3GwkUZ/XPkNNEakg4mVqHarm18fxqxx+DjvSIqXuS2iS
	xB/6Ql8yoj61fBQVMJewh/5tKxJDpBTNsZv/h+sKMfFwjLfR1d0/Mqy/hp5NLIPkrkXmIC6FniD
	B4SfxpjaBOOe+JO7EJHJYqVvGj06+V4ed7EuP+8rcDXqlFA92/jlToEoLjtPOkBZzzDW/2KS0BO
	7rDcIcOw3ahqL6EnLx/rpS/sp9S/XI7uTPF1G1sQA2fcb/aGpMTkYUz/TdecEOM/c4e6ySxHr8X
	mQ9SlDhegb2N6f2Pi99VDhPyNTKFzg67WWhiyijh4Q==
X-Received: by 2002:a05:6402:430f:b0:5e7:97d2:646d with SMTP id 4fb4d7f45d1cf-5eb80d05e06mr1876722a12.2.1742378179672;
        Wed, 19 Mar 2025 02:56:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFaYLLnFNk1mvbm+NiVb34VzN3R5KCpJTgq9ejviX1tgfeRbUuaSFFxYINZsZnBBCw44PMUw==
X-Received: by 2002:a05:6402:430f:b0:5e7:97d2:646d with SMTP id 4fb4d7f45d1cf-5eb80d05e06mr1876706a12.2.1742378179228;
        Wed, 19 Mar 2025 02:56:19 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5eb5c958bc3sm1759621a12.51.2025.03.19.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:56:18 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 19 Mar 2025 10:55:56 +0100
Subject: [PATCH] fstests: update missing gitignore entries
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-update-gitignore-v1-1-6664aab9df35@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKuU2mcC/x3MPQqAMAxA4atIZgNp/EOvIg5FY81SS6siiHe3O
 H7Dew8kiSoJhuKBKJcm3X2GKQuYN+udoC7ZwMQNVabHMyz2EHR6qPN7FGypZlqZWqYOchairHr
 /y3F63w9pF/0aYgAAAA==
X-Change-ID: 20250319-update-gitignore-60420f206207
To: fstests@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=I0er/MqE5O+wigM+Y1vZZeLPauEIwgEJZ1xzUyKtVMc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0m9NObS98KMrv9aHKcrq4dwblY9e8+D4PnXp5feaM
 Xc2LWfsOzi7o5SFQYyLQVZMkWWdtNbUpCKp/CMGNfIwc1iZQIYwcHEKwET+tDMyvD+mXXn03JYj
 6+2/xQgl986yjX98MVZ9mRp7ipaJlKmqFiPDzCJPzp2Jv4tXf22Z//Sy4vEV6burTdS+/Ppo/o2
 3QiebAQAfCkl4
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Some build artifacts seems to be missing from gitignore (list them
with ls -l src/*.c). Also, add autoconf backup files (tilda).

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Minor patch to update gitignore with build artifacts.
---
Compare .gitignore to src/*.c

diff \
        <(grep -F '/src/' .gitignore |sed -E 's~/src/(.*)~\1~' | sort) \
        <(ls -l src/*.c | awk '{ print $9 }' | sed -E 's~src/(.*).c~\1~' | sort)
---
 .gitignore | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitignore b/.gitignore
index 4fd817243dca37715d9a6ca52afa0f7fecfabc64..9b44071f8de3d43536e0a59c1a4a7416d6525f85 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,6 +7,7 @@
 .*
 *.state
 tags
+/*~
 
 /local.config
 /results
@@ -37,6 +38,7 @@ tags
 /include/builddefs
 /include/config.h
 /include/config.h.in
+/include/*~
 
 # quilt
 /patches
@@ -210,6 +212,13 @@ tags
 /src/fiemap-fault
 /src/min_dio_alignment
 /src/dio-writeback-race
+/src/enospc_unlink
+/src/iopat
+/src/md5
+/src/scaleread
+/src/btrfs_encoded_read
+/src/btrfs_encoded_write
+/src/fsxattrat
 
 # Symlinked files
 /tests/generic/035.out

---
base-commit: d71157da4ef4cfdbf39e2c4a07f8013633e6bcbe
change-id: 20250319-update-gitignore-60420f206207

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>

