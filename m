Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8233101AB
	for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534069; cv=none; b=sA+mEHc2wDJe82AAlN/3BrigwIqILK3yjQ5sHffe3k9byAKMZm8ZOIdMAvzRrito3MgoZNj/d/WUdOVuIsGFHHIxAX7e7/MxPhVRy3TEgzDAtSI2Ea7CtYj909dmQ6HUstrgB/8+IxKKNdDdf/XuFIZlsMDMzPiSW3Xe9Khn//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534069; c=relaxed/simple;
	bh=moNZNLBrbu2XF+/99+souqRgCd//axKgc/BKTZ+KUtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFbRwEUsfrchUk41GBOqU8TnVhX8ap4P9GXU8XFWGaT0CuBssLTCVM7mIJBNbYNxZKvtFKyUgzdScPtHQhbZiWSdMeI0u2Ca2vyhhz7ciHIYwmm14LhKicqwpEw9hlc7AKEDkg4GsPFBzMc8PCgyXv0KmQN0pv5Xo87YnRNLFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/3SyM4Y; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/3SyM4Y"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ba49f92362so599176b3a.1
        for <fstests@vger.kernel.org>; Tue, 18 Nov 2025 22:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763534067; x=1764138867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tl5gdOJCiA2D2qewPGrh6FyyRoDeU74qwjXYHmRpPfs=;
        b=P/3SyM4Y2NkJaGIeDcLXva4XpBmOPA7gZMQgSFwpQFbeDTcl7bQx622tFTM7A/roHE
         E82vrx4KuOibqQYsciy0b8Yl/W+Tc7iny0XmNO64AE5lLEdMHieJ2P4ezFYOXuVv7vO5
         PJoe27tigfAvYmnA4bKiWDACDWCAP0+7PdH0IBkfdxKw7w/oIgVli762b3/Z5nUKSOiu
         3IelrJBjSBDaWAaKe3kmGa224HccUBmX+waRm83b5UUNE+a9NXWIQcbYrWw0KLU5bZGL
         s53Y9DhcMor8g24fk/SbFK+CTsxEBzhQ17ls6HEPMbEWN9EePadcKv5AB4+7V/g2i3Zw
         CfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763534067; x=1764138867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tl5gdOJCiA2D2qewPGrh6FyyRoDeU74qwjXYHmRpPfs=;
        b=MDb/0okVoGq/b8Z1RjIliQxYgE/UMLYBC6lKBlzSbkXvF/nSOjgBiVDIaUY8/JxuIU
         9BUNlZgWZ8VYMOozufqrL2DdGKVbWOocrU/5VQVjH/EMSboLP073saTO2djo0f0SiCam
         Bmsnt66I3KwufhQpdYKpybNyoFJ+Qpqw5zLiL5vS5R0mJjEdah7J7DgHUyC38eMfW0VS
         c8rf3qDMG2UIZsoJ/hj8NeiO2fa2WIkfyj8U3AAmgYrr7UZw+7Rqj/ZwcojqKAi7KqNR
         QgfYwaQWT2QW+8jX1R76Ke4+mwOx3j+LtXL9vuDZdWWzjR57kecbHqx92w5m17qv5Gd5
         3oNg==
X-Forwarded-Encrypted: i=1; AJvYcCXFwhSrjbUkKcWt+62XMEM4wwdB7SaT4FaBttaH0rS7kOvh5eKgnzOdQL8yfLHbC+8/EpWmGFxi@vger.kernel.org
X-Gm-Message-State: AOJu0YxaH9ak+aqndHGu3WUpn3DvqI/CH1IybMD8tC0c2OC1v387Xiwu
	ExZ8x+6tv1ZsuXjniO1rOqsQejl7IyTJZHTgd+tL43X7x7urXlOqKTiOvOukJHsY21s=
X-Gm-Gg: ASbGncvIKUIfglMOkDXsOX8pqMopFbyyp09aG264zxrQH0yFWbVTaCM2J0qInNvpS6P
	QP9n7plWN9BaV/UOTmQRob7YxNVzO0+TfGG8lta7B0jwGCAKrJegxaz9cXPhLaUIkk+gHo/NQdk
	SjlIxp3JUObPw0mF7wjfocEwrGmjVO3JrdX3LyhV6499kIMNPl6MjiAf9c7tpbX5O7wmFmUHFcS
	Yedx10RRQh9o9vhbEtcA964K1dC/lTTEHjsTKlPqakA5767xdikoqyp6EhkZ/cXERdIcXYfLErN
	EXnkkqQw5XWfcsOqRVW5mtaGycWXf7DJNqLV42WxXIrd8liK65sD03sG0yGPLl+G33aQY4dxwoV
	Y7YNoB5B96J46h74vIDaj/xwreUuYE8z2fvNrM/rU1eFc74BV4opx9JK5Fi+JNBcAk6+z/9uzgq
	fI8kY0OlL1synX7j3IV/leA365ruXurnVvkclGtkYP+6DUKEND7rQ0/NbLx6lTqo57FryffWw/y
	ok=
X-Google-Smtp-Source: AGHT+IFkrW57P8oreP3NqKyLFBxoVDgyf0DvFrpPumGyte/tXzCLDbNIJIX8BMIisxhqcKaQ+6eEAg==
X-Received: by 2002:a05:6a21:151a:b0:35d:c88e:4603 with SMTP id adf61e73a8af0-3612e870b1bmr1773475637.3.1763534066865;
        Tue, 18 Nov 2025 22:34:26 -0800 (PST)
Received: from [192.168.1.184] (softbank126125156093.bbtec.net. [126.125.156.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc377414572sm16657418a12.35.2025.11.18.22.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 22:34:26 -0800 (PST)
Message-ID: <61e8777f-ce11-45fc-a3f7-436c5943eee9@gmail.com>
Date: Wed, 19 Nov 2025 15:34:24 +0900
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: Add lustre support
To: Zorro Lang <zlang@redhat.com>
Cc: zlang@kernel.org, timday@amazon.com, fstests@vger.kernel.org,
 sihara@ddn.com
References: <20251118073011.362595-1-iceyangxiao@gmail.com>
 <20251119062543.lhqaqn3h76btxyk3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Xiao Yang <iceyangxiao@gmail.com>
In-Reply-To: <20251119062543.lhqaqn3h76btxyk3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/19/2025 3:25 PM, Zorro Lang wrote:
> Hi Yang,
> 
> As you can see, the fstests community doesn't like to spend time on
> maintaining fstests for out-of-tree fs, especially downstream-only filesystems.
> I'm not a dictator. If we accept to support someone filesystem and its
> patches, that means we'd like to spend time to review patches for it, think
> about it when update fstests, fix issues on it, and so on. So I'd like to
> respect the willing of fstests community.
> 
> For bcachefs, it was in-tree, and we know its contributors are still trying to
> keep it up to date. So I'd like to keep its supporting.
> 
> For glusterfs, it's an upstream open-source filesystem, it's base on FUSE of linux
> kernel. It can't be a kernel module, but it's a pure upstream fs at least. Actually
> I brought in it for testing FUSE at beginning.
> 
> So do you do this for*upstreaming* the lustre filesystem (any active source code link?)
> or just for using xfstests downstream? If it's the latter, I'd suggest you to fork
> xfstests, and maintain this patch downstream.
> 
> I noticed that there was a discussion about Lustre filesystem upstreaming:
> https://lore.kernel.org/linux-fsdevel/DA28F0FE-ACB6-486E-BF3D-85AF328FE2AD@amazon.com/T/#med943c38d27ddac1b68e9db37d6b0f2803ee6133
> 
> But I haven't found it's online. So if the "lustre upstreaming" project get
> an offical version be acked by mainline linux, fstests willing to support
> its later developing/testing. At your early developing stage, I think you
> can fork and maintain a downstream xfstests temporarily.
> 
> Thanks,
> Zorro

Hi zorro

Thanks for your explanation.
OK, I will fork xfstests and maintain it downstream for now.

Best Regards,
Xiao Yang

