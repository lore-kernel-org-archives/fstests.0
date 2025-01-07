Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513962594A3
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215932; cv=none; b=o9Pdm1cOh/I63ITqvwho+9ea6XLi1tsyCuKoxObQKD2OdaY4RHxstWwNZlrluyw3yrRgenM2x2byLlLeS9PXYQ4Zh6hFOz8dmx8rbW03YUapB7GAOjvhLQiQxXpWMfCiZByoQ3s9GiVLdlFmKKEhZrE4K4wjvAB1oFn6mKVSIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215932; c=relaxed/simple;
	bh=Wrm2cFi4OxWJxOSgLJ4CL14Xf8jxwebw7MCFyrq5eXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6ea+8n9HQXJo7eLYY9aXLu0GEwlfX6ZiQ7ww6AkT6qvoxo0gggApZp504wVKBkwQhnhfgIZTLbloyVi9W0lOhWDxAxIk2G08E3KdbfYpnBh7SyEv6FZNKJLe1kcdahkAjCNDz/I3HtGivVfFutbexjVaGX3H7QEqxnV4yOeTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VIRg7VmT; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VIRg7VmT"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844cd85f5ebso1246208139f.3
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 18:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736215928; x=1736820728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNQe/WR71FZygdC+W4FLGA0pV45U0zkbVZTzWNEj+R4=;
        b=VIRg7VmTVaO5HMaqFgBZjCgsEl5+gDM1H1cFaiobLhxteEJO324IiEfEeiESqqOdHJ
         jkGg9Q7ejFGl5weO+/IyLnM7P/N4/d/iyCdZtOn7jIaWefCeR3g04UCT+bzrUegaPy3l
         4VIrceuDoHv9F78W2d+E4qbOYckBQo9jfqS8SEJ8KFsO9qLcQWiXDOGxcx//8XYXaCCi
         X9HdsY7IFfsgnmr0CefzvX3mJX9YvOqrvGMPXnhbsAzMNQMR1v01JUamlELZz/LJxZEf
         Pbm1wttQjcB0mgZshyshrImuCwoTrNocIbm2MeoK2MvYZYP0Dk8nuYLBf8HswflJbcj9
         O1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736215928; x=1736820728;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNQe/WR71FZygdC+W4FLGA0pV45U0zkbVZTzWNEj+R4=;
        b=krHTkG6blDNbDkwbGqOjNmhICYspockJ1j3wV2dPvoGZLW+XrJ43cW6AjH468Rb6dE
         eHoMbbWxgRCJ4GTcItTunYTHeTH1BDCRXXic8wQgOMJNBssTdXr5PlNhQTsxjs/IfNTR
         C9GiKyJtdYAh9hLDRRubb7rXZaK22Sfw5a7zoQfpN900cGoHY+0Ts+dpKySkgiifKXJn
         Ur1ar2ce4a7B4LWh2ktD1mcf70Z8/mCF4siL0/O7z6rmabey9Ir+3O5mqB3XvL/GWuAZ
         0MlS2qafcxDJwKEB5AXrPTyO7F5iFq/UChakguvwoLy6PHkhSBr0ubS3bP4UnnpHmTes
         KeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCrhXYECRB/B2B2Y1mUoNzjEg6NLlmo69aUBjpeXtONDMCfwGhBUs+7RaTyP3ULLXNe1ZtbE29@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2AVfzWH7BjN00oiMoy9peVDOIwET7wlJkilvsoVt9EjxTAROO
	wJAOwoB46Y7pQFS1NKLHeEZLHbVbYmRWjWkFJ8S7BVXg5jDK2uwn0ZAFEJkKmfjQlJETyBX/47j
	I
X-Gm-Gg: ASbGncuTM6AdtMRQiHTicBee++92t7lZv7HJifPAP2VpcUujvl8UjkT2cbWlYL/ltQj
	PPAmDCCqkEEuq8OuBdryuVSLX/6G82VJPHO2guPysE4GwRCnx/68S7zLEBxp7IdHXM99HGORpwQ
	VVj4IKzP0TClADocqM0Dmgk4KoBg1ty52lALHcv629sZslkf774ZMsyi2CAiU8yR4diJDEPblnr
	hDj0J6sBK7jr7zFhwqoTGHinwJEo282JDmv0BzKxJgLQyDeczQfPg==
X-Google-Smtp-Source: AGHT+IFkyvS+3iluW+QRAppD3uM0QnCXFu9YwmLkLuRE8c4K6DWCAdPp4KmR9Gv6Wzf5swujyl+aag==
X-Received: by 2002:a05:6602:13d4:b0:844:dfcd:8de0 with SMTP id ca18e2360f4ac-8499e6a11c0mr5950239039f.15.1736215928413;
        Mon, 06 Jan 2025 18:12:08 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c199a09sm9596883173.87.2025.01.06.18.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 18:12:07 -0800 (PST)
Message-ID: <0564fe96-203e-48d1-b853-5ad55fd7dd68@kernel.dk>
Date: Mon, 6 Jan 2025 19:12:06 -0700
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
References: <20250106174919.103199-1-axboe@kernel.dk>
 <20250106174919.103199-3-axboe@kernel.dk>
 <20250107020938.GN6160@frogsfrogsfrogs>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250107020938.GN6160@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 7:09 PM, Darrick J. Wong wrote:
>> @@ -3293,6 +3329,9 @@ main(int argc, char **argv)
>>  		copy_range_calls = test_copy_range();
>>  	if (exchange_range_calls)
>>  		exchange_range_calls = test_exchange_range();
>> +	if (dontcache_io)
>> +		dontcache_io = test_dontcache_io();
>> +	printf("Dontcache_io=%d\n", dontcache_io);
> 
> Is this a debug printf that got left in by mistake?
> 
> (Everything else in here looks fine to me...)

Oops indeed yes, good catch!

-- 
Jens Axboe
