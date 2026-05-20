Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9834D3B2
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265253; cv=none; b=N59aJ7R0TArggeRVZLbneWwSgJc4V7ntVEAO34wxNfkO02QQ+HgWcCpS/ufnZvkj4okBjedxdxApizCqGXYyp3T06kO3bfb1Q9Avln2xlVFt/Urvq4KErwehwKghKUZ2Q8ZvZUUlukB1QLPWJakT+kE5Y94prFzO1tjZsE/TsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265253; c=relaxed/simple;
	bh=luSfoqdswX0V+pcH849fJBXv0E7guSSiXRwJzBjLRo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IamySN86fnQjLOoS3WzBT0bDkeCfMDYSyTAbFH8Ml5DVueucfMArpYaC/p3z/ZvqdNIbF6wArSADx7i/MntHmas0SCjKg5mcP85VZASfWgYdwZXkXzTCjnWlKsy/Qo8zJHdi6NwVTTbh16C1+iyt0pbfcODdLtKZZ1xxrnd+dAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=elt+lsGs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="elt+lsGs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LEhRbfDY78iqQAtIjRxmla0Ggf0mDFJCFIrPVkrlI7c=; b=elt+lsGsBj4celB45DNaGIieq2
	4U3f5C1Rav3gK9LAfvddKaJ5f+fIcTmKboHS+nTusoXjxNwdZj3EU55WxpFJAQyL2EATZBp8VvnDD
	EmWFNFdFCL9xVhfeQzy4VNm90+fKC9pjUbIXLU/Y2yovPvxlwouk5ZcmyBHtGVkmbnS3wwT+m/1Gm
	bfKp8mMg3VYamVjFfilrWtCqG6J1e7JwjTlAFCdH9uJJCImqZCX5B1Tl3+yJmQGCFYIcIqolZzSy7
	2cZFHauxVS1D3bbHneid5mYkDr8bHmO4PQKV2M/ms4o9YWU6PwYhOT3Iu9fGDFrtZtMxlPg2gC6m+
	7KJGe1LQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPcAV-00000003wTD-2jz3;
	Wed, 20 May 2026 08:20:43 +0000
Date: Wed, 20 May 2026 01:20:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/2] align the "# FS QA Test" format
Message-ID: <ag1u28zXxrpkaCfG@infradead.org>
References: <20260520074954.1877984-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520074954.1877984-1-zlang@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 20, 2026 at 03:49:50PM +0800, Zorro Lang wrote:
> The intent of this patchset is straightforward, to reduce maintenance
> overhead by unifying the format of the '# FS QA Test' line. This also
> standardizes the output format of related maintenance tools.

Stupid question, but could we just kill the line?  It doesn't really
add much value, but causes all kinds of issues.

