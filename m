Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908F3C343F
	for <fstests@vger.kernel.org>; Wed,  1 Jul 2026 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902208; cv=none; b=B2uXVtLNm0aesT2uTSOkP1czAoKYHrM5+a0DRIBgZ5C8EDv3p1B3Mtx8fg0NzwHcykxwaLHdGw20O7Yer+bPe4cfZACcZRTyDdl/dMCQI3NRj4OKkRMBFgsABudcTd5ATVjiBoHwXqCIzIZn4zMEVtTI816S7eQ30xgbjwTcpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902208; c=relaxed/simple;
	bh=eow0qLO+xRWLorCF0hn66EZCYM3v0buwbmfoj19LepM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BButcy2CTTUdA/ktzeW89ryrXxLtNpNztT+Kcfo7XCedLyJLa+WazmqsxsNB3bk33pI5Zi3Jr0ju4GkkFOm5x9+FrZfvU1UL/vjkrw+7r6HPpcLfRsRmHvc/vwTC7nKJAu+o+G0oo5sw5YYbxSZD0GoRDCWMc9hFPPS7BTeZhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4L8vJVU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rkGwlD8n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4L8vJVU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rkGwlD8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782902206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhJfmb7L1mpjtH4m4+FUT+rHS4lvtEnGLKvPvw3hHUM=;
	b=O4L8vJVUyCU0xrYJVs+s20n7tWAnuWNg28Cea3Gl3DnRpc3Gbv9JOpVB/vrvJE+MyRYLjj
	d61hBeS3EJNKyjUZj5yBvx7w00QomSnpMGkFuhIF9B81Jaz2cSS2JMkzWSnRB36GmJZ+/i
	2Kw/niWiKnA+Nu8cTSZKr/ik6A40hic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-IQqs3ZB8OYSMDPB82I3iPQ-1; Wed, 01 Jul 2026 06:36:44 -0400
X-MC-Unique: IQqs3ZB8OYSMDPB82I3iPQ-1
X-Mimecast-MFC-AGG-ID: IQqs3ZB8OYSMDPB82I3iPQ_1782902203
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493b21b1fe8so3897125e9.0
        for <fstests@vger.kernel.org>; Wed, 01 Jul 2026 03:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782902203; x=1783507003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LhJfmb7L1mpjtH4m4+FUT+rHS4lvtEnGLKvPvw3hHUM=;
        b=rkGwlD8nQG1iLfBzMrfioEFigZzJHdYnDh7ivMimzP3S6/sq5Sr58V7V7e/YXqQMQa
         WzZRdUPlfkYbN2CT/HGCgBtRoR+iUPqk4xpuOLCiVEuzXE07QumvdJiCK7ZoRC+25ggE
         4GZ9r2gAhwdNM0GZ3Q0b4S/FLCsIRWK5oP4ILE9gfQm6ZCu00IN5/FT1mM70N3/yQFTI
         xiNzRGYx3K9dFicwp8nYnsryFeNFHKvjNCP2AfYoAuoE0oXGyILCqpJU4sIu05d3FdIm
         yefNLUEUBiGlPVI5Jc95/n27cAN4hFgLx5wSesMSQOeFVg22+jlYUS0pKonlAfXHseQ1
         oGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782902203; x=1783507003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LhJfmb7L1mpjtH4m4+FUT+rHS4lvtEnGLKvPvw3hHUM=;
        b=oN2bEd+QYmIsSkG0ng59p68hq3bNOcft9Q+ZzktAclexFFTiK5Dlu+ys1/SuKCKKmL
         YdPgkma7dJaWPlfLt4/+kPBScLdfAXxahPR4FkDKfO9RAmFakSbma4bbxbuuu0kvO8tc
         EIGnyXBcNQr9o49uHRCk5kpJZjeF4J0ZvQJndkLeWuSGzZu44XrBRips3x7JcuVLxt/B
         Jr4C9n+qvUqHlAt1oXZgWeHXFBH/QjBpDg28E9QszM4ZbO19yX6Ll4K1ppoekIcRnhlC
         P/ifvzz4ElwDdHSXwufhZVmFCvek3oEJWYmxfeymNLRXqyqsgc9WOaGMOZd0evyvLEXQ
         p06Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hUAQYXVrclOR5fZ+4e2t2JrNGD9T6y09vZyFp8R2/bAhgUJZpfHsIwyuXOhkdzsBoG8H4LPlW@vger.kernel.org
X-Gm-Message-State: AOJu0YzgC2Bx9aQLHzeIiQ37TCYe2WfaqFRIrYiN+rQ3hBMU1ZSImLoV
	BiauP1LQA4sVfxs4EjeI1SkwYWEkIFqgtxwmPi9C526SGYYNmuQBXfWCWVePaUr4Avn5XbODuQm
	6exnJYw5eNQ4sh/P3tsOTclOpOmpPrrBFE7kOwSrMDCI7KvkDZ9V9qj0Gow==
X-Gm-Gg: AfdE7cnAecmT8vKAXGCbGbun0w+w0+gDI8QiT1LNj3EdhvoAqY0YkTBs2sdp5F8bTu/
	X2gmhTRCJ4yRLChfzWQEGOyhz2AHIdd0F3A/FyXWIeBQixlPu7qOXLFOg6YqbpWXKPdIp7xgCWQ
	NAnWm5x0In/FteFf/5B3QKR5u2wsq2zYjEw+xvcJYP7xmumYA60QgGViMdli9B/VpRAR//e/xO4
	VVtlwoKbgWzU3ZyQeXKI1I5CWK3jMOUHtyTW29V3SJ3IA8SfzariPn7S4iOWukakqJqFdWh/wiY
	28rimY1jEC+nO2Hrth1U8w7gEwNzDLoPWJ89+ulg0m+pred51oXo3YyrAPIlZ4ym4KWN3YTn7+n
	0U0bIWXSXcA7J5CK4m3Pl99PaSEgd7ruugPVA20NOdk5oZw==
X-Received: by 2002:a7b:ce84:0:b0:493:ba40:ef39 with SMTP id 5b1f17b1804b1-493c2b505d3mr11719565e9.15.1782902203415;
        Wed, 01 Jul 2026 03:36:43 -0700 (PDT)
X-Received: by 2002:a7b:ce84:0:b0:493:ba40:ef39 with SMTP id 5b1f17b1804b1-493c2b505d3mr11719165e9.15.1782902202965;
        Wed, 01 Jul 2026 03:36:42 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d19ba6sm14606062f8f.6.2026.07.01.03.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 03:36:42 -0700 (PDT)
Date: Wed, 1 Jul 2026 12:36:41 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, djwong@kernel.org, fstests@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: remove the v2log group
Message-ID: <akTto7Y-r2pJY_ID@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260618134528.237508-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618134528.237508-1-hch@lst.de>

On 2026-06-18 15:45:28, Christoph Hellwig wrote:
> v2log have been the default for more than a decade.  Merge all xfs log
> tests into the log group instead of splitting them up (with a lot of
> overlap).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>

-- 
- Andrey

