Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3E244EA7
	for <fstests@vger.kernel.org>; Sat,  8 Feb 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739052495; cv=none; b=q5IVTA9oSSBVMIJbm/6heB4gSlXcaG6kZ3lFLMQ10LFCKJGt8n2vAZOsbg7BblRgH+ADupBxPJAwRZm7pjdmtP6m/+omd0u6sU/jsSV7AMK9oWIvvPrgwe+k4PVBFTXXrUo0EPG+LEVRkFqHx2KuQzJFuDDSdXbC7lynJCrKiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739052495; c=relaxed/simple;
	bh=rFYNXx48/ExOrxG22hgZQi71xv4iubnd4xRn+BFVoOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFobdmoaFlTmUJPFNbtuUE+mO3QtRc1ExzgRBI4R2ESWUeR/JWmoBB6DQCezIh7hl8bqtFUxecUc+LpxDbaD7nSgEBhMLVBtkK5CxWo6q05r6LL/Bb5I/pYPv2irAUz5XgwnflTBxaG9jPMiS0zNRNeW7HaAMndhRBNZHfGymHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mp6BCF+d; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mp6BCF+d"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d04932a36cso28476535ab.1
        for <fstests@vger.kernel.org>; Sat, 08 Feb 2025 14:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739052490; x=1739657290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8nTg4XPYQ0eluA3V2De+DpAkU5CwdOhclfcNpzVraw=;
        b=mp6BCF+d1d26rpidSH5mnHFrugX+2mfAimBmWVmaibCHXdZl105MtA4PgdBKp+6AXj
         eGW5r8h1DGEJI4qkRb00i3nSjjESnnTEmtJcbm4R0OiAehqFbCLfVc1rp4vG83ZpDAVU
         dWOHedba/Mn+DTjgO36qk1K+YtTxytJ540gCNL0vlIu9Jbsc+kKAB6EO6ov/WzKE/m17
         NUPlJZKNLD2ZVP+frTENCkUmb0uJtTPSo/7sgNzXwG+1oyGRo/1suevvoN/DsgGPJtpT
         Y/x0Pt+2mOY8BfsKYv/18YW5tyxoja2wO8qXDahXQRzd5LBLg8J3XGfj6UkXsKRspORw
         fdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739052490; x=1739657290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8nTg4XPYQ0eluA3V2De+DpAkU5CwdOhclfcNpzVraw=;
        b=MQOqe1byESerOqomuPyR3xIwPcvLLIq2WaY920NdiUdddXVZjIbu/8D8wit5im+l+x
         G0jZl5NvEU5tyN+mq1COVyeufvDIf0xqz4BBI77WaUlqMmr63c0r1KtdLS2ecLGHO+LB
         P2r+mus616vHZ9YmEYD2tfn+QMe6J0XFrK8oprFA3f7CArQnixjstA7Hm5ILJkNaV9N6
         ztYXy5m6S4TMoMkxwvG4Azuq3L2Jn5/gp4k0Vk35vzFOPAXjmQ7+Y1asj7WBbX7NNIrL
         7b1MJbI/5LeoPJMlzZzh9PAg21YCGfQT0dLOa3AN5PRYlc8Hact2LDlHYVRRFdxfQ+2m
         yu0A==
X-Gm-Message-State: AOJu0YwiqducqqStyAzK8SyCfejY4rR7TGLQ0tQCiCt3Fyn0tiirY3kk
	srpb28u5740hGrti6wM49x4A7WBczrYgIpbmzNwst1Ubvh/AHe0SOPzx5jMAuPk=
X-Gm-Gg: ASbGncv9yVMwAuPTgifa0RIRi9ukLp1KpX5wPJUP0QMN1Q9KqfZzGbRhOD6YLEQ24mu
	f7dRwPz7BixV69Iue7vDZNi/Glg9ZYqZCPl8tglAX2luwzuky6O0+OC3/V5HMKPCrUhmXyKy7d0
	Oo+iWfNF4w99WUsLrQh+6ky6uByJ5GZ80D/sEQRVucvS+cj8IVrrpSvVZL8DEpswP2nYBpQwiSb
	NqBKtmY9oEVMt7zUnSLrasFX08R01BsVAgVp/0s5yxeYoBCpIV4QyNLLOmnkiq49xDmBEXqy6+F
	5bu4tlZP1c3P
X-Google-Smtp-Source: AGHT+IEMnrzaBCVfK/TvhdoQCnyxRDs7O7nCH1BaTYTVvoVsiMcG6kPY+GEOVXP65qdQGx9qv86MgQ==
X-Received: by 2002:a05:6e02:1c86:b0:3d0:443d:a5a4 with SMTP id e9e14a558f8ab-3d13dcfc7f7mr79037705ab.2.1739052490517;
        Sat, 08 Feb 2025 14:08:10 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ecf29324cdsm37284173.84.2025.02.08.14.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 14:08:09 -0800 (PST)
Message-ID: <7d5bebb8-00f5-4e5e-9c69-67bef353ec79@kernel.dk>
Date: Sat, 8 Feb 2025 15:08:08 -0700
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to compile due to missing <linux/blkdev.h> header with
 liburing-2.9?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <b7149d6f-2c1b-4c51-ac0c-0b2d7560330c@gmx.com>
 <e760d88e-e9e9-4e59-be69-eab333977f45@kernel.dk>
 <dfe7dc98-ed02-4a18-8295-ced25f0b500e@gmx.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <dfe7dc98-ed02-4a18-8295-ced25f0b500e@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/8/25 1:40 PM, Qu Wenruo wrote:
> 
> 
> 在 2025/2/8 23:41, Jens Axboe 写道:
>> On 2/7/25 8:43 PM, Qu Wenruo wrote:
>>> Hi,
>>>
>>> Just find out that fsstress no longer compiles on for-next (v2025.02.02)
>>> , patches-in-queue (a494849fb48dc6b276c2a1784d6ff66c731e5572) nor master
>>> branchs (8467552f09e1672a02712653b532a84bd46ea10e)
>>> All fails with the following error:
>>>
>>> ```
>>> Building ltp
>>>      [CC]    fsstress
>>> In file included from /usr/include/liburing.h:17,
>>>                   from fsstress.c:30:
>>> /usr/include/liburing/compat.h:11:10: fatal error: linux/blkdev.h: No
>>> such file or directory
>>>     11 | #include <linux/blkdev.h>
>>>        |          ^~~~~~~~~~~~~~~~
>>> ```
>>>
>>> This seems to be a change in the liburing headers, as v2.8 still
>>> compiles fine.
>>>
>>> Is there something wrong with header change?
>>
>> Are you on arch linux? They messed up their packaging.
>>
> 
> Thanks for confirming, will report back to downstream.

Forgot to link it, but also see:

https://github.com/axboe/liburing/issues/1341

which is the same issue on Arch. They compiled the library against
different heads than the version they are installing with, which
caused the issue. They just need to fix their liburing package.

-- 
Jens Axboe

