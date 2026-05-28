Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773136B048
	for <fstests@vger.kernel.org>; Thu, 28 May 2026 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011092; cv=none; b=qk9ihznxfE1roqctAsqeCTfkPkekFUas5d6BNfM9bRQtJY+a9PwHgj/g63ihXKPw5Z5t5+mok7JvEWaqYXfvvoQ1OFN4m8WoSr4wc0qGSasJGp8gTYcodj5kMMlt1Udi6h6COVXJ73GO18LUeRGmMb1a8OSYsadQkEI+m7XSfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011092; c=relaxed/simple;
	bh=lqxv8nVHPEdwe2QwwpE33htDLQMxjsFPk2OHMI4P2Sg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hfBddnFxrfWThwE+24UOxBQ40vfs6xp2jigEk5KIJiUqr5rclAWb3JrxRD4xZB5g78tC68Ui8IE3sjdbEOrQV6BEwaGoCKZtUHSeGIcpBh1j3SJSoxZJ+yKDpSmdENBcyNdHWjSBIc5bh0wnGDvAswzYEkxkuZcPTIZyuwyh6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO1zR5SL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO1zR5SL"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-841882f8f4bso2331770b3a.0
        for <fstests@vger.kernel.org>; Thu, 28 May 2026 16:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780011090; x=1780615890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lqxv8nVHPEdwe2QwwpE33htDLQMxjsFPk2OHMI4P2Sg=;
        b=kO1zR5SLHrqM7dLUL4kBg3HB4HhvocZhBEAk6jjGwvaxchGb3k3tS8QHnlS78MaJNk
         SaOYLkQ3grAzMLMmvzi9E6ybzsGfc/WcA8qEI4UyfvNiHgCB+oOAMFiJrGSYopCEjgJY
         d6wRPq8wpfnFR/aXjgnH79oZp3MWRiQSMZb0B2mnOmsEw/OsNRZgoK05Zc5REA+0Avu1
         oX4N5SM35S9JvwbMd4TzKm4cp1uuPLq2FY2BPYzXKdM5RYMLoHzNHYOpB3sunyeLESk5
         r+iAki/HOMSGiH08yh+1U87fzDYbgui23Gtqv+A/PmNdom3/r/8rKtGUiqF/+fKek0nn
         /r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780011090; x=1780615890;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqxv8nVHPEdwe2QwwpE33htDLQMxjsFPk2OHMI4P2Sg=;
        b=rWjNQAB/zQQ7QYziW/cr5JsyFfS00KIY539KRZQyf38TM/wZtmk4U/oGBfnS/0Jj/D
         7JayejM9dv+bPyNdHNP/lDl5bg7eOuWhUcK6ZDP7+knAKqTCW6mvKu1BAT3hohgrwzrA
         ZrLhX7Ac6XD1pA/bDglZcb6eMudemjjtjJ/NN3foQn6Dkbb44/SrKjG/KnqOxO+zi6Mg
         gHnpY8WGtyinDOc/5b4o1m2qA0aK37oS8nCty+kk5vlfSToElSP+4TnVfWlmnyrzOoba
         UDn4IAy5Nj7njPmKu1a01kfFo7JTS+VLC/F9tMH9jV9TK5dB477ULxXM2CmeialXag+U
         2ILw==
X-Forwarded-Encrypted: i=1; AFNElJ+RgBOJ3Tp2zlG2pLxom+9nMCSVXTeqX9o4IAi0ZzKNwgQcJF2TtY1KXTCuOVGwIGbi1jl1qgWY@vger.kernel.org
X-Gm-Message-State: AOJu0YyAx2ItJ12pynIGek4R6akVaclt+lcYSxG3S82md2B2yUF8LUxI
	T5bl4HI1AJQv89qIeprxiwR+qnFclxo+6eZL+Z+PgQl92xDbQGOhJJDQ11WXVA==
X-Gm-Gg: Acq92OEXK1A9ShwDtfOemZ0bLZDa49fnRKcXSP6gnskV/5deYpvnbqtBLO4tI3bGHbl
	raGOAYlsliEOLuY6Lr+NaPS3B9YMwmmRIz+Fpzl1xPc32yJQFhQ9tWtibiRRgIaH1wIg+Elfoul
	pr26Ga+d3tuR64CKPLGPZL3/bzhqy902Q9qGGbNU5sIKaqtmKymo+Uz7kakOBXh0hFbB/1WKIPI
	uNkZSj24M3yiKXblGB0auTd/DWXOvFjIDEVSHXNchhlbdmFcD/CvMkqucT/1ySs8TVt1MyW+Zwu
	Tf+AAwe9yrhQI1pQl5q0IMJLgfbDSiFyFZDz9jCLJTpB0g9Z4IISQqPLrNOPsvCYaumNExsYAJm
	YZFVuQxh2GiOdx+Um8wE+y0NX008d+MnwUxqXqdje2A77tDzrppd/zhSzkssAUcUfv89N7UGHLs
	3oHBA2d+wKkfNzDPl4BQgmGhhy8TDEhjVKqBw0Y0Jc
X-Received: by 2002:a05:6a00:3d07:b0:835:351c:f236 with SMTP id d2e1a72fcca58-84212ba1e7cmr295411b3a.29.1780011090452;
        Thu, 28 May 2026 16:31:30 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84213121564sm76760b3a.24.2026.05.28.16.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 16:31:30 -0700 (PDT)
From: Anand Jain <anajain.sg@gmail.com>
X-Google-Original-From: Anand Jain <asj@kernel.org>
Message-ID: <a690deac-20ee-4985-aee4-4cfd819fbd9b@kernel.org>
Date: Fri, 29 May 2026 07:31:27 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: remove dio related target file to respect
 mount options that only affecst new inodes
To: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
References: <20260528111659.87113-1-wqu@suse.com>
Content-Language: en-US
Reply-To: asj@kernel.org
In-Reply-To: <20260528111659.87113-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


In the patch title s/affecst/affect/g

Reviewed-by: Anand Jain <asj@kernel.org>

