Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1F2222D8
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678949; cv=none; b=HMY6XY41sgPg40xOeztjkHiERDCyifs85kArx4d6h59Xr8PkdLGCg1WrU4EKQE84wEzRNIWsED4IXKPzrc+aQvprS7RJ+Xbd2bwELFZCek/jxwFy9iBRh3zufgJPGaBOy+ofw2RCQXj5t/eoGwQBmhaI64tMMJEzdoB1RbvlvTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678949; c=relaxed/simple;
	bh=pTpRAUnwpcmHAR4xrfgOuF7nko5C+ighbRJnpfAV/Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAvrcRaP4uB4cumjGqzj8gzLswiKWktYPQ4shS7aIWb7Vs82MyrV/1ESBg9ysKHWSPw1N2M2NQ+Fqygbgpkw+qOCjFvjn3IYid8kN0RgcDSIP8sruZDh0/B5wv4ia5SxJRjRtAcUfmuTjVxdW11Dz5+z1oL/QYYp/rN3mSCoLQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NW+dVuAE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NW+dVuAE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CQRxyoizGSANMeYxtjza+3ua0IrFOFROhJA8SQPkU2g=; b=NW+dVuAEk+CvuZWhCRliSDALff
	5yqzyX7Aab0ynrhYDhisLsrrhTvHfRn/VhOe5wyOiEFrvG5WDIkyVxRkgzl1izYSOUQcckvtaLR3c
	YDGj3UPihYB21fWEw9vXvGGKSdrQxrMu/50C8EmFyZB1hDOFH3w2zwlEi+Uhe5BDWJgfCwDPSPQbg
	dyxduywYtBJPVnJYx2Q2vWD1XIUvJmFDnKKCwWB1QYA7bhNoSy9Wyp16NJwzxRWrciAPcb1fLVsVn
	ubOE+P8rCrs+YuRHxLavqCqtlvDqHeKed8zNoM6lBTbCJg6OqRtc2JTA0iMMA4ijVCQTP3yLg9UTB
	IZktIqAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1truFv-00000004tcm-1y3d;
	Tue, 11 Mar 2025 07:42:27 +0000
Date: Tue, 11 Mar 2025 00:42:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/rc: use getent when available
Message-ID: <Z8_pY1N6Pccsz5K3@infradead.org>
References: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 10, 2025 at 12:55:51PM -0500, Eric Sandeen wrote:
> Zorro noticed that on systems using nss-altfiles, some tests failed when
> trying to parse /etc/passwd directly. The "getent" command does the
> right thing in this case, so let's use it as long as it's available.

Are the reevant systyems where it does not exist?  It seems to come
with glibc and apparenly has for a long time.

