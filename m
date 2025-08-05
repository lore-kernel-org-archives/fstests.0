Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12677272E53
	for <fstests@vger.kernel.org>; Tue,  5 Aug 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408363; cv=none; b=O+kMFmq5J+mb7d8j9woP0JCs8KEhumnUoe00y3HmR9hlsbQnPnKl2rM+InFUBlQ/D9GrNFC4pq0qkMnXhz64DSDu22QgQMNDQsaMHNr/UfkGp4XJVxtT7XarjdrlRvpgVDhS41w5AmdnE3TTxd22CaFHxBFwDzWNnRFo/wrPbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408363; c=relaxed/simple;
	bh=XhV1u7yAOmq3DL2/aVsLsL2XCiKiICT3mTnvT5JMjLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkJ/s8M1fKkgn1rxFC34CGc9iDeLox+YGp40woK3lgO+B+qEQZLpT40oOaF7wlql5mxuJvUKrNExG5ZyCfxHAIWBJ4/IIEup1bvJBJOyhHc9wraR0enBTxozrFnGvVnJzT62iQkgliAXKyD5iDpd6BqPASVr2u2l0XJVg2LFPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a6NAnFps; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a6NAnFps"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2401248e4aaso73572345ad.0
        for <fstests@vger.kernel.org>; Tue, 05 Aug 2025 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754408361; x=1755013161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gde3Z4lrKVpxofexKal4NMiLTMCt2/suB8AyXkEBFg=;
        b=a6NAnFpsdljR3uSHeRZpnZxskTkO5XVAQAk3RTQtsll5Yyqp4Aqprawt7IWMTia7W1
         FtU+QkkZxAnxWnmQXankT7J8Vq/dy2rpoTrit5lF5UDKDb6eQy1UaD0zQ9Bc/Gd4TczA
         /1zsF4uYB+eyVTJbtEsOfCJnYBZ5VR1BQlkPfwn4r60VypX2hGY9o8siY6geb2RrxEsP
         rJc1Ub7rJ/n+jYCXcaXPTpVwv4XBCKsQTIp72oZTdLZwsKOp64dsyOTC/vfDH3fNx+zw
         uv5QPLbvAAWVMkDVAz6C17/pFcZ4LnLCN9kfFLtHzLYHjW4EMzsNOBs5jFB1rjjIO6Fi
         no9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408361; x=1755013161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gde3Z4lrKVpxofexKal4NMiLTMCt2/suB8AyXkEBFg=;
        b=swPmZUQdpD75dQBAHxv+vyYxtviA40FskYV1GQuduGcPYtoiOWvV5tcfKYrNeT+97u
         G4qApnwmmXeh4AAno1y8zRSH3abIXRZAcyFfE/k8hocC4S45o4flFo6cEAEVzz8kdCg6
         IrNAIgOaVbVUqCnxf06ULLM59Py8i4rd4PEsx5F0+yoyd1X05CCK/zuDeFlkbgs+RPgB
         oqrqRS6aNGoa0ElM3Zr6buTpozpySRffH11ZzI56am/mP5y5GiYi4jAjUTaUCNIpxVFA
         6tRbxu4JiyTirz6Xdu1JHF4/ojbczLodfgCQwczgzEdVR4avm+nTCFBIB/hJnQKg4kmN
         9v2g==
X-Forwarded-Encrypted: i=1; AJvYcCUm+XxWSacU0AZCH6/yvsiJpA35+DWiN4dVsGXFQGFOvVatUrSr6KBilfwakaiF41sXqj5wO6zu@vger.kernel.org
X-Gm-Message-State: AOJu0YzKIUJ1G/3e8ImQYb8p3NR05/ytrNmy1ZsDwvqLxSVXx2BnLZh0
	yogZwDzn4XaHG9Bl0++8xDaIa+e9xOl7GqgRHmfU9ZV9qw6q9mXjG2sFZLf8svDCeFM=
X-Gm-Gg: ASbGncu7C76GCa3Pufwcx4elAe3xeOzZoYZ79FuxHS5g6HlJEhSS/NwYU95Jstp9wQi
	8RxkNOSsZrmYP+Vi1GUR6xRZVDh/PHk7sE1Y1DKfOQb8+hbZ/qmEegSKlJRrt+RsDHL1Wqmt755
	2RsZVFr6OgEX12jauTAd8SDc+bH45SgWTdhOSMclSdDLRHd3hpChC1pQju5Shn4LbWDVH+KkXbn
	UBPKVFEC/qOQWTyx1FTwh4vQdEIeO28lv4ANJaz1XfPFXA/5uhTu+OKlueemoRKXSKZEs3HFFBS
	KS5LLoN8aw5+7v7zyhVFO46Q+xLZKPIUmEfKx2LdHKeqj58u347s/ReeZRAin2DE58vBAeul5LR
	zGFet1BvIr3UDtGdu3K0i
X-Google-Smtp-Source: AGHT+IHyJbB5vULpWYjYzw+lS+gJrZWcinJIio9c1ZSVIIxX106/OKELIJZN8higRiwuS7NP5k30qQ==
X-Received: by 2002:a17:902:d482:b0:235:e9fe:83c0 with SMTP id d9443c01a7336-24246fefe69mr189311545ad.27.1754408361181;
        Tue, 05 Aug 2025 08:39:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7c30sm135562665ad.37.2025.08.05.08.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:39:20 -0700 (PDT)
Message-ID: <a96768ed-ae71-47e3-b5e6-229d9b431923@kernel.dk>
Date: Tue, 5 Aug 2025 09:39:19 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsx: check pwritev2(,RWF_DONTCACHE)in test_dontcache_io
 as well
To: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
Cc: jaegeuk@kernel.org
References: <20250805014538.2935061-1-chao@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250805014538.2935061-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 7:45 PM, Chao Yu wrote:
> filesystem like XFS or ext4 has supported dontcache in both read&write
> side, so we can know whether filesystem can support dontcache by only
> checking w/ preadv2(,RWF_DONTCACHE).
> 
> However, filesystem can decide only support in read side or write side,
> not sure, all filesystems will support this feature in both read&write
> side later.
> 
> Let's add a check condition for write path as well.

Once more:

https://lore.kernel.org/lkml/587aaee2-8d84-4eb5-9b87-22947abd0752@kernel.dk/T/#t

-- 
Jens Axboe
