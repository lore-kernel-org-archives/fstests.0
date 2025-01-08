Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB98192D66
	for <fstests@vger.kernel.org>; Wed,  8 Jan 2025 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294432; cv=none; b=kTcTwTr+s6FqyrgU8EuZnylk+13tRixnDjYZbXuo2fq5iuZRDCR51qU9HH7Y/XbVSeMsK1iS9CCpxLEePP6ptG+ntZwdQfi81jpuXDu3Z+JIA60QQ8LldMxy1bNlnGVDAEHBKQKLI2GSca16NSHt8rVAvbdBpWjUSTuXufjtuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294432; c=relaxed/simple;
	bh=zvimoe7eQKv2k0c6QxFUgo0LeMnduLqHwTQ5No3Ztwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5tqYxPwBo1aLXJVmB7F4U251GbLLOVP4SeXqF1590kXF7LU/I03vNs1OAiCkaxurI+XpLzP+d6yAOLBUxf/8Oa841kL+PEOpA3oiLcon1/wbbM4XphaqDjJM9qWHbKbAZ4sSqUBCcXePYjB7EcIIEiJQ5urUJ6BZyU0y0285aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FY1Ik0HW; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FY1Ik0HW"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844e9b7e50dso1449934539f.3
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2025 16:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736294426; x=1736899226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdWISwy1YIAxaEcKADPUx/ysYhRJgOiGULFbQTwaQ1Q=;
        b=FY1Ik0HWWhRpZsD5YjUMVByYgjd1NqtbD3Wb9f/aDHIxITKSrUdRikwZMn5vz5Kwkj
         sJySGyckA3ZTd8fFSBlYBOo5+prvXrArQSeKnfgwYlMFHFgk3SU8YFptcLH2r7m2Clu9
         vf6SmONMzzRByc4ohYYnzfh4EZoorce4Xh0BaRlipde5AoelCe9lDLGJkCmyKLSpnfMv
         1qz5oYr+zaZdG47Sl+OSV/qy6PYGJnKG6xC/mm2Uf1AM069KKrP5k3lLWmJ91y21jpwr
         8Bsc88RFs4nzupgKNIiAXxud25X/84Dgakg+lzu3JIq7QGpR2PfSFr2Ut6Q5WNh72Pz+
         MHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736294426; x=1736899226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdWISwy1YIAxaEcKADPUx/ysYhRJgOiGULFbQTwaQ1Q=;
        b=CBLc0BeJQUey1gwe6BLCd2ghlzCA4/hkqhU5bFT18Tx466TgQTQiC111SpNABNXmMW
         bwQAyxQxTV9BH7C/4igcUDNzmt+2Z2G1EiCbQJgEQMlcS0sXhbvzRY+BXtXa5e1K4nts
         PXi+thXv9PAFZx4CLqyup4F+IQ2FIRSRjtHN08RUTjkuhdPminTaTuRkO2Xa5r2cY1q/
         YFeUyxtlkWovWW2d1xzhI4QMrJxJa8DpQLwqZqRSnBmEMm/oH9lVJUs8e52g5SldVReF
         6iqcYuPD3YfBj824vHnVGTuFQJPCoDVuw4lbpeibjt/AmGU6gAX9sxdnWEoC7UuXYlbc
         17tg==
X-Forwarded-Encrypted: i=1; AJvYcCUdpfwXY2iWz1/JecLhOFAYJZYDwTQS5nk1LG7JkVK18lethep+gT+a+hQXKjkYOJvo5L4L7CSx@vger.kernel.org
X-Gm-Message-State: AOJu0YwDS4TStXaArrtyq85HnerxWqafdwVwVcF56mQPSF71mGmSKi8l
	WnW7MepQzJCjey5fQB97rnzTfwc14p+3iN1byKTvyASAb6ZmHgJAHhyj0rWB2QE=
X-Gm-Gg: ASbGncuF/sDqA2UvtKxP/GC96MG+sLk0a2I8+UaUi1gA6LChBiyE83xMDCueo/80E+h
	ud1OoLti93T51p6aJ3ORzYLpOYRyxOyke8eKrli6n+dgx0l7QCoWyzgDXWgju0o2EfcyqiVyvqh
	V0DvN8l50yiUrwSn8Eb9nRm1T7cW7LImZKQReIpTCA4ld7z9EIKqAuxM5CHzRjv8XlWI69F7H7G
	P0z1EY/BL2n95rD/4etxuQo0O3R2DuBM3npZ8ac1UV5HmvQ7G3NoA==
X-Google-Smtp-Source: AGHT+IF7FMd5b4jfvxo29XA+D7cQhb+kZz7mfDCtNDKQxjTWKu09583T9qylGnBtP1i/XPWFqi2rwA==
X-Received: by 2002:a92:194a:0:b0:3a7:e452:db4 with SMTP id e9e14a558f8ab-3ce3a8beb94mr7578635ab.16.1736294425913;
        Tue, 07 Jan 2025 16:00:25 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0e47d6d6fsm104657205ab.69.2025.01.07.16.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 16:00:25 -0800 (PST)
Message-ID: <770d0b93-d61d-4fc0-9649-f9850db11f8b@kernel.dk>
Date: Tue, 7 Jan 2025 17:00:24 -0700
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fsx: add support for RWF_DONTCACHE
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org
References: <20250107160617.222775-1-axboe@kernel.dk>
 <20250107160617.222775-3-axboe@kernel.dk>
 <20250107181920.GS6160@frogsfrogsfrogs>
 <98b65811-dec5-44e7-8b8e-c6f65ab1ee0c@kernel.dk>
 <20250107232240.GT6160@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250107232240.GT6160@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 4:22 PM, Darrick J. Wong wrote:
> On Tue, Jan 07, 2025 at 11:24:13AM -0700, Jens Axboe wrote:
>> On 1/7/25 11:19 AM, Darrick J. Wong wrote:
>>> On Tue, Jan 07, 2025 at 09:05:15AM -0700, Jens Axboe wrote:
>>>> Using RWF_DONTCACHE tells the kernel that any page cache instantiated
>>>> by this operation should get pruned once the operation completes. If
>>>> data is in cache prior to the operation it will remain there.
>>>>
>>>> Add ops for testing both the read and write side of this. At startup,
>>>> kernel support for this feature is probed. If support isn't available,
>>>> uncached/dontcache IO is performed as regular buffered IO. If -Z is
>>>> used to turn on O_DIRECT, then uncached/dontcache IO isn't performed.
>>>
>>> Huh.  Does the kernel reject RWF_DONTCACHE for directio?  And, if a
>>
>> It doesn't, it simply ignores it. Not sure why you ask? It's buffered IO
>> after all, falling back to just clearing the flag seems like the most
>> sensible solution here.
> 
> I was curious, because your code does has_dontcache=0 when -Z is used to
> select directio mode.  So I wondered if it that was because the kernel
> would return EOPNOTSUPP for directio + RWF_DONTCACHE? :)

Ah gotcha - no that's not the case, it's just that it doesn't make any
sense to open a file O_DIRECT and then use RWF_DONTCACHE, when it
already shouldn't be cached. Outside of the case you brought up where
we'd want to drop page cache for O_DIRECT that ends up allocating page
cache, but that should be done regardless imho.

> Then I wondered if there was actually a good usecase either for letting
> userspace specify it, or for filesystems to add it for buffered write
> fallback.  At this point I would wager there's a stronger case for
> adding drop-behind automatically because userspace shouldn't have to
> communicate "write this without accessing the page cache, and don't
> leave file contents in the page cache that I already told you not to
> do."

Yeah agree, I think we should just use the same mechanism for O_DIRECT
instantiated page cache, without needing the app setting RWF_DONTCACHE.
O_DIRECT is also slowed down by the existence of page cache, which can
be annoying particularly when you fill a file with O_DIRECT and now have
a bunch of page cache for it.

> Anyway the fstests change satisfies me now so
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!

-- 
Jens Axboe
