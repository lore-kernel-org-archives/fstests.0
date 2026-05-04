Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D86362133
	for <fstests@vger.kernel.org>; Mon,  4 May 2026 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931593; cv=none; b=r8b/ZoB4TS2QlZx7uMbzOlnN5GDqaxdRqlH6Ux42i99P8u4R1O7iJ6eT4Ca+t3mETNgsTqXViu7r3zbWPnuyFBa/uPG34+A/b1N3t0aaaTGFS/cMkT3uiQFWDNdVMm3ypgAMzsEfTXm5KdZl2QDulCv+ToH0oI6hbYYXgBpH4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931593; c=relaxed/simple;
	bh=Dnh5BL6xJ72ipR9U8fPo48Nov7Fjz0cNnckpLk8ffqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DN2KgNdlyJkW8vC14L/PXdlXUQvQxoUaYJkBDGG05mq6Cx1QCJQkLcnSvwAQGb5ih03HkySC1eJeEUWoMjxvfoYUbvIbbGWZuIlAmTxc0PmZK5KK1lUymbgHT4NVAebK1u9cRdvyr6D5XAnD9cXXn7SJ8Py84SK7IWxYxeKZBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1kozGNR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1kozGNR"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36536771300so1071329a91.1
        for <fstests@vger.kernel.org>; Mon, 04 May 2026 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777931592; x=1778536392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dnh5BL6xJ72ipR9U8fPo48Nov7Fjz0cNnckpLk8ffqQ=;
        b=J1kozGNR/TEwVEcoWG5lYsx7whDPKlO32BTdIKZs4FRJ4v7bSCDqiU5gxon9amNCD8
         8ADOX7juKQf562uR0RPyecy43UJTfeJ9W/jTSOCeE1Qg8PrgoD7yetguqm6DzNtwtXBI
         NeD5uATTrkZs+FZLxhnC7hDjzC15vVQlyA8pBeJCDnjHp3AZiq8amYRxI88AJv9lhcuk
         HiEEsRYn2huXjOa74MZqM4iARMDV/N302+c0c+0eON5E804GhPq+GYw45hAoDNbwSv6f
         MGWVVPwPnAF0nGcPi1TBtUoPqeP2CF2gqfH/TapEzg+vAuTfi+EQLwv2ua2Ey8FMOU/L
         MkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777931592; x=1778536392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dnh5BL6xJ72ipR9U8fPo48Nov7Fjz0cNnckpLk8ffqQ=;
        b=nCcoKewzvDplq54nvJr1vtR2w9OZMmEpnwCCXytdP/2VNzZ6KLOM0JpzDOGHwM31Gh
         S12X8DjTKSQ70buKxweNuPrLl4ydsSlVcsZMlK/41Ic/WBmIssu8d0HLG0TyJdUBn4rP
         zED1LV3uVvUVfwyQzkY/UJ66JS9OcZpYvHJslZx3J0rc0zuSi2uKi2QLShYgLlptJQnN
         GXnTvv7Vv8fv5ZlPP9dYpPB/Ru8GtwxtgwJy1zKCNvnwyoFTdKLH/RvOJLR0w/iNl/g1
         B5JjaMXIP2yF9Mnm8lE1fRJGpI//upaMYCGywtPGygjWEQUfJbN6V8HURGJBKC6nqaM0
         Vc3A==
X-Forwarded-Encrypted: i=1; AFNElJ+NOHO5AEVjVWVElz8XVt31bnmMRjtnlcuQ6uHGvrHgEBoRykSgj+CtzWON53sTrlfOIw3BjK/6@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHTJDFNTIzyvnvx2JGF1Il7sLljJrkgVo/OK6Y4bMJ4Fvaonr
	QzVgKZ81CZaslFkVElcAuOfitVed6tfTx9uZnuZWjl/BZYX4fIUpKfyT
X-Gm-Gg: AeBDietG+4pvaIbKe1E2hSEbn2kl6tLF9hYGi5977nP6LHfRam0L5L3LG2kJQE5Ohdf
	IUw6oxjSU3i6vlBKV8UdynylDX4Tc1n3izgcoeIJA8fOfsZiq5rNpZ8Ww4p7xPUEqHtYrS5vc3k
	phamWilawAJyO+zgB4Kllw2Irvt4cg0DxMYLH0nv3pvBe6A8/g260fqNb8KyO8zeZOzLu166otC
	LyPCU5jUwJujaWRUM1J00aYAaH+6Q/PSvmURZeuM4M8bi/G2ekSGs7S76WSLOdPM6Cyn+HT0EqR
	pac5JyZlTfytzPaO2xJzboKKJ1oTMPZ+U/a7dJRVbGTidyAbJxKyvmMp6RO1xFaPQEciDcctHhj
	/UY/+l6rDxad2IaxIpn3yWwq6Bz1XYMq2X1uDWd1jGNVmNVViqhdh+4lFPWpfsPlYOuG7bTC7r6
	EF046BT2bVuHNwToTrSYZFjC932WN39mdbiU9qXGU=
X-Received: by 2002:a17:90a:d648:b0:35f:c258:a9a2 with SMTP id 98e67ed59e1d1-365729b398fmr943479a91.17.1777931592114;
        Mon, 04 May 2026 14:53:12 -0700 (PDT)
Received: from [192.168.50.119] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3afdasm117093125ad.62.2026.05.04.14.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 14:53:11 -0700 (PDT)
Message-ID: <7a5a4c7f-2c1f-4dc8-b2ef-b052b62798dc@gmail.com>
Date: Tue, 5 May 2026 05:53:07 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] common/dmlogwrites: add _require_log_writes_sized
 helper
To: Disha Goel <disgoel@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, fdmanana@kernel.org,
 quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <20260427122551.71696-1-disgoel@linux.ibm.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20260427122551.71696-1-disgoel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


looks good.

Reviewed-by: Anand Jain <asj@kernel.org>

Thanks

