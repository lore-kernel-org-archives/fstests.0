Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66D303A14
	for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763526730; cv=none; b=fZNzFzs813uRq7QjBFiwRzN3fwzZtoz9FL9e/KBWLKTbnviXLNciDQ7d4xqSjKis9FqMZYXm4yk1V1rbKcmctjL8cF09iI1e/zyOxJjiIegcEM3XHd5BRXkocTS0C2uiTj8J1K84wNmzQmsAWa6tKTpkLFiQpqqslusla8lO09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763526730; c=relaxed/simple;
	bh=/m89jfT30/tRwbduCIRVfxDeDV/FT+EuXQu8opiBvYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leXVZ/bYYvdQKoZJMEVFU5r6KNX2E5oJG7Xs8IE5ssWL8909NhY6u0Wd4ZysODgc564dY92IY1PM8vj6jaHZT++vhxdmmX2VOKHf3Rhq/OC3KYo71hIYtlFSl/yoPOnWJsM5RjXRtAPrSiqGqMQEfBXwh21QFa5at1pGL3k9enI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW9s6PnT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW9s6PnT"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3436cbb723fso4767661a91.2
        for <fstests@vger.kernel.org>; Tue, 18 Nov 2025 20:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763526728; x=1764131528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbpCJganupDYWz/6qwfm+7PVu0pYwieTdauDHhZgBqU=;
        b=PW9s6PnTVDcLOAZKzwVyaQIlNMgeoakv1BcNk+TLm2l8aOs/hood2B1BVAOXjw9fmu
         cIVqmEwH8A0hLYV4+cn5YaU0lAxnTqHmnjfWNrZobSiFmOXl3HvB/ozsub7gG5pthv3n
         vSRR4CU/mqG5GBqV0r23gs0fHsHVn0AEEJ9lQZ3gbRTjdCsWDP9M4EOGXmaZ599JAaSD
         FonKS1lVojLBZ3lgpck4j1dh32cSzZtw7VEfa8aeBF5j1f7AiVGZhNAX9zcNwdV8OG5w
         nwuSjZdwiK3ZR5dHKC1J97NjnFYMKplJqcqzgR+cv8RZ94cdxx94FA8seTw7p/zzeRF0
         cZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763526728; x=1764131528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbpCJganupDYWz/6qwfm+7PVu0pYwieTdauDHhZgBqU=;
        b=A3lFMiK1gwzBogpGd7GOd+Qr/dGUvg6JWtViLxL1mxCWv2hFTRXqISVJvlcCZ8lQ6J
         6MdDrtFHWuhCF81F2AwI7TlJ6sTe8CBI0jlXsGTYP6tnVWN6spvlnLbQ6SRoTlTmWqcZ
         pFrmpKCCaMY6Uxj6LOY9sMY0DpjAaC7sFnYooMsL7jvbjkcmS2u05xupXqcQZjF4kt8e
         TNiautsAWvkQKYYDY4wja1620cei6hak/nISQIw9VUVfDXQ69k2Cvr7TiCO+8rJeE+FN
         Xe1NYdT3vreBAHa/NCZ9YHijJcnoEBaCeMa3XXba9EA867C8RhMJL/jSmGxbJm1pPr3Y
         9d2g==
X-Gm-Message-State: AOJu0Yw1cM+ack24bRepGMOuew8n6L8yekEUoI6jneQj2tK3MkJukHVB
	0pe1QxMzoDTgMs8XASIWLa+a6V/TwuYATXl8AGlBFWHOw+ucfxyRZeqf
X-Gm-Gg: ASbGncsMBqaIcYdbeBBPZUQkPFUh/Avo1z/nGQco2tECPfQGc577SetrA2MneTNEfBl
	YbQfMUeeSifZRmmRgCOjBj1ZUp1x7xCzeVrJ2hMsGrA6TVczwat1tIU/5aPcvK7859U57N1z1KD
	ng5/1mU+a7PdTAXsMtBdgIZFvox8QySA3PP311rVy6PWAl4v5bxgyiQvaThe2mVbWRR0EVRlCoX
	jW6m8qNkpWHwI0/3J+nnjbyWXNmG2x3/ckHXRnmpv72Irii6rQjEphB76BQJbVF2pp9t7Ql6dRi
	taneJH14NlQpUr+gr1gl84mhIP1MOkyjcah4iPyIAL55HhDi1n22cEF/lH2C1MJNLSHwzSLiACx
	IAxGy0/zeCxtJkMXbMUobhVEJ5o8oAujQch1oOoxNJDwwEQPlk8bY2l5BBEgqqpdAQSTIfeglQm
	gcpZ4phQahavl88OSSvQ6Bc56iOCObM3qrYctIFoE0PAS+G/uKvHznz66ulhawhOtB
X-Google-Smtp-Source: AGHT+IGFB/hNJSq9N3IFy2CuHxuLbhecz+BfCIwB5wH88g1lU1XObaYPaNBaww05VuRvheo4XRBfjg==
X-Received: by 2002:a17:90b:2ccc:b0:340:dd2c:a3da with SMTP id 98e67ed59e1d1-343f9e90725mr18304321a91.8.1763526728143;
        Tue, 18 Nov 2025 20:32:08 -0800 (PST)
Received: from [192.168.1.184] (softbank126125156093.bbtec.net. [126.125.156.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bc110a6dsm1060780a91.14.2025.11.18.20.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 20:32:07 -0800 (PST)
Message-ID: <c23f3979-2556-4c14-811b-d5f27dbb961b@gmail.com>
Date: Wed, 19 Nov 2025 13:32:06 +0900
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: Add lustre support
To: "Day, Timothy" <timday@amazon.com>, "zlang@kernel.org"
 <zlang@kernel.org>, "zlang@redhat.com" <zlang@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 "sihara@ddn.com" <sihara@ddn.com>
References: <20251118073011.362595-1-iceyangxiao@gmail.com>
 <7BEC5D32-095C-4128-9401-9DBD2A861CA6@amazon.com>
Content-Language: en-US
From: Xiao Yang <iceyangxiao@gmail.com>
In-Reply-To: <7BEC5D32-095C-4128-9401-9DBD2A861CA6@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/18/2025 11:52 PM, Day, Timothy wrote:
> fstests accepts a wildcard filesystem type. I_think_ the wildcard
> assumes the filesystem is a disk filesystem. But could we
> improve that enough that it would work for Lustre? The
> changes required for Lustre aren't huge, so that seems
> plausible.
> 
> Tim Day

Hello, Tim

Thanks for your reply.
I think this patch can make xfstests support lustre.
Would you like to improve the patch or add other features? If so, could you provide some more details?

Best Regards,
Xiao Yang
