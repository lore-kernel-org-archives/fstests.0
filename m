Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1430F541
	for <fstests@vger.kernel.org>; Tue, 28 Oct 2025 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652383; cv=none; b=bqyZtX0yrX3Z0ALHz5ePr8MKdBjFj3dG+Flfazaj+wIVVzVATe5gb6bY5DMkeNwtuT6QoSSOWmmbpfbfsn+/NGmp01pmN3c6osEmyOr3bO0Sqs/C800Esbma54sW9VUTDmCaT7RaKZgB98y7JRx7+YfxXX6jtecLRwzBz1HLWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652383; c=relaxed/simple;
	bh=Vi0FhiX/ggITd3I3NaqAnYfWEtdEdBan5sFdli9E1x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9awXT/nVTn5Yq8gCivOXvVfIEhBAdiEd9V4igwiZuCSqwN8vWssS0xbefwUEvtVzEjzl9tLV4NHoIqHkGA1U7AiOmUx4LroCaYOaPNghEfDDUZ4Mxi7ZQxn86DrSccxVGf+p2/eFMbEaKWd4RC/mlBKZ8irKpgCazsjyveTzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heqeLLJ0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heqeLLJ0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4872415a12.3
        for <fstests@vger.kernel.org>; Tue, 28 Oct 2025 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761652380; x=1762257180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9q6iVQdHrPdlSbkfXY8WLj2PD38JvG6sOUR5lttSodQ=;
        b=heqeLLJ068Girb2vt3WbZP96ddf6IJffG+EkLX57+qbPV2ZVZkL9gtEB6iX1t1zrCn
         lCF+KDCNwWYJ/zDEn4s3y3Ft1zJvFBytnhmWYYCK2QBUFUKPoKXqKge4sZnvKYO0ojmr
         4fLKhSjqXY1ih02Z5j/8KM61ixb8Rqa+lbiz5qPrW5cVBzU4HePdEpI7aeuCGoBhcrPt
         ysWaHc6ZQm6KMet2fhGYK+9tNVYKpphdYvz/oV+QrVVDVUqqnmx8UgVdsckTNQpaLP0z
         ee88+2bB1x0g/4A06RNxzsKOlcU7S1PFTh7+0qkmSVL2P1XcRrH6Miyhwg3f5m/QmR0Y
         xBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652380; x=1762257180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9q6iVQdHrPdlSbkfXY8WLj2PD38JvG6sOUR5lttSodQ=;
        b=pVzBG8QFfwyJ84DNoTGl5v4TulMCIvfi1R+fw6vE+K/nALbRqkllFcLwI98rJ4K7bg
         65Nig3iQRQtb/OMVWMA0BEbxknsiBqV1ZwW+lu6aHumSsP+f2qFm2vcMU5qeKWO82Rtq
         jCJIE622Mn3ril/Dk0L/m+Zq5juTeKve4Bkk/1sWWOuHRARp9FmC87l/BF5//+SpJkoK
         D0YmjXyEdq1GAOlRDA0bVBQhHCyM+ViAH28dlqRtIj6CF3cMO37mh5yRUZu8+lPuCECF
         DzRqDfaopn4jOnkpP5/so4OqsFyQ+GpJDDV1WlLXb2mj0sNk4c2+Fj3NgbaG42WdwCwK
         VjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8SKgrFA6HNEtzLicGDs+ngGYY0NG7f60bKACjDxqV8EjJawxQrGoelNz2xY8+gKFzO7LkJyy@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJD0QwDTtdzqRsUVG2VaFT0qsGwNhMFj2xag7ZDqqMwhKNwO6
	ajB5WGFAC7uk5g9MuACwURD38Qip/csn2B20lNcY2q7P7gZbJpayuyxh
X-Gm-Gg: ASbGncvBXT2yrrZkJCUaVPPJ38ENE9J6UqKn6C4DPsjHjh7w3rPSKItsbzOgsR7coYx
	Eepn8+ur78bFgNirTr71pHFySq8NUBFro4NsK8RujV0G1MMcB2gyyAj0i76cg+ciV7chTCTkpzA
	qaRTksRlzmA94nAResb4Qt/JaCmk9TuvRNwzhvWLGXd/A9wuJ1XTEmqTwYmHwsOuGMihOSrYXOg
	eoN/Rwiooo3SmmpeLyQ9LU1ck9Rq8SKx9D/fi81ZEjOfiBQlfHq0ZkSCjrOKc45VCK3oRCvIO/m
	2E/iw1cfr4SxckwJVEjxAR3F/Q3qgdLHT95Cb8R8BhGyts2hjkZH0fh8WDSkxmAOfLIMlq1yci0
	4MRe5xrQ8gcicAPuRnhgwun4Xkj9Odp2Bqx0WgQcQATZz1ZPx96pPsiZZWlpgG1/RfdkLasilcb
	94khmy2HqxfgcTMxA=
X-Google-Smtp-Source: AGHT+IG4v4AwOlK6aSbRgipc1yI6p/3NKXN0fH+1iuKSdkqn9RVuz1RC/ZsuBzjtQhG2qSX1tRVw/A==
X-Received: by 2002:a17:902:fc84:b0:267:ed5e:c902 with SMTP id d9443c01a7336-294cb392202mr52068325ad.20.1761652380349;
        Tue, 28 Oct 2025 04:53:00 -0700 (PDT)
Received: from [192.168.50.87] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm113605605ad.37.2025.10.28.04.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:53:00 -0700 (PDT)
Message-ID: <a76731af-72c3-42a2-ae14-d26c911d5c9a@gmail.com>
Date: Tue, 28 Oct 2025 19:52:56 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 Hans Holmberg <Hans.Holmberg@wdc.com>, linux-xfs@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
References: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
 <20251022092707.196710-3-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251022092707.196710-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



v6->v7 is missing. I guess ...

> +
> +_find_next_zloop()
> +{
> +    local id=0
> +

added local in v7.

Reviewed-by: Anand Jain <asj@kernel.org>



Thanks, Anand

