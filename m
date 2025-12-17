Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86992874E0
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990970; cv=none; b=NCvmihyhyRNyT/GQV/ksB30/LkP+uv7T+GvStfvgUXqe4BpftapdiiTu0fB11w1vk+OolsHIgL4t7SszWtUVA2MD1nOYpRHZQPDTD5Ov3qC8+VH5gylHR4Uxi4D/FFM+Ov76/sIbZ2ZXgqd2x8rvOGoEtFzWUkmyT6ZiN1ce2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990970; c=relaxed/simple;
	bh=ToRJHcpjvXVga4X877HC3kIL7IrMUEU1J2VVkV8cndc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqBVN3SXnPul7o5XMrjSzeM+K8HXXk5QmVV+GCXi3Zl/HmDI1yeIgOurCtGSFmh7eConYuew0b7Mfzcg8bfiTJ6QfVfwB+4QxNz/rhbn/Si67+LBUFP9ejSl8t5JWjHF7F15cRLAc7qdhhyFEPArESrH8Ci/QUvdfM93khRaFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrCbc00H; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrCbc00H"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34b75fba315so5532389a91.3
        for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990967; x=1766595767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BlAKzA21ErBWFpH53H6S+ldLrYlUKuDSpGtu3kSDeU=;
        b=lrCbc00HEbRr6b+RJNwKbSt0O2VWfxdq7QcAC+gbQU5Rc3TYV/D8+in0hJPHFZweJ9
         E+fyKhwtVK8INnPGiZhmGif8Iq4c5gna92K6HXby0Tu34fB/hkNI6UMnSlclGNj6zxNW
         z6ac6mP2Gf3Rx1yMHGokppfnzHML1TqkNBoNHTkfirXPx0VZZtWxhBjkYaF41T8l29Zr
         xFjESe5ciixJLKAq1nzPAz0Gl4dmRbzy9euDwYx/rVQ15BfaIb7RmOnWS5cQANXyKeOe
         7A25LFMPxAjn+4F96XRdW7v0yv6KjhFD3yxnjY1vd+9x8YTtwfXbRAZ7t5L0OrMX8TnS
         X0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990967; x=1766595767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BlAKzA21ErBWFpH53H6S+ldLrYlUKuDSpGtu3kSDeU=;
        b=u7hviiwbTaq3l0DiPcRI4L8Z4PNN/hRF7fGEiO9x7yb4YlgFKABmiB/FaQtEOzRDlZ
         V3pUOJbtnOiTgFMcGfo4Jtvt+IRfKA40AMeN4v5bWEo+Q056yeLY9Yc4+qc3xh5J7R7q
         DTHsuz95vm9i/HQ9DIq3dDm4pnKzUdMKRML1cteVFMllW0dCBvoGU/cDHc73YQ+b1zG+
         YsmbZpuSiShPEwEL5G5zV7jtQMChMNbkT0DjPt/Gyo7JnN9qTJd8mZEq9gUK0BsLFnkJ
         YinoBFe2yDq22YY3H/n43sJInlTZNAZ7KhUuIj7zMUa23cFJaeAn8rtf5IBcM+FfrYkG
         Db3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUiYwm7N6bILLPWitNBmv/bICMpWFS9gqXMdZIqKJk92P8jZ7OZHkRpgyQzWtEldPquboQYkDv@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHgDCa7UUbHIJGE/8O7/fPUjxKYpo9Q/A8xypu43YA4E+XF0T
	X6l8G9zb/GV+c9k3B8kpgSEpiDGnGrmFJDfhJk5xGQ2Pmhd/QLQzMySW
X-Gm-Gg: AY/fxX6ELfzKnHGpQtsEszdOuvekLZJWgQvxOk/ZzmakBNBt1MDDvqXXyH83KphYSIA
	3jkqtaTFt2FnnQGo5SR+RuJFvX0Vrwc3Tb3e2183Yj0k//ca3R+Z1gOicLTdyAgSlHmmOW80XDn
	0yk8wwIC7BsJbkRZoz4wlFa/UB/aJ9NzgT+FlEL9iPkK2sbbRnFzcZ8tJjucGzSleQZgSv9tUIO
	WZ4gaMh11wF3CG4atMOUnKB9hLan4S5E5fmq0zUGVzgAmj6IWWzJjlaHicB5t426EU6idiAA6Ag
	F2ehLmRJr3UNmwqmE4f3wLjYkAvoiYEdMsr32lZayx+sqCqZG3jPEKE1LyufIcWmPAcf3oTlqTC
	YV7tzCBqPgJldjyudVv9vWLA8uU/f2y/FOFqTgQao/nFcq+WwH0KL4/SGwkbtc0enfNcLQ4OEcv
	cRVjRRMVVnNQkG1veuEciiCRIq/A==
X-Google-Smtp-Source: AGHT+IEjJA54aEA6lI7AscWvPNd06zlq1bSw1wMcFH8bsgGXOTWLSkjWYzIWJqEuLnR0WZ1MVIJLCQ==
X-Received: by 2002:a17:90b:3912:b0:34a:4a8d:2e2e with SMTP id 98e67ed59e1d1-34abe47924fmr19838591a91.17.1765990964073;
        Wed, 17 Dec 2025 09:02:44 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd9aaaf2csm1933817a91.5.2025.12.17.09.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:02:43 -0800 (PST)
Message-ID: <7f13d1fb-92c0-4175-806a-0f7dbb2bfc63@gmail.com>
Date: Thu, 18 Dec 2025 01:02:39 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] ext4/032: use _check_dev_fs
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-5-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251212082210.23401-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Looks good
Reviewed-by: Anand Jain <asj@kernel.org>

Thanks

On 12/12/25 16:21, Christoph Hellwig wrote:
> _check_dev_fs is the new designated helper to check file systems on
> arbitrary devices, use that instead of _check_generic_filesystem, which
> is just an implementation detail.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>   tests/ext4/032 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 690fcf066c11..043ae4f53505 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -66,7 +66,7 @@ ext4_online_resize()
>   	$UMOUNT_PROG ${IMG_MNT}
>   
>   	echo "+++ check fs" | tee -a $seqres.full
> -	_check_generic_filesystem $LOOP_DEVICE >> $seqres.full 2>&1 || \
> +	_check_dev_fs $LOOP_DEVICE >> $seqres.full 2>&1 || \
>   		_fail "fsck should not fail"
>   	_destroy_loop_device $LOOP_DEVICE && LOOP_DEVICE=
>   }

