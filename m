Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB382C237E
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246028; cv=none; b=sGruLsvoj6/1z3iWutuOJnQlATstNv6DQvU2q4AYfSuiVJWYgOjlfhzieE4c+pWU859rLQegG4rW8R+6y0HV3FWCM1lc8YTIFZ4TDETn1rJ0RxHrTQk6CTd+ECL0BxNBCMipnJ2T166/hMMDIikfz+ESDzF33uDK2/EnOngnEjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246028; c=relaxed/simple;
	bh=7RGFKd9AUw2ZuPRIq33p6vOYtsURdxAycgrSa2y9vjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsbjRG7P3uTRMJCxYqToyAJn3SOsahnnEAN08bQNkdEbcAnq02l3q/PhGMk8PoVowKb507GE/wRn9fv9zo93bDjfkY5E1DMCegrodKhtXcnBmX47JezpBfEI1omrSYw4aZNtwVViAZg9+mjC5vtyq2wawt+h/WooSoESMdBcGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v2sqQI2N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v2sqQI2N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=REecvo/1sa5fGVfHVTGqxVjhogG9koEJ0Db+67E9NOo=; b=v2sqQI2N+XX4LI4j6/ks3q6f2C
	qoAZxqAsNVtdIRpwixs7MdVQeJi7/hm9RUuOIItKXsN8d6snfWc8OQsYIhmVbD/NwweJXYA+iHbZr
	3EfDIHjz02G3+pGuEifrKoxg2uEC/v4HbuDay92ihK6whPqolhpLGv51lGQgs5G306x8xQNete2/8
	nN/8OMG6iLnUYg/vzY/9Y0nomPkktHLvEMH8pwYFp+bEd1EYd/gG4ZdvllXGDKYaNDhHkD+iduytU
	2yXDzBQLuPakj5yJx1sbBsVEB7onTW27smTTaiB4r28U/LAV3XTEGcEQ/5hPl0yfgggTWsq4zGRoW
	jLUlRVBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4YRL-0000000G5So-2GbW;
	Mon, 23 Mar 2026 06:07:03 +0000
Date: Sun, 22 Mar 2026 23:07:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Disha Goel <disgoel@linux.ibm.com>, fstests@vger.kernel.org,
	zlang@kernel.org
Subject: Re: [PATCH] generic/730: skip on ext4 when dax is enabled
Message-ID: <acDYh-Q4gQcR2xRg@infradead.org>
References: <20260318081812.47870-1-disgoel@linux.ibm.com>
 <20260320155644.yy4qz2ulujpppaj2@doltdoltdolt>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320155644.yy4qz2ulujpppaj2@doltdoltdolt>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 20, 2026 at 11:56:44PM +0800, Zorro Lang wrote:
> I think this case isn't a DAX related test case, even give it "-o dax=always",
> it won't test scsi_debug with that either. So why don't we simply skip the test
> if dax is detected in MOUNT_OPTIONS?
> 
>   _exclude_scratch_mount_option dax
> 
> Any thoughts on this?

Agreed to all of the above.

