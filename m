Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AD4A2F
	for <fstests@vger.kernel.org>; Thu, 21 Mar 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057011; cv=none; b=QfLQcSfYNa8hm9LOmTkaEvx+33PbbefAfcZ1GiBObYlyBzQK1Wbv8bZlU0dLnz2HtN0sgxoI22VFrz1KSvIiSNGJADmsN+jsibpUdlmf6lwC2oN+L0lkUQ0BPTOAvGZNMqxk1meD9kVwfqnYsbc9i/xObsL3mMHmmp6WES+9wOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057011; c=relaxed/simple;
	bh=vYIj2CYM7zys1mj32oo+VtQ7QCFMnlvBPnhTIQiMOf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndwVk5AY71PE0VfsJ3BtoEkxCSSEuyr6v/lqnrwFNpvvr9c3YUlPiHh7bvZReICtcfVXJ3LLgpduBM7kijy3WuJFB+QhkGPqzmsmw9acgYxqsi5RMwcGTTvhsBnCPx30fMb6DRubdunUly09ow6XvzfTmP83nW9YFfS4kKNbRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qyBnratB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyBnratB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s5dhft+OlY7eVjZESdNL2DQb2yQXh3pjtzxGMqpgdzw=; b=qyBnratB4TijtIhbLh4rJnMfSi
	dwEYdgRbl/K5LLseO3UMZEG77+Bs7QVc42otvtZildjH/3JlngsbCjXcswAGEkjkSaeDXmAXBQdi1
	lT7/ZOGrJs81inJL5ncJ6ML3sC80xyW2vhqkxi5yiyylBOJBfynFMbDzk/zOEAnTyNYQO3GqGXwW7
	E9cnIpUqdzAY0/phRxUUAlsgfCjr0B54EVKf3tQXtepukSdEZteV/SUfawJJwxv7iCUKWHG1I86Bk
	XaLfT6d6MtG5DDKyvY1wc5GzSCVUORwwzWeQTPUr/Op0ETsnWpVMMB+ms5XJBDz08/jYHSR2Dn6CI
	kI9x8gGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnQ5f-00000004kga-2gMu;
	Thu, 21 Mar 2024 21:36:47 +0000
Date: Thu, 21 Mar 2024 14:36:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, David Sterba <dsterba@suse.com>,
	fstests@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <Zfyob_7NV9Kbd9pU@infradead.org>
References: <cover.1710871719.git.dsterba@suse.com>
 <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
 <Zfn9DMR8UQQMiyiL@infradead.org>
 <20240320155824.GD14596@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320155824.GD14596@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 20, 2024 at 04:58:24PM +0100, David Sterba wrote:
> It is a bug in the test, it should have been xfs specific and never
> promoted to generic/ and not affect btrfs unless explained how
> in the first place.

Well, the concept that reflinks are reasonably fast and are not live
locked by ongoing I/O seems pretty natural.  But I guess we can't
just asusme quality of implementation everywhere, and do an opt-in
like _require_non_sucky_reflink.  Either way we need to document
the assumptions and not add a magic exclude for a single fs.

