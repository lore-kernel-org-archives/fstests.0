Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF91478E42
	for <fstests@vger.kernel.org>; Tue,  5 May 2026 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001167; cv=none; b=VGWipoGN7yj9fa92qRCVfZCa84/gdrbPFix8inyDA0zTNxe+RcTAZ1c0Zy81V8DOioPWZ9zrCtX1gIliVlr6Gqm+w1xhNWmWkz7vbBosH301OD44pG7AJjNdfYhgfQSAPAi726iciZIATLjwTl76ohlPz/KKJfAWPvOdcNr1Nx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001167; c=relaxed/simple;
	bh=a1z/NZlPGPz0LIcY87SAa6pI93bKQHmt3HQnMQShrCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/svcPKaP+eGlY3hRvlgv4uZe05ytvoOkkyHCMfFwrtgdPHfPR3LzetG/PVpVyVbUMu0VFxPNagcGrin3X8V99o1NqAqmbS8qBiW5Z40XsgvSrKapTD7MUxQ8HmjjwT6gz42E7hUj+Y65B9L49BgtLfpMAF333Fg8Hx07FRf9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ri19fZyk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=raR9RdK5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri19fZyk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="raR9RdK5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778001162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pP6CmEhCIsO2nQrf4te9scrBlc5AJw7miQRdY5uxiM=;
	b=Ri19fZykMUfVkTYn7QHd2XtrJLURGMQM3Th1uPCrdf7gmaEKUoRiISlguDZpbimWOVb8Cq
	rqEODQWtPGuTu8aoaH+K9wB0DikFwWzTt+WyCBv1K0h6DVvYo9yCX1j+NLpa+WPYXp0FZ9
	hrbQE5yW8HXAcVZvF9piW/4PWSoxXTk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-DLC4yaHnPeqqoq5Rwg_hKw-1; Tue, 05 May 2026 13:12:41 -0400
X-MC-Unique: DLC4yaHnPeqqoq5Rwg_hKw-1
X-Mimecast-MFC-AGG-ID: DLC4yaHnPeqqoq5Rwg_hKw_1778001160
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso44473465e9.2
        for <fstests@vger.kernel.org>; Tue, 05 May 2026 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778001160; x=1778605960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pP6CmEhCIsO2nQrf4te9scrBlc5AJw7miQRdY5uxiM=;
        b=raR9RdK5RRq/Vco2czCggKgqG0gJrna5BoGxisnuST098dGEsMQ8QVfpP6r3xkM0kA
         3VrKr8cZoFbjyF9Ln1sjMXVukEDY75Rp/wQ2g6mhMRQuK2fS9FVNLO5W4xrxgZTzcACo
         fFNP3yjZbnmMgEr3JwMsvrY5Mp2KZ55nNR/E1ZiR1vFyQ0FF4iGuJ3AvDzGKuxHGS/vd
         dfTYogxJMhCKepwaohecqhzo0E+/3mMfx2TItLW+4CHJadUD4FhM9W5XVMDL5rWAiJYQ
         KJukqoGjwVCA9AQvAgJadS9PPgPk0lJyM6whdUjBVcNiQCD3DRmcU981v09r/yR3TgPb
         PZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001160; x=1778605960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pP6CmEhCIsO2nQrf4te9scrBlc5AJw7miQRdY5uxiM=;
        b=ggeqGFesocvXujeIzESwCYFebnfjUpvORr/3qdkb3MtqMVLtzshkgk5yDrI6kHJA+d
         1MUP6pMijkBuDokwKDbljfPF25wFX2kXiSQ/Yl3Os5S/+BubA9Pob6q64piVIm+ozS9i
         9rnAT3zobesdeXQ7UlcXBKamavE9mx7vx+CODOfBSlpOJfEN16TV4MWrTZHrvXjdqcb7
         7mVx9ACnpvj0NwU2ipzgM0/M8PNIj4GFyxDSB537rvagiU4Ck1apn/0+ao4frw9gMSue
         0qw6oVJk14EZHpmQppTzBgVcqipBQMmyxivBwe21dD1tY/fMsq3ykjCwQU1B6VhIPE+x
         FG8A==
X-Gm-Message-State: AOJu0Yx6gJWl9Zhv7dUvEzVJPWNnXxhbUhWh3h+jnrT6twBFrcISWgr5
	ThZRBa5Ye8ZEAifBBkEGCdPvCRod82hIb3uWaG0tUl+b4XTGneu0qTdC+zK2URJrZeEXPZg6b1w
	mkWeomqs7SEji7qIkesAA+QaKpOpaQ7iIiiSqrueuO/Cvx91pYzpfJJpqWA==
X-Gm-Gg: AeBDieuRVFTCPcqiRTmwj4WCrptJ9S2IZqoZMI9t8UpqVIiDXmE+h7ZrA78pMVtv1IJ
	Pme9/Z03D8dxx9LbkPKwR8Nf9ivZbB0jnzkkyv7jiRaWblnE2QBupJmGysJQSlXR+H7QSkOYqk2
	zuSrJ2YDaRXPPhsOH/t9u7l/5B8G/4gtFQMU9a7fZKlhtf19qv+PjJNhXATwDBv6bZjyaS0uFQN
	2xVcFr8t5K36QXr877b6rg4WOgxj1dUAzGfMjQ/MjzcGTGBDrIZ+YK5Df8JBX3cnaQhVMF1Bnkl
	/CeCbpUZwVZGgFXFHzgiFTLF4+FGAMIcJUDhOsT7GZcnDbXCmr91WiHhjGH27efoIlnrZ2Z3xZa
	A09H7emBO8GgRokjwwLKC9A==
X-Received: by 2002:a05:600c:3548:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48e51e097a2mr2197575e9.1.1778001159920;
        Tue, 05 May 2026 10:12:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48e51e097a2mr2197135e9.1.1778001159336;
        Tue, 05 May 2026 10:12:39 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524831cdsm6543722f8f.5.2026.05.05.10.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:12:39 -0700 (PDT)
Date: Tue, 5 May 2026 19:12:38 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Donald Douwsma <ddouwsma@redhat.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: test xfsdump subtree restores
Message-ID: <q35bobvlsz66pdqqg5ie6q3xqqflw7kckwvk3hl42hqc5rtcn3@h7kaiwi5vl6l>
References: <20260326025443.1569874-1-ddouwsma@redhat.com>
 <20260326030012.1571545-1-ddouwsma@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326030012.1571545-1-ddouwsma@redhat.com>

On 2026-03-26 14:00:12, Donald Douwsma wrote:
> Regression test for cumulative restores where a directory has been
> renamed outside of the subtree being restored triggering the assert:
> 
>   xfsrestore: tree.c:1421: noref_elim_recurse: Assertion 'isrealpr' failed
> 
> Signed-off-by: Donald Douwsma <ddouwsma@redhat.com>

Looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>

-- 
- Andrey

