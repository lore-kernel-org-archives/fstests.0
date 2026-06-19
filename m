Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851023064AE
	for <fstests@vger.kernel.org>; Fri, 19 Jun 2026 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844809; cv=none; b=bUwtZ5lLdexxGI/KUfWv5naFdzytIUBZ0g13XE4hXNbJZDXg4JTLV3qBKus3Q6smkFhWT1Kjn/kK902ceWvQNLpG8lNRyo1CX5cDnA4fnEtRrmHU62jH63oLj06p+Wc28LOQA8oGZLq1t7TcqtZxx/tk6AM1scMUc/U5cnwmV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844809; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+YCsAvtaPJZrp6MSos6j24tNM9f7HsrTnso/a/9SozbY9MyBBD73VC+/sMiymtgtr6k3asL4dP/9/vhvv27ENxb78E5Reus2HoK/5+NtlrBClUf1QharnffBAvMV3Tt3ZftL2huTa+9RkmBoVGxb6i5Yn+HVFeKStFd/VJkO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0ED9368AFE; Fri, 19 Jun 2026 06:53:26 +0200 (CEST)
Date: Fri, 19 Jun 2026 06:53:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Timber <dxdt@dev.snart.me>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/740: add --force option to mkfs.ntfs
Message-ID: <20260619045325.GB24829@lst.de>
References: <20260618192236.654082-1-dxdt@dev.snart.me> <20260618192236.654082-2-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618192236.654082-2-dxdt@dev.snart.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

