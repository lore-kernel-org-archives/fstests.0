Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCA30C16A
	for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823615; cv=none; b=Fry8erKek7P4KKCnsrj7ELgdYqw2CmVcuQz7CQoGGr1d0AlUto8AUt7HBfC2l+xAfzsfLzRSuCLpOHEL2NjKIzAeDUPfDXyJBxfj2dG+1hu2S9/u0Wmf+HdHa5Q+5eirISR1Gt2AYnRtQGDn16RNe0tbARxFs2RB6ATA+t5RYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823615; c=relaxed/simple;
	bh=WAMRkCfr7H5QN6A4aQbcqsVChqM0nwv/H92TRsaVOlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JkDFRrQrq0212WEI5GUA1hKn22qUn30WiC65lnHwh3ADDeZ/JRiEPQ56oaHE83uZEKxh2ZW1gC1I3kXG4OiN64IV0cXC4MqjN0ajxjERFYn98Mka2i0ucwJI/Ms2HJOVXpXZjWEqnQKM0oKctoYMMSYc5920N4xMW1ivos4Qk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8JAGs+q; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8JAGs+q"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-354ba08cfd1so3686992eec.1
        for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791823612; x=1792428412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfiNe+XyA8zhOMOl60OM1lT0ru0Yw38SRDVvcZ2Pv9w=;
        b=g8JAGs+qkBzqRG/EKXX54kowehahV9aUOVgycQZzcxnutRdEgI9w3ybGXxbzreyupi
         TZtVJkIK5tD4ZfQAf5fdTG1XDPsZTTuVVho6csyfcqjGm1SOSosLPKScob5orxGPoJ6d
         khq0kt3mydVBT/ytcB6fB8z+4Kd6UIs7QWHrXkH5InXzt5CncE+7t0sKKcJRFqIcvmyJ
         /OmnoDP0BMr8nIjkizDSxEMWMr1/fdikDrQQFR5kWc8TGEQ+v6cCpcpDWe/TgdZaouIF
         ilsj2Mv3OA9NT2AabCHpGZiIZQPGgH/1pLizW67ecNhtc+QO5GwuiwDAqzsMkedN+pOC
         0+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823612; x=1792428412;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfiNe+XyA8zhOMOl60OM1lT0ru0Yw38SRDVvcZ2Pv9w=;
        b=mmJ3g7Wy3lOjRoeVEnZZH1qDBg1CsqlnaDEWsjsUalj0OF11NkCEA5IkTBfpz2Cb2U
         Asdz9kCjGFKPnoLFGGIZCYQaqtr0rKDwX4VOy7P9Je6ueinjy662vgqjqTveuD46fFb0
         fDT/Ev7L3UcYeL7bWi58lFAyUtiUad9h9iL6Z1ys7N5RV4w0+t6yUD28CNfEmc13Jvqi
         TDHMv62oTXDE5HfH1VQVT2sjwgH85xK7xxi/xi0OmgiuSDSbYGdh0YG4NJRmgz46/eQY
         roKVzWCBBWv9oEJFfi5PEv0Of4kpq5xkc8l6CTY5QcVzRnFcXmkW/sfZJB3QGJ6fQEZJ
         Ke0Q==
X-Forwarded-Encrypted: i=1; AKwUvBw7VM+TU8Xx+CIlMpRpnqHIjNQrp99dwRxANcvUHJtBiej9WDZ2gYrb2wbtAKfEW6KDLtZVltIO@vger.kernel.org
X-Gm-Message-State: AFq9FYKWUP2/Q8Ng1ur8/Sni7lPwGkRjIeDohBVGVg1DJ8+JEK6Ij3vE
	prvN9JSLIU0WelLWYAbmPx/s8V0OzK+wFpZsij+c+Q7fwb1iGzImPh+Y
X-Gm-Gg: AYBFou3uAJzRO2xQtIBrW0fFo8Vx/wO3slL/fynXaadS6CTMqK/OeDBWp4T49zR8JRM
	VB/TT+KM6PaM3HtyEASSS02J6awJHjZxMzEmZaiTeA5juf/bqzDXXSUPsAcNtLKR4XDnmEbszyL
	CaYQV7bXoahkkOZp3LklzTCaaMCYsPZmXJBtivm17BCD+m7yPjrxeqDKigzaq+QoY8gV5xBP4Ja
	8WU95lrpaRSN5e2jqYlEhVeQshipUt02iEy4svl/QDJ2jjbMgqk7GnuW4L9NoiCUHBYXn8q72sl
	uGkpvONigWYLS8gyFZGZSEmQD3L7hvaeg7Sl6wNSovZ6rQHe0q9QdLYhkybMOMYsx2KmeQSsSO4
	2bXmXRj9jp1ybaX2/+S6687nfUGiGjD75c9SQZ54hSSjp69LUeOvb86rbTLoqyxteTV0GUPP573
	/9hXM0P8Ilh7UPWMWytK6sXby7eGrdENEXohKfROevcfpiQS8x8+Vc7IjJKaii1qFp0KlbbhWJX
	fxTdEGcR7e5OCq0Xp5KbV6QdiNSfEfIUvkWI4HXTgb0/GnIG8P5Xz9IEeS07fd3OHGTd2RFMwQf
	wX/w
X-Received: by 2002:a05:7301:1603:b0:351:1e89:66ab with SMTP id 5a478bee46e88-3537e03cdcamr14286574eec.7.1791823611968;
        Mon, 12 Oct 2026 09:46:51 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:97af:5038:b049:4f32:e620? ([2406:7400:56:97af:5038:b049:4f32:e620])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm38195439eec.5.2026.10.12.09.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:46:51 -0700 (PDT)
Message-ID: <6fcc096d-c049-4a72-a33f-54aef6151a0e@gmail.com>
Date: Mon, 12 Oct 2026 22:16:47 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: test if btrfs control file rejects
 unknown ioctls
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20261011230716.16860-1-wqu@suse.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20261011230716.16860-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12-10-2026 04:37, Qu Wenruo wrote:
> This is a regression test for a recent bug fix, where unsupported ioctls
> are not properly rejected for btrfs control file (normally at
> "/dev/btrfs-control").
> 
> The test case itself is super simple, which doesn't even require test or
> scratch device, it just run the "btrfs_ioctl" program using
> "get_subvol_info" ioctl on "/dev/btrfs-control", which should fail as
> that ioctl only makes sense on a mounted btrfs, not the btrfs control
> file.
> 
> The error will be outputted to the golden output so that we can catch
> any unexpected success.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/359     | 26 ++++++++++++++++++++++++++

fails before the fix, passes after it on a local x86_64 Btrfs VM.

Tested-by: Dhruva Gole <goledhruva@gmail.com>
Reviewed-by: Dhruva Gole <goledhruva@gmail.com>

Regards,
Dhruva Gole
