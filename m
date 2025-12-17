Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2343469ED
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991081; cv=none; b=KYuApCy5I0No81l61F//kyzbCPX6P69IuMvTXJu97RCMs4b81b7he5ti3k7OiYxeUP1HNoOpDmc9U1QMBL76AG83m3ybz5rwIwv9oD3LHFlswsBEpVz0tAVsPq7Sj2eTFB40bavJcQwWCteWgFIH/9mrQoAZY5H/Wkni4I9zHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991081; c=relaxed/simple;
	bh=hlf2F0WFEMV77iV9h71UB6Sx4lGPX/1ax28MtW+95x8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G+E2PEf+SUgROo21sXxBqdJgXUlzbUBkwLAc0AlCD0G7vSBer/NEyoyiyBBq86GxCGkAnGPXhwnm7ug4c/GcDmYsivFQ5FeJXZq5K5QN1szLVyIdwB2gA7kTTmrDPZudYWuZ9yP07qbS8sXBmYRMHnFdwldXyCnrbQ1B/f5IGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyMoRHnO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyMoRHnO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f102b013fso73674275ad.2
        for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765991079; x=1766595879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ho94FLLOSJHFFY5GW+ImodCHqbIMG5RYp+UDa9CSbnA=;
        b=fyMoRHnOy/EvoJtz2HWbJkdEQ/CAjSpUZPG/Pe5AsvwBMGRraMD1CvdqoCWJ1Wh1Vr
         jqsqjM1BwSz2l6IPRUUEcjoJcgbvQHYi5R+deAX3cly3TIJqgBGlBvrFJIK6VDgO5tTw
         8qBI/wdbJtOik1ce5iM/uQEanl/r0izwsvgqWAOo7mhQGm+tmFlu+zZMRAKGc2u47fG+
         V1ekrPpIGgmE4LqcGOBPgDaV+P+ZCDfJte4+hebZ3xhhwdzdQkmr6hZ9iBwqnutUpaxm
         0SOvu1oOmGhTVnwh24z2mp3wOL5npQ0TQJaU+tpV7dPnURmm0PhPS8WpK/8B6r/4EKtG
         kVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765991079; x=1766595879;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ho94FLLOSJHFFY5GW+ImodCHqbIMG5RYp+UDa9CSbnA=;
        b=FCp+WCGe3V3t/bh6o8SNFDwIQuAFPLAwJpd+5OnWAGFcGfcGTxrvaNhxbpXNHACGVq
         QTIu4VzyX+58VaouNkVI7m20W33VLZEenXiCJKindEcKdthkMgrv3Id0AOCgZADpa7/9
         DguShptzU/lejARVUMarTaLLt4cpL54efxpxjWocam5RUjNiKy55NVtIextlgJUTn40b
         +Iyo7ehP3FeFj2++HHNkrBrblu6IBCBKizM3To/33zrHgR8s0JLvWfrUTdWSS2pYG4cd
         hnhBN4tdhO6Cjz/MuXGiIhuGWfBACC5LA40dn29JRv2od/61D7nPDJ6lNQxkMdiidILj
         Ulhw==
X-Forwarded-Encrypted: i=1; AJvYcCX/vguVW7Bm7zx4NThIEJF0Te3FlIqQs6Z2otAHF6qTKuECV8v8YVL6is13YsHXsYOaU+6OvHhE@vger.kernel.org
X-Gm-Message-State: AOJu0YwtqGm7Eu/OnxE0D3r1IOBcU8XyiZ3P1uuDTZe5H7zAgYc9NKTR
	P8klt9SQA7cIocuqnq9MgFq9848L5uceLKB5qYxIp/fwFCjU8VGVEMY0MclcWI8j
X-Gm-Gg: AY/fxX4u9Dkkil1S+j48LcaM1XvK4UbXzWOuIdl0+DKF2fzRIg0mCW+CD3VdXgMfc1Z
	It7RoY8bLizYdK9CNiAkfmHBIegS1QV4IAvaJ+cEw1rR+A8M90vibt7Bgt07uln0EBA57NX4H8/
	MVOxf5eeX9c/M2ojM4uYlRJGfT2jPUMXaD5kJi6WXm1b8kWPBgWZ7RujaT7JAO0xGApEkYMrMsQ
	4O9ZvJAZc3rbAUFvUAjo6JphNw7xjs5ViS5YbC3uKfKPjvJD0jyjh5udTpvbsOHdJjB6Xl69JIG
	SRDqdvKE7pcdG4t9y1V6N4gk29okvXlntc6p+p3euPDV5jNsITsq9kc/oo1smNhrI2E9YQoH7wV
	48XFZChcmyFz2vMT/Di++9Qg3t4SnuVfhz+sPaJ6j7gZKvaP3VHHTSzOfJoFgX/kVbHh8SS0dc9
	SNtXP+P9FiGHigJLc=
X-Google-Smtp-Source: AGHT+IGglLUxbz7F1zaaKXL4o3u9tQkXv1b3wt/mp7TFc59oza6w2APwy5n2p12gp0/ZwJGMsEmEkQ==
X-Received: by 2002:a17:903:458d:b0:29f:135c:5f25 with SMTP id d9443c01a7336-29f23de670cmr175908485ad.4.1765991079047;
        Wed, 17 Dec 2025 09:04:39 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2ce09c616sm10475ad.88.2025.12.17.09.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:04:38 -0800 (PST)
Message-ID: <161818cf-2052-46fe-ac50-f68d4d62141c@gmail.com>
Date: Thu, 18 Dec 2025 01:04:36 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anand Jain <anajain.sg@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update entry for Anand Jain
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, asj@kernel.org, fstests@vger.kernel.org
References: <20251210055134.3470190-1-hch@lst.de>
 <CANZP331-x5hPUUAZW+W3cHGm3b_P4hUW1gYmVGKZB8fn53g87w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANZP331-x5hPUUAZW+W3cHGm3b_P4hUW1gYmVGKZB8fn53g87w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This email didn't go through due to the HTML format, so I'm resending it 
now in plain text.


Reviewed-by: Anand Jain <asj@kernel.org>

Best.


On 10/12/25 16:52, Anand Jain wrote:
> Christoph, thanks. This looks good. ( I’m viewing it on my mobile, while 
> traveling .)
> 
> Reviewed-by: Anand Jain <asj@kernel.org <mailto:asj@kernel.org>>
> 



> On Wed, 10 Dec 2025 at 12:51 PM, Christoph Hellwig <hch@lst.de 
> <mailto:hch@lst.de>> wrote:
> 
>     The oracle address bounces.  Replaced it with the kernel.org
>     <http://kernel.org> address
>     found in recent commit logs.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de <mailto:hch@lst.de>>
>     ---
>       MAINTAINERS | 2 +-
>       1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/MAINTAINERS b/MAINTAINERS
>     index a0f50f3d98b4..19e558296809 100644
>     --- a/MAINTAINERS
>     +++ b/MAINTAINERS
>     @@ -108,7 +108,7 @@ Maintainers List
>                or reviewer or co-maintainer can be in cc list.
> 
>       BTRFS
>     -M:     Anand Jain <anand.jain@oracle.com
>     <mailto:anand.jain@oracle.com>>
>     +M:     Anand Jain <asj@kernel.org <mailto:asj@kernel.org>>
>       R:     Filipe Manana <fdmanana@suse.com <mailto:fdmanana@suse.com>>
>       L: linux-btrfs@vger.kernel.org <mailto:linux-btrfs@vger.kernel.org>
>       S:     Supported
>     -- 
>     2.47.3
> 

