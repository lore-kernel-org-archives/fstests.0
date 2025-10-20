Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48724DCEB
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960020; cv=none; b=U4lU7W1jN+xndbkDdbAnLhQgsEm0HWHMTO1d855VxRVQWpsg/p7DtEESlVnEjQFN3Rv/PyPvwQ8MfrY/85HeDGy4zeOd5bOPQwvAjD9iuiqIoxVDOBNDiALiNjygnTWVVzDnU6lDQK424H/pmgzIDCSs8+I6SE2Q9isnC2/bBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960020; c=relaxed/simple;
	bh=6EiGStiBznav1eSgay7iCK/qy5mr0rH2mzyH9UWsfy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcVWdYihYjJeylAIClPvuYDU0X90NjpgY6cKWuJt1Qb74IdUVXQfCFTlUcGLhMqKl9mo05qqpTza2wSyOBt8kCzkj6oNhT7thV19KGEFKg8vuDzNdhD4IG2iACNR/KOeL6L43UC6cklPpTy9kAZhSqgo6fnuS4H07VlyksXJtbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZadAJu84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZadAJu84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760960018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5P+mZVBt10RC7+9Dyixo8N3Ti/idpjm/0QEnemownhg=;
	b=ZadAJu84RwdHjN80WyZIqZ0xlyuXZBqaPnotqKR3NpFyB0OcOXNUns/gLd7EhA/f/qQ2VR
	E6p1GcCZxj+vC5uz0syFpXa+G6P3Cjo81pxO9HKgZdqi2MGU9UPemQl5/bX/jtowWmmYBh
	pLxKYJnkifWi3n/Owfn3hguYSFrdHZ8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-QooFe7kbOzCD3maVX-QUvQ-1; Mon, 20 Oct 2025 07:33:36 -0400
X-MC-Unique: QooFe7kbOzCD3maVX-QUvQ-1
X-Mimecast-MFC-AGG-ID: QooFe7kbOzCD3maVX-QUvQ_1760960016
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-63c0d3d7178so5233788a12.3
        for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 04:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960015; x=1761564815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5P+mZVBt10RC7+9Dyixo8N3Ti/idpjm/0QEnemownhg=;
        b=OfbZ+Muf8wpDdL/IbRwVsGGWNtGNNC/HuLilNYZBlv7V/2ayWilFs93oQowbOSnlLH
         qDba+akue2w7E0q4lT4McP+IdnOI3WlAeCIeccHc986rUBhQWQZ/BTOX3wI/XkcSqt+8
         4bINnBPkCLLBk4d1dIwjAoTLGgBa1hL2YvV8U+uggwoEHn67R3pf7WmZ7CIDXLhjy1Vz
         zyDfq6BkXDfy6BQYL+jrQqR4qzyc/Uqwx1vprbb+YUPt6YZGDROQMx+yavl8CQZeds5P
         U0ZnqfgP4r9JUXnkDJN4nxiSOSruxE876lBLJaNm7b00PjIbmZZpLQgi4st+F8cIGkXC
         tdug==
X-Forwarded-Encrypted: i=1; AJvYcCV/g9M4gin+Nc9uowGqBvJcq7ozkgcjBCG/LgyPxMCvSe/81VwQ5+pbZut/r21OFjxvaIrqt1JG@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9r9AErJxCBu3/ZeTMGWsvF26PHk2S832zpKTRWyFOAtvcsVS
	TeNezfltXFEou5bCuqVovNM7RouWbHb+yXYSnA690Sz9TKtHjuE2PpCJvOfA/hCpYXQVEGo58b2
	trqX0dsgnmkExeUU9k3fqpEatfFLLIjRnY8Cw6lB5Q5yj/qEwcDv+jW9fSYXpZpqls1Y=
X-Gm-Gg: ASbGnctYraYfM4iDi8hB1v0hhmE1Vi0hG5EYt8Db2YBRf2g2lgtOTd0p7Lhd9Rzz/Vf
	07Psky4YBJy2ElN5n2AF9Q9MOffZeC8o1z+JFbw59NuPh6c48jksv2NgD0mv09TBQh8YTvvXyA+
	tDB5rj86c55i/bppDHOg2baCEFc4F/9tTwfvfxpgFEFCkjFJRBSh15rTcd7oFdzt4wgy0qB+RfS
	mm1m4Kt8KO/5QfN1An3cXrmoymGySEeG9qhVPVvAoyQOqsPAM6pnDs1BG91fa2uKaPfbf7BEqgP
	GhAYodSsro53pRyHASaTewP6EgmJpdndT3DDT05A4TzehauntBbOIjckFSKwWFCHBdldkgB448l
	71/CZ5Om63VjB0xfPOufsrUMOaOmO2hfVodhq
X-Received: by 2002:a05:6402:1443:b0:61c:35c0:87c6 with SMTP id 4fb4d7f45d1cf-63c1f647f4emr12287023a12.12.1760960014998;
        Mon, 20 Oct 2025 04:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfpMYghkzzs/Ww2s0+gFlJskIrmobsHH+lSHmxFfy4Z1IyJwk98fukBGwGrnhsp3o9CDhWpQ==
X-Received: by 2002:a05:6402:1443:b0:61c:35c0:87c6 with SMTP id 4fb4d7f45d1cf-63c1f647f4emr12287002a12.12.1760960014517;
        Mon, 20 Oct 2025 04:33:34 -0700 (PDT)
Received: from [192.168.100.149] (gw20-pha-stl-mmo-2.avonet.cz. [131.117.213.219])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945ef49sm6389403a12.29.2025.10.20.04.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:33:34 -0700 (PDT)
Message-ID: <426917c5-baf7-4a0c-a62c-f674d6ace20b@redhat.com>
Date: Mon, 20 Oct 2025 13:33:33 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/atomicwrites: fix _require_scratch_write_atomic
 when awu_max_fs is empty
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: djwong@kernel.org
References: <20250906131722.1333025-1-zlang@kernel.org>
Content-Language: en-US
From: Pavel Reichl <preichl@redhat.com>
In-Reply-To: <20250906131722.1333025-1-zlang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2025 15:17, Zorro Lang wrote:
> If a kernel doesn't support atomic write, _get_atomic_write_unit_min
> and _get_atomic_write_unit_max will get nothing.
>
>    local awu_min_bdev=$(_get_atomic_write_unit_min $SCRATCH_DEV)
>    local awu_max_bdev=$(_get_atomic_write_unit_max $SCRATCH_DEV)
>
> If $awu_min_bdev and $awu_max_bdev are empty, then the logic likes
> "[ $awu_min_bdev -eq 0 ] && [ $awu_max_bdev -eq 0 ]" is meaningless,
> and it causes g/767 hang on system which doesn't support atomic
> write.
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>   common/atomicwrites | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/common/atomicwrites b/common/atomicwrites
> index 33526399d..bbcc4e7c5 100644
> --- a/common/atomicwrites
> +++ b/common/atomicwrites
> @@ -47,8 +47,9 @@ _require_scratch_write_atomic_multi_fsblock()
>   
>   	_scratch_unmount
>   
> -	test $awu_max_fs -ge $((bsize * 2)) || \
> +	if [ -z "$awu_max_fs" -o $awu_max_fs -lt $((bsize * 2)) ];then
>   		_notrun "multi-block atomic writes not supported by this filesystem"
> +	fi
>   }
>   
>   _require_scratch_write_atomic()
> @@ -58,7 +59,8 @@ _require_scratch_write_atomic()
>   	local awu_min_bdev=$(_get_atomic_write_unit_min $SCRATCH_DEV)
>   	local awu_max_bdev=$(_get_atomic_write_unit_max $SCRATCH_DEV)
>   
> -	if [ $awu_min_bdev -eq 0 ] && [ $awu_max_bdev -eq 0 ]; then
> +	if [ -z "$awu_min_bdev" -o -z "$awu_max_bdev" ] || \
> +		[ $awu_min_bdev -eq 0 -a $awu_max_bdev -eq 0 ];then
>   		_notrun "write atomic not supported by this block device"
>   	fi
>   
> @@ -75,7 +77,8 @@ _require_scratch_write_atomic()
>   
>   	_scratch_unmount
>   
> -	if [ $awu_min_fs -eq 0 ] && [ $awu_max_fs -eq 0 ]; then
> +	if [ -z "$awu_min_fs" -o -z "$awu_max_fs" ] || \
> +		[ $awu_min_fs -eq 0 -a $awu_max_fs -eq 0 ];then
>   		_notrun "write atomic not supported by this filesystem"
>   	fi
>   }

LGTM

Reviewed-by: Pavel Reichl <preichl@redhat.com>


