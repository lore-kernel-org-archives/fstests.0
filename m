Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9A175A9D
	for <fstests@vger.kernel.org>; Tue, 23 Jun 2026 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225051; cv=none; b=I7b2Vghl7YfBJu0VujOz8/IRsn3Ei5hyDHuRFyNuf1qBSEnle4d5j6YyMjtZcy9/8MNrHrVc1Q1VitWkiyqs50A8anDGW+h78N1PqDBxkU490p5lnQf4BbqThtaeM59zEzZW44/nCeP01Wo9ft8q+rr3KaOqeM4NTNLYHcl+7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225051; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu+q4BHxyVsKMH0oBf8GahkciDvTAyVuFfFX9oUuyUBB3e1N9/pPSDq35OBjRcsiijIOneYqfAfN+0GMTdZYOTXwDnJMcFJ6Uwy1g311jl3MkGAlq9y1gIENC6xkaZrPawXMP4ymxoTQEC9uFocWLtBK2rgURx54os+RQjXT+1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BBA768C7B; Tue, 23 Jun 2026 16:30:46 +0200 (CEST)
Date: Tue, 23 Jun 2026 16:30:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] common: skip data write EIO survival tests on fatal
 configs
Message-ID: <20260623143045.GA12046@lst.de>
References: <20260623062616.1994466-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623062616.1994466-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

