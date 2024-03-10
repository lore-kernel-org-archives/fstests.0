Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FC1CAB2
	for <fstests@vger.kernel.org>; Sun, 10 Mar 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710061808; cv=none; b=ZkxCdc5Cu8vBeZ/SG85o1Z5Fb5mZ0zjbB92xA4biLiSmeoU0exn3+QXQPitEMj6fHx3l2J7H+hfmZk/XtaJ1Of1QaknUe/jlTanBYGfEyMfHVCX2gxPPlaJnw5w4F02Rz0i+ke0SjubrOsTBetJSHdZWctP7eNHcfiOWhfYJcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710061808; c=relaxed/simple;
	bh=qn1NUrY+MMY1qBrn6D0W6bzzTcxrVYrBlZyGuoad3Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTZUjMmENFzecnfMsFAeeV4RNXdr8NaZGsNidmg5+MxJOylorD7rOYgVnIBL7xwnCdRwHDx0FtEIcYMaDAyapwUznPcrgwtkgc153HSsGV7D2QmiCjHzl0YLm8geBAZJm6AMiBpNztFDMQvwGtj+DJeqvgRLhI/Y9GW9cSIFfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoqklLxT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoqklLxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710061805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdzXYPbsGWJJCW+Kunyur8yTB5/njm53JJwx9B52/00=;
	b=AoqklLxTsNL0p7nBUhYOwg3NJb/MVO9p3HSpLXqbP+IMOsUi93ZfjpsCHfPXTGp3zFX6o9
	adwurMMGDtBrHRQ8mAFDoHA3pcp9fFad4LfuxcdtRJFTWpqYnPQLpnqgqOQavTQEZbKJzO
	Xbk1cmejPVQTE6+h7JTg351QJZrSztw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-7eyg713oN1K0i6NIKX1T1Q-1; Sun, 10 Mar 2024 05:10:01 -0400
X-MC-Unique: 7eyg713oN1K0i6NIKX1T1Q-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c23270d2b3so2841300b6e.2
        for <fstests@vger.kernel.org>; Sun, 10 Mar 2024 01:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710061800; x=1710666600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdzXYPbsGWJJCW+Kunyur8yTB5/njm53JJwx9B52/00=;
        b=FI/PN1amygtSKfXxpI4X/+nhOv1wj1e3MHFfxDQNFZEe9K+uiFU/zPr5nk/K87CumX
         bQVbi16zHOaNa+OoYNZcdzD3CA3AJPEzum5DQKSqHlBnaU5gvUlucrnxAFZeVzO/k0cQ
         i63MUCKWqKw9Hbbny+9mFhPR6arbjtuNPiwzIuDKTi4zKhfnNoFshUH0vp6b6rZbPeEG
         MZo3zUmMEuly0cBun6j7IQ/sppmLRRwm1zCf7tFKFZQi2lYkeygwMyG7LDiDyhw0dRM9
         91148wf+Mr0VgsxIfzsgaxsdGpfNAgmGat37OeWeRNMd8zi60epEqew96lu8F11dxSW7
         +KFA==
X-Gm-Message-State: AOJu0YyrhLOQ1O6xYsb4ZPNL1IhSPx/iHneCJRKLiwONntR9ON/ZFpF9
	tNI1I4wAhGTxzpY1JuvFu+ngXgDOSGjmEjEEO/W+m1cDQ76ICJDXYpw8ksRrvvBu0tTWkBUgYt5
	0a5myNPQzGj36YqScCU+3gEDKi/NS4+Ija3ouPVKnf+sX0dj+c0SFWnmH49wJ+EI=
X-Received: by 2002:a05:6808:319b:b0:3c2:2d80:96f7 with SMTP id cd27-20020a056808319b00b003c22d8096f7mr6408504oib.46.1710061799853;
        Sun, 10 Mar 2024 01:09:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY79kzOtwRScX+fzjcUlvUz1u42r647bOUPPyouENJ38hkr1OROvBddvqyBZknCUtq8A2Nfg==
X-Received: by 2002:a05:6808:319b:b0:3c2:2d80:96f7 with SMTP id cd27-20020a056808319b00b003c22d8096f7mr6408477oib.46.1710061799283;
        Sun, 10 Mar 2024 01:09:59 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902ced000b001d8aa88f59esm2367728plg.110.2024.03.10.01.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 01:09:58 -0800 (PST)
Date: Sun, 10 Mar 2024 17:09:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/392: stop checking st_blocks
Message-ID: <20240310090955.hrzmd2u5yo3gscbz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240226100319.280355-1-hch@lst.de>
 <20240226165206.GP6188@frogsfrogsfrogs>
 <20240308154316.GA13600@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308154316.GA13600@lst.de>

On Fri, Mar 08, 2024 at 04:43:16PM +0100, Christoph Hellwig wrote:
> Zorro, I noticed this didn't make it to the pending queue, can you
> pick it up?

Sure Christoph, sorry I did some rebase work locally, some patches got
changed, will re-create/push it later.

Thanks,
Zorro

> 

