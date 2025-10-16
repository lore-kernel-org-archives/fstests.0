Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081C2E0917
	for <fstests@vger.kernel.org>; Thu, 16 Oct 2025 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760658868; cv=none; b=lmVCP/q7VKJZz2+TxnNH/Rd2FZ0yNa0eTJx32UOonlGDHYZXvH9QYppLHc/uEtOUYnYa9mkwDyioR3rMO6k+pPr/GEzglZXZavCH8vPW3jTDo+Xq4CzPW7cOHNFjQkhSwWI/9tkdtuoHoAxHsVSBFWYSa0RtqN/E2MmjiWC6DnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760658868; c=relaxed/simple;
	bh=aK0HIlz8QpmZ8viy5ttoIR/Sw7DFRXGwB1wihf4h2uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAGlJ9hHFx5Fbl+3K2FdFx/qy39OyAjxzXiON9FTzEsbZkCYdS60L2FeLnqT9g+vt5qzaFtQDSsmillhFKt081NvZ7DOUkJKh/LrSvgzHViO3qWJ1taw8pHm5rxzPlOgnFlG/s3Y40nphSd8jdLf1yfMXQYPa7EivC4dLGiUFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFpPaydY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFpPaydY"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-793021f348fso1306773b3a.1
        for <fstests@vger.kernel.org>; Thu, 16 Oct 2025 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760658866; x=1761263666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aK0HIlz8QpmZ8viy5ttoIR/Sw7DFRXGwB1wihf4h2uA=;
        b=SFpPaydYkmZo0RTqgPHQYaesHemd/H0GP21+nM6sMqFUw3+49833ouFtyPSNo/19Xp
         /ySvXuCbiI8HMa72dynXW5hLJtQ1+4NkSDvxmm9MiEnrdRl6nRyIphadSg2ci1SupXy9
         OsG2RdK3KEY8jFnkkWFuJPJekjIoCbGISPjRLg0Sn7fSNbOQEVgrEcgNhYa+pd/0yc9t
         As0qL14huA/tfikUYIqcMn1CYBMdgi4SuqVe91uAr4NN6cD6gW1dCim3n34Q1ydiTF4g
         ZfP8BaqaF7ntUsamITQ5cQ5QgflIkYH02yXuFYS6oBK3cPqVBMpHcOXEimjPixWGYBz7
         qdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760658866; x=1761263666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aK0HIlz8QpmZ8viy5ttoIR/Sw7DFRXGwB1wihf4h2uA=;
        b=JcZ1kz/erPwn7KNOolPOVwHwrYOIKkx5GVbBC9c114avSX1ahbFl4oftv04KH88sIL
         eHCC8fJzLzFsLDE/em/mq1yNLlMW4TSY6nPoLKa5LBsFIizp/ytCADWVrID3TByjOtvz
         x+yd6MOuHTpqyawISfGZTwdywIPjKfPqrfkihXLfteHVbFipbUIVHIQo0EgoLiCRdCme
         rfk1X0vly1EP8gw7/3UAR9+pbqU+F44Fz+D5KXDIgeAVAvj6Toq+SJFmt95d/ZCE06tB
         1UYwqfsRLZxchtpiMNJ9MPa49fHUrl/PH1N6l26J8YqRoUE/hAWXeKzv4CcuucU7LWws
         Ip4A==
X-Forwarded-Encrypted: i=1; AJvYcCXBpJa/k96OhHW0Iccj9DbkCU4IV19bbLZaWLKdkBJ2CHVuBfCnMTXu2VwJhg+uycAXR7M3lrZn@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGW7kE/dIBmCUu72h8N3bDUDmMQ1/EQp87W0t9b8xwfvtgxDo
	IbebZiyxfw8s/PwPeCa7U988ErJegUfPtnrrEJsWW4LdXMEGawAn3o6m
X-Gm-Gg: ASbGnctJ/nIBnIBMZUzf2aZ1rOI6dCqlpjCyLn8U6Anu7/Hal6aK8qiiuJSGG+6gGjH
	Xw0HUHax7onN4YHGyg1l6zXUftGhfOBHMyeZ37HeALD0GQN3T6SD5JOsWRAY7r7gEbZklJ/R8/W
	FtZHMLFmTfaid0fDKNbtJjLtA/IrXO/MIFUq41ixLQZmepvj0ElAoW2hsF01s5SdQakv0FPLhnf
	h9/muY45DhWPZe41VllBl9sdpAtNxSekVXLyrvVJ9nIibIskRf/OHBetvQqZWPGr5AC8Q9AkWff
	vn6wGz6jOsMBVx+s6oggHl2bhL8nVbe0/diujwSDwYnvGjh3OSNsEXpPXUf0meOHMx9rycmOoaM
	q8j+OPhuk9v/V40qxp8jnVPDU/h1Y+tuwzWJRWhN/soX5/KJeE72EBPtOzXP292MMQ/xOHP6kKH
	3mL1L/l40iVXi+azGkyxgZBAxSyEDL0SX2a4cm/ZO4Hw0bPKWnHo+gd7VD6fXM5lji6k2p933N+
	p8=
X-Google-Smtp-Source: AGHT+IEQTO2Rn6Zn2mjzgAtb5MC9kioqoXxy+wCCJOa0aqfiGZuVMbJgx4ckvtvqbeTnmHskZ53hzg==
X-Received: by 2002:a05:6a20:42a3:b0:2fb:add5:5570 with SMTP id adf61e73a8af0-334a8606ff6mr2179365637.33.1760658866309;
        Thu, 16 Oct 2025 16:54:26 -0700 (PDT)
Received: from [192.168.50.211] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc18c96sm23614670b3a.37.2025.10.16.16.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 16:54:25 -0700 (PDT)
Message-ID: <96fa1a22-2df4-4047-9cc5-459e9846780c@gmail.com>
Date: Fri, 17 Oct 2025 07:54:21 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
 fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Carlos Maiolino <cmaiolino@redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251016152032.654284-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

looks good.

Reviewed-by: Anand Jain <asj@kernel.org>

