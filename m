Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B76329E7E
	for <fstests@vger.kernel.org>; Wed,  4 Mar 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637491; cv=none; b=C6+J7zh4xd6lcWpP/VUAOdOpLlr1YJpWMlDFqQJw1OGjaQyITzqiGWRKMp1vUOUn4eT6X7gx5X0KKxFtkzwmnpnxRvdUy0mlUtUYeK0fjFs2+/WzrhB+3EeW5mjK6FgD+OLb1cAtB94aZXJiSy9Xe3OlmVhimweSug0lapfGNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637491; c=relaxed/simple;
	bh=R2Y58A8d6w17HztjmtgRVKKs/bnaU3iN5P6Rgwuu4xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCKLDfkUSXSuLBxWlcopEm9UEDcfTlqzSnRR3f/mIwYshautel2+J+9acHEdoEE8+YpI7No4fRKHIENIWopCEvfVpO7OccogT8QsEmrlHkmGcuuvLZplTNcBklv3hJNo2W/4HkvKCDtpNk4AgUb9CGiRo3g7VMytVHN/H9cvH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzcmiylh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tIUexOSA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzcmiylh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tIUexOSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772637488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00JJFGOrDTHitcGq6XabMTYCTpc+QyAEd0XE4dW5bTU=;
	b=bzcmiylh5vZN9IJ7pg2t948pwse8teXoAd711iBG5ki/cwMQVtQUDjhu00oLmcKMu4yalj
	qCTmXleqIMsJot0/XWrwP52yp68EuUr3mawF/dTkbzn+Bwg9ewXGm7HKZ1/FoaHDxE8nIs
	lYn96fsA+ID4BF0e7WWewrEaH1VavT0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-be1kn8fZPLiUO00I31EH9g-1; Wed, 04 Mar 2026 10:18:07 -0500
X-MC-Unique: be1kn8fZPLiUO00I31EH9g-1
X-Mimecast-MFC-AGG-ID: be1kn8fZPLiUO00I31EH9g_1772637487
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6e7f45e2ddso25213537a12.1
        for <fstests@vger.kernel.org>; Wed, 04 Mar 2026 07:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772637486; x=1773242286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00JJFGOrDTHitcGq6XabMTYCTpc+QyAEd0XE4dW5bTU=;
        b=tIUexOSAX22IMkySE6z0KSaGIJ73f/doREc3++sJRrwqbd8NgrkCXqlJDikxfF55fk
         lM5DXnEILKtDGM8iQwuMbC9LA9uHVTShIo1r1eeisv+/4dKEMVac0yXfCSl3AA6SakDQ
         524GibHP42v0w+Wgmvp/2DOuEsVD1yo/Te7Whmq37uyBH4HxhOK7x0ss4LomfVg71VbA
         7iFxgoULEZwhIhB6/mAgQ36r+fC0/gbp9Tmc3ZUMQEtvxFPyryR/HntSXeNuO08e7wGC
         xtI3IB8wTy3qmRZX0TZBpE1JyrU9csB28+8xiQGyDnGBSOXenyLzdO99hTtp0M2vMupO
         jz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772637486; x=1773242286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00JJFGOrDTHitcGq6XabMTYCTpc+QyAEd0XE4dW5bTU=;
        b=Guj0M/Jvmt8EZCF5JaFanz1Shrx/L2OPuBX2cBrXAZxZ4VEujmxKvRhThygqHXqLFT
         O3qHQQdiq3HR1ckC9bwgFzR2vYoQTSt9PaDprN8WOjEx+26f6IQDxasUU1KKOaW7FhCJ
         0Fif0renQvZPyWWtuvnm0wI1o1+zQ4NElmptQQW0pRw1Z2iDdGVTnvT5VHXW3vlQjPNV
         RZlhKX+KEHdMvfe/YZCr0U6UhUcWt15Ukf2Q2cz3DSY6Anw6rhJeD0VgW/9I46B78p6j
         lY64vP7Qkd5WwivnJ41T5NYlpzlStNEcppSWJHc+WprYZExAW2U0YK4Z2lpHPTwc5c/q
         h4WA==
X-Forwarded-Encrypted: i=1; AJvYcCUyZwVv/bMi/8A5xF3YR9xMFKa+qRGJoXV9GcPVBofQ0vOh+LB8mr+7Uv8XudpRYDU9Zi8JJ2q/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25QDLon5/P6CX1AZi3QV9eyg2v23aJ4qg4CUgJxoD9NzBJzps
	6Xx9w1ZjQIHPtndgB/1OuZd+vUGYaqVBTYjfCnKvX2gm97VB6HkWS/noOkTcpdQw5m3vnnwMTsh
	ZJeTxXLMeGxflzxoGvHnswiynpS47RnOUVLZvbN8vwuXoJez9aWGruYzzZbU=
X-Gm-Gg: ATEYQzwyyYC+UHDxF7D+6M4+a5iYRdevY4kMXsa5lXybBJGgF4amfLtsbWJu0e+HAjX
	vW99FPFhHmLkUS8w9NRKsZL99qGCddCpoIEjU36K+StPT+P/RMPCIcgLLKslxj8PxdEUnrENhFZ
	7TQ6q/70vSIUNNMkfxs8rLpS6ZzKs2zx4UltqVPSikbKqGJaxeeelPXw9SlwdALyg0dRKJoNbXw
	apTdbwfdOnkCi4R2vRB2hHOl7ycRowz3J5nipR3BRdjqiL2JeW0uombXyyIggalPHIlHftspyKz
	BldRkU8trTFdKiWKi0KmGR0Sre3cfMEJggt1S7Xmppf4ftomg0Mh74yBND8+DtD8hXqTNHprE1A
	ETqD6LcwP2NDQPyCSZ/tw9TZRWcCfJgtd7ztTcD+ZqYQouJqienebOqm1tZmUjg==
X-Received: by 2002:a05:6a00:a206:b0:827:343a:a1ef with SMTP id d2e1a72fcca58-82972ca4112mr2176538b3a.52.1772637486539;
        Wed, 04 Mar 2026 07:18:06 -0800 (PST)
X-Received: by 2002:a05:6a00:a206:b0:827:343a:a1ef with SMTP id d2e1a72fcca58-82972ca4112mr2176500b3a.52.1772637485820;
        Wed, 04 Mar 2026 07:18:05 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff325esm23132141b3a.37.2026.03.04.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:18:05 -0800 (PST)
Date: Wed, 4 Mar 2026 23:18:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: fdmanana@kernel.org, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: test a directory fsync scenaro after replacing
 a subdir with a file
Message-ID: <20260304151800.6qkmxjsufen7sbq4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
 <7997e07a4f530bc52edd1b93e662907c4cd07377.1772561118.git.fdmanana@suse.com>
 <aaguMUK6TgYfwtZk@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaguMUK6TgYfwtZk@infradead.org>

On Wed, Mar 04, 2026 at 05:05:53AM -0800, Christoph Hellwig wrote:
> The subject is wrong, this is actually a generic test.

Yeah, thanks Christoph, I'll change it to "generic" when I merge it.

> 
> 

