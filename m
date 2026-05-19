Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6237FF40
	for <fstests@vger.kernel.org>; Tue, 19 May 2026 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171509; cv=none; b=QXwdxDjIoEfys/ckjF0EYQ2DKYHAdSNZ+AiQ7mPPtV3LD6eNZsO69mF78+7jpQLgd8Q2Qh5VYmwb72hMZjGhQQqqM01fc6Ox0rZs1WBAMDBpiMHgBfIIcmSv9XEG4y306lFOG5QwRJGwQ4oYdSNFm9wE5xqfX81yBaANjM4hudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171509; c=relaxed/simple;
	bh=P40yBmSFg8vv4hsr/oFplKZ8V4wmkdemPNXjCPuU8VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kIzEMbuD53SfLew27C+yFpXA5L8BcCPK7RWc35Rpe6DzkNGeEhsJvTIR1WiV2KH7LKfPRmEOdTn2CncdOf2/i8eZyzO8yVZNSPJz+zgk5MkAnoYeSrpT01NwRiU/4GSsNGC5c5m5Bfz0zkfYo9cJ/JO5LEsbQkdIeFI/ZpR6OCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao+N2LYR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao+N2LYR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83d31ac4017so1386890b3a.3
        for <fstests@vger.kernel.org>; Mon, 18 May 2026 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171508; x=1779776308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P40yBmSFg8vv4hsr/oFplKZ8V4wmkdemPNXjCPuU8VI=;
        b=ao+N2LYRoVP4U/dIrbjKvlnbwMbiuCQP+GLyKhosa00aUx4QYUTUN9eVdPhPCUxTlg
         8mpADQyckI41BwaR3PsoNKB6bcskBODN3xCk8TFuMIdexmwkTgvGmYKRqnm3SZw2ONmK
         2mgbVxq/M/dzntVh7ak8+yoFkGpZs59CTgmesf1vLLXYtzg4/63/gamK1PgcAcK9gdZE
         uWaI8TIOM4kJLBVAovg5NnTTg3AsvRWAys7HtOORnqfNnSLqsifViUfDkyINLmdLIQ+h
         /LYXF6Xi5ey67LUq+kLjcJ84NwWfhGPU33S0QYsyHZ0c/UgVN8rQsWne4qJTxMs0uumG
         v5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171508; x=1779776308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P40yBmSFg8vv4hsr/oFplKZ8V4wmkdemPNXjCPuU8VI=;
        b=PS5lGbFDF5Z1YX8bkWtJ5Fhq9aOkOU7F/Od3bJHonndsyJ8dw2pX1Weoh0oHxZZuPh
         JHeY+wENwt7bF+n6A7gNBqZ9ak/XEzfhyM/hXHn75Gu75QUt6i77lMloroXPrjyhmEKi
         yupSlefv8ckBCWPGRhFLEmG1X8mDLgreSTxoMCkY2Z6iDMM6XdIyahxDOgGnvvNs4kpz
         WRMoIi0nt+ztBy/j2ZVhg62SU3f6C61JdNeYh9OAmlLO/V8rAxDAaM79oRonYNu/ZrFH
         PZJ41n9D7OvrSED9nCDrc32ETdfNE39SY6x0Yy8GohqnV4aYeZcWaTOhM724l57CbiGG
         7jag==
X-Forwarded-Encrypted: i=1; AFNElJ+VhC3ZDnXTYEzjVH6i9MKlHohFp3v5t68amGfh7CoaFaxJzlqrund+/6Q9pnz/uc88dVdWx9Ub@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+ET3VBB2/TqFfuu9OCUCBF/Ti/fz4v6appjvQRnJKu4cyRgD
	M+7x+xeTIGXgaA4SZSq+1ZMkfuS0x87b2hTDf7vmIiRW02f9LPaTcbjn
X-Gm-Gg: Acq92OGhPb9wEHJ6O0A+PGLro+ZtW3Z2rqCiJUeB4BuV2f1yhAnu0U7NBZSIeH1GFAW
	cSRN/5Ed16zArGTC/kaLBxhlfr2BPNCix080qfILBjf3VbMv1L73rn/rCfhDmBHwuvUkbG2RVqL
	kvYBM5vn2H4vrTQGV7GVy2SBsM8glE2DPeIXuDG8zayTWyKgbDhWvEhWnv0+ZI6FhxDeWl+dOb6
	VS/wF5z2Ucu8NGczuM0/l5N+y5H5ry20eeXLwGPUq/Icp7Vr0nNZRlcTyLa1yNAR6n3EN205G22
	PGCqkbHeEdq7Ipc4soQTMtDqVXwVSuw53Lc3A9W+7vepd8ETKzssRzxO6dPLxei4D9rkgTBQjk6
	7cr1XCDzXYpHAwD50AyH9D1AjMxWVN7mfTIJzsmXIqwLhgHQUBPC8Yj7Xmn5jHjiiJlLlQ28zpb
	pmy8/HuCXcG2K6UP8qbrsRtLk3vuk8+f0Fju4b2m/O
X-Received: by 2002:a05:6a00:3915:b0:81f:ac81:d597 with SMTP id d2e1a72fcca58-83f33a38df2mr17304957b3a.0.1779171507707;
        Mon, 18 May 2026 23:18:27 -0700 (PDT)
Received: from [10.203.107.185] ([129.126.14.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664712sm17004315b3a.12.2026.05.18.23.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 23:18:27 -0700 (PDT)
Message-ID: <bc32c185-b573-4ed8-bc15-f8fb402a2ff4@gmail.com>
Date: Tue, 19 May 2026 14:18:24 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: inline enable_quota helper in test 301
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1778632843.git.boris@bur.io>
 <3234af372b0f16511aa5856aa7a3a0ca28397fcb.1778632843.git.boris@bur.io>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <3234af372b0f16511aa5856aa7a3a0ca28397fcb.1778632843.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


looks good.

Reviewed-by: Anand Jain <asj@kernel.org>

Thanks.
