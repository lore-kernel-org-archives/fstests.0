Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C0C15B
	for <fstests@vger.kernel.org>; Tue, 21 May 2024 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716257806; cv=none; b=acYoOHV8Nco+QOikdSCdI1J2mOQX+1X8gan1vNI4L7BadsNeBnDTGHVGfcXiuMs+1SBUIfaq9w+sv0C3DfzeO4O/iLQd30pXuH6ED+jIlKjm5hBj4zGPVputF5UaPnHVFG4c8xQxTyfbbaKclniEL1TH2ALkCrjW3spQElA4ZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716257806; c=relaxed/simple;
	bh=eKnpfxvDaYq+DwDZHBRUy+U6nOAfeD0uRw7ixhZoG2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z36DW3KQBWry8VyMOPrEFMfvd71VIgTTw/sV9xzEpomxs5PXxo8VkwUnCWHlwf6DxKhZBupQZ/BNuD/QyXXEFhgUct/g/diGBY57oEAAbk16vgCq6rTTjBuPZoWGHCPmNufSGyPIgibTE0z9G/mK3TyuH6CzsjtrIv6j9LaFyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CCqbyM/9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CCqbyM/9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f30a419500so3404715ad.0
        for <fstests@vger.kernel.org>; Mon, 20 May 2024 19:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716257803; x=1716862603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mkKTqOw+p2imSeScmeiyaYB3xUiHp3oIcyaShivtNk=;
        b=CCqbyM/9uypoiaIUJUofXRYZNTejU3BvEfuh2ORRc+IyH5Xf7YC3ZN3ot05kgZT1SL
         oMV9xdr7Xo4F8r3evT+7w5LnXYk+/jtt4xUx2cAwF22UI0w+SK+lYmkxzSuJopOPztOp
         7KCc8wV/INVQqGbIAqgZUsHeyLfdM/u0na4q2QuiJSGYB1xxpbMJSynbBn02JLS8ZHJy
         nes02X8uWqWa/FiVEBhrNME/Tm1gUKPjo/ECBABakygfboV3cNZEsDhHtQjrZ6a658UN
         hrIZpGprZA061l00vsvv5pb4DzuqXvxK2NAqxfUp9FxbVvX6WqO3jvn9sJqnVCQ5a/XV
         Gd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716257803; x=1716862603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mkKTqOw+p2imSeScmeiyaYB3xUiHp3oIcyaShivtNk=;
        b=JUaWJO4t6IXxpjY+XKMXC5VcZSSEF7c713+4jOh5fbhBhhl47U4MK8GkcNbykUElWa
         5c9qWs4tt4d2tdAXfHYKvZJrqsrYDlh3cR56zuw25kdVqtSX+za59K/65kbvyLnvq+lr
         yUUVjnwbqJZR/vEqrhhJLL8Cm59iGPRjBho7CeGY9VTObPOxNK5vNlbWota5p/HPAJPI
         L4iTBYUhCoYu/1BEs1tfT28OVap1lrD7/zd06vMwsoP7UxFnEYrHyDqchXRB6LxexpC4
         1mqzl4/4szkZxGGNFLHrKuQizzRKBLAVhsRHOV1DapH5kS4SPWXTBKuei1kDzzzX5zfB
         V7fg==
X-Forwarded-Encrypted: i=1; AJvYcCV8TmmWVMY+5Jqi8rT2sNn3E3aPvaTeJOGn0gUx98anyaNlVugEy2I7h5y7vTjpyYUvFq3Ao7AauX5sRwUWFltYb5zObmpDWw==
X-Gm-Message-State: AOJu0YxG1nMfjmeVZeJmrbyhMt1ej7ZDP9L1p/gsLtmME7xyuFaE/Dzd
	6s1iEKTLUo/Nb3CdtkWry2zlBwyK0HbGW3oKEAZUyJyjJnl/k8Ls7wi00b081+M=
X-Google-Smtp-Source: AGHT+IG+ljMqQiJsntMg0IA+jPL3/O9ib+aSj/rx6/n7y5iVi7EkelHQkD9oXGx1+ihOevGAFZJxJw==
X-Received: by 2002:a05:6a21:329d:b0:1af:a5e8:d184 with SMTP id adf61e73a8af0-1afde224bd1mr34072911637.5.1716257803584;
        Mon, 20 May 2024 19:16:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628861725sm24825245a91.22.2024.05.20.19.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 19:16:42 -0700 (PDT)
Message-ID: <8b4f7d90-05d9-4245-889f-64c86bd81e98@kernel.dk>
Date: Mon, 20 May 2024 20:16:41 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Internal error isnullstartblock(got.br_startblock) a
 t line 6005 of file fs/xfs/libxfs/xfs_bmap.c.
To: Guangwu Zhang <guazhang@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <CAGS2=Ypq9_X23syZw8tpybjc_hPk7dQGqdYNbpw0KKN1A1wbNA@mail.gmail.com>
 <ZktnrDCSpUYOk5xm@infradead.org>
 <CAGS2=YqCD15RVtZ=NWVjPMa22H3wks1z6TSMVk7jmE_k1A-csg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGS2=YqCD15RVtZ=NWVjPMa22H3wks1z6TSMVk7jmE_k1A-csg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 7:05 PM, Guangwu Zhang wrote:
> yes,
> the branch header info.
> commit 04d3822ddfd11fa2c9b449c977f340b57996ef3d
> Merge: 59ef81807482 7b815817aa58
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri May 17 09:40:38 2024 -0600
> 
>     Merge branch 'block-6.10' into for-next
> 
>     * block-6.10:
>       blk-mq: add helper for checking if one CPU is mapped to specified hctx

Doesn't reproduce for me, with many loops on either nvme or SCSI. You seem
to be using loop, can you please include some more details on your setup?

-- 
Jens Axboe


