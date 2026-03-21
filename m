Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D126CE2D
	for <fstests@vger.kernel.org>; Sat, 21 Mar 2026 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094571; cv=none; b=kn/51asPleVZciAwFXwp3ABaTNij39rVq+72sPFXiu+r3zb4GcC2OYnLHzjmcpx2KCUCo3/fqsms2KXYgLUUfcJwkdu9djrb+nqlEEw53cM1YoVIFCd/P5fan+MswI6EZqkAQY6tQSBOQj07Fmi7j6G3RKeP2u42lJKA6TLFPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094571; c=relaxed/simple;
	bh=/wI/foD0sk3pGIuKEZloRKbbe3z74+E/1C7uRYDLQWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EirVky4lpp/7ZveAWdBF8B3P8jK48xSKvXmnmD1UgYMYrwzzxOySOn7KaGPNwwDqeow+hg7uLGRiDhSKNdw5/bsiVEpfK8nNP5mZTMUqsWzNnZwykxn2ttYR8j4uc7qBvDomu768cGUVDNN6MOPPwCMnUbPVWfQ8v5GA9n1F31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbLBeksy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbLBeksy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35a288a2c00so1337199a91.2
        for <fstests@vger.kernel.org>; Sat, 21 Mar 2026 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774094569; x=1774699369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4qgRGJ4UfwI3KD62cy/WJqflPXvvOjREmQMushdZ80=;
        b=hbLBeksy2DH9qHQBgZA2M7VEKpHF+2DNgal6Re6CVYa6uPPgN4YNixB3OVi/NKW1t6
         N1vaj3rQ8zjGpfqxfJ/UiDcKuuwf0HR7y5rMz9l2wLG+RB4oGIWXtCcaINHDNrkr3HF8
         6x8ldaC/Y/5/zZRUaY9mUPqBUyD6OANUcXKc11ovQ02hVdiY0DQzP/QD0Sg53UPcFhEg
         DaMXxslEiAfuCu0XP1Rqglr1+ORjZiIMVzH8LZGtKTMoZhsfUovuEmbOQXqlg5m013hm
         l0NWVg6gHmkvyy2oX5DoshKJ70XnQVIAG+kz+wAkr8fNYMRzlHPZLFeZZmVTgmeMC8ZS
         MgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774094569; x=1774699369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4qgRGJ4UfwI3KD62cy/WJqflPXvvOjREmQMushdZ80=;
        b=O+OoMNYCOc5W7LHzLw5ffG/UoLveSW12bAeXqLx4E0rNzw8JeC0twuhisu4L1w89Uv
         zUIh5qucYFRgvcuryDhV0kT0HPetV8ppios9qSUtPk7Wbl0AYJsBX/NdvYT7UHocYxX5
         mbkmYGAdBrnT2kCjflQFcEtTKdsULvEm2Bh/2FtFU3LpRLvUb9nrva+HyImZQtv4jYtm
         j11p96XY5Z6KfFib4NLbsFzuXy1pMZjcP6+5h1W6tuZ+vYylkDzlcctnNHcQ1zkX001u
         dJCyYIn+TsfRoThV/p8MFub0aTManDtnis8hkx/sMTak7K9AN3mLG3+DKOIO3k2nZ3Fy
         wF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+2AO4e77abA7782412ng/tvFCaJssBvWSn6yXXE1BYSD6e+sVj/DVNsAmm5oaEmhP2c7L6lri@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3y62ctF6zIf6D7GEWSPbVa6bOyrs9qwITo24WLCg/1hib/i1
	zy0Kn2Oz7yyzYYO5Fc+yfXzkj5pnwaQmbTrQthltN8l/3AZ63bPYsSri
X-Gm-Gg: ATEYQzzBcAlIoDW3qyKJ2pTNSVLdV/+teIsDWpoOUsI2HiHHGKl+4dQzJqef3ZSmrec
	HCS0nmWBWzBGRalWpFyA7gic+lpesTEWxsFE8PWOk2+p2sGw+BPa1Y5ngyEVwRBlSfqAXbL1og/
	truXybYIxsMBRPajjxoAM/TzQ8AX2ptlaCwGrVkkXwqgcVyuhdcPRQuDy/yKeUp2/jJXfTi+aCr
	5+ZtvaaMpGRNl6m8/imQjnA66sArMB9IGo9ZtctmlMK5J1Yhd3kdLulbtgoHyKIzIhYRvvh3afC
	u31L3aODiuOq8dqlEUbsdtBrdfBfLsYqABqc6HOJ5QWYv3iE+YCaLiQ59BbVtAqRcXq3WYSLxM7
	CsmOD87tnCNokD9FJSQ+9maaq2/A/T6r+PT0SZ7m25Dt62/NdxvOKCB18UcePGzfXo0zFnXLldQ
	NOVGWdNaiexNg6zi5cwS6ho9JWhog=
X-Received: by 2002:a17:90b:2242:b0:35b:a7be:ae62 with SMTP id 98e67ed59e1d1-35bd2d2c8e1mr5178568a91.30.1774094569246;
        Sat, 21 Mar 2026 05:02:49 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c232sm7268972a91.13.2026.03.21.05.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 05:02:48 -0700 (PDT)
Message-ID: <dee6a4db-5b10-4cec-8090-30ddce8858ea@gmail.com>
Date: Sat, 21 Mar 2026 20:02:43 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] fstests: add _mkfs_scratch_clone() helper
To: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@redhat.com>
Cc: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <cover.1772095513.git.asj@kernel.org>
 <254fdd3e212f6618ea33207ef24db2b316d2d8fc.1772095513.git.asj@kernel.org>
 <20260309191317.vxcjvqfpoqdiycki@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <43710dd2-4282-4475-a29d-983295fab86f@gmail.com>
 <20260314170422.a62qqwqe6agom443@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <abgsorUy3KM8KZV5@infradead.org>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <abgsorUy3KM8KZV5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/3/26 00:15, Christoph Hellwig wrote:
> On Sun, Mar 15, 2026 at 01:04:22AM +0800, Zorro Lang wrote:
>> I'm concerned that testers from other filesystems might not be familiar
>> with SCRATCH_DEV_POOL, as it's typically not a requirement for their
>> testing. I'm not sure if they would be willing to configure and switch
>> to SCRATCH_DEV_POOL, just for these few test cases. If we can avoid making
>> the pool to be a hard requirement, it might be more user-friendly for other
>> fs list. Welcome feedback and review points from other filesystem mailing
>> lists :)
> 
> Yes, doing this using loop devices or ramdisk is going to get us much
> better coverage.

Agreed. Let's stick with SCRATCH_DEV compatibility for now.
v2 is in the ML.

Thanks.


