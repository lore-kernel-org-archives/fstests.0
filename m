Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF471154BE2;
	Wed, 18 Dec 2024 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555704; cv=none; b=Du/MPQ9bchmm3BBx14m1i8yBOBfTYqBoEaTsa3rlOgFE5OCOE8qTzj6+RF/J6BKOtYwK1b6t7ANamzFufKBB+wuRHE9jmEvZGvVRxl5riNDZeUJIUdSg9OF29tEC6buD+l+Shfx3T1H3KEaC+kwrsZgUtAxi1xE3UW4a3V7bqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555704; c=relaxed/simple;
	bh=1xjpSBxi3kNZg7RwapyHF30o2RKo5JZlGFsvyV8EVys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjkOBBsd8lEChdP9EmedVAvJk6YM/jN/qrIoIqXgcrzF8ASJmVnJorKg99w1p+GUKOmtUMqXZTulXvdz5iyWQ+xOVcIXHV5BoJZVX2K6YBudxZURfQjvCgoYjouGe+LTcu5EH/4P1+3TgHOFB5EFsUYQOvfrbVsXnHKE36i8lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNvycLmP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNvycLmP"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f2896ecdafso919587b3.1;
        Wed, 18 Dec 2024 13:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734555701; x=1735160501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DWw5wVPT+yj2lMwqK7Emk7iKazto2lPJM/4qc1aAqwA=;
        b=lNvycLmP54oZpy0rGVO1bgHgRDTOP3tlhZKm+0+r9BVB+W4OAFmfAccIu8e/Ctl4M8
         OMeLJ+ktFbMDnxlBXZekb/aVJVHhLXN8Gl2UEn82gL/2sLJSSg+FCfTeiPZF7Q2YwMEm
         K+WfybF+1pRKg5xeTQgDtB/PREvS/p9UZcSc5s/JNZWJgSVB9s7diGkdNmvHQVygvjhr
         MCYyuNCpg6Zf3bkh8FvCkqNVbWOHyxYpdJhH5buC9RIhFjPSQjmGQ8T8+PXPRlX1GPlU
         UOA82PfS8PeifC08mllgfmnux0F0FUW9npoJPr0aoVjqKjW8SJns5N+9CFNNMa/kT2T/
         K09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734555701; x=1735160501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWw5wVPT+yj2lMwqK7Emk7iKazto2lPJM/4qc1aAqwA=;
        b=a/IuholBnKhJPE7E6XEBwVRlQt3ZK1Yn2BRDFLCxKHdRDU4NeY/stlELnkqXEZhPZq
         fm8c97OJZZeyiU6LReM8Id2/fNXpHH8WB0UTApDYb20H6BdWXX1o2Nd4sZtRZjRtS8W+
         XlOoIo5afKvR389DIrVhpkKyYb9PdPxR/w7C5xSSu18gupxjyrIA4P0jTow9i5ozjF4m
         LxePqWONOkfivN5LdiWdgduyLpQvYW/QGFsEEJOosIywzzIuoWl339M4iGXJywmq+92i
         kj7bimcDpkKawaGkVE+EkwXkT2jlFbe5pBYKIRt/BZimycDSzIp5IsmlfTTmiZ3IMewm
         o9ZA==
X-Gm-Message-State: AOJu0Yxz5vyYtJHgajWSadEM1ZMygHcJn/rT4vuwI8oIXIzKo5FeCWGK
	80zg+N4zPn59iPB0v2OayEJcvAbfb2PmAFqZvxwQ4kJ9hC7hwql+ckoC3Q==
X-Gm-Gg: ASbGncspjrdI1sYykx/OWUR4lQJob0nmlsNMdY3MPN0MHT6sjcZL+9ANONu5oYSZFjV
	LcUZMVaV86xD3nZu8evq+TqQPowKU4M+O1t2x/REh51KlC/fmTQQqJDzWCNimCbvvXWNefOpy0p
	YuYkTkOGjep52yHEfy8NY7YEWJ4Wu1zcaz9gMn2IK9b9Aou5hHhnd/HU1gvDpjha5BDyBkox4Tx
	8etwx4cbTDhfPT+QN/T81QUnT2VNHUWhcyRRkhri5jGO0SYs4n7UiNl91AGY0SxkHx1p0XUZI+1
	p6qEdM+JTT/vjI8=
X-Google-Smtp-Source: AGHT+IHRqBK9Pl12C5lQNeZYUplq9CR+4j6ZM04lvN1cJQh4U2z72iEuoMFuatnoX+O5gkRAQer20Q==
X-Received: by 2002:a05:690c:3:b0:6ef:63cb:61d0 with SMTP id 00721157ae682-6f3d0e0fec9mr36800207b3.10.1734555701274;
        Wed, 18 Dec 2024 13:01:41 -0800 (PST)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288fc50fasm26124227b3.25.2024.12.18.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 13:01:41 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/2] fstests: test reads/writes from hugepages-backed buffers
Date: Wed, 18 Dec 2024 13:01:20 -0800
Message-ID: <20241218210122.3809198-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a recent bug in rc1 [1] that was due to faulty handling for
userspace buffers backed by hugepages.

This patchset adds generic tests for reads/writes from buffers backed by
hugepages.

[1] https://lore.kernel.org/linux-fsdevel/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw/

Joanne Koong (2):
  fsx: support reads/writes from buffers backed by hugepages
  generic: add tests for read/writes from hugepages-backed buffers

 common/rc             |  10 +++++
 ltp/fsx.c             | 100 ++++++++++++++++++++++++++++++++++++++----
 tests/generic/758     |  23 ++++++++++
 tests/generic/758.out |   4 ++
 tests/generic/759     |  24 ++++++++++
 tests/generic/759.out |   4 ++
 6 files changed, 157 insertions(+), 8 deletions(-)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out
 create mode 100755 tests/generic/759
 create mode 100644 tests/generic/759.out

-- 
2.47.1

