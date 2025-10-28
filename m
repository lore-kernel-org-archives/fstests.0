Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5728688C
	for <fstests@vger.kernel.org>; Tue, 28 Oct 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652210; cv=none; b=CKCp5JxKi3Xp5h4wSHRmbCQz4L9ZN7E7dUUIlsDCATxJa2mhwZqPmQSBhlIW3SUO/Qv29f+wattmpdi5mVA6329vvd71fSDnODJxe582z8+V9U6yYEFI1o3Kchf+LuHRLHQ3z2Ljtke5JJn728rqSHWkQtU0WmgaOeRgoEQj9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652210; c=relaxed/simple;
	bh=dU4zVFHKW2O4QpCbJtTeOJxYp+cQxgc03lfH59F0Ox8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raCA5UQh7P3FaVYMQYkz7BmdbmoDmTfVt//2lGTxb+cJGjRUvi9I2W1vY36W12RsloHTlMhLZgTqF0ccJZXa5ULJW1SLT+x4Zj0hVEfl6jahzUmXMwcJGDdvJ2d3l1vyBW10UgKKjgl4BrDdioGaxgmeBK3IdG4HbbY0wkp0am4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChnWjv/0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChnWjv/0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290deb0e643so54277345ad.2
        for <fstests@vger.kernel.org>; Tue, 28 Oct 2025 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761652208; x=1762257008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU4zVFHKW2O4QpCbJtTeOJxYp+cQxgc03lfH59F0Ox8=;
        b=ChnWjv/0JuqPzHXfJOz//zQvwNYUNA1aZjae518yz5Q4AYhQ8VNHbzWAtFussbWMXa
         RshpvQEwcAkjhtUOKUEv10kTr37jCyPuwZbujqe4MVBjgCcxiI1UNefXN+/ZvkW20gw+
         7I1b4M5ezSeR+SF7vWgaltbQ/+p7hTXUlzr9GrFDi4PZKODcY30rND5Ge236ARc+GRNy
         n2XEpxs8DA7Gbv3rp7At2kD/HtAAaxEuFdZKRT1Wm+s1uNqXRVStLDSbQvHDj8RSQBAc
         KmZG9I/Hp7bW2uqj6MLov7IKhn+7+slEhyfBQQYrHjrIR4gZTI+tkT78NoC5mtnGpvIW
         iePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652208; x=1762257008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU4zVFHKW2O4QpCbJtTeOJxYp+cQxgc03lfH59F0Ox8=;
        b=Jp1KumNNjxzsrQMKPePQzsO5M7j21pasnX+r0CbbRcuIsPZEGTwqRYz7ah1oCW8e+u
         5WhW/PkIKHo0NQj5f/fagZEMPtuePd1QYrwAyDiK77qSGGmQuuyA2/aVyX9a8RKkT7zG
         aVCLoUdqSotKTyhgqz9+q83lwb3ICzBNuxfCR1mPte9YU91yq4b1Om4khju5CW2Vbrr1
         +/Eqqyhq5YgqnpjvtY3ULC1c27Ur0bdCb/UGrX9pUe2WyZbhERbQoBC+0BTpxhsQARKQ
         obkVr+SXQRdioZDrOy+MegwpcxZK/o0MarTLTUyjWQnovALFgXcd9pf5ePZlPK8XZEsu
         eFQg==
X-Forwarded-Encrypted: i=1; AJvYcCXAi99Jqxti0XFgy8Ym7t6ScOuLLoyHK5mc4pM2LFjpFbIwgxI/Fzq5HylrIbeRQbW0NfGpvakm@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJXxqBSztaQVz96hxoF4lk9j6R39F7YeW1kZRDpFOWLIM1Omy
	eofWZVA2Oc9+phud/3SwhuTwy6jojZV8yjvWkWZhgUXIVSl+xn0cbIQY
X-Gm-Gg: ASbGncu7/UGsu2CJqHgoRcjZrg+QgRIAjXnNbvR347zObAFMXcASf7qrlIPBFXVLrCN
	lpxUTfl1TYVAUEIFq44sTsAMgwn68lScdLub+QaZATbJ/+uBZod0ePp8y4Bc3iDXBacjUImUqWJ
	/WxnAp/kfGl6D/ElJgR59pC9X8nubwf0395LNASoO32jmUD378Hji6QEXNWpX9ux/wt98QLozCR
	ZW67mlK46GKtIFRI7zflv+POQadZfcgDrDpI8r0nHsBMbRJDdc53LpDqc52c84JuEnQaLazyJcq
	h2DWd3lPbGqE5hodQoLxpN0XP7X00LmNs8y7NciV7UleRKNGZ63LydhAPtRPpTI7AN2bYxypFI4
	NISDwyvDgAo+12Om1ZmPBeGhGi9ya7k7OwoIf5r8VFPqCWjhtUs67Zq6Nv5BGCq5Ip+D2FzkOE1
	rmRfASmqXabtn282A=
X-Google-Smtp-Source: AGHT+IHP1cVhD8F4dyZ7P8z0EmhNkVZ3pwTL9LbVmVnwsMVkY7U34z4WsYnpeZSVPdy2RXMWC2141w==
X-Received: by 2002:a17:902:f545:b0:292:fe19:8896 with SMTP id d9443c01a7336-294cb674766mr40940405ad.52.1761652207657;
        Tue, 28 Oct 2025 04:50:07 -0700 (PDT)
Received: from [192.168.50.87] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf49easm116300265ad.9.2025.10.28.04.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:50:07 -0700 (PDT)
Message-ID: <ed6bcb1a-e0bb-4211-951f-500a8fd7787b@gmail.com>
Date: Tue, 28 Oct 2025 19:50:03 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] common/zoned: add _require_zloop
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 Hans Holmberg <Hans.Holmberg@wdc.com>, linux-xfs@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Carlos Maiolino <cmaiolino@redhat.com>
References: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
 <20251022092707.196710-2-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251022092707.196710-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Reviewed-by: Anand Jain <asj@kernel.org>


Thanks
