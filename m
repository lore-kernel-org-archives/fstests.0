Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336692;
	b=kd3ytsW91+jjHS5r0fVsf1jBUVm3mdtAfap6C5xBKuT5vsULQXwTSP6LuB9kAu4kAuCA
	 mpoo24DnaPqVbMs3rLcUNRrXUzWDCkC2t8xJwQNJGk1vPd8AXwyI0nFJA1F53QKP0eGrG
	 9Hw2N0pIh+Pkh+p60jdTSKtifpvTDgE7sXMgqDez1XLz4FlFi2Wd4bpsXWGt3mcgpiCQw
	 oAlB17hAZcT4d55/fYUms/Rd0zxuy83G3/xc0ADmQt2dsDJPhWHWy9zSY7enwXQk4S4Fl
	 g4HToIGP908kTXJB9yQSW6nAtKH9D4Y5spslPSgVop9kpHz5QMzSRb1sABr5YvZ3PkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eSWtkVU6mS+isDiyOe0c8DoQ/PK3FUw0h39/ptl7nhQ=;
	b=NGTvMMfoNJs13MMDjUDW/gnYtjXBPakYtFZRP4K/pcG6FBtGd4xUnLaKmGgrq4WAWdC1
	 jsgulyWJJknbckyr3v+BZCu8RD+nrbl6N9WVhQWuEvCymLN0TYo60XRWGJEJ6TIbL7ckD
	 O36I/RokYMdkxZyVZdgdhmFVPxup7EvIgwJnsLK7cpM0TRTWuGYJ39zai7AZps+gL8gx5
	 QebLUEnxPrWRtC2VOTBYRQazLefnBgBYBEXSuwUwLA6lTBFp/KiYWV6RmwMnYf6nipI6O
	 8DUA6nqBcJLLKthMnt6vWl2TP7nTraQcngrYoJ9BWXHGN/yq/B1D4UvOorOBHvdCsgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCh6SPUY;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02113606A32E
	for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 18:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02113606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCh6SPUY
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so3182905c88.1
        for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794336691; x=1794941491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSWtkVU6mS+isDiyOe0c8DoQ/PK3FUw0h39/ptl7nhQ=;
        b=vCh6SPUYYBgQGIMv11JBHQ1ZpHG1YmpKKy5z+PXKqrS6wvzLt+Jd96wRXDx3xAl9Zs
         eqHWZ1n9wDAWlHKO5CkPw4UotjvIcrK0884KDbHvz5p9p7KQTkJqv5sTw/JBAHknmVTc
         +wP7x6qNAd7K8sNrY31mCjYhvP3jjfem3Lk+JNugwr9HA5oie3JA5NtyNSkVuubkdgRU
         33Kk1iyy9S88ZnullO0/56DouCUG+sX8fPRgm8+uiTm/aE2cqdzBuXzSqiOAk6bbQAow
         k8asWa5p9oAsXMqiHne/qDa3fprJ5tb89OjqiXvvDaYxMTTLrJineT/aeibpPyUQhXuV
         hKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794336691; x=1794941491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSWtkVU6mS+isDiyOe0c8DoQ/PK3FUw0h39/ptl7nhQ=;
        b=e3t7gTFYx4cgcMudLXck4Sx3sflIcRbjwHSz1up4WBZL6crbQT++QtqUIrOXTH80Wx
         74Ar1MzK1EHYxY9rbGiUxWn/zKtZkFwcvXZN0iOJqOT7kpJhgubTJMsqmMlyrgM05b7B
         pMyA91+JkE4r8llmxxmuq2pPQeS7ywVeO5Hbf/tO+LXnCs7fWo1oVKVbX30Xjr6xnw0v
         367FCD+DRvqbxPMKLNtrG7r2dbxDNF6TWvpEijNeHdd/uY2tYuPxOTfpz6DutB1aT45c
         qtSvBZbhNhBTRNAccKOSuFsIosyOBaGPrDPcU5aFqngHF7PIwjcgC3QuOFv6QSwGmWRQ
         zdFA==
X-Gm-Message-State: APuU4Z/yFaCcnzfybIbC3Z0+1/nVuN/sJjDR8C2LpvhNi37a4iQDETgI
	h5JmDznRd40VCJINkOHzdg2zP/TF6sBVBg4KlD0IZcnN6yjeyU1tLaqVoXuFyKbl
X-Gm-Gg: AYBFou0jsWLwB5VJ47Bs94pvmVml517CcP1R3nSCpJTGGB8qw0bb/F2evZyMc63vHPU
	8U0mdeu9dI6zIx7f2XDQzqiGBioaXxN3q9Z3FsX4altT2TcevadGc8ozJ5MNk0iqMO7SCT4tLxr
	8CYZfpMtVnsYkCwQo7n35Q01vzkQ+CRSbS6zZzIOQYspTAx9OBNC+NG56kx+fwc7qU2BMQAHs3F
	hMU/bJzKunYYaFMfzYO1Otut+YkLT3RbuTZw0uFs7Op6BCrZ6xwmSq56Vdk+6C/HrD/XIlVwDfP
	b/9D8buLsYYntx05I53ww5nfpY8qSIuCh06jbTuHvGIx/OOHzM6Qeuc5x/vk1c+7JcEdtkXlG+E
	ErU9bjKduBCR1mOYm/bg6VlEwE/x4Paf3RuLaa7AQmeFqT0yEjolBnGWIZUPDmbsUlge6jfMniu
	KIbW6GRM/G8vN54WDgMrc2MOl/7NwJtvjCKywxy+vjimruYyTyKXjuTWs69ctbNEStkXQ6Db9AW
	lWxpG9haceh6RzF+dAB3hygbLQ/zMVmRl9Vs7boG4h3h9nuDblvKq5NEEtEb3njL+whjc7aSu+w
	yfDsDFEoV7cLAzQg++kWdmP1fGouogHfj35Lv4WWwc269QwFNo97/KcLLw==
X-Received: by 2002:a05:7022:ed02:b0:1b2:4e2c:6838 with SMTP id a92af1059eb24-1b3b6057a1fmr4809191c88.15.1794336690874;
        Tue, 10 Nov 2026 10:51:30 -0800 (PST)
Received: from obadmin-Precision-3680.atlascopco.group ([167.103.3.1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b75d42sm7359570c88.20.2026.11.10.10.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:51:30 -0800 (PST)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: test reserved GID block allocation
Date: Wed, 11 Nov 2026 00:22:17 +0530
Message-ID: <20261110185217.867117-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107193050.330685-1-sahaj123.sc@gmail.com>
References: <20261012112109.3363168-1-sahaj123.sc@gmail.com> <20261107193050.330685-1-sahaj123.sc@gmail.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I've posted v3 in a new thread, addressing Zorro's suggestions and the
setup/error-checking concerns:
https://lore.kernel.org/fstests/20261110182040.798390-1-sahaj123.sc@gmail.com/

It supersedes v2:
https://lore.kernel.org/fstests/20261107193050.330685-1-sahaj123.sc@gmail.com/

Sorry for posting v3 separately without linking back to this thread.

Thanks,
Sahaj
