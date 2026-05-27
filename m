Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252037C929
	for <fstests@vger.kernel.org>; Wed, 27 May 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921705; cv=none; b=Sikp2ZS3X2BNVwE2LfpuJTjNM2M1XrHnuT5yAavr57fiErowAd/Z4r9xA+2/5AVkzDtvfs3qkMSnhVpzODSKwsIQLsriezGxtLxTCzUIC4f9Y5Y0NYzkigPiAq9As9SWScZjD7r4wdogdcQWE9yvNDGAkmC0djW7/E/Z1SyXcKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921705; c=relaxed/simple;
	bh=LWyhWusqHr4rQgdvmPOrVaCWSEHYAt554Q0TgVqFBAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJXTQ/IMVWyJ92xEVPDmSGJU61t99YU16+BfiYOoJ+9plUyK2W2BBRSiO3BbZVAHjgbHwXWLDwGwNuXOAoIQO7KKV6OIi5pCoO9EP71yhZJP2BzRi0dPwdkaF47zlAfY8C31NIgspxBe4yfRHZJKG93SC7EcA/De76vTsOIBqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiP3Fx58; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiP3Fx58"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8383fb7143aso5397715b3a.3
        for <fstests@vger.kernel.org>; Wed, 27 May 2026 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779921704; x=1780526504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PS1QiPPseraqYZzSGuyGeQTFkHJ1l+wgxnVan1O+b0I=;
        b=DiP3Fx58Z5VrEdwY7kjptCOepOOHDy8zV0Ac5ySjdW4f+l1+vDiBNiKiBzu636TGcU
         3sd38WaRMSNrRZa7jxWC6anAxvVtqvkF45zWGzfHYfsB63mQpm0pE2dVt0ekNpNkLrGV
         n7b8kNYbZykxiWAz0q80vZwxp1S4oPKT0vqK2gRuKayCrK9iKcs/yLF1DhugXB/yVhzr
         i+cNR7W1V1EHZvWhyp1OGlh8hOpQCMkEieT5Csk7MMjEqzw1c3aSKtzhMAqzX6fx4r/O
         lGL6DMqEu1XxRvJ60EBWZ1DIt9Te+oi3ZPE6r1i02MYAksmoVDr/RVwd3vRlv1pIFcy+
         xIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779921704; x=1780526504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS1QiPPseraqYZzSGuyGeQTFkHJ1l+wgxnVan1O+b0I=;
        b=RdHrHZxkCuUmGzGvMzIkLh5N8i2J6cmR1p+KcWsl+FxFQkWUe2dtomKU2sWAcqquxm
         nGi3YcMhb5p66eoxVShYDYgqSoTAGleZ9Y+sDPZu2wuHyVK1DLcq0RZABdqubAqoScxw
         IKNRHGVjT8kkLUmt1+J54YRRGl2o8ZVyyW2POHHt2NrbJgaWsYCPU/6sCFzfRnLSoMhB
         5d+Bqmg3XbZP4UG74xcaTwVwFH/XwQWIJNkibRdhahvkXNQ3QC5x73o91uTmu87TNSyM
         ePAGKpzHnzH5v0+DiF2CcIWG3tI5OlQCwJvqoCJvz4O7kS6CW0OGgNAhfmiBe5BCwybU
         CqeA==
X-Gm-Message-State: AOJu0YxvoA+H6kZo7FlRVkBWKvTs2p5/WAp7sD42fuVXDO/fpmiFN57A
	oAYSh74PfwbnIyoZJ/k0JbwcVrigN3ycgilY0AvV98VSMMGLpxeycILJ
X-Gm-Gg: Acq92OECBqfHxVePAX4ocGqQavAc9++A9kW6ZXLNjiVJTMfe9AILerMzxYwCk/BcWVL
	ry5a7U7+hOJiqvOrxE80zfZZ6LJ2NdbpC8VB/gBx4dj8JQomlztiLvu3A8WBEdIxxKka5wuJnGW
	ddS/IYBvsCLfnCK7iNkUpd8AeWIQjjooeJPqXSA7GCIAjikzGLzNOTys6FXz41kpthI2mgW11JJ
	NzzEmDujgfD4tKiDUDjMSrHN+oRx20D0oQ/8OVlAJB0gvw6L288AXHeoO1vlZQ+R1SBDqus2K+8
	Dx7ynUgxDYoJTLhQ9i9QzOgO8Z/d9E+VSTFB5A1MA26+jpttdL46wyYOFEuO4tWSm5CaOR8vzPM
	8aSnYFCtxYsDIzyRCP6hC3MqA0RS92Us+KKJ0G8C8xY7pJcAu/N50YudW3sY2Yzfd5fFAfG75FF
	api5PD/Fs1FbzN0yVXp7rUANK8ObaAQMayHNy8fA==
X-Received: by 2002:a05:6a00:3a14:b0:835:41f3:f453 with SMTP id d2e1a72fcca58-8415f3f67d5mr21283194b3a.17.1779921703896;
        Wed, 27 May 2026 15:41:43 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eac68esm3382981b3a.15.2026.05.27.15.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 15:41:43 -0700 (PDT)
Message-ID: <e039c677-073b-4201-8588-ad84d58639e4@gmail.com>
Date: Thu, 28 May 2026 06:41:39 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] fstests: verify f_fsid for cloned filesystems
To: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, amir73il@gmail.com, zlang@redhat.com
References: <cover.1779367627.git.asj@kernel.org>
 <a24645463979d0550e0010030995b0ed609215c1.1779367627.git.asj@kernel.org>
 <ahP2hjv9zl_WL1kg@infradead.org>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <ahP2hjv9zl_WL1kg@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/5/26 15:13, Christoph Hellwig wrote:
> On Thu, May 21, 2026 at 08:54:55PM +0800, Anand Jain wrote:
>> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
>> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"
> 
> Seems like these are stuck on the btrfs list.  Any progress on that?

They are in the `for-next` branch of the Btrfs Linux repository:
https://github.com/btrfs/linux.git
