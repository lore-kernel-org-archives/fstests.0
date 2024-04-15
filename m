Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26F76033
	for <fstests@vger.kernel.org>; Mon, 15 Apr 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205599; cv=none; b=mx6n+h6xc0AHbGK/TJijqYDwPWpDkGVH73wKJ1Gv7B+luK0kiB+pPO2zcKZGX3+gHBIPsRtDx9fMRWFUVlcVIdJjf3jiViBdiIM5DNEtMe4ifUikyQHJQtnGwjUmkDxn73xXIqlkFf+5Ki7+kRdm7WoQKJoQEpA9dkIcve8JEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205599; c=relaxed/simple;
	bh=DeyeRnhAf6E/BpqhO8gU057lCZiiDEWJC6amSBNKtb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WnOb8kb7W96H+tAI0vvUR2B6lRslPvIxOw7/vpIExDFKf/TRY1XsS6eGMZHooJ+iM86Xunu5aZPo9C1ow/0u//NNF2y/eMx3b729LwM9DMyDOG9tMW+AP7JZQ8zFSMmeXvVwz2mSaHKZ3qCKZQPTuZ3InyxADZ1UZyDe8N4rrLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yciqbuqU; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yciqbuqU"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a11328dfeso1987625ab.1
        for <fstests@vger.kernel.org>; Mon, 15 Apr 2024 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713205596; x=1713810396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUbBMxfJPjfbHcg8vCOm4zxO7L0+Lq97n8Cjp037fwY=;
        b=yciqbuqULpqewN5FWPiAUQB0TKIgBzl10oLCsgSoMFM9xWwLjCFKuIkd3LivBUsQat
         ZFgpzKQmEfnQUO2mRxqEyD4n3+n8l0l1VJr300iePdcjZ16vESH1aFY8XOdfaib+P5E2
         /FkIwgJIeSlNrarRjepbhEybgB67MJzkRhm8D0VTALc7onyd98uryvUuKYN+uRNciP+4
         LLAuF+Vu5mSPbhxWhTK/Axm5tHfYiTQIPLvTjKwZSASI3j4AZuItr0xFDqHYJlBO9ZXo
         MvI4NDL0EIjqPtr9LvrUfeg5TuHr4DOTqbSlcrHMkOJvCYWeCHkf5q2PszBy76aD2LO+
         nlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205596; x=1713810396;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUbBMxfJPjfbHcg8vCOm4zxO7L0+Lq97n8Cjp037fwY=;
        b=D50ajsG9Nv8BAvJJlkJLXkf5zAn4RLdfaXb4PapapLvEwaBfihVmS1n94r4hVmzhuV
         /WuaSUmyYjCvgs7NM+VwEv+vyVd/CKqQuNHNMXSV+/eLuBmiUnR+4d+wkSzu5mFMkEyp
         po4TTL9VFTbYHtd2t6fKCu/1eXZWpQB1YlbyOWMR1FELMsdVt9/FGh/LQd05rPnEc8HP
         JLHdCT3PeA686uOJFjXRpXJLf8BDwGSGp0dUiUBTAkqe5UYVYpahKbemX084O/SQTHn6
         fia7i/HnEjwnOtT8doNgQI85ghGV55XRbnljtzsymHR8rLgzjndDk0rc2lrUAIJH5O3H
         TClw==
X-Forwarded-Encrypted: i=1; AJvYcCWH9E9R0bvJHAgNY+BjNtUuzkLJpuHFH0SriYswqrgg709rccsFeIH9cp65wKGmZMIS6KfqMv7C7W/2jS4m+obB4ix9JtB23A==
X-Gm-Message-State: AOJu0YxuvfkbgVndXbEtUFUSJ6IXOfhyHSitBZbrT2qK4xx0iTWVpvVJ
	0tt3I9fNViVIX29Nfl70VRpQauvyK6dkdsrbskEu7JF0fYG0RIWrOvV6YirYppg=
X-Google-Smtp-Source: AGHT+IFLKpDxw0MLVKJ4m/TqdlEfRRC6666wYiLDl+wtONmeTvX3fNpWr5uXTERukSmhD1mZwMS82A==
X-Received: by 2002:a5d:94c3:0:b0:7d9:892f:389d with SMTP id y3-20020a5d94c3000000b007d9892f389dmr2798844ior.1.1713205596100;
        Mon, 15 Apr 2024 11:26:36 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bm6-20020a05663842c600b0047f100b70e1sm3334513jab.105.2024.04.15.11.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:26:35 -0700 (PDT)
Message-ID: <a8f03f2c-5951-4aea-856b-218326815302@kernel.dk>
Date: Mon, 15 Apr 2024 12:26:34 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xfstests flakiness in generic/095 triggered by fio 3.37
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
References: <20240415182231.GA2649469@mit.edu>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240415182231.GA2649469@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 12:22 PM, Theodore Ts'o wrote:
> I was updating various components in my xfstests test appliance, and
> it appears that fio 3.37 is causing generic/095 to become flaky.
> Previously, I had been using fio 3.35 and a quick test shows that fio
> 3.36 seems to be OK.  So the change seems to be somethinig that was
> introduced between fio 3.36 and 3.37.
> 
> The test failures seem to be caused by the following unexpected
> message in the output file:
> 
> fio: first I/O failed. If /xt-vdc/file1 is a zoned block device, consider --zonemode=zbd
> 
> The following comment in tests/generic/095 suggests to my suspicious
> mind that the above warning message isn't getting suppressed when
> --ignore_error=,EIO is passed to fio:
> 
>   # There's a known EIO failure to report collisions between directio and buffered
>   # writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
>   # at here.
> 
> .... but I could be wrong about that.
> 
> For now, I've just switched to using fio 3.36, since there's nothing
> in my testing that really _requires_ 3.37.  It might be that we should
> just work around this by filtering out the warning message in
> xfstests.  Or maybe we should make a change in fio?

I'll just revert that change, not sure how it slipped by that it also
change it from informational to an error message.

-- 
Jens Axboe

