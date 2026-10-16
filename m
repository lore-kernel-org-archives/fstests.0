Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE837EFFC
	for <fstests@vger.kernel.org>; Fri, 16 Oct 2026 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142131; cv=none; b=NXIGN8leeMxrbmadK3mVq2WTnWzfq3PInDyDDH36/Wttausd55iuljho35D1kUDkXv9RFpKRV+6UIzfKOuLt3jE3SukY0+kcY4s4zV5bZO+ffA8aEsxUACUoQak2viQIdoGI+8NOBIzdm6loKlsMBriYT1/uZu+h6Ru+nIiJqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142131; c=relaxed/simple;
	bh=ffkoKDIdGGE56y/QSI0VYZgfQlzr+u0AHAsPiTaWUvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuHTkoPuNRzSj2W2AIozJ8+UA+z9bHKrC1hrh4AAhHPP20ySkhYPS8DXCi4WIpDHaqq/DQ8nBk+cCQOvYPIehVsXtfD98lZpwbb4R49+c4fqRcowogPQMkjcBR2fKVfjEJke/siYvaHqatzrVpISG6jJ3HT0jgzDvd3lvGTX2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+wvjPaX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqbmSh+M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+wvjPaX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqbmSh+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792142128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cGD28N5eS0nZxh81/Vm4e61Bi2VqoNQPqUMCznEkaro=;
	b=K+wvjPaXO1txTtWyJRx4gw1N5WxGg+nMaQiEThMSFQ0HyuU3VIt8LGuYv8POdX+bkIWq5x
	ypgp9mBZ9ZoTa/vqdFgg/BFSpikzbg47VyrQ1qPJo+bVlB2LgrI+9Bk6UMSkaeK9fxCWPB
	lLSXyI/FMFru5Fh0kgBldm2FagOzpvs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Q7cMHaPJOcyIaSE0Jn3Gyg-1; Fri, 16 Oct 2026 09:15:26 +0000
X-MC-Unique: Q7cMHaPJOcyIaSE0Jn3Gyg-1
X-Mimecast-MFC-AGG-ID: Q7cMHaPJOcyIaSE0Jn3Gyg_1792142126
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a022fee32fso47612475e9.0
        for <fstests@vger.kernel.org>; Fri, 16 Oct 2026 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792142125; x=1792746925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cGD28N5eS0nZxh81/Vm4e61Bi2VqoNQPqUMCznEkaro=;
        b=dqbmSh+M/thKkGxyV3wHhYBHoAvXx8S2ZbGHGETxnMyEDnRrYoPLBbH/thOauGcD5/
         h4Z745q1pEw51p+c3FljEH1jsWtjSCm/pUyeTSi0ONFG7ui94e6qMsZrj2xCzaG6jsUF
         m8Oh2YeLAlj54Mwu2q1ZahUInAZ/eChuzBOQOG3RVV2aKb+QsMhYUEKiLOAbVFJO+fbA
         ybfl4BoHckOVg7uF1SdbO/dLEvoVHFiFx0TTx4ndnMjX6XmerkUVrWTxwaPqtDH927sO
         hsR93atzttsAf9mxvhG4xmTHPN2eW0LZ936EVT19JLXoOljuzOzcN/I2SpmEtzNNSAZv
         7WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142125; x=1792746925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGD28N5eS0nZxh81/Vm4e61Bi2VqoNQPqUMCznEkaro=;
        b=RKEnzFfnRhL//fk3xqQtb4o+Y2u79sXJD5w5FPjhXUHluAQP8zq2R3kLru4aAbe/RL
         DeXpOedxuYxVm6ZlbN7XXTIeEfBMdMWgch+UnLS9LT//111f8DIqChUHUtJbi16pDGns
         pmyPtjvjy9icvcq1wnR4j3MNZQ+JnAa4x2zZZhw/CIyZV4PXlfH/XXz7g2OEfaFnZPq7
         gxVyNGc6crtCGpkRxLzLI7PBzyzPCYaq7REOErZMgny+UqUvSAwA2Q1bMXayapydXC7g
         BVOQfXUmesE5wsPm8nap/FExJwfUU613rFUD/VdZ8i1UnuVLAwKg09deRe9O2tklq3vF
         x2vA==
X-Gm-Message-State: AFq9FYK4lanlzaNDvXJku49M1+gV5xwkE1GbAHwsXj5yv0VaCBuf5l1U
	ySdt+2Wy1dWPoRiD7QVtZk1Xkcqd5NFsCsCoTQJW7pgYfX4DWrMEoPXm7WNPip0iuP9IfzjcvJu
	RczA93RGAXBzWBb3Uqx9hTA9/xHDMB6UF6pFUhrG7GGyCrn7OatpD90QLvK0=
X-Gm-Gg: AYBFou1XCqD2MJdL6vE1OCRwXVTFilp/ZFbzN8uhD9bhmerYVvNPshuuHEn/xRx6Rqa
	yuKS/Cndn+oJ8IxrIOF9NLM19JHfcaiVpyzjAegP2x/6UjxSskOL7O+0tgdTlpjVMA6b0P1gQ2p
	JpSj2lcU+LxfK9SdpkjbCFpbWbZr82Gda0pD/tX7gpC2EKtY2SY3m23IZMHXHrMJ5EOrFLBa4SE
	9plOBYOc6/4ZVsW7R25wfF22vAZ0ie+3QdA1cGVMtc0iw1yl3g/LECLuBjYaeyv+fwJciWr4bDr
	okL/tEu2q2EjMm57+2Mlx7Nc2zcgpow2fjQ7mA/fUs+S3mGhwMHdYu8jyXBOBIFbh+bvXZLxwFn
	vRcK2
X-Received: by 2002:a05:600c:a0d:b0:4a1:b187:1314 with SMTP id 5b1f17b1804b1-4a1b1871350mr181535435e9.7.1792142125559;
        Fri, 16 Oct 2026 02:15:25 -0700 (PDT)
X-Received: by 2002:a05:600c:a0d:b0:4a1:b187:1314 with SMTP id 5b1f17b1804b1-4a1b1871350mr181535015e9.7.1792142125214;
        Fri, 16 Oct 2026 02:15:25 -0700 (PDT)
Received: from localhost (mx0.herbolt.com. [5.59.97.199])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a1cca30aa4sm16423035e9.2.2026.10.16.02.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:15:24 -0700 (PDT)
From: Lukas Herbolt <lherbolt@redhat.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	hch@lst.de,
	linux-xfs@vger.kernel.org
Subject: [PATCH 0/1] New test for ENOSPC and ENOSR on pre v6.10 kernels
Date: Fri, 16 Oct 2026 11:14:37 +0200
Message-ID: <20261016091438.294872-2-lherbolt@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests covers the XFS spurious ENOSPC (and ENOSR and if only 6773da870ab
is applied). 

Two new helper programs are added:
  1) src/fragment_fs.c - will fragment the filesystem, by writing user defined
			 file size and then deleteing every n-th
  2) src/mix_buffer_direct_io.c - mixes buffered and direct IO to the same file

Adding Christoph to cc as he is author of the fixes.

Ignore the first email, I mixed up my indentities.

Lukas Herbolt (1):
  xfs: add test for ENOSR/ENOSPC on DIO into delalloc extents

 .gitignore                 |   2 +
 src/Makefile               |   3 +-
 src/buffer_direct_io.c     | 154 ++++++++++++++++++++++++++++++++
 src/fragment_fs.c          | 101 +++++++++++++++++++++
 src/mix_buffer_direct_io.c | 175 +++++++++++++++++++++++++++++++++++++
 tests/xfs/842              |  63 +++++++++++++
 tests/xfs/842.out          |   2 +
 7 files changed, 499 insertions(+), 1 deletion(-)
 create mode 100644 src/buffer_direct_io.c
 create mode 100644 src/fragment_fs.c
 create mode 100644 src/mix_buffer_direct_io.c
 create mode 100755 tests/xfs/842
 create mode 100644 tests/xfs/842.out

-- 
2.56.0

