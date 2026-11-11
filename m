Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417996;
	b=yEQKlFLTWcbc7dNu7hJgZcUJe9I8egVI2ViXmHfrd0h2ZelEQvhAMwDOkYUA1VjsFLWh
	 wbt+btmumDtgTYanj5xqSBRguHi8/fz0fKx9jWIxwxOOHn+V9UkTvYbPjlT0MSciekkso
	 5/EXsmZENkt3fnH/EQiJfaP8Rtxw9fpvPwBigL07Ytt5m7gpuCt180dD51FUFqvdVN4ZW
	 QBYEXP8L/hq9OGdAG/PDH8/Cpjx8JAz40WDN8OIqoIfUOCPyYdXUif3A8T+hcLCQAbZQ4
	 ewcSkw3sM8BaX6Xct2UACxHUUwj66NQDly4210bGBoZzwQm2BThPvFkEBoPHFodAEfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417996;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=j4nTbY78D3br8044Tew8EwGa3Z/cUsmkNhBDZ02x3AFiqfH/1vfS7yvjmhBSyRRNwWtJ
	 ZIlK6yYuZU44w7jLMb4fKAP8m87mwwowPtw20PGDCF6i5I2WA35Frf6u43F0FmLT7MXcP
	 F2vlLSyWyCOqoOW9DEaM57E3k0wE7lBAIPqAdgERQ5oElZczoTzP9qCM3nnnzJGRDzzQz
	 ajUOH2ukSCoeZbSxp7J+JVWIYze5fSr51EcfuelFGuUUYCoj07cPp2TYpwh0hJqOH2Poh
	 btUOxZkq9AZhVdVc1x+siDkuUpaIiegbvPOgzKZzsNjAUz9vRqaaGzMr0C73r9fRarQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O6YAdNxr;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC8606A321
	for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 17:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDEC8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O6YAdNxr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=O6YAdNxr0GpRC7zX1aRyJcf+lE
	3p7Cya668ThEyQFCgOKP5z+1DJP9TBAl4OBqb021Qo8nvpYwBW8VDmV39wgog10N6xX1Qak6XFM62
	2j3BmYety5W3/mK/M07qqNKbup90k42ZmwDN0T5mV0a8kXuHDbKzs62zSeiZgEEHLPFvA1B+86P73
	6Ksgcd/nqm3AVmHEhDWLx84+eimxc5+1ZowaVRMYwgErtwBcYdPn8XkWbpBQx4VliqoMWXXxM5hR6
	lIz8tdmh/76pDiHex15haKUJAjRZYo27LtRUCBSnRvNBeQgq95fAHqyciIJq9VUs5NW6jVXZuHHY+
	8PUZfybw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRC5j-00000007Iai-0uzN;
	Wed, 11 Nov 2026 17:26:35 +0000
Date: Wed, 11 Nov 2026 09:26:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: Re: [PATCH] xfs/654: don't complain if the healthmon xfs_io already
 exited
Message-ID: <avSlS9Ivyeilm5Ds@infradead.org>
References: <20261111152024.163855-1-avinesh.kumar@suse.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111152024.163855-1-avinesh.kumar@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

