Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D800274659
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131691; cv=none; b=b7bnwaMW1Hnkfs3UEoEwGvpTHjuyYMsk7drfeMrL2cjND4rrjIY+whyNI8Peksi/oyfAgIvQ5/U5FZYX/ZxGoiP2LMDbH6GO1G2YeF8HCOkc1AwP72spB6jWq0XYzEDgtDwMPlIVcDnWQpBjdqrKnM4fkX5DOUS86YwcB14ZgRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131691; c=relaxed/simple;
	bh=J0o4GxRm7Cep0xgCCkEjYlyduM6eG96JlT+TvwmaX60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+pYmn4hKAqPXaigYbsDFl8ozOGKjVZMBbrmhwHX9JUjJ178/z5QSY5okB4oKkBMQ+aRmdeRBFxURSnwzXv0xf4Yv1BEhBcDpfB7c6FKeFEBCulSatoGgYG11jj6UM16Mn5441aYkGLIZE4Dcebk+6Q1qBJka9QSm2bDy3yFc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B46F468C7B; Thu,  5 Jun 2025 15:54:43 +0200 (CEST)
Date: Thu, 5 Jun 2025 15:54:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/740: add _require_scratch
Message-ID: <20250605135443.GA2669@lst.de>
References: <20250604131922.848228-1-hch@lst.de> <20250605135210.zrezswl6qgc62mmq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605135210.zrezswl6qgc62mmq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 05, 2025 at 09:52:10PM +0800, Zorro Lang wrote:
> > +_require_scratch
> 
> There's a "_require_scratch_nocheck" in this test case, but it's called
> after the "_require_block_device".

Yes.  But I looked at _require_scratch_nocheck and despite the name
it doesn't seem to imply _require_scratch.

