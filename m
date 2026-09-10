Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998FE3264EA;
	Thu, 10 Sep 2026 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034237; cv=none; b=sdDvmnf0OsD5YVIpsm/8IuKjcGY2pqnkGeWH/zIENx4w8bnPBNG0PBMQRZO/Pr7U6EsRi7rBVYEqJaXLdSRCqTQVxLoqdUSAixWh9kia0hBlSgjn8OZ/BhrLQvP0T+P3e8m1JHZIXCJ9F7BvGnWNUKxvXYtvteOMziMYGsSCpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034237; c=relaxed/simple;
	bh=cfT1bqOGI5tYMQqrLQps44QKfR8kbu992cGPNkGKF+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXUkZsml36ig+mWPPaNW5+8pmQar3GkK1nrQjUWyvd5ZRAUR292UTwxkWJTXdHSgmZRIual6o2Lvy8Sy77soPFOgEJ/DzsnvOcM+23E0sUF/cWnpmxOEtqecNX9PQ4SAPTYBBLv+9P4hngk4BvqnHPYUzkrJ2F+p1aqFoqBmYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lRLNwx7B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lRLNwx7B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cfT1bqOGI5tYMQqrLQps44QKfR8kbu992cGPNkGKF+k=; b=lRLNwx7BeExyjOsmv2VEuk/aFH
	Y6Q6miIeqN0kKUrQM7pd1ZBn0/RDzTACNW1d3DTS/IN9JrXjVk8ROkioZMI7FCaGWjZ24nb10ojWT
	U6duR3lD5eVXjNcpVv+Y/PNdm3Qrm00ke1SLp+62K8RDSSZcR15orfUJvgoOCRyg/HvuI/1RKg+Up
	8pLBiU+BetvVjb+qR5u9kDEzUshYmDxL4nEDSv/jHi+MYscXP4Kr9ss/L4vTGSJ1CVo98GvXqobTd
	5q1jdqDU+oDEu1rvrG4zGfyf7inS/uE7U24lxyD8hr+2sSRmwXkzGSIvpXBSYNO6nS5nvu0XlgWPu
	mo2cmpJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4bWq-0000000DxCw-441t;
	Thu, 10 Sep 2026 09:57:12 +0000
Date: Thu, 10 Sep 2026 02:57:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: zlang@redhat.com, fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de,
	vdubeyko@coreweave.com, linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Subject: Re: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
Message-ID: <aqJ--AqubS-CWiV-@infradead.org>
References: <20260910000449.747189-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910000449.747189-2-slava@dubeyko.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 09, 2026 at 05:04:50PM -0700, Viacheslav Dubeyko wrote:
> The dirhash_collide generates filenames from arbitrary random
> bytes (only '.' and '/' are filtered out), which are not valid
> UTF-8 in general. Catalog names on both classic HFS and HFS+ are
> Unicode. Feeding random bytes causes fsck to report "Illegal name"
> or catalog corruption that has nothing to do with directory
> hash-collision handling, which is what this test is actually meant
> to exercise.

If user file name creation manage to trigger fsck complaints, you need
to righten the input checks in the file systems first to fix this.

We can then find a programmatic way to deal with these rejects in
xfstests, as ext4/f2fs in case insensiive mode probably have the same
issue.

