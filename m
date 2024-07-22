Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91432BE5E
	for <fstests@vger.kernel.org>; Mon, 22 Jul 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658072; cv=none; b=L05Um3wYY3AeJm4cvTcAtkqvoygHx39E5pG7z2lrLmbC0u9Y6dMRatBsxq/zuh8wGF82RNkNAZIylpmX/AzfbXkPjxao1o7l154bSJ+GhObZFEFtXDJ4+5600PDiTGouheU63KXpW1zeZ6at//BtQCc3geKKSdrzcHO8IHvNUMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658072; c=relaxed/simple;
	bh=41WPFfseiK2/vJ3aOz/gu8hVRXaDWwMZhSZxVhZSgnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQYvkC4jNmtbLPYvMjjw6jchK5+cPun0EMrGUzu+WFC/iC1KWiMYkDcq15CwYWT1/TNMFpIj0DuAVx8DnNYxyEyUm+jBHXsbxlQLTY6nXVV6lbv2xmQ26dhZzOMeGFl7jwH75pLWcerA5y04oLaGNhV4aAvxeTyVN+socpBRDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uag4a/Xb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uag4a/Xb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=41WPFfseiK2/vJ3aOz/gu8hVRXaDWwMZhSZxVhZSgnk=; b=Uag4a/XbVp5GzwCmpiQxJluvKM
	RJqjTPvd6JQEg9x90iTXqzLTUcVtB+AvaiDBItO4QSGPZjGdJOYQct6sv1EcAvZJ1Hz7uLa4WxuFL
	kEBju2iyspJqhzxYHos6wEfkEw7MGQpB4wJaj40iIBMpwwvBc17xnk3E7nIpbw4tNIsPfGpNIXXaK
	jiS3huDOxde7be977VGHk2wDewSyXu/didHBmQ5vK4iwVzlSqm+4FRAzxaGaMGTMaT7VFLPSdtcX+
	kTNyvmbHLNKmKon0SKXGYo5UfUrbZyhl/2RUOMbC8qHWWRk12Q0dxqaHVTeUt0R4eTh2/UUa3+BX5
	WRtEK/Ew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtuZ-00000009kxr-0GiB;
	Mon, 22 Jul 2024 14:21:11 +0000
Date: Mon, 22 Jul 2024 07:21:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yang Erkun <yangerkun@huawei.com>
Cc: zlang@kernel.org, fdmanana@suse.com, fstests@vger.kernel.org,
	linux-mm@kvack.org, hughd@google.com, akpm@linux-foundation.org
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
Message-ID: <Zp5q16N3m6qGilMu@infradead.org>
References: <20240720083538.2999155-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720083538.2999155-1-yangerkun@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 20, 2024 at 04:35:38PM +0800, Yang Erkun wrote:
> We use offset_readdir for tmpfs, and every we call rename, the offset
> for the parent dir will increase by 1. So for tmpfs we will always
> fail since the infinite readdir.

This honestly sounds like a bug in tmpfs, so maybe we should discuss
the behavior first?

If the changes goes in please write a comment documenting it in the
test case.

