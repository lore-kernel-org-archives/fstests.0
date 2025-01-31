Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C3153BC1
	for <fstests@vger.kernel.org>; Fri, 31 Jan 2025 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738311053; cv=none; b=TJaQUO3RMGHoMC6yYcZt1NhiD1G+2fR0j8YjbgglsxDl4ZpN7U/SE2Xqk1dtuZjo8/WCEpSKkQILoVQW+cp9D20pGDTW9IeU1JDHVON5m4hA1FdZoW9Kf3QZpGxboZ4RAHZpQubWEQncVJwCuif1jqAlqocSqlqjGIbUvphoPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738311053; c=relaxed/simple;
	bh=MyyQu4iPjyZucrNEG3W/bvdx3X1s1nLacA7jXIRhcco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh5uLPcvQxfjlpCpxh8d53ngE1w1rxGzm1Z1s3Ws+nNUMwnfoiQ9TF7lorUHk0WlcAJbXtLYPZJHqqeXyQV1C8zyK2Ev/Dm4uUXmGE9NkLfy1GMqMw0YWTCjZ0ce3Qg0eX56VybLYe1hOB57+T6H6UsrAKIN8zqqnM0Spd4fRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HeJb6elc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HeJb6elc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s1CKXjJgIN539CauXi2NWcLfm/ngO6WZmEpQVkno5Lk=; b=HeJb6elcyAzFxqKUtbkSjNBCEf
	M8Pxylr+xE4g2PZ+ea2ej16mEGHi8dRXoSt96LyE43+sgMOKDnRGbHJxxupspcuPhlLtXDKCuGAD/
	AHvSv4D3B3PyfcIeOI4UPvLAzLMjkW3oTDoNAxfKPbtSB3VBSzOSNKe6a+tPU3FF0+HTbucFXShzP
	ZCP0KhZDqmeiGbmCq+5TUm6IIvJ8oKtUVABfSDiKSgDv4eCdARRYwyByzCs0Cgc79qEGtprSDUfU+
	Zzl/S+iigFkT/jcHrj5HB2Nqn+1NRWRTV4YidV5gsKoRLiPWoCLzCXvsaEGOq/J6tMUG36WhY9uqo
	iF+HdPsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm71-0000000AB6l-1eGE;
	Fri, 31 Jan 2025 08:10:51 +0000
Date: Fri, 31 Jan 2025 00:10:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] fix vfs/utils.c for big-endian systems
Message-ID: <Z5yFi6Ofr5_I75jL@infradead.org>
References: <fb7ad928-bbe9-4488-a6b7-a2786782bccd@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7ad928-bbe9-4488-a6b7-a2786782bccd@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 27, 2025 at 03:43:24PM -0600, Eric Sandeen wrote:
> generic/633 was failing with EINVAL on the fsxgetattr call on s390.
> Looks like this is due to a failure to properly endian swap the
> arguments to the syscall, so fix that, and the magic_etc compare
> in expected_dummy_vfs_caps_uid() as well while we're at it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Do we need to enable sparse builds for xfstests?  Or is this
goign to create too much churn?

