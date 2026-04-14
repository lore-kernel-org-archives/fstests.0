Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3643386C0A
	for <fstests@vger.kernel.org>; Tue, 14 Apr 2026 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153424; cv=none; b=up7AjpdClJQnRjuxGtbzxIZaK0UuJkOpEQ6JgX/kPKQGqBuVpPznZxfp5b4qq2GnNqEWzeBE+CtkVfIJI+MfDQCd8Kd+Wz8zEnClEbRaSYrmkhQzK6orhcl8Tr7i3f7a+ErbLFhlaMn7yPzjNq8FleFt6XEgRpmqOjWQSCOSmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153424; c=relaxed/simple;
	bh=N3H0cc6z1dejTxykF/Qp17QOZHIkq2Xz3UobiqqkSrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S667O2wa5lBLLXA6SCyhygq+9LSYduXd7jxNxzGd2GO9XTASb5SdBXx1pVwQdiOwhJnc1V5XkbBYn2IOmgiq7pJ+RC2cSwBQGgYa+PgM4++3zowsUvbwVzz/dB3USGu/YPdJXGOCCwFsSphwAgJgcRujrGRB9KbwC+KObOpkAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vbCctZ39; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vbCctZ39"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F3K7FttOvq8iXxufEoa5R9Agqd7XYyOWbVVEycm3fGI=; b=vbCctZ39PPVVgUPC8arCrwuVoB
	T+V1r5AQpU/xk0QwQB/NmGZC0H0W3YW1Mc1vEiivmGxacR3doZXOiZBxF2B3kUz4+acPZumNK6bXb
	D1cLfDAinsfGLBCCmzv38NcuB3xADnlCAThmAcrYKd5gamw2g0q2CGJ2iXJRBLHgQ3IUmPF4pnz3Y
	GqS0Uxuo5dlXDEM03O0aY4cmRvEFHQpMzqg5iuARTQYsW8y8a9sO4//exZDULxuTOet3FGuvrZkAR
	1rrdZir74g+oW0eJ5NJ3VA5TzW0jp9re6q6jBa6Iq6tEy0cZnDOxJyD8nsziRcLYWI8VezJAtl/qQ
	/Z1T3QrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYdq-0000000Gvhm-1Tus;
	Tue, 14 Apr 2026 07:57:02 +0000
Date: Tue, 14 Apr 2026 00:57:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, anand.jain@oracle.com,
	wqu@suse.com
Subject: Re: [PATCH] generic/050: handle f2fs as nojournal filesystem
Message-ID: <ad3zThMKaWZ65XE2@infradead.org>
References: <20260410131821.991005-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410131821.991005-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 10, 2026 at 01:18:20PM +0000, Jan Prusakowski wrote:
> F2FS uses a checkpoint mechanism for metadata consistency rather than a
> traditional journal. Roll-forward recovery is only needed if there are
> fsync'd files since the last checkpoint.
> 
> In this test case, files are created without fsync, so there is no
> roll-forward data to replay during mount.
> 
> Therefore, F2FS does not need to write to the device to recover, and
> successfully mounts on the read-only block device. Thus, it should be
> treated as nojournal in this case.

This looks ok, but I always wonder if we want an opt-in for this
"journaling" behavior and/or define it clear in common/.
