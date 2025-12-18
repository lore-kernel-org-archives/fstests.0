Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB0265CAD
	for <fstests@vger.kernel.org>; Thu, 18 Dec 2025 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038287; cv=none; b=FraAOT/VPbK8Q3yog0aqK+LUyojZ1xvO+fLkJ9NqJnS0U9PDkAi8uaZA2NIokEo2lwm4MrfzeLvPQhnNAvHSrNNniu+Tmm9qz52UxfO2L6GQH9HY5pNNenqzvtUAwFzIdYKRh2VRAS1h5f4n8AWyeH9NysahIVG1XYPxhdtJ7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038287; c=relaxed/simple;
	bh=SzczhBn6uFW3EPMbbWQp/8hD8axIWh/L4otH81nYvE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PymCyr5/+uDx6lhvkbr9Tn9LPeXkRO5IDCLL6jXYwXqFnl241TrxR8mg6GAKqAtK0B1uFgTu/j3xesrmO5EqF8CDvL2stBscDHXAJtwvTZ0mn2GtmKPfkvXhy4J9MrB826CQ9FtYJ6d4nU17YNZOGVc7/cGkb6P+Iy6nZb6ioB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIGab7X3; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIGab7X3"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29f1bc40b35so5485035ad.2
        for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 22:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766038285; x=1766643085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywLXq8I80yLUYlgBLukO/C6ljslQEkacdBOeoKlGp+8=;
        b=iIGab7X3D21CW4OuVMc7dB7W5Tl9qKB2Akpw6rReI+/eeqT2l/5/upPXY+O5hLhfql
         xGzpfuwXn00STMFX53N5dxcx2ec10pRooi1XvbcBp9vJjMB0xoDdRN7opn29p06uNXOY
         UNsSW6+BBSzyskhcejHRkHtH8zqGY6OGs5UnupGxi5qynpyZmvLMWVCxOpVxue7sv3Yc
         2REd9AdGIHWJclvHerKaduDwS4ckMAbL4CIA0JgFwi8CEd3bBzWSUjjDnUHUvX1my2EE
         TFgjv0DWrXbJXVTIugLgvUXt7mdiVFnuv6+IxZGFFhj9LEYlQc2sDw/YBeXJOH5KywVF
         HjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766038285; x=1766643085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywLXq8I80yLUYlgBLukO/C6ljslQEkacdBOeoKlGp+8=;
        b=EkvsAsp8+v3GOIK+/HSMxrApWuD8ICSx5qkSXP3GNDM3YmwLYGOFdqsezVMQUk8PVj
         8RsX+M1SZtjoE/fUMZQGijEZ1erSL4oWfWolyFJHjLhtdfzjt+1/UrRyItYKAORIMxwv
         j2XwkT2zDaQkikyeaK2cgTX0KttyJW/lgdPUgxLGvnvepwei7a2D3DQni5SGIqLHD9T+
         qiZtZNp0wAVtvgglIWAVmjcms1R/pLQOOt2S2sd24mpTxAWLCvbdoaPrlsBFghoMNo9V
         yoIXyUZNOh2JBUDy1m8vqdZTMjwCxiqcWLCQTMO4H+POsJMRp9DZMIH/ZSWMNJa4+RwN
         VzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnJQ0dVonpcHHSuvg8nL7kUTCuGUhgfmX1MHMD2TgWX+DfB2zxPS9hPNGhrMS6KarAHYXpQV9e@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFLK4PNEfOz4RQMol0Zg0bIIe7nJzjKNHwtyp6wygdTmDI/oe
	OafLjTTWXidcrtJInCjeSznyvegfQj96ar9s8Y7XEsd5qreu2h2mrZAD04jYfBt7I4Q=
X-Gm-Gg: AY/fxX7HCM+ff31UU/hTVMcujV4VlxZF3/OsRUgr6fx4EBZ8w1DirOwtiKQ4Wo2aFf2
	1KRCEXpFFA0HPcFZ2BaKkMFhTtcSV8RNc6Iak230RXEfVIXSjCoz2KC7csorIMz+61U43EUyVk4
	kOHEZ4dymB5UrIlAL1DCf9TROsfy1Yd/i2ufgNGppwszqXSTdduN/ts+iYX9QYiCKRqTbUCXp5T
	Qf4Jh0XoWchCRju+1O5DZqxa+ohyFP2wqE3iOA+o6RE2QIpK8vNLGzjMcBt1II5rZMKOj52ZApc
	RGuZu6gJ2S/xY9noE1vohac5JQilD9oq2B9TJdV0O03lNMDf+xjLem+paO0cz5mdqtfW3Y0bPJi
	OLQ0dkwsdfBSMrWW8FrhfGWW4zHPcZ3Y4Hww7lgNSnqJDqeAfyQfSf18PYNMWgGR07alaPj8Je4
	LFMHuhrwGF49bnxgoa7I9X+CfMHA==
X-Google-Smtp-Source: AGHT+IGhCJ60ODaxL/aqk5hzFqG+KTYHhFsrD1l9kBf+i8jtNKgA+MduOlkw72rocl0RFLCOyTLnIg==
X-Received: by 2002:a17:903:2cd:b0:29e:e925:1abb with SMTP id d9443c01a7336-29f23b6832dmr191377825ad.27.1766038285548;
        Wed, 17 Dec 2025 22:11:25 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1612ab9sm12338075ad.53.2025.12.17.22.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 22:11:25 -0800 (PST)
Message-ID: <3a3ce42a-6eee-464b-a8f4-ff7590ff9dea@gmail.com>
Date: Thu, 18 Dec 2025 14:11:22 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: fix flaky device name in _cleanup_flakey
To: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org
References: <6025643af0c6a7d7d377aef22a53f23f24f06db6.1765988375.git.asj@kernel.org>
 <aUORO1y4rkXHAH-f@infradead.org>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <aUORO1y4rkXHAH-f@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/12/25 13:29, Christoph Hellwig wrote:
> On Thu, Dec 18, 2025 at 01:00:22AM +0800, Anand Jain wrote:
>> There is no device named flakey-test, which _cleanup_flakey() currently
>> uses. The actual device name is stored in $FLAKEY_NAME and is set to
>> flakey-test.$seq. Use $FLAKEY_NAME instead.
> 
> This looks good, but I vaguely remember fixing this up on the go, and
> seeing random hangs. While that could have been me fat-fingering
> something,  please run all the tests using this first to make sure it
> works just to be safe.

Yeah, I've already run the tests that fall under the
_require_dm_target flakey, and they have no regression
with this. I reran them again just now to be safe.

Happy to run any specific set/test case if you'd
like me to try.
