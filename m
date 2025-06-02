Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8B2C3242
	for <fstests@vger.kernel.org>; Mon,  2 Jun 2025 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748842968; cv=none; b=HyA2v7GheDvMpwwOw2GcfkH6aCp7cYggmPGVCfe3qIhG5K2CRI2yfqoQKDVP3SjTk6qSi0qwok8+6A8GdBXBHSCLW5UhdGzn920LqmlSvLfAjMVjTwIUB8+wC52maIb5/nLGkiaCOmlmZDYC6FhV8ljwYOxd3pyFHAAJumXpVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748842968; c=relaxed/simple;
	bh=tBdUA7s9NirFLOB026NXdOIykhv/vWHirGYfolwIPvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzfLEn/IPfbqYFnKC+lCahQURFgooBHD55MhJaTKP1JDTgyNY8N8eOpujzq64P9HR3+y7X9h8PWPITajO0Akfa4keW7IPfQiz1Px0a5baVyFnNMKE+R0X8fzOFPP43yfmQCqyaoRk0uOCORejv8iymMbW8h1JJjHuIYwVd58oTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m3xF/U5G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m3xF/U5G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AcnjBmWjjgd0sBdMzCVrBbacDO35Ccriat+wMsCR4HI=; b=m3xF/U5GdDITDbh65/gjlkp0gS
	3NNrqQXq9oUtLUKvuBguOEABA89b6USkSjMrvFIwIMZRSi7qzk/WgJD8VaoHNwZ+FeXQnwcipnXs9
	l/XCtCe4816Z4plzTeEp2Ti89GoKuw1r+S0Xrn7SELyOgyk4MJSadWPQlZYoScC1Dk1/tMuItQY8b
	WwMSvcVOCLlW3jgBsR8A91NuNUgqUsecHLApcvOUCNNLNIT4uWou32TLuNxELvDN16rumldJ42JnM
	9AOaSM22zDJPL5hGZ4SsNdK5YL6jksdroX25HuVCj2tg6jhD1VBhufDlKvdlssqbVd+w8weVY1UWm
	eyNogguw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxwd-00000006m5G-0SXL;
	Mon, 02 Jun 2025 05:42:47 +0000
Date: Sun, 1 Jun 2025 22:42:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"zlang@kernel.org" <zlang@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"Friendy.Su@sony.com" <Friendy.Su@sony.com>
Subject: Re: [PATCH v1 0/7] add test requirements
Message-ID: <aD0514qLBX-MSazZ@infradead.org>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <aDbs_Fr-8CVCxdxy@infradead.org>
 <PUZPR04MB63163EFBDDF33FFC83B863008166A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB63163EFBDDF33FFC83B863008166A@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 29, 2025 at 05:43:48AM +0000, Yuezhang.Mo@sony.com wrote:
> For filesystems that do not support the features(symlink, hardlink, access 
> permissions, etc), such as exfat, these tests will always fail and there is no 
> need to run them.

So this is for exfat?  What do the results look like with this patchset?

