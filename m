Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456E1B4F0E
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274258; cv=none; b=ir7u8SwZPLiRnwFpB0gWzWKsk89L0U4dZ/fPu1KSDm7iKc1TS2szNqcd0YG4heW370m7eh27/g1kOG1p49OZoYzDvPZ3O8dDAZED5WMas2O7ZyOpM85e1xZX/wzMBGF0IFqnMiNwxZXY1Hh94IRIxkhybjMF5vNdyyPoQU5Oaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274258; c=relaxed/simple;
	bh=6o0xewFINAKO7TmhPeJqEQRn5g/8np3z/ldu+pzYdYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCUuWBmg9lbL69XcXdyFgOK7aYtbekkOLxyuLTXKKcPQQW4NTkvVT4Bea9dGmSlQFEU+kR4ff5Ei73iN4MGfpJvYK0OSHAcHXxxkVD8Z/j+wuaiOTaj+hTToS8rJx3a6cB6YOTmjQ+1do+hnPyTF0e8qRXBw4xuRuCNLork9/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PLA3aWJD; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PLA3aWJD"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844cd85f5ebso1307453939f.3
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2025 10:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736274255; x=1736879055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OC6nrwFSVTo9ouGK7J/ZD/pO5fB5zNaSoW8G1YKB5Zo=;
        b=PLA3aWJDIBTUp4iFvo0fh2ESWUB6sNQ7tD01iQRHIbjJtVTqtXe1yikUIho3Ked4vs
         29IpF0OG23boIUcyW0p8uK5YH3kdPu7pjQLYcnbQ1U+HGEuzonYu8/PGJDMFt/OfuVTl
         oOVuL09dI3wWaowmvMG9R6y5O29gVsNBtblNSgo450kqQFuTudO5BbDUHN/WXdNTa9nZ
         MVZ/eno4yeolgnQnzzUIhPlvPfkBLOD0tcLVkYb3w6eWjNtcZZU6rmnsm6FzkAziOK+b
         +NgZk3CooEXM90FKeqXatzlgEiZJDgQ5g5AOPmtxLmEjip60gWg+92P1B+9mP4e25jaU
         pL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736274255; x=1736879055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OC6nrwFSVTo9ouGK7J/ZD/pO5fB5zNaSoW8G1YKB5Zo=;
        b=vKiSoCFpyO6zulSyp8nxlgUD6pWsmR685l5fxS3tM4a7kLrgPrwSqG4IVm5Nxj7Uzb
         QEdQbhDLuvNSYA6Ppv5wcOWcuTMDlO5tSEi5C3R/3OXMJHTGOLCA8P5FiQ4UEibBT6st
         F2sAB0GLrA+DRhYYwcel6Xgb+91MwZr7kIScog74iYgrA/JcuaZW84AKcaj5/X74LH3a
         TjYDU33P4ZyLa5u2Vl8Qkd6HcyGzmuHCPUWPQymJo1Ep3hT94EdGYiya4j3otjl6gQvr
         WfV3w4V8pfXRxgCt4DaTci+Zu2WW4d38HVtRdTFhINLG4Wxm8q5KgERe5+qf2DFedneM
         kcog==
X-Forwarded-Encrypted: i=1; AJvYcCUd+IV1YSYFA5nfwiXXfFgrs5J7v2LDRSqgiHdnleg4wkiCG8aQOGg7Wcy5bA+HLopmfgvBtzX+@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxVe62wU6BK26j6wbiNQgbTAKZzQ+6/Q8TsWSp/LQt92AwK0o
	3nHtlmYsztYy7GtxnrIKHpO9SGG9LnNT3Mcwd3DqtS5ebLAsyCNzjs+mYEVRQlVuxvpt8iZneg+
	G
X-Gm-Gg: ASbGncvxTJhzdT3rgSE7VT5Pax/d75TEzlSImkb4tmfd+BT0j+oohWQxO1WX2P0mWTg
	vyH14Jhyh4oIdbsXjMttVdamTA3XwXOBRC+yo2///68YfmaRpyAM6btDeeq37hZ1U6PWQwN8usp
	wX9FxWYNkhNz1yyTMn44/6ocgoDAWHV88ns+0hdKISJ2FfZRINs1NSF+2/7QjarAsge/NjUNSPw
	OqlYW3jCSptUHOr28ilxC8M/W239T/98NN3mYrHGpHeeiidRvgp
X-Google-Smtp-Source: AGHT+IGBXBSRw70E7KIz++LtOHGDdMl8V1eyw3qEy2tkv9avJDxbN9fhRkvlaO6lW+VvlkumEe09aw==
X-Received: by 2002:a05:6602:b90:b0:849:a2bb:ffde with SMTP id ca18e2360f4ac-84ce00766a7mr8487939f.4.1736274254882;
        Tue, 07 Jan 2025 10:24:14 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d810f00sm930298939f.28.2025.01.07.10.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 10:24:14 -0800 (PST)
Message-ID: <98b65811-dec5-44e7-8b8e-c6f65ab1ee0c@kernel.dk>
Date: Tue, 7 Jan 2025 11:24:13 -0700
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250107181920.GS6160@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 11:19 AM, Darrick J. Wong wrote:
> On Tue, Jan 07, 2025 at 09:05:15AM -0700, Jens Axboe wrote:
>> Using RWF_DONTCACHE tells the kernel that any page cache instantiated
>> by this operation should get pruned once the operation completes. If
>> data is in cache prior to the operation it will remain there.
>>
>> Add ops for testing both the read and write side of this. At startup,
>> kernel support for this feature is probed. If support isn't available,
>> uncached/dontcache IO is performed as regular buffered IO. If -Z is
>> used to turn on O_DIRECT, then uncached/dontcache IO isn't performed.
> 
> Huh.  Does the kernel reject RWF_DONTCACHE for directio?  And, if a

It doesn't, it simply ignores it. Not sure why you ask? It's buffered IO
after all, falling back to just clearing the flag seems like the most
sensible solution here.

> directio implementation falls back to the pagecache (e.g. xfs when doing
> a sub-fsblock cow write), do we:
> 
> (a) want RWF_DONTCACHE to propagate through to the buffered io
> implementation (which I think xfs does) and

Maybe? The current implementation keeps things simple and doesn't touch
any of that stuff, but conceptually it'd make sense to mark those
buffered ranges as uncached, if instantiated as buffered IO on behalf of
direct IO.

> (b) should filesystems *turn it on* any time they fall back, even if the
> original IO request didn't set DONTCACHE?

Same answer :-)

-- 
Jens Axboe
