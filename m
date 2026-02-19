Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB834026B
	for <fstests@vger.kernel.org>; Thu, 19 Feb 2026 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512993; cv=none; b=EMES+/9Yt5Jl8oJVFpJ6faDeexystq2SvApidLQJVM4DyV5rSjJ9G/Ooit/PCMRblYgRE2JYk/F6AoS1SdOd9kdsJDUw8joX0em8S7s1d6be2k3voMEIGwhIh58AKAipeH8f3q/HqGQysmCcD8sI6o76PFM/x7Hs0DW1nDkvjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512993; c=relaxed/simple;
	bh=rjZffwu6hdynv2JN23UfzxtD0VnYAIJPc9irgjPZp38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGatThc7QZ11UfF2/8OAY5Iz9R7IsQPRirnNBZ9I23c9cKknVXl5gAakxL5Uk0+IXj31SARGcH7r30HC1Vmbq8Wc6nFf+Zt+tj4A7hYdRIKCMaDUL5yfyerJnixH3mkpp3vwUzwOL0ammdY0Dmyq3yzFWEnVfNUAAp6n8d3VVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cl5ttWaw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNo0xuE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl5ttWaw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNo0xuE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771512990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KURr9oUxoL2KSC7hNk04GTMfJKM8TJ20DK+6mMaf68=;
	b=Cl5ttWawKGfe8MqTZxyaZ6BDkDR5OIUxhcoCmpG+Qa5mRgkzNpuBp+amfu4mYceykwMSqg
	mHjq507e27jVRhg3X6SDgeKchK9bN/Ll6dL7BTON5H/4uNRq/8khr/85yuqULIRZPJ5IbD
	cBftFkuroTZesCTemMIGLsLPfEBU0lY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-TZqlFzRuOe6gGjR5Sipmiw-1; Thu, 19 Feb 2026 09:56:28 -0500
X-MC-Unique: TZqlFzRuOe6gGjR5Sipmiw-1
X-Mimecast-MFC-AGG-ID: TZqlFzRuOe6gGjR5Sipmiw_1771512987
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48069a43217so9513065e9.1
        for <fstests@vger.kernel.org>; Thu, 19 Feb 2026 06:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771512987; x=1772117787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KURr9oUxoL2KSC7hNk04GTMfJKM8TJ20DK+6mMaf68=;
        b=GNo0xuE23lMBFHNDlxsQ++ET/1BKa+n8Dx2BPpvgOfxiUjBb3afpgRYUlFpWBW1hU0
         WaO6+4TahQHUKsba/XmJnXnJfYZ/i8trYKubCZEd4tGUuL4JgqOeRRio4vOwlD0eszt+
         4MtO/ebenZYp/amCiSnmjdvM10t9qnfLlYMb3DPp2wSXMZ3m2gDBsV3oKxH/Ri2bXAh/
         ewulCAjn2xx+DnExqoJmga2D4kdlxIkcQHwCEntacM+HQDIF8J0lBO+dpczekGlFho3p
         xPwZAkWmz9ll5HcQqRNAMrwKxNRPXY9tVYV0+ixnnBaDnWT5hgeS4zc59P+kdHVVE5RG
         yDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512987; x=1772117787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KURr9oUxoL2KSC7hNk04GTMfJKM8TJ20DK+6mMaf68=;
        b=vdNT7U6v4KYSifoJqpcuKLz4YG5j0HMPQhxz2S/xpH6bGLwXK4PisFqy5RM0P+EmnY
         eiROUuyMABuO8oTsgVilvThLlCshuFxGrePUW3Ns095BZ39yxyM11/ze0+GO3X/Qni/h
         UHmBg64AklywCyT00JuS/Ur3ybxF8CFst7qD9NgyoUMRKlXkkal0TUmy3dZWdkpbNCIx
         2h3cVoMDR+q/9C448mFoj96VZilnUr2mgCrBKEtPDffORHPGTmhTcWpY+fDWye2p+Sli
         aRMcTNFyd/JZlUImn1X6io1uuUZPtSXY3e5p9YE3TQESN7hMYQi865oVT5WpXwf+plCv
         Bw9w==
X-Forwarded-Encrypted: i=1; AJvYcCXw0ZRsyb9xCkNMgzUHEWMVE2UbHERDWL+JT0KL9Q1d+ZVY2b66d1Tky8IleSyKdL9Utx/Ld2wP@vger.kernel.org
X-Gm-Message-State: AOJu0YymQxcLzSz7akYi8istR5DEIyr3yHFdbgbmyB7bWT/2VHXrlyaz
	DV9CxX3KE1aAMQw5T8kvpI+0yCxU+Lt0jca8LgAurEljfcW2sMI5sorM60TDszD5Bqy0BDxmbK0
	5YNretIcyL2+D/dbsqw7m55YpuwZwR0QP3HdMx6HX6/h5jB9sZAysHtWamg==
X-Gm-Gg: AZuq6aKtTLMnVRP0/xUewDRI5Ah2AHyyQa/gya2a9pLyRIhSuC0yuPlsThN7vlncbX4
	o62sWR9KQ+MRgGcisFVNy24cHd7FULwABZNxxEdnQbwcPiwtrl7D1OSZwC2f98qwGrAbdMq4rOm
	rKoGA0kjPtdKhjIlDs1h+LM4vUP5nbP2GGut+bnZcE3xA7GzAMDuyhC/nQ2i6kNsnGp0uz/FTfS
	JQNBzuLrV0MunjkqYumB6WG3yYfCt9JEWVthwKAG7jbwOrWNlYfGvgGqlP/LXGE61GraHGhyELl
	8wixzYydJ9UcnZUhpTmvTMPWNeF7AXkDGSsXHI/5jvXaMlLW7K1IxT+QSp8hTzA8yxrpcTNJ0Yg
	X6HSDfAIUeW0=
X-Received: by 2002:a05:600c:6814:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-48379bf4788mr307947955e9.34.1771512987371;
        Thu, 19 Feb 2026 06:56:27 -0800 (PST)
X-Received: by 2002:a05:600c:6814:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-48379bf4788mr307947515e9.34.1771512986883;
        Thu, 19 Feb 2026 06:56:26 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31ba9easm7852995e9.4.2026.02.19.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:56:26 -0800 (PST)
Date: Thu, 19 Feb 2026 15:56:25 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: "Nirjhar Roy (IBM)" <nirjhar@linux.ibm.com>, djwong@kernel.org, 
	hch@infradead.org, david@fromorbit.com, zlang@kernel.org, linux-xfs@vger.kernel.org, 
	fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com, 
	nirjhar.roy.lists@gmail.com, hsiangkao@linux.alibaba.com
Subject: Re: [PATCH v1 0/7] Add multi rtgroup grow and shrink tests
Message-ID: <7pxwnn2gkb7dx46fwzuaubpwcuxvzzy4z6lzivwytypzxfuskl@twake2shwvr2>
References: <20260219055737.769860-1-nirjhar@linux.ibm.com>
 <cover.1771425357.git.nirjhar.roy.lists@gmail.com>
 <aZcIEd9DY_bQGJ9L@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcIEd9DY_bQGJ9L@nidhogg.toxiclabs.cc>

On 2026-02-19 13:55:51, Carlos Maiolino wrote:
> On Thu, Feb 19, 2026 at 06:10:48AM +0000, Nirjhar Roy (IBM) wrote:
> > From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
> > 
> > This series adds several tests to validate the XFS realtime fs growth and
> > shrink functionality.
> > It begins with the introduction of some preconditions and helper
> > functions, then some tests that validate realtime group growth, followed
> > by realtime group shrink/removal tests and ends with a test that
> > validates both growth and shrink functionality together.
> > Individual patches have the details.
> 
> Please don't send new versions in reply to the old one, it just make
> hard to pull patches from the list. b4 usually doesn't handle it
> gracefully.

b4 has --no-parent argument for am/shazam to break the thread,
pretty handy in such cases :)

	--no-parent           Break thread at the msgid specified and ignore any parent messages

-- 
- Andrey

