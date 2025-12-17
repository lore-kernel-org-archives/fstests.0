Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D52D2398
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990894; cv=none; b=LysQFREkmWIIH3JAfT9r+jDKjDsroc2eo7wdgxQR7596cKwme1VLI8OiyRY19kaKmwq7ZNkM1WTrNuFRdxdt4z7cK7iPrGkRJwsMdYeUoqx4KgE8rKOCJX4FfaGSTNC3pa5T12BqPGYQ7NY1nubbwYMkLDvbGxJ5ipQKdQKjZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990894; c=relaxed/simple;
	bh=fpFnDzhZoXXWC4Kp8cec3dL+gf7xE0QtOfAURsHF3rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3H7hhjWV8SCGmnO0MJzqDnY7T690eHud+BOkHZQNVOxejdS1teMgHxKHbe2zHvSPsQhU8AsCIBcZqp13fwdFXRQUZ4neOWs2IV5/9O5FBV+McWx/dHENDIN3qeF9n5p1/+yV78Oi8AL60uHc2I5wK7+hT7/sj9Ji0nP/KtfbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRNXm6df; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRNXm6df"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b75e366866so2586807b3a.2
        for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990893; x=1766595693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+FQObq4BlmA1znanAjBgJXenx2Op3zd07yw7QPGN50=;
        b=JRNXm6dfFTxJU7MeiG6VfAxetUn2Yymb8CujQpCWkCS5so955BfghZ5PbbwGBsvvxN
         6Bl7BjhAXs5zuEHUEm3AJYCpUKHdOIDVvLeY+G+yB0lsui8K/R9d4F5vzYYc3q2R9JJF
         sF0wdZvx46yWUQR1LKZX4GxT4h8+Plr3qElmcP/ai1ph/AnWVWz68ay67R8mSxBqv6tu
         GbVebgvwy0NXhLmHqz2WQ1cIVuSTWicbJZC2BCo7YIB6QpI+cMCBEHSPAMQdaSCgNPqI
         ym2dT9H6I8RitVl7RqleKcr7NdEC4XhT+6KMy6kQBwtyuPlP512n/Q5QWHydjYXCIuz0
         1JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990893; x=1766595693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+FQObq4BlmA1znanAjBgJXenx2Op3zd07yw7QPGN50=;
        b=sOL62rCoNLhCwSNq8XQfgHBB9Xx+9Tpi5OoeFSEu7MfYhIPiVpwZo/NZd8xQW+XzWC
         K5p4TXooSmLfDNCcMqoY8hPVSQ/MXIbEIob8PkdcBkU8UCSDm3ZcerVQiGxkjmKc40KJ
         PWJjZlZ5NRUSlKcYBZb82WwuTbmn/X/D0re9vdTLeZUis4jDOj2z/2RY2hMfWOtSdWaQ
         tSr3KA/BJCkM7Vgym/o4RsWIiOc7obyQih1mHJPTfdaGyu6HpDj03Iqpd5mGk3yiQjGW
         M+ZbRdL9+sUlXUd0IfsWlXj9Syy5COEkxEh1qqbfEfDThPSf5Vu84Iq2EppmOhar5twH
         vxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJriBaGIYedhzKdIKqI7n7iVMrgtiTILE4taRMPJYPVxxtVS3aTG/1Q5xCLWhn9QAUmQvNitBV@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9BkwnqBsOdRVf0M9qp2Z+J8wPtiBkSpNlsA7UPoBvdiotqSM
	BNvaUFQYkub3dSu4YuNe4En1YD5C692ptYhojTz6wTHCTbRi+g4Pxfeb
X-Gm-Gg: AY/fxX5f6NAIS0BgskWiiphuHKzYIsd1oCdwnz9lbIPF3xyx1ThpCafj0qMobVueKCA
	Hr4i5qa/gWAo7s5m5TvqErezqHw5vtLE8Sc4+nk8oUde+aftVBVpxvUYHPGn4z/l+U/vTHaHBHT
	3zWsnmZIvln3F+MRFejXSdbiw2WQHiriADQ4uIhaMDE2XFTBpu+Yi9VoJxXVyn3VM6KdJic35aU
	+jem949bqisjUI9b0mB9Ju6xuck+KRHZIlw1oIZImsq7gql0ENOeibQB5i0dTq2GwAVo5QDuazj
	8I9O8FwlnmH6UAw3iJz+cEQQdzxviak7PeI4tvAIl3CgUdGztX+wst5FUSxNj/2Rvdnk1yR09wX
	tPW1NGPEfp/CuIR7fkFnbxt/sw3Qhd/UD584aVQIAn9ZUy1QTtVmoiy4PFai3AwpRo+BtgDcmv0
	ymMvJ6A/gitm9P1wI=
X-Google-Smtp-Source: AGHT+IGDtgBQ4KQcHdb1LBCvEWJkZILPcU9I11r/0S4sbvgYuq/WsKBoqpiccDIsNUdDum5ypziV5Q==
X-Received: by 2002:a05:6a00:2993:b0:781:4f0b:9c58 with SMTP id d2e1a72fcca58-7f667935e19mr19497642b3a.15.1765990892447;
        Wed, 17 Dec 2025 09:01:32 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe12316e60sm12290b3a.30.2025.12.17.09.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:01:32 -0800 (PST)
Message-ID: <f9913843-07c1-4750-9545-a5af47f5fbd3@gmail.com>
Date: Thu, 18 Dec 2025 01:01:28 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] ext4/006: call e2fsck directly
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-3-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251212082210.23401-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Looks good

Reviewed-by: Anand Jain <asj@kernel.org>

Thanks

On 12/12/25 16:21, Christoph Hellwig wrote:
> _check_scratch_fs takes an optional device name, but no optional
> arguments.  Call e2fsck directly for this extN-specific test instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   tests/ext4/006 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/006 b/tests/ext4/006
> index 2ece22a4bd1e..ab78e79d272d 100755
> --- a/tests/ext4/006
> +++ b/tests/ext4/006
> @@ -44,7 +44,7 @@ repair_scratch() {
>   	res=$?
>   	if [ "${res}" -eq 0 ]; then
>   		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
> -		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
> +		e2fsck -n "${SCRATCH_DEV}" >> "${FSCK_LOG}" 2>&1
>   		res=$?
>   	fi
>   	echo "++ fsck returns ${res}" >> "${FSCK_LOG}"

