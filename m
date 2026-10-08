Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C043846B
	for <fstests@vger.kernel.org>; Thu,  8 Oct 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456820; cv=pass; b=Oa1GRZRfeVtYhlAu1k/tJI8Bz5GQwZ5JJay/sZmPRIXZnHxU5al43h5tRm1HMKOIwUIAZFPmvcU1zulubYcfWCUh2nSSYGhdM+fqNadAC5yrBQRrCNue9W4ErI7WmxsIWUiTiO8GoLSzGFsAY3l+VX8veQ7GfttF+6K92YurWM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456820; c=relaxed/simple;
	bh=Y4fyfcQSH1fht1ENIEiaER3sPYluHfnLd38vJ3h+S38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+8+9h9XmuF8togqMUKd9QpydWMelP1EisAy5hv9dLkDaxXIFvSEPfnQCnXkz+4l6w7LJbEwNH0xYaw5k/G7bxTZWV+kemmDPII4tOVhQeY0nuBb776teoX3rRXyBqXcNiNLJIYFJzPgzDB7zjQk1PzKy5/js521J0/fqq42ueE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9cBkMdX; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9cBkMdX"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5337fa12431so204821cf.1
        for <fstests@vger.kernel.org>; Thu, 08 Oct 2026 03:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791456818; cv=none;
        d=google.com; s=arc-20260327;
        b=h+zUzExZhLLD//zPRMRj2VwmUbLrSQxm9tEGzav+7RFyXtIVXi4o5gpCMZAqkwGr2Y
         aNzJ4B1zW8c/fK9ie/L5wiO71VnbUQV8FScPgbM9uIIeXo4G+pwZhhgWVuDY5wCTjRYL
         l+wlGe+9Y8DrH3Bn6/Dxiw9pYMGcidaGczv7m/JjI4yM+Bh5p/7K2azgDTqlKIqffzsI
         vvwOYBUVTfkqK+NryQOC6hc8hGWrgGGGM6vC9Vl0WIpJrjEVxuKEHfCIOYWSg674JUOV
         irEbnXhtL64jwMewkn+4fG+QNSk+KtsohLW28U14YjYRHoIHsKEJz8NzNkSaVbFPKvZ1
         GY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RdIfW0TB1524JNRu+zC/enwNslep7VME5A2W7emIiNg=;
        fh=0T2m50aTd39Z+8VctvI4BSkmn8seDHAD0oNGCrDxMcE=;
        b=KtikOsg212pTkF1nE0R+A6Mow/Wytbh6ucl0JukbuBO6/+6ZuabeXsBWRfE4dNMx6D
         J8SumpnV0Oh7VysrVmuqFPJcSjfneQGyu0ev45HKHSlCr0McPSSZhN3hieM5ZtHCqRIn
         DkGs/ivTop/qa+sbdggKNOqk0nZlrdACIMgA8jNhefPmrppHHtKZ1rFZzvq5d9A+fLwO
         EBgkmewEhCyxorpSaqIC8VGBYvo9gx+PDh0pGJmCexFGiMKuMaaWUYKRagEKEUuHXE6N
         KUPIqAnmKruEa2ttrpLa/bDrI0et1K4O56DLmQYhXq+RAkrFNT/fGg0Z37JIplGGShPU
         Os7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791456818; x=1792061618; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdIfW0TB1524JNRu+zC/enwNslep7VME5A2W7emIiNg=;
        b=t9cBkMdXHwvoaafXHydnqitQcYnwJAWOBtgzk5KE9voimuVt1WhCPR/mpKIk5dNRRH
         qSIe3Oj0uLchyReh+6TYbv4DUT3rcUUOEhrvpg87lnZpxwMJGvCfHOvkWdnUS7A8SH6K
         8phA2OaTiMg55l7E4lQTrjio/oYc8h98bk9Sok+m+yWqR6X9QXwsf7d3OyrmlhSoAdLt
         1tiDtXV0m68igQHLVsvZuR7qYtydQEYCr50k6Y6pqLjF7ZqGYQHPtU77PyOHXbX7vJwO
         y38MQNyR66RuJbRVmMj1Nahrit2EQ25Xvlp1DEQMAMKXQ7u99zCzb5dOlt9z7u76HHX5
         E+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456818; x=1792061618;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RdIfW0TB1524JNRu+zC/enwNslep7VME5A2W7emIiNg=;
        b=JnBizxtUKVjYLvghkTajX6dZLe8rmJunFfAI4dl/L2+egHHY7lghrhdjncW/KY0yyZ
         ZcKR3Hxu9DLcUzS7D/93NbqdqUguYKeiRVugkP8laLF49MDtoiTPy43qkpBXzm8lUDYA
         ZNAh+aJ8/F521XF6c2JH6n+m1KA5VOaDjsIfQQdJHd9UPP1u0k6IEpbmlMGC09HDWfcE
         Y14LIvxtwSONp0U3fhhpaSJTL1+VQM75E7ywHUWI+0pzAfRsaf0j7GJA44RCSQD1YeQP
         Ao1I046P28d+FxoE+iXGVsIbCF38+VyzaNgbWsZWjFQ126Meb/7QEtZq9qnQx8IXkdem
         J9kA==
X-Forwarded-Encrypted: i=1; AKwUvBz8Kj3um5uQDYir/Cl5yD6AG3XU/C9vyiFTPrJ9ueCg/fF0b5YaxK4SJOH2jfL1IXVvX50FZFNt@vger.kernel.org
X-Gm-Message-State: AFuF++mrVSWxY9SXHOEtzkqAqQB6WqYwvmRtSsYdr2em6yBIQ3vrp9xa
	6alHzgAKMLzZflInwRt8tQUyJ9fTCju8a87v5keRI1W8G8tjreD6LztAkApwwpZY4UnLrZ89Uvp
	ghmafKnhUUsNfF7cveUzB5gRzfDguI6V27j3+k4/I
X-Gm-Gg: AYBFou144qDsDFMbijCoIc6v58s7tkhHP++Tg4fGNFv+QsjrrSjVO/6x96II8ugeXvj
	MZ1dzeRyB8oaVW5roXAIV69ND7TMZnNSWQWXjN6GsF3JaJNF+7A1R0QGeHShu9Up9SsLQ9uaFKW
	lrYHa5WMYzrxkxBmjW3J8wxenuBDvn3na3U8yWInPmvW+7tmrubnZxxWfO/CEAU0neTrr1rnVSJ
	HWTMJ/OclUcGnjvglhqaAqegGYtKUuxDIwiafvcZtuX8aO3U4i3cOiv239OSiZmyI8cHndEFhDh
	orPFvHuWrg0eNIlxF1XtGq0VvJY896O1mOnAy/T7RYW4r9wQuhGtZ/xbOpwvHmoreBRmGrHUaGk
	I4jo6KvX0KF2ckg==
X-Received: by 2002:a05:622a:8cb:b0:531:282:6560 with SMTP id
 d75a77b69052e-5358ba57e28mr13693771cf.15.1791456817740; Thu, 08 Oct 2026
 03:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008093102.2791457-1-jprusakowski@google.com> <asdjv0byRIgx2DBO@infradead.org>
In-Reply-To: <asdjv0byRIgx2DBO@infradead.org>
From: Jan Prusakowski <jprusakowski@google.com>
Date: Thu, 8 Oct 2026 12:53:26 +0200
X-Gm-Features: AclHuK8T47iztnOQ3wUy_EMdakQ9CJulz201rAPWZy9Jb7GPVkr9zBdUs-yMDfs
Message-ID: <CAHwWncgG88o3dbhHuHYgCoqGZJ_X8C7wLP0S5ppwRDM450jMcA@mail.gmail.com>
Subject: Re: [PATCH] generic/794: add fsync_mode=strict mount option for f2fs
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

> It looks like this sneaked into the other tests, but this option
> is bullshit and we should remove it from the other tests.
>
> The f2fs default is simply broken, and the justification in the
> documentation is incorrect.  f2fs should absolutely fail all these
> tests in default mode because it actually is broken.

Hi Christoph, I can see your point. Let me look into it again.
