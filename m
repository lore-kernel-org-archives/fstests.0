Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BAE3CF5E
	for <fstests@vger.kernel.org>; Mon, 26 Aug 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683610; cv=none; b=swnHviGSp10jRJkRrqJlgpdpQtZiBrUJaVF2WNfBW4GvVPiTrSwSE9P87+nVa5XhC/pER4byL+UYqfIGMfbr+FDs0ZOaiUlmiavjhmVCSv6hZOi866Pn67idBPM+Wk55Vl4fe9dEpIlg/PxpDcpqoRmJG7vhxVelFNbDmqXLb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683610; c=relaxed/simple;
	bh=PTRRo3dzvxOaNSFDJFiuouiSsXgmh8iKTeY86UaaLzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8OQ9geX699ACeUr9J2L2f/HKZrSDjqn5vi5Bl4DxDi3yhCatDObgCTk5TmWcakPvub+SixyGmfDTxhErgfO+2hTqFmbayNc+vVmiHIrgpVwpsDKyc2QpDo4878N6G4ZYkeARFRysuo3EkVvGCv959R5BlJLhsQ5fx0j3z6LnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BNW4h0rG; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BNW4h0rG"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1df0a9281so273675985a.1
        for <fstests@vger.kernel.org>; Mon, 26 Aug 2024 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724683608; x=1725288408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=60roTMKnLbimtxG7vYaCnFjaEybHDOPOa/gCDo0rA3E=;
        b=BNW4h0rGd/bRTcmM//rHce5moOp3kqq6aj/cEDAruQ838jPkgKs6OrmcR4sNK2Kzvy
         rPNDfBw37RF5HeRB64VehjMmG05nX/154JpiylBux/nIh4SQzFMl4e3Qqo32GxeW3Dfm
         Bh+Atbj0IeKBTx8zCZWc6oUFmwjmjTUKI6pS6lNsaMtXLNrlJGDZfGnxmjHqsUsy6z3f
         6n6zIJMQDDNkBBN+CPU+4h1ID4s20t0VCjosNoVz6VhBK/bEyvVGBL3rNhNA+ZLTeJlL
         J22VZHr7Fg4M+9B2Lbbj3gURYun32oVntcV2C17HSfvqmfy/rF2ZsMw9WhQv6P5aO4cW
         DWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683608; x=1725288408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60roTMKnLbimtxG7vYaCnFjaEybHDOPOa/gCDo0rA3E=;
        b=Fn8FKnSsG2/vsEbILtFHNCicyCsZJxQ1eGHDz2Y8gaU4Rsv2J70D6w6CBI+4mIOcGr
         wi38dWE5ql8P8zD59mmAmFfoC8Ud/2UVVgMWW5yaGS//izOK03xu0Wpxx5qihEDdv7P0
         1jUl3L68ip3F0ng2mV3ZBFmH8Yj4+Zmk/YadzemHhFJuY32yGbR3pEeGYZ7K+lVZF2tq
         /U9wY04S9Bn2OFMOa4g6wWFXpC3aNZQ0/SaOsuZd6c3H7Nr3qI6X4ImYjSQRFsTp3bGk
         qIr05gSwfeCZcPx/uI3VTm98aO+AeXct8u28Q6+fTqHm0iFHdhyUB752yFIlKEX9Og8H
         C2Lw==
X-Gm-Message-State: AOJu0YxWChbyHbF3dLZyivDbrP3yDI1A7UyTR2hHyZIACkV62Wcu0MUw
	d3JCECKbdeOBCSN2LYZUFeUi3SsG9Rcpiv7cpzayvGkWSGFeQf+CqFwtbGp6QzU=
X-Google-Smtp-Source: AGHT+IGMYjCw+APmqru5dS4wTd9OzfykuTBi4S2Ig6gWIxrjbdQ0apShQOaiLdv3zAy46uekrtWwLg==
X-Received: by 2002:a05:620a:408f:b0:79e:ff64:39c4 with SMTP id af79cd13be357-7a6896d0f8bmr1285736085a.6.1724683608231;
        Mon, 26 Aug 2024 07:46:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f34233csm459903485a.35.2024.08.26.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:46:47 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:46:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/319: add git commit ID
Message-ID: <20240826144646.GE2393039@perftesting>
References: <fbcd0be9cf4a58086074157ea8ddd3a85eab6650.1724674946.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcd0be9cf4a58086074157ea8ddd3a85eab6650.1724674946.git.fdmanana@suse.com>

On Mon, Aug 26, 2024 at 01:22:57PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The kernel patch was merged into Linus' tree, so update the 'xxxxxxxxxxxx'
> stub with the respective git commit ID.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
