Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07634AAEE
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035520; cv=none; b=U2wZTvYGJz80xbfCC/cDzlWf9SDvcXaY5HEXRcO4RNq8twSEbxOU2sUfQPQ98gxRBswehIn37RkL7gGO2osInKplK3fLSEE7jV55mc9k3hvhQn6k5vtmEDvuVz6VpTR15BmpPzvNw+jJCYrFE179R+WKLCo5IvU8UBKtIsms+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035520; c=relaxed/simple;
	bh=zDdgojVZPZOXtRaXh6vtaGFID5TNfg/+i716B/FSmWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WWWmTkavDlt67f8Amy++o72ohWCtZvsAN8gsTLebKVtoO1NiJ10bT0F3RDW6Fp9y08MDniLA4RjsvV94fr7XIwjwXRaqy4vMFhG8lVbMD993CrzwAFnlhDCs5kddRG56n099OJ+gFC+EmC84/rU6EqgeqHTLa4FNihHk3cHVPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZnGUrW9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZnGUrW9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26799bf6a2eso19863545ad.3
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035518; x=1758640318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhQUyNEwtupyTisO/JTGBHAsyEjIO+DjLc5O+vEyEHA=;
        b=kZnGUrW9ILWyE9UWeZkJkwzmg66EU5ryhzZW5Q2UZEZLpzyGmzViQVBzrn6JMvJL3Q
         2WZLzBQ1CI/oVyEj69SRYGQq3+BelOKsfUPqbLbDUngmqbYSxwG2sAflZTu2jym4FHvj
         qGJiFiirXkBwbQ460KMxtVl+qjzW3cmUqvKxqLHrmsYqIyKtL2RjO9aFEG1xNpqRTIix
         1NBn5/f1NR0MQhP0nHtoyYsxo6f0/H8byN/fS8fPXm8jigbY/dh4HZxOgacqJPMyP1aI
         mmrHUkzKiUgDVCZVzGmViESPgKlIbuCRAfthAB/RS3do2Uw/Aosz1YVfpG639BjfBMXL
         fcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035518; x=1758640318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhQUyNEwtupyTisO/JTGBHAsyEjIO+DjLc5O+vEyEHA=;
        b=vodUg6fiTUrrdcITdPqcOykhku1Oi7U5g9aRluXjxiMD4iIJ4DcinWqcTkAp5cVVsu
         7oV/tlOOBs2tY6ivNL+qkSxEN9l23hq0O3cw0VQufuVG3kYjMSVV+LEjKcEYZmTqMWkn
         /Q8HfakoIvOEIiOvSylwhPd1t0sd+L4ilG4HiZrT+GpDi6ExOvdJ2LRf1EyZ+bylwJq0
         WiH4jM62Rob5FI4GYFJMkhJGOAX9wxF7C022EZW05kTM2cfYec2pey6gL8JXA00pmEPL
         Nbxv1FYiuS3qJeyc/yYAvi1iS3jrp6T6VYPnsaOSoNxQWVZP1MraRWVBcsqZ3BcSwV+Q
         UPyQ==
X-Gm-Message-State: AOJu0YyoQG9+lGZNSrAjLJOa4wQVrL5cODUpPTJR1mbO5aWFNzKbmg/6
	6ZzVEB+cgn5w4A/RXnLLO3CnLtQ+GrZHKMfF1vTtuh4tmyABPJt8tcsZIpOb+w==
X-Gm-Gg: ASbGncuLqbagjouo7qzlr0PUqk8eGKbUujBtq2f+YtN6imkcqWRfsSm4zc7igSJ8XMy
	bQDYjOnYD3IIaqO43sHIGIUzMdTBLMkHo/OrikBerDT0CIhbZUEMeKY7ZkGkVbAXVnI5Wsckxap
	psqKeZcS/nSB/FS5xBZruWrkmuAURBvhZBoLTaUAsyQrVA44aBHESbRL04EdidRa2Z7+5UjMPPf
	RnaBXCaN88C9Li79fLTfb6FCJmxSWmgutS5OiRl0lkgW0qz4QWi0y15xVNweiXjinwB3l8s8vk7
	fkVSg40yjcgXlgc2eRmsv2QkIe3E7hjZy0S+f6vD5O3n4VxFHuysMkpGeVDx4jxzvXB97ykEZ5/
	UdFBHh3UNJEe/6weJL3Wf5Z54Gyg=
X-Google-Smtp-Source: AGHT+IHMSNxfXtB57j9Mgly5q+BDBjiMO0DtseJli3jDPBs5VcYStoJNPmdAjvjW6ef+WH2V8vpqAg==
X-Received: by 2002:a17:902:8606:b0:24e:e5c9:ecf7 with SMTP id d9443c01a7336-25d26e43dbbmr130153575ad.34.1758035518220;
        Tue, 16 Sep 2025 08:11:58 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a750sm164780175ad.83.2025.09.16.08.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:11:57 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	bfoster@redhat.com,
	david@fromorbit.com,
	hsiangkao@linux.alibaba.com,
	zlang@kernel.org
Subject: [RFC 0/3] xfs: Add new xfs multi AG shrink tests
Date: Tue, 16 Sep 2025 15:11:29 +0000
Message-Id: <cover.1758035262.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds several multi AG shrink tests based on the RFC[1].
Patch 1/3 adds more basic shrink functionality tests to the already existing
ones in xfs/163.
Patch 2 adds tests that checks whether the filesystem is consistent
after several xfs_growfs operations(filesystem growth/shrink).
Patch 3 adds a test that repeatedly shrinks and shuts down the filesystem, thus
checking the log recovery correctness during multi AG shrink operations.
Tested them with 4k blocksize(on x86_64 with 4k page size) and 4k+64k blocksize
(on ppc64le with page size 64k).

[1] https://lore.kernel.org/all/cover.1758034274.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (3):
  xfs/163: Update this test with multi AG shrink sub-tests
  xfs: Add parallel back to back grow/shrink tests
  xfs: Add multi AG shrink + shutdown + recovery tests

 tests/xfs/163     | 162 ++++++++++++++++++++++++++++++++++++----------
 tests/xfs/163.out |  23 +++++--
 tests/xfs/333     |  87 +++++++++++++++++++++++++
 tests/xfs/333.out |   2 +
 tests/xfs/611     |  89 +++++++++++++++++++++++++
 tests/xfs/611.out |   2 +
 6 files changed, 327 insertions(+), 38 deletions(-)
 create mode 100755 tests/xfs/333
 create mode 100644 tests/xfs/333.out
 create mode 100755 tests/xfs/611
 create mode 100644 tests/xfs/611.out

--
2.34.1

