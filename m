Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA3155330
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541864; cv=none; b=GtRWDSM9DHr2RtapepUNU+SA1Xa0tS+gQZhEeWZt9lzEiURkF8aOzbplEk4D/VyITOgzN/RqDFYhdbWmD0Vwga3LmDjaJPwrQ58wNdsx8xk+iOQn/5BpQ23YUMNZHaiq4jJKA+p+RAEBY945LjFX0V67r+GLYgHhGZU1hd6MDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541864; c=relaxed/simple;
	bh=ydqLUl2u18QjE0ixxOc+iJ5SZOFm7qYau1+MhAgRt8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEihI6wghcDQUwNIRS+kcYHThDta2O/Ji8mfdnQGo5ilRvCVxCdmuiomON2IshTfzozLdkaepKPkHx8HAjlyac92TIlI/+HbmvkM/63l211caEBuF/X3IBDTqp3Wbzp2Ry+3ncMkwXkUI20DxVIJ33UGq6RcB2BxHP+oD/KE9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DEIMNbZ3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DEIMNbZ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KkOCKW5nfshYoiAteM9qg0kYHcmbYS1fr5PpBROde5s=; b=DEIMNbZ36n2NSNYr6GpqtqF+p3
	fxqFcymzhJZCSmK76ujQFN2FmvYln019/oqMyFfZc2CWDv0zYsteOklerj80ZJLKkAv7fAUhEyxsp
	Hrc+dvyVGXDBOZGCYZ1ECPK5Nl0h8l5COMcIkvIg+bhL/zcKuCvcniQ1GQ1uS/d5lgxYFAKt7q1Wg
	6Fc7k30ASyWg6auqPUoWYGP6/GNnVl4/WJCyRieWWvfprYKHuizzipko+5oYP/nMttNqOF0EaM2o2
	peTjGEn7Vlq91V2rGVAacIZDDkrpJowkLv5qdviZ72TE/AVs7R9jZAu9EOHBjdkDlZolvzjGNdT3e
	cSxnYp1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvWjv-0000000E5lr-04G8;
	Fri, 21 Mar 2025 07:24:23 +0000
Date: Fri, 21 Mar 2025 00:24:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v2] fstests: update missing gitignore entries
Message-ID: <Z90UJq9JN-Tos4f3@infradead.org>
References: <20250319-update-gitignore-v2-1-a77183931c15@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-update-gitignore-v2-1-a77183931c15@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 19, 2025 at 11:57:33AM +0100, Andrey Albershteyn wrote:
> Add autoconf backup files (file~).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
> Minor patch to update gitignore autoconf backup files.

> +/*~

Why would we ignore those files?  They are garbage that should be
removed.

