Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A51F12E9
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249966; cv=none; b=hbvz3Axc/ARIZl3ln/WvCKUeEA/Xvv9bjrSTueW216hulCoZPFQEM5BTxS5p6m4trb11WF2SQmM8XqEaP2WCLnvYIJG10A3GAs6wj1ERCmlHmv4ZqB9efoYHiDgqlb4z28Klww5PDqOYaLmdK731ex1+FQ1ufoerUBvYA20jTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249966; c=relaxed/simple;
	bh=efX/tPG5CKUqXeBzzQUR5NMnxNjzn5a9zF4/rO+8+xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAjQhVWdcEI6FC9YG1ieuw80MWpGexQ73xjLmYlA1UT5lvSycTWWtpn9pnw804lGb8WoOyKz5LQNC4Ni/eYCSI95oYJJmTPwdxYUJNSQzfnPk0eUU17tDs70U5MhfN6yOVfE5kmtyoz6Bx3xmJqCahcNsPrmQTg6KU36F7c6CCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELa8PJ6a; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELa8PJ6a"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2301ac32320so15753365ad.1
        for <fstests@vger.kernel.org>; Mon, 26 May 2025 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748249964; x=1748854764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEdcw/7/Ou/3N8RsZz5p9Bt0NhRDp4M+SCqt9Er8IQk=;
        b=ELa8PJ6a6z+Ge+t8YymAxydKM3jBRz/BxPoCBl6xS1FMdYxDsd6wV/Hr2B6xUQV+jI
         KGlAtHL1IT0LgcA80YhB2BETC0CGli7RoLRrb56bRBNetZ9Z5RGBhv5G9lIlQssYhYHN
         v9W/PpaztPS84nkHyd9/P5iy1JBMmG9bFYukM9yB4dHxW7I0eAcmBbhlW4RrOWER8369
         iBHGzLtyXBZ3krTOQr9Wt1b9lw44Suv0pkwM+Ozo4Wc4gMqY1pZ0JkerJX9no6rbuTMp
         eJCedxRCRBywzxo5s7oTOJO7mrnQN7QChZhzWRokHoYGP/M5XvWiHvzFzaauhvqSC/WT
         S88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748249964; x=1748854764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEdcw/7/Ou/3N8RsZz5p9Bt0NhRDp4M+SCqt9Er8IQk=;
        b=C3YG8VVbB0atPTJpfTlZkL+VpP2lseTGlTvQS2yBqqHSQ2PYqF6Srsue89P5WVCHLD
         uo3TIQsvCF0JDYJVFB5e64JyxYkf0FcW8MhhOh9dGE95wIOfyyJqfw0JY5bVCfwc0eCD
         CP8Rhwe60ld5PEOOTgm7B/5yCQBtVEYG26CkcCToCwgeSQZjZEDZlGKDD5byCEKBWnZw
         hVCsUYPxxrn3oF9lHMZ9VbFNkxBG/lS4MMQggEBkHRmf1kZlQddxsfl7G2zRLxhlMm2O
         fHGD8fJhZRjNXXbxCxjP+99PsLJHDahlaXpf72R59EC1SM180D+WR6Zaw7nQTdA8BJRh
         o8Ag==
X-Gm-Message-State: AOJu0YyzEyErZaDOe6rUMekgYNPbr8PwW5SFgg1mBMvPIaoagtop8oiq
	009wNLL5HQcR71JinBkV+yacZQq4gEWVDAsc9ivcaRwLc1YQoAtxefkA4S892g==
X-Gm-Gg: ASbGncsXpIi5DxmVZ3fdiUg41OHo+5X751BXyM7Xp6nHNDPe6PMHmTnP4iogCmQ1bXY
	Zl9SwHqyGGr53uLW+EdEr/VOhsARUEP2Kb2JgbTZ4paVJNfDyfJNaAFu8dRY3OnzkUFtEaMtgCH
	aT3wcfTJZNPSbwx/uHZZXFBdTjnkZ5svELHU52UeXuf5qbelzYcklm75udFb5yYqI3eWzopE6wr
	OM8oWaJ/B9l0GHk2nwcn0C0O8/oEA+kVDEukL9ay2x6Dt0tz3RjML35tfqbaKaA44NM/bdEd7zP
	zICUjY35Vo4ggUqxn6++3o86YOaUFnC4Vb6yVG1NTbGijxWN1hYoisoJVw==
X-Google-Smtp-Source: AGHT+IHzJ3MmDkSr0o0WYPbAk6+2voQ67H7BVtdvBGGfJiOeCcwnpMRNstS3PLjbJBSUy7ErToMd3Q==
X-Received: by 2002:a17:902:ef51:b0:223:47d9:1964 with SMTP id d9443c01a7336-23414fd3b2emr161803025ad.34.1748249963759;
        Mon, 26 May 2025 01:59:23 -0700 (PDT)
Received: from [9.109.247.80] ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-310ffebb340sm4780570a91.16.2025.05.26.01.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 01:59:23 -0700 (PDT)
Message-ID: <db1e5383-3e8e-476e-a181-34d03bea1682@gmail.com>
Date: Mon, 26 May 2025 14:29:20 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/28] check-parallel: add logwrite device support
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-9-david@fromorbit.com>
 <3c71d313d13fab780425304c118bd86f534fefe6.camel@gmail.com>
 <aC2l3D-mqGT2Ae_d@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC2l3D-mqGT2Ae_d@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 15:37, Dave Chinner wrote:
> On Wed, May 07, 2025 at 01:48:03PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> Every logwrite test will use the same /dev/mapper/<dev>
>>> name for the logwrites device, so we also need to convert
>>> common/dmlogwrite to use per-test device names as we have done for
>>> other dm devices.
>>>
>>> Then add a per-test-runner LOGWRITES_DEV so that all tests using
>>> dm-logwrites now get run by check-parallel.
>>>
>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> .....
>>> diff --git a/common/dmlogwrites b/common/dmlogwrites
>>> index a27e1966a..7c3ad95c9 100644
>>> --- a/common/dmlogwrites
>>> +++ b/common/dmlogwrites
>>> @@ -4,6 +4,9 @@
>>>   #
>>>   # common functions for setting up and tearing down a dm log-writes device
>>>   
>>> +LOGWRITES_NAME=logwrites-$seq
>> if 2 different runners are running tests with the same $seq, won't
>> there be a conflict? For example runner-0 is running xfs/xyz and
>> runner-1 is running generic/xyz ?
> Yes, it could happen, but it won't happen right now as there is no
> overlap in test numbers using dmlogwrites between different test
> directories.
>
> I do need to solve this generically (i.e. for all the dm device
> types) in the near future because I want to be able to run the same
> test N times in parallel. e.g do flakey test profiling really
> quickly over thousands of iterations by running 64 instances of the
> test at the same time.
>
> For this use case, the dm device name cannot rely on the test
> name/sequence number at all, and so I'm going to have to come up
> with a unique ID of some kind for this purpose. It may be as simple
> as encoding the unique runner ID along with the test sequence number
> into the device name - it's not a difficult issue to solve.
>
> Hence I haven't spent much more thought on it than that, because
> I've answered the two main questions that were relevant: "can
> I solve it?" (yes) and "do I need to solve it now?" (no).

Okay. Yes, I just wanted to point this out and confirm if my 
understanding is correct.

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

