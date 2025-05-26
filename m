Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21771C84BB
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239793; cv=none; b=jAGWN2oBzAiVx+WFZxSwVamJ7GKruZL3ksPsD+SJ5cUGr4PxJxW5sp+tvqs/afbgBzcuV1MTIbHVfi/U4I53LGOL8G0CalpiJ7zS3IYt6gB/XareXf9kFYUv+1GiiXsNtCKRsPdVb0sFfzrbM0c0qLlg+EGnJYm0xAieN3t+7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239793; c=relaxed/simple;
	bh=aQVge/NR0Y8jBVu2fkfLO79hfJJ6Zv5uor/LcGnVAUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayQZmECgo2jtTywmLkGrnoKM3/EPWSEqpPJAo/MP0frDw7lrG0mzSGXGiykk/TIT6UGNAB9shaeUx8AYOqDJVT3mJLUVb/evlwTaKTWK/1rsgKzYYLKZ1LVpSlDu0tJ4wWYCSrzFNFHJcM9bfo4K3tIQpbsqc3mePBFyFHaAiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emTItmT7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emTItmT7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2301ac32320so14426785ad.1
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 23:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748239791; x=1748844591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugidByR7iUIx7zRC3yIxTgEncBl3PE4wW3E85GjAFZE=;
        b=emTItmT7e/oyu6gCvh4M2rBXrW+sHoqMP3YYnlKFqH0pNsPgl9qdkOrR1K7NWm8X01
         IjdbVnlf8JDDUSfNBbgxMnw2a9VKMFXwdk+8c2yaXvYWTtCLv4qFuptxbouoRCt+he52
         LqvJAOUPSBzXnSrRfQ+/BRrtvGJlkJ9rvHCChf6YlE9V2FNZgSwKd7KrvFJMN+SKHYWn
         dsu3mzXS1kwry+Fe3cCieMJGLmdOBRegO2J69AxVe+jLMzRLuJ0w5aHvsTb7yA4blxVU
         H8mWPbII2ojCY6NfFMs0nWp284Gw4V0S7RiPI7e7k8EvqhH7dmzUCk2AFaxqPA2alpmF
         Be0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748239791; x=1748844591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugidByR7iUIx7zRC3yIxTgEncBl3PE4wW3E85GjAFZE=;
        b=EzacGs/cvYiDKlBQPxyHe5mbzetA08jLyI7QJ+xoxAfVFlsz1OrRXBvA03zgKgOb1w
         W27BTAeygPu8lCx1xY7UlnVQkvM0e4lvUCDegL0LTt5sXFFtC7wvSqdBboD0tP7NL4/L
         VXA9WY+URPLk+VbH4EuPjMc/kG0rAGOBzcEofvbaq8R7K4aWZ/ziUiKRikMR+FcSHZnS
         lnFl802Q9CRI9NmAh49dmKwS80DUbrL081v6lJ3Tp7y9X7RdJCNl33YmjWfB5lE7c/7b
         1kUgMNQjLy9T3auCZM9DZj54MA2P5RvRF7KGeC/5i0+WTJ6CbXn/usKt7mZu/dBW+uKz
         kVkA==
X-Gm-Message-State: AOJu0YyIklX4mqr86Hcq+4JKtZXF4QCTzNikEs80T8Vq4OLa1T6fcgm5
	09O4KW6KakvGMYQztfM95104jTQktMzoIjTtguI/oeUxWP8xdRgewLcv
X-Gm-Gg: ASbGncvp3+UNp+TVab5UCqk5CVGTHJPnmkuzD78D/IdAX2WUT0WrAM38jvXqayuRkET
	tNEzhdWJmO+UHUKpX6pnHU5fbL9ifS5TZZaXloGnaeeWou87P3yITojwJefi5vPhN+/ngaUjYbb
	yl5N3Ln6yT5v/25+CwemSUgoNwZR8gSIbvN4k5+C4aEowsDBCvB2YICuQBoHBzkwdWsD3z6h/BT
	GDm4yyJHAZRWYWQFuWODkLYZ7UyA4+rXAzA2/PEbekXDj8y2NRWzFmLmE5NmVhz2zN95VmM4NX7
	4B7MoaqA39uNRxE/urHyXznDkHGEmT5uGaZO4RG0DC8pOCFAtVaYoJLJOndkSQ==
X-Google-Smtp-Source: AGHT+IFkFzQhUZLYyroBR2Kb28WWBg7127mi4kRDeN4No7DPaaB5sj2/cp5bxZQ57zvZrrZoWE0DIA==
X-Received: by 2002:a17:902:d541:b0:220:e156:63e0 with SMTP id d9443c01a7336-23414f55ff9mr111548385ad.8.1748239791084;
        Sun, 25 May 2025 23:09:51 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-233abb99a06sm86121085ad.254.2025.05.25.23.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:09:50 -0700 (PDT)
Message-ID: <b57446f1-09b7-4dc2-97ff-9975e9e3baa1@gmail.com>
Date: Mon, 26 May 2025 11:39:47 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/28] check-parallel: report how many tests were _notrun
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-5-david@fromorbit.com>
 <a6b7ba3c519e9db3f408b913dc18fc732cde1241.camel@gmail.com>
 <aC1ALFZ_fI0_b6DU@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC1ALFZ_fI0_b6DU@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 08:23, Dave Chinner wrote:
> On Mon, May 05, 2025 at 03:28:10PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> We already count tests "run" and tests that failed, but there is no
>>> indication of how many tests were _notrun. With tests actually
>>> failing to run because of things like bugs in _scratch_mkfs_sized
>>> being reported as "_notrun" instead of failing, visibility of
>>> changing numbers of _notrun tests is needed.
>> This looks okay to me. 2 questions below. Apart from that, this looks
>> good to me.
>>
>> Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>
>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
>>> ---
>>>   check-parallel | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/check-parallel b/check-parallel
>>> index c85437252..d68d76e55 100755
>>> --- a/check-parallel
>>> +++ b/check-parallel
>>> @@ -188,7 +188,10 @@ done;
>>>   wait
>>>   
>>>   echo -n "Tests run: "
>>> -grep Ran /mnt/xfs/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
>>> +grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
>> Nit: /mnt/xfs --> $basedir is not related to this change, right? Should
>> we move it to a different commit/patch?
> I don't see much point in separating it out into a different patch.
> That makes more work for everyone and it's a simply, obvious fix to
> reporting code this patch is adding to...
Okay.
>
>> Not related to this change - Can we change the above statement to
>> something like it is done below for _notrun i.e
>> grep "Ran $basedir/*/log" | uniq | sed ... | wc - l
>> in this way we can get rid of the sort command?
> Don't think so - uniq only filters adjacent lines. You have to sort
> the input to put all the duplicates together in the stream before
> uniq will detect and remove them. I suspect that it is possible to
> use 'sort -u' rather than 'sort | uniq' but I've always used the
> latter because not all implementations of sort support the '-u'
> option.

Yes, uniq considers adjacent lines. So for the getting number of 
_notruns we are using:

"grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' 
-e 's,^\n,,' | wc", why aren't we using sort? After looking at this 
command, I suggested above change.

--NR

>
> -Dave.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

