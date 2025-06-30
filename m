Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F12745C
	for <fstests@vger.kernel.org>; Mon, 30 Jun 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307385; cv=none; b=et5nTdStszRiO7HQdQAp1b3AoEAeRD+d+HoDQv4vtJZI8AUfc0IJSOXJ1tpO6hPSdH4bp9TACciUeNr2PZyA0d+vC6zV+xe7d1tbSdYGNigqsbuVI+DohTXk5++tm2hj6NG5pKkE+KWi1z+bcf5zL4vOosc2O8TXsi0nAMTyCIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307385; c=relaxed/simple;
	bh=1teiLudPYpf74cEKxc0pbm43CR4cAzMv9mQ6dgZ6IW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mY7ejKgnPfijkjZZGACL2tc9T2+NXHgbGNcJ5u4YaB6QTxzwyXLoIBk10UyNA9Zmoqz4izgNKEnp0XOXfOONavykAMUY/FycsoPk3grWL3YqONb8m14ppSKww9Kjxf51wmUDCGWTXe5DvfpWqDV3fhDq7iaqnDx9rl9bD1MJ9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=versity.com; spf=pass smtp.mailfrom=versity.com; dkim=pass (2048-bit key) header.d=versity.com header.i=@versity.com header.b=apwotjs5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=versity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=versity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=versity.com header.i=@versity.com header.b="apwotjs5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748e378ba4fso6599473b3a.1
        for <fstests@vger.kernel.org>; Mon, 30 Jun 2025 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=versity.com; s=google; t=1751307383; x=1751912183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzml6Ua+vkYGqwJQMhtpFrMUzAwJ0KTmrbULPKrmeZQ=;
        b=apwotjs5SDqxcZptTo7OJFkBcgtkwkUeV0FqzYHySp1HtsFIHesTrgbUOXeT9WmubK
         El/IO4tz35FKjE0DhhRyXirtho132GQoP+alBN4IuaY1odKWH2TKs25ufvUg+8FDPXGD
         VOanHtwrEIu09E0InDE6mnI/vcLApyDbsr8wcrk69aTmyggUdL1R7q4yE2vhyY9jF8O+
         a+ziCuac8F0ShQcQVgrf9S980XFE9Gu6qMMa/jOqbBMpjpEbL+MtDPlwTsq/7PeDqL1J
         4jp2epOaF6cs93kirK7T9AyienonD+F0CyY79mRqyAIYxH8gyZbEfktt0oNYaMuRiAK5
         Yqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307383; x=1751912183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzml6Ua+vkYGqwJQMhtpFrMUzAwJ0KTmrbULPKrmeZQ=;
        b=K1SZjGLuTGmqz8io6c+ZK6ZExX7r/LAbnmwwQnO3PStHoQvEHkHqNLa3BHkxLOZk9c
         T133FT5ignpkFpS88He+6JZPA/RXwC5el7mYc25GSl30wwF5/rJldxCnZtcsWqnnzw5a
         loR1N/wSEeKAZ3zL+dbbQX8rVhwxJrpRpJ2VR89WHP/xyRqLM0rNwCpY87KjXZL2kM3w
         OnrbII9AX1IfurC85rx4rWaWS4L39RWitvlAouExBMgM4bAuXCsls15JYT2uXyc2F4lS
         YffZ0E0Luq0tVIH9kc6xVIFfgk64ybBcnudfqNJWRR0CFGt8XtMlsuF38baT0bKtBH8M
         D7Gw==
X-Gm-Message-State: AOJu0YxTIX/OSanE8g13dd0P8XCo61j64wBZXt22qt8CvX/btoMI/kFM
	opYY4l8+p90TVJ/yUKWkzNxBy5bnM7N5TfNIohjMNqYDl0laC+4kKdF5PPnN4WtENpcRm8FjcWs
	y6yxL
X-Gm-Gg: ASbGnctTzL7Fmyio8qK9QsRHdQkEqQwWqCzHuwEu0A0CcBU/Gi0w5H80Rj9axRAq/DE
	Y7TJwpBgcmZAkuWWMrYLZZruOGOBJa5x2Jncxfqh/y8UpSdIw1UlfLpgpZ6jb7L05DD/ke+Jteo
	8qlUo87Vd06a4CIlhHueaTN8kFSp65rkabD3/eAQOD1Vda1icdE80oIeK524++JBLI4GRKd3/GB
	escj5eDEJlrhFB26mpojvYGVlTX/Q7sHTwTMDrXfvQkQTvSccvVwPE4fF43b9UakD6NlOfFbDqY
	U5I9WGlx30QJ5INYDevuNlewfIRvwuzDyaa7sG24l79+a1ayZcIMGkRIrGeeTgMCWO7DtBVMFjg
	9L5ilf1kAdek570cR+0g/PQXedby/wOuLzkE/bgLhT+o9
X-Google-Smtp-Source: AGHT+IGuH5QBp5/ernqtN6PHBgnCkuTvXfxo53bvJ2yho59RhiHvoAHsQSO5hpVWKmlQtWOqZwmbgg==
X-Received: by 2002:a05:6300:4cc:10b0:220:2bd8:cfd6 with SMTP id adf61e73a8af0-220a1a63177mr13376110637.40.1751307381295;
        Mon, 30 Jun 2025 11:16:21 -0700 (PDT)
Received: from ?IPV6:2605:59c8:474:a101:9fb1:5c42:6eff:124d? ([2605:59c8:474:a100:82ee:73ff:fee4:d15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57df00asm9575340b3a.148.2025.06.30.11.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 11:16:20 -0700 (PDT)
Message-ID: <a9a226a0-62ca-4f50-b481-9cc4bdd04d0f@versity.com>
Date: Mon, 30 Jun 2025 11:16:20 -0700
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: add scoutfs support.
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
References: <20250627184220.114746-1-auke.kok@versity.com>
 <aGIi7wHaq7cPMiZU@infradead.org>
Content-Language: en-US
From: Auke Kok <auke.kok@versity.com>
In-Reply-To: <aGIi7wHaq7cPMiZU@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/25 10:38 PM, Christoph Hellwig wrote:
> xfstests is only really intended to test in-tree file systems, or at
> least those submitted upstream for inclusion and still in-progress.

I hear you. I don't think this will ever happen.

We've been using xfstests to test scoutfs for many years and rely 
heavily on it, running it practically non-stop on scoutfs in our own CI 
infrastructure, so I thought I'd at least test the waters as I'm in the 
process of updating our local copy of it.

It's entirely likely we'll be maintaining scoutfs for a very long time 
given our main users are deploying large scale archives with it that 
have extensive lifetime spans.

Either way it's no big issue for me/us - this patch is rather small and 
trivial. I do personally prefer to push things upstream once in a while 
to see what feedback comes back, hence this post.

Auke

