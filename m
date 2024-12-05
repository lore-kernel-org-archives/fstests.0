Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA701714CF
	for <fstests@vger.kernel.org>; Thu,  5 Dec 2024 04:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733373352; cv=none; b=WvjJrHJg6Q4zry3TYXKEw92L76alxZb8DNYFRGoy82/0Y4lP+0XnP1wknDcg0nLzEDsaFj6ri3b4QZh8m1RLI0CT+BGMob5hBMi9w2d/7VHFXtbZhzosQ2CD7fmlHmgPbFZR62WOHRIvkHrdL440/6dZMOSrEaNBkzLY/5Gqp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733373352; c=relaxed/simple;
	bh=uiNNXseuROWmgCpz6MHoHMtZaYwfpO53Yy2y0pgRuUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVdERki3HC6WlO0dCQ30F8shkev+310QSI3Srirh9k6KZu04IYlcUB5ImnThcCC9pkw07p1nm0GYABf5RqNrnkfq4uBsRCEcIlcORN4oj+Chd8JiZNxWAj6TwXOrROLgdcsMJtR0XjSJXzSy0fOrNetkbxewLEAp1n8A2/xgTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPIdnbKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPIdnbKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733373349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0toYV7O5m7SIQhioF5KP2treLFyuAZomjZkcJd8tQOM=;
	b=UPIdnbKCE5Nlu33Vho9D4asc7RnccKoo4mf//GGZGJ5INaCkvzBDYo3wAwxHgP4ZcPJpJr
	y3geszLFyTzgGHmiCU1VbsDp6pDllUMzlc3t76nTPDuFP6EdTr5QtQdyFLREhLB8ljmlG6
	qksq1G+Zwn+JQ5wuWcE4EJGRw/MTv8s=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-MCmoOStOPfSFvfK_faiUGQ-1; Wed, 04 Dec 2024 23:35:47 -0500
X-MC-Unique: MCmoOStOPfSFvfK_faiUGQ-1
X-Mimecast-MFC-AGG-ID: MCmoOStOPfSFvfK_faiUGQ
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7cff77f99so8886725ab.3
        for <fstests@vger.kernel.org>; Wed, 04 Dec 2024 20:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733373347; x=1733978147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0toYV7O5m7SIQhioF5KP2treLFyuAZomjZkcJd8tQOM=;
        b=CPDDh31R4jZHUGjYoA8LJg69FQkmkhSwh0kcDiakShjnaMfdacDuVFxmKIbjqMRjU/
         GIPRruM/E2Hs4Sz81rcz+w3dhHPw4KVuF3FFPDikbwdfP5O3ppY4yRGCndHXQl7MUya7
         wgOoav6tzMw22dShp+bSWOMWblctLcQw76jz4Hz/XfR1hPg1xyCKuYvlHdeAu4qV26bt
         1pyNAiE80X2MQyPq6IkFxxlHfUgnv3nZKgj6vfniBMDP44+8Azth2bCoEiFoUm/ESwjO
         19mATtdyxzdaEdSvxq/XL7nvKBCaICyT5x1lI4U8+G9QMQdfnurW5ctbdwlj+7U5KxNR
         GlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/iqVeKvpW6i3Qs1DlHlxtdLZ4Wc6J2FVWNI5hqfxo/RCe4HSkdScmT5uuxJSFpBtftZ4/BkNu@vger.kernel.org
X-Gm-Message-State: AOJu0YycNs/ThbujAihb3NtxUoS8ShYQI9IDfgwEY3tw3AWO4G7IfgSw
	NNNeTdVza566XMdJRqkf0QbeYRlgHV5sfSH3W9uaSRZmPi1KBanfFD1ort2fgAT40ajp1Sk4+Dm
	p2TUVzDAAoc4Vfj777qSJq8F+7jOrFJATJme05QAoaQRzJZ3LYY7/kaQ=
X-Gm-Gg: ASbGnct6oGj99Z9oIb853pvBEY5sfNG+5cMEqXEnpCMrWgyqRBLc8Owo2xkfyLgBefC
	P3lS00HwURtDXOmW2MmwcZuu5JV2/vZYYBRVV/fXLpBzjnMI6Wu0mQYHHh+/hZ7MsW5CZ1IPOPW
	ZmaAk9XWsKY5CU3E1Cx5CbVF5t6NMq7fkyHRRn8Uu9tsbO+FzxcUEQcWujakaU+SiPJj+E+7dZa
	t+w2Unf5VTtAyjawSd9fgGevQt4NkOT7alanMtHhUdYJpfJJq/8Ywtwk2foDpoQfny8M0DXlCAk
	lMpPCoTbAt4w
X-Received: by 2002:a05:6e02:350b:b0:3a7:fe8c:b012 with SMTP id e9e14a558f8ab-3a7fe8cb0damr84155225ab.18.1733373347033;
        Wed, 04 Dec 2024 20:35:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC8qtYhZohMTLDB//11ZaFrpRsOUaLt9pecqfj3xsswKrVgp4ixwyQVtzcB3lFYfmEB8DAVQ==
X-Received: by 2002:a05:6e02:350b:b0:3a7:fe8c:b012 with SMTP id e9e14a558f8ab-3a7fe8cb0damr84155035ab.18.1733373346753;
        Wed, 04 Dec 2024 20:35:46 -0800 (PST)
Received: from [10.0.0.214] (97-116-181-73.mpls.qwest.net. [97.116.181.73])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a808da2623sm2186565ab.22.2024.12.04.20.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 20:35:46 -0800 (PST)
Message-ID: <0272e083-8915-407a-9d7f-0c1a253c32d7@redhat.com>
Date: Wed, 4 Dec 2024 22:35:45 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/config: use modprobe -w when supported
To: Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
 fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, gost.dev@samsung.com
References: <20241205002624.3420504-1-mcgrof@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20241205002624.3420504-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/24 6:26 PM, Luis Chamberlain wrote:
> Eric, I saw you mentioning on IRC you didn't understand *why*
> the patient module remover was added. Even though I thought the
> commit log explained it, let me summarize again: fix tons of
> flaky tests which assume module removal is being done correctly.
> It is not and fixing this is a module specific issue like with
> scsi_debug as documented in the commit log bugzilla references.
> So any sane test suite thing relying on module removal should use
> something like modprobe -w <timeout-in-ms>.

Well, I was having a sad because the upshot of all of that was
that when xfs was not removable at all because it was the root
filesystem, the end result was something like this:

    --- tests/xfs/435.out	2024-11-21 05:13:04.000000000 -0500
    +++ /var/lib/xfstests/results//xfs/435.out.bad	2024-11-21 05:14:47.949206141 -0500
    @@ -3,3 +3,4 @@
     Create a many-block file
     Remount to check recovery
     See if we leak
    +custom patient module removal for xfs timed out waiting for refcnt to become 0 using timeout of 50

which is kind of nonsense, but that probably has more to do with
the test not realizing /before it starts/ that the module cannot
be removed and it should not even try.

Darrick fixed that with:

[PATCH 2/2] xfs/43[4-6]: implement impatient module reloading

but it's starting to feel like a bit of a complex house of cards
by now. We might need a more robust framework for determining whether
a module is removable /at all/ before we decide to wait patiently
for a thing that cannot ever happen?

-Eric

