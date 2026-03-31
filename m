Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E43590A9
	for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989593; cv=none; b=MvUy/zfR7XYt+7/x+5eddp6cyW1MgvuBVnAKsiMg5tGdUwDaqLl2+Y5y25PvE8wZIw6iafTztJBgrfxoUMYGlwjh9UCSEkDVkXbs58OZSx1mZAGCjWEkVhFuLPTBj4jvKYxw4RIrHSkFchmHk5gPwRHNEFNf59XTT2yfQ/CMn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989593; c=relaxed/simple;
	bh=nKN5Q3bE47gLyVVSOtIOoSNhzjmrP/qfvzrVJtwlBEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOtMMs5gL7XyqmqQw+x4njI6OqIyX9R2thLffa2AjyUifO4ic7c1+NMtrw2dMHFtnZS1253SaxxuAoZXhpt2k4appj4OEDa7DMqjxfXo/Kn/11F1oU6h0A4kl6o43CfeaIbfurlEKAVYMzg/2B0nXHb6gtJUOx0cS7OQmxmooUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ML8G5jVw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHSJTNrP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ML8G5jVw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHSJTNrP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774989591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQCRyPp24y6G+kaXtWDfiexu44t7AhdGV8RncQdBurs=;
	b=ML8G5jVw1Ixu2q+VKmYRo3RGaqulejM739CyUzdv4IS2q/g57Xt4aqttx3GAYkP6CeexGS
	STLAdSF0UbSqV14G7vPwD647Dmasz9hwEoeQiDhAZOr2xGRR2R3drUzmCyF1+8n1dljl4k
	mKJZthtnUO05I3hMsIb8MUakDNvNpJg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-HVZeWVXeNAehUGCGEV3_qg-1; Tue, 31 Mar 2026 16:39:50 -0400
X-MC-Unique: HVZeWVXeNAehUGCGEV3_qg-1
X-Mimecast-MFC-AGG-ID: HVZeWVXeNAehUGCGEV3_qg_1774989589
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c741b950511so3218243a12.0
        for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774989589; x=1775594389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQCRyPp24y6G+kaXtWDfiexu44t7AhdGV8RncQdBurs=;
        b=dHSJTNrPOUdWfZZ92G4lc2hiSOsDs79decsqzin4GR/Je6D0iTjs1R9i9lr2u0IbZW
         ZZRvyje8oVwu8xp5r+KQlRRrmv4pjo0Ck7wuJKTzGcFU6JB1DNzhSMztY+vXKMuTAzP6
         gEgzR8nXfbKh9eqHt+s8xuC4H3YPoe52Tvrt8Y2jqYgFRCj62LUldKktubLyUMtkHOOB
         VFRNLkFynIIuUvjlU6YAC1atK7BTloHVIovoVFREC10lJ37sxeo9XKPapRXgxbLnWckf
         1FEerDjeBIV2DxXMpbiol/UWqDzsM4ZohlUMelQWo9GcToULKezd53JUWy8jca25YkFt
         cyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774989589; x=1775594389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQCRyPp24y6G+kaXtWDfiexu44t7AhdGV8RncQdBurs=;
        b=h0P8tUolGb9aI4IlUOumI/aBBhCwqstfOrU3Sg+nzOb1JHMmohTM4YOJzolzvB25hb
         1C+syQcrYQuq3Bkwdk/6snRj/Cr2WpStv9gKOrNCiYZWgBri9epmyFaXS6NOe46IJWrv
         0mgYgT36ZjNqDT7XYBJqBBE2cd2WRT6jefUGv3qO08yq0uXC1TIVLj1v/VvcRTaiI162
         ZQNIBIgLdQU4WLg7f1BH89DRctstMx9ILFUx5HU1PRIbkZ16XNaQwLZ+713cz9n83qWR
         kusizGhzZYGQ6sj0ADh+6exNEZE6v4fQQ0G3QFhLF7xWkrkMvl+Fo7oz6HD2U05pr7mw
         Lq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0WJ4xslXPPbTCNMTn1ViPhJ800KvqDlvHU+JO97HKw/F+bmCSHubzjAdOzYJmQ52kFZWl5Dmg@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYOjZ048QbKvrXaM7NzKvYRxxvu3Ee6OfjZMav6YykKeCD/Mc
	ltSIMNh5W4uCZvbgQxRCbmYcFL4fXOnLQhlIAwHb+oeq7tVKyp/dB0w84fpJF7dcuE9MGiYRrd8
	6eFTpdu9+tKwvORsa0UpO0aqRxPRWJUQLvQzk8YNFXAAoM1QJcvuRmnAYNyg=
X-Gm-Gg: ATEYQzxPZZtCn+izEO5HUfJfSZSAWkI3ip2JMABB69JbXZRCVll9yFmHQ/rA8CQgzzh
	X2VXaHtoAcl23s1TDYnUMGfuQ3t2CItcgQlPGkIx6JdbGHgnunPBai6ma7Hy1JO8xE1yuj8wf9X
	Fu9yJUCg7HqTF3dWUSWlpvVopiO/t0K8RDfJZ3tBh2dOe9Gzyt2uHItpfYva2rLMen+dFlxx5su
	WYM+Qy0VKbowCNDSOXbdHh6tyL7srnvkB5HqFo//0UczbJO4mwsQbORQzeAMz0cDbe1Kh3kTAvn
	BMkaMQSVJFnjdaS++/rTcmQQtVF1XmvreT6RwMuGTFQd4MIwaT62gry93vC7biLivmJs+fFnsUd
	+ODJFR2Vd8nI9v+ahPg==
X-Received: by 2002:a05:6a20:918c:b0:39b:e837:5565 with SMTP id adf61e73a8af0-39ef75347d3mr691501637.28.1774989588950;
        Tue, 31 Mar 2026 13:39:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:918c:b0:39b:e837:5565 with SMTP id adf61e73a8af0-39ef75347d3mr691461637.28.1774989588320;
        Tue, 31 Mar 2026 13:39:48 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916ba75esm9506628a12.6.2026.03.31.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:39:47 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:39:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Hans Holmberg <hans.holmberg@wdc.com>, zlang@kernel.org,
	fstests@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: test that zone_gc_low_space writes start gc
 for rw fses
Message-ID: <20260331203942.jvlahulg7x3zkjd6@doltdoltdolt>
References: <20260327123429.39330-1-hans.holmberg@wdc.com>
 <20260327123429.39330-3-hans.holmberg@wdc.com>
 <20260330053421.GC4876@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330053421.GC4876@lst.de>

On Mon, Mar 30, 2026 at 07:34:21AM +0200, Christoph Hellwig wrote:
> On Fri, Mar 27, 2026 at 01:34:29PM +0100, Hans Holmberg wrote:
> > Test that writes to the sysfs attribute zone_gc_low_space triggers
> > garbage collection for rw (but not ro) file systems.
> 
> .. and add common helpers for that.  I tend to split the helpers out
> into separate commit, but I'm not sure if Zorro cares all that much
> about it.

If a new case brings in a new helper, it doesn't matter to me if we separate
the helper into a standalone patch or just bundle it with the new case.
But if introduce a series of helpers, it makes more sense to split them out.

For this patch, I won't treat the "splitting" as a blocker. If the author
isn't keen on sending another patchset, I'm fine with the current version :)

Thanks,
Zorro

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> 

