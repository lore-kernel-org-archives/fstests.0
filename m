Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B16FC5
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738717234; cv=none; b=fsmiCXIAwYgXjRTCi0pQ6qiJTP+VMhDAXPQ2/6UaijcakMBWsE/y8TzOD2h2W9NFqghllBhYweDFUhV+AtmLt51Qyqa85XKrIDebop4BEgnwZI3tO9Tr40hALRMyCbe8f41Nmf9YqAVr/4YA0mQKshHH//kF4bhwmKhaH4LJzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738717234; c=relaxed/simple;
	bh=Y7FWLQT8UE98ees+K4x9ur8zHcMK9xZCLk0+kQYJ7QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMEqAIVa5m3jS2NCn1Vc4y7PMgpj//Eyu3WGQdbrIBx0sovxMeMffK5uvZszFajdYnfglRIIXesGM9+QdKbgF5/ZRXYChD/ylH3vATcDKX82h9AcGh2tafkRJ3HYXQDgbu9QjtT1iEpK3kU2uWVM3Ujmj4rItPoiwhEMYpWtono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hTujD7lm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hTujD7lm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so10541217a91.0
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 17:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738717232; x=1739322032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvpwC1Daks5VODIvN5vPWe1auzHRNpTS5gipILhdALM=;
        b=hTujD7lmTaz4MQdAJ3uv9TjFCICAYz3d1uZ6dZR1koAJ0YWXK3pqsjFEb0qNsveQ4k
         3JHshFUJJkzRxOLKAph+rPnAFXKTLqXvOMwQ3iZb3Gu8MvxnyVEwNrla6oYrzZdY1kMX
         knXvoJv+siJuJai4z3LlG5GfPPf0Kr6i+2iRixS7NvksgKexS5hImo1h2yXOpOyUL6kz
         9Gt/9XD1G5NmjhkJc0VwpQQyZfk/6Zv7iaUzf98xkq9eJaoU5uuHd7POgBJ7fH8HgjxG
         nQku4QL/Vyz0opfQymQLHivpz68pvEsZ32yuag6LqMODfhlfihLHG/EiyVx+EOyJe2h6
         x/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738717232; x=1739322032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvpwC1Daks5VODIvN5vPWe1auzHRNpTS5gipILhdALM=;
        b=WOMe2uxvoWCGs2FNA0i+Zu/Xrl+FPGrM4ftGKV/z9RdvxiZlzzSiV1UPp8+mD1chr8
         soNjRYAeTxKmMFHvWPNAxB1jvJCdfWVLVf9TNk7QPfLKCIIfW1R0VRUh8tIHbU227iHU
         mzRVBwWeWA/m6X6phbhjCEwjvg4b5vuYsgmTPGGCcPe6cADZbYRHgqsvz8v8RelyiLAb
         f1ZWHwfQfLRbdKNJGI4BZXkgJIEV8Z/990b/1JnMkaMdh6yV6gocp/jc6vL6e/iwb9e0
         YOu4H7tg+AR1wtVGAIrbpM5ZKEFfy03aH/znqfOePiPoH5m7SbKHztd1HCrhbql/7csc
         HS1w==
X-Forwarded-Encrypted: i=1; AJvYcCVBt/SDgRlHcAg2rGCGjeLpqvt6mi47mUTDPpJEC5HgNZlq6hPgkH/6YmyDSJJ+Klc+VePuG7Cj@vger.kernel.org
X-Gm-Message-State: AOJu0YxqgrwSUTuQulKaFsL6blGFchUGyWLlfkFV92qSgDfIIyxQTj8W
	tHtMFYFaEXsbt/XLGD6hoTIqKm3KUqh8t3vfnp2HmUy54LaE5IzGXAefbsqkXlI=
X-Gm-Gg: ASbGncsY863ApKjmEngwl5KnteJi8kAz2v5dIqugUc/nfyeGQMo2cgtqmXpWjhUKNm/
	9P4i4XWTUZgs/rysXzysr2X2JbZf4Opgy83I0zg4eq0XMTO+0pHRtankleobdBD9mSK9h26aDdX
	bu52E9McAbzxfQSANj/l8g4T5Ipab+vyhv1ZR90rTK8s0q6jjdgTLfIzt6fq1wjMxpVp2BcWrPG
	q2IxW0VDlDPq7i1wgf3KRae6Crl4jiIjXYgKaQ14Arr2iJdtr+2yAqBlKib6QpUVEOyfksIK32b
	DUWxuS5lq2uZ0mPZaIuZvrYilD0rlqIL7CsTw5Wfjw91SGo88fc/SIOf
X-Google-Smtp-Source: AGHT+IFIGo/kCWBEfTnAwLT5cid1CedbRRsD8RlxdQgQpqJ66i1r3YqPlaqWlzvZ0EZvEFEg7MxhYA==
X-Received: by 2002:a17:90b:3b88:b0:2ee:b8ac:73b0 with SMTP id 98e67ed59e1d1-2f9e0753dc6mr1421920a91.2.1738717232125;
        Tue, 04 Feb 2025 17:00:32 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1d8a791sm196539a91.28.2025.02.04.17.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:00:31 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTmG-0000000EjoN-3RRu;
	Wed, 05 Feb 2025 12:00:28 +1100
Date: Wed, 5 Feb 2025 12:00:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 32/34] common/config: add $here to FSSTRESS_PROG
Message-ID: <Z6K4LIkO9zlu19HM@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406595.546134.7063206926113803976.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406595.546134.7063206926113803976.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:30:39PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In general we're supposed to specify full paths to fstests binaries with
> $here so that subtests can change the current working directory without
> issues.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/config |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
