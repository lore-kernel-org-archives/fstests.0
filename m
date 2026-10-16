Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE336472782
	for <fstests@vger.kernel.org>; Fri, 16 Oct 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142029; cv=none; b=X/ukOTvJnKrOFH3wCdCR5htDU18kq7U8dHt7ajyJ6S/Z953YMs77lSoaEE112DCVsxL0JIstlALbmwBnqSwTm74NmT0AlHmeUwTBQC9ldohQ/dsGR+CB3AnXkJGSs0FWMmn/yb1KEdYBYyEHn8hzi6qLw2oRIfLVF9sAklwXSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142029; c=relaxed/simple;
	bh=CtH/Vf7ari7AB6RWWGf45YDue4zz6p+iLIVLPULLBz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffa7b4Qohezb21eYvYjXBKZmtHfVU7xgp+ifYFLVdLo7Nvvddm7KAGlctVKLT1f5gBuzJK+Fg/xgj8Ks4ln0Bjdq4PCACgnlTeljz4VnRyXrml4XBdR9nNY8/pvUT/LlRVa0zK32H6PBTDoo+o5hYF4vrdqX4RsqzigMZlNg7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5lgik6Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+u/N09z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5lgik6Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+u/N09z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792142026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nvyep45+Ocd9G5AEE7LTrvRKFFek8ljG1vClwySaUIg=;
	b=S5lgik6QA9HXGhDPUdIEbGNy5yJKgl8aW6tRfKW88EH37+pV2HUjQhHody+Ca4SZOOth6s
	DFfHAINj3YX5mBK2AN4Cl23b+8/NKnOjAflZyjBvLVo5f0AKgiHzw5pfT2adYGOz+VApwS
	ihYqHrjHZOfoVNla9O3N5MeCAzuVtns=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-b1cyb5zRO96K6Nxmozosyg-1; Fri, 16 Oct 2026 09:13:39 +0000
X-MC-Unique: b1cyb5zRO96K6Nxmozosyg-1
X-Mimecast-MFC-AGG-ID: b1cyb5zRO96K6Nxmozosyg_1792142018
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f9d150c3so3864273f8f.3
        for <fstests@vger.kernel.org>; Fri, 16 Oct 2026 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792142018; x=1792746818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nvyep45+Ocd9G5AEE7LTrvRKFFek8ljG1vClwySaUIg=;
        b=M+u/N09zukkRiuT3z//Tvu8kASF7zuDgvhBXAZer3bpTRtUKO/4iWo6a+0HRJPXa0R
         a0BYJnWPJGD0RgB+ukPKPSPH4wciJmuPOuFxbPg1KNIkrep9Tm+uxD4ejVA+9l3f9uvk
         1Y48gsdRPv3j8JvXb/QWhoTu2+xfNBNEe1/v/PmtmqwM1iX2Uta6D7KRglplGN8WO4uY
         0V2MNNzSCETx4uiXqQ4yp0RPgVxIPLAoMFph9U7Csn9+ZD6ESN+FIqUSyNYYqUBQnVI+
         KdyfMQACCfODeQBkLVgNG4wFx5pQDbSzcT0Rhq2XxQfkqkPXE3livgs9M/7vB4vAKpx5
         VCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142018; x=1792746818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nvyep45+Ocd9G5AEE7LTrvRKFFek8ljG1vClwySaUIg=;
        b=UVBgwEZsXS4Pke3wKi5T3YdYQ+ZS2KCiXhEvEiVL8rck1+jOop23NI4O7pbF/XGLOa
         setSwjr6UiXuVorvUAdfnsroqUo+HOngFjs80U1i5LLr9K7BDYhuhS9pM6CeTo2ec/xy
         k6HIKiufDubAOWUufQaVj9g2a/quM4xwZS5QbWNgM56pQ4l6v2OytOpbSGAdPICCG4Gl
         fi095K+xyD6crqj2NFt93me4TXPMhSRp+mnpFJ1PMjngR+Zc8qNGWZObx7TGtYcAxlNp
         dv2lr4FuBZxWCTwSw5WnLDOWMDD8DEEKeFayYktcwQ8XVX+kk7NPRjTUELNXKGwfN8MO
         2qMg==
X-Gm-Message-State: AFq9FYL932qyRag+BZamu4bpJ7s0oIdpuC4GhnBQF29B9LZ+VgU1OI8M
	gYFpBu1ob8wAfsiSXZU2EaVyU3JznXvwyFVB1dHtHj3Eqsi6CVjgN75IueyPXm7Jh2d8w/h6Mql
	QyAPVAvAaUGIRUOz6cmBws+8jWZ9o8VZsXnU3U8aSBM1HjyN9OjjRrKdZN0f0ArZD7b4=
X-Gm-Gg: AYBFou06UMk947uQzc1Teky+6A6Lswl6W0UxhKoCmrDfDoBETNCvG3xbyX+r9kDfvXM
	WTZWqMnWXyEsMZ/oI7mHFg+nh2jF/6Urt0Esd+ty3P8PWuHy2GqG7yjrKLejVtn62HaKQfzwlkU
	BOrTtS7dfCWSJsJucXZysNOm2xW6qLPqkUVx4k5sbzi5ou8vOGpBOvWczvjoknldGeKXW09oMsi
	AYx53aeVBmz2Vxrhbs7E9P4xiipyk02au5QXFo/82ckVn68pM0sDQ9i0h4AxjUNNqW7VspGKVuI
	DQhVyO28L5K4uqAgNkRIszB46VAE3AMWuDGfxoBp5FI2Nfwz5hOWGAtBqzlWSKtosm005fJqw7N
	LLUqR
X-Received: by 2002:a05:600d:8488:10b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4a190780997mr303070995e9.31.1792142017807;
        Fri, 16 Oct 2026 02:13:37 -0700 (PDT)
X-Received: by 2002:a05:600d:8488:10b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4a190780997mr303070785e9.31.1792142017488;
        Fri, 16 Oct 2026 02:13:37 -0700 (PDT)
Received: from localhost (mx0.herbolt.com. [5.59.97.199])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a1bd9b303csm130227205e9.8.2026.10.16.02.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:13:36 -0700 (PDT)
From: Lukas Herbolt <lherbolt@redhat.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	hch@lst.de,
	linux-xfs@vger.kernel.org
Subject: [PATCH 0/1] New test for ENOSPC and ENOSR on pre v6.10 kernels
Date: Fri, 16 Oct 2026 11:13:10 +0200
Message-ID: <20261016091312.294645-2-lherbolt@redhat.com>
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

